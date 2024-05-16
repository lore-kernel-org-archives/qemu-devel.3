Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B258DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 21:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ivA-0007sH-Dw; Thu, 16 May 2024 17:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7iv8-0007qs-GU
 for qemu-devel@nongnu.org; Thu, 16 May 2024 17:45:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7iv6-0003dT-A8
 for qemu-devel@nongnu.org; Thu, 16 May 2024 17:45:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso154275ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715895946; x=1716500746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sw193o8Giu5b5jHKjDP64wHh/6z2KFxRHk+32nQYCBg=;
 b=LEBJmAjTFf8iN0SYDp20ULAXd/Vqp2adsd2IU2VOXuaVqIIl9hXp96TGgF4gB4MFjr
 +ZN1WmqkluLjjwvHpDKm0aMhPMWlmK/9P+TPC67ZLOhd8PxIpYzoFjfKa36g1OpwExAG
 QDOoNzfTqW2nZahKyCtODB9Xaf0nTeQCOqD2BDpPoV2rA4PykweX3ap/kJX6d7/2ZTch
 mTPWBPjwHDhlWj4F+Vg85E8Qf9YC09EfgX1DYRKeWqpMUFiRi0p+Kj3gZO2ylszW9/wx
 t6q2ooKq5G4sxx4x01srIAeDmCMdNg8VqSOURkwnrRnvQF72TKDy7aORxC/Jd0dft71O
 x13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715895946; x=1716500746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sw193o8Giu5b5jHKjDP64wHh/6z2KFxRHk+32nQYCBg=;
 b=aM+m23+bBicw6rcEmDV0SjMQUcSe1MdV6wKjP6+kGK8fP8hHTQfqHxXtsBn7ov9RNO
 qyb+Mn/rm0feOsAaOB4/67VYU5UAJmW6LcC5+JCnmNWqA24GfUynTpjVwKDV+YSX2bXd
 1+N/WEWAls72Nxgt8mLLedsIdMH91ZxH2STRUM8hdalEbS+74MRaArQkkfAkaHa6r07d
 /9A8s61cTbkr5siUSq3oFiQmuEpOFm79kYIOqiHpfqKwWMhyum/lYlJktst5dLkhVP0X
 3Aly+iS5vtchkDztM+hFh8/GcKisRHOt7+KYJq60/AJwM8RRsttD0UrV/MxMMIZzakoC
 gwJw==
X-Gm-Message-State: AOJu0YwbfXX9Ic89/yVbNpG8YbZu2+SE0TLvRA3iNOKaxX4wwaBJ4aw6
 kSVGcYeLBCoJ2tX9UBsWNajSx9UbpC/6osRD5dGbGkNY2zvqv3NODpEXxlVZx38=
X-Google-Smtp-Source: AGHT+IF5QCJMzPuU+bOPNyFBPvUO9neoJZVpeNcflIMfhu8QChIgbNA6YPhOWhNJSA0dsxtNATd27w==
X-Received: by 2002:a17:902:b495:b0:1e9:470:87e6 with SMTP id
 d9443c01a7336-1ef43d1853emr207865015ad.23.1715895946602; 
 Thu, 16 May 2024 14:45:46 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c0355fasm143108355ad.186.2024.05.16.14.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 14:45:46 -0700 (PDT)
Message-ID: <78d179f3-fe8d-45dc-b779-3310e47cea2c@ventanamicro.com>
Date: Thu, 16 May 2024 18:45:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] hw/riscv/riscv-iommu: add Address Translation
 Cache (IOATC)
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-9-dbarboza@ventanamicro.com>
 <CANzO1D1hKidUTKeLrWoNsr4oCy_D6m0UEWAPYemFo5MzmJGuLQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CANzO1D1hKidUTKeLrWoNsr4oCy_D6m0UEWAPYemFo5MzmJGuLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/8/24 04:26, Frank Chang wrote:
