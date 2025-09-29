Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141B9CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FJy-00050x-S8; Mon, 29 Sep 2025 10:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3FJn-0004wd-2i
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3FJi-0007Vl-Ev
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759157846;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1bPFdJc04xQqufj583xtML79RJkMNVCaB60kuD9f1E=;
 b=eH0WhbRwJ2xQFXdpKqUlCH+sEjCyCJZtKsj20EsMM6XAljSPXgSELcf16ilTg1jCvUUIg3
 TQEdl+mHTbSqWmK3v5UlS/A5GLh9yfE5zK3JzzXqsnVIg77QAyu9IjG/mCVnqLzfwYYoua
 g+b5KgjYWKLg75u74GbqlxcsPk7vOn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-so8IkgLfMyieoxXpX8Lprg-1; Mon, 29 Sep 2025 10:57:24 -0400
X-MC-Unique: so8IkgLfMyieoxXpX8Lprg-1
X-Mimecast-MFC-AGG-ID: so8IkgLfMyieoxXpX8Lprg_1759157844
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e31191379so30547305e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759157843; x=1759762643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V1bPFdJc04xQqufj583xtML79RJkMNVCaB60kuD9f1E=;
 b=jtzdE9jLcss20AC1klZz1M6wOnsOQMNGnGg2olHBtFIxeGAxqxaqXpZdG0lDBJCrAc
 SFkX0JqIuSElmolnoHaa1fOWMPvFLRkKACtNbJzAk7y5prV3+gtnc62r9Z8Erng8H1Cp
 Ou0A59z9q1GGAyzDRZuWoQq69qDuejzkOh5iBbKxC8DQ5KrEPOByfMMCrLevNqxJDJHu
 JoApZ1lEAaNfzAutO205PQ6h8oB+koGyzkz+53pV2AFoJqU3n+BtCsFuPrb2b7zPzXFO
 27F8Hs2fx2q4bL0rYH/7uwOP75wuo+HE/7I0dd8mha/WICNTkPeMZ5Yrstp8KiW1W2k6
 pKYQ==
X-Gm-Message-State: AOJu0YzBCuIir0xUVPNVie7xubA3hScMRRowjj2wO0tFYiRb8uc76Du9
 IBoemiU1Yw/Et8ZI073tj77gr2sfzgFvnjRKXyrHcV3wPTB0Xy+Ot/Knqz9YScnkZ5lyvuBrfCl
 ufJ2lcNg9lws/JAlibXBzz48sfWLQ6OQKwM/YHLffKRDWySorJkczomTD
X-Gm-Gg: ASbGncsjCgR/81mUT0ajLLkc1d7t27Bv4wL5q9KuI3bG8r1H0o3IacJUZOyEdAhh0tB
 zy3INAGtDC0+ChmP9YgN/zqLW2ORic0yjvR0vz87zDBx/PXNy2hN7CJeichRgd6t/LniMveYI7R
 8BAuvNUECRC3/xbkuMpNqNDv9cYPxuF0g1naIQz7qYRslLISaacx5YKIFdxbC4CiaIUMlx61Ogk
 Ha6YBAxWfL3KSNLpMWq4Xz/83scPrINFzKsN++Thr+hb+p50vSbNbdqxxZSaOlP8n1Kt9aTQKEf
 ixN7cQpIQBLm5coVzUCnVbixz/y0aSaYYdMRCWSq/FN8l1cM0HVdx8itB5ElI84/32/7cOKxt7O
 ixO8eHSzhKUY=
X-Received: by 2002:a05:600c:474e:b0:46e:450d:e037 with SMTP id
 5b1f17b1804b1-46e450de400mr86499075e9.5.1759157843371; 
 Mon, 29 Sep 2025 07:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnxd0LE8aCoeKII9sRxWb+6FQVeyGzosMJvS38EPoq+HZcDxRJYUbREPMnvXE6pFoEHDHhhQ==
X-Received: by 2002:a05:600c:474e:b0:46e:450d:e037 with SMTP id
 5b1f17b1804b1-46e450de400mr86498755e9.5.1759157842889; 
 Mon, 29 Sep 2025 07:57:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5873f2efsm13027845e9.4.2025.09.29.07.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 07:57:22 -0700 (PDT)
Message-ID: <78cf7d16-2e15-4610-9150-065ee816e586@redhat.com>
Date: Mon, 29 Sep 2025 16:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] hw/arm/smmuv3: Add secure TLB entry management
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-10-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250925162618.191242-10-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 9/25/25 6:26 PM, Tao Tang wrote:
> To prevent aliasing between secure and non-secure translations for the
> same address space, the IOTLB lookup key must incorporate the security
> state of the transaction. A secure parameter has been added to
> smmu_get_iotlb_key, ensuring that secure and non-secure TLB entries are
> treated as distinct entities within the cache.

