Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA34CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vRC-0007oh-Ev; Wed, 15 Oct 2025 02:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8vR9-0007oU-SS
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8vR1-00076F-DW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760511384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EL2fQXyYz/PHMzfkxUm6aM+y69WWu2uXMwRmlMlw8uc=;
 b=Tvb+T4OIwUu6240Cl0oL/C9gXPK0x37kGsOMiKWNZzsAIcv05nPiq/CLYP0dsGiziJ/1yA
 +ZljDyPdzKMEJ+2CYNjaadMcP4NI/1RqMhvJ1ZdNbrKP3+AUYDyvKECbLzbjrplcw9koBo
 uaHJF9Sli/E6U5LuUqO4eOoovmKS4lw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-65FlBshCMIafhtnr4-EM1Q-1; Wed,
 15 Oct 2025 02:56:20 -0400
X-MC-Unique: 65FlBshCMIafhtnr4-EM1Q-1
X-Mimecast-MFC-AGG-ID: 65FlBshCMIafhtnr4-EM1Q_1760511379
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98405195608D; Wed, 15 Oct 2025 06:56:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 176A219560AD; Wed, 15 Oct 2025 06:56:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9133F21E6A27; Wed, 15 Oct 2025 08:56:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  raphael@enfabrica.net,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru
Subject: Re: [PATCH v3 7/7] chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
In-Reply-To: <20251014152644.954762-8-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 14 Oct 2025 18:26:44 +0300")
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-8-vsementsov@yandex-team.ru>
Date: Wed, 15 Oct 2025 08:56:15 +0200
Message-ID: <87tt00irg0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> For further vhost-user-blk backend-transfer migration realization we
> want to give it (vhost-user-blk) a possibility (and responsibility) to
> decide when do connect.
>
> For incoming migration we'll need to postpone connect at least until
> early stage of migrate-incoming command, when we already know all
> migration parameters and can decide, are we going to do incoming
> backend-transfer (and get chardev fd from incoming stream), or we
> finally need to connect.
>
> With this patch, we only provide new macro, to define chardev property,
> later it will be used in vhost-user-blk instead of DEFINE_PROP_CHR.

There is no "later" in this series.

The new macro is called DEFINE_PROP_CHR_NO_CONNECT().

> Then, vhost-user-blk will call qemu_chr_connect() by hand when needed
> (for example through qemu_chr_fe_wait_connected(), which is already
> called in vhost_user_blk_realize_connect()).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Excuse my quick & ignorant questions...

I understand ChardevClass provides either methods init() and connect(),
or method open().

Is a ChardevClass providing open() usable with
DEFINE_PROP_CHR_NO_CONNECT()?

Is a ChardevClass providing init() and connect() usable with
DEFINE_PROP_CHR()?

Could the code do the right thing based on presence of open() vs. init()
and connect() instead of DEFINE_PROP_CHR()
vs. DEFINE_PROP_CHR_NO_CONNECT()?


