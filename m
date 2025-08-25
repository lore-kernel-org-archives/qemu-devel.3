Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4013CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUYi-0002OS-Ku; Mon, 25 Aug 2025 06:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUYe-0002N6-Ax
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:36:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUYU-0006wZ-Ml
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:36:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso21303805e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756118157; x=1756722957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w63cxLN3KRUNqwiXrJYqtIWo5C5s48OCDSjMs1jZ32o=;
 b=XUgZbwJxfMo1cxZVd4dUsU5i+5nrDx6FpUjRCb0+MLlXZCi3elLOE1MGnMSHVADjWT
 5QSmTGDLnkMzD6eF4n4kmOuAy9zZTGV52WBD8PFFUjMW6hU2DBV7BCVlRdL40t1QoC0A
 OVbRGcRO71Yewru0kHRvZ6Lj/oZ/lB9jbbVpSuopzfzWeC0QaM0EkjXsv3pDPCmwjkiG
 xdkhZJKR1CapHvvXpoYZNyP67iFugylSRvIPf09tOPkfA+L3M9uQ6p5mAX8+I7m1T7HP
 bWU3T0PIcC5+gqzK6LaKAwA3ItLHKnOl+DHLSVOxXb0KNqp/hwjRDlIvqKqT5+kn3Lq6
 mRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756118157; x=1756722957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w63cxLN3KRUNqwiXrJYqtIWo5C5s48OCDSjMs1jZ32o=;
 b=Iw+MJ/XCnAFYoETtZDn6sInuzLTpRsyiXunRVWj6is8vDw5StW2x+oA9ZS+11tCKm5
 ECDrCrUm8oN5NB8Nzr1t6fx9hAb51K7U0gYZor/8r7CsuRVMJ3thNVqezg4Ne0ROEIr6
 1AGPDX3k56h5sM4z0mMFlhAswN7/Mmozhzt23oUUQTsQBGCdNnu/aMO5xFSOGXD0ChLX
 mti4v3TdKbd9ZI40xB/jcwft9tpZC4hoNOGoOw2EDQsWPI3aiVfoIdHrh0IiwdOlCxfC
 lDpGSVA1OO0bfidv/4QG6jrhiDNsc4nwx6t89/Zwxi5Mq6RfUE3LsEDmy58vJ9hOGTyF
 JRLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhI9dJx6Tpcu8EjcmVIBZmPWFxWMX3/L1wc5d/aW+WPHjtAepxAGuiyKXOnX7c8oqetJa7giqD4+J9@nongnu.org
X-Gm-Message-State: AOJu0YyJC3PAxIipS177wNsAJ2bmW/sat2blqGhUbaOB9asME0jS3sik
 lTMS5vceUOY6vvQdm3sKKesKQuQG/98Xqto4MrSMvv2Htrscx3fP0dSkwARQMzT1FWifG3i6OuP
 0DcGJ
X-Gm-Gg: ASbGncs2YeG3JlnvlEC4dQj64TbmVe8VtnQ5zI/XA6LMUNLa4WaGndpjd7cDA4mbtq7
 CJKLyhOt8g4iD4ywce9fQlcouRX6+d0SdsOc+xlPO1UBc9ZlYmJaNV4VN7hBqVh3wCLDYLoDhON
 SRW0IfMgy6y/8b+ssrPyn1A4mXgLKom4+nxtKniDhNjtiF9DsEld8/+D8+6ScH01FyfIFFohTDP
 pacZ9Aplwca9XGTv2bEqY9/SiBYDAQnMbahp9iuERezJAtWfR6vWM/RTKAvGgrCaSLI3D+py7Ll
 Fr47/cU4i+S2L4ZWIJb7EsHyRUM5F5UgWvr4XIisSq656ewZSn/AE53N+LnU0Jq/oMICKO/SH4p
 x7CGDL8YZ1w55N0cYX0FTno1pgq+eHE0qvVU2rcI8+sD+nT0E7UdNYzaleLlxhdNv2w==
X-Google-Smtp-Source: AGHT+IFhAUxs4RNLfENqnkegwfZCjgLo52KMealaWUJYRWktF+GUvHjqSZJoxs9Ow8zGsRPE4PiCvg==
X-Received: by 2002:a05:600c:1548:b0:459:d709:e5b0 with SMTP id
 5b1f17b1804b1-45b5178e893mr109301895e9.5.1756118156175; 
 Mon, 25 Aug 2025 03:35:56 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7119c4192sm11102267f8f.52.2025.08.25.03.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 03:35:55 -0700 (PDT)
