Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C77CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsEp-0000WC-7d; Thu, 23 Oct 2025 06:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBsEl-0000Vy-Ab; Thu, 23 Oct 2025 06:08:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBsEi-0003vv-IP; Thu, 23 Oct 2025 06:08:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N2LrBt023518;
 Thu, 23 Oct 2025 10:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ipZL/l
 ZgcW8ul80jXZEGZrnl5c2WTkVyVXECWhlLjaY=; b=SVw0JGvc1e0j0VI6Xl/xAq
 E6yUNPzZfJ0qR0sbCAD2D9btGJEJxr9oIytx2JTbrN0do3UbEngmuWMc0JCyEsbE
 ex/bvIXWb2yZeUK0u4HTt+OhwK10jrrhaPxht+Z5Uh5U1AT1nBGMJ1nXZILunVK3
 75sG/pJdmwDodUX57J2MuUoE6FreCVpfPev7f/xHFPuLXBLOZwQms7fDPGLgP9M3
 fwePfGu+Cp6ww7onkk6WHFsFM74XaZgY1oUAWS6ljCQBwBgBTQVzYBxnphECBqE8
 tJH/OysTLQ06RvQsoO6SVG2TYgFXi0dn9hxqccecjgeTmUqMm7JqP7T1WMT/snFQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w031g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 10:07:51 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NA7oDA006696;
 Thu, 23 Oct 2025 10:07:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w031e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 10:07:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6Z63C024953;
 Thu, 23 Oct 2025 10:07:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk52hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 10:07:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NA7n6h6947484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 10:07:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7322758057;
 Thu, 23 Oct 2025 10:07:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 137A058059;
 Thu, 23 Oct 2025 10:07:47 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 10:07:46 +0000 (GMT)
Message-ID: <ff63dc6b-42c7-44f8-b0d0-268d3745a88f@linux.ibm.com>
Date: Thu, 23 Oct 2025 15:37:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Remove the unusable e200 CPUs
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251017144504.563594-1-thuth@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251017144504.563594-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xc0n2GuNhGdILHPzoB6XHpOExHetPNAX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5ArnXRK4YDvh
 Lf2gQYMwtU3IAZLzBfNXwKSX6ZRHpQXL5WFe2UIuA7qr2jyN1GfZyzFDcDvm6B65+sajan/awpc
 291P6llev9k9imZlQVtoiH86hlEE06ObPRgpGmvMvOKkFU6LuKXxOYkFItgm26SoxK4ApwoPch4
 GSRMjhbi336mifyOdNdlquZpnrksE45XKp01wInR+eraW7mzOJmavBITiWSvFayrTJYbqn7lxhD
 1aMicR1VeVutQWTuHa4w2Sc2HiSVfA3PKIWvHJiGmsThZflI3I69hvIT4KZI4KZ5g9XcgmaRk+7
 nnZ/Bs//+qkfxK8xSluzi7OqBRyUy63rIUcINxh6U0LDnRNSCqD1QSBW7Mz7FVze5DJFgJRspKU
 3I4RKu/99+Puu6OQ0J0xkWvQcZxnfw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f9fe77 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=jbIhCXDeA65-yuyFUw0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: K5CU3tzGVvn8CREWeZWeTYanFJcSuT2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Thomas,
I am seeing below CI failure with this patch:

In file included from ../target/ppc/cpu_init.c:46:
In function ‘register_BookE206_sprs’,
     inlined from ‘init_proc_e500’ at ../target/ppc/cpu_init.c:2910:5:
../target/ppc/spr_common.h:57:5: error: array subscript 3 is outside 
array bounds of ‘uint32_t[2]’ {aka ‘unsigned int[2]’} 
[-Werror=array-bounds=]
    57 |     _spr_register(env, num, name, 
              \
       | 
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    58 |                   USR_ARG(uea_read) USR_ARG(uea_write) 
              \
       | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    59 |                   SYS_ARG(oea_read) SYS_ARG(oea_write) 
              \
       | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    60 |                   SYS_ARG(hea_read) SYS_ARG(hea_write) 
              \
       | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    61 |                   KVM_ARG(one_reg_id) initial_value)
       |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/ppc/spr_common.h:66:5: note: in expansion of macro 