> Hi Daniel,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年3月8日 週五 上午12:05寫道：
>>
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> The RISC-V IOMMU spec predicts that the IOMMU can use translation caches
>> to hold entries from the DDT. This includes implementation for all cache
>> commands that are marked as 'not implemented'.
>>
>> There are some artifacts included in the cache that predicts s-stage and
>> g-stage elements, although we don't support it yet. We'll introduce them
>> next.
>>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/riscv-iommu.c | 190 ++++++++++++++++++++++++++++++++++++++++-
>>   hw/riscv/riscv-iommu.h |   2 +
>>   2 files changed, 188 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index df534b99b0..0b93146327 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -63,6 +63,16 @@ struct RISCVIOMMUContext {
>>       uint64_t msiptp;            /* MSI redirection page table pointer */
>>   };
>>
>> +/* Address translation cache entry */
>> +struct RISCVIOMMUEntry {
>> +    uint64_t iova:44;           /* IOVA Page Number */
>> +    uint64_t pscid:20;          /* Process Soft-Context identifier */
>> +    uint64_t phys:44;           /* Physical Page Number */
>> +    uint64_t gscid:16;          /* Guest Soft-Context identifier */
>> +    uint64_t perm:2;            /* IOMMU_RW flags */
>> +    uint64_t __rfu:2;
>> +};
>> +
>>   /* IOMMU index for transactions without PASID specified. */
>>   #define RISCV_IOMMU_NOPASID 0
>>
>> @@ -629,14 +639,127 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
>>       return &as->iova_as;
>>   }
>>
>> +/* Translation Object cache support */
>> +static gboolean __iot_equal(gconstpointer v1, gconstpointer v2)
>> +{
>> +    RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
>> +    RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
>> +    return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
>> +           t1->iova == t2->iova;
>> +}
>> +
>> +static guint __iot_hash(gconstpointer v)
>> +{
>> +    RISCVIOMMUEntry *t = (RISCVIOMMUEntry *) v;
>> +    return (guint)t->iova;
>> +}
>> +
>> +/* GV: 1 PSCV: 1 AV: 1 */
>> +static void __iot_inval_pscid_iova(gpointer key, gpointer value, gpointer data)
>> +{
>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>> +    if (iot->gscid == arg->gscid &&
>> +        iot->pscid == arg->pscid &&
>> +        iot->iova == arg->iova) {
>> +        iot->perm = 0;
> 
> Maybe using IOMMU_NONE would be clearer?

Agree. I changed all relevant "iot->perm = 0" instances to "iot->perm = IOMMU_NONE".


Thanks,


Daniel

> 
> Otherwise,
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> 
>> +    }
>> +}
>> +
>> +/* GV: 1 PSCV: 1 AV: 0 */
>> +static void __iot_inval_pscid(gpointer key, gpointer value, gpointer data)
>> +{
>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>> +    if (iot->gscid == arg->gscid &&
>> +        iot->pscid == arg->pscid) {
>> +        iot->perm = 0;
>> +    }
>> +}
>> +
>> +/* GV: 1 GVMA: 1 */
>> +static void __iot_inval_gscid_gpa(gpointer key, gpointer value, gpointer data)
>> +{
>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>> +    if (iot->gscid == arg->gscid) {
>> +        /* simplified cache, no GPA matching */
>> +        iot->perm = 0;
>> +    }
>> +}
>> +
>> +/* GV: 1 GVMA: 0 */
>> +static void __iot_inval_gscid(gpointer key, gpointer value, gpointer data)
>> +{
>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>> +    if (iot->gscid == arg->gscid) {
>> +        iot->perm = 0;
>> +    }
>> +}
>> +
>> +/* GV: 0 */
>> +static void __iot_inval_all(gpointer key, gpointer value, gpointer data)
>> +{
>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>> +    iot->perm = 0;
>> +}
>> +
>> +/* caller should keep ref-count for iot_cache object */
>> +static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
>> +    GHashTable *iot_cache, hwaddr iova)
>> +{
>> +    RISCVIOMMUEntry key = {
>> +        .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
>> +        .iova  = PPN_DOWN(iova),
>> +    };
>> +    return g_hash_table_lookup(iot_cache, &key);
>> +}
>> +
>> +/* caller should keep ref-count for iot_cache object */
>> +static void riscv_iommu_iot_update(RISCVIOMMUState *s,
>> +    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
>> +{
>> +    if (!s->iot_limit) {
>> +        return;
>> +    }
>> +
>> +    if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
>> +        iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
>> +                                          g_free, NULL);
>> +        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
>> +    }
>> +    g_hash_table_add(iot_cache, iot);
>> +}
>> +
>> +static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
>> +    uint32_t gscid, uint32_t pscid, hwaddr iova)
>> +{
>> +    GHashTable *iot_cache;
>> +    RISCVIOMMUEntry key = {
>> +        .gscid = gscid,
>> +        .pscid = pscid,
>> +        .iova  = PPN_DOWN(iova),
>> +    };
>> +
>> +    iot_cache = g_hash_table_ref(s->iot_cache);
>> +    g_hash_table_foreach(iot_cache, func, &key);
>> +    g_hash_table_unref(iot_cache);
>> +}
>> +
>>   static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>> -    IOMMUTLBEntry *iotlb)
>> +    IOMMUTLBEntry *iotlb, bool enable_cache)
>>   {
>> +    RISCVIOMMUEntry *iot;
>> +    IOMMUAccessFlags perm;
>>       bool enable_faults;
>>       bool enable_pasid;
>>       bool enable_pri;
>> +    GHashTable *iot_cache;
>>       int fault;
>>
>> +    iot_cache = g_hash_table_ref(s->iot_cache);
>> +
>>       enable_faults = !(ctx->tc & RISCV_IOMMU_DC_TC_DTF);
>>       /*
>>        * TC[32] is reserved for custom extensions, used here to temporarily
>> @@ -645,9 +768,36 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>>       enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
>>       enable_pasid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>>
>> +    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
>> +    perm = iot ? iot->perm : IOMMU_NONE;
>> +    if (perm != IOMMU_NONE) {
>> +        iotlb->translated_addr = PPN_PHYS(iot->phys);
>> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
>> +        iotlb->perm = perm;
>> +        fault = 0;
>> +        goto done;
>> +    }
>> +
>>       /* Translate using device directory / page table information. */
>>       fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
>>
>> +    if (!fault && iotlb->target_as == &s->trap_as) {
>> +        /* Do not cache trapped MSI translations */
>> +        goto done;
>> +    }
>> +
>> +    if (!fault && iotlb->translated_addr != iotlb->iova && enable_cache) {
>> +        iot = g_new0(RISCVIOMMUEntry, 1);
>> +        iot->iova = PPN_DOWN(iotlb->iova);
>> +        iot->phys = PPN_DOWN(iotlb->translated_addr);
>> +        iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
>> +        iot->perm = iotlb->perm;
>> +        riscv_iommu_iot_update(s, iot_cache, iot);
>> +    }
>> +
>> +done:
>> +    g_hash_table_unref(iot_cache);
>> +
>>       if (enable_pri && fault) {
>>           struct riscv_iommu_pq_record pr = {0};
>>           if (enable_pasid) {
>> @@ -794,13 +944,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>>               if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
>>                   /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
>>                   goto cmd_ill;
>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
>> +                /* invalidate all cache mappings */
>> +                func = __iot_inval_all;
>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
>> +                /* invalidate cache matching GSCID */
>> +                func = __iot_inval_gscid;
>> +            } else {
>> +                /* invalidate cache matching GSCID and ADDR (GPA) */
>> +                func = __iot_inval_gscid_gpa;
>>               }
>> -            /* translation cache not implemented yet */
>> +            riscv_iommu_iot_inval(s, func,
>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,
>> +                cmd.dword1 & TARGET_PAGE_MASK);
>>               break;
>>
>>           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
>>                                RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
>> -            /* translation cache not implemented yet */
>> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
>> +                /* invalidate all cache mappings, simplified model */
>> +                func = __iot_inval_all;
>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
>> +                /* invalidate cache matching GSCID, simplified model */
>> +                func = __iot_inval_gscid;
>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
>> +                /* invalidate cache matching GSCID and PSCID */
>> +                func = __iot_inval_pscid;
>> +            } else {
>> +                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
>> +                func = __iot_inval_pscid_iova;
>> +            }
>> +            riscv_iommu_iot_inval(s, func,
>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
>> +                cmd.dword1 & TARGET_PAGE_MASK);
>>               break;
>>
>>           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
>> @@ -1290,6 +1467,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>>       /* Device translation context cache */
>>       s->ctx_cache = g_hash_table_new_full(__ctx_hash, __ctx_equal,
>>                                            g_free, NULL);
>> +    s->iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
>> +                                         g_free, NULL);
>>
>>       s->iommus.le_next = NULL;
>>       s->iommus.le_prev = NULL;
>> @@ -1313,6 +1492,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>>       qemu_thread_join(&s->core_proc);
>>       qemu_cond_destroy(&s->core_cond);
>>       qemu_mutex_destroy(&s->core_lock);
>> +    g_hash_table_unref(s->iot_cache);
>>       g_hash_table_unref(s->ctx_cache);
>>   }
>>
>> @@ -1320,6 +1500,8 @@ static Property riscv_iommu_properties[] = {
>>       DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>>           RISCV_IOMMU_SPEC_DOT_VER),
>>       DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
>> +    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>> +        LIMIT_CACHE_IOT),
>>       DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>>       DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>>       DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
>> @@ -1372,7 +1554,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
>>           /* Translation disabled or invalid. */
>>           iotlb.addr_mask = 0;
>>           iotlb.perm = IOMMU_NONE;
>> -    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
>> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
>>           /* Translation disabled or fault reported. */
>>           iotlb.addr_mask = 0;
>>           iotlb.perm = IOMMU_NONE;
>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>> index 6f740de690..eea2123686 100644
>> --- a/hw/riscv/riscv-iommu.h
>> +++ b/hw/riscv/riscv-iommu.h
>> @@ -68,6 +68,8 @@ struct RISCVIOMMUState {
>>       MemoryRegion trap_mr;
>>
>>       GHashTable *ctx_cache;          /* Device translation Context Cache */
>> +    GHashTable *iot_cache;          /* IO Translated Address Cache */
>> +    unsigned iot_limit;             /* IO Translation Cache size limit */
>>
>>       /* MMIO Hardware Interface */
>>       MemoryRegion regs_mr;
>> --
>> 2.43.2
>>
>>

