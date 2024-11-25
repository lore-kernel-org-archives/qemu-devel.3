Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53097D58D64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFbur-0008Tn-O7; Mon, 25 Nov 2024 11:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFbuq-0008Si-2z; Mon, 25 Nov 2024 11:26:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFbuo-0003ML-EM; Mon, 25 Nov 2024 11:26:23 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBuXjw032641;
 Mon, 25 Nov 2024 16:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=d/aZPDKuacGKV+WxGTzPq2zG1c+bMUjuUs6ZAn1IXww=; b=eOAhoutXZvTV
 Oko994B7Ke5sjeunAkWs4/NmV4NT6JKUUg0kdUFK2ELm0wdIY2IzVvKxM8HDMX+x
 lDqDi8gApnTPGDyF8eaUmbgqFShKRV3wTUDaY7Bt9CEuAq5YxAtzE7KR4dcvfTT9
 H+DPZcV57rh9m5YBy3box0GsBRA8vctOfBwvkz1sWbwVZnJ9Bcr0pP67ywJbR0xq
 8ZXrMxOeOZ9+F8TkVUEHwHynZcVvywdYmpeuJxSzcwS1FEDS6/i36tvSH+4XoVV9
 dqxdz3tKqHBsJHVr3tSEVLuEnFaEHeIcdzXIMKwI9BU39E7EYHO2+pmjXheg/qo+
 PIv017TkPw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389c9em8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:26:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APGQIgE007167;
 Mon, 25 Nov 2024 16:26:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389c9em4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:26:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFp57Y000859;
 Mon, 25 Nov 2024 16:26:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433sry0x0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:26:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4APGQGIA46334332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 16:26:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2C6658055;
 Mon, 25 Nov 2024 16:26:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B968B58043;
 Mon, 25 Nov 2024 16:26:15 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2024 16:26:15 +0000 (GMT)
Message-ID: <8f5d6402e17834fc365cd52002840e4496534458.camel@linux.ibm.com>
Subject: Re: [PATCH 1/4] target/ppc: Fix non-maskable interrupt while halted
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Date: Mon, 25 Nov 2024 10:26:15 -0600
In-Reply-To: <20241125132042.325734-2-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-2-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8_8.2) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aABmuTFwsHQjb3662-Zsl7nuV8p6OY2O
X-Proofpoint-ORIG-GUID: 0Di7HKMO69NOdkjyYOepSlR6A8FUExZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=851
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2024-11-25 at 23:20 +1000, Nicholas Piggin wrote:
> The ppc (pnv and spapr) NMI injection code does not go through the
> asynchronous interrupt path and set a bit in env->pending_interrupts
> and raise an interrupt request that the cpu_exec() loop can see.
> Instead it injects the exception directly into registers.
> 
> This can lead to cpu_exec() missing that the thread has work to do,
> if a NMI is injected while it was idle.
> 
> Fix this by clearing halted when injecting the interrupt. Probably
> NMI injection should be reworked to use the interrupt request
> interface,
> but this seems to work as a minimal fix.
> 
> Fixes: 3431648272d3 ("spapr: Add support for new NMI interface")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/excp_helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 70daa5076a..9f811af0a4 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2495,10 +2495,16 @@ static void ppc_deliver_interrupt(CPUPPCState
> *env, int interrupt)
>      }
>  }
>  
> +/*
> + * system reset is not delivered via normal irq method, so have to
> set
> + * halted = 0 to resume CPU running if it was halted. Possibly we
> should
> + * move it over to using PPC_INTERRUPT_RESET rather than
> async_run_on_cpu.
> + */
>  void ppc_cpu_do_system_reset(CPUState *cs)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>  
> +    cs->halted = 0;
>      powerpc_excp(cpu, POWERPC_EXCP_RESET);
>  }
>  
> @@ -2520,6 +2526,7 @@ void ppc_cpu_do_fwnmi_machine_check(CPUState
> *cs, target_ulong vector)
>  
>      /* Anything for nested required here? MSR[HV] bit? */
>  
> +    cs->halted = 0;
>      powerpc_set_excp_state(cpu, vector, msr);
>  }
>  


