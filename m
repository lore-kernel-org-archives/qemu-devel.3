Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EA3D206A9
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 14:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRAOo-0007be-8O; Thu, 04 Dec 2025 09:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRAOl-0007aa-UF
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRAOk-0007RH-A8
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764858812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJTbbx9bvccEvtU1F7UOZYSh0YBKtNEjL+ESlkbOtvs=;
 b=i2V4RpfDvaqyEUBPQW3OaJtxHGrb28zyK+SQ4rfrKxNtD6edu9Ae625HekLTzrzcDDb2Cp
 ruFb59URouwAdax9J36YnSxigaWvmteoc6huaFW92ts8mGAoD9s5SlDqVcN2aoRqAn8Bjm
 wd6owL954Ki4iYsDWm7fgSi6vO3r93g=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-yUAl1RH4Nzqd02t7UqvnPQ-1; Thu, 04 Dec 2025 09:33:29 -0500
X-MC-Unique: yUAl1RH4Nzqd02t7UqvnPQ-1
X-Mimecast-MFC-AGG-ID: yUAl1RH4Nzqd02t7UqvnPQ_1764858809
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6421389c362so1177646d50.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 06:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764858809; x=1765463609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJTbbx9bvccEvtU1F7UOZYSh0YBKtNEjL+ESlkbOtvs=;
 b=CgHf+Pu/xiEMNAzeyjv231+g82ZDca7l4NWPUOwlF12Y39CleHY0dP3i4Dwip6a261
 MY5GqkpUGNlSyLfEmnhKPG9XcQYW0CHhk1Wfn8fSDlFKLeRgQT7K6f6AMy4kikqjNu2o
 IquamUQBW+FfEYaiODh/uo7KAJ3+Wy086N/YSu4JkihOw59eohh+RYE8t+Hhz4ppewxE
 tPYdJbUgrXrDBfKWcZvC/8y/y/d3JxX30oZBVOTIYGCDcO680AF8uSzYTiEbwOILkEQl
 iXL5tFtKhkCnk8ZDL3krXJGZdWuw0KFhm3ZYaqs/4S5WpZH7V9ar8tmEAR3FyIdAjjfm
 rqIQ==
X-Gm-Message-State: AOJu0YwIX9gu4ri9OEQzm03QkSU+anUzEvOZk4ZlcWZYeX37hD8fcfp5
 4cnzcphB5geytMP76tJMDQooJ7MD2L46/4Ev+eGu7vhPuJ0aJEo/iEg8hnA1I+jDtBztQfeJOIf
 KCkcBQr3gS9XKjX80e202sW/VKx0XgtTvVtw2FKvUZ9hCTF/+eHPdDn2O
X-Gm-Gg: ASbGnct5IuYDONTKzfjrNBjIp9y0yZ/P4I4oNtnRvAe188wOeXV4g312i5QLh5FkMwR
 WwzB+FfZpzfkcb3TF0oT3Xe9pB/8w7iFP1WUARWdi4Ms0VMcZtR+cBlTt3bjOauCwNOVryCfkUj
 uzcNsYb80RoMTz2iCt3a9fKcyZyYva/w5biVkEjbdYBcanG1f3Ssv95RpabnIHhm+A0ohU90oQv
 SoRLNYhnGfzD0WEFq0oqPWzqvrUXiNpkm32/ZviDOsG+59Wmod1GX79gEIOuw/sIA62k59/vrcn
 KIWKMKDfr8ejjuTApGuldM2wmd3eMp/b2pe1ta/q84MkplnUsfWKsH2EYZXBBjhfPRImNqMdpGC
 FrG9kpcpA9nyNLIqF/He/nccjocfgLQiP9NjAk5R1Rh2RFXsewjcsX15Bxg==
X-Received: by 2002:a05:690e:1486:b0:63f:b5a5:37c with SMTP id
 956f58d0204a3-6443d8ea4c2mr2696992d50.2.1764858809317; 
 Thu, 04 Dec 2025 06:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8MolvGFND5akNFmibK9HSspDeQ5bXOfjmLTbA1M+rKG/sJ/7ngViswEZ3iXdAQBv2MvDXgQ==
