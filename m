Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD32AC71150
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 23:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSM8-0002z7-Nv; Wed, 28 Aug 2024 19:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjSM4-0002y6-PF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 19:45:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjSM1-0002Zn-BG
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 19:45:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71434174201so86581b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724888731; x=1725493531;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WxdkL1obvAnCJUAIqTIhPFS1dEvxW1fvCGrzJ7vvk2o=;
 b=miG/yiK17cHhthG1RHx1uCqPt11AJBHYv9Gkc1fv9n5BhJajd0LBRl0q2pjOvvCgIN
 oe4rzYJPeA2MlYnibCCxqlEtmnRQXp6M/IP7j6s2fKmDckRqh4w78FPYby03ZQv1s/S5
 RJgvIlH94n+o6uBys1QdleVFGDhaPrr+K/7vw+hEQbM7yd1vDjScmF3s1iJMgkmxRKpw
 pyzCvw29c8QKpZYUicShYepNNenVUNAu6OpBq63b6L3o3XKVealwpVvpmC9AUrKSY8LW
 58UZDcXehYF0HQLRffF+YLgIfJsybwxGI4UM9fA+FJXWJ1huU/F+M/cWN/BVKcBGRSzk
 nIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724888731; x=1725493531;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxdkL1obvAnCJUAIqTIhPFS1dEvxW1fvCGrzJ7vvk2o=;
 b=lNBA156Exu7tR3A3o0cytf7lsgO6J/kq69XHW/a2tNgp7Cu9U01Xzv5s7zU+fDu5yH
 9R9BfUw8KoI+d7KZYRz4Gyb4lNU3IFNH/D4BKd45mYzw+gUki4RpjtxAjNY98urX1u7G
 D8yPruquEGDcXYEYfoqg6IZjPrB5ffo5Cc5l1SKC4wxSPST6kVU8b/jV5ekukTGUxmdp
 9BExBx3JPS7mkrtMzglVOy8q28ICBN4iCCumEjBnsozfEKh7YXAQZP51pkp/PrHvbHnQ
 WS2bqsnBmKGRDFPnlaKaGQMk2m5l4o3DlN6TNnFTJC7mBgvaaxeSFgD/3wKjza6oiHsR
 ZchQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP07Q5l6PlqfoBJIDAUgmGho17FeGIQA1dGqQH/9rOvKTgZvRWb4nZLydDQIF6SUGlKPTpmYRsaROY@nongnu.org
X-Gm-Message-State: AOJu0YwV5Z2penckSqUe7IV0lQzQVeIn5C5qjFFu2OFLgwoYf9DHqW50
 hJYzK+OdF1TTxd48R2ioEprTesA0L6IhHHmIfbvi7eCuMm/mEiFG/760oSUzTtU=
X-Google-Smtp-Source: AGHT+IFE4OavEM0RTVcHNMvDTI2mH5L3lC5VkKRjYAgZzXKOKW7fY/CANheJdl2vBLz+I789MPIlzw==
X-Received: by 2002:a05:6a00:3cca:b0:704:2563:5079 with SMTP id
 d2e1a72fcca58-715dfc7a8dcmr1412305b3a.27.1724888731272; 
 Wed, 28 Aug 2024 16:45:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e5576d7bsm30509b3a.30.2024.08.28.16.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 16:45:30 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:45:28 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v11 13/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
Message-ID: <Zs+2mIsAw2BKODtk@debug.ba.rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-14-debug@rivosinc.com>
 <CAKmqyKPyyupykqc-0yrGm+msZPuf+=jVWvD86yz7mfqjn5MT9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPyyupykqc-0yrGm+msZPuf+=jVWvD86yz7mfqjn5MT9A@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Thu, Aug 29, 2024 at 09:29:49AM +1000, Alistair Francis wrote:
>On Thu, Aug 29, 2024 at 3:49 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> zicfiss protects shadow stack using new page table encodings PTE.W=1,
>> PTE.R=0 and PTE.X=0. This encoding is reserved if zicfiss is not
>> implemented or if shadow stack are not enabled.
>> Loads on shadow stack memory are allowed while stores to shadow stack
>> memory leads to access faults. Shadow stack accesses to RO memory
>> leads to store page fault.
>>
>> To implement special nature of shadow stack memory where only selected
>> stores (shadow stack stores from sspush) have to be allowed while rest
>> of regular stores disallowed, new MMU TLB index is created for shadow
>> stack.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/riscv/cpu_helper.c | 37 +++++++++++++++++++++++++++++++------
>>  target/riscv/internals.h  |  3 +++
>>  2 files changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index be4ac3d54e..39544cade6 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -893,6 +893,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>>      hwaddr ppn;
>>      int napot_bits = 0;
>>      target_ulong napot_mask;
>> +    bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
>> +    bool sstack_page = false;
>>
>>      /*
>>       * Check if we should use the background registers for the two
>> @@ -1101,21 +1103,36 @@ restart:
>>          return TRANSLATE_FAIL;
>>      }
>>
>> +    target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
>>      /* Check for reserved combinations of RWX flags. */
>> -    switch (pte & (PTE_R | PTE_W | PTE_X)) {
>> -    case PTE_W:
>> +    switch (rwx) {
>>      case PTE_W | PTE_X:
>>          return TRANSLATE_FAIL;
>> +    case PTE_W:
>> +        /* if bcfi enabled, PTE_W is not reserved and shadow stack page */
>> +        if (cpu_get_bcfien(env) && first_stage) {
>> +            sstack_page = true;
>> +            /* if ss index, read and write allowed. else only read allowed */
>> +            rwx = is_sstack_idx ? PTE_R | PTE_W : PTE_R;
>> +            break;
>> +        }
>> +        return TRANSLATE_FAIL;
>> +    case PTE_R:
>> +        /* shadow stack writes to readonly memory are page faults */
>> +        if (is_sstack_idx && access_type == MMU_DATA_STORE) {

While responding to your question, I noticed there is a bug here. Its a leftover from
previous patches where I was promoting shadow stack loads to stores. No need to check
`access_type == MMU_DATA_STORE` because we store unwind information as part of tcg
compile.

Will fix it.

>> +            return TRANSLATE_FAIL;
>> +        }
>> +        break;
>>      }
>>
>>      int prot = 0;
>> -    if (pte & PTE_R) {
>> +    if (rwx & PTE_R) {
>>          prot |= PAGE_READ;
>>      }
>> -    if (pte & PTE_W) {
>> +    if (rwx & PTE_W) {
>>          prot |= PAGE_WRITE;
>>      }
>> -    if (pte & PTE_X) {
>> +    if (rwx & PTE_X) {
>>          bool mxr = false;
>>
>>          /*
>> @@ -1160,7 +1177,7 @@ restart:
>>
>>      if (!((prot >> access_type) & 1)) {
>>          /* Access check failed */
>> -        return TRANSLATE_FAIL;
>> +        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
>
>Why is it a PMP error if it's a shadow stack page?

A shadow stack page is readable by regular loads.
We are making sure of that in `case PTE_W` in above switch case.
But shadow stack page is not writeable via regular stores. And must raise
access fault. return code `TRANSLATE_PMP_FAIL` is translated to access fault
while raising fault.

>
>Alistair

