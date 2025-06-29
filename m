Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A01C7EE39
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 09:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVo7D-0000xN-J2; Sun, 29 Jun 2025 05:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uVo7C-0000xB-In
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 05:14:22 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uVo7A-0006xO-FK
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 05:14:22 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-700c7e4c048so13250056d6.3
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751188458; x=1751793258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VKpuEWr2aLUGYdcIwG4SkyLw6nH1iFe3zWkVT9KZX9o=;
 b=Clso1YSR7CVi86CXohP3kRU7SiGtZx7gmjZMHdOpUSrzPwbKDwdmPN61G6z1XEb8Cj
 2Hx04BPwsHODad6cJNGC4CPIItwgoqn8s8rpfBTWiVTFAlsnWzeZ58mlyLemKzGrbEBX
 bW05bQftI7vaV4iezyall9MtJoc5plw6PAKh0WarDxCJj/K3+pbmYc3OyqX+4u3IqyID
 Hm2222i5xutMopfBUEq0r6UZlotd8RokR6Ppx9EodBzJspOMbtdAXd8mJKmUSj69oRuy
 57gtKNsitzpqgjqrlIaOhxpVtfwh8klgl0aaCCM9YjNZDEPRoUKHi4uUISB8lVb5i6Eh
 WaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751188458; x=1751793258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VKpuEWr2aLUGYdcIwG4SkyLw6nH1iFe3zWkVT9KZX9o=;
 b=QzHxB3yu/hWsNBHpnxILT0kxLv+6+pZ0AtbVsVAncRZi3hvDMLOjkPMIKATqncImZK
 7OuljWk6vv4iYNo106QDbMUqhYP0eVZTaavNf20/9ICI+PfCMeS5BZr3sQIiALQfSj0p
 tV8FwB4Gv+3sFnUAKXrj4QYLW4/WCwxcNpZfRj/ag1/YzM0/v+34K3p9CNpV7eqA3cef
 qmg+f367910aUCgNlF9SIDVaGTQpx3pmh7c5776gdufslEIj6ibu80TxOveVXdHAi/Eh
 yueOkVEC8AUfvRWpC6EjfmiOXo1kj0rKfDDk5jyDbeuWlR9l99NVN0XdHy5Fe2X+POoh
 dYAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMQAhKSFk51Z1zEWNrZTeSQPF8mSNEoSDCKC0C8Lnhl1Q2+tDS6pcOmXkjsqvjp88oW3YIApWoon49@nongnu.org
X-Gm-Message-State: AOJu0YzHKdpEnHY5gvSvK2sC+pknPPENJHo6SNAaygzb9nIInp5c7Dfd
 w5O5s+Mi03IbWIcuzvzm4JEYbL140v4E79YvhuzvpVsLqojL4OQPhKGuaZMY+p5U4bk=
X-Gm-Gg: ASbGncu5mEW9R+BxaW//JHbzwNCW2Iqv8jeVKQtmYivdEAT+HiCweLNDWARlYw1FGm6
 jXQ2VtbSlFbyALV0Uns8Gzbiy0Gae3Ht6934OeKTDte/YCCAaz+pUMPzGhPZ5OAcVVacGsPsGO3
 2JVZXqONdFbdUJAnlvr7oB2LqeGo5un9Wv4qztTQ3+cGi6vw03vgG0/l29148IZkaK3RShdJEDn
 kObe+BH62bZJ8Tdx5ricXI85FB4GGlkA2dsrgOyioy6E88vbPd2wuor9iIn9glj/iJ3lm0EJkiW
 9270k3M0dCOS++9Zr5fdH2N8+hIlbSOZlXZiAM7uicpZs/Qv9yyxhSe0BDeDzMlKvqM3/14/MOI
 k26U/v1fOjg==
X-Google-Smtp-Source: AGHT+IGNZtjxxZwOnW7vdFEqb6AaGxxi0iEzFrbE+m2N5fszoXo3fHIqGwCNSwHmDPlmbMtDs1efWA==
X-Received: by 2002:a05:6214:4009:b0:6fd:c82:cc33 with SMTP id
 6a1803df08f44-6ffed7a42eemr153116586d6.7.1751188458032; 
 Sun, 29 Jun 2025 02:14:18 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772fcdb7sm48849726d6.86.2025.06.29.02.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Jun 2025 02:14:17 -0700 (PDT)
