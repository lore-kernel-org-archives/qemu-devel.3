Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8799C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 06:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjvmU-0003U9-Tr; Tue, 12 Mar 2024 02:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjvmO-0003Tn-Rn; Tue, 12 Mar 2024 02:38:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjvmL-0008Ls-3S; Tue, 12 Mar 2024 02:38:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C6b9M6022075; Tue, 12 Mar 2024 06:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Z3HASq7+gyMI4oanTYo79sYaUuiKe8q43m9s3hI4x1s=;
 b=kt9nO8Aq4VCYzlhGRExZipmK4mGRjbtsdMjtyngoF6OauXwTtFSStq0iN93l44z6cJJC
 M0sHySt8MjD4HCoG+pohPeHH3YePZa8YFAZK3SRKLXO3ap15kgvVxfFCRxy/1YKm4VBb
 NBCiZQAIOrAqhKhJaRJ+xfpuL9PvM7KfWMTKtJm9bpa1DIupIAZSlYIOrWTKRZKgvSYR
 wo4s/CUfLHU37xaxzDFHBeNGmwUcuWNm4GT4cIVO+HybKmPFBvgr5+QzQuz8Rg7FTZTb
 Gq8OCdu/2sAdGYPL2VhHasLNEzRt7ZadHw7gmiOJO08jKWBL0nmI828HX6DdmN6d31iT CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wthxh8079-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 06:38:10 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C6c9FN024422;
 Tue, 12 Mar 2024 06:38:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wthxh8076-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 06:38:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C66T3Z014855; Tue, 12 Mar 2024 06:38:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33nnb9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 06:38:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C6c6YF22086202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 06:38:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0197058062;
 Tue, 12 Mar 2024 06:38:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8AEF5806B;
 Tue, 12 Mar 2024 06:38:03 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 06:38:03 +0000 (GMT)
Message-ID: <a465cc07-17ee-48ea-95e6-14c15697ab09@linux.ibm.com>
Date: Tue, 12 Mar 2024 12:08:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spapr: avoid overhead of finding vhyp class in critical
 operations
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240224073359.1025835-1-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240224073359.1025835-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V2qx_0hOABw1_wpKRcRa4o2G90HivMp2
X-Proofpoint-GUID: 42MRTp-0glqbpyYR-ST6JoSVDPXIWDfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_05,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Nick,

One minor comment below:

