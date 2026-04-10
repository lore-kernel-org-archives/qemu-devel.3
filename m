Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDFE99049
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB668-0002Ke-7E; Fri, 10 Apr 2026 03:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1wB666-0002K1-2c; Fri, 10 Apr 2026 03:16:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1wB664-0004hx-Aj; Fri, 10 Apr 2026 03:16:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639LDaWH2326338; Fri, 10 Apr 2026 07:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NnRxgs
 8uCVhsjkfC8QTCVCXzpNWTDgDGCkUn4+e7VUI=; b=Sgrm+jrRxMrcbnc2AsW0KR
 u/lI2M2vRvmzv/6jyaCLijxOmZI2+QAd2z08nhWOhbH97rwjG1YuEscOE4qoIWwR
 C+gCCjrRQ1Ui+cxg4unxCBxeBI+XbDRUHUsIhckTYkOTiDYjfqqbEiPUmhZ4nF5P
 DERLB74Pa7GPBk8YdUAuaXvftFzDs+jxOr/or+oCJOIPpW74ZoqG6La6Qh/x0vyb
 FF5Su3efLZvVdZqNw6eBzUKZa4A0LHrKY4vggr03H87emiAe+vowiGJxOBmjv+gv
 aA1YK96uT8fai0fnwraZI7IVcB92VXqMd/S3OCLTBwuf7O3UAQqSP1vLIyOcmfgA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kqqj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 07:16:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A3ch4X014378;
 Fri, 10 Apr 2026 07:16:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4y0dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 07:16:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63A7G2YF65798452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 07:16:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFC2C58043;
 Fri, 10 Apr 2026 07:16:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D8A35805F;
 Fri, 10 Apr 2026 07:16:01 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 07:16:01 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 10 Apr 2026 12:46:00 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Anisinha
 <anisinha@redhat.com>, Pbonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 gautam@linux.ibm.com, peter.maydell@linaro.org
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
In-Reply-To: <20260409161042.55281-1-harshpb@linux.ibm.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
Message-ID: <4fee7176e93e91a75e39ef141db2675f@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2MSBTYWx0ZWRfX6jKPEGteKutG
 I53l9toAbqBbiI3Lg/zZM7B/q6GS+L0RAr44va7H0ry/fWw/iqytPuBiZhOnB/YvZIZowuI/iuK
 iZHAzFvu/cGWjQ5yLscJ1M97qJ5OLxeOtbqu1rL2qX5VWZC1FKMTCvr4wGuXDUci147UZOp4JFe
 5mlOhFlgzdfpFLip1ROJ3BkmTfhjXp8e2p6JJVBXnnYWiETiz61MidNJ2xtF0LnVwvlJ+By2f9N
 Rh6zyL70M315y+uLO0L9vqNvll6LH4u8OhV1Wcmm1TrTRtoYVN1vwMfFK7lHXRjARvQAqlTZndz
 MTetl0Bnd9rjfEhX2+WLmQkZbeZJ30KqQqJ0qqchePGvQ3+laAsIpz2WdqumlRzwYMOrcIS+KEQ
 jUZXq9oqI+i3I/lZ0pyNTI/4QlLU68H4GKlWLnTOML6EjTsM96N2MJUHKn7dFAXcuW045JL2c4R
 /eA6Ps5FGNApxHymy5g==
X-Proofpoint-ORIG-GUID: XbzVHOuZhd_9uTrAtaKohDaaRlicFaB5
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d8a3b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=9oSHA60ZoXLfwu9LI_gA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: GETwo9QV28Wz_Sxq8bUNjdJgXVbjrhjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100061
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=misanjum@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,
I've tested the patch on PowerPC pseries machine and it resolves the 
boot hang issue seen on ppc when booting KVM guest with >1 smp value.

Test Environment:
- Host Arch: ppc64le
- Host and Guest OS: Fedora 42
- Machine Type: pseries with KVM acceleration
- QEMU: Latest master with this patch applied

Test Results:
All the following SMP topologies now boot successfully:

Single and simple multi-CPU:
- -smp 1
- -smp 2
- -smp 4
- -smp 32

Various socket/core/thread combinations (8 vCPUs):
- -smp 8,sockets=8,cores=1,threads=1
- -smp 8,sockets=1,cores=8,threads=1
- -smp 8,sockets=1,cores=1,threads=8
- -smp 8,sockets=2,cores=4,threads=1
- -smp 8,sockets=1,cores=4,threads=2
- -smp 8,sockets=2,cores=1,threads=4
- -smp 8,sockets=2,cores=2,threads=2

Higher vCPU count:
- -smp 16,sockets=2,cores=4,threads=2
- -smp 32,sockets=1,cores=8,threads=4

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>

Thanks,
Misbah Anjum N <misanjum@linux.ibm.com>


On 2026-04-09 21:40, Harsh Prateek Bora wrote:
> When kvm_cpu_exec() returns EXCP_HLT due to 
> kvm_arch_process_async_events()
> returning true, it was returning before releasing the BQL (Big QEMU 
> Lock).
> This caused a lock imbalance where the vCPU thread would loop back to
> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
> 
> The issue manifests as boot hangs on PowerPC pseries machines with 
> multiple
> vCPUs, where secondary vCPUs with start-powered-off=true remain halted 
> and
> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration 
> held
> the BQL, preventing other operations from proceeding.
> 
> The fix has two parts:
> 
> 1. In kvm_cpu_exec() (kvm-all.c):
>    Release the BQL before returning EXCP_HLT in the early return path,
>    matching the behavior of the normal execution path where 
> bql_unlock()
>    is called before entering the main KVM execution loop.
> 
> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>    Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since the
>    loop expects to hold the BQL when calling kvm_cpu_exec() again.
> 
> This ensures proper BQL lock/unlock pairing:
> - kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
> - kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
> - kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
> - Next iteration has BQL held as expected
> 
> This is a regression introduced by commit 98884e0cc1 ("accel/kvm: add
> changes required to support KVM VM file descriptor change") which
> refactored kvm_irqchip_create() and changed the initialization timing,
> exposing this lock imbalance issue.
> 
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM
> file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  accel/kvm/kvm-accel-ops.c | 4 ++++
>  accel/kvm/kvm-all.c       | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6d9140e549..d684fd0840 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
> 
>          if (cpu_can_run(cpu)) {
>              r = kvm_cpu_exec(cpu);
> +            if (r == EXCP_HLT) {
> +                /* kvm_cpu_exec() released BQL, re-acquire for next
> iteration */
> +                bql_lock();
> +            }
>              if (r == EXCP_DEBUG) {
>                  cpu_handle_guest_debug(cpu);
>              }
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..00b8018664 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>      trace_kvm_cpu_exec();
> 
>      if (kvm_arch_process_async_events(cpu)) {
> +        bql_unlock();
>          return EXCP_HLT;
>      }

