Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CFEC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnePY-0003yl-IQ; Thu, 27 Feb 2025 08:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnePU-0003vz-1n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnePR-000806-TX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740664720;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pl6ecwuwNAq4GurPYG+n+Gv46zl2dCc56pniwaicPPE=;
 b=H+76djMUfQ5rh3iAbht8YWS97yACE4TcIJeiDyn4I5eRdSL39CHehc2ZL+OAhW7zBR0Hx9
 sZNs93bWTSw40k/+qYzesIp777v8TgxJ3KlUu+7ooq1o0QUa5mfDRkO0Kg6NkdIu9S99XH
 wiIDKHRpKXg5iJ1/0UHpdU6PvrlDtGs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-QvEuhrM6Pn2E-LKiVv42Nw-1; Thu, 27 Feb 2025 08:58:38 -0500
X-MC-Unique: QvEuhrM6Pn2E-LKiVv42Nw-1
X-Mimecast-MFC-AGG-ID: QvEuhrM6Pn2E-LKiVv42Nw_1740664717
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399a5afcb3so8857005e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740664717; x=1741269517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pl6ecwuwNAq4GurPYG+n+Gv46zl2dCc56pniwaicPPE=;
 b=wUiYKkTMWv6C7MO9uTHL9yOyzIpG0Gk/p32H8S8YeC8LI2pWxG0j9b2P5GpdwrWC5m
 1HEoSbYh8zwL5s+M5ufdmEG9q69MLQ18kiWysuvVCP2AaQkdKuK7B12bslPIVfqp0hok
 uNke0KAF18Pl8XTcbW8SJGHABSWyN2BVD3UiY5+QDmPgcpi5oSQGVYOVJuK2X7AbsRhs
 7EMEPCeIvRO0V84HtZ19nmDmmrf5Tn3nV9NLlV73qSgGVGdJvNp3+gplzarDjAo2ZtlC
 /PEoBChUeD1nfRvoV1xhpw5tcoCKWUd/j+flSDR0B2DhFEykqOUi5RZaH0ArtzgflVy1
 XFvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDmcyfGsy7mf2ED/v8FvGFBuNWR07XO9c6Qgzmmia3tkSnE3UgfD+VtWjktZEBJuFHR/bXmdoL2h+F@nongnu.org
X-Gm-Message-State: AOJu0YxmfZr/TyWr7NTkvSvfhb9gRfOAUt2gjzZbHLaUjV0DxtHT9RTp
 r0fnwG9oi4yygK8/ngO59UuttsmdlCojIKUBMy5rOpnymDZwK31vJbtfylEbxiDfQBvz+m1140h
 VaabyJkV4Cz5a+dsftSf5nGtLsSBbqPWfYEFb/llDerRapV9JFJAc
X-Gm-Gg: ASbGnctgKrD9AMSykLddje0p8n42AQGsitB6MF8dPwSJzcjN+LIMw3orPH2XO1yb1DJ
 tb1UV+DPCKRgrnL8GMkD5LZr6Zgnr/7shf2XoJRQ1h4nLK9sjJ2K+NjWw8O6uRMgRlYbwiYu4h5
 XGQZiyKJqaMD0p7Sw6lRGKKrAKiG+19C+1wls4pdH7FFLlkQHjvaZxNp34yPBa84gerxVjPfYdh
 Ejy5VAcKJj8a8E5+XfN9oq89oxc4y970mbjyCqtPORsR2D2WrcmGiYBpy/jMvlz/ThKOtpcinhQ
 KgB2wdXjdFbcPH9V26nR34SUKs8Semiy2jSxWoEtbGinEbxUps707uNLCzQmfeU=
X-Received: by 2002:a05:600c:1ca9:b0:439:94f8:fc79 with SMTP id
 5b1f17b1804b1-43ab7ae46efmr102740715e9.0.1740664717522; 
 Thu, 27 Feb 2025 05:58:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2xIUWaGnJ6AqFxd73gyFA3eUTqt7NeI0lJ2dOKNoRLjP8wYh+pH/SU0xdMxXdNknNNyh5qg==
X-Received: by 2002:a05:600c:1ca9:b0:439:94f8:fc79 with SMTP id
 5b1f17b1804b1-43ab7ae46efmr102740465e9.0.1740664717120; 
 Thu, 27 Feb 2025 05:58:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a27ab9fsm23789115e9.25.2025.02.27.05.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 05:58:36 -0800 (PST)
