Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D17EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 07:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkImS-0002PI-UZ; Wed, 13 Mar 2024 03:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkImQ-0002Os-Lc
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkImP-0004eU-DI
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710313920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FaVHQT7UIKduH5ya0KeqbaSzqzd5+iCB+0PQtYFKaXY=;
 b=D8vJEiIh2iowRmJdbpHSWNEhgfuTmNLQOq5CB3TPe+QVUHBc7BRHkUSJrtm2ZYEMiOEyVD
 gt40RPTxJDB+i+k/xr3XNpy01NsdXd08vQE9skegDSjyBc73h0KkzI6ZYrL20T688LWf6g
 S0dlyiDtbmXWybCWPQ+gdaRBvyqoYew=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-XHD-Sfj7O3SIxRUubsxzWg-1; Wed,
 13 Mar 2024 03:11:56 -0400
X-MC-Unique: XHD-Sfj7O3SIxRUubsxzWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E603CBDF62;
 Wed, 13 Mar 2024 07:11:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DCCE492BC6;
 Wed, 13 Mar 2024 07:11:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0571121E6A24; Wed, 13 Mar 2024 08:11:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
In-Reply-To: <ZfDTKkksgW-HdnkF@x1n> (Peter Xu's message of "Tue, 12 Mar 2024
 18:11:54 -0400")
References: <20240312120431.550054-1-clg@redhat.com>
 <20240312184106.GC389553@fedora>
 <1b9016a1-ad58-47ba-9dda-96095c1e59bc@redhat.com>
 <20240312213426.GA449817@fedora> <ZfDTKkksgW-HdnkF@x1n>
Date: Wed, 13 Mar 2024 08:11:55 +0100
Message-ID: <8734suip1g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Mar 12, 2024 at 05:34:26PM -0400, Stefan Hajnoczi wrote:
>> I understand now. I missed that returning from init_blk_migration_it()
>> did not abort iteration. Thank you!
>
> I queued it, thanks both!

Thanks for cleaning up the mess I made!


