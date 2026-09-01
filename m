Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1C3C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1PDj-0004lO-Ku; Tue, 01 Sep 2026 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PDh-0004l6-Ng
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:12:13 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PDc-0007uO-Kt
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:12:13 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a5dce0aacdso11075a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788271927; x=1788876727; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fhpKgbADrOGLwqe+MMroWjXRf8xZSh4k/RB9gfvInKg=;
 b=Sxl1P4os0PR70BeBsZQSyGa+/OJQzVx6ETk/zY3lnYEtnrEklPw6CQJCMeOf7pYOQC
 pSncWo9PGwC+do8NLo7i+MAhBMGM1baOeWfazODmYELh5RNo1rLJHlhIURh+86uYJy1u
 3PY2oCxRfGr5F4iudfUAX0w0trEV/ScXMBgMFFiR8/H1ta4pzMSzXkXKs8C0KicHs8Tp
 gVbFjpmos3SimBwtQURfzaXz9rEGN/CFiJt7fUvg1uaY2AlvuxY/lu9VNlnUCKslr/ZR
 MYYGw/XqpNkia6pv0xZK97iF+riiKeeticS+6nQlljtY+X9juBKiA7WCMD2ssGvxc0X+
 N1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271927; x=1788876727;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fhpKgbADrOGLwqe+MMroWjXRf8xZSh4k/RB9gfvInKg=;
 b=E89+Nou8TA+Oko4E03wwxmMR54tUpZQAAqS5Jwzy6kjsHU5NVIUVhL1A9rtmA2fsUy
 qsMbMkbN4bHu2Dgz38JZYh69gnHsCsbkLbq7LnEeHTNUAgHx2Z1oA2F5EIc6O6klb8sn
 vHf0FznxohYyj/j5tl53u15mlVxxrO3MF9NK4wOdo1Lab/sEaXJn6OX9jApH0zz/Ki3l
 68hnJp8kkcYxXiFJW8mWOfZMZAcv3tZnMzK2Ze8FTou0y9feDVO7tf7isdjL9BQDE4WE
 6ONXw4p+wbETovteK6Jd71wPg0oAYhVGnX2k2f25i2HHdzY3XcO/xkPbDPSTRUQQXLAO
 lrhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5ylRjbjWwO7ivor2iMYrsQn0EIgs6mi3k0HWpd6vSm3J7ijekFe/uc7ayywxYKl33Sf5CCbqUamEc@nongnu.org
X-Gm-Message-State: AFuF++ncggmdttnBn3/6MstMgzruA7RVzOrhP1sbZL5D5JVkgKQ+O06L
 Xx1Spako9rxZiklUAzRnWGid+qPjKNLcLZkga+0CYZv7r5Nk4dV9QOkx1uBHWnE/9g==
X-Gm-Gg: AYBFou1Onu7wZ34h+eu3awt6vSibAeN3QBEr9hpyHtsbL3j7rSHQ79SFfTxiX8od7YB
 67IgG+PDFPbgQ/GyOekKhraMeL4H+SHdHN83ZGueAWqXC6ZJZB8ze13kiwYj4ANkDdxMRPRfZMV
 6/ckP2U86F12xZS6qdVTp37AISjg28ssIrzg6kOWYbEpv9U9qDB2unR+RfF/biV9thyKTQFN3Cm
 SZpYmNGsOkRXEjY9tRRPD7+dqSYKowk7x/H9QiVyxjRFYwbot2p/lG4m+u2Af8og1a1FtMNLJYh
 KsOxtHJOt7Vm2ZrcOZVxqBB3qgZVGMepHXKYRfpI+3S9x1Cnkf9cmgcX0vzGzaG8cjjf2s+YpzI
 M3K6lLlWOL9fH3EstEu4hNfZdfn1RL8ACCeaPBoICmfV8jUtxK38z1y80VSMStF9473dNlwLlul
 qtGvtPX0vsl/NDNtdGpoR9EIuxzBTRSj4y39l5aXxLp6nesqQdtKonRAk1Hlh2eTEU/OTbf/gE/
 LX4163JbaQSfDGnCkEI0Oc2gYS3kQ==