Message-ID: <d585141a-07ab-479e-9d56-f58ecc4e7207@linaro.org>
Date: Mon, 25 Aug 2025 12:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, richard.henderson@linaro.org, riku.voipio@iki.fi,
 thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 david@redhat.com, jjherne@linux.ibm.com, shorne@gmail.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 zhao1.liu@intel.com, peter.maydell@linaro.org, agraf@csgraf.de,
 mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de, dirty@apple.com,
 rbolshakov@ddn.com, phil@philjordan.eu, reinoud@netbsd.org,
 sunilmut@microsoft.com, gaosong@loongson.cn, laurent@vivier.eu,
 edgar.iglesias@gmail.com, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 arikalo@gmail.com, chenhuacai@kernel.org, npiggin@gmail.com,
 rathc@linux.ibm.com, harshpb@linux.ibm.com, yoshinori.sato@nifty.com,
 iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821155603.2422553-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Igor,

On 21/8/25 17:56, Igor Mammedov wrote:
> the helpers form load-acquire/store-release pair and use them to replace
> open-coded checkers/setters consistently across the code, which
> ensures that appropriate barriers are in place in case checks happen
> outside of BQL.

I don't understand the beginning of this sentence (even prepending
the patch subject).

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
> v5: fix copy/paste error in doc comment of cpu_set_interrupt()
>     "Jason J. Herne" <jjherne@linux.ibm.com>
> v4:
>     add cpu_set_interrupt() and merge helpers patch with
>     patches that use them (v3 6-7,9/10).
>         Peter Xu <peterx@redhat.com>
> ---
>   include/hw/core/cpu.h               | 25 +++++++++++++++++++++
>   accel/tcg/cpu-exec.c                | 10 ++++-----
>   accel/tcg/tcg-accel-ops.c           |  2 +-
>   accel/tcg/user-exec.c               |  2 +-
>   hw/intc/s390_flic.c                 |  2 +-
>   hw/openrisc/cputimer.c              |  2 +-
>   system/cpus.c                       |  2 +-
>   target/alpha/cpu.c                  |  8 +++----
>   target/arm/cpu.c                    | 20 ++++++++---------
>   target/arm/helper.c                 | 18 +++++++--------
>   target/arm/hvf/hvf.c                |  6 ++---
>   target/avr/cpu.c                    |  2 +-
>   target/hppa/cpu.c                   |  2 +-
>   target/i386/hvf/hvf.c               |  4 ++--
>   target/i386/hvf/x86hvf.c            | 21 +++++++++---------
>   target/i386/kvm/kvm.c               | 34 ++++++++++++++---------------
>   target/i386/nvmm/nvmm-all.c         | 24 ++++++++++----------
>   target/i386/tcg/system/seg_helper.c |  2 +-
>   target/i386/tcg/system/svm_helper.c |  2 +-
>   target/i386/whpx/whpx-all.c         | 34 ++++++++++++++---------------
>   target/loongarch/cpu.c              |  2 +-
>   target/m68k/cpu.c                   |  2 +-
>   target/microblaze/cpu.c             |  2 +-
>   target/mips/cpu.c                   |  6 ++---
>   target/mips/kvm.c                   |  2 +-
>   target/openrisc/cpu.c               |  3 +--
>   target/ppc/cpu_init.c               |  2 +-
>   target/ppc/kvm.c                    |  2 +-
>   target/rx/cpu.c                     |  3 +--
>   target/rx/helper.c                  |  2 +-
>   target/s390x/cpu-system.c           |  2 +-
>   target/sh4/cpu.c                    |  2 +-
>   target/sh4/helper.c                 |  2 +-
>   target/sparc/cpu.c                  |  2 +-
>   target/sparc/int64_helper.c         |  4 ++--
>   35 files changed, 141 insertions(+), 119 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5eaf41a566..1dee9d4c76 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -942,6 +942,31 @@ CPUState *cpu_by_arch_id(int64_t id);
>   
>   void cpu_interrupt(CPUState *cpu, int mask);
>   
> +/**
> + * cpu_test_interrupt:
 > + * @cpu: The CPU to check interrupt(s) on.> + * @mask: The 
interrupts to check.

Can we use plural form to express we might test for more
than one interrupt in the mask?

   -> cpu_test_interrupts()

otherwise cpu_test_interrupt_mask().

> + *
> + * Checks if any of interrupts in @mask are pending on @cpu.
> + */
> +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> +{
> +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
How missing "qemu/atomic.h" header.

> +}
> +
> +/**
> + * cpu_set_interrupt:
> + * @cpu: The CPU to set pending interrupt(s) on.
> + * @mask: The interrupts to set.

Rename plural: cpu_set_interrupts() or _mask().

> + *
> + * Sets interrupts in @mask as pending on @cpu.
> + */
> +static inline void cpu_set_interrupt(CPUState *cpu, int mask)
> +{
> +    qatomic_store_release(&cpu->interrupt_request,
> +        cpu->interrupt_request | mask);

(indent is off)

> +}
> +
The field is described in CPUState as:

   @interrupt_request: Indicates a pending interrupt request.