X-Received: by 2002:a05:690e:1486:b0:63f:b5a5:37c with SMTP id
 956f58d0204a3-6443d8ea4c2mr2696967d50.2.1764858808924; 
 Thu, 04 Dec 2025 06:33:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78c1b78e8b5sm5724037b3.43.2025.12.04.06.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 06:33:28 -0800 (PST)
Message-ID: <421fdc65-c21d-4606-a241-28341955104a@redhat.com>
Date: Thu, 4 Dec 2025 15:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 16/21] hw/arm/smmuv3: Implement SMMU_S_INIT register
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151351.4130239-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012151351.4130239-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 10/12/25 5:13 PM, Tao Tang wrote:
> Implement read/write handlers for the SMMU_S_INIT secure-only
> register.
>
> Writing to this register provides a mechanism for software to perform a
> global invalidation of ALL caches within the SMMU. This includes the
> IOTLBs and Configuration Caches across all security states.
>
> This feature is critical for secure hypervisors like Hafnium, which
> use it as a final step in their SMMU initialization sequence. It
> provides a reliable, architecturally defined method to ensure a clean
> and known-good cache state before enabling translations.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c     | 33 +++++++++++++++++++++++++++++++++
>  hw/arm/trace-events |  1 +
>  2 files changed, 34 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 100caeeb35..432de88610 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -354,6 +354,21 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>  
>  }
>  
> +static void smmuv3_invalidate_all_caches(SMMUv3State *s)
> +{
> +    trace_smmuv3_invalidate_all_caches();
> +    SMMUState *bs = &s->smmu_state;
> +
> +    /* Clear all cached configs including STE and CD */
> +    if (bs->configs) {
> +        g_hash_table_remove_all(bs->configs);
> +    }
> +
> +    /* Invalidate all SMMU IOTLB entries */
> +    smmu_inv_notifiers_all(&s->smmu_state);
> +    smmu_iotlb_inv_all(bs);
> +}
> +
>  static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUTransCfg *cfg,
>                                                   SMMUEventInfo *event,
> @@ -1969,6 +1984,21 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>  
>          bank->eventq_irq_cfg2 = data;
>          return MEMTX_OK;
> +    case (A_S_INIT & 0xfff):
why do we apply & 0xfff ?
> +        if (data & R_S_INIT_INV_ALL_MASK) {
> +            int cr0_smmuen = smmu_enabled(s, reg_sec_sid);
> +            int s_cr0_smmuen = smmuv3_get_cr0ack_smmuen(s, reg_sec_sid);
> +            if (cr0_smmuen || s_cr0_smmuen) {
use smmuv3_is_smmu_enabled()?
> +                /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
> +                qemu_log_mask(LOG_GUEST_ERROR, "S_INIT write ignored: "
> +                              "CR0.SMMUEN=%d or S_CR0.SMMUEN=%d is set\n",
> +                              cr0_smmuen, s_cr0_smmuen);
> +                return MEMTX_OK;
> +            }
> +            smmuv3_invalidate_all_caches(s);
> +        }
> +        /* Synchronous emulation: invalidation completed instantly. */
> +        return MEMTX_OK;
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
> @@ -2172,6 +2202,9 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_CONS:
>          *data = bank->eventq.cons;
>          return MEMTX_OK;
> +    case (A_S_INIT & 0xfff):
> +        *data = 0;
> +        return MEMTX_OK;
>      default:
>          *data = 0;
>          qemu_log_mask(LOG_UNIMP,
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 434d6abfc2..0e7ad8fee3 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -64,6 +64,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
> +smmuv3_invalidate_all_caches(void) "Invalidate all SMMU caches and TLBs"
>  smmu_reset_exit(void) ""
>  
>  # strongarm.c
Thanks

Eric


