Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCF9E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 11:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWa4m-0001Y9-6p; Sat, 11 Jan 2025 06:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tWa4j-0001Xp-FD
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 06:54:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tWa4g-0007Ab-Fy
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 06:54:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-219f8263ae0so47305455ad.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 03:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736596475; x=1737201275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cI0z9IzUCWsMkN+ec+CPAaCpQCBa9UeIdw665t3oq8A=;
 b=OnpR0YnLJIaWoB1KGRORaepv4ms2NiXHPMS0mTrco+9D4BpqOVqOwJcqKDvjjqbhJl
 B4mSE4pLoe2HjcFjJq7qbWYykfJsMSIsjkWhQbSOHH0CtDytI1pf9aFbR2vRJ849KAU7
 bfms0hHpX5Sb+C5SPlgCmuVqHVHk2xoEZbUxUl2nRpUoQHYeYCWhhboYhpbFK0KwCmJi
 AKNq+4j/sA9uE462fqrbeITlAsXBMBnd73S7RjLT0kok0TQcs8ay81Xd6GHTX54s8YRD
 0aHkqO5upmcVoQwGzAKMdgu2Xi0iQpjA8OjUtUHleWfSIyHzJNCB03jiGh0ka8NqRgU4
 XK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736596475; x=1737201275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cI0z9IzUCWsMkN+ec+CPAaCpQCBa9UeIdw665t3oq8A=;
 b=pX3enU7E3wnSt9bgxyRRdTecvZqV7z21hHPnsh2hxqY/4D6UH0YG8bR5KHE9/6ZNdS
 uwobZf9yQcxLVpc8L5CvO2CfHiL+AFxAgc/ROfURiJkOLHjN+gveX7aXjYuWviWXt+ng
 WXVQnlfIX3mElVAeYq+HIp1ZI7ExcaUJoIQ61LYsbJ58avDleJ483IseJMB5TRWVsMjK
 /eCw6iaS2Foy0289NRKU4RXjOx+FAKHrmEHkybQ6B+2DmICij0BNIewz5X0k7GtVMyDg
 obotN3xsGmh7rDjy65of2N7fN/c8MbKYTvk/YFhyC2oBNliX2EhICoaJpOHomkADaY8K
 4uVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYwNhGErL/Ywf4AWGTe7tpxv2HamNfJ1rosiGvqSxRVlH5uAu45kP1YB2I8k4/4/MQOWXHx36eXFhy@nongnu.org
X-Gm-Message-State: AOJu0Yza7kc8fy+3pxiWmURtwjKfNMJepjHeNwanOL8TWTZ+UxrNppjr
 ASvMvFbI2CPgX29j+pfaOg8Bc1ep4dyqASShYC5CPA9men7rh/XhlvwRtWdQTik=
X-Gm-Gg: ASbGncs4AzYcDptQnN49CB3zd4+SvfwXXe7kvr0EMHkuzYF27l6YUj1pNoSkdguTSdV
 bRsIAhrvQBh0xjcS9HnMVb344oAKx3bNyyDTrbwEGUbR4cMgvd3GjhGY6KBf7XbAGzIKeq6oXK3
 6Nq70RtEuoGER1lb/spcFEgzRPgrG87w0sRz5bGAA0Uz1N/cUpFsdM53i4tWjJbLhPYLkohA5nK
 ncrla3eItgh3ChXvlcW20ndVSrNq7cO3PHCTV0NT72GfhSBWaDH+foUkxOuOfSIm55bnGqY
X-Google-Smtp-Source: AGHT+IFTJZ2uYprBv+rTFUCxZ6rXDyqu5KK/Z/mM4rUlJYgM2MzgZD+XvZeFSiWtxcixV+NGSY7dFQ==
X-Received: by 2002:a17:902:f551:b0:216:2dc4:50ab with SMTP id
 d9443c01a7336-21a83f42821mr187754065ad.2.1736596475067; 
 Sat, 11 Jan 2025 03:54:35 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22c99csm26409785ad.164.2025.01.11.03.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jan 2025 03:54:34 -0800 (PST)