Message-ID: <40b0deac-17ed-4720-9cfd-95c4de363182@redhat.com>
Date: Thu, 27 Feb 2025 14:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/smmu: Add invalidating function of config data
Content-Language: en-US
To: JianChunfu <jansef.jian@hj-micro.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250221031741.69946-1-jansef.jian@hj-micro.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250221031741.69946-1-jansef.jian@hj-micro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,


On 2/21/25 4:17 AM, JianChunfu wrote:
> Uniform the removal judgement of g_hash_table_foreach_remove(), previous
> name seems to perform the actual action while it just returns a Boolean.
I had difficulties to understand the commit msg.

IIUC you meant smmuv3_invalidate_ste() name is not self explanatory and
you would prefer to use a similar terminology as the one being used for
other hash table matching functions, ie. "remove_by" and introduce a
helper that invokes the g_hash_table_foreach_remove with the renamed
function. + add "No functional change intended".
>
> Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
> ---
> v2: - move smmuv3_invalidate_ste() to smmu_hash_remove_by_sid_range()
>     - add function smmu_configs_inv_sid_range()
> v1: - Rename smmuv3_invalidate_ste to smmuv3_hash_remove_by_sid_range
> ---
>  hw/arm/smmu-common.c         | 21 +++++++++++++++++++++
>  hw/arm/smmu-internal.h       |  5 -----
>  hw/arm/smmuv3.c              | 17 +----------------
>  hw/arm/trace-events          |  1 +
>  include/hw/arm/smmu-common.h |  6 ++++++
>  5 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3f8272875..69544392a 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -225,6 +225,27 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
>             ((entry->iova & ~info->mask) == info->iova);
>  }
>  
> +static gboolean
> +smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
> +{
> +    SMMUDevice *sdev = (SMMUDevice *)key;
> +    uint32_t sid = smmu_get_sid(sdev);
> +    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
> +
> +    if (sid < sid_range->start || sid > sid_range->end) {
> +        return false;
> +    }
> +    trace_smmuv3_config_cache_inv(sid);
now the code has been moved to smmu-common, would be better to rename
the trace into

trace_smmu_config_cache_inv and move it into the 
# smmu-common.c section in trace-events.

> +    return true;
> +}
> +
> +void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
> +{
> +    trace_smmu_configs_inv_sid_range(sid_range.start, sid_range.end);
> +    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range,
> +                                &sid_range);
> +}
> +
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl)
>  {
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index 843bebb18..d143d296f 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -141,9 +141,4 @@ typedef struct SMMUIOTLBPageInvInfo {
>      uint64_t mask;
>  } SMMUIOTLBPageInvInfo;
>  
> -typedef struct SMMUSIDRange {
> -    uint32_t start;
> -    uint32_t end;
> -} SMMUSIDRange;
> -
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 4c49b5a88..9da3b6df0 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1277,20 +1277,6 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>      }
>  }
>  
> -static gboolean
> -smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)
> -{
> -    SMMUDevice *sdev = (SMMUDevice *)key;
> -    uint32_t sid = smmu_get_sid(sdev);
> -    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
> -
> -    if (sid < sid_range->start || sid > sid_range->end) {
> -        return false;
> -    }
> -    trace_smmuv3_config_cache_inv(sid);
> -    return true;
> -}
> -
>  static int smmuv3_cmdq_consume(SMMUv3State *s)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1373,8 +1359,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              sid_range.end = sid_range.start + mask;
>  
>              trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
> -            g_hash_table_foreach_remove(bs->configs, smmuv3_invalidate_ste,
> -                                        &sid_range);
> +            smmu_configs_inv_sid_range(bs, sid_range);
>              break;
>          }
>          case SMMU_CMD_CFGI_CD:
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index c64ad344b..95f523361 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -15,6 +15,7 @@ smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
>  smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
>  smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
>  smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> +smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
>  smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
>  smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index e5ad55bba..e5e2d0929 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -142,6 +142,11 @@ typedef struct SMMUIOTLBKey {
>      uint8_t level;
>  } SMMUIOTLBKey;
>  
> +typedef struct SMMUSIDRange {
> +    uint32_t start;
> +    uint32_t end;
> +} SMMUSIDRange;
> +
>  struct SMMUState {
>      /* <private> */
>      SysBusDevice  dev;
> @@ -219,6 +224,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>                          uint64_t num_pages, uint8_t ttl);
> +void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);
>  
Otherwise it looks good.

Thanks

Eric


