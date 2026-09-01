Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C79FC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1P11-0000E1-2H; Tue, 01 Sep 2026 09:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1P0y-0000CY-NT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:59:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1P0w-0003Q4-8l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:59:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49ccf12bed0so42795e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788271140; x=1788875940; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lCJmQOLwToA27ztd3sXDRNZbULBQnYZKqLk0fQ20TTo=;
 b=a0yFwKZCK89uaXMWHH9rjR2cHqf3NfupVtrXWRgsYt0WQ1ZPgxYV8XgU+w9ztMQMVf
 i8QY923+VM7QNcF7WGm1vdUgVVqi5ykw6JdMEXt8/FmOIfTjCVhabfwoPvDDySadqVqp
 muU29Bw7TOjOszZgsttFFtba/D5wU4jUwrQCT6tNgdv862KrOaGvMBL2OgbVBc3ecHfv
 ssn/HG4zEzVc7povEL+jQduItbpHtQnowipJqcFdrzbwvXVhGU2dWq4TU3xiUKWGzryQ
 Qq/+xy74NtT3IbIU1eIjOGg7/FgBJAvuZCvX3kW9wD2XqC9raYJNojQ9h10IXOF4u78N
 nVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271140; x=1788875940;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lCJmQOLwToA27ztd3sXDRNZbULBQnYZKqLk0fQ20TTo=;
 b=k7Ch4GhmqSuHExJfYq78irXfQ3XyckT/6at75HGyFI71IvDBD0tx/v+QU4jBGkHEgX
 TGsW9zeEJj54SLxtNDABlIahkLLTmM6NcXRWcirrFWwYYgyxgAdslV3q48hsvezbnzjv
 I/bXJ1ZlA85pVXtbNwxVGS1gOcnCkblxHGHU9m5y3Z8dDP60UNQkVXRceoAWOfxf5h8F
 beI45Hvqe/FvXEUNJBPZ+LzuflHGSu/NS7u5P6jeHfju9hbne3uhUzKBSBotIuefpCCC
 QHgsqZcbLxSpk3+KewBHSrdo8blUaXogojfGr+p5ujwJiO+h0ftlwMBQzU1DIZHzC+og
 c1yA==
X-Forwarded-Encrypted: i=1;
 AHgh+RopcE4760AS0obnj4pF1CiXm5Sr7EuOqaydnzOoccEzlctvYzTHOKkEjyNRY290NhIcJoGd9ZpVzwvf@nongnu.org
X-Gm-Message-State: AFuF++lOQCVGP1nmXizZwXN/SV9o1ZYPWqEKitUH0enfwkgAuxQhT3+e
 jpBsx4Ko6G/Cq/hlnGKD0sMLzw420llcRNBYJgyJGQLrGO43baHeET8az8jLwsw9mg==
X-Gm-Gg: AR+sD10M62fjo4PAi9+A072XJ6XlNfDZnUYQ1BSwPXKbdOpaKXi3KOxTyzg+wNQE0cT
 Qvf8cd6eXNyYMQ9CMpY1OLOtLkYdcHlUvmm0aGqS8igWFp8gkOSIVZHq/tS2fJB9WwjZeYvFYG9
 IG3manHfNxwnydIgpW3eICmCuRYtOwD7M125mHDRHHZcrVpRnykm9YQTWDh9Z7uUMoDiuUQ60YG
 sKVXRiee7aNt0EaTB6l7On9EhjSewG+T44KZukj11LhwzwIp2hfKT7NmnAmaVq+vFeziYU8Nuuw
 7ANLuTl4OVqKWTbMUtaOOVpR1OHwGNInOb02DvWXyZ76mriN4PXLQL1GRgHr9ixlLXum9t5vVAs
 hU0XeVpE55VnrEuA/Sr6ft0ppMKJ79OdfrekLNj/J75iXgZ5yBYIwgM7VpU3voF9Q8gBqLecz4Q
 2OeOzuEJKoToFfIgkUX4rT0pzxkWuwZ5Me13kZoRah45oWYhDaqs4rB/X16sMjf/Mf7xbGSiakf
 wBOgmKHerdUKyiSfZ7oaceouFP44ttSGvfs1vC+
X-Received: by 2002:a05:600c:8587:b0:499:a6a5:a687 with SMTP id
 5b1f17b1804b1-49cdd106630mr855055e9.0.1788271139769; 
 Tue, 01 Sep 2026 06:58:59 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce164bcsm67109175e9.7.2026.09.01.06.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:58:58 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:58:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 06/28] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
Message-ID: <apbaH93DHhCUx4K0@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162446.2806393-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=smostafa@google.com; helo=mail-wm1-x332.google.com
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