Message-ID: <3a3552e5-c346-470e-a9de-86bd24cc4898@ventanamicro.com>
Date: Sat, 11 Jan 2025 08:54:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: Introduce a translation tag for
 the page table cache
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241108110147.11178-1-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108110147.11178-1-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/8/24 8:01 AM, Jason Chien wrote:
> This commit introduces a translation tag to avoid invalidating an entry
> that should not be invalidated when IOMMU executes invalidation commands.
> E.g. IOTINVAL.VMA with GV=0, AV=0, PSCV=1 invalidates both a mapping
> of single stage translation and a mapping of nested translation with
> the same PSCID, but only the former one should be invalidated.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu.c | 205 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 153 insertions(+), 52 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index ff9deefe37..ac6bbf91d6 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -64,8 +64,16 @@ struct RISCVIOMMUContext {
>       uint64_t msiptp;            /* MSI redirection page table pointer */
>   };
>   
> +typedef enum RISCVIOMMUTransTag {
> +    RISCV_IOMMU_TRANS_TAG_BY,  /* Bypass */
> +    RISCV_IOMMU_TRANS_TAG_SS,  /* Single Stage */
> +    RISCV_IOMMU_TRANS_TAG_VG,  /* G-stage only */
> +    RISCV_IOMMU_TRANS_TAG_VN,  /* Nested translation */
> +} RISCVIOMMUTransTag;
> +
>   /* Address translation cache entry */
>   struct RISCVIOMMUEntry {
> +    RISCVIOMMUTransTag tag;     /* Translation Tag */
>       uint64_t iova:44;           /* IOVA Page Number */
>       uint64_t pscid:20;          /* Process Soft-Context identifier */
>       uint64_t phys:44;           /* Physical Page Number */
> @@ -1228,7 +1236,7 @@ static gboolean riscv_iommu_iot_equal(gconstpointer v1, gconstpointer v2)
>       RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
>       RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
>       return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
> -           t1->iova == t2->iova;
> +           t1->iova == t2->iova && t1->tag == t2->tag;
>   }
>   
>   static guint riscv_iommu_iot_hash(gconstpointer v)
> @@ -1237,67 +1245,115 @@ static guint riscv_iommu_iot_hash(gconstpointer v)
>       return (guint)t->iova;
>   }
>   
> -/* GV: 1 PSCV: 1 AV: 1 */
> +/* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */
> +/* GV: 0 AV: 0 GVMA: 1 */
> +static
> +void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> +    if (iot->tag == arg->tag) {
> +        iot->perm = IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */
> +static
> +void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> +    if (iot->tag == arg->tag &&
> +        iot->pscid == arg->pscid) {
> +        iot->perm = IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */
> +static
> +void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> +    if (iot->tag == arg->tag &&
> +        iot->iova == arg->iova) {
> +        iot->perm = IOMMU_NONE;
> +    }
> +}
> +
> +/* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */
>   static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer value,
>                                                gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->gscid == arg->gscid &&
> +    if (iot->tag == arg->tag &&
>           iot->pscid == arg->pscid &&
>           iot->iova == arg->iova) {
>           iot->perm = IOMMU_NONE;
>       }
>   }
>   
> -/* GV: 1 PSCV: 1 AV: 0 */
> -static void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
> -                                        gpointer data)
> +/* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */
> +/* GV: 1 AV: 0 GVMA: 1 */
> +static
> +void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->gscid == arg->gscid &&
> -        iot->pscid == arg->pscid) {
> +    if (iot->tag == arg->tag &&
> +        iot->gscid == arg->gscid) {
>           iot->perm = IOMMU_NONE;
>       }
>   }
>   
> -/* GV: 1 GVMA: 1 */
> -static void riscv_iommu_iot_inval_gscid_gpa(gpointer key, gpointer value,
> -                                            gpointer data)
> +/* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */
> +static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer value,
> +                                              gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->gscid == arg->gscid) {
> -        /* simplified cache, no GPA matching */
> +    if (iot->tag == arg->tag &&
> +        iot->gscid == arg->gscid &&
> +        iot->pscid == arg->pscid) {
>           iot->perm = IOMMU_NONE;
>       }
>   }
>   
> -/* GV: 1 GVMA: 0 */
> -static void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
> -                                        gpointer data)
> +/* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */
> +/* GV: 1 AV: 1 GVMA: 1 */
> +static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer value,
> +                                             gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->gscid == arg->gscid) {
> +    if (iot->tag == arg->tag &&
> +        iot->gscid == arg->gscid &&
> +        iot->iova == arg->iova) {
>           iot->perm = IOMMU_NONE;
>       }
>   }
>   
> -/* GV: 0 */
> -static void riscv_iommu_iot_inval_all(gpointer key, gpointer value,
> -                                      gpointer data)
> +/* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */
> +static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointer value,
> +                                                   gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
> -    iot->perm = IOMMU_NONE;
> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> +    if (iot->tag == arg->tag &&
> +        iot->gscid == arg->gscid &&
> +        iot->pscid == arg->pscid &&
> +        iot->iova == arg->iova) {
> +        iot->perm = IOMMU_NONE;
> +    }
>   }
>   
>   /* caller should keep ref-count for iot_cache object */
>   static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
> -    GHashTable *iot_cache, hwaddr iova)
> +    GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
>   {
>       RISCVIOMMUEntry key = {
> +        .tag   = transtag,
>           .gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
>           .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
>           .iova  = PPN_DOWN(iova),
> @@ -1323,10 +1379,11 @@ static void riscv_iommu_iot_update(RISCVIOMMUState *s,
>   }
>   
>   static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
> -    uint32_t gscid, uint32_t pscid, hwaddr iova)
> +    uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
>   {
>       GHashTable *iot_cache;
>       RISCVIOMMUEntry key = {
> +        .tag = transtag,
>           .gscid = gscid,
>           .pscid = pscid,
>           .iova  = PPN_DOWN(iova),
> @@ -1337,9 +1394,24 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
>       g_hash_table_unref(iot_cache);
>   }
>   
> +static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext *ctx)
> +{
> +    uint64_t satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    uint64_t gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +
> +    if (satp == RISCV_IOMMU_DC_FSC_MODE_BARE) {
> +        return (gatp == RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
> +            RISCV_IOMMU_TRANS_TAG_BY : RISCV_IOMMU_TRANS_TAG_VG;
> +    } else {
> +        return (gatp == RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
> +            RISCV_IOMMU_TRANS_TAG_SS : RISCV_IOMMU_TRANS_TAG_VN;
> +    }
> +}
> +
>   static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       IOMMUTLBEntry *iotlb, bool enable_cache)
>   {
> +    RISCVIOMMUTransTag transtag = riscv_iommu_get_transtag(ctx);
>       RISCVIOMMUEntry *iot;
>       IOMMUAccessFlags perm;
>       bool enable_pid;
> @@ -1365,7 +1437,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           }
>       }
>   
> -    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
> +    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag);
>       perm = iot ? iot->perm : IOMMU_NONE;
>       if (perm != IOMMU_NONE) {
>           iotlb->translated_addr = PPN_PHYS(iot->phys);
> @@ -1396,6 +1468,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
>           iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
>           iot->perm = iotlb->perm;
> +        iot->tag = transtag;
>           riscv_iommu_iot_update(s, iot_cache, iot);
>       }
>   
> @@ -1603,44 +1676,72 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>   
>           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
>                                RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> -            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> +        {
> +            bool gv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
> +            bool av = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
> +            bool pscv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV);
> +            uint32_t gscid = get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> +            uint32_t pscid = get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID);
> +            hwaddr iova = (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> +
> +            if (pscv) {
>                   /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
>                   goto cmd_ill;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> -                /* invalidate all cache mappings */
> -                func = riscv_iommu_iot_inval_all;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> -                /* invalidate cache matching GSCID */
> -                func = riscv_iommu_iot_inval_gscid;
> -            } else {
> -                /* invalidate cache matching GSCID and ADDR (GPA) */
> -                func = riscv_iommu_iot_inval_gscid_gpa;
>               }
> -            riscv_iommu_iot_inval(s, func,
> -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,
> -                cmd.dword1 << 2 & TARGET_PAGE_MASK);
> +
> +            func = riscv_iommu_iot_inval_all;
> +
> +            if (gv) {
> +                func = (av) ? riscv_iommu_iot_inval_gscid_iova :
> +                              riscv_iommu_iot_inval_gscid;
> +            }
> +
> +            riscv_iommu_iot_inval(
> +                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
> +
> +            riscv_iommu_iot_inval(
> +                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
>               break;
> +        }
>   
>           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
>                                RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> -            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> -                /* invalidate all cache mappings, simplified model */
> -                func = riscv_iommu_iot_inval_all;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
> -                /* invalidate cache matching GSCID, simplified model */
> -                func = riscv_iommu_iot_inval_gscid;
> -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> -                /* invalidate cache matching GSCID and PSCID */
> -                func = riscv_iommu_iot_inval_pscid;
> +        {
> +            bool gv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
> +            bool av = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
> +            bool pscv = !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV);
> +            uint32_t gscid = get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> +            uint32_t pscid = get_field(cmd.dword0,
> +                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID);
> +            hwaddr iova = (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> +            RISCVIOMMUTransTag transtag;
> +
> +            if (gv) {
> +                transtag = RISCV_IOMMU_TRANS_TAG_VN;
> +                if (pscv) {
> +                    func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
> +                                  riscv_iommu_iot_inval_gscid_pscid;
> +                } else {
> +                    func = (av) ? riscv_iommu_iot_inval_gscid_iova :
> +                                  riscv_iommu_iot_inval_gscid;
> +                }
>               } else {
> -                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
> -                func = riscv_iommu_iot_inval_pscid_iova;
> +                transtag = RISCV_IOMMU_TRANS_TAG_SS;
> +                if (pscv) {
> +                    func = (av) ? riscv_iommu_iot_inval_pscid_iova :
> +                                  riscv_iommu_iot_inval_pscid;
> +                } else {
> +                    func = (av) ? riscv_iommu_iot_inval_iova :
> +                                  riscv_iommu_iot_inval_all;
> +                }
>               }
> -            riscv_iommu_iot_inval(s, func,
> -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
> -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
> -                cmd.dword1 << 2 & TARGET_PAGE_MASK);
> +
> +            riscv_iommu_iot_inval(s, func, gscid, pscid, iova, transtag);
>               break;
> +        }
>   
>           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
>                                RISCV_IOMMU_CMD_IODIR_OPCODE):


