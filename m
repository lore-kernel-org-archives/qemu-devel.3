Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8C5C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6c6-0005rI-OR; Wed, 17 Jul 2024 11:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6bw-0005WC-Un
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6bs-0003bH-6Z
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721230227;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALaMNY1059SLRwzn/2RfEPOXfxCaDgRxwRcSvdvPpf4=;
 b=ChAlzdmudJ2an12CiQjg1sHJhuqoEgDH44owcTvRuiDuj3on6h/1OZ7XUuXT+8lIKaO+rc
 k0HCoKu8paDTwully2WpbFp9hBvKyLKyExwEuvZeiQvd3dYlb7vrpqZS2UwBo8t0v2BbWH
 2qgZgm7+lnepS2Ba4nMvWf9lcv8zy3g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Rrx9LtvTNi6XiYbu3yRsCg-1; Wed, 17 Jul 2024 11:30:25 -0400
X-MC-Unique: Rrx9LtvTNi6XiYbu3yRsCg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79ef9c44d3eso945892085a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721230225; x=1721835025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALaMNY1059SLRwzn/2RfEPOXfxCaDgRxwRcSvdvPpf4=;
 b=rmdZNcrdhN6zGgfuXaJehKwp8LJ6nltBQFinxjE86ZuJ7iJ4NuMxkBJG/o5Kyeq4nc
 eey9Of6rldLivluLxquTUiX9xDAcJTKjmDEGw3HuRk+Y3lEC5fWQflIF0ODjYNatfkcD
 +Ols/TJGc+mBK6ugHwHuTkZ3jr2RuRi49Jvm3w8BGJYa1xD6qSvMmSEEZqqgPmxLzR0s
 FusviTy/P2Z6u+xtWs7Ztgmmwv0t6YQkRyrzbW6QcL7OyVMgJ/+G1WKKryAfRHQiAUzV
 cG+2us4OJrdNL6GzR3Q8//usXN15n+vZGgsiDa3e9MFwGZ3apg7lE9Uk0LL0EG4ilbsa
 OC2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFFgIO5H+5HYx+IfUiy9c/B7/g6UI3sSJLNYi1t9zvYvsr0Gan091JZm8HwSilUEIl5PrOKtOT6yd1rh43LzlS97J18PE=
X-Gm-Message-State: AOJu0YwNgLbUdpSIETHOAOtJvuex2owepwKgfOibBqoAGComEFlaa1Tx
 ZpVZMa1CH81NNNSaLb0yE/IhkIMLRCiDmp0RIpz7TeCk7/8IEDYmhj2aGI78DJaCNVpFvRPAJxN
 2elJ8twLz9vFNsRK8B7Qzgk3UUAwNM1xpmrZOIHEg/m0UxBUbVKtg
X-Received: by 2002:a05:620a:199a:b0:79d:6052:1994 with SMTP id
 af79cd13be357-7a1875043a5mr251460685a.58.1721230225003; 
 Wed, 17 Jul 2024 08:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKC9s25qTgzMTwoavLokxedPkFZhrN5fZGruCX8TwcNKEwyLYCIumWuH81B6f5W1bNoKa8cw==
X-Received: by 2002:a05:620a:199a:b0:79d:6052:1994 with SMTP id
 af79cd13be357-7a1875043a5mr251457585a.58.1721230224596; 
 Wed, 17 Jul 2024 08:30:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160b92ba7sm414925685a.27.2024.07.17.08.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 08:30:24 -0700 (PDT)
Message-ID: <f866d214-1d01-4daa-a8f1-bb9718f67278@redhat.com>
Date: Wed, 17 Jul 2024 17:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-16-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240715084519.1189624-16-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/15/24 10:45, Mostafa Saleh wrote:
> IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
> SMMU instances we consider the input address as the IOVA, but when
> nesting is used, we can't mix stage-1 and stage-2 addresses, so for
> nesting only stage-1 is considered the IOVA and would be notified.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c     | 39 +++++++++++++++++++++++++--------------
>  hw/arm/trace-events |  2 +-
>  2 files changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9a88b83511..84cd314b33 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1096,27 +1096,38 @@ epilogue:
>   * @iova: iova
>   * @tg: translation granule (if communicated through range invalidation)
>   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
> + * @stage: Which stage(1 or 2) is used
>   */
>  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>                                 IOMMUNotifier *n,
>                                 int asid, int vmid,
>                                 dma_addr_t iova, uint8_t tg,
> -                               uint64_t num_pages)
> +                               uint64_t num_pages, int stage)
>  {
>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
> +    SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
> +    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
>      IOMMUTLBEvent event;
>      uint8_t granule;
> -    SMMUv3State *s = sdev->smmu;
> +
> +    if (!cfg) {
> +        return;
> +    }
> +
> +    /*
> +     * stage is passed from TLB invalidation commands which can be either
> +     * stage-1 or stage-2.
> +     * However, IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
> +     * SMMU instances we consider the input address as the IOVA, but when
> +     * nesting is used, we can't mix stage-1 and stage-2 addresses, so for
> +     * nesting only stage-1 is considered the IOVA and would be notified.
> +     */
> +    if ((stage == SMMU_STAGE_2) && (cfg->stage == SMMU_NESTED))
> +        return;
>  
>      if (!tg) {
> -        SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
> -        SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
>          SMMUTransTableInfo *tt;
>  
> -        if (!cfg) {
> -            return;
> -        }
> -
>          if (asid >= 0 && cfg->asid != asid) {
>              return;
>          }
> @@ -1125,7 +1136,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>              return;
>          }
>  
> -        if (STAGE1_SUPPORTED(s)) {
> +        if (stage == SMMU_STAGE_1) {
>              tt = select_tt(cfg, iova);
>              if (!tt) {
>                  return;
> @@ -1151,7 +1162,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                        dma_addr_t iova, uint8_t tg,
> -                                      uint64_t num_pages)
> +                                      uint64_t num_pages, int stage)
>  {
>      SMMUDevice *sdev;
>  
> @@ -1160,10 +1171,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>          IOMMUNotifier *n;
>  
>          trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
> -                                        iova, tg, num_pages);
> +                                        iova, tg, num_pages, stage);
>  
>          IOMMU_NOTIFIER_FOREACH(n, mr) {
> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
>          }
>      }
>  }
> @@ -1194,7 +1205,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>  
>      if (!tg) {
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
>          } else {
> @@ -1217,7 +1228,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>          num_pages = (mask + 1) >> granule;
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
>                                   ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
>          } else {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 593cc571da..be6c8f720b 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> -smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
> +smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"


