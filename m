Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307DDC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 05:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcdhH-0001vn-1h; Mon, 27 Jan 2025 23:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcdhA-0001ur-LO; Mon, 27 Jan 2025 23:59:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcdh9-0006OK-0V; Mon, 27 Jan 2025 23:59:28 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLIT98026454;
 Tue, 28 Jan 2025 04:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ch9Vgi
 QRxaGLW4hRfLWAWJHC47V5EvQwG3eYJ/sITKI=; b=CAO2X/hSpT2rh4jP4B5sR1
 HSddNMi9iEoyObjdD0nMF7CwfUiyoxwjzpcU/qV5q3kktAtzu9bexdaQbEWnDz9F
 N+vjdsvKh/nWfnQmQVZzAiap2FrXGMkApH92ZkYLqbokjWkH6sVyvM1w20WqcaJh
 vU+vpwXkR5XhzfcS7jiumCReOqo/hVt2xsFrmkotnW+lHPP/ISIgBzmeOB4wCt6s
 CGOQ7bO4RbATWJvWy5cISVSjFInD86+O/vtNwlxMQIbITzqvCddOTA9MnmJBNTrF
 zpRrc8BeMaNphwuvPc31AdCo+BES/maknVCKANGzV+b8oM7dtIjPm6xIwS5SBoyw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e3y7wyw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 04:59:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S4uROL028586;
 Tue, 28 Jan 2025 04:59:20 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e3y7wyw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 04:59:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S24WLd018922;
 Tue, 28 Jan 2025 04:59:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd0198m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 04:59:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S4xIVE32834236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 04:59:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2D2B5805A;
 Tue, 28 Jan 2025 04:59:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 258AA58056;
 Tue, 28 Jan 2025 04:59:16 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 04:59:15 +0000 (GMT)
Message-ID: <86b77fec-15ef-437b-b9c4-9a90a3edbf3b@linux.ibm.com>
Date: Tue, 28 Jan 2025 10:29:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] hw/ppc/spapr: Restrict CONFER hypercall to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-2-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250127102620.39159-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zuaN6lxn9TOt65PSK3-eQ4-JWumgqF6t
X-Proofpoint-GUID: Y2bY_7pRBwA8l0TLlsWieOz5I-2rZ5_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=686 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280035
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

Hi Philippe,

On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
> TODO: Add PPC folks why :)

While this appear be TCG specific, may I know what caused you to bring 
this change? Usually we have blanks stubs for hcalls in KVM mode which 
are only TCG specific. That helps in avoiding building TCG specific code 
when building with TCG disabled.

Nick, thoughts?

regards,
Harsh

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/spapr_hcall.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index f8ab7670630..dbf30358a1a 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -578,6 +578,8 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       CPUState *cs = CPU(cpu);
>       SpaprCpuState *spapr_cpu;
>   
> +    assert(tcg_enabled()); /* KVM will have handled this */
> +
>       /*
>        * -1 means confer to all other CPUs without dispatch counter check,
>        *  otherwise it's a targeted confer.

