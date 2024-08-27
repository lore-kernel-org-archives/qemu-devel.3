Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EA7C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuod-0007kB-G8; Tue, 27 Aug 2024 07:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1siuoZ-0007is-Kb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:56:48 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1siuoX-00046K-AH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:56:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2021c08b95cso48191685ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724759803; x=1725364603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKrRJueEvKyzXDUJBgWtLZO9oGJ3do+gbjlemctpCeA=;
 b=fSgZZLdIRpE8goDMSK1SHl7CuiqLK4zEk6FBKniT/BBHS//MMJq1GclfPhhxrqzwbP
 9t7gAp0UvEYZwFlr/qRObQ7DR0fITtqszY7NDY2iTRUlBAQLctZUYIGHHWVIhxm4mxNV
 ocxmOkwagc0nlsoUxPmCG5FpNf+2UtKnttsPRB5KnxROkZv0CefDn6Zk7cD3SFKBj85E
 jjhRsK1fK5ImwFA+EHBr9KYqiRSOduHSFcDkCG/86u8LQB9KZLiSDOJqm1Luna8ngcFu
 c0TOljU1m+BUF0isS/nSrFCrKozMLQ0sWRZizRztjuzjViU1iqstsT73REwE/cmhnOb/
 JOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724759803; x=1725364603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKrRJueEvKyzXDUJBgWtLZO9oGJ3do+gbjlemctpCeA=;
 b=GAiKKJS8gb1qiQm1awbSFIVYKEDLYA8lsCEFiYRj6Bn/oYcZ9TMiCE7wzzaULKcwrn
 kFjjp/h+JnZLQjLZzjScZdZRXfQh8BJkCJZwm0y0mrIAtPsPAUg26Ko8cgN5n20d6Yhx
 RuodRTwxWL5STCMHhA6ToON8qvc5z2IEU3wn3vxjPpJSWrosulfVLDzi8bwSZBKcCb1T
 sAg2hao1HChmUQnHQkP7WxE92qgOTy9RGYRVREAw9j+v+s1B76fAsdBwxapcgBQqCHIF
 vRQb/WbH/lgQdfPX0IDC++xI/rb7VhDS89e5OpLeNGBSH5uCkdQwCYiGIvEGI83GzjUl
 GGWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTmwgEWe1/NW6u+/QCkvPhRk+hPoBOE3NpZ4yYjjaokMAPIg+pTMmSRXh7qK6R7RMIucfyB376UGwd@nongnu.org
X-Gm-Message-State: AOJu0YysZ9jdy9rrI8tMSEobEfO8ZgUUC9ijhN6JDff8hSUmD/qJKkOs
 jzzNr8/JKIxHVVCa61AiS7MsY4+YW7zKbW8PL6RMSN1ERwXsmFN2XWuS4ULlj9o=
X-Google-Smtp-Source: AGHT+IFMHJMq7jUwbHwNpPva0Vr7a2JsV2ElbqTEoDpLtUR08U6zy096YINpNuYuptT4E1XPuN5/Tg==
X-Received: by 2002:a17:902:ecc5:b0:1fb:77e7:27b2 with SMTP id
 d9443c01a7336-204ddd2c826mr41910775ad.18.1724759803218; 
 Tue, 27 Aug 2024 04:56:43 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20393f37480sm70752415ad.187.2024.08.27.04.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 04:56:42 -0700 (PDT)
Message-ID: <3b2680a1-84c9-4856-bea0-541ef059f9ae@ventanamicro.com>
Date: Tue, 27 Aug 2024 08:56:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v6 08/12] hw/riscv/riscv-iommu: add Address
 Translation Cache (IOATC)
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, ajones@ventanamicro.com
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-9-dbarboza@ventanamicro.com>
 <922b33c4-d01a-44d1-a2b8-ef7cb1b1d30a@sifive.com>
 <c2af15b8-fc22-4154-97e6-6f38b33796b7@ventanamicro.com>
 <CAH2o1u6g+MBVJYikAkEnWOWQ-v3WGPdVrS0_tn9JY5b=MrD0BA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAH2o1u6g+MBVJYikAkEnWOWQ-v3WGPdVrS0_tn9JY5b=MrD0BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 8/26/24 11:44 PM, Tomasz Jeznach wrote:
