Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C63CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 08:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqSP9-0002a0-0l; Mon, 25 Aug 2025 04:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqSP6-0002Yt-H6; Mon, 25 Aug 2025 04:18:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqSP1-0008TH-Vy; Mon, 25 Aug 2025 04:18:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P5oPsj024844;
 Mon, 25 Aug 2025 08:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0r8OZm
 sZKM1O8FPvKVD9VtykZ5Tn2fwo6zXU1+R6GmI=; b=sQQ4f5cuQ8v7S48nFi9zxD
 wHNFa03EtnQYSghkJhBhUCEOokq4FuB8MHMogcypXxn7hd59q74DgoyTgeC6RZp+
 b/dh20hqAkhMI5oP5r+qXO59GWTTsEUvq0VZzrhylMxw47jigymeLLd0kpcP4mPS
 iE6kNnEUPp/2CTbjDbyDRRne72QbslMRLvMemri8hULw9Uw+NWjN9Ven+zvGF98N
 s4/7i0JnZNhjRa8vD++1GqFozvdvQEnstGnVVSN/HV69M1b4BiHL3DjHVsV1NasI
 G2myDHhLIXUFS72I9o8k22mEPCOH7xRFbGMZatAEGQurMI92HmlqPl36Y0YXUIyQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q557qu07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 08:17:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57P85MBq007360;
 Mon, 25 Aug 2025 08:17:03 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q557qtyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 08:17:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57P4j37u007459;
 Mon, 25 Aug 2025 08:17:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyu53p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 08:17:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57P8H1kQ10946044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 08:17:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0529A5803F;
 Mon, 25 Aug 2025 08:17:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D76EA5804E;
 Mon, 25 Aug 2025 08:16:46 +0000 (GMT)
Received: from [9.39.20.14] (unknown [9.39.20.14])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Aug 2025 08:16:46 +0000 (GMT)
Message-ID: <9fde8cf9-19c4-4265-90dd-75ac4f12c584@linux.ibm.com>
Date: Mon, 25 Aug 2025 13:46:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, richard.henderson@linaro.org, riku.voipio@iki.fi,
 thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 david@redhat.com, jjherne@linux.ibm.com, shorne@gmail.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, peter.maydell@linaro.org,
 agraf@csgraf.de, mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de,
 dirty@apple.com, rbolshakov@ddn.com, phil@philjordan.eu,
 reinoud@netbsd.org, sunilmut@microsoft.com, gaosong@loongson.cn,
 laurent@vivier.eu, edgar.iglesias@gmail.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, chenhuacai@kernel.org,
 npiggin@gmail.com, rathc@linux.ibm.com, yoshinori.sato@nifty.com,
 iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250821155603.2422553-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S4ydI0SUhPXLx3XtApRan3983lJS855O
