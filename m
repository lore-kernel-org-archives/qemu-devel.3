Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB3EC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPcn-0005aV-8F; Thu, 18 Jul 2024 07:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUPch-0005ZT-Dw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUPcf-0001WB-JP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721303311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=icKIEI64MFwGV3bUjp1WsC50h2diTVbf1sAdQCrjvbQ=;
 b=bx49vtTvwva2JI2WK1USqJlDEW32ImTFcmiI24a2b1HiUEqloahQ9dOHxyH2dTGa/GCDhK
 9QWy2kJ/yGtOAIryFuSfpqYKTsNcHnm8ic9Pb+2r6UcrqeSh10BFGBvip1y4x/a2ZZn41s
 s4FqgBJ78w5V/8eIF6JZ+Tc43+x2qsg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-YqDjiIb5MXKNEJXwdHo23Q-1; Thu,
 18 Jul 2024 07:48:30 -0400
X-MC-Unique: YqDjiIb5MXKNEJXwdHo23Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E3491955D4B; Thu, 18 Jul 2024 11:48:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A0901955D42; Thu, 18 Jul 2024 11:48:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF4B121E668F; Thu, 18 Jul 2024 13:48:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  pbonzini@redhat.com,
 eblake@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com
Subject: Re: [PATCH v9 2/7] block/export: add blk_by_export_id()
In-Reply-To: <20240626115350.405778-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 26 Jun 2024 14:53:45 +0300")
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-3-vsementsov@yandex-team.ru>
Date: Thu, 18 Jul 2024 13:48:25 +0200
Message-ID: <87ed7qc452.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

> We need it for further blockdev-replace functionality.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  block/export/export.c                       | 18 ++++++++++++++++++
>  include/sysemu/block-backend-global-state.h |  1 +
>  2 files changed, 19 insertions(+)
>
> diff --git a/block/export/export.c b/block/export/export.c
> index 6d51ae8ed7..57beae7982 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -355,3 +355,21 @@ BlockExportInfoList *qmp_query_block_exports(Error **errp)
>  
>      return head;
>  }
> +
> +BlockBackend *blk_by_export_id(const char *id, Error **errp)
> +{
> +    BlockExport *exp;
> +
> +    exp = blk_exp_find(id);
> +    if (exp == NULL) {
> +        error_setg(errp, "Export '%s' not found", id);
> +        return NULL;
> +    }
> +
> +    if (!exp->blk) {
> +        error_setg(errp, "Export '%s' is empty", id);

Can this happen?

> +        return NULL;
> +    }
> +
> +    return exp->blk;
> +}
> diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
> index ccb35546a1..410d0cc5c7 100644
> --- a/include/sysemu/block-backend-global-state.h
> +++ b/include/sysemu/block-backend-global-state.h
> @@ -74,6 +74,7 @@ void blk_detach_dev(BlockBackend *blk, DeviceState *dev);
>  DeviceState *blk_get_attached_dev(BlockBackend *blk);
>  BlockBackend *blk_by_dev(void *dev);
>  BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
> +BlockBackend *blk_by_export_id(const char *id, Error **errp);
>  void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
>  
>  void blk_activate(BlockBackend *blk, Error **errp);


