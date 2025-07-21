Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F2C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udy2M-00014b-94; Mon, 21 Jul 2025 17:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1udy2D-0000yk-8V; Mon, 21 Jul 2025 17:26:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1udy2A-0005XA-Am; Mon, 21 Jul 2025 17:26:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LKvY2M015099;
 Mon, 21 Jul 2025 21:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=af8ZhQ
 WZ7IxXVhDZDutXqQd5zTSPY+nF6ebap1mMnBI=; b=H7gExuDp7thbHcx9J8sEPv
 YykPbmAiC2MonEPYU/irPdav7171CGwlsyirtMWyWquRFMQk1XGd7G67AidvjiNg
 el1LIF+2yAl7k8jSK3vrW2hn1PUT6iYDpMKmY5ox18wjKTGdG0hUFUdUwoiG/Hg3
 VctGvlvjnVMZGKAfqtQ7bSofcTrwBat9nyrKQoAFwZkTHOhi2jvILWP/Arc4Sc+G
 1UvQCKaDRuNrFcB2UrcJdhiWgs2dRuz8zn4q4E1o4iJNccW9D0jC5JiJ1DUxseEo
 GsSCIChbaNyrbUAkfbt3oZzSYtsXoudVLOaXLA7aQP3BLap6y6+CTmYJudGUUbMw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut2vby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:26:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LHnoi5024761;
 Mon, 21 Jul 2025 21:26:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd27r6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:26:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56LLQlbQ61669886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jul 2025 21:26:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F16058057;
 Mon, 21 Jul 2025 21:26:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E3F458058;
 Mon, 21 Jul 2025 21:26:46 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jul 2025 21:26:46 +0000 (GMT)
Message-ID: <5847016f-f4e7-49ca-82dd-3fb062a8ec0c@linux.ibm.com>
Date: Mon, 21 Jul 2025 17:26:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/28] s390x/diag: Introduce DIAG 320 for certificate
 store facility
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-6-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE4OCBTYWx0ZWRfX1xEn1fNI1xNb
 9D/uXU0KlS/lrW7cxl/lg4/ngOorNEJNCkuu8V0G+M/2YqSpvxSfEOggd4o/MrwMOW/afKBw939
 WOTSRYLBSoAJL611gIiarIbY2CLRjD7JizKWQa+uyK+pPzPkAVDIIpZEoozgxZyELsqt5mON5wt
 thQd1Tjx4dm8CZ0Mt+xlmZ4v9tbkgJaZuqJEzE2JeK4FV4loea3J1NBS+TjMJqSV0+8oEkVvszQ
 sQaHxdsDw2pCu5zUAyixyY6wDxgQ/+QLXqk1rJU/jnLPhD8HQymHB2yBlwRnh2+vzswNXVzO66p
 jtoN0uSu6j1DSOUJ+X7Tqc9dobqMnuGbsUtEVb5j4kVX+DXbgFyK+ZrZTINEhD5ugiXfRVXt8K8
 DjxtYvKpbKNgPXAqdsP8EmBV+0rPY0wC6bByZaHO+Qlr77+JM/02cilwNRAEhgsKJkm2m+D9
X-Proofpoint-ORIG-GUID: i-zhmp_pq_US3SWKPiKlj0icFJghDbb0
X-Authority-Analysis: v=2.4 cv=cIDgskeN c=1 sm=1 tr=0 ts=687eb09a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=wPz425FPKc1gwUKmrLQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: i-zhmp_pq_US3SWKPiKlj0icFJghDbb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210188
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

On 7/11/25 17:10, Zhuoying Cai wrote:
> DIAGNOSE 320 is introduced to support certificate store facility,
> which includes operations such as query certificate storage
> information and provide certificates in the certificate store.
> 
> Currently, only subcode 0 is supported with this patch, which is
> used to query a bitmap of which subcodes are supported.

Change to: "used to query the Installed Subcodes Mask (ISM)."

Based on my feedback below, make sure to include a statement that this
subcode is only supported when the Certificate Store facility is enabled.

> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/diag320.h | 17 ++++++++++++++
>  target/s390x/diag.c            | 41 ++++++++++++++++++++++++++++++++++
>  target/s390x/kvm/kvm.c         | 14 ++++++++++++
>  target/s390x/s390x-internal.h  |  2 ++
>  target/s390x/tcg/misc_helper.c |  7 ++++++
>  5 files changed, 81 insertions(+)
>  create mode 100644 include/hw/s390x/ipl/diag320.h
> 
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> new file mode 100644
> index 0000000000..713570545d
> --- /dev/null
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -0,0 +1,17 @@
> +/*
> + * S/390 DIAGNOSE 320 definitions and structures
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef S390X_DIAG320_H
> +#define S390X_DIAG320_H
> +
> +#define DIAG_320_SUBC_QUERY_ISM     0
> +
> +#define DIAG_320_RC_OK              0x0001
> +
> +#endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index cff9fbc4b0..d33c5daf38 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -18,6 +18,7 @@
>  #include "hw/watchdog/wdt_diag288.h"
>  #include "system/cpus.h"
>  #include "hw/s390x/ipl.h"
> +#include "hw/s390x/ipl/diag320.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "system/kvm.h"
>  #include "kvm/kvm_s390x.h"
> @@ -191,3 +192,43 @@ out:
>          break;
>      }
>  }
> +
> +void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +{
> +    S390CPU *cpu = env_archcpu(env);
> +    uint64_t subcode = env->regs[r3];
> +    uint64_t addr = env->regs[r1];
> +    int rc;

Even though "rc" likely means "response code" in the context of DIAG, it
screams "return code" in a void function, which looks a little odd.  I'd
remove this variable and simply set `env->regs[r1 + 1] = DIAG_320_RC_*`
instead, similar to how DIAG 308 handles this.

> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> +        return;
> +    }
> +
> +    if (!s390_has_feat(S390_FEAT_DIAG_320)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    if (r1 & 1) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    switch (subcode) {

In patch 4, you introduce the feature bit for DIAG 320.  It is
documented that subcodes 0-3 are only supported if this feature bit is
on.  Please add a check for this feature.  Subcode 0 (and later 1 and 2)
should not be handled if this feature bit is not present.

> +    case DIAG_320_SUBC_QUERY_ISM:
> +        uint64_t ism =  0;

Technically, this subcode is suppose to write to an 8-word installed
subcodes block (ISB).  Though I can't imagine that we'll grow beyond
even the first word for quite some time.  I guess it's up to the caller
to provide a proper ISB anyway.

I'd suggest the following:

change from `uint64_t` to `uint32_t ism_word0`

Add a comment:

/*
 * The Installed Subcode Block (ISB) can be up 8 words in size,
 * but the current set of subcodes can fit within a single word
 * for now.
 */

> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
> +
> +        rc = DIAG_320_RC_OK;

env->regs[r1 + 1] = DIAG_320_RC_OK;

> +        break;
> +    default:
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;

As specified in the documentation, "response code 0x0102 indicates that
the subcode is reserved or not supported on this model". There is no
program specification when an incorrect subcode has been provided.

> +    }
> +    env->regs[r1 + 1] = rc;

Remove this line.

> +}
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 8f655a4b7f..d5b3694600 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -98,6 +98,7 @@
>  #define DIAG_TIMEREVENT                 0x288
>  #define DIAG_IPL                        0x308
>  #define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
> +#define DIAG_CERT_STORE                 0x320
>  #define DIAG_KVM_HYPERCALL              0x500
>  #define DIAG_KVM_BREAKPOINT             0x501
>  
> @@ -1560,6 +1561,16 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
>      }
>  }
>  
> +static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
> +{
> +    uint64_t r1, r3;
> +
> +    r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    r3 = run->s390_sieic.ipa & 0x000f;
> +
> +    handle_diag_320(&cpu->env, r1, r3, RA_IGNORED);
> +}
> +
>  #define DIAG_KVM_CODE_MASK 0x000000000000ffff
>  
>  static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
> @@ -1590,6 +1601,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
>      case DIAG_KVM_BREAKPOINT:
>          r = handle_sw_breakpoint(cpu, run);
>          break;
> +    case DIAG_CERT_STORE:
> +        kvm_handle_diag_320(cpu, run);
> +        break;
>      default:
>          trace_kvm_insn_diag(func_code);
>          kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index a4ba6227ab..86a652f833 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -400,6 +400,8 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
>  void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
>                       uintptr_t ra);
> +void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
> +                     uintptr_t ra);
>  
>  
>  /* translate.c */
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index f7101be574..412c34ed93 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -142,6 +142,13 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>          /* time bomb (watchdog) */
>          r = handle_diag_288(env, r1, r3);
>          break;
> +    case 0x320:
> +        /* cert store */
> +        bql_lock();
> +        handle_diag_320(env, r1, r3, GETPC());
> +        bql_unlock();
> +        r = 0;
> +        break;
>      default:
>          r = -1;
>          break;


-- 
Regards,
  Collin

