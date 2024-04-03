Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0185BCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 18:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs5Qx-00062O-Im; Wed, 03 Apr 2024 14:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rs5Qv-00062A-Fk
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rs5Qt-0007Zz-QN
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712169238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXyZxkpKqpvdZlX3yc1Z18/BEwxszH/y0reLaTPNXOg=;
 b=IUErR2/L3/m6IwQG9j0Z2ttKu+t6G0m3A0A2VXY37pKsoVs/6NaHA1K2alxXh4o+o+SggT
 KzT/DOYSGF0ZAMVmjlylNwnRhH4QXPLZMzNGIMP/spJhwiSSGsaRVGOM2cVtH0+k/pHQpT
 ABGbSkUpXLNN3TXFwOJKj/tHsBAdWtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-TyEa6Z5VM3WbA0cocdc4Rg-1; Wed, 03 Apr 2024 14:33:56 -0400
X-MC-Unique: TyEa6Z5VM3WbA0cocdc4Rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DEC685A5B9;
 Wed,  3 Apr 2024 18:33:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A5282024517;
 Wed,  3 Apr 2024 18:33:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 526E421E6811; Wed,  3 Apr 2024 20:33:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: berrange@redhat.com,  eblake@redhat.com,  eduardo@habkost.net,
 kraxel@redhat.com,  marcandre.lureau@redhat.com,  pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] input-linux: Add option to not grab a device upon
 guest startup
In-Reply-To: <20240403154539.10256-1-justinien.bouron@gmail.com> (Justinien
 Bouron's message of "Wed, 3 Apr 2024 08:45:39 -0700")
References: <87edbmk59j.fsf@pond.sub.org>
 <20240403154539.10256-1-justinien.bouron@gmail.com>
Date: Wed, 03 Apr 2024 20:33:50 +0200
Message-ID: <87zfuagusx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Justinien Bouron <justinien.bouron@gmail.com> writes:

>> Again, QAPI schema
>
> Pardon my ignorance, but are you writing this because there is a problem with
> the QAPI schema changes that I would need to fix and re-submit?
> Or is it just here to indicate that you've reviewed the change made to the
> schema?

The latter.

Reviewed-by: means I reviewed the entire patch, and approve it.

Acked-by: is weaker, and its meaning depends on context.  In this case,
it means I reviewed just the QAPI schema, and approve it.

Details (likely more than you ever wanted to know) at:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html