X-Proofpoint-ORIG-GUID: SeS9AxjnCblwtAd6St5veFXkS1kKE6Jw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX3zSxPxQXGe3G
 Rn1x4sb7fxBNdIv/jBJ5Lge1GThUKF3E+GEMuLpDP1ByKVuhFYQiU5hOuk2qz5Qy+sYJ4u3qKYA
 TJxl0IeMIK8yVAsobx2w3AF1mtKU5gbxz6SD4AZeh/i8W+rULvzpHeI6InQ/E0GYi2s7y7vWQHA
 H9PQ5MBz9gEeWGJ/2ucxT4RwVRRs4o1VEsX0MrOUoRuqAZuKpDpKLXIesZdhRdW0GRD1xa+SIjv
 1ljXJ5hc/6bx/uEvlUuPwHUro+nfYEm+8Z2mtvaRYNP85L099XzvVobwoPK8ml5t37injZxgPwM
 Sox9ZABqYPXw1HOWYjDHmfGZGa/qNmWEgKWu28g6nOMawm13Bax4tz+IXQHq7MdSJci6hcG0SNa
 X75lLtOw
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68ac1c00 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=2cbqLzNlm-FmP95Ks_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/21/25 21:26, Igor Mammedov wrote:
> the helpers form load-acquire/store-release pair and use them to replace
> open-coded checkers/setters consistently across the code, which
> ensures that appropriate barriers are in place in case checks happen
> outside of BQL.
> 
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
> + * @cpu: The CPU to check interrupt(s) on.
> + * @mask: The interrupts to check.
> + *
> + * Checks if any of interrupts in @mask are pending on @cpu.
> + */
> +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> +{
> +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> +}
> +
> +/**
> + * cpu_set_interrupt:
> + * @cpu: The CPU to set pending interrupt(s) on.
> + * @mask: The interrupts to set.
> + *
> + * Sets interrupts in @mask as pending on @cpu.
> + */
> +static inline void cpu_set_interrupt(CPUState *cpu, int mask)
> +{
> +    qatomic_store_release(&cpu->interrupt_request,
> +        cpu->interrupt_request | mask);
> +}
> +
>   /**
>    * cpu_set_pc:
>    * @cpu: The CPU to set the program counter for.
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
>           int interrupt_request;
>           bql_lock();
>           interrupt_request = cpu->interrupt_request;
> @@ -786,7 +786,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>               /* Mask out external interrupts for this step. */
>               interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
>           }
> -        if (interrupt_request & CPU_INTERRUPT_DEBUG) {
> +        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
>               cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;

Do we need a helper for instances like these (logical &) as well ?
I see a couple more such instances below.


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
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 3b0d7d298e..9c37266c1e 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -97,7 +97,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>   /* mask must never be zero, except for A20 change call */
>   void tcg_handle_interrupt(CPUState *cpu, int mask)
>   {
> -    cpu->interrupt_request |= mask;
> +    cpu_set_interrupt(cpu, mask);
>   
>       /*
>        * If called from iothread context, wake the target cpu in
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index f25d80e2dc..fc2eaf420d 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -49,7 +49,7 @@ __thread uintptr_t helper_retaddr;
>   void cpu_interrupt(CPUState *cpu, int mask)
>   {
>       g_assert(bql_locked());
> -    cpu->interrupt_request |= mask;
> +    cpu_set_interrupt(cpu, mask);
>       qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
>   }
>   

<snip>

> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index a0e77f2673..db841f1260 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7225,7 +7225,7 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
>   #ifndef CONFIG_USER_ONLY
>   static bool ppc_cpu_has_work(CPUState *cs)
>   {
> -    return cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 015658049e..d145774b09 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1354,7 +1354,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
>       CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>   
> -    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> +    if (!cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
>           FIELD_EX64(env->msr, MSR, EE)) {
>           cs->halted = 1;
>           cs->exception_index = EXCP_HLT;

For target/ppc:

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index c6dd5d6f83..da02ae7bf8 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -75,8 +75,7 @@ static void rx_restore_state_to_opc(CPUState *cs,
>   
>   static bool rx_cpu_has_work(CPUState *cs)
>   {
> -    return cs->interrupt_request &
> -        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
> +    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
>   }
>   
>   static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
> diff --git a/target/rx/helper.c b/target/rx/helper.c
> index 0640ab322b..ce003af421 100644
> --- a/target/rx/helper.c
> +++ b/target/rx/helper.c
> @@ -44,7 +44,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
>   void rx_cpu_do_interrupt(CPUState *cs)
>   {
>       CPURXState *env = cpu_env(cs);
> -    int do_irq = cs->interrupt_request & INT_FLAGS;
> +    int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
>       uint32_t save_psw;
>   
>       env->in_sleep = 0;
> diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
> index 709ccd5299..f3a9ffb2a2 100644
> --- a/target/s390x/cpu-system.c
> +++ b/target/s390x/cpu-system.c
> @@ -49,7 +49,7 @@ bool s390_cpu_has_work(CPUState *cs)
>           return false;
>       }
>   
> -    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> +    if (!cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
>           return false;
>       }
>   
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 4f561e8c91..21ccb86df4 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -108,7 +108,7 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
>   
>   static bool superh_cpu_has_work(CPUState *cs)
>   {
> -    return cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index fb7642bda1..1744ef0e6d 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -58,7 +58,7 @@ int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
>   void superh_cpu_do_interrupt(CPUState *cs)
>   {
>       CPUSH4State *env = cpu_env(cs);
> -    int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    int do_irq = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
>       int do_exp, irq_vector = cs->exception_index;
>   
>       /* prioritize exceptions over interrupts */
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 245caf2de0..c9773f1540 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -783,7 +783,7 @@ static void sparc_restore_state_to_opc(CPUState *cs,
>   #ifndef CONFIG_USER_ONLY
>   static bool sparc_cpu_has_work(CPUState *cs)
>   {
> -    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> +    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
>              cpu_interrupts_enabled(cpu_env(cs));
>   }
>   #endif /* !CONFIG_USER_ONLY */
> diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
> index bd14c7a0db..49e4e51c6d 100644
> --- a/target/sparc/int64_helper.c
> +++ b/target/sparc/int64_helper.c
> @@ -89,7 +89,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>        * the next bit is (2 << psrpil).
>        */
>       if (pil < (2 << env->psrpil)) {
> -        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
> +        if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
>               trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
>               env->interrupt_index = 0;
>               cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> @@ -120,7 +120,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>                   break;
>               }
>           }
> -    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
> +    } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
>           trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
>                                                 env->interrupt_index);
>           env->interrupt_index = 0;

