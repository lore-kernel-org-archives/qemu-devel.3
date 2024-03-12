Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B5CC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyyy-0001KI-7d; Tue, 12 Mar 2024 06:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjyyv-0001K4-UM; Tue, 12 Mar 2024 06:03:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjyyt-00015E-PR; Tue, 12 Mar 2024 06:03:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CA2c4b015915; Tue, 12 Mar 2024 10:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=f/v2LkmSet7RV83+0tuyaoqZ3446kfaRDur56+81VFQ=;
 b=H8fHQbir23/NhHfBOEW15PgI1JymQC9AbXyIVGmk+015daWX9YvRLZ+DOoEvvXKcz0yV
 32C2H7tzCXTBBdZiT08Po9bL2QMj5J4LPM1EBLixHfzy1+D1sHpPwCgRjRqLZ1+Kf7o1
 GGjZvn7fXxaHA9loSbVVf/QMtJsI6CjrOOvuhwcE73cRQJvP7P2Pmle7JhppK2ZlYdJX
 cPDkrjvA5AmxvRob4wsvcVkhhMMHzLUcgQ4qE2L+RunNzXIp0GjMdsVtsApx0mdwXWbo
 we6QJxwgokVVbSURp7+gvjIihjNFVtggbz9Vwz5vIiesVGdp6zd3dvyJbVFkgtML3svZ Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtmxs80ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 10:03:29 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CA3SVZ017797;
 Tue, 12 Mar 2024 10:03:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtmxs80af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 10:03:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C8eO40015477; Tue, 12 Mar 2024 10:03:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fypf9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 10:03:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CA3PIa43974978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 10:03:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E1395805A;
 Tue, 12 Mar 2024 10:03:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D41875805E;
 Tue, 12 Mar 2024 10:03:23 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 10:03:23 +0000 (GMT)
Message-ID: <eb0f5c3b-92ee-4c89-82a4-fcdd9db068b7@linux.ibm.com>
Date: Tue, 12 Mar 2024 15:33:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] spapr: set MSR[ME] and MSR[FP] on client entry
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-11-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240311185200.2185753-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mXmtoihNg3hy2ZREjo-iSCZMVQHP1OdO
X-Proofpoint-GUID: JQdtz_Y2BTiUWmtTEXE2l1VFN3eSjczs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 3/12/24 00:21, Nicholas Piggin wrote:
> The initial MSR state for PAPR specifies MSR[ME] and MSR[FP] are set.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

It would be good to mention PAPR section numbers suggesting the same.
Anyways,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr_cpu_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 50523ead25..f3b01b0801 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -42,6 +42,8 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>        * as 32bit (MSR_SF=0) in "8.2.1. Initial Register Values".
>        */
>       env->msr &= ~(1ULL << MSR_SF);
> +    env->msr |= (1ULL << MSR_ME) | (1ULL << MSR_FP);
> +
>       env->spr[SPR_HIOR] = 0;
>   
>       lpcr = env->spr[SPR_LPCR];