On 2/24/24 13:03, Nicholas Piggin wrote:
> PPC_VIRTUAL_HYPERVISOR_GET_CLASS is used in critical operations like
> interrupts and TLB misses and is quite costly. Running the
> kvm-unit-tests sieve program with radix MMU enabled thrashes the TCG
> TLB and spends a lot of time in TLB and page table walking code. The
> test takes 67 seconds to complete with a lot of time being spent in
> code related to finding the vhyp class:
> 
>     12.01%  [.] g_str_hash
>      8.94%  [.] g_hash_table_lookup
>      8.06%  [.] object_class_dynamic_cast
>      6.21%  [.] address_space_ldq
>      4.94%  [.] __strcmp_avx2
>      4.28%  [.] tlb_set_page_full
>      4.08%  [.] address_space_translate_internal
>      3.17%  [.] object_class_dynamic_cast_assert
>      2.84%  [.] ppc_radix64_xlate
> 
> Keep a pointer to the class and avoid this lookup. This reduces the
> execution time to 40 seconds.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This feels a bit ugly, but the performance problem of looking up the
> class in fast paths can't be ignored. Is there a "nicer" way to get the
> same result?
> 
> Thanks,
> Nick
> 
>   target/ppc/cpu.h           |  3 ++-
>   target/ppc/mmu-book3s-v3.h |  4 +---
>   hw/ppc/pegasos2.c          |  1 +
>   target/ppc/cpu_init.c      |  9 +++------
>   target/ppc/excp_helper.c   | 16 ++++------------
>   target/ppc/kvm.c           |  4 +---
>   target/ppc/mmu-hash64.c    | 16 ++++------------
>   target/ppc/mmu-radix64.c   |  4 +---
>   8 files changed, 17 insertions(+), 40 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index ec14574d14..eb85d9aa71 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1437,6 +1437,7 @@ struct ArchCPU {
>       int vcpu_id;
>       uint32_t compat_pvr;
>       PPCVirtualHypervisor *vhyp;
> +    PPCVirtualHypervisorClass *vhyp_class;
>       void *machine_data;
>       int32_t node_id; /* NUMA node this CPU belongs to */
>       PPCHash64Options *hash64_opts;
> @@ -1535,7 +1536,7 @@ DECLARE_OBJ_CHECKERS(PPCVirtualHypervisor, PPCVirtualHypervisorClass,
>   
>   static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
>   {
> -    return PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp)->cpu_in_nested(cpu);
> +    return cpu->vhyp_class->cpu_in_nested(cpu);
>   }
>   #endif /* CONFIG_USER_ONLY */
>   
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 674377a19e..f3f7993958 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -108,9 +108,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
>       uint64_t base;
>   
>       if (cpu->vhyp) {

All the checks for cpu->vhyp needs to be changed to check for 
cpu->vhyp_class now, for all such instances.

With that,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        return vhc->hpt_mask(cpu->vhyp);
> +        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
>       }
>       if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
>           ppc_v3_pate_t pate;
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 04d6decb2b..c22e8b336d 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -400,6 +400,7 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
>       machine->fdt = fdt;
>   
>       pm->cpu->vhyp = PPC_VIRTUAL_HYPERVISOR(machine);
> +    pm->cpu->vhyp_class = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(pm->cpu->vhyp);
>   }
>   
>   enum pegasos2_rtas_tokens {
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 9bccddb350..63d0094024 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6631,6 +6631,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>       CPUPPCState *env = &cpu->env;
>   
>       cpu->vhyp = vhyp;
> +    cpu->vhyp_class = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(vhyp);
>   
>       /*
>        * With a virtual hypervisor mode we never allow the CPU to go
> @@ -7224,9 +7225,7 @@ static void ppc_cpu_exec_enter(CPUState *cs)
>       PowerPCCPU *cpu = POWERPC_CPU(cs);
>   
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->cpu_exec_enter(cpu->vhyp, cpu);
> +        cpu->vhyp_class->cpu_exec_enter(cpu->vhyp, cpu);
>       }
>   }
>   
> @@ -7235,9 +7234,7 @@ static void ppc_cpu_exec_exit(CPUState *cs)
>       PowerPCCPU *cpu = POWERPC_CPU(cs);
>   
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->cpu_exec_exit(cpu->vhyp, cpu);
> +        cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
>       }
>   }
>   #endif /* CONFIG_TCG */
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 98952de267..445350488c 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -840,9 +840,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>            * HV mode, we need to keep hypercall support.
>            */
>           if (lev == 1 && cpu->vhyp) {
> -            PPCVirtualHypervisorClass *vhc =
> -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -            vhc->hypercall(cpu->vhyp, cpu);
> +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
>               powerpc_reset_excp_state(cpu);
>               return;
>           }
> @@ -1012,9 +1010,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>            * HV mode, we need to keep hypercall support.
>            */
>           if (lev == 1 && cpu->vhyp) {
> -            PPCVirtualHypervisorClass *vhc =
> -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -            vhc->hypercall(cpu->vhyp, cpu);
> +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
>               powerpc_reset_excp_state(cpu);
>               return;
>           }
> @@ -1534,9 +1530,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   
>           /* "PAPR mode" built-in hypercall emulation */
>           if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
> -            PPCVirtualHypervisorClass *vhc =
> -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -            vhc->hypercall(cpu->vhyp, cpu);
> +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
>               powerpc_reset_excp_state(cpu);
>               return;
>           }
> @@ -1677,10 +1671,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       }
>   
>       if ((new_msr & MSR_HVB) && books_vhyp_handles_hv_excp(cpu)) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>           /* Deliver interrupt to L1 by returning from the H_ENTER_NESTED call */
> -        vhc->deliver_hv_excp(cpu, excp);
> +        cpu->vhyp_class->deliver_hv_excp(cpu, excp);
>   
>           powerpc_reset_excp_state(cpu);
>   
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 26fa9d0575..5b5b96ab6b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -862,9 +862,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
>       sregs.pvr = env->spr[SPR_PVR];
>   
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        sregs.u.s.sdr1 = vhc->encode_hpt_for_kvm_pr(cpu->vhyp);
> +        sregs.u.s.sdr1 = cpu->vhyp_class->encode_hpt_for_kvm_pr(cpu->vhyp);
>       } else {
>           sregs.u.s.sdr1 = env->spr[SPR_SDR1];
>       }
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index d645c0bb94..196b4b2a48 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -516,9 +516,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
>       const ppc_hash_pte64_t *hptes;
>   
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        return vhc->map_hptes(cpu->vhyp, ptex, n);
> +        return cpu->vhyp_class->map_hptes(cpu->vhyp, ptex, n);
>       }
>       base = ppc_hash64_hpt_base(cpu);
>   
> @@ -538,9 +536,7 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
>                               hwaddr ptex, int n)
>   {
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->unmap_hptes(cpu->vhyp, hptes, ptex, n);
> +        cpu->vhyp_class->unmap_hptes(cpu->vhyp, hptes, ptex, n);
>           return;
>       }
>   
> @@ -820,9 +816,7 @@ static void ppc_hash64_set_r(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
>       hwaddr base, offset = ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_R;
>   
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->hpte_set_r(cpu->vhyp, ptex, pte1);
> +        cpu->vhyp_class->hpte_set_r(cpu->vhyp, ptex, pte1);
>           return;
>       }
>       base = ppc_hash64_hpt_base(cpu);
> @@ -837,9 +831,7 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
>       hwaddr base, offset = ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_C;
>   
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->hpte_set_c(cpu->vhyp, ptex, pte1);
> +        cpu->vhyp_class->hpte_set_c(cpu->vhyp, ptex, pte1);
>           return;
>       }
>       base = ppc_hash64_hpt_base(cpu);
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 5823e039e6..496ba87a95 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -677,9 +677,7 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
>   
>       /* Get Partition Table */
>       if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc;
> -        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        if (!vhc->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
> +        if (!cpu->vhyp_class->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
>               if (guest_visible) {
>                   ppc_radix64_raise_hsi(cpu, access_type, eaddr, eaddr,
>                                         DSISR_R_BADCONFIG);

