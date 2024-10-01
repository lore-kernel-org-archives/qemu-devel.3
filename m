Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EED4CF3189
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 23:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svlrQ-0006Po-1X; Tue, 01 Oct 2024 19:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svlrL-0006PS-Dl
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 19:00:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svlrF-0007Jw-Nz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 19:00:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7179069d029so4411851b3a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727823640; x=1728428440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPs2KIvfdwuj1YdFO0EW+j2GJnniFw+sMDZv/M52Wx8=;
 b=pW0NtS+fZSLGD72GtEAN5uzQeLpefWaddmU4MDnzpNqqhVzPBvmyPr5XBZdpdgjmHE
 kxhmYWlRtJbdSqUnuI/HMAAMCTUJRbTjksQOi//epwwZrh0H6uzElpGdUVFK+gnnTDx6
 kTBRrP2Ez/H09VfN26ZidzbbojSvGz0oHgZB+/oOuzufbcuGixd3NackUuy8i4j+k3o9
 DYmo1bAOmmS0z1shVt2toH+Gu51jtZdVtLblKv8xn27qNY23zc73ZSgTsBqJu1ZTxFza
 JF2iHYFHeVo4QcohkzpGbd4uKpSMwE9UxCGqFmcufMdK3Pf+c0aN21vdTFQ03aIfIIfW
 oHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727823640; x=1728428440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPs2KIvfdwuj1YdFO0EW+j2GJnniFw+sMDZv/M52Wx8=;
 b=QdbTnReTHDkhMOPKbajEUEPO2bqElpQ/jJoM3W1E/SkN99oiIyfvcWG16AJEHeXI2m
 x4f7RtiV0hpmkBn6JS5mHHnzs2WjDy00lc3PSl1DErdmDFuiv+6ADMv0W9ywU02/xuEK
 4UPm5VjiNALLm8Yj8XZqXXsNnifH5FrO9H7L2W7zCh7e/u99R8Ux/03haQ5+MosnLx+9
 OCrC80sroD8sCLQ1DKlTW7BK2HV+wmTweIwtLBGIm7fdxjSVM8C5W1tWchjN5ZDRwMPc
 FIJFCqLDzeKxdRlV4ilm6qFkTvs6j4q10LUkh+BHsiwsCJJ48kHOztjUyuq7KcJmxL0b
 sVDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2r1tBvLnxbjgpquZHnhYGCcLEKaC6UEb7JSDc1D5jijKd0u7gEQQcACh0drfNHqArLTjIE+rQ1S8b@nongnu.org
X-Gm-Message-State: AOJu0YxCfT0yf55vvCR8AD/KsSj9I2e7xLV0MuczWNacgJP0j7HIL4go
 PRZB5Bc/Pnn5jaJvMu7Olnj5pyRPAWsDY9N0Cg9W7mbIxwn3K21UVFIkXCx3sUo=
X-Google-Smtp-Source: AGHT+IHExZ72fXgv6D6SfP5UnnbtIy2LdsmJb+J1iRuzeAitE+dWA1KCQBTGDl1pQMvJxTE3i1e49w==
X-Received: by 2002:a05:6a00:1896:b0:717:8eca:95 with SMTP id
 d2e1a72fcca58-71dc5d56a3dmr2025597b3a.17.1727823640003; 
 Tue, 01 Oct 2024 16:00:40 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b265249b7sm8917036b3a.148.2024.10.01.16.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 16:00:39 -0700 (PDT)
Message-ID: <fe6c6569-4623-451c-bd4f-9325f294461c@ventanamicro.com>
Date: Tue, 1 Oct 2024 20:00:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 16/47] hw/riscv: add RISC-V IOMMU base emulation
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Sebastien Boeuf <seb@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "frank.chang@sifive.com" <frank.chang@sifive.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <20240924221751.2688389-17-alistair.francis@wdc.com>
 <CAFEAcA8rdFYACFKdJga72WA4ET9NFRwrOifdbTYDBxY6G6uOXA@mail.gmail.com>
 <634d685c-7e36-409e-9b41-b9162a5acf9c@ventanamicro.com>
 <CAFEAcA-=s9zatyYYOP01BO1o7jPpY45mWkDM3N_yydD=Ka3GNw@mail.gmail.com>
 <CAH2o1u6pQXOFbo6EyJAOfkAgE6VPK7MGsuvLD=nzhVeQFfrHwA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAH2o1u6pQXOFbo6EyJAOfkAgE6VPK7MGsuvLD=nzhVeQFfrHwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 10/1/24 7:14 PM, Tomasz Jeznach wrote:
