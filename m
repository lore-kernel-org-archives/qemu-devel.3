Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0181C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9lC-0001h7-6I; Thu, 20 Mar 2025 02:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1tv9lA-0001gs-Av; Thu, 20 Mar 2025 02:52:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1tv9l7-0000Bl-2U; Thu, 20 Mar 2025 02:52:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JLHJgX011881;
 Thu, 20 Mar 2025 06:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nRwztK
 vl4c9jnndCXnlYG7hDZlaSu5M3rgHzrPviPW4=; b=ZNa6M/uLpKxFu7O8ltYKS5
 D+KLOqpnr5hiUWvHfaFqkqhGe6ONwqQgdLVqKjKSw9qdEEE+cF7eseOtjLEMQe1B
 83a7uHMOq9eBQYEX/9ueLlmauChIoHFybji5aX/2JjLSuJ82iG+JnHkJqWy0/N2j
 K3ML+lyzO+3kLdvfybCzd67namDDAHPwlZLtwl2yjzG0Nps5LL0AYNjxEidnD4tv
 IUaB1XDzyKMznRRKoZqvYXDKqkywtzm7zR+hp6SLXAylKzsQAMRC+COYVKHe/U23
 UxLnPNEeCMitKl3njxOwkjvg8Zl3jRyjeqGqEsh+TJ6PaSBJcJs2MvKj3L+lIPcA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy259bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 06:52:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52K6q0Al014769;
 Thu, 20 Mar 2025 06:52:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy259bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 06:52:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K50XPX012481;
 Thu, 20 Mar 2025 06:51:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp6gte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 06:51:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52K6pw8e3998246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 06:51:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D7D65803F;
 Thu, 20 Mar 2025 06:51:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F77F5804E;
 Thu, 20 Mar 2025 06:51:58 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Mar 2025 06:51:57 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 20 Mar 2025 12:21:57 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ppc/spapr: Fix RTAS stopped state
In-Reply-To: <20250320043443.88829-1-npiggin@gmail.com>
References: <20250320043443.88829-1-npiggin@gmail.com>
Message-ID: <7da3a2fc359c7e5573bc911642c17a5f@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iFwyA881P5Af5nPB7rJKlZnBLhleOleX
X-Proofpoint-GUID: LtDaxiWMW_0LDDkMold3kGf5F36XSmAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200039
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=misanjum@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Thanks for the quick fix.
I tested the patch and I am successfully able to boot the KVM guest.


Console Logs:
# b4 am 20250320043443.88829-1-npiggin@gmail.com --outdir patches
Analyzing 1 messages in the thread
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH] ppc/spapr: Fix RTAS stopped state
   ---
   ✓ Signed: DKIM/gmail.com
---
Total patches: 1
---
  Link: 
https://lore.kernel.org/qemu-devel/20250320043443.88829-1-npiggin@gmail.com

# git am patches/*.mbx
Applying: ppc/spapr: Fix RTAS stopped state

# /usr/bin/qemu-system-ppc64   -name avocado-vt-vm1   -machine 
pseries,accel=kvm   -m 32768   -smp 32,sockets=1,cores=32,threads=1   
-nographic   -device virtio-scsi-pci,id=scsi   -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive0,format=qcow2 
   -device scsi-hd,drive=drive0,bus=scsi.0   -netdev 
bridge,id=net0,br=virbr0   -device virtio-net-pci,netdev=net0   -serial 
pty   -device virtio-balloon-pci   -cpu host
QEMU 9.2.90 monitor - type 'help' for more information
char device redirected to /dev/pts/1 (label serial0)
(qemu)

(In another ssh session)
# screen /dev/pts/1
Preparing to boot Linux version 6.10.4-200.fc40.ppc64le 
(mockbuild@c23cc4e677614c34bb22d54eeea4dc1f) (gcc (GCC) 14.2.1 20240801 
(Red Hat 14.2.1-1), GNU ld version 2.41-37.fc40) #1 SMP Sun Aug 11 
15:20:17 UTC 2024
Detected machine type: 0000000000000101
command line: 
BOOT_IMAGE=(ieee1275/disk,msdos2)/vmlinuz-6.10.4-200.fc40.ppc64le 
root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root crashkernel=1024M
Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
Calling ibm,client-architecture-support... done
memory layout at init:
   memory_limit : 0000000000000000 (16 MB aligned)
   alloc_bottom : 0000000008200000
   alloc_top    : 0000000030000000
   alloc_top_hi : 0000000800000000
   rmo_top      : 0000000030000000
   ram_top      : 0000000800000000