Can we update the description, mentioning its access should be
via the proper cpu_test_interrupts/cpu_set_interrupts/... helpers?

> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 713bdb2056..1269c2c6ba 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -778,7 +778,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>        */
>       qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
>   
> -    if (unlikely(qatomic_read(&cpu->interrupt_request))) {
> +    if (unlikely(cpu_test_interrupt(cpu, ~0))) {

Maybe nitpicking, but I'd introduce the API and use it first only where
we already use atomic accesses. Then convert the rest of the code base
to this API in a distinct patch.

>           int interrupt_request;
>           bql_lock();
>           interrupt_request = cpu->interrupt_request;
> @@ -786,7 +786,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>               /* Mask out external interrupts for this step. */
>               interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
>           }> -        if (interrupt_request & CPU_INTERRUPT_DEBUG) {
> +        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
>               cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
>               cpu->exception_index = EXCP_DEBUG;
>               bql_unlock();
> @@ -795,7 +795,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>   #if !defined(CONFIG_USER_ONLY)
>           if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
>               /* Do nothing */
> -        } else if (interrupt_request & CPU_INTERRUPT_HALT) {
> +        } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HALT)) {
>               replay_interrupt();
>               cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;

Can we have a cpu_clear_interrupts() helper for completion? Likely we
need the same BQL-safe access.

>               cpu->halted = 1;
> @@ -805,7 +805,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>           } else {
>               const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>   
> -            if (interrupt_request & CPU_INTERRUPT_RESET) {
> +            if (cpu_test_interrupt(cpu, CPU_INTERRUPT_RESET)) {
>                   replay_interrupt();
>                   tcg_ops->cpu_exec_reset(cpu);
>                   bql_unlock();
> @@ -841,7 +841,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>               interrupt_request = cpu->interrupt_request;
>           }
>   #endif /* !CONFIG_USER_ONLY */
> -        if (interrupt_request & CPU_INTERRUPT_EXITTB) {
> +        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
>               cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
>               /* ensure that no TB jump will be modified as
>                  the program flow was changed */
Looking at v4 applied on top of v10.1.0-rc4 reconstructing patch
#6 with v5:

$ git grep -F -- '->interrupt_request'

* Missing cpu_test_interrupts()

target/arm/machine.c:968:        env->irq_line_state = 
cs->interrupt_request &
target/i386/helper.c:600:    int sipi = cs->interrupt_request & 
CPU_INTERRUPT_SIPI;
target/i386/kvm/kvm.c:5067:            events.smi.pending = 
cs->interrupt_request & CPU_INTERRUPT_SMI;
target/i386/kvm/kvm.c:5068:            events.smi.latched_init = 
cs->interrupt_request & CPU_INTERRUPT_INIT;

* Possible uses of qatomic_load_acquire()?

accel/tcg/cpu-exec.c:801:            int interrupt_request = 
cpu->interrupt_request;
accel/tcg/tcg-accel-ops-icount.c:152:    int old_mask = 
cpu->interrupt_request;

* Candidates for cpu_clear_interrupts()

accel/tcg/cpu-exec.c:784:            cpu->interrupt_request &= 
~CPU_INTERRUPT_DEBUG;
accel/tcg/cpu-exec.c:794:            cpu->interrupt_request &= 
~CPU_INTERRUPT_HALT;
accel/tcg/cpu-exec.c:842:            cpu->interrupt_request &= 
~CPU_INTERRUPT_EXITTB;
hw/core/cpu-common.c:79:    cpu->interrupt_request &= ~mask;
hw/core/cpu-system.c:207:        cpu->interrupt_request &= ~0x01;
target/avr/helper.c:50:            cs->interrupt_request &= 
~CPU_INTERRUPT_RESET;
target/avr/helper.c:62:                cs->interrupt_request &= 
~CPU_INTERRUPT_HARD;
target/i386/helper.c:605:    cs->interrupt_request = sipi;
target/i386/hvf/x86hvf.c:400:            cs->interrupt_request &= 
~CPU_INTERRUPT_NMI;
target/i386/hvf/x86hvf.c:412:        cs->interrupt_request &= 
~CPU_INTERRUPT_HARD;
target/i386/hvf/x86hvf.c:440:        cs->interrupt_request &= 
~CPU_INTERRUPT_POLL;
target/i386/hvf/x86hvf.c:453:        cs->interrupt_request &= 
~CPU_INTERRUPT_TPR;
target/i386/kvm/kvm.c:5069:            cs->interrupt_request &= 
~(CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
target/i386/kvm/kvm.c:5459:            cpu->interrupt_request &= 
~CPU_INTERRUPT_NMI;
target/i386/kvm/kvm.c:5470:            cpu->interrupt_request &= 
~CPU_INTERRUPT_SMI;
target/i386/kvm/kvm.c:5505:            cpu->interrupt_request &= 
~CPU_INTERRUPT_HARD;
target/i386/kvm/kvm.c:5600:        cs->interrupt_request &= 
~CPU_INTERRUPT_MCE;
target/i386/kvm/kvm.c:5630:        cs->interrupt_request &= 
~CPU_INTERRUPT_POLL;
target/i386/kvm/kvm.c:5643:        cs->interrupt_request &= 
~CPU_INTERRUPT_TPR;
target/i386/nvmm/nvmm-all.c:422:            cpu->interrupt_request &= 
~CPU_INTERRUPT_NMI;
target/i386/nvmm/nvmm-all.c:431:            cpu->interrupt_request &= 
~CPU_INTERRUPT_HARD;
target/i386/nvmm/nvmm-all.c:440:        cpu->interrupt_request &= 
~CPU_INTERRUPT_SMI;
target/i386/nvmm/nvmm-all.c:700:        cpu->interrupt_request &= 
~CPU_INTERRUPT_POLL;
target/i386/nvmm/nvmm-all.c:713:        cpu->interrupt_request &= 
~CPU_INTERRUPT_TPR;
target/i386/tcg/system/seg_helper.c:181:        cs->interrupt_request &= 
~CPU_INTERRUPT_POLL;
target/i386/tcg/system/seg_helper.c:189:        cs->interrupt_request &= 
~CPU_INTERRUPT_SMI;
target/i386/tcg/system/seg_helper.c:194:        cs->interrupt_request &= 
~CPU_INTERRUPT_NMI;
target/i386/tcg/system/seg_helper.c:199:        cs->interrupt_request &= 
~CPU_INTERRUPT_MCE;
target/i386/tcg/system/seg_helper.c:204:        cs->interrupt_request &= 
~(CPU_INTERRUPT_HARD |
target/i386/tcg/system/seg_helper.c:218:        cs->interrupt_request &= 
~CPU_INTERRUPT_VIRQ;
target/i386/tcg/system/svm_helper.c:827:    cs->interrupt_request &= 
~CPU_INTERRUPT_VIRQ;
target/i386/whpx/whpx-all.c:1474:            cpu->interrupt_request &= 
~CPU_INTERRUPT_NMI;
target/i386/whpx/whpx-all.c:1481:            cpu->interrupt_request &= 
~CPU_INTERRUPT_SMI;
target/i386/whpx/whpx-all.c:1505:                cpu->interrupt_request 
&= ~CPU_INTERRUPT_HARD;
target/i386/whpx/whpx-all.c:1523:        cpu->interrupt_request &= 
~CPU_INTERRUPT_HARD;
target/i386/whpx/whpx-all.c:1610:        cpu->interrupt_request &= 
~CPU_INTERRUPT_POLL;
target/i386/whpx/whpx-all.c:1626:        cpu->interrupt_request &= 
~CPU_INTERRUPT_TPR;
target/openrisc/sys_helper.c:199:                cs->interrupt_request 
&= ~CPU_INTERRUPT_TIMER;
target/rx/helper.c:66:            cs->interrupt_request &= 
~CPU_INTERRUPT_FIR;
target/rx/helper.c:76:            cs->interrupt_request &= 
~CPU_INTERRUPT_HARD;
target/s390x/tcg/excp_helper.c:562:        cs->interrupt_request &= 
~CPU_INTERRUPT_HARD;

