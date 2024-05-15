Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799A8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7DxR-0001EU-N0; Wed, 15 May 2024 08:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7DxD-0001Cq-OZ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7DxA-0006BR-R1
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715776912;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9KNfcZMT4EbRYsu7Qmem6zWhRf0dUHw8W2+vQBBdO70=;
 b=OnmRh1ONXN95aURQ1nTQQAY3B8MgbblIvoEyeikx2BIV3L4lPhdvVafKqyXDnjnqdRlHGa
 hgNQWk5B//FNA0Bfyt0wa0D6pkwRVglXPabXRuWcE9/Qipa7U3hqkVuzoxjE0crr1brZqX
 +vVfCEJesnWwDyArOuYGha+GWdZJuJg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-zEvZL-aYP_CUngX_sZA0Ag-1; Wed, 15 May 2024 08:41:49 -0400
X-MC-Unique: zEvZL-aYP_CUngX_sZA0Ag-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6f10d71ed9eso2977607a34.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776907; x=1716381707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9KNfcZMT4EbRYsu7Qmem6zWhRf0dUHw8W2+vQBBdO70=;
 b=D9uMQJgSJ7M6PA0TEGVsWY3iEi4B9KTePoKXaoeWMR8aG1jWGsJRkyW1ygoAC4UHVS
 6S1ec6o+mIlHn0Y7YKW3byKv8SxNpxu3HG6JIYRk5K7WxWz7q/Q3R3BGQLNHlvAzNVVp
 je2r48PHBDUCbGa64smq/qvCKjJ7AtBVI+14g8GSum+5KhaswozpUhSvTFJEmEl9cf7y
 Gi8bYtvUYTrhcSQEDVuWjn4EDtll2PWs0qer23PencADfl+tTxqkqoz4QJ8pym9d/gbY
 Uvu0Lkbg3z0x5uToQu4RBqf37cu6NoZOWPG5B7dF4XvQPHjfZY4j9oy07vrWoAW+umzR
 jvpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy5MOny9rQ5x3GC5KYM0jeo282t/JqPn22zTEWy8SsijSVI3/VKC7qU5qykhtUYCdY8yraByXWsuQMlJOp3UBKxcZhpOk=
X-Gm-Message-State: AOJu0YyhS+Jd7HWeC0LM434XQjxiaP2rJ/5KospNNpyO3ufx7Vv8g78n
 nJr6QSHi/GF1qoHfvRZCMCfyAHpdslM5DjqNnBBQCnu0Nt2GBC73XgJX4nta50X00G7xC9nGOkF
 WzSrbZmmscJYjdnKo2X12pA1caMpRe2Zr71BoyBbCBHJLGGMyLSnz
X-Received: by 2002:a05:6830:18d1:b0:6f1:18da:603 with SMTP id
 46e09a7af769-6f118da06admr4748009a34.4.1715776907069; 
 Wed, 15 May 2024 05:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeyQRtGW+XZztbbrsttNymhJJxFMirqbsMJWUzz6DCLdmlTCYMo7QFEPDNDCetNu2bqm6G5g==
X-Received: by 2002:a05:6830:18d1:b0:6f1:18da:603 with SMTP id
 46e09a7af769-6f118da06admr4747995a34.4.1715776906686; 
 Wed, 15 May 2024 05:41:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df54b58b5sm82910141cf.7.2024.05.15.05.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:41:46 -0700 (PDT)