found display   : /pci@800000020000000/vga@0, opening... done
instantiating rtas at 0x000000002fff0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000008210000 -> 0x0000000008210c0d
Device tree struct  0x0000000008220000 -> 0x0000000008230000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000440000 ...
[    0.000000] random: crng init done
[    0.000000] Reserving 1024MB of memory at 512MB for crashkernel 
(System RAM: 32768MB)
[    0.000000] radix-mmu: Page sizes from device-tree:
[    0.000000] radix-mmu: Page size shift = 12 AP=0x0
[    0.000000] radix-mmu: Page size shift = 16 AP=0x5
[    0.000000] radix-mmu: Page size shift = 21 AP=0x1
[    0.000000] radix-mmu: Page size shift = 30 AP=0x2
[    0.000000] Activating Kernel Userspace Access Prevention
[    0.000000] Activating Kernel Userspace Execution Prevention
[    0.000000] radix-mmu: Mapped 0x0000000000000000-0x0000000003950000 
with 64.0 KiB pages (exec)
[    0.000000] radix-mmu: Mapped 0x0000000003950000-0x0000000800000000 
with 64.0 KiB pages
[    0.000000] lpar: Using radix MMU under hypervisor
[    0.000000] Linux version 6.10.4-200.fc40.ppc64le 
(mockbuild@c23cc4e677614c34bb22d54eeea4dc1f) (gcc (GCC) 14.2.1 20240801 
(Red Hat 14.2.1-1), GNU ld version 2.41-37.fc40) #1 SMP Sun Aug 11 
15:20:17 UTC 2024
...
...
** Boot Successful


Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>

Thanks,
Misbah Anjum N