‘spr_register_kvm_hv’
    66 |     spr_register_kvm_hv(env, num, name, uea_read, uea_write, 
oea_read,       \
       |     ^~~~~~~~~~~~~~~~~~~
../target/ppc/spr_common.h:77:5: note: in expansion of macro 
‘spr_register_kvm’
    77 |     spr_register_kvm(env, num, name, uea_read, uea_write, 
              \
       |     ^~~~~~~~~~~~~~~~
../target/ppc/cpu_init.c:894:9: note: in expansion of macro ‘spr_register’
   894 |         spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
       |         ^~~~~~~~~~~~
../target/ppc/cpu_init.c: In function ‘init_proc_e500’:
../target/ppc/cpu_init.c:2809:14: note: at offset 12 into object 
‘tlbncfg’ of size 8
  2809 |     uint32_t tlbncfg[2];
       |              ^~~~~~~
In function ‘register_BookE206_sprs’,
     inlined from ‘init_proc_e500’ at ../target/ppc/cpu_init.c:2910:5:
../target/ppc/spr_common.h:57:5: error: array subscript 2 is outside 
array bounds of ‘uint32_t[2]’ {aka ‘unsigned int[2]’} 
[-Werror=array-bounds=]
    57 |     _spr_register(env, num, name, 
              \
       | 
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    58 |                   USR_ARG(uea_read) USR_ARG(uea_write) 
              \
       | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    59 |                   SYS_ARG(oea_read) SYS_ARG(oea_write) 
              \
       | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    60 |                   SYS_ARG(hea_read) SYS_ARG(hea_write) 
              \
       | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    61 |                   KVM_ARG(one_reg_id) initial_value)
       |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/ppc/spr_common.h:66:5: note: in expansion of macro 
‘spr_register_kvm_hv’
    66 |     spr_register_kvm_hv(env, num, name, uea_read, uea_write, 
oea_read,       \
       |     ^~~~~~~~~~~~~~~~~~~
../target/ppc/spr_common.h:77:5: note: in expansion of macro 
‘spr_register_kvm’
    77 |     spr_register_kvm(env, num, name, uea_read, uea_write, 
              \
       |     ^~~~~~~~~~~~~~~~
../target/ppc/cpu_init.c:900:9: note: in expansion of macro ‘spr_register’
   900 |         spr_register(env, SPR_BOOKE_TLB2CFG, "TLB2CFG",
       |         ^~~~~~~~~~~~
../target/ppc/cpu_init.c: In function ‘init_proc_e500’:
../target/ppc/cpu_init.c:2809:14: note: at offset 8 into object 
‘tlbncfg’ of size 8
  2809 |     uint32_t tlbncfg[2];
       |              ^~~~~~~
cc1: all warnings being treated as errors
[1374/1838] Compiling C object 
libqemu-ppc-softmmu.a.p/target_ppc_gdbstub.c.o
[1375/1838] Compiling C object 
libqemu-ppc-softmmu.a.p/target_ppc_cpu-models.c.o
ninja: build stopped: subcommand failed.
make: *** [Makefile:168: run-ninja] Error 1
Cleaning up project directory and file based variables
00:00
ERROR: Job failed: exit code 1

Kindly take a look.

regards,
Harsh

On 10/17/25 20:15, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> There is currently no machine in QEMU (except the "none" machine)
> that can be run with one of the e200 ppc CPUs - all machines either
> complain about an invalid CPU type or crash QEMU immediatly.
> 
> Looking at the history of this CPU type, it seems like it has never
> been used in QEMU and only implemented as a placeholder (see e.g. the
> comment about unimplemented instructions in the POWERPC_FAMILY(e200)
> section of cpu_init.c). Being completely unused and unusable since
> such a long time, let's just remove it now.
> 
> Note: The init_excp_e200() is used by the e500 CPUs, too, so we
> rename this function to init_excp_e500() instead of removing it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/ppc/cpu-models.h |   4 --
>   target/ppc/cpu-models.c |   5 --
>   target/ppc/cpu_init.c   | 147 +---------------------------------------
>   3 files changed, 2 insertions(+), 154 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index c6cd27f390e..a439eb37ee4 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -120,10 +120,6 @@ enum {
>   #define CPU_POWERPC_MPC5200_v12      CPU_POWERPC_G2LEgp1
>   #define CPU_POWERPC_MPC5200B_v20     CPU_POWERPC_G2LEgp1
>   #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
> -    /* e200 family */
> -    /* e200 cores */
> -    CPU_POWERPC_e200z5             = 0x81000000,
> -    CPU_POWERPC_e200z6             = 0x81120000,
>       /* e300 family */
>       /* e300 cores */
>       CPU_POWERPC_e300c1             = 0x00830010,
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 89ae763c7f6..26b6debcfc9 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -244,11 +244,6 @@
>                       CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, G2LE)
>       POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
>                       CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2LE)
> -    /* e200 family                                                           */
> -    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 e200,
> -                "PowerPC e200z5 core")
> -    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 e200,
> -                "PowerPC e200z6 core")
>       /* e300 family                                                           */
>       POWERPC_DEF("e300c1",        CPU_POWERPC_e300c1,                 e300,
>                   "PowerPC e300c1 core")
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 3aa3aefc136..c3284bcbd3f 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -1825,7 +1825,7 @@ static void init_excp_G2(CPUPPCState *env)
>   #endif
>   }
>   
> -static void init_excp_e200(CPUPPCState *env, target_ulong ivpr_mask)
> +static void init_excp_e500(CPUPPCState *env, target_ulong ivpr_mask)
>   {
>   #if !defined(CONFIG_USER_ONLY)
>       env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000FFC;
> @@ -2796,149 +2796,6 @@ POWERPC_FAMILY(G2LE)(ObjectClass *oc, const void *data)
>                    POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
>   }
>   
> -static void init_proc_e200(CPUPPCState *env)
> -{
> -    register_BookE_sprs(env, 0x000000070000FFFFULL);
> -
> -    spr_register(env, SPR_BOOKE_SPEFSCR, "SPEFSCR",
> -                 &spr_read_spefscr, &spr_write_spefscr,
> -                 &spr_read_spefscr, &spr_write_spefscr,
> -                 0x00000000);
> -    /* Memory management */
> -    register_BookE206_sprs(env, 0x0000005D, NULL, 0);
> -    register_usprgh_sprs(env);
> -
> -    spr_register(env, SPR_HID0, "HID0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_HID1, "HID1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_ALTCTXCR, "ALTCTXCR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_BUCSR, "BUCSR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_CTXCR, "CTXCR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_DBCNT, "DBCNT",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_DBCR3, "DBCR3",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_L1CFG0, "L1CFG0",
> -                 &spr_read_generic, SPR_NOACCESS,
> -                 &spr_read_generic, SPR_NOACCESS,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_L1CSR0, "L1CSR0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_L1FINV0, "L1FINV0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_MMUCSR0, "MMUCSR0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000); /* TOFIX */
> -
> -    init_tlbs_emb(env);
> -    init_excp_e200(env, 0xFFFF0000UL);
> -    env->dcache_line_size = 32;
> -    env->icache_line_size = 32;
> -    /* XXX: TODO: allocate internal IRQ controller */
> -}
> -
> -POWERPC_FAMILY(e200)(ObjectClass *oc, const void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(oc);
> -    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> -
> -    dc->desc = "e200 core";
> -    pcc->init_proc = init_proc_e200;
> -    pcc->check_pow = check_pow_hid0;
> -    pcc->check_attn = check_attn_none;
> -    /*
> -     * XXX: unimplemented instructions:
> -     * dcblc
> -     * dcbtlst
> -     * dcbtstls
> -     * icblc
> -     * icbtls
> -     * tlbivax
> -     * all SPE multiply-accumulate instructions
> -     */
> -    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL |
> -                       PPC_SPE | PPC_SPE_SINGLE |
> -                       PPC_WRTEE | PPC_RFDI |
> -                       PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
> -                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
> -                       PPC_MEM_TLBSYNC | PPC_TLBIVAX |
> -                       PPC_BOOKE;
> -    pcc->msr_mask = (1ull << MSR_UCLE) |
> -                    (1ull << MSR_SPE) |
> -                    (1ull << MSR_POW) |
> -                    (1ull << MSR_CE) |
> -                    (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_FE0) |
> -                    (1ull << MSR_DWE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_FE1) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR);
> -    pcc->mmu_model = POWERPC_MMU_BOOKE206;
> -    pcc->excp_model = POWERPC_EXCP_BOOKE;
> -    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
> -    pcc->bfd_mach = bfd_mach_ppc_860;
> -    pcc->flags = POWERPC_FLAG_SPE | POWERPC_FLAG_CE |
> -                 POWERPC_FLAG_UBLE | POWERPC_FLAG_DE |
> -                 POWERPC_FLAG_BUS_CLK;
> -}
> -
>   enum fsl_e500_version {
>       fsl_e500v1,
>       fsl_e500v2,
> @@ -3173,7 +3030,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
>       }
>   #endif
>   
> -    init_excp_e200(env, ivpr_mask);
> +    init_excp_e500(env, ivpr_mask);
>       /* Allocate hardware IRQ controller */
>       ppce500_irq_init(env_archcpu(env));
>   }