On Fri, Aug 14, 2026 at 12:24:42AM +0800, Tao Tang wrote:
> Introduce helpers that derive MemTxAttrs and select an AddressSpace from
> SEC_SID, then pass SEC_SID through the Stream Table and Context Descriptor
> fetch paths. This makes reads of SMMU configuration structures use the
> corresponding Non-secure or Secure memory context.
> 
> To support these helpers, include hw/arm/arm-security.h from smmu-common.h,
> making the Arm security-space definitions available to the common SMMU code.
> 
> The accelerated path remains Non-secure-only and therefore passes
> SMMU_SEC_SID_NS explicitly.
> 
> For now, the configuration cache lookup key remains based solely on the
> SMMUDevice pointer. It is extended with SEC_SID in a later commit. Other
> SEC_SID-sensitive memory accesses that still use the Non-secure address
> space are converted in follow-up commits.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 30 +++++++++++++++++++++----
>  hw/arm/smmuv3-accel.c        |  2 +-
>  hw/arm/smmuv3-internal.h     |  3 ++-
>  hw/arm/smmuv3.c              | 43 ++++++++++++++++++++++--------------
>  include/hw/arm/smmu-common.h | 10 +++++++++
>  5 files changed, 65 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 54a6a9f4d62..89e1e2826d4 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,27 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
> +{
> +    switch (sec_sid) {
> +    case SMMU_SEC_SID_S:
> +        return ARMSS_Secure;
> +    case SMMU_SEC_SID_NS:
> +        return ARMSS_NonSecure;
> +    case SMMU_SEC_SID_NUM:
> +        g_assert_not_reached();
> +    }
> +    g_assert_not_reached();
> +}
> +
> +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid)
> +{
> +    return (MemTxAttrs) {
> +        .secure = smmu_sec_sid_is_secure(sec_sid) ? 1 : 0,
> +        .space = smmu_get_security_space(sec_sid),
> +    };
> +}
> +

So that would be used instead of MEMTXATTRS_UNSPECIFIED previously
used. I am not sure if some other fields need to be set also as
memory, requester_id, address_type?

If not, maybe it is worth adding a comment.

Thanks,
Mostafa

