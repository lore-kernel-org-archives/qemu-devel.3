Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACABC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 13:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3y26-0001tR-NR; Mon, 06 May 2024 09:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s3y23-0001qB-UD
 for qemu-devel@nongnu.org; Mon, 06 May 2024 09:05:28 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s3y20-0008BH-Gf
 for qemu-devel@nongnu.org; Mon, 06 May 2024 09:05:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ec4dc64c6cso12302715ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715000715; x=1715605515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m2e6miWxvP8l2p8XuQ6anDUvvnsup8z0r2EdQToelss=;
 b=Ye5J+3CD9y8ZKkm7aRhMpV3gkrYkyPFDrk4jJ8Plc4Rp6NzuHU/yt8KgkY5oayOCFV
 HHCl473K2pkwVNSvFu3e7AjdOxgGiA9uVoXBJCD7RBaBjYphxWle95RNvUQd+WViJWIK
 BIHD02wLp7VESmhVIrDikGz4jc6ZSi7HCCkKaXDFkkePFSfk9e4udLJwZ2rwR3YEPn9f
 5a5QGTRbTXDLIkz3nJu6a44SYzhwD60/M2LURIIvMQDYC/ntrOM2rmfLk2xe9cFl6/YC
 iqnn6wfWKtuM4fJscgKZJnARBwXECETd5S7197KmtPhbLysDdVti51/s9mFB9JXJ5A63
 Smtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715000715; x=1715605515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2e6miWxvP8l2p8XuQ6anDUvvnsup8z0r2EdQToelss=;
 b=tCwon1Y5B5wKpj8qFkiQLSy7EwZWgZkw9gc8joHaNrR6GwUSx3JaOoOvm16kYv134l
 PxA1Un47WrQlGz0GCVZoS1+oEPruvrPHP9mNmv2/7snstwk4WihXefOBO5TPKyBMLv+V
 ub3RVNpgYSSewpr+xZIursheywBndtItYLdH7FWZ/lBT6htWUUfZ7FiULrdWCtjdtdlr
 eGI6xJ1sVXBI4yq0jcIFhtsEBs3FRpNRuhMaXOX2FzApxFRI0JoJUmueFuDO6DEIOhsR
 qaG6NYIwQrgxkXYNbWj92K1ypo96nqqLztL0I2GZNfqx2cUBXkq76DlUMM1A5sUUCijU
 Dt/g==
X-Gm-Message-State: AOJu0YxUGljcYwFvhWtgdJSLmVv5QR952mrNOeo9/RC/oKbcvMQEQPSA
 IgqdnoLvhP66scoZvY6FSJhdeN0D7+JamJXirpyMVvrxofTeWyGqi6cjmFmOaiLIL+wD9G/6VtN
 6
X-Google-Smtp-Source: AGHT+IGOwJzhMhEp11Mu1Y8Ro+3/F1mirpNirXxEZDIA4e+nFoRnzf3b+yeiLih8bTyK97CRA8Rcrg==
X-Received: by 2002:a17:902:bb95:b0:1e2:688e:597d with SMTP id
 m21-20020a170902bb9500b001e2688e597dmr10241247pls.21.1715000714089; 
 Mon, 06 May 2024 06:05:14 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.168])
 by smtp.gmail.com with ESMTPSA id
 kn14-20020a170903078e00b001e27557050dsm8209549plb.178.2024.05.06.06.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 06:05:13 -0700 (PDT)
Message-ID: <e3eba1d7-35d7-4ecd-8443-320cbebc2bc3@ventanamicro.com>
Date: Mon, 6 May 2024 10:05:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] hw/riscv/riscv-iommu: add DBG support
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-12-dbarboza@ventanamicro.com>
 <CANzO1D0ywHs+Juv9_qavykxCDiUsuk6tebObfSAyRbgW-WhGJA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CANzO1D0ywHs+Juv9_qavykxCDiUsuk6tebObfSAyRbgW-WhGJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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

Hi Frank,