X-Received: by 2002:a05:6402:a257:10b0:6a4:abe:52db with SMTP id
 4fb4d7f45d1cf-6a66a195ca9mr40321a12.12.1788271925884; 
 Tue, 01 Sep 2026 07:12:05 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a66ccb91fasm953227a12.5.2026.09.01.07.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:12:02 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:11:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 12/28] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
Message-ID: <apbdLhuQ7T0I9lMS@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-2-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162512.2807281-2-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=smostafa@google.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Aug 14, 2026 at 12:25:09AM +0800, Tao Tang wrote:
> To prevent aliasing between translations controlled through the Secure and
> Non-secure programming interfaces, the IOTLB lookup key must incorporate
> SEC_SID.
> 
> This commit:
> - expands SMMUIOTLBKey with SEC_SID field for cache key differentiation

I still feel that it's better to have a separate IOTLB for the secure
world, as it should never mix with the non-secure one; as I commented
on the last version:
https://lore.kernel.org/qemu-devel/aaGuGuevX8HFqx0x@google.com/

Then all the functions can be re-used and it is just a matter
of passing the right instance.

No strong opinion though, this approach should work also, so it is up
to Eric.

Thanks,
Mostafa

> - extends SMMUIOTLBPageInvInfo with SEC_SID for invalidation filtering
> - updates all IOTLB invalidation helpers (smmu_iotlb_inv_iova,
>   smmu_iotlb_inv_ipa, smmu_iotlb_inv_asid_vmid, smmu_iotlb_inv_vmid,
>   smmu_iotlb_inv_vmid_s1) to accept and filter by SEC_SID
> - plumbs SEC_SID through smmuv3_range_inval for TLB invalidation
> - enhances trace events to include SEC_SID for better debugging
> 
> This ensures that IOTLB entries decoded through the Secure and Non-secure
> programming interfaces are distinct, preventing cache aliasing across
> SEC_SID namespaces.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 110 +++++++++++++++++++++++------------
>  hw/arm/smmu-internal.h       |   2 +
>  hw/arm/smmuv3.c              |  47 ++++++++++-----
>  hw/arm/trace-events          |  20 +++----
>  include/hw/arm/smmu-common.h |  32 +++++++---
>  5 files changed, 140 insertions(+), 71 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 317cfafded2..3d4b6b3a287 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -95,7 +95,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
>  
>      /* Jenkins hash */
>      a = b = c = JHASH_INITVAL + sizeof(*key);
> -    a += key->asid + key->vmid + key->level + key->tg;
> +    a += key->asid + key->vmid + key->level + key->tg + key->sec_sid;
>      b += extract64(key->iova, 0, 32);
>      c += extract64(key->iova, 32, 32);
>  
> @@ -111,14 +111,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>  
>      return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
>             (k1->level == k2->level) && (k1->tg == k2->tg) &&
> -           (k1->vmid == k2->vmid);
> +           (k1->vmid == k2->vmid) && (k1->sec_sid == k2->sec_sid);
>  }
>  
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> -                                uint8_t tg, uint8_t level)
> +                                uint8_t tg, uint8_t level,
> +                                SMMUSecSID sec_sid)
>  {
>      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
> -                        .tg = tg, .level = level};
> +                        .tg = tg, .level = level, .sec_sid = sec_sid};
>  
>      return key;
>  }
> @@ -126,7 +127,8 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>  static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>                                                    SMMUTransCfg *cfg,
>                                                    SMMUTransTableInfo *tt,
> -                                                  hwaddr iova)
> +                                                  hwaddr iova,
> +                                                  SMMUSecSID sec_sid)
>  {
>      uint8_t tg = (tt->granule_sz - 10) / 2;
>      uint8_t inputsize = 64 - tt->tsz;
> @@ -140,7 +142,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>          SMMUIOTLBKey key;
>  
>          key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
> -                                 iova & ~mask, tg, level);
> +                                 iova & ~mask, tg, level, sec_sid);
>          entry = g_hash_table_lookup(bs->iotlb, &key);
>          if (entry) {
>              break;
> @@ -156,6 +158,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>   * @cfg: Configuration of the translation
>   * @tt: Translation table info (granule and tsz)
>   * @iova: IOVA address to lookup
> + * @sec_sid: StreamID Security state
>   *
>   * returns a valid entry on success, otherwise NULL.
>   * In case of nested translation, tt can be updated to include
> @@ -163,11 +166,12 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>   * the IOVA granule.
>   */
>  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                SMMUTransTableInfo *tt, hwaddr iova)
> +                                SMMUTransTableInfo *tt, hwaddr iova,
> +                                SMMUSecSID sec_sid)
>  {
>      SMMUTLBEntry *entry = NULL;
>  
> -    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova, sec_sid);
>      /*
>       * For nested translation also try the s2 granule, as the TLB will insert
>       * it if the size of s2 tlb entry was smaller.
> @@ -175,18 +179,20 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>      if (!entry && (cfg->stage == SMMU_NESTED) &&
>          (cfg->s2cfg.granule_sz != tt->granule_sz)) {
>          tt->granule_sz = cfg->s2cfg.granule_sz;
> -        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova, sec_sid);
>      }
>  
>      if (entry) {
>          cfg->iotlb_hits++;
> -        trace_smmu_iotlb_lookup_hit(cfg->asid, cfg->s2cfg.vmid, iova,
> +        trace_smmu_iotlb_lookup_hit(sec_sid, cfg->asid,
> +                                    cfg->s2cfg.vmid, iova,
>                                      cfg->iotlb_hits, cfg->iotlb_misses,
>                                      100 * cfg->iotlb_hits /
>                                      (cfg->iotlb_hits + cfg->iotlb_misses));
>      } else {
>          cfg->iotlb_misses++;
> -        trace_smmu_iotlb_lookup_miss(cfg->asid, cfg->s2cfg.vmid, iova,
> +        trace_smmu_iotlb_lookup_miss(sec_sid, cfg->asid,
> +                                     cfg->s2cfg.vmid, iova,
>                                       cfg->iotlb_hits, cfg->iotlb_misses,
>                                       100 * cfg->iotlb_hits /
>                                       (cfg->iotlb_hits + cfg->iotlb_misses));
> @@ -194,7 +200,8 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>      return entry;
>  }
>  
> -void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
> +void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new,
> +                       SMMUSecSID sec_sid)
>  {
>      SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
>      uint8_t tg = (new->granule - 10) / 2;
> @@ -204,9 +211,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>      }
>  
>      *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> -                              tg, new->level);
> -    trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> -                            tg, new->level);
> +                              tg, new->level, sec_sid);
> +    trace_smmu_iotlb_insert(sec_sid, cfg->asid, cfg->s2cfg.vmid,
> +                            new->entry.iova, tg, new->level);
>      g_hash_table_insert(bs->iotlb, key, new);
>  }
>  
> @@ -223,26 +230,29 @@ static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
>      return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
> -           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
> +           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
> +           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
>  }
>  
>  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>                                           gpointer user_data)
>  {
> -    int vmid = *(int *)user_data;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
> -    return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
> +    return (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
> +           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
>  }
>  
>  static gboolean smmu_hash_remove_by_vmid_s1(gpointer key, gpointer value,
>                                              gpointer user_data)
>  {
> -    int vmid = *(int *)user_data;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
> -    return (SMMU_IOTLB_VMID(*iotlb_key) == vmid) &&
> -           (SMMU_IOTLB_ASID(*iotlb_key) >= 0);
> +    return (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
> +           (SMMU_IOTLB_ASID(*iotlb_key) >= 0) &&
> +           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
>  }
>  
>  static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
> @@ -259,6 +269,9 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
>      if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
>          return false;
>      }
> +    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
> +        return false;
> +    }
>      return ((info->iova & ~entry->addr_mask) == entry->iova) ||
>             ((entry->iova & ~info->mask) == info->iova);
>  }
> @@ -278,6 +291,9 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
>      if (info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
>          return false;
>      }
> +    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
> +        return false;
> +    }
>      return ((info->iova & ~entry->addr_mask) == entry->iova) ||
>             ((entry->iova & ~info->mask) == info->iova);
>  }
> @@ -323,13 +339,17 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
>  }
>  
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> +                         SMMUSecSID sec_sid)
>  {
>      /* if tg is not set we use 4KB range invalidation */
>      uint8_t granule = tg ? tg * 2 + 10 : 12;
>  
> +    trace_smmu_iotlb_inv_iova(sec_sid, asid, iova);
> +
>      if (ttl && (num_pages == 1) && (asid >= 0)) {
> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova,
> +                                              tg, ttl, sec_sid);
>  
>          if (g_hash_table_remove(s->iotlb, &key)) {
>              return;
> @@ -343,7 +363,8 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>      SMMUIOTLBPageInvInfo info = {
>          .asid = asid, .iova = iova,
>          .vmid = vmid,
> -        .mask = (num_pages * 1 << granule) - 1};
> +        .mask = (num_pages * 1 << granule) - 1,
> +        .sec_sid = sec_sid};
>  
>      g_hash_table_foreach_remove(s->iotlb,
>                                  smmu_hash_remove_by_asid_vmid_iova,
> @@ -355,13 +376,15 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>   * in Stage-1 invalidation ASID = -1, means don't care.
>   */
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> -                        uint64_t num_pages, uint8_t ttl)
> +                        uint64_t num_pages, uint8_t ttl,
> +                        SMMUSecSID sec_sid)
>  {
>      uint8_t granule = tg ? tg * 2 + 10 : 12;
>      int asid = -1;
>  
>     if (ttl && (num_pages == 1)) {
> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa,
> +                                              tg, ttl, sec_sid);
>  
>          if (g_hash_table_remove(s->iotlb, &key)) {
>              return;
> @@ -371,34 +394,47 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>      SMMUIOTLBPageInvInfo info = {
>          .iova = ipa,
>          .vmid = vmid,
> -        .mask = (num_pages << granule) - 1};
> +        .mask = (num_pages << granule) - 1,
> +        .sec_sid = sec_sid};
>  
>      g_hash_table_foreach_remove(s->iotlb,
>                                  smmu_hash_remove_by_vmid_ipa,
>                                  &info);
>  }
>  
> -void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
> +                              SMMUSecSID sec_sid)
>  {
>      SMMUIOTLBPageInvInfo info = {
>          .asid = asid,
>          .vmid = vmid,
> +        .sec_sid = sec_sid,
>      };
>  
> -    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
> +    trace_smmu_iotlb_inv_asid_vmid(sec_sid, asid, vmid);
>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
>  }
>  
> -void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid)
>  {
> -    trace_smmu_iotlb_inv_vmid(vmid);
> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
> +    SMMUIOTLBPageInvInfo info = {
> +        .vmid = vmid,
> +        .sec_sid = sec_sid,
> +    };
> +
> +    trace_smmu_iotlb_inv_vmid(sec_sid, vmid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &info);
>  }
>  
> -void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid, SMMUSecSID sec_sid)
>  {
> -    trace_smmu_iotlb_inv_vmid_s1(vmid);
> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
> +    SMMUIOTLBPageInvInfo info = {
> +        .vmid = vmid,
> +        .sec_sid = sec_sid,
> +    };
> +
> +    trace_smmu_iotlb_inv_vmid_s1(sec_sid, vmid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &info);
>  }
>  
>  /* VMSAv8-64 Translation */
> @@ -919,7 +955,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>          tt_combined.tsz = tt->tsz;
>      }
>  
> -    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr);
> +    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr, sec_sid);
>      if (cached_entry) {
>          if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
>              cached_entry->parent_perm & IOMMU_WO)) {
> @@ -938,7 +974,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>              g_free(cached_entry);
>              return NULL;
>      }
> -    smmu_iotlb_insert(bs, cfg, cached_entry);
> +    smmu_iotlb_insert(bs, cfg, cached_entry, sec_sid);
>      return cached_entry;
>  }
>  
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index 004abd58bca..ce68d4b5813 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -144,12 +144,14 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
>  
>  #define SMMU_IOTLB_ASID(key) ((key).asid)
>  #define SMMU_IOTLB_VMID(key) ((key).vmid)
> +#define SMMU_IOTLB_SEC_SID(key) ((key).sec_sid)
>  
>  typedef struct SMMUIOTLBPageInvInfo {
>      int asid;
>      int vmid;
>      uint64_t iova;
>      uint64_t mask;
> +    SMMUSecSID sec_sid;
>  } SMMUIOTLBPageInvInfo;
>  
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index cc5d3ab696c..087112ba4b6 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -634,6 +634,17 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>          goto bad_ste;
>      }
>  
> +    /*
> +     * Keep the SEC_SID-to-StreamWorld approximation used by the IOTLB key
> +     * one-to-one until the other Secure translation regimes are modeled.
> +     */
> +    if (sec_sid == SMMU_SEC_SID_S && STE_CFG_S1_TRANSLATE(config) &&
> +        STE_STRW(ste) != 0) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "SMMUv3 Secure StreamWorld is not implemented\n");
> +        goto bad_ste;
> +    }
> +
>      if (STAGE2_SUPPORTED(s)) {
>          /* VMID is considered even if s2 is disabled. */
>          cfg->s2cfg.vmid = STE_S2VMID(ste);
> @@ -1317,7 +1328,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>      }
>  }
>  
> -static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
> +                               SMMUSecSID sec_sid)
>  {
>      dma_addr_t end, addr = CMD_ADDR(cmd);
>      uint8_t type = CMD_TYPE(cmd);
> @@ -1342,12 +1354,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>      }
>  
>      if (!tg) {
> -        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> +        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
> +                                 tg, 1, ttl, leaf, stage);
>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>          if (stage == SMMU_STAGE_1) {
> -            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
>          } else {
> -            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl, sec_sid);
>          }
>          return;
>      }
> @@ -1364,13 +1377,15 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>          uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
>  
>          num_pages = (mask + 1) >> granule;
> -        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
> -                                 ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
> +        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
> +                                 num_pages, ttl, leaf, stage);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
> +                                  num_pages, stage);
>          if (stage == SMMU_STAGE_1) {
> -            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
> +                                num_pages, ttl, sec_sid);
>          } else {
> -            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl);
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl, sec_sid);
>          }
>          addr += mask + 1;
>      }
> @@ -1521,9 +1536,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>                  vmid = CMD_VMID(&cmd);
>              }
>  
> -            trace_smmuv3_cmdq_tlbi_nh_asid(asid);
> +            trace_smmuv3_cmdq_tlbi_nh_asid(sec_sid, asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
> +            smmu_iotlb_inv_asid_vmid(bs, asid, vmid, sec_sid);
>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
> @@ -1545,8 +1560,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               */
>              if (STAGE2_SUPPORTED(s)) {
>                  vmid = CMD_VMID(&cmd);
> -                trace_smmuv3_cmdq_tlbi_nh(vmid);
> -                smmu_iotlb_inv_vmid_s1(bs, vmid);
> +                trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
> +                smmu_iotlb_inv_vmid_s1(bs, vmid, sec_sid);
>                  break;
>              }
>              QEMU_FALLTHROUGH;
> @@ -1566,7 +1581,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
> @@ -1583,7 +1598,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>  
>              trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_vmid(bs, vmid);
> +            smmu_iotlb_inv_vmid(bs, vmid, SMMU_SEC_SID_NS);
>              break;
>          }
>          case SMMU_CMD_TLBI_S2_IPA:
> @@ -1595,7 +1610,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               * As currently only either s1 or s2 are supported
>               * we can reuse same function for s2.
>               */
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
>              break;
>          case SMMU_CMD_ATC_INV:
>          {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index a166b79c8ef..6a8716e8041 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -19,16 +19,16 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
>  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
>  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> -smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
> -smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
> -smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
> -smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> +smmu_iotlb_inv_asid_vmid(int sec_sid, int asid, int vmid) "IOTLB invalidate sec_sid=%d asid=%d vmid=%d"
> +smmu_iotlb_inv_vmid(int sec_sid, int vmid) "IOTLB invalidate sec_sid=%d vmid=%d"
> +smmu_iotlb_inv_vmid_s1(int sec_sid, int vmid) "IOTLB invalidate S1 sec_sid=%d vmid=%d"
> +smmu_iotlb_inv_iova(int sec_sid, int asid, uint64_t addr) "IOTLB invalidate sec_sid=%d asid=%d addr=0x%"PRIx64
>  smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
>  smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> -smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> -smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> -smmu_iotlb_insert(int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
> +smmu_iotlb_lookup_hit(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> +smmu_iotlb_lookup_miss(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> +smmu_iotlb_insert(int sec_sid, int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
>  
>  # smmuv3.c
>  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
> @@ -57,10 +57,10 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
>  smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
>  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> -smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> -smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
> +smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> +smmuv3_cmdq_tlbi_nh(int sec_sid, int vmid) "sec_sid=%d vmid=%d"
>  smmuv3_cmdq_tlbi_nsnh(void) ""
> -smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
> +smmuv3_cmdq_tlbi_nh_asid(int sec_sid, int asid) "sec_sid=%d asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 0c5718ea684..8e971c28093 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -152,6 +152,17 @@ typedef struct SMMUIOTLBKey {
>      int vmid;
>      uint8_t tg;
>      uint8_t level;
> +    /*
> +     * We currently model one StreamWorld per SEC_SID, giving the approximate
> +     * mapping:
> +     *
> +     *   SMMU_SEC_SID_NS -> NS-EL1
> +     *   SMMU_SEC_SID_S  -> Secure
> +     *
> +     * SEC_SID is not architecturally equivalent to StreamWorld. Extend this
> +     * key when additional translation regimes are implemented.
> +     */
> +    SMMUSecSID sec_sid;
>  } SMMUIOTLBKey;
>  
>  typedef struct SMMUConfigKey {
> @@ -250,19 +261,24 @@ SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid);
>  #define SMMU_IOTLB_MAX_SIZE 256
>  
>  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                SMMUTransTableInfo *tt, hwaddr iova);
> -void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> +                                SMMUTransTableInfo *tt, hwaddr iova,
> +                                SMMUSecSID sec_sid);
> +void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry,
> +                       SMMUSecSID sec_sid);
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> -                                uint8_t tg, uint8_t level);
> +                                uint8_t tg, uint8_t level, SMMUSecSID sec_sid);
>  SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_all(SMMUState *s);
> -void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
> -void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> -void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
> +                              SMMUSecSID sec_sid);
> +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid);
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> +                         SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> -                        uint64_t num_pages, uint8_t ttl);
> +                        uint64_t num_pages, uint8_t ttl,
> +                        SMMUSecSID sec_sid);
>  void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
>  void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
> -- 
> 2.34.1
> 