On 2025-03-20 10:04, Nicholas Piggin wrote:
> This change takes the CPUPPCState 'quiesced' field added for powernv
> hardware CPU core controls (used to stop and start cores), and extends
> it to spapr to model the "RTAS stopped" state. This prevents the
> schedulers attempting to run stopped CPUs unexpectedly, which can cause
> hangs and possibly other unexpected behaviour.
> 
> The detail of the problematic situation is this:
> 
> A KVM spapr guest boots with all secondary CPUs defined to be in the
> "RTAS stopped" state. In this state, the CPU is only responsive to the
> start-cpu RTAS call. This behaviour is modeled in QEMU with the
> start_powered_off feature, which sets ->halted on secondary CPUs at
> boot. ->halted=true looks like an idle / sleep / power-save state which
> typically is responsive to asynchronous interrupts, but spapr clears
> wake-on-interrupt bits in the LPCR SPR. This more-or-less works.
> 
> Commit e8291ec16da8 ("target/ppc: fix timebase register reset state")
> recently caused the decrementer to expire sooner at boot, causing a
> decrementer exception on secondary CPUs in RTAS stopped state. This
> was not a problem on TCG, but KVM limits how a guest can modify LPCR, 
> in
> particular it prevents the clearing of wake-on-interrupt bits, and so 
> in
> the course of CPU register synchronisation, the LPCR as set by spapr to
> model the RTAS stopped state is overwritten with KVM's LPCR value, and
> that then causes QEMU's interrupt code to notice the expired 
> decrementer
> exception, turn that into an interrupt, and set CPU_INTERRUPT_HARD.
> 
> That causes the CPU to be kicked, and the KVM vCPU thread to loop
> calling kvm_cpu_exec(). kvm_cpu_exec() calls
> kvm_arch_process_async_events(), which on ppc just returns ->halted.
> This is still true, so it returns immediately with EXCP_HLT, and the
> vCPU never goes to sleep because qemu_wait_io_event() sees
> CPU_INTERRUPT_HARD is set. All this while the vCPU holds the bql.  This
> causes the boot CPU to eventually lock up when it needs the bql.
> 
> So make 'quiesced' represent the "RTAS stopped" state, and have it
> explicitly not respond to exceptions (interrupt conditions) rather than
> rely on machine register state to model that state. This matches the
> powernv quiesced state very well because it essentially turns off the
> CPU core via a side-band control unit.
> 
> There are still issues with QEMU and KVM idea of LPCR diverging and 
> that
> is quite ugly and fragile that should be fixed. spapr should 
> synchronize
> its LPCR properly with KVM, and not try to use values that KVM does not
> support.
> 
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/cpu.h         | 11 +++++++++++
>  hw/ppc/pnv_core.c        |  6 +++++-
>  hw/ppc/spapr_cpu_core.c  |  6 ++++++
>  hw/ppc/spapr_rtas.c      |  5 ++++-
>  target/ppc/excp_helper.c |  4 ++++
>  5 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index efab54a0683..3ee83517dcd 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1356,6 +1356,17 @@ struct CPUArchState {
>       * special way (such as routing some resume causes to 0x100, i.e. 
> sreset).
>       */
>      bool resume_as_sreset;
> +
> +    /*
> +     * On powernv, quiesced means the CPU has been stopped using PC 
> direct
> +     * control xscom registers.
> +     *
> +     * On spapr, quiesced means it is in the "RTAS stopped" state.
> +     *
> +     * The core halted/stopped variables aren't sufficient for this, 
> because
> +     * they can be changed with various side-band operations like qmp 
> cont,
> +     * powersave interrupts, etc.
> +     */
>      bool quiesced;
>  #endif
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 99d9644ee38..a33977da188 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -248,21 +248,25 @@ static void pnv_core_power10_xscom_write(void
> *opaque, hwaddr addr,
> 
>              if (val & PPC_BIT(7 + 8 * i)) { /* stop */
>                  val &= ~PPC_BIT(7 + 8 * i);
> -                cpu_pause(cs);
>                  env->quiesced = true;
> +                ppc_maybe_interrupt(env);
> +                cpu_pause(cs);
>              }
>              if (val & PPC_BIT(6 + 8 * i)) { /* start */
>                  val &= ~PPC_BIT(6 + 8 * i);
>                  env->quiesced = false;
> +                ppc_maybe_interrupt(env);
>                  cpu_resume(cs);
>              }
>              if (val & PPC_BIT(4 + 8 * i)) { /* sreset */
>                  val &= ~PPC_BIT(4 + 8 * i);
>                  env->quiesced = false;
> +                ppc_maybe_interrupt(env);
>                  pnv_cpu_do_nmi_resume(cs);
>              }
>              if (val & PPC_BIT(3 + 8 * i)) { /* clear maint */
>                  env->quiesced = false;
> +                ppc_maybe_interrupt(env);
>                  /*
>                   * Hardware has very particular cases for where clear 
> maint
>                   * must be used and where start must be used to resume 
> a
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 0671d9e44b4..faf9170ba6b 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -37,6 +37,9 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
> 
>      cpu_reset(cs);
> 
> +    env->quiesced = true; /* set "RTAS stopped" state. */
> +    ppc_maybe_interrupt(env);
> +
>      /*
>       * "PowerPC Processor binding to IEEE 1275" defines the initial 
> MSR state
>       * as 32bit (MSR_SF=0) with MSR_ME=1 and MSR_FP=1 in "8.2.1. 
> Initial
> @@ -98,6 +101,9 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu,
> target_ulong nip,
>      CPU(cpu)->halted = 0;
>      /* Enable Power-saving mode Exit Cause exceptions */
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
> +
> +    env->quiesced = false; /* clear "RTAS stopped" state. */
> +    ppc_maybe_interrupt(env);
>  }
> 
>  /*
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 503d441b48e..78309dbb09d 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -110,7 +110,8 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU 
> *cpu_,
>      id = rtas_ld(args, 0);
>      cpu = spapr_find_cpu(id);
>      if (cpu != NULL) {
> -        if (CPU(cpu)->halted) {
> +        CPUPPCState *env = &cpu->env;
> +        if (env->quiesced) {
>              rtas_st(rets, 1, 0);
>          } else {
>              rtas_st(rets, 1, 2);
> @@ -215,6 +216,8 @@ static void rtas_stop_self(PowerPCCPU *cpu,
> SpaprMachineState *spapr,
>       * For the same reason, set PSSCR_EC.
>       */
>      env->spr[SPR_PSSCR] |= PSSCR_EC;
> +    env->quiesced = true; /* set "RTAS stopped" state. */
> +    ppc_maybe_interrupt(env);
>      cs->halted = 1;
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
>      kvmppc_set_reg_ppc_online(cpu, 0);
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 44e19aacd8d..c941c89806e 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1951,6 +1951,10 @@ static int 
> ppc_next_unmasked_interrupt(CPUPPCState *env)
>      target_ulong lpcr = env->spr[SPR_LPCR];
>      bool async_deliver;
> 
> +    if (unlikely(env->quiesced)) {
> +        return 0;
> +    }
> +
>  #ifdef TARGET_PPC64
>      switch (env->excp_model) {
>      case POWERPC_EXCP_POWER7:

