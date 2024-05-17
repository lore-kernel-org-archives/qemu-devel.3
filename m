Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE925C25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7tuN-0001f8-KY; Fri, 17 May 2024 05:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7tuM-0001en-28
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:29:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7tuI-0001B4-1P
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:29:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so3585955ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715938179; x=1716542979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CMAWjyjpSCmVCIAoBYVxPDxn+aC7bC35vzUVWi7kAdI=;
 b=lZdfCr4eYv15ag31TUdSX+QZpWOw4R3CxugzCsFjoFw7shafh1sVKRnVlpvzsJJAoG
 Lfvw0OZlopYQ8kOpbQycyXfWnOOAAuxiKEwG/xknZgUS4V/4sI5h+ENzH35lqZZsx/n7
 rmXnsBCCtRz4WPYS5iqU/mkuqywu6rWa0uli1R2IeMUsSmPTsRP1yR2d4ihM+iINAamn
 fN2MCsg54feJTjz09UzUbeWD62IKDJVrXWLm3LyM2rkWH2mb2ovY3fHxd4H8b6Q0JGEN
 OdjIG1KFhzaf1duwHMBbX3HV+gqumhFAQ9dbZf13o2f/WZOIen5eX0Tz16BCdrWoKn44
 6aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715938179; x=1716542979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CMAWjyjpSCmVCIAoBYVxPDxn+aC7bC35vzUVWi7kAdI=;
 b=J4ZSODwXotfYdJvDCEfsz946aInr5tmly9fw/mSGM7K+VtzS3vMV9CE10m6nYL4olZ
 eI3B8VmI6qNAVsznxApowGEqXpUSVmEnXlX/FmGrq3VM8TPbL4TuKs4qWTtK3qowPeWp
 G+jGDCn0vZva7RgdVermMdLsa+IqGVjUs69uwB9Ei/XfZWgmzrNYUBSxbsnTHOu0k+wy
 tfv0ccjzvT/sojaBGF6lp+NxgPwmAM09DOJpJeIvDvfeyOpwuzIzK6yuMlaj28YrSsR7
 ISAg905kCZ59j9jT3D8Y6maHmLCLjz57x4DjmIqhrBMkf9oX7JQWTEZB/PXM4GrG7ffn
 4I4w==
X-Gm-Message-State: AOJu0YxAeDOhc/9HVTS0Qj9KhmwMWz4+NJSGTMLRkkm/gLGVDr92Wmb9
 8K4fxb0NhPIqbOhEpgFYBJdhQQC+3Kg83iLiNwvoRaYiXaaee/q8duAS9NAGnRM=
X-Google-Smtp-Source: AGHT+IHoFtid6WA+9lNuQJHLmQMMA7MSyxu/BmuSxfZaKB3sWWKVubdRMAzV1LgFSZz45RXiJH5sxQ==
X-Received: by 2002:a17:903:41c4:b0:1eb:50fd:7875 with SMTP id
 d9443c01a7336-1ef43e2323cmr265470875ad.33.1715938178721; 
 Fri, 17 May 2024 02:29:38 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f070c54e45sm96408545ad.99.2024.05.17.02.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 May 2024 02:29:38 -0700 (PDT)
Message-ID: <680add99-f5fb-4c75-83de-fef26991b064@ventanamicro.com>
Date: Fri, 17 May 2024 06:29:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] hw/riscv/riscv-iommu: add ATS support
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-11-dbarboza@ventanamicro.com>
 <CANzO1D2dj3boVZoWGtM3Ji0S_xPPu2JThFBqXEudJgKVp=S3UA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CANzO1D2dj3boVZoWGtM3Ji0S_xPPu2JThFBqXEudJgKVp=S3UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

Hi Frank,