In the same spirit as my previous comments I would encourage to split
this into 2 patches:
1) add the sec_sid in the key. This should cause no regression with the
NS current code base.
2) introduce a separate patch for the new smmuv3_invalidate_all_caches
and A_S_INIT_ALIAS support.
Those can be easily separated and you can refocus the associated commit
messages.

I also see you adapted some range invalidations for STAGE2 with sec_idx.
Since secure path is not implemented for S2 yet you may abort if this is
attempted at some point

Thanks

Eric
>
> Building on this, this commit also implements the SMMU_S_INIT register.
> This secure-only register provides a mechanism for software to perform a
> global invalidation of all cached translations within the IOTLB. This is
> a critical feature for secure hypervisors like Hafnium, which use it as
> the final step of their SMMU initialization sequence to ensure a clean
> TLB state.
>
> Together, these changes provide robust management for secure TLB entries,
> preventing TLB pollution between security worlds and allowing for proper
> initialization by secure software.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 25 ++++++++------
>  hw/arm/smmuv3.c              | 67 ++++++++++++++++++++++++++++--------
>  hw/arm/trace-events          |  1 +
>  include/hw/arm/smmu-common.h | 10 ++++--
>  4 files changed, 76 insertions(+), 27 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index f563cba023..fdabcc4542 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -84,7 +84,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
>  
>      /* Jenkins hash */
>      a = b = c = JHASH_INITVAL + sizeof(*key);
> -    a += key->asid + key->vmid + key->level + key->tg;
> +    a += key->asid + key->vmid + key->level + key->tg + key->sec_idx;
>      b += extract64(key->iova, 0, 32);
>      c += extract64(key->iova, 32, 32);
>  
> @@ -100,14 +100,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>  
>      return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
>             (k1->level == k2->level) && (k1->tg == k2->tg) &&
> -           (k1->vmid == k2->vmid);
> +           (k1->vmid == k2->vmid) && (k1->sec_idx == k2->sec_idx);
>  }
>  
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> -                                uint8_t tg, uint8_t level)
> +                                uint8_t tg, uint8_t level,
> +                                SMMUSecurityIndex sec_idx)
>  {
>      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
> -                        .tg = tg, .level = level};
> +                        .tg = tg, .level = level, .sec_idx = sec_idx};
>  
>      return key;
>  }
> @@ -129,7 +130,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>          SMMUIOTLBKey key;
>  
>          key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
> -                                 iova & ~mask, tg, level);
> +                                 iova & ~mask, tg, level, cfg->sec_idx);
>          entry = g_hash_table_lookup(bs->iotlb, &key);
>          if (entry) {
>              break;
> @@ -193,7 +194,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>      }
>  
>      *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> -                              tg, new->level);
> +                              tg, new->level, cfg->sec_idx);
>      trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
>                              tg, new->level);
>      g_hash_table_insert(bs->iotlb, key, new);
> @@ -313,13 +314,15 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
>  }
>  
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> +                         SMMUSecurityIndex sec_idx)
>  {
>      /* if tg is not set we use 4KB range invalidation */
>      uint8_t granule = tg ? tg * 2 + 10 : 12;
>  
>      if (ttl && (num_pages == 1) && (asid >= 0)) {
> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova,
> +                                              tg, ttl, sec_idx);
>  
>          if (g_hash_table_remove(s->iotlb, &key)) {
>              return;
> @@ -345,13 +348,15 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>   * in Stage-1 invalidation ASID = -1, means don't care.
>   */
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> -                        uint64_t num_pages, uint8_t ttl)
> +                        uint64_t num_pages, uint8_t ttl,
> +                        SMMUSecurityIndex sec_idx)
>  {
>      uint8_t granule = tg ? tg * 2 + 10 : 12;
>      int asid = -1;
>  
>     if (ttl && (num_pages == 1)) {
> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa,
> +                                              tg, ttl, sec_idx);
>  
>          if (g_hash_table_remove(s->iotlb, &key)) {
>              return;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2f8494c346..3835b9e79f 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -953,6 +953,21 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
>      smmu_configs_inv_sdev(bc, sdev);
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
>  /* Do translation with TLB lookup. */
>  static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUTransCfg *cfg,
> @@ -1181,16 +1196,18 @@ epilogue:
>   * @tg: translation granule (if communicated through range invalidation)
>   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
>   * @stage: Which stage(1 or 2) is used
> + * @sec_idx: security index
>   */
>  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>                                 IOMMUNotifier *n,
>                                 int asid, int vmid,
>                                 dma_addr_t iova, uint8_t tg,
> -                               uint64_t num_pages, int stage)
> +                               uint64_t num_pages, int stage,
> +                               SMMUSecurityIndex sec_idx)
>  {
>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>      SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
> -    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, SMMU_SEC_IDX_NS);
> +    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_idx);
>      IOMMUTLBEvent event;
>      uint8_t granule;
>  
> @@ -1235,7 +1252,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>      }
>  
>      event.type = IOMMU_NOTIFIER_UNMAP;
> -    event.entry.target_as = &address_space_memory;
> +    event.entry.target_as = smmu_get_address_space(sec_idx);
>      event.entry.iova = iova;
>      event.entry.addr_mask = num_pages * (1 << granule) - 1;
>      event.entry.perm = IOMMU_NONE;
> @@ -1246,7 +1263,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                        dma_addr_t iova, uint8_t tg,
> -                                      uint64_t num_pages, int stage)
> +                                      uint64_t num_pages, int stage,
> +                                      SMMUSecurityIndex sec_idx)
>  {
>      SMMUDevice *sdev;
>  
> @@ -1258,12 +1276,14 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                          iova, tg, num_pages, stage);
>  
>          IOMMU_NOTIFIER_FOREACH(n, mr) {
> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
> +                               num_pages, stage, sec_idx);
>          }
>      }
>  }
>  
> -static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
> +                               SMMUSecurityIndex sec_idx)
>  {
>      dma_addr_t end, addr = CMD_ADDR(cmd);
>      uint8_t type = CMD_TYPE(cmd);
> @@ -1289,11 +1309,11 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>  
>      if (!tg) {
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, sec_idx);
>          if (stage == SMMU_STAGE_1) {
> -            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_idx);
>          } else {
> -            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl, sec_idx);
>          }
>          return;
>      }
> @@ -1312,11 +1332,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>          num_pages = (mask + 1) >> granule;
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
>                                   ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
> +                                  num_pages, stage, sec_idx);
>          if (stage == SMMU_STAGE_1) {
> -            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
> +                                num_pages, ttl, sec_idx);
>          } else {
> -            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl);
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl, sec_idx);
>          }
>          addr += mask + 1;
>      }
> @@ -1514,7 +1536,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_idx);
>              break;
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
> @@ -1539,7 +1561,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>               * As currently only either s1 or s2 are supported
>               * we can reuse same function for s2.
>               */
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, sec_idx);
>              break;
>          case SMMU_CMD_TLBI_EL3_ALL:
>          case SMMU_CMD_TLBI_EL3_VA:
> @@ -1769,6 +1791,21 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_IRQ_CFG2:
>          s->bank[reg_sec_idx].eventq_irq_cfg2 = data;
>          return MEMTX_OK;
> +    case A_S_INIT_ALIAS:
> +        if (data & R_S_INIT_INV_ALL_MASK) {
> +            int cr0_smmuen = smmuv3_get_cr0_smmuen(s, SMMU_SEC_IDX_NS);
> +            int s_cr0_smmuen = smmuv3_get_cr0_smmuen(s, SMMU_SEC_IDX_S);
> +            if (cr0_smmuen || s_cr0_smmuen) {
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
> @@ -1925,6 +1962,8 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_CONS:
>          *data = s->bank[reg_sec_idx].eventq.cons;
>          return MEMTX_OK;
> +    case A_S_INIT_ALIAS:
> +        *data = 0;
>          return MEMTX_OK;
>      default:
>          *data = 0;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f99de78655..64e8659ae9 100644
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
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index c27aec8bd4..b566f11b47 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -184,6 +184,7 @@ typedef struct SMMUIOTLBKey {
>      int vmid;
>      uint8_t tg;
>      uint8_t level;
> +    SMMUSecurityIndex sec_idx;
>  } SMMUIOTLBKey;
>  
>  typedef struct SMMUConfigKey {
> @@ -265,16 +266,19 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>                                  SMMUTransTableInfo *tt, hwaddr iova);
>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> -                                uint8_t tg, uint8_t level);
> +                                uint8_t tg, uint8_t level,
> +                                SMMUSecurityIndex sec_idx);
>  SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecurityIndex sec_idx);
>  void smmu_iotlb_inv_all(SMMUState *s);
>  void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> +                         SMMUSecurityIndex sec_idx);
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> -                        uint64_t num_pages, uint8_t ttl);
> +                        uint64_t num_pages, uint8_t ttl,
> +                        SMMUSecurityIndex sec_idx);
>  void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
>  /* Invalidate all cached configs for a given device across all security idx */
>  void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);


