Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D557AC47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 06:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSX2y-0004dL-D1; Wed, 24 Jan 2024 01:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rSX2w-0004cy-Ks
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 01:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rSX2t-000329-Nm
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 01:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706078852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Erg2DYAGXbbJnLgK4yt6LveyEc7Km7pacwKc6FRXP00=;
 b=U6dUC4V65OKYGaz30zbNoHkoOslcSG1nvbIXwEz+Gn8FcI5nlKnJjlN/be3xj6hQWknm7E
 y648+0aGLRujidBEqSiMhgTLNM4VNzCk4uKE/XjYezc0vPl+XADKg8v9FRe2mEE1RKjJsz
 BumbVICPbhQCjCMoDLI+uhguSGltSXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-5Wopvq8uNBOVdbXTn1I0vA-1; Wed, 24 Jan 2024 01:47:27 -0500
X-MC-Unique: 5Wopvq8uNBOVdbXTn1I0vA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76DB883B8E8;
 Wed, 24 Jan 2024 06:47:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 391AE492BC9;
 Wed, 24 Jan 2024 06:47:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DD9721E66C8; Wed, 24 Jan 2024 07:47:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 farosas@suse.de,  het.gala@nutanix.com
Subject: Re: [PATCH] migration: Plug memory leak on HMP migrate error path
In-Reply-To: <ZbBppQ_4sfyYgl4n@x1n> (Peter Xu's message of "Wed, 24 Jan 2024
 09:36:37 +0800")
References: <20240117140722.3979657-1-armbru@redhat.com>
 <CAFEAcA-tX=GPm1zDq5pnL+T_cbivKUQ1dZe_vQ0XAjvehWLdpQ@mail.gmail.com>
 <ZbBppQ_4sfyYgl4n@x1n>
Date: Wed, 24 Jan 2024 07:47:26 +0100
Message-ID: <87bk9bdy81.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Tue, Jan 23, 2024 at 04:33:43PM +0000, Peter Maydell wrote:
>> On Wed, 17 Jan 2024 at 19:49, Markus Armbruster <armbru@redhat.com> wrote:
>> >
>> > hmp_migrate() leaks @caps when qmp_migrate() fails.  Plug the leak
>> > with g_autoptr().
>> >
>> > Fixes: 967f2de5c9ec (migration: Implement MigrateChannelList to hmp migration flow.) v8.2.0-rc0
>> > Fixes: CID 1533124
>> 
>> Isn't this 1533125 ? 1533124 is a false positive in
>> the migrate_mode() function.

Yes.

> Indeed.. I fixed it in the staging branch (which will be in the final
> pull), thanks.
>
> https://gitlab.com/peterx/qemu/-/commit/74278c11b980429916116baf0f742357af51ebb4

Thanks for catching & fixing my typo!


