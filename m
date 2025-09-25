Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BC1CAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 20:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1swD-0003Fo-5U; Thu, 25 Sep 2025 16:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1sw7-0003ED-22; Thu, 25 Sep 2025 16:51:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1svm-0002jR-Nr; Thu, 25 Sep 2025 16:51:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PImmZF018714;
 Thu, 25 Sep 2025 20:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=riWYNk
 VHRtCKMwdLhm26Ap0Qpx1VycH+VAO7NqptFfE=; b=Ca2AogiWMtoxzmyIxGNGy4
 CatnjeYM38O7Wl4DkiHZVRdlbUTezlnGhOB5czWPlM9lqNgp/JH4iEv4U4sarmoO
 RHuolN2BdSvM9XR3SBsR90HAMogG62gkPIunOdn3q9jj9YZxz/kNKGMvPWbgzigH
 cei6tF2hz1LDgLX97gbQYoU0ClzF0zK3JVoFrNqqrj694gzliTRuXvQnphYuKtYh
 eIW8cw2084hZQeRM1XuWxvWekLBMBW4YlBZ+fHJ7miimH4jWXL7/4YWcndqgh++H
 fSSOOOCIB91qAVBMwokyNSAp1C2RbXPa2Z4R7Jc0bA2F6JUbCgjo13l/y1DGi5BA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbd8kdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:50:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIJA2h025794;
 Thu, 25 Sep 2025 20:50:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawprng6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:50:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PKosjl31523578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 20:50:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A375558050;
 Thu, 25 Sep 2025 20:50:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F06B258045;
 Thu, 25 Sep 2025 20:50:52 +0000 (GMT)
Received: from [9.61.254.10] (unknown [9.61.254.10])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 20:50:52 +0000 (GMT)
Message-ID: <78785962-2f38-47f6-81e3-5f9aa8aaec9c@linux.ibm.com>
Date: Thu, 25 Sep 2025 13:50:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/28] s390x/diag: Introduce DIAG 508 for secure IPL
 operations
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-11-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-11-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=F/Jat6hN c=1 sm=1 tr=0 ts=68d5ab31 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=c14hHzUaRZDl8Y9BHVwA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX3jCb1vTHMsyV
 rWdVZsu5OpUBMluaHVp/CSp6CbY1iJEuZX2dG6Xxxw05qM/lEtBU4/6f+cmSJEWw3RxYuAtdTgW
 /OCAZJByraa35YsMm2Q5DJkGzXmm2gqiCGoT6Fqim0ubODFH6meBS01aJZCwjKKlWr1zPWM9L71
 e4yWWNubav1EtU1RWrFlhv8f42YfgnsI2E3VqKYtIVFTvT5MWNeVk3cDp2qDtHVkhh33kVelLwy
 /uJ32ABEPJqypkDFeZrhj7oBECekqBbfwIRx+EaeVsvOOy9nQv15DGvBzxIhyDuZQ7lSqFAt6X2
 xVzHrVduiL2LocdIdduKqIKsOrDxPoknLulp6elz3dur1nBcjTihLHMieTFhcOSZOQtXu3q2ATu
 6xqfmFecJgsrVRvYiukNra3BL1BN0w==
