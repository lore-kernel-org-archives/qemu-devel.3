Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEEFC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 15:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9RYM-0002Au-OQ; Tue, 21 May 2024 11:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RYL-0002Ah-7L; Tue, 21 May 2024 11:37:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RYJ-0005LO-8N; Tue, 21 May 2024 11:37:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LEqVJM007168; Tue, 21 May 2024 15:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=MZPeI1x/cKwLgU/DGrghuHxR0J4kZ7IvWN4yuvzqqDE=;
 b=V6JlANOoSIBZJvIJrOQJHy9IhRcB0vAoGZ0HcOWABVZiYPUFP2L2dPk2DzYGLCHqh8Lp
 IKoRo1Qn2vsMn0/xg7HqmTAs9d3dmJOunNv7eG0KMiVpYwnbBBLnFL3TXqjvXU+GzwX8
 t53HWXw57w91vR8/MSU4enVrWYYC2p0fSKXYgCwdl56sP4se6WhNVU9Jw3eVMqoQgpSP
 iS2vE2kDTHZ3kfZyAqTB98B2URCCp5qnTQJYH+N1EMqTSanqdrt4S5x8kHrwf5zWaeL+
 9YLpnfYq0N7rUpxZ4sXvOzOfJx8FPqVoM7lghxTiy9yXOOiSK9H18w3jF3BZ0vazsZdN 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8wrg83ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:37:18 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LFbI2I018189;
 Tue, 21 May 2024 15:37:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8wrg83u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:37:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LETlH6023565; Tue, 21 May 2024 15:37:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77np6g8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:37:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LFbEuU60227846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 15:37:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D511458054;
 Tue, 21 May 2024 15:37:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D7975804E;
 Tue, 21 May 2024 15:37:14 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 15:37:14 +0000 (GMT)
Message-ID: <8551fc11a1e3f453c4b8689bb00658d5d7a51c7c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 02/12] target/ppc: improve checkstop logging
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 10:37:13 -0500
In-Reply-To: <20240521013029.30082-3-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-3-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VkAmNiuQbfek0KnXXVi33b2JRTZACGYA
X-Proofpoint-GUID: Mq0wCD0XdyJf1WXHcwBUfmVI3yWfUhG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_09,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> Change the logging not to print to stderr as well, because a
> checkstop is a guest error (or perhaps a simulated machine error)
> rather than a QEMU error, so send it to the log.
> 
> Update the checkstop message, and log CPU registers too.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/excp_helper.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index b2b51537b7..17bf8df9d7 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -430,17 +430,19 @@ static void
> powerpc_mcheck_checkstop(CPUPPCState *env)
>      /* KVM guests always have MSR[ME] enabled */
>  #ifdef CONFIG_TCG
>      CPUState *cs = env_cpu(env);
> +    FILE *f;
>  
>      if (FIELD_EX64(env->msr, MSR, ME)) {
>          return;
>      }
>  
> -    /* Machine check exception is not enabled. Enter checkstop
> state. */
> -    fprintf(stderr, "Machine check while not allowed. "
> -            "Entering checkstop state\n");
> -    if (qemu_log_separate()) {
> -        qemu_log("Machine check while not allowed. "
> -                 "Entering checkstop state\n");
> +    f = qemu_log_trylock();
> +    if (f) {
> +        fprintf(f, "Entering checkstop state: "
> +                   "machine check with MSR[ME]=0\n");
> +        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> +        qemu_log_unlock(f);
> +    }
>  
>      /*
>       * This stops the machine and logs CPU state without killing
> QEMU