> On Fri, Aug 23, 2024 at 10:18 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 8/20/24 12:27 PM, Jason Chien wrote:
>>> Hi Daniel,
>>>
>>> On 2024/8/1 下午 11:43, Daniel Henrique Barboza wrote:
>>>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>>>
>>>> The RISC-V IOMMU spec predicts that the IOMMU can use translation caches
>>>> to hold entries from the DDT. This includes implementation for all cache
>>>> commands that are marked as 'not implemented'.
>>>>
>>>> There are some artifacts included in the cache that predicts s-stage and
>>>> g-stage elements, although we don't support it yet. We'll introduce them
>>>> next.
>>>>
>>>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> Reviewed-by: Frank Chang <frank.chang@sifive.com>
>>>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>>>> ---
>>>>    hw/riscv/riscv-iommu.c | 199 ++++++++++++++++++++++++++++++++++++++++-
>>>>    hw/riscv/riscv-iommu.h |   3 +
>>>>    2 files changed, 198 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>>>> index ebe3a53a04..3816e6a493 100644
>>>> --- a/hw/riscv/riscv-iommu.c
>>>> +++ b/hw/riscv/riscv-iommu.c
>>>> @@ -65,6 +65,16 @@ struct RISCVIOMMUContext {
>>>>        uint64_t msiptp;            /* MSI redirection page table pointer */
>>>>    };
>>>> +/* Address translation cache entry */
>>>> +struct RISCVIOMMUEntry {
>>>> +    uint64_t iova:44;           /* IOVA Page Number */
>>>> +    uint64_t pscid:20;          /* Process Soft-Context identifier */
>>>> +    uint64_t phys:44;           /* Physical Page Number */
>>>> +    uint64_t gscid:16;          /* Guest Soft-Context identifier */
>>>> +    uint64_t perm:2;            /* IOMMU_RW flags */
>>>> +    uint64_t __rfu:2;
>>>> +};
>>>> +
>>>>    /* IOMMU index for transactions without process_id specified. */
>>>>    #define RISCV_IOMMU_NOPROCID 0
>>>> @@ -1138,13 +1148,130 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
>>>>        return &as->iova_as;
>>>>    }
>>>> +/* Translation Object cache support */
>>>> +static gboolean __iot_equal(gconstpointer v1, gconstpointer v2)
>>>> +{
>>>> +    RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
>>>> +    RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
>>>> +    return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
>>>> +           t1->iova == t2->iova;
>>>> +}
>>>> +
>>>> +static guint __iot_hash(gconstpointer v)
>>>> +{
>>>> +    RISCVIOMMUEntry *t = (RISCVIOMMUEntry *) v;
>>>> +    return (guint)t->iova;
>>>> +}
>>>> +
>>>> +/* GV: 1 PSCV: 1 AV: 1 */
>>>> +static void __iot_inval_pscid_iova(gpointer key, gpointer value, gpointer data)
>>>> +{
>>>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>>>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>>>> +    if (iot->gscid == arg->gscid &&
>>>> +        iot->pscid == arg->pscid &&
>>>> +        iot->iova == arg->iova) {
>>>> +        iot->perm = IOMMU_NONE;
>>>> +    }
>>>> +}
>>>> +
>>>> +/* GV: 1 PSCV: 1 AV: 0 */
>>>> +static void __iot_inval_pscid(gpointer key, gpointer value, gpointer data)
>>>> +{
>>>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>>>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>>>> +    if (iot->gscid == arg->gscid &&
>>>> +        iot->pscid == arg->pscid) {
>>>> +        iot->perm = IOMMU_NONE;
>>>> +    }
>>>> +}
>>>> +
>>>> +/* GV: 1 GVMA: 1 */
>>>> +static void __iot_inval_gscid_gpa(gpointer key, gpointer value, gpointer data)
>>>> +{
>>>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>>>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>>>> +    if (iot->gscid == arg->gscid) {
>>>> +        /* simplified cache, no GPA matching */
>>>> +        iot->perm = IOMMU_NONE;
>>>> +    }
>>>> +}
>>>> +
>>>> +/* GV: 1 GVMA: 0 */
>>>> +static void __iot_inval_gscid(gpointer key, gpointer value, gpointer data)
>>>> +{
>>>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>>>> +    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
>>>> +    if (iot->gscid == arg->gscid) {
>>>> +        iot->perm = IOMMU_NONE;
>>>> +    }
>>>> +}
>>>> +
>>>> +/* GV: 0 */
>>>> +static void __iot_inval_all(gpointer key, gpointer value, gpointer data)
>>>> +{
>>>> +    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>>>> +    iot->perm = IOMMU_NONE;
>>>> +}
>>>> +
>>>> +/* caller should keep ref-count for iot_cache object */
>>>> +static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
>>>> +    GHashTable *iot_cache, hwaddr iova)
>>>> +{
>>>> +    RISCVIOMMUEntry key = {
>>>> +        .gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
>>>> +        .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
>>>> +        .iova  = PPN_DOWN(iova),
>>>> +    };
>>>> +    return g_hash_table_lookup(iot_cache, &key);
>>>> +}
>>>> +
>>>> +/* caller should keep ref-count for iot_cache object */
>>>> +static void riscv_iommu_iot_update(RISCVIOMMUState *s,
>>>> +    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
>>>> +{
>>>> +    if (!s->iot_limit) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    qemu_mutex_lock(&s->iot_lock);
>>>> +    if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
>>>> +        iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
>>>> +                                          g_free, NULL);
>>>> +        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
>>>> +    }
>>>> +    g_hash_table_add(iot_cache, iot);
>>>> +    qemu_mutex_unlock(&s->iot_lock);
>>>> +}
>>>> +
>>>> +static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
>>>> +    uint32_t gscid, uint32_t pscid, hwaddr iova)
>>>> +{
>>>> +    GHashTable *iot_cache;
>>>> +    RISCVIOMMUEntry key = {
>>>> +        .gscid = gscid,
>>>> +        .pscid = pscid,
>>>> +        .iova  = PPN_DOWN(iova),
>>>> +    };
>>>> +
>>>> +    iot_cache = g_hash_table_ref(s->iot_cache);
>>>> +    qemu_mutex_lock(&s->iot_lock);
>>>> +    g_hash_table_foreach(iot_cache, func, &key);
>>>> +    qemu_mutex_unlock(&s->iot_lock);
>>>> +    g_hash_table_unref(iot_cache);
>>>> +}
>>>> +
>>>>    static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>>>> -    IOMMUTLBEntry *iotlb)
>>>> +    IOMMUTLBEntry *iotlb, bool enable_cache)
>>>>    {
>>>> +    RISCVIOMMUEntry *iot;
>>>> +    IOMMUAccessFlags perm;
>>>>        bool enable_pid;
>>>>        bool enable_pri;
>>>> +    GHashTable *iot_cache;
>>>>        int fault;
>>>> +    iot_cache = g_hash_table_ref(s->iot_cache);
>>>>        /*
>>>>         * TC[32] is reserved for custom extensions, used here to temporarily
>>>>         * enable automatic page-request generation for ATS queries.
>>>> @@ -1152,9 +1279,39 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>>>>        enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
>>>>        enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>>>> +    qemu_mutex_lock(&s->iot_lock);
>>>> +    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
>>>> +    qemu_mutex_unlock(&s->iot_lock);
>>>> +    perm = iot ? iot->perm : IOMMU_NONE;
>>>> +    if (perm != IOMMU_NONE) {
>>>> +        iotlb->translated_addr = PPN_PHYS(iot->phys);
>>>> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
>>>> +        iotlb->perm = perm;
>>>> +        fault = 0;
>>>> +        goto done;
>>>> +    }
>>>> +
>>>>        /* Translate using device directory / page table information. */
>>>>        fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
>>>> +    if (!fault && iotlb->target_as == &s->trap_as) {
>>>> +        /* Do not cache trapped MSI translations */
>>>> +        goto done;
>>>> +    }
>>>> +
>>>> +    if (!fault && iotlb->translated_addr != iotlb->iova && enable_cache) {
>>> Shouldn't addresses which don't need to be translated also be cached?
>>
>> I think it doesn't hurt to cache these addresses too. Just updated the check to:
>>
>>       if (!fault && enable_cache) {
>>
>>
> 
> Note: It was an implementation choice to not cache identity-mapped
> translations, as allowed by the specification, to avoid translation
> cache evictions for other devices sharing the IOMMU hardware model.
> Unless there is a strong reason to enable IOATC here, I'd suggest not
> caching such entries.

That's fair enough. Let's keep the restriction as is. I'll add a comment with
this observation you made about being an implementation choice.


Thanks,

Daniel

> 
> Thanks,
> - Tomasz
> 
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>>> +        iot = g_new0(RISCVIOMMUEntry, 1);
>>>> +        iot->iova = PPN_DOWN(iotlb->iova);
>>>> +        iot->phys = PPN_DOWN(iotlb->translated_addr);
>>>> +        iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
>>>> +        iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
>>>> +        iot->perm = iotlb->perm;
>>>> +        riscv_iommu_iot_update(s, iot_cache, iot);
>>>> +    }
>>>> +
>>>> +done:
>>>> +    g_hash_table_unref(iot_cache);
>>>> +
>>>>        if (enable_pri && fault) {
>>>>            struct riscv_iommu_pq_record pr = {0};
>>>>            if (enable_pid) {
>>>> @@ -1294,13 +1451,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>>>>                if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
>>>>                    /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
>>>>                    goto cmd_ill;
>>>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
>>>> +                /* invalidate all cache mappings */
>>>> +                func = __iot_inval_all;
>>>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
>>>> +                /* invalidate cache matching GSCID */
>>>> +                func = __iot_inval_gscid;
>>>> +            } else {
>>>> +                /* invalidate cache matching GSCID and ADDR (GPA) */
>>>> +                func = __iot_inval_gscid_gpa;
>>>>                }
>>>> -            /* translation cache not implemented yet */
>>>> +            riscv_iommu_iot_inval(s, func,
>>>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,
>>>> +                cmd.dword1 & TARGET_PAGE_MASK);
>>>>                break;
>>>>            case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
>>>>                                 RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
>>>> -            /* translation cache not implemented yet */
>>>> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
>>>> +                /* invalidate all cache mappings, simplified model */
>>>> +                func = __iot_inval_all;
>>>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
>>>> +                /* invalidate cache matching GSCID, simplified model */
>>>> +                func = __iot_inval_gscid;
>>>> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
>>>> +                /* invalidate cache matching GSCID and PSCID */
>>>> +                func = __iot_inval_pscid;
>>>> +            } else {
>>>> +                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
>>>> +                func = __iot_inval_pscid_iova;
>>>> +            }
>>>> +            riscv_iommu_iot_inval(s, func,
>>>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
>>>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
>>>> +                cmd.dword1 & TARGET_PAGE_MASK);
>>>>                break;
>>>>            case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
>>>> @@ -1824,6 +2008,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>>>>                                             g_free, NULL);
>>>>        qemu_mutex_init(&s->ctx_lock);
>>>> +    s->iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
>>>> +                                         g_free, NULL);
>>>> +    qemu_mutex_init(&s->iot_lock);
>>>> +
>>>>        s->iommus.le_next = NULL;
>>>>        s->iommus.le_prev = NULL;
>>>>        QLIST_INIT(&s->spaces);
>>>> @@ -1836,6 +2024,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>>>>        RISCVIOMMUState *s = RISCV_IOMMU(dev);
>>>>        qemu_mutex_destroy(&s->core_lock);
>>>> +    g_hash_table_unref(s->iot_cache);
>>>>        g_hash_table_unref(s->ctx_cache);
>>>>    }
>>>> @@ -1843,6 +2032,8 @@ static Property riscv_iommu_properties[] = {
>>>>        DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>>>>            RISCV_IOMMU_SPEC_DOT_VER),
>>>>        DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
>>>> +    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>>>> +        LIMIT_CACHE_IOT),
>>>>        DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>>>>        DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>>>>        DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
>>>> @@ -1897,7 +2088,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
>>>>            /* Translation disabled or invalid. */
>>>>            iotlb.addr_mask = 0;
>>>>            iotlb.perm = IOMMU_NONE;
>>>> -    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
>>>> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
>>>>            /* Translation disabled or fault reported. */
>>>>            iotlb.addr_mask = 0;
>>>>            iotlb.perm = IOMMU_NONE;
>>>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>>>> index 6d76cb9b1a..c917b6219a 100644
>>>> --- a/hw/riscv/riscv-iommu.h
>>>> +++ b/hw/riscv/riscv-iommu.h
>>>> @@ -75,6 +75,9 @@ struct RISCVIOMMUState {
>>>>        GHashTable *ctx_cache;          /* Device translation Context Cache */
>>>>        QemuMutex ctx_lock;      /* Device translation Cache update lock */
>>>> +    GHashTable *iot_cache;          /* IO Translated Address Cache */
>>>> +    QemuMutex iot_lock;      /* IO TLB Cache update lock */
>>>> +    unsigned iot_limit;             /* IO Translation Cache size limit */
>>>>        /* MMIO Hardware Interface */
>>>>        MemoryRegion regs_mr;