On 5/6/24 01:09, Frank Chang wrote:
> Hi Daniel,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年3月8日 週五 上午12:05寫道：
>>
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> DBG support adds three additional registers: tr_req_iova, tr_req_ctl and
>> tr_response.
>>
>> The DBG cap is always enabled. No on/off toggle is provided for it.
>>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/riscv-iommu-bits.h | 20 +++++++++++++
>>   hw/riscv/riscv-iommu.c      | 57 ++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
>> index 0994f5ce48..b3f92411bb 100644
>> --- a/hw/riscv/riscv-iommu-bits.h
>> +++ b/hw/riscv/riscv-iommu-bits.h
>> @@ -83,6 +83,7 @@ struct riscv_iommu_pq_record {
>>   #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
>>   #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>>   #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
>> +#define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
>>   #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
>>   #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
>>
>> @@ -177,6 +178,25 @@ enum {
>>       RISCV_IOMMU_INTR_COUNT
>>   };
>>
>> +#define RISCV_IOMMU_IPSR_CIP            BIT(RISCV_IOMMU_INTR_CQ)
>> +#define RISCV_IOMMU_IPSR_FIP            BIT(RISCV_IOMMU_INTR_FQ)
>> +#define RISCV_IOMMU_IPSR_PMIP           BIT(RISCV_IOMMU_INTR_PM)
>> +#define RISCV_IOMMU_IPSR_PIP            BIT(RISCV_IOMMU_INTR_PQ)
> 
> These are not related to the DBG.
> 
>> +
>> +/* 5.24 Translation request IOVA (64bits) */
>> +#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
>> +
>> +/* 5.25 Translation request control (64bits) */
>> +#define RISCV_IOMMU_REG_TR_REQ_CTL      0x0260
>> +#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY  BIT_ULL(0)
>> +#define RISCV_IOMMU_TR_REQ_CTL_PID      GENMASK_ULL(31, 12)
>> +#define RISCV_IOMMU_TR_REQ_CTL_DID      GENMASK_ULL(63, 40)
>> +
>> +/* 5.26 Translation request response (64bits) */
>> +#define RISCV_IOMMU_REG_TR_RESPONSE     0x0268
>> +#define RISCV_IOMMU_TR_RESPONSE_FAULT   BIT_ULL(0)
>> +#define RISCV_IOMMU_TR_RESPONSE_PPN     RISCV_IOMMU_PPN_FIELD
>> +
>>   /* 5.27 Interrupt cause to vector (64bits) */
>>   #define RISCV_IOMMU_REG_IVEC            0x02F8
>>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index 7af5929b10..1fa1286d07 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -1457,6 +1457,46 @@ static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
>>       riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
>>   }
>>
>> +static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
>> +{
>> +    uint64_t iova = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_IOVA);
>> +    uint64_t ctrl = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_TR_REQ_CTL);
>> +    unsigned devid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_DID);
>> +    unsigned pid = get_field(ctrl, RISCV_IOMMU_TR_REQ_CTL_PID);
>> +    RISCVIOMMUContext *ctx;
>> +    void *ref;
>> +
>> +    if (!(ctrl & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY)) {
>> +        return;
>> +    }
>> +
>> +    ctx = riscv_iommu_ctx(s, devid, pid, &ref);
>> +    if (ctx == NULL) {
>> +        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
>> +                                 RISCV_IOMMU_TR_RESPONSE_FAULT |
>> +                                 (RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED << 10));
>> +    } else {
>> +        IOMMUTLBEntry iotlb = {
>> +            .iova = iova,
>> +            .perm = IOMMU_NONE,
> 
> .perm should honor tr_req_ctl.[Exe|Nw]
> 
>> +            .addr_mask = ~0,
>> +            .target_as = NULL,
>> +        };
>> +        int fault = riscv_iommu_translate(s, ctx, &iotlb, false);
>> +        if (fault) {
>> +            iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
>> +        } else {
>> +            iova = ((iotlb.translated_addr & ~iotlb.addr_mask) >> 2) &
> 
> For 4-KB page, we should right-shift 12 bits.
> 
>> +                RISCV_IOMMU_TR_RESPONSE_PPN;
> 
> It's possible that the translation is not 4-KB page (i.e. superpage),
> which we should set tr_response.S
> and encode translation range size in tr_response.PPN.

At this moment this emulation doesn't support superpages, at least from my
understanding. Tomasz is welcome to correct me if I'm wrong. I'll explictly
set tr_response.S to 0 here to make it clearer.

The idea here IIUC is to, in the future, merge the IOMMU translation lookup code
with the existing lookup code we have (cpu_helper.c, get_physical_address()), and
with that the IOMMU will end up supporting both super-pages and svnapot.



Thanks,

Daniel


> 
> Regards,
> Frank Chang
> 
>> +        }
>> +        riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
>> +    }
>> +
>> +    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
>> +        RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
>> +    riscv_iommu_ctx_put(s, ref);
>> +}
>> +
>>   /* Core IOMMU execution activation */
>>   enum {
>>       RISCV_IOMMU_EXEC_DDTP,
>> @@ -1502,7 +1542,7 @@ static void *riscv_iommu_core_proc(void* arg)
>>               /* NOP */
>>               break;
>>           case BIT(RISCV_IOMMU_EXEC_TR_REQUEST):
>> -            /* DBG support not implemented yet */
>> +            riscv_iommu_process_dbg(s);
>>               break;
>>           }
>>           exec &= ~mask;
>> @@ -1574,6 +1614,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
>>           exec = BIT(RISCV_IOMMU_EXEC_PQCSR);
>>           busy = RISCV_IOMMU_PQCSR_BUSY;
>>           break;
>> +
>> +    case RISCV_IOMMU_REG_TR_REQ_CTL:
>> +        exec = BIT(RISCV_IOMMU_EXEC_TR_REQUEST);
>> +        regb = RISCV_IOMMU_REG_TR_REQ_CTL;
>> +        busy = RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
>> +        break;
>>       }
>>
>>       /*
>> @@ -1746,6 +1792,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>>           s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
>>                     RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
>>       }
>> +    /* Enable translation debug interface */
>> +    s->cap |= RISCV_IOMMU_CAP_DBG;
>> +
>>       /* Report QEMU target physical address space limits */
>>       s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
>>                          TARGET_PHYS_ADDR_SPACE_BITS);
>> @@ -1800,6 +1849,12 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>>       stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
>>       stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IVEC], 0);
>>       stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
>> +    /* If debug registers enabled. */
>> +    if (s->cap & RISCV_IOMMU_CAP_DBG) {
>> +        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_IOVA], 0);
>> +        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_CTL],
>> +            RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
>> +    }
>>
>>       /* Memory region for downstream access, if specified. */
>>       if (s->target_mr) {
>> --
>> 2.43.2
>>
>>

