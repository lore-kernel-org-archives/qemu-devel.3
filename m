Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3376AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 22:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdGyi-00013C-UL; Sun, 11 Aug 2024 18:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGyf-00012E-Vy
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 18:23:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdGyc-00017j-2s
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 18:23:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc65329979so34703585ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723415027; x=1724019827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=200woV0Waq5KPyQXnG1armcVi5NgaKFdPO/3NpLgxp8=;
 b=qKxXX/7RztlQllOwFGhkkaO4ds7kyXL+6Rg84P6I6CuMh1VNCOSPDupL8BSHB7CiT+
 SgDy+HpPQbIneXa6w7E4PJNfrFF/KEw/G18kq5KySpQp6PqUlDh0zRECOZEk+RjzOfa0
 iGef+w+gFCz7kOpSkqDhCUrC37Kw3G0DVP01uE6j2DpHOdldPi+TZqdtwvJxcs5ZP57u
 7fc92cu3f6o0wsPH58f+Po3M7jl47L+kMhV7q4w3fzV1IyKzI3SX85WlU+0dGwPE752V
 HRhy1iCNkzu0y0Xql7/MiU8x+K0l0iBh+ZL+LzI3WCDtMfha7T0gehfNwFFL2ZCANYPC
 M16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723415027; x=1724019827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=200woV0Waq5KPyQXnG1armcVi5NgaKFdPO/3NpLgxp8=;
 b=TLbl6Tk2e+LrdF1FmnxOfTVWCCU8a8YxgN1Y4McshR+RX1SBIdImGBGIQavSrV5Opw
 /52peuWbRayXHnye5fi5gnLJjYxGtqjMjyHzB1hqnTVTuXjrerXc9Zx2GvP82HPsGDTM
 +Z81zeIZckbOl83gWPmXfwr6KPM3yh20cULIyK4Gz4spZPDcrfpwUVYov8JTR7M2qa8i
 xmfy18b6RzqMz8LhTV1G5bOSR5P/8BAWiODDnLo1W8c90llNnKQyForVMgN7Z1zOahP1
 eVqFTKbC1LYWzZpcUreZAxdRUVmKkYeOrp01M+WpX/ORB4WChv/9bmkYYrEDP5idusM9
 kA+g==
X-Gm-Message-State: AOJu0YwamO2r3bopwiQvX4IrNYqHC/leHOEd05p+FkIIgUST12i3jGTi
 fG3EoUTTcxC6bIh6MYy56L9sveaDjzsaamv+gTquiWO6pN+1axFCZpP39B/3LCA=
X-Google-Smtp-Source: AGHT+IGaymqK8zVtfDLYM7UtR+kKdB9K+VbAIc4ifMF1m2D0zX6NOpj2+7mIGXVP/Fb7R/SPz917Fg==
X-Received: by 2002:a17:902:ccc7:b0:1fd:9e44:e5e9 with SMTP id
 d9443c01a7336-200ae5d3c99mr116261685ad.53.1723415027165; 
 Sun, 11 Aug 2024 15:23:47 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9dc8988sm6824183a91.48.2024.08.11.15.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 15:23:46 -0700 (PDT)
Message-ID: <cd70d975-2a72-4899-a16a-430b398d19ca@linaro.org>
Date: Mon, 12 Aug 2024 08:23:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-15-debug@rivosinc.com>
 <bea52a58-12a7-45d1-b610-d577a7540887@linaro.org>
 <ZrZmBhUnTQY1eaC3@debug.ba.rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZrZmBhUnTQY1eaC3@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/10/24 04:55, Deepak Gupta wrote:
> On Wed, Aug 07, 2024 at 01:19:55PM +1000, Richard Henderson wrote:
>> On 8/7/24 10:06, Deepak Gupta wrote:
>>>      int prot = 0;
>>> -    if (pte & PTE_R) {
>>> +    /*
>>> +     * If PTE has read bit in it or it's shadow stack page,
>>> +     * then reads allowed
>>> +     */
>>> +    if ((pte & PTE_R) || sstack_page) {
>>>          prot |= PAGE_READ;
>>>      }
>>
>> I feel like this logic could be simplified somehow.
>> I'll think about it.
> 
> Ok let me know.
> 
>>
>>> @@ -1409,6 +1461,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>>>                    __func__, address, access_type, mmu_idx);
>>> +    /* If shadow stack instruction initiated this access, treat it as store */
>>> +    if (mmu_idx & MMU_IDX_SS_ACCESS) {
>>> +        access_type = MMU_DATA_STORE;
>>> +    }
>>
>> I know you're trying to massage the fault type, but I think this is the wrong place.
> 
> Is it okay if I add `mmu_idx` argument to `raise_mmu_exception` ?
> Inside `raise_mmu_exception`, then based on `mmu_idx == shadow stack index`, I can convert
> a fault due to access_type=MMU_DATA_LOAD into store page fault.

We have other places where we miss-categorize amo instructions and raise the wrong fault, 
I think particularly without smp, when we implement amo without host atomic operations. 
We should perhaps come up with a general purpose solution.

For instance, set TARGET_INSN_START_EXTRA_WORDS to 2.  In the second extra unwind word, 
set bit 0 to 1 if the instruction should raise STORE_AMO on a read fault.  Handle this in 
raise_mmu_exception, which would then need to perform the restore and exit itself.


r~

