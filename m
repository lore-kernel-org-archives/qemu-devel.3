Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68A6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tchwu-0002RD-W8; Tue, 28 Jan 2025 04:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tchwj-0002J2-Nu; Tue, 28 Jan 2025 04:31:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tchwh-0004n7-LG; Tue, 28 Jan 2025 04:31:49 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S5NkA9023481;
 Tue, 28 Jan 2025 09:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/xVJ+T
 2W2wVDBUzJvUwOJDIPn04LuYXNzIsZTZ9vxZo=; b=kt6qF6bAle86xqAqapa/Bg
 Iaz+F/sc0SiOZB0OlUip7w24LNXiulplH/QbV/MxwxdPbtfLHqDr1SDGTNU8J8Oq
 Y41gZ2COXKI7NFWRi9Qy820jgvIR5/tal3DW1HdVDPmAK3xYXXk8MLlmyq5X019X
 kLPQhPomArsP11TKTmEaarc4eIxmIcVjKUEbAhmadYgZbrhSeiTFhCDa0PBZTCw8
 Zn2vXxIvoi2GnNzK/3loYGwTpGdEYhE+sgTRO7phFPU8lUluXXISNwvi9EZ/+OBw
 HMvbUyStAbBteUzgj0kJTjTOh3RY4mgE9ASGiVu6DDklR+lObFesfzbYDnjAKD/w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44es27h1xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:31:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S8rXu3027219;
 Tue, 28 Jan 2025 09:31:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44es27h1xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:31:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S9JWr1019445;
 Tue, 28 Jan 2025 09:31:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9mtjyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 09:31:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S9Vgwd32244304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 09:31:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C98A5805A;
 Tue, 28 Jan 2025 09:31:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECC4058052;
 Tue, 28 Jan 2025 09:31:39 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 09:31:39 +0000 (GMT)
Message-ID: <af2c2503-e066-4b5d-8045-c6f1c4ee6ba7@linux.ibm.com>
Date: Tue, 28 Jan 2025 15:01:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] target/ppc: Restrict powerpc_checkstop() to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-8-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hKZLpdQHt1L0tKWWFrEFX5Nw9Y5LPQMM
X-Proofpoint-GUID: IPkZk5ObJWdaF7HtC8mR-gHnExDcpkeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280073
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
> Expose powerpc_checkstop() prototype, and move it to
> tcg-excp_helper.c, only built when TCG is available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/internal.h        |  4 +++-
>   target/ppc/excp_helper.c     | 26 --------------------------
>   target/ppc/tcg-excp_helper.c | 28 ++++++++++++++++++++++++++++
>   3 files changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 46db6adfcf6..62186bc1e61 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -289,7 +289,9 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>   void ppc_cpu_debug_excp_handler(CPUState *cs);
>   bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
>   bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
> -#endif
> +
> +G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
> +#endif /* !CONFIG_USER_ONLY */
>   
>   FIELD(GER_MSK, XMSK, 0, 4)
>   FIELD(GER_MSK, YMSK, 4, 4)
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index b08cd53688c..236e5078f56 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -400,32 +400,6 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
>   }
>   
>   #ifdef CONFIG_TCG
> -/*
> - * This stops the machine and logs CPU state without killing QEMU (like
> - * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
> - * so the machine can still be debugged.
> - */
> -static G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
> -{
> -    CPUState *cs = env_cpu(env);
> -    FILE *f;
> -
> -    f = qemu_log_trylock();
> -    if (f) {
> -        fprintf(f, "Entering checkstop state: %s\n", reason);
> -        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> -        qemu_log_unlock(f);
> -    }
> -
> -    /*
> -     * This stops the machine and logs CPU state without killing QEMU
> -     * (like cpu_abort()) so the machine can still be debugged (because
> -     * it is often a guest error).
> -     */
> -    qemu_system_guest_panicked(NULL);
> -    cpu_loop_exit_noexc(cs);
> -}
> -
>   #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
>   void helper_attn(CPUPPCState *env)
>   {
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 6950b78774d..93c2d6b5a03 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -17,7 +17,9 @@
>    * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/log.h"
>   #include "exec/cpu_ldst.h"
> +#include "system/runstate.h"
>   
>   #include "hw/ppc/ppc.h"
>   #include "internal.h"
> @@ -199,6 +201,32 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>       return false;
>   }
>   
> +/*
> + * This stops the machine and logs CPU state without killing QEMU (like
> + * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
> + * so the machine can still be debugged.
> + */
> +G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
> +{
> +    CPUState *cs = env_cpu(env);
> +    FILE *f;
> +
> +    f = qemu_log_trylock();
> +    if (f) {
> +        fprintf(f, "Entering checkstop state: %s\n", reason);
> +        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> +        qemu_log_unlock(f);
> +    }
> +
> +    /*
> +     * This stops the machine and logs CPU state without killing QEMU
> +     * (like cpu_abort()) so the machine can still be debugged (because
> +     * it is often a guest error).
> +     */
> +    qemu_system_guest_panicked(NULL);
> +    cpu_loop_exit_noexc(cs);
> +}
> +
>   /* Return true iff byteswap is needed to load instruction */
>   static inline bool insn_need_byteswap(CPUArchState *env)
>   {

