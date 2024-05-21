Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9867C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 15:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9RTo-0000Ac-Po; Tue, 21 May 2024 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RTm-0000AJ-E4; Tue, 21 May 2024 11:32:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RTj-0004F3-Gq; Tue, 21 May 2024 11:32:42 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LFMigq030002; Tue, 21 May 2024 15:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=7H5z3HBvQDzk8alFhgoJ8TnM6w590B/EKRZGSvvkDWI=;
 b=euOU1Y/gfvlJM0dDYoxD4hmoYnG4qDTjsMvBourEmIzm2aIQyWVAf8pkeRrJgroJvCJ7
 wcFXhEHw4xbQlo/gcyJEKWemxEPA16dwB1gqcHELzujewnF5XTuZY8czwt6txpkejBPY
 qwvB2/Q04SuJ9AqJ/xB6d75M//OviEOYv05cbEkJcDHD6XjvB2Nfd9hoUkUjVL89U7BG
 8HiSU8SceVnsXcoX5kzvDHtkLkPF6Tj4rtbxjmeHceNpHVesTrkV7lR8dn19VM2ZU7FQ
 fgHDlLdi1tDI/QMqE+aqobx0JPyXKXoxlmE++uaoAv2m0Ob7TaPT1JpmE0+mfPW1vNok Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8x6fr0x5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:32:35 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LFWYe6014688;
 Tue, 21 May 2024 15:32:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8x6fr0x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:32:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LEkGnT026474; Tue, 21 May 2024 15:32:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785meb7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:32:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LFWVF060031390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 15:32:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CC6758057;
 Tue, 21 May 2024 15:32:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C93958058;
 Tue, 21 May 2024 15:32:31 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 15:32:30 +0000 (GMT)
Message-ID: <58f7d978e41ab70247048116aa8b1601c2ed64df.camel@linux.ibm.com>
Subject: Re: [PATCH v2 01/12] target/ppc: Make checkstop actually stop the
 system
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Chinmay Rath
 <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 10:32:30 -0500
In-Reply-To: <20240521013029.30082-2-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-2-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HwyBePfwI0ft-3Fw6VRgbyBvKkkJ8zbi
X-Proofpoint-ORIG-GUID: 7wVE2rcZvYz1BjnzrMKvtrcD-zKzWqFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_09,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=848
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Tue, 2024-05-21 at 11:30 +1000, Nicholas Piggin wrote:
> checkstop state does not halt the system, interrupts continue to be
> serviced, and other CPUs run. Make it stop the machine with
> qemu_system_guest_panicked.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/excp_helper.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 3be086d10b..b2b51537b7 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -19,6 +19,8 @@
>  #include "qemu/osdep.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/log.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/runstate.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "internal.h"
> @@ -425,6 +427,8 @@ static void powerpc_set_excp_state(PowerPCCPU
> *cpu, target_ulong vector,
>  
>  static void powerpc_mcheck_checkstop(CPUPPCState *env)
>  {
> +    /* KVM guests always have MSR[ME] enabled */
> +#ifdef CONFIG_TCG
>      CPUState *cs = env_cpu(env);
>  
>      if (FIELD_EX64(env->msr, MSR, ME)) {
> @@ -437,9 +441,15 @@ static void powerpc_mcheck_checkstop(CPUPPCState
> *env)
>      if (qemu_log_separate()) {
>          qemu_log("Machine check while not allowed. "
>                   "Entering checkstop state\n");
> -    }
> -    cs->halted = 1;
> -    cpu_interrupt_exittb(cs);
> +
> +    /*
> +     * This stops the machine and logs CPU state without killing
> QEMU
> +     * (like cpu_abort()) so the machine can still be debugged
> (because
> +     * it is often a guest error).
> +     */
> +    qemu_system_guest_panicked(NULL);
> +    cpu_loop_exit_noexc(cs);
> +#endif
>  }
>  
>  static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)


