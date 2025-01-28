Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBB9C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciNv-0002bC-4n; Tue, 28 Jan 2025 04:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tciNq-0002aO-Ss; Tue, 28 Jan 2025 04:59:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tciNp-0002Bq-31; Tue, 28 Jan 2025 04:59:50 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLITdL009913;
 Tue, 28 Jan 2025 09:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IK4PDz
 aDWbOsLgQ4oFApIYXFhdyg+uSuknFnajiaQNw=; b=GW086iPcZHGYJoi++dq270
 uMoq6b4k7Kzpea0tJmWfsAKHd3m/LqSP1bzFl4wKMAQZNq3yPHAnLyyTpxeBn6l7
 Wz+lgoQwkzOZsugoFOn40u9lbkF8GgoBQCe3bAJ1+o18UJnVyv+uGiCzdtgDkjMj
 hEVD+5QAiWTwDOjAstuCSv/0ht7VTyviGXWarTc+NzJYjQYjnPtHYVA8+LGvPOMq
 RKCVc1qTrqXyC9eK2ZCVbxpvd2Lk3uveYWkcpsqjbyZFbK4M1bSa/L22VXD2KJVS
 Imwz/LJ/yEuXwlVjVFBZaydI2TzOkYrPusZrBjwhHE0EpVTwZo1O1P05mULS4H8A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycmu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:59:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S9xjnM004301;
 Tue, 28 Jan 2025 09:59:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycmtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:59:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S5vGLu028042;
 Tue, 28 Jan 2025 09:59:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskakm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:59:44 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S9xiV732572020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 09:59:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2D4C5805E;
 Tue, 28 Jan 2025 09:59:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9003658056;
 Tue, 28 Jan 2025 09:59:41 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 09:59:41 +0000 (GMT)
Message-ID: <e0219562-1bce-421e-b056-28f0132e2a70@linux.ibm.com>
Date: Tue, 28 Jan 2025 15:29:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] target/ppc: Restrict exception helpers to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-10-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: urF4FQPOrtY0mbqetyUQh8rajQOkGneY
X-Proofpoint-ORIG-GUID: k0Pclf0fkPXMy3NTGnd6s933YUCGh9Bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=704 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
> Move exception helpers to tcg-excp_helper.c so they are
> only built when TCG is selected.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/excp_helper.c     | 34 --------------------------------
>   target/ppc/tcg-excp_helper.c | 38 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+), 34 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 9e1a2ecc36f..6a12402b23a 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2504,41 +2504,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   
>   #endif /* !CONFIG_USER_ONLY */
>   
> -/*****************************************************************************/
> -/* Exceptions processing helpers */
> -
> -void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
> -                            uint32_t error_code, uintptr_t raddr)
> -{
> -    CPUState *cs = env_cpu(env);
> -
> -    cs->exception_index = exception;
> -    env->error_code = error_code;
> -    cpu_loop_exit_restore(cs, raddr);
> -}
> -
> -void raise_exception_err(CPUPPCState *env, uint32_t exception,
> -                         uint32_t error_code)
> -{
> -    raise_exception_err_ra(env, exception, error_code, 0);
> -}
> -
> -void raise_exception(CPUPPCState *env, uint32_t exception)
> -{
> -    raise_exception_err_ra(env, exception, 0, 0);
> -}
> -
>   #ifdef CONFIG_TCG
> -void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
> -                                uint32_t error_code)
> -{
> -    raise_exception_err_ra(env, exception, error_code, 0);
> -}
> -
> -void helper_raise_exception(CPUPPCState *env, uint32_t exception)
> -{
> -    raise_exception_err_ra(env, exception, 0, 0);
> -}
>   
>   #ifndef CONFIG_USER_ONLY
>   void helper_store_msr(CPUPPCState *env, target_ulong val)
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 93c2d6b5a03..268a1614597 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -19,15 +19,53 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "exec/cpu_ldst.h"
> +#include "exec/exec-all.h"
> +#include "exec/helper-proto.h"
>   #include "system/runstate.h"
>   
> +#include "helper_regs.h"
>   #include "hw/ppc/ppc.h"
>   #include "internal.h"
>   #include "cpu.h"
>   #include "trace.h"
>   
> +/*****************************************************************************/
> +/* Exceptions processing helpers */
> +
> +void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
> +                            uint32_t error_code, uintptr_t raddr)
> +{
> +    CPUState *cs = env_cpu(env);
> +
> +    cs->exception_index = exception;
> +    env->error_code = error_code;
> +    cpu_loop_exit_restore(cs, raddr);
> +}
> +
> +void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
> +                                uint32_t error_code)
> +{
> +    raise_exception_err_ra(env, exception, error_code, 0);
> +}
> +
> +void helper_raise_exception(CPUPPCState *env, uint32_t exception)
> +{
> +    raise_exception_err_ra(env, exception, 0, 0);
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   

In excp_helper.c, below helpers were getting built when CONFIG_USER_ONLY 
is defined. Is this change to move under above ifndef intentional?

regards,
Harsh

> +void raise_exception_err(CPUPPCState *env, uint32_t exception,
> +                                           uint32_t error_code)
> +{
> +    raise_exception_err_ra(env, exception, error_code, 0);
> +}
> +
> +void raise_exception(CPUPPCState *env, uint32_t exception)
> +{
> +    raise_exception_err_ra(env, exception, 0, 0);
> +}
> +
>   void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>                                    MMUAccessType access_type,
>                                    int mmu_idx, uintptr_t retaddr)