On 5/7/24 23:57, Frank Chang wrote:
> Hi Daniel,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年3月8日 週五 上午12:06寫道：
>>
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> Add PCIe Address Translation Services (ATS) capabilities to the IOMMU.
>> This will add support for ATS translation requests in Fault/Event
>> queues, Page-request queue and IOATC invalidations.
>>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/riscv-iommu-bits.h |  43 ++++++++++++++-
>>   hw/riscv/riscv-iommu.c      | 107 +++++++++++++++++++++++++++++++++---
>>   hw/riscv/riscv-iommu.h      |   1 +
>>   hw/riscv/trace-events       |   3 +
>>   4 files changed, 145 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
>> index 9d645d69ea..0994f5ce48 100644
>> --- a/hw/riscv/riscv-iommu-bits.h
>> +++ b/hw/riscv/riscv-iommu-bits.h
>> @@ -81,6 +81,7 @@ struct riscv_iommu_pq_record {
>>   #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>>   #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>>   #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
>> +#define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>>   #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
>>   #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
>>   #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
>> @@ -201,6 +202,7 @@ struct riscv_iommu_dc {
>>
>>   /* Translation control fields */
>>   #define RISCV_IOMMU_DC_TC_V             BIT_ULL(0)
>> +#define RISCV_IOMMU_DC_TC_EN_ATS        BIT_ULL(1)
>>   #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
>>   #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
>>   #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
>> @@ -259,6 +261,20 @@ struct riscv_iommu_command {
>>   #define RISCV_IOMMU_CMD_IODIR_DV        BIT_ULL(33)
>>   #define RISCV_IOMMU_CMD_IODIR_DID       GENMASK_ULL(63, 40)
>>
>> +/* 3.1.4 I/O MMU PCIe ATS */
>> +#define RISCV_IOMMU_CMD_ATS_OPCODE              4
>> +#define RISCV_IOMMU_CMD_ATS_FUNC_INVAL          0
>> +#define RISCV_IOMMU_CMD_ATS_FUNC_PRGR           1
>> +#define RISCV_IOMMU_CMD_ATS_PID         GENMASK_ULL(31, 12)
>> +#define RISCV_IOMMU_CMD_ATS_PV          BIT_ULL(32)
>> +#define RISCV_IOMMU_CMD_ATS_DSV         BIT_ULL(33)
>> +#define RISCV_IOMMU_CMD_ATS_RID         GENMASK_ULL(55, 40)
>> +#define RISCV_IOMMU_CMD_ATS_DSEG        GENMASK_ULL(63, 56)
>> +/* dword1 is the ATS payload, two different payload types for INVAL and PRGR */
>> +
>> +/* ATS.PRGR payload */
>> +#define RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE      GENMASK_ULL(47, 44)
>> +
>>   enum riscv_iommu_dc_fsc_atp_modes {
>>       RISCV_IOMMU_DC_FSC_MODE_BARE = 0,
>>       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 = 8,
>> @@ -322,7 +338,32 @@ enum riscv_iommu_fq_ttypes {
>>       RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH = 5,
>>       RISCV_IOMMU_FQ_TTYPE_TADDR_RD = 6,
>>       RISCV_IOMMU_FQ_TTYPE_TADDR_WR = 7,
>> -    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 8,
>> +    RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ = 8,
>> +    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
>> +};
>> +
>> +/* Header fields */
>> +#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
>> +#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
>> +#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
>> +#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
>> +#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
>> +
>> +/* Payload fields */
>> +#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
>> +#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
>> +#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
>> +#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
>> +#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
>> +#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
>> +
>> +
>> +/*
>> + * struct riscv_iommu_msi_pte - MSI Page Table Entry
>> + */
>> +struct riscv_iommu_msi_pte {
>> +      uint64_t pte;
>> +      uint64_t mrif_info;
>>   };
>>
>>   /* Fields on pte */
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index 03a610fa75..7af5929b10 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -576,7 +576,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
>>               RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
>>           ctx->satp = set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
>>               RISCV_IOMMU_DC_FSC_MODE_BARE);
>> -        ctx->tc = RISCV_IOMMU_DC_TC_V;
>> +        ctx->tc = RISCV_IOMMU_DC_TC_EN_ATS | RISCV_IOMMU_DC_TC_V;
> 
> We should OR RISCV_IOMMU_DC_TC_EN_ATS only when IOMMU has ATS capability.
> (i.e. s->enable_ats == true).
> 
>>           ctx->ta = 0;
>>           ctx->msiptp = 0;
>>           return 0;
>> @@ -1021,6 +1021,18 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>>       enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
>>       enable_pasid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>>
>> +    /* Check for ATS request. */
>> +    if (iotlb->perm == IOMMU_NONE) {
>> +        /* Check if ATS is disabled. */
>> +        if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS)) {
>> +            enable_pri = false;
>> +            fault = RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
>> +            goto done;
>> +        }
>> +        trace_riscv_iommu_ats(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
>> +                PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid), iotlb->iova);
> 
> It's possible that iotlb->perm == IOMMU_NONE,
> but the translation request comes from riscv_iommu_process_dbg().

That's true. I don't see an easy way to distinguish at this point whether
the translation was triggered by an actual ATS request or a DBG request.

I'll remove this trace since it's ambiguous.  There are enough traces in ATS
code in riscv_iommu_ats_inval() and riscv_iommu_ats_prgr(). We also have a trace
for each command being processed in riscv_iommu_process_cq_tail().


Thanks,


Daniel

> 
>> +    }
>> +
>>       iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
>>       perm = iot ? iot->perm : IOMMU_NONE;
>>       if (perm != IOMMU_NONE) {
>> @@ -1067,13 +1079,10 @@ done:
>>
>>       if (enable_faults && fault) {
>>           struct riscv_iommu_fq_record ev;
>> -        unsigned ttype;
>> -
>> -        if (iotlb->perm & IOMMU_RW) {
>> -            ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
>> -        } else {
>> -            ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
>> -        }
>> +        const unsigned ttype =
>> +            (iotlb->perm & IOMMU_RW) ? RISCV_IOMMU_FQ_TTYPE_UADDR_WR :
>> +            ((iotlb->perm & IOMMU_RO) ? RISCV_IOMMU_FQ_TTYPE_UADDR_RD :
>> +            RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ);
>>           ev.hdr = set_field(0, RISCV_IOMMU_FQ_HDR_CAUSE, fault);
>>           ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, ttype);
>>           ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, enable_pasid);
>> @@ -1105,6 +1114,73 @@ static MemTxResult riscv_iommu_iofence(RISCVIOMMUState *s, bool notify,
>>           MEMTXATTRS_UNSPECIFIED);
>>   }
>>
>> +static void riscv_iommu_ats(RISCVIOMMUState *s,
>> +    struct riscv_iommu_command *cmd, IOMMUNotifierFlag flag,
>> +    IOMMUAccessFlags perm,
>> +    void (*trace_fn)(const char *id))
>> +{
>> +    RISCVIOMMUSpace *as = NULL;
>> +    IOMMUNotifier *n;
>> +    IOMMUTLBEvent event;
>> +    uint32_t pasid;
>> +    uint32_t devid;
>> +    const bool pv = cmd->dword0 & RISCV_IOMMU_CMD_ATS_PV;
>> +
>> +    if (cmd->dword0 & RISCV_IOMMU_CMD_ATS_DSV) {
>> +        /* Use device segment and requester id */
>> +        devid = get_field(cmd->dword0,
>> +            RISCV_IOMMU_CMD_ATS_DSEG | RISCV_IOMMU_CMD_ATS_RID);
>> +    } else {
>> +        devid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_RID);
>> +    }
>> +
>> +    pasid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
>> +
>> +    qemu_mutex_lock(&s->core_lock);
>> +    QLIST_FOREACH(as, &s->spaces, list) {
>> +        if (as->devid == devid) {
>> +            break;
>> +        }
>> +    }
>> +    qemu_mutex_unlock(&s->core_lock);
>> +
>> +    if (!as || !as->notifier) {
>> +        return;
>> +    }
>> +
>> +    event.type = flag;
>> +    event.entry.perm = perm;
>> +    event.entry.target_as = s->target_as;
>> +
>> +    IOMMU_NOTIFIER_FOREACH(n, &as->iova_mr) {
>> +        if (!pv || n->iommu_idx == pasid) {
>> +            event.entry.iova = n->start;
>> +            event.entry.addr_mask = n->end - n->start;
>> +            trace_fn(as->iova_mr.parent_obj.name);
>> +            memory_region_notify_iommu_one(n, &event);
>> +        }
>> +    }
>> +}
>> +
>> +static void riscv_iommu_ats_inval(RISCVIOMMUState *s,
>> +    struct riscv_iommu_command *cmd)
>> +{
>> +    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_DEVIOTLB_UNMAP, IOMMU_NONE,
>> +                           trace_riscv_iommu_ats_inval);
>> +}
>> +
>> +static void riscv_iommu_ats_prgr(RISCVIOMMUState *s,
>> +    struct riscv_iommu_command *cmd)
>> +{
>> +    unsigned resp_code = get_field(cmd->dword1,
>> +                                   RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE);
>> +
>> +    /* Using the access flag to carry response code information */
>> +    IOMMUAccessFlags perm = resp_code ? IOMMU_NONE : IOMMU_RW;
>> +    return riscv_iommu_ats(s, cmd, IOMMU_NOTIFIER_MAP, perm,
>> +                           trace_riscv_iommu_ats_prgr);
>> +}
>> +
>>   static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
>>   {
>>       uint64_t old_ddtp = s->ddtp;
>> @@ -1260,6 +1336,17 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>>                   get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
>>               break;
>>
>> +        /* ATS commands */
>> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_INVAL,
>> +                             RISCV_IOMMU_CMD_ATS_OPCODE):
>> +            riscv_iommu_ats_inval(s, &cmd);
>> +            break;
>> +
>> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_ATS_FUNC_PRGR,
>> +                             RISCV_IOMMU_CMD_ATS_OPCODE):
>> +            riscv_iommu_ats_prgr(s, &cmd);
>> +            break;
>> +
> 
> PCIe ATS commands are supported only when capabilities.ATS is set to 1
> (i.e. s->enable_ats == true).
> 
> Regards,
> Frank Chang
> 
>>           default:
>>           cmd_ill:
>>               /* Invalid instruction, do not advance instruction index. */
>> @@ -1648,6 +1735,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>>       if (s->enable_msi) {
>>           s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
>>       }
>> +    if (s->enable_ats) {
>> +        s->cap |= RISCV_IOMMU_CAP_ATS;
>> +    }
>>       if (s->enable_s_stage) {
>>           s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
>>                     RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
>> @@ -1765,6 +1855,7 @@ static Property riscv_iommu_properties[] = {
>>       DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>>           LIMIT_CACHE_IOT),
>>       DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>> +    DEFINE_PROP_BOOL("ats", RISCVIOMMUState, enable_ats, TRUE),
>>       DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>>       DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
>>       DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>> index 9b33fb97ef..47f3fdad58 100644
>> --- a/hw/riscv/riscv-iommu.h
>> +++ b/hw/riscv/riscv-iommu.h
>> @@ -38,6 +38,7 @@ struct RISCVIOMMUState {
>>
>>       bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
>>       bool enable_msi;      /* Enable MSI remapping */
>> +    bool enable_ats;      /* Enable ATS support */
>>       bool enable_s_stage;  /* Enable S/VS-Stage translation */
>>       bool enable_g_stage;  /* Enable G-Stage translation */
>>
>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
>> index 42a97caffa..4b486b6420 100644
>> --- a/hw/riscv/trace-events
>> +++ b/hw/riscv/trace-events
>> @@ -9,3 +9,6 @@ riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iov
>>   riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
>>   riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>>   riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
>> +riscv_iommu_ats(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: translate request %04x:%02x.%u iova: 0x%"PRIx64
>> +riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
>> +riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group response"
>> --
>> 2.43.2
>>
>>