>  AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
>  {
>      switch (sec_sid) {
> @@ -588,6 +609,7 @@ error:
>  /**
>   * smmu_ptw_64_s2 - VMSAv8-64 Walk of the page tables for a given ipa
>   * for stage-2.
> + * @bs: smmu state which includes TLB instance
>   * @cfg: translation config
>   * @ipa: ipa to translate
>   * @perm: access type
> @@ -599,7 +621,7 @@ error:
>   * Upon success, @tlbe is filled with translated_addr and entry
>   * permission rights.
>   */
> -static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> +static int smmu_ptw_64_s2(SMMUState *bs, SMMUTransCfg *cfg,
>                            dma_addr_t ipa, IOMMUAccessFlags perm,
>                            SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>  {
> @@ -636,7 +658,6 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>          uint64_t pte, gpa;
>          dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>          uint8_t s2ap;
> -
>          if (get_pte(baseaddr, offset, &pte, info)) {
>                  goto error;
>          }
> @@ -690,6 +711,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>              goto error_ipa;
>          }
>  
> +        tlbe->entry.target_as = &bs->memory_as;
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = ipa & ~mask;
>          tlbe->entry.addr_mask = mask;
> @@ -765,7 +787,7 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>              return -EINVAL;
>          }
>  
> -        return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
> +        return smmu_ptw_64_s2(bs, cfg, iova, perm, tlbe, info);
>      }
>  
>      /* SMMU_NESTED. */
> @@ -775,7 +797,7 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>      }
>  
>      ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
> -    ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
> +    ret = smmu_ptw_64_s2(bs, cfg, ipa, perm, &tlbe_s2, info);
>      if (ret) {
>          return ret;
>      }
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 2ce94786829..9d207acc8e3 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -310,7 +310,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>          return false;
>      }
>  
> -    if (smmu_find_ste(sdev->smmu, sid, &ste, &event)) {
> +    if (smmu_find_ste(sdev->smmu, sid, &ste, &event, sec_sid)) {
>          /* No STE found, nothing to install */
>          return true;
>      }
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 202cd533636..1f2f426da01 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -367,7 +367,8 @@ typedef struct SMMUEventInfo {
>  
>  void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
>  void smmuv3_propagate_event(SMMUv3State *s, Evt *evt, SMMUSecSID sec_sid);
> -int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event,
> +                  SMMUSecSID sec_sid);
>  
>  #define STE_SIZE 6
>  #define L1STD_SIZE 3
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 649050b9347..b5dc67dcb01 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -366,14 +366,15 @@ static void smmuv3_reset(SMMUv3State *s)
>  }
>  
>  static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> -                        SMMUEventInfo *event)
> +                        SMMUEventInfo *event, SMMUSecSID sec_sid)
>  {
> +    AddressSpace *as = smmu_get_address_space(ARM_SMMU(s), sec_sid);
> +    MemTxAttrs txattrs = smmu_get_txattrs(sec_sid);
>      int ret, i;
>  
>      trace_smmuv3_get_ste(addr);
>      /* TODO: guarantee 64-bit single-copy atomicity */
> -    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(as, addr, buf, sizeof(*buf), txattrs);
>      if (ret != MEMTX_OK) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
> @@ -396,12 +397,15 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUTranslationClass class);
>  /* @ssid > 0 not supported yet */
>  static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
> -                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
> +                       uint32_t ssid, CD *buf, SMMUEventInfo *event,
> +                       SMMUSecSID sec_sid)
>  {
>      dma_addr_t addr = STE_CTXPTR(ste);
>      int ret, i;
>      SMMUTranslationStatus status;
>      SMMUTLBEntry *entry;
> +    AddressSpace *as;
> +    MemTxAttrs txattrs;
>  
>      trace_smmuv3_get_cd(addr);
>  
> @@ -417,9 +421,10 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>          addr = CACHED_ENTRY_TO_ADDR(entry, addr);
>      }
>  
> +    as = smmu_get_address_space(ARM_SMMU(s), sec_sid);
> +    txattrs = smmu_get_txattrs(sec_sid);
>      /* TODO: guarantee 64-bit single-copy atomicity */
> -    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(as, addr, buf, sizeof(*buf), txattrs);
>      if (ret != MEMTX_OK) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
> @@ -680,18 +685,21 @@ bad_ste:
>   * @sid: stream ID
>   * @ste: returned stream table entry
>   * @event: handle to an event info
> + * @sec_sid: StreamID Security state
>   *
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
> -int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event,
> +                  SMMUSecSID sec_sid)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
>      int strtab_size;
>      int ret;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
> +    AddressSpace *as = smmu_get_address_space(ARM_SMMU(s), sec_sid);
> +    MemTxAttrs txattrs = smmu_get_txattrs(sec_sid);
>  
>      trace_smmuv3_find_ste(sid, bank->features, bank->sid_split);
>      log2size = FIELD_EX32(bank->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
> @@ -718,8 +726,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>          l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
>          l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
>          /* TODO: guarantee 64-bit single-copy atomicity */
> -        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
> -                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
> +        ret = dma_memory_read(as, l1ptr, &l1std, sizeof(l1std), txattrs);
>          if (ret != MEMTX_OK) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
> @@ -773,7 +780,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>          addr = strtab_base + sid * sizeof(*ste);
>      }
>  
> -    if (smmu_get_ste(s, addr, ste, event)) {
> +    if (smmu_get_ste(s, addr, ste, event, sec_sid)) {
>          return -EINVAL;
>      }
>  
> @@ -904,7 +911,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>      /* ASID defaults to -1 (if s1 is not supported). */
>      cfg->asid = -1;
>  
> -    ret = smmu_find_ste(s, sid, &ste, event);
> +    ret = smmu_find_ste(s, sid, &ste, event, sec_sid);
>      if (ret) {
>          return ret;
>      }
> @@ -918,7 +925,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>          return 0;
>      }
>  
> -    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
> +    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event, sec_sid);
>      if (ret) {
>          return ret;
>      }
> @@ -933,12 +940,14 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>   *
>   * @sdev: SMMUDevice handle
>   * @event: output event info
> + * @sec_sid: StreamID Security state
>   *
>   * The configuration cache contains data resulting from both STE and CD
>   * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
>   * by the SMMUDevice handle.
>   */
> -static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
> +static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
> +                                       SMMUSecSID sec_sid)
>  {
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
> @@ -959,7 +968,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>                              (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
>          cfg = g_new0(SMMUTransCfg, 1);
>  
> -        if (!smmuv3_decode_config(&sdev->iommu, cfg, event, SMMU_SEC_SID_NS)) {
> +        if (!smmuv3_decode_config(&sdev->iommu, cfg, event, sec_sid)) {
>              g_hash_table_insert(bc->configs, sdev, cfg);
>          } else {
>              g_free(cfg);
> @@ -1139,7 +1148,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto epilogue;
>      }
>  
> -    cfg = smmuv3_get_config(sdev, &event);
> +    cfg = smmuv3_get_config(sdev, &event, sec_sid);
>      if (!cfg) {
>          status = SMMU_TRANS_ERROR;
>          goto epilogue;
> @@ -1221,7 +1230,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>      SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>                                 .inval_ste_allowed = true};
> -    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
> +    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
>      IOMMUTLBEvent event;
>      uint8_t granule;
>  
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 9d6e2d3038f..a31ffcf6e71 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -22,6 +22,7 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/pci/pci.h"
>  #include "qom/object.h"
> +#include "hw/arm/arm-security.h"
>  
>  #define SMMU_PCI_BUS_MAX                    256
>  #define SMMU_PCI_DEVFN_MAX                  256
> @@ -47,6 +48,9 @@ typedef enum SMMUSecSID {
>      SMMU_SEC_SID_NUM,
>  } SMMUSecSID;
>  
> +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid);
> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid);
> +
>  /*
>   * Page table walk error types
>   */
> @@ -200,6 +204,12 @@ SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
>  /* Initialize SMMUDevice handle associated to a SMMUPciBus */
>  void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
>  
> +
> +static inline bool smmu_sec_sid_is_secure(SMMUSecSID sec_sid)
> +{
> +    return sec_sid == SMMU_SEC_SID_S;
> +}
> +
>  /* Return the stream ID of an SMMU device */
>  static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>  {
> -- 
> 2.34.1
> 