X-Proofpoint-GUID: Kfkc7hMnlQ113h2E5_Vmc5YaPdKlWkkr
X-Proofpoint-ORIG-GUID: Kfkc7hMnlQ113h2E5_Vmc5YaPdKlWkkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
>
> In order to support secure IPL (aka secure boot) for the s390-ccw BIOS,
> a new s390 DIAGNOSE instruction is introduced to leverage QEMU for
> handling operations such as signature verification and certificate
> retrieval.
>
> Currently, only subcode 0 is supported with this patch, which is used to
> query a bitmap of which subcodes are supported.
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 18 ++++++++++++++++++
>   include/hw/s390x/ipl/diag508.h  | 15 +++++++++++++++
>   target/s390x/diag.c             | 27 +++++++++++++++++++++++++++
>   target/s390x/kvm/kvm.c          | 14 ++++++++++++++
>   target/s390x/s390x-internal.h   |  2 ++
>   target/s390x/tcg/misc_helper.c  |  7 +++++++
>   6 files changed, 83 insertions(+)
>   create mode 100644 include/hw/s390x/ipl/diag508.h
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index e28f0b40d7..0919425e9a 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -48,3 +48,21 @@ Subcode 2 - store verification certificates
>       storage specified in the VCB input length field.
>   
>       VCE contains various information of a VC from the CS.
> +
> +
> +Secure IPL Data Structures, Facilities, and Functions
> +=====================================================
> +
> +DIAGNOSE function code 'X'508' - KVM IPL extensions
> +---------------------------------------------------
> +
> +DIAGNOSE 'X'508' is reserved for KVM guest use in order to facilitate
> +communication of additional IPL operations that cannot be handled by userspace,
> +such as signature verification for secure IPL.
> +
> +If the function code specifies 0x508, KVM IPL extension functions are performed.
> +These functions are meant to provide extended functionality for s390 guest boot
> +that requires assistance from QEMU.
> +
> +Subcode 0 - query installed subcodes
> +    Returns a 64-bit mask indicating which subcodes are supported.
> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> new file mode 100644
> index 0000000000..6281ad8299
> --- /dev/null
> +++ b/include/hw/s390x/ipl/diag508.h
> @@ -0,0 +1,15 @@
> +/*
> + * S/390 DIAGNOSE 508 definitions and structures
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Collin Walling <walling@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef S390X_DIAG508_H
> +#define S390X_DIAG508_H
> +
> +#define DIAG_508_SUBC_QUERY_SUBC    0x0000
> +
> +#endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index d5f6c54df3..ee64257dbc 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -20,6 +20,7 @@
>   #include "hw/s390x/cert-store.h"
>   #include "hw/s390x/ipl.h"
>   #include "hw/s390x/ipl/diag320.h"
> +#include "hw/s390x/ipl/diag508.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "system/kvm.h"
>   #include "kvm/kvm_s390x.h"
> @@ -600,3 +601,29 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           break;
>       }
>   }
> +
> +void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +{
> +    uint64_t subcode = env->regs[r3];
> +    int rc;
> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> +        return;
> +    }
> +
> +    if ((subcode & ~0x0ffffULL) || (r1 & 1)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    switch (subcode) {
> +    case DIAG_508_SUBC_QUERY_SUBC:
> +        rc = 0;
> +        break;
> +    default:
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +    env->regs[r1 + 1] = rc;
> +}
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 5510fc2fc5..ae6cd3d506 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -101,6 +101,7 @@
>   #define DIAG_CERT_STORE                 0x320
>   #define DIAG_KVM_HYPERCALL              0x500
>   #define DIAG_KVM_BREAKPOINT             0x501
> +#define DIAG_SECURE_IPL                 0x508
>   
>   #define ICPT_INSTRUCTION                0x04
>   #define ICPT_PROGRAM                    0x08
> @@ -1571,6 +1572,16 @@ static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
>       handle_diag_320(&cpu->env, r1, r3, RA_IGNORED);
>   }
>   
> +static void kvm_handle_diag_508(S390CPU *cpu, struct kvm_run *run)
> +{
> +    uint64_t r1, r3;
> +
> +    r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    r3 = run->s390_sieic.ipa & 0x000f;
> +
> +    handle_diag_508(&cpu->env, r1, r3, RA_IGNORED);
> +}
> +
>   #define DIAG_KVM_CODE_MASK 0x000000000000ffff
>   
>   static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
> @@ -1604,6 +1615,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
>       case DIAG_CERT_STORE:
>           kvm_handle_diag_320(cpu, run);
>           break;
> +    case DIAG_SECURE_IPL:
> +        kvm_handle_diag_508(cpu, run);
> +        break;
>       default:
>           trace_kvm_insn_diag(func_code);
>           kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index ecff2d07a1..7cca8a67de 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -393,6 +393,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
>                        uintptr_t ra);
>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
>                        uintptr_t ra);
> +void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3,
> +                     uintptr_t ra);
>   
>   
>   /* translate.c */
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index 412c34ed93..ddbf495118 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -149,6 +149,13 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>           bql_unlock();
>           r = 0;
>           break;
> +    case 0x508:
> +        /* secure ipl operations */
> +        bql_lock();
> +        handle_diag_508(env, r1, r3, GETPC());
> +        bql_unlock();
> +        r = 0;
> +        break;
>       default:
>           r = -1;
>           break;

