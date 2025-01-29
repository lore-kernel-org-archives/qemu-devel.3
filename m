Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4FAC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 05:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td15o-0007xg-Kc; Wed, 29 Jan 2025 00:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1td15m-0007wt-Jt; Wed, 29 Jan 2025 00:58:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1td15l-0001Qz-4l; Wed, 29 Jan 2025 00:58:26 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T1836V004404;
 Wed, 29 Jan 2025 05:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8X9uXI
 1TjWBrJQxpKK1l54swlYmwmXTEVsz03RHbEIU=; b=d5pAyMhgUyqBiBszCp6jdH
 Dbe8j+R5Ajor9n2HZb04JCgxz8yEo/4QnHB0u0pyi3f9/NK+HaBIdX8eYMYCh9uu
 ug5G+zKqmYGmkr9ChXNlt2Z+T/VBK1numFpjuCtMFr96kTo1i5aNO/pQW33LOUuA
 VwcjUVlxLkWuQmqD8f87sP25b/SkFiOK+d3wGlAiOkC4QuTUPK5mXWc6F8i+J6Oc
 7VlD250jgL3PEHtfbNEbUJOVWiuoBIkYTJ+gRjMsF2H3Sn0edwgDvz23QS7eXn8W
 BxsEark3fcCNzTKwMUSTh/GjPd4/itoDY4OZd/p/qkPGumYZ4wU0MmBBlXnpKRCw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fad9gw5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 05:58:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50T5j3R6016455;
 Wed, 29 Jan 2025 05:58:21 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fad9gw5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 05:58:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T1qpUF022229;
 Wed, 29 Jan 2025 05:58:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjpvpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jan 2025 05:58:20 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50T5wKZ211403914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 05:58:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED88358059;
 Wed, 29 Jan 2025 05:58:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48B465804B;
 Wed, 29 Jan 2025 05:58:16 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jan 2025 05:58:15 +0000 (GMT)
Message-ID: <12b1106d-3989-4a73-8e0e-3ff4e72eec64@linux.ibm.com>
Date: Wed, 29 Jan 2025 11:28:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] target/ppc: Make powerpc_excp() prototype public
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-14-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XJeWN1c7SPS5n7jllVaphLRqt5CIeUD8
X-Proofpoint-ORIG-GUID: 29Xq6JufM1BNzsJLwTqZ_2adfka9_yXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=726 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290043
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
> In order to move TCG specific code dependent on powerpc_excp()
> in the next commit, expose its prototype in "internal.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/internal.h    | 1 +
>   target/ppc/excp_helper.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 0e66b29ec68..b8997ba31db 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -291,6 +291,7 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
>   bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
>   
>   G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
> +void powerpc_excp(PowerPCCPU *cpu, int excp);
>   
>   #if defined(TARGET_PPC64)
>   bool is_prefix_insn_excp(CPUPPCState *env, int excp);
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 661d9650d9f..f0e734e1412 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1494,7 +1494,7 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   }
>   #endif /* TARGET_PPC64 */
>   
> -static void powerpc_excp(PowerPCCPU *cpu, int excp)
> +void powerpc_excp(PowerPCCPU *cpu, int excp)
>   {
>       CPUPPCState *env = &cpu->env;
>   

