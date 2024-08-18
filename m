Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D746C52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 18:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfkWJ-00022g-To; Sun, 18 Aug 2024 14:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sfkWJ-00021k-3u
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 14:20:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sfkWH-0001YB-8d
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 14:20:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2021537a8e6so16849165ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724005247; x=1724610047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OS4MzMo2V3PyM3KnIiKBExxRQzlzxJxkSDId0GUaBew=;
 b=AoObRqEl09byAGQUtl0F87es591ijzJp9VoRpbKax2MpXCR5CUycCaB6hzMU7VtqC2
 Cp6+g/j9JIVMZ6I58fPkrfG9PEZFu5Kob53IjWZJyOaB9p9k7u1CwZt+3UmLkAFE2tb1
 kiX4dh0W/CLwhAqM7J8WE/i+LgFY5mZONs1eXs24sfDYlY0iu0bCTbTENq/e5PypFYtW
 4iP+M+6SrMKdA58A/a8L6/MuD/OkvVCEcOP5RpzRHaJl23Yx/8aoUxWuGPRFMIzSvNZ2
 hDy8nQxabUovgTtunr8LpDebwpwWPkkcukaNyzxUUpNV5FRzl/FpxvYDzygvPe8bATtt
 urPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724005247; x=1724610047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OS4MzMo2V3PyM3KnIiKBExxRQzlzxJxkSDId0GUaBew=;
 b=IEJcd9c3XjLjBG7WBsyuN9GdZxYU52olBRuF5Xyw6KGPGU4kLanC6XFI3sNjw6DX4F
 RWMtAbLFMjf96UUvZIw+omgow4V+xwJwhjg9cBeNIGElGFAiUIWDI6CLIaEXiBa7UxsB
 wuIWn1tFaYutPNhAB03y+S8SVFFGepiQgJtq21cYNuOzXkM7n82zPvU2C/1ZaTOylDd+
 2AMBS20ZSLuUtCVMfi3RtcLqC76pPtm2B3vRMnSYaor/YrxijFvkJcOkQYPnJPXK6t6r
 p5di2h2Ct5otF2B1St5I2NevE1oITqm3zixjY2zQDo8EU1MyZ1iEYbP027PyD8uGe4/a
 N8JA==
X-Gm-Message-State: AOJu0YyxGtwxoc76ygbuINK0fET8e91+Er89Iq5Ny/hpCxSF0f5sDf+Q
 OqbR2IMhP48piJ48v/EHtV76H0HwZoo3SZnPK0xXrJshKsQTTtn0cA9s6i71bUM=
X-Google-Smtp-Source: AGHT+IE4D30EMJINoqSVqrXvkY2uSBTWZuIQWUeSW0cc2f/LDRxMA3fT+F88KHruREzS3Z682sOioQ==
X-Received: by 2002:a17:902:e74b:b0:202:35a8:42 with SMTP id
 d9443c01a7336-20235a8015bmr37195185ad.49.1724005247385; 
 Sun, 18 Aug 2024 11:20:47 -0700 (PDT)
Received: from [192.168.68.110] ([179.133.97.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03194b2sm52583735ad.86.2024.08.18.11.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 11:20:46 -0700 (PDT)
Message-ID: <2eafad44-d9d7-43c5-8ded-72fe0bed10fa@ventanamicro.com>
Date: Sun, 18 Aug 2024 15:20:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v6 03/12] hw/riscv: add RISC-V IOMMU base emulation
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Sebastien Boeuf <seb@rivosinc.com>
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-4-dbarboza@ventanamicro.com>
 <20240817-08bebc0e0a1cd92c2d9aff8a@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240817-08bebc0e0a1cd92c2d9aff8a@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 8/17/24 8:34 AM, Andrew Jones wrote:
> On Thu, Aug 01, 2024 at 12:43:24PM GMT, Daniel Henrique Barboza wrote:
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
>> international process. The latest frozen specifcation can be found at:
>>
>> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
>>
>> Add the foundation of the device emulation for RISC-V IOMMU. It includes
>> support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage (sv32x4,
>> sv39x4, sv48x4, sv57x4 caps).
>>
>> Other capabilities like ATS and DBG support will be added incrementally
>> in the next patches.
>>
>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---

  (...)

>> +/* Redirect MSI write for given GPA. */
>> +static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>> +    RISCVIOMMUContext *ctx, uint64_t gpa, uint64_t data,
>> +    unsigned size, MemTxAttrs attrs)
>> +{
>> +    MemTxResult res;
>> +    dma_addr_t addr;
>> +    uint64_t intn;
>> +    uint32_t n190;
>> +    uint64_t pte[2];
>> +    int fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
>> +    int cause;
>> +
>> +    /* Interrupt File Number */
>> +    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>> +    if (intn >= 256) {
>> +        /* Interrupt file number out of range */
>> +        res = MEMTX_ACCESS_ERROR;
>> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
>> +        goto err;
>> +    }
>> +
>> +    /* fetch MSI PTE */
>> +    addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
>> +    addr = addr | (intn * sizeof(pte));
>> +    res = dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
>> +            MEMTXATTRS_UNSPECIFIED);
>> +    if (res != MEMTX_OK) {
>> +        if (res == MEMTX_DECODE_ERROR) {
>> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED;
>> +        } else {
>> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
>> +        }
>> +        goto err;
>> +    }
>> +
>> +    le64_to_cpus(&pte[0]);
>> +    le64_to_cpus(&pte[1]);
>> +
>> +    if (!(pte[0] & RISCV_IOMMU_MSI_PTE_V) || (pte[0] & RISCV_IOMMU_MSI_PTE_C)) {
>> +        /*
>> +         * The spec mentions that: "If msipte.C == 1, then further
>> +         * processing to interpret the PTE is implementation
>> +         * defined.". We'll abort with cause = 262 for this
>> +         * case too.
>> +         */
>> +        res = MEMTX_ACCESS_ERROR;
>> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_INVALID;
>> +        goto err;
>> +    }
>> +
>> +    switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
>> +    case RISCV_IOMMU_MSI_PTE_M_BASIC:
>> +        /* MSI Pass-through mode */
>> +        addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
>> +        addr = addr | (gpa & TARGET_PAGE_MASK);
> 
> I'm not sure what the idea was with this (maybe a misunderstanding of how
> guest interrupt files get targeted?), but we shouldn't be modifying the
> result of a translation with the input to that translation. It breaks
> translations where guest imsic address bits don't strictly overlap host
> imsic address bits and it allows the guest to access host memory it
> shouldn't. The fix is just to remove the line.

I'll remove this line in v7. Thanks,


Daniel

> 
> Thanks,
> drew