Message-ID: <b5f070d4-a0f6-4f1c-b75d-dcf8486dd9b3@ventanamicro.com>
Date: Sun, 29 Jun 2025 06:14:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target: riscv: Add Svrsw60t59b extension support
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, debug@rivosinc.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250605142126.1939798-1-alexghiti@rivosinc.com>
 <4990220d-a4a6-49b4-a8db-929cf1100e31@ventanamicro.com>
 <CAHVXubg3DM52H_1z1Yg5SSk2nZq3VL8xBREBP9Np9aC0OTAAuw@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAHVXubg3DM52H_1z1Yg5SSk2nZq3VL8xBREBP9Np9aC0OTAAuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf2b.google.com
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



On 6/25/25 4:36 AM, Alexandre Ghiti wrote:
> Hi Daniel,
> 
> On Sat, Jun 7, 2025 at 7:54 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 6/5/25 11:21 AM, Alexandre Ghiti wrote:
>>> The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
>>> for software to use.
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>
>>> Changes in v2:
>>>    - Add support for IOMMU
>>>    - Make svrsw60t59b depend on sv39 (deepak)
>>>
>>> Open question: svrsw60t59b in IOMMU should also depend on 64bit, but I
>>> did not find an easy to way in riscv_iommu_realize() to detect that, how
>>> should I do?
>>
>>
>> What controls the IOMMU behavior is the set of IOMMU capabilities that the driver
>> chooses to use. Other than that the device should be oblivious to the CPU word
>> size.
>>
>>   From what I see in this patch you did the right thing: you added a new capability
>> to be advertised to software and that's it. It's up to software to decide whether
>> it's going to use it or not. You can advertise a 64 bit only IOMMU capability running
>> in a 32 bit CPU and it's up to the OS to not use/ignore it. In fact we already do
>> that: satp_mode related caps (e.g. RISCV_IOMMU_CAP_SV32X4) are 32/64 bits exclusive
>> but are always advertised.
>>
>>
>>
>> Now, Svrsw60t59b being a 32 bit only extension requires special handling in
>> riscv_init_max_cpu_extensions() because the 'max' CPU has a 32 bit variant and
>> enabled everything by default. You can use this diff:
>>
>>
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index f93cd53f37..96201e15c6 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -1612,6 +1612,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>>
>>        if (env->misa_mxl != MXL_RV32) {
>>            isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
>> +    } else {
>> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_svrsw60t59b), false);
>>        }
>>
>>        /*
>>
>>
>> To fix this test break in 'make check-functional':
>>
>>          Command: /home/danielhb/work/qemu/build/qemu-system-riscv32 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,fd=10 -serial chardev:console -cpu max -kernel /home/danielhb/.cache/qemu/download/872bc8f8e0d4661825d5f47f7bec64988e9d0a8bd5db8917d57e16f66d83b329 -append printk.time=0 root=/dev/vda console=ttyS0 -blockdev driver=raw,file.driver=file,file.filename=/home/danielhb/work/qemu/build/tests/functional/riscv32/test_riscv32_tuxrun.TuxRunRiscV32Test.test_riscv32_maxcpu/scratch/511ad34e63222db08d6c1da16fad224970de36517a784110956ba6a24a0ee5f6,node-name=hd0 -device virtio-blk-device,drive=hd0
>>          Output: qemu-system-riscv32: svrsw60t59b is not supported on RV32 and MMU-less platforms
> 
> Sorry for the late answer and thanks for the fix ^! I have just sent the v2.


I'm not seeing it in my box and in qemu-devel and in qemu-riscv. Perhaps a
re-sending might be in order. Thanks,


Daniel

> 
> Thanks,
> 
> Alex
> 
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>>
>>>    hw/riscv/riscv-iommu-bits.h       | 1 +
>>>    hw/riscv/riscv-iommu.c            | 3 ++-
>>>    target/riscv/cpu.c                | 2 ++
>>>    target/riscv/cpu_bits.h           | 3 ++-
>>>    target/riscv/cpu_cfg_fields.h.inc | 1 +
>>>    target/riscv/cpu_helper.c         | 3 ++-
>>>    target/riscv/tcg/tcg-cpu.c        | 6 ++++++
>>>    7 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
>>> index 1017d73fc6..47fe01bee5 100644
>>> --- a/hw/riscv/riscv-iommu-bits.h
>>> +++ b/hw/riscv/riscv-iommu-bits.h
>>> @@ -79,6 +79,7 @@ struct riscv_iommu_pq_record {
>>>    #define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
>>>    #define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
>>>    #define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
>>> +#define RISCV_IOMMU_CAP_SVRSW60T59B     BIT_ULL(14)
>>>    #define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
>>>    #define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
>>>    #define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
>>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>>> index a877e5da84..36eda95a1c 100644
>>> --- a/hw/riscv/riscv-iommu.c
>>> +++ b/hw/riscv/riscv-iommu.c
>>> @@ -2355,7 +2355,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>>>        }
>>>        if (s->enable_g_stage) {
>>>            s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
>>> -                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
>>> +                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4 |
>>> +                  RISCV_IOMMU_CAP_SVRSW60T59B;
>>>        }
>>>
>>>        if (s->hpm_cntrs > 0) {
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 629ac37501..13f1f56d95 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -228,6 +228,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>>        ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>>>        ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>>>        ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
>>> +    ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
>>>        ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>>>        ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>>>        ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>>> @@ -1282,6 +1283,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>>        MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>>>        MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>>>        MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
>>> +    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
>>>        MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>>>
>>>        MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>> index a30317c617..51eb7114da 100644
>>> --- a/target/riscv/cpu_bits.h
>>> +++ b/target/riscv/cpu_bits.h
>>> @@ -675,7 +675,8 @@ typedef enum {
>>>    #define PTE_SOFT            0x300 /* Reserved for Software */
>>>    #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
>>>    #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
>>> -#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
>>> +#define PTE_RESERVED(svrsw60t59b)            \
>>> +             (svrsw60t59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
>>>    #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
>>>
>>>    /* Page table PPN shift amount */
>>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>>> index 59f134a419..ab61c1ccf2 100644
>>> --- a/target/riscv/cpu_cfg_fields.h.inc
>>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>>> @@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
>>>    BOOL_FIELD(ext_svinval)
>>>    BOOL_FIELD(ext_svnapot)
>>>    BOOL_FIELD(ext_svpbmt)
>>> +BOOL_FIELD(ext_svrsw60t59b)
>>>    BOOL_FIELD(ext_svvptc)
>>>    BOOL_FIELD(ext_svukte)
>>>    BOOL_FIELD(ext_zdinx)
>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>> index 2ed69d7c2d..3479a62cc7 100644
>>> --- a/target/riscv/cpu_helper.c
>>> +++ b/target/riscv/cpu_helper.c
>>> @@ -1309,6 +1309,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>>>        bool svade = riscv_cpu_cfg(env)->ext_svade;
>>>        bool svadu = riscv_cpu_cfg(env)->ext_svadu;
>>>        bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
>>> +    bool svrsw60t59b = riscv_cpu_cfg(env)->ext_svrsw60t59b;
>>>
>>>        if (first_stage && two_stage && env->virt_enabled) {
>>>            pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
>>> @@ -1376,7 +1377,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>>>            if (riscv_cpu_sxl(env) == MXL_RV32) {
>>>                ppn = pte >> PTE_PPN_SHIFT;
>>>            } else {
>>> -            if (pte & PTE_RESERVED) {
>>> +            if (pte & PTE_RESERVED(svrsw60t59b)) {
>>>                    qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
>>>                                  "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
>>>                                  __func__, pte_addr, pte);
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index 305912b8dd..886006abc3 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -804,6 +804,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>>>            cpu->cfg.ext_ssctr = false;
>>>        }
>>>
>>> +    if (cpu->cfg.ext_svrsw60t59b &&
>>> +        (!cpu->cfg.mmu || mcc->def->misa_mxl_max == MXL_RV32)) {
>>> +        error_setg(errp, "svrsw60t59b is not supported on RV32 and MMU-less platforms");
>>> +        return;
>>> +    }
>>> +
>>>        /*
>>>         * Disable isa extensions based on priv spec after we
>>>         * validated and set everything we need.
>>


