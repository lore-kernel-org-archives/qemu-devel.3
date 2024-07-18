Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1127AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 10:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUOnS-0000fI-5o; Thu, 18 Jul 2024 06:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUOnQ-0000ZK-UR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUOnP-0003TJ-FB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721300134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CyG1Shf25B05px6KutuFhy/6kIx5Yb/Stz0KbvmQhLw=;
 b=QEicGUQOZrcYJI4jM675xhi3ixSnY8QDFnF3XaMQQjhb6tPuL9koK2P1uAKvTkTaDUakp9
 xCF65+9atT68SGTZz0IggTXIoJJS7ojERA7bG0L7KdEVV4Bg0AOjOo4U9/rVsp9xwq/yRh
 oKAMe4Hql8mMZnHxXZU/40KZLLb0LIA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-EtzDfluhOE6r72-dwyn3PQ-1; Thu,
 18 Jul 2024 06:55:31 -0400
X-MC-Unique: EtzDfluhOE6r72-dwyn3PQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2691955D42; Thu, 18 Jul 2024 10:55:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0A563000185; Thu, 18 Jul 2024 10:55:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 94E4E21E668F; Thu, 18 Jul 2024 12:55:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 devel@lists.libvirt.org,  hreitz@redhat.com,  kwolf@redhat.com,
 jsnow@redhat.com,  pkrempa@redhat.com,  f.ebner@proxmox.com
Subject: Re: [PATCH v2 3/7] qapi: block-job-change: make copy-mode parameter
 optional
In-Reply-To: <20240626110124.374336-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 26 Jun 2024 14:01:20 +0300")
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
 <20240626110124.374336-4-vsementsov@yandex-team.ru>
Date: Thu, 18 Jul 2024 12:55:26 +0200
Message-ID: <87plrbx941.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> We are going to add more parameters to change. We want to make possible
> to change only one or any subset of available options. So all the
> options should be optional.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  block/mirror.c       | 4 ++++
>  qapi/block-core.json | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/block/mirror.c b/block/mirror.c
> index 2816bb1042..60e8d83e4f 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1272,6 +1272,10 @@ static void mirror_change(BlockJob *job, JobChangeOptions *opts,
>  
>      GLOBAL_STATE_CODE();
>  
> +    if (!change_opts->has_copy_mode) {
> +        return;
> +    }
> +
>      if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
>          return;
>      }
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4ec5632596..660c7f4a48 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3071,11 +3071,12 @@
>  #
>  # @copy-mode: Switch to this copy mode.  Currently, only the switch
>  #     from 'background' to 'write-blocking' is implemented.
> +#     If absent, copy mode remains the same.  (optional since 9.1)
>  #
>  # Since: 8.2
>  ##
>  { 'struct': 'JobChangeOptionsMirror',
> -  'data': { 'copy-mode' : 'MirrorCopyMode' } }
> +  'data': { '*copy-mode' : 'MirrorCopyMode' } }
>  
>  ##
>  # @JobChangeOptions:

Acked-by: Markus Armbruster <armbru@redhat.com>


