Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858E5C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpk0v-00048w-HA; Fri, 31 Jul 2026 05:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1wpk0t-00048V-QD
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:58:47 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1wpk0s-0005dJ-1l
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:58:47 -0400
Received: from [192.168.106.196]
 (dynamic-077-002-060-183.77.2.pool.telefonica.de [77.2.60.183])
 by csgraf.de (Postfix) with ESMTPSA id 8F2BA60802CC;
 Fri, 31 Jul 2026 11:58:42 +0200 (CEST)
Message-ID: <96ad911f-6f07-4616-b911-617dde2f12de@csgraf.de>
Date: Fri, 31 Jul 2026 11:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] igvm: track memory regions
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: graf@amazon.com, qemu-devel@nongnu.org
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-3-anisinha@redhat.com>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20260730071254.80695-3-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 30.07.26 09:12, Ani Sinha wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>
> Memory regions added by the current IGVM needs to be tracked so that they can be
> freed when a new IGVM is loaded.
>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   backends/igvm-cfg.c            |  1 +
>   backends/igvm.c                | 20 ++++++++++++--------
>   include/system/igvm-internal.h |  6 ++++++
>   3 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> index e1f09855f6..38438a7b1e 100644
> --- a/backends/igvm-cfg.c
> +++ b/backends/igvm-cfg.c
> @@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, Error **errp)
>       IgvmCfg *igvm = IGVM_CFG(uc);
>   
>       igvm->file = qigvm_file_init(igvm->filename, errp);
> +    QTAILQ_INIT(&igvm->memory_regions);
>   }
>   
>   OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 534032fed8..9e7c90d386 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -220,7 +220,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>                                     int region_identifier, Error **errp)
>   {
>       ERRP_GUARD();
> -    MemoryRegion *igvm_pages = NULL;
> +    IgvmMemoryRegion *imr = NULL;
>       Int128 gpa_region_size;
>       MemoryRegionSection mrs =
>           memory_region_find(get_system_memory(), addr, size);
> @@ -254,23 +254,27 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>            */
>           g_autofree char *region_name =
>               g_strdup_printf("igvm.%X", region_identifier);
> -        igvm_pages = g_new0(MemoryRegion, 1);
> +        imr = g_new0(IgvmMemoryRegion, 1);
> +        imr->mr = g_new0(MemoryRegion, 1);
>           if (ctx->machine_state->cgs &&
>               ctx->machine_state->cgs->require_guest_memfd) {
> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> +            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,


Please make sure to track them with owner set to 
OBJECT(ctx->machine_state). Without owner, reference counting is 
disabled and we end up leaking memory regions on cleanup you introduce 
in patch 3 later.


Alex