Message-ID: <195e906c-d263-4736-91aa-69274fa85180@redhat.com>
Date: Wed, 15 May 2024 14:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/18] hw/arm/smmu: Consolidate ASID and VMID types
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-7-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-7-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mostafa,
On 4/29/24 05:23, Mostafa Saleh wrote:
> ASID and VMID used to be uint16_t in the translation config, however,
> in other contexts they can be int as -1 in case of TLB invalidation,
other contexts = TLB invalidation, right?
> to represent all(don’t care).
add space bewteen all and (.
> When stage-2 was added asid was set to -1 in stage-2 and vmid to -1
> in stage-1 configs. However, that meant they were set as (65536),
> this was not an issue as nesting was not supported and no
> commands/lookup targets both.
s/targets/uses
>
> With nesting, it’s critical to get this right as translation must be
> tagged correctly with ASID/VMID, and with ASID=-1 meaning stage-2.
> Represent ASID/VMID everywhere as int.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 10 +++++-----
>  hw/arm/smmuv3.c              |  4 ++--
>  hw/arm/trace-events          | 18 +++++++++---------
>  include/hw/arm/smmu-common.h | 14 +++++++-------
>  4 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index d94db6b34f..21982621c0 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -57,7 +57,7 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>             (k1->vmid == k2->vmid);
>  }
>  
> -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> +SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level)
>  {
>      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
> @@ -130,7 +130,7 @@ void smmu_iotlb_inv_all(SMMUState *s)
>  static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
>                                           gpointer user_data)
>  {
> -    uint16_t asid = *(uint16_t *)user_data;
> +    int asid = *(int *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
>      return SMMU_IOTLB_ASID(*iotlb_key) == asid;
> @@ -139,7 +139,7 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
>  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>                                           gpointer user_data)
>  {
> -    uint16_t vmid = *(uint16_t *)user_data;
> +    int vmid = *(int *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
>      return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
> @@ -191,13 +191,13 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                                  &info);
>  }
>  
> -void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
> +void smmu_iotlb_inv_asid(SMMUState *s, int asid)
>  {
>      trace_smmu_iotlb_inv_asid(asid);
>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
>  }
>  
> -void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
> +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
>  {
>      trace_smmu_iotlb_inv_vmid(vmid);
>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index f98c157221..cc61708160 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1243,7 +1243,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          }
>          case SMMU_CMD_TLBI_NH_ASID:
>          {
> -            uint16_t asid = CMD_ASID(&cmd);
> +            int asid = CMD_ASID(&cmd);
>  
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
> @@ -1276,7 +1276,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              break;
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
> -            uint16_t vmid = CMD_VMID(&cmd);
> +            int vmid = CMD_VMID(&cmd);
>  
>              if (!STAGE2_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index cc12924a84..09ccd39548 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -11,13 +11,13 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
>  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
>  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> -smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
> -smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
> -smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> +smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=%d"
> +smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
> +smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> -smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> -smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> -smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
> +smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> +smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> +smmu_iotlb_insert(int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
>  
>  # smmuv3.c
>  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
> @@ -48,12 +48,12 @@ smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t p
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
>  smmuv3_cmdq_tlbi_nh(void) ""
> -smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
> -smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
> +smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
> +smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> -smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
> +smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 5944735632..96eb017e50 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -84,7 +84,7 @@ typedef struct SMMUS2Cfg {
>      bool record_faults;     /* Record fault events (S2R) */
>      uint8_t granule_sz;     /* Granule page shift (based on S2TG) */
>      uint8_t eff_ps;         /* Effective PA output range (based on S2PS) */
> -    uint16_t vmid;          /* Virtual Machine ID (S2VMID) */
> +    int vmid;               /* Virtual Machine ID (S2VMID) */
>      uint64_t vttb;          /* Address of translation table base (S2TTB) */
>  } SMMUS2Cfg;
>  
> @@ -108,7 +108,7 @@ typedef struct SMMUTransCfg {
>      uint64_t ttb;              /* TT base address */
>      uint8_t oas;               /* output address width */
>      uint8_t tbi;               /* Top Byte Ignore */
> -    uint16_t asid;
> +    int asid;
>      SMMUTransTableInfo tt[2];
>      /* Used by stage-2 only. */
>      struct SMMUS2Cfg s2cfg;
> @@ -132,8 +132,8 @@ typedef struct SMMUPciBus {
>  
>  typedef struct SMMUIOTLBKey {
>      uint64_t iova;
> -    uint16_t asid;
> -    uint16_t vmid;
> +    int asid;
> +    int vmid;
>      uint8_t tg;
>      uint8_t level;
>  } SMMUIOTLBKey;
> @@ -205,11 +205,11 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
>  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>                                  SMMUTransTableInfo *tt, hwaddr iova);
>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> +SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level);
>  void smmu_iotlb_inv_all(SMMUState *s);
> -void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
> -void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
> +void smmu_iotlb_inv_asid(SMMUState *s, int asid);
> +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
>  
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