> On Sun, Sep 29, 2024 at 8:46 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sat, 28 Sept 2024 at 22:01, Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>>
>>>
>>> On 9/28/24 5:22 PM, Peter Maydell wrote:
>>>> On Tue, 24 Sept 2024 at 23:19, Alistair Francis <alistair23@gmail.com> wrote:
>>
>>>>> +/* Register helper functions */
>>>>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
>>>>> +    unsigned idx, uint32_t set, uint32_t clr)
>>>>> +{
>>>>> +    uint32_t val;
>>>>> +    qemu_spin_lock(&s->regs_lock);
>>>>> +    val = ldl_le_p(s->regs_rw + idx);
>>>>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
>>>>> +    qemu_spin_unlock(&s->regs_lock);
>>>>> +    return val;
>>>>> +}
>>>>
>>>> This looks very weird. Nobody else's IOMMU implementation
>>>> grabs a spinlock while it is accessing guest register data.
>>>> Why is riscv special? Why a spinlock? (We use spinlocks
>>>> only very very sparingly in general.)
>>>
>>>
>>> The first versions of the IOMMU used qemu threads. I believe this is where
>>> the locks come from (both from registers and from the cache).
>>>
>>> I'm not sure if we're ever going to hit a race condition without the locks
>>> in the current code (i.e. using mmio ops only). I think I'll make an attempt
>>> to remove the locks and see if something breaks.
>>
>> Generally access to the backing for guest registers in a
>> device model is protected by the fact that the iothread lock
>> (BQL) is held while the guest is accessing a device. I think for
>> iommu devices there may be some extra complication because they
>> get called as part of the translate-this-address codepath
>> where I think the BQL is not held, and so they typically
>> have some qemu_mutex to protect themselves[*]. But they
>> don't generally need/want to do the handling at this very
>> fine-grained per-read/write level.
>>
>> [*] This is just what I've gathered from a quick read through
>> our other iommu implementations; don't take it as gospel.
>>
>> If you do need to do something complicated with locking it would
>> be good to have a comment somewhere explaining why and what
>> the locking principles are.
>>
> 
> Locking for the iot and ctx cache is still required as the translation
> requests going through IOMMUMemoryRegionClass.translate callback
> (riscv_iommu_memory_region_translate) are unlikely protected by BQL.
> With ATS translation requests and eventually PRI notifications coming
> to the iommu implementation, cache structures will be modified without
> any external locking guarantees.
> 
> To add some background to register access spin locks.
> Original implementation runs all IOMMU command processing logic as a
> separate thread, avoiding holding BQL while executing cache
> invalidations and other commands. This was implemented to mimic real
> hardware, where IOMMU operations are not blocking CPU execution.
> During the review process it was suggested and modified to execute all
> commands directly as part of the MMIO callback. Please note, that this
> change has consequences of potentially holding CPU/BQL for unspecified
> time as the command processing flow might be calling registered IOMMU
> memory notifiers for ATS invalidations and page group responses.
> Anyone implementing memory notifier callback will now execute with BQL
> held. Also, updates to register state might happen during translation
> fault reporting and or/pri. At least queue CSR/head/tail registers
> updates will need some sort of protection.
> 
> Probably adding a comment in the code and maybe restoring the original
> threading model would make this implementation more readable and less
> problematic in the future.

I agree that the locks makes more sense in a threading model like it was
the case in v2. At this point it doesn't make much sense to have both
BQL and manual locks.

For context, we moved away from it back in v2, after this comment from
Frank Chang:

https://lore.kernel.org/qemu-riscv/CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com/

--------------
In our experience, using QEMU thread increases the latency of command
queue processing,
which leads to the potential IOMMU fence timeout in the Linux driver
when using IOMMU with KVM,
e.g. booting the guest Linux.

Is it possible to remove the thread from the IOMMU just like ARM, AMD,
and Intel IOMMU models?
--------------

Frank then elaborated further about IOFENCE and how they were hitting asserts
that were solved after moving the IOMMU away from a thread model.

For now I removed all locks, like Peter suggested, and in my testing with
riscv-iommu-pci and riscv-iommu-sys I didn't see anything bad happening.
BQL is granting enough race protection it seems.

I believe we should stick with this approach, instead of rolling back
to a threading model that Frank said back in v2 that could be problematic.
Nothing is stopping us from moving back to a threading model later if we
start hitting race conditions or even if we have performance improvements
in doing so. At that point we'll be more versed in how the IOMMU is going
to be used by everyone else too.


Thanks,

Daniel


> 
> Thanks for the review,
> - Tomasz
> 
> 
>> thanks
>> -- PMM

