Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5961C35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 07:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4pq-00015f-8E; Mon, 17 Mar 2025 03:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tu4pb-00014j-Ig; Mon, 17 Mar 2025 03:24:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tu4pY-0004uU-A7; Mon, 17 Mar 2025 03:24:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GKd9KV002902;
 Mon, 17 Mar 2025 07:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=y5gpq5
 oHHMR67ISEmWUah8rkFB9Cl0E5AGg3TIL4GSY=; b=ouZsXN5ojnlqSsVwansycR
 BCx9b80LbWpfCTzz1GpZxeAgOeciyAeIEZenfo10DGkuwV7Nl07jmtl1pop2bTak
 yyCeecedblUKkFZ+aP3MrIIAOt0P2MaTskww/9erfJYb9D3gqxxESi7hZVjuwyxL
 Pz9XDHyasgm8QimquozHg5NPwCSH2GB7s1fC9nbxTaNYZMhI0fiBsoWKf1Mogy7B
 inRCNM4VGiu9PhhV8L+hdZ9U600TKclbtxemavbK3HQZ+IghIjQ1ziGg4XmxBwIt
 YPktaEJTHYSsbV8ZVcggbWzYCn7PhZCzjruthMKoNFMROaB9WNe3LvdN3D1ZZdEA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v01u4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 07:24:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52H7BBnx025459;
 Mon, 17 Mar 2025 07:24:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v01u4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 07:24:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H53ehf024471;
 Mon, 17 Mar 2025 07:24:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dnckvu3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 07:24:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52H7O1jA32309870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Mar 2025 07:24:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF19620043;
 Mon, 17 Mar 2025 07:24:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0834120040;
 Mon, 17 Mar 2025 07:24:00 +0000 (GMT)
Received: from [9.124.208.205] (unknown [9.124.208.205])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Mar 2025 07:23:59 +0000 (GMT)
Message-ID: <513b3d62-cb6d-4634-be9e-7593d4dbe4bd@linux.ibm.com>
Date: Mon, 17 Mar 2025 12:53:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ppc/spapr: Fix possible pa_features memory overflow
To: Nicholas Piggin <npiggin@gmail.com>
References: <20250317052339.1108322-5-npiggin@gmail.com>
Content-Language: en-US
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20250317052339.1108322-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sIc7xh2_2hGNa07hSJ6PX6XMcTx8hoOI
X-Proofpoint-GUID: 2FU3lqEMV0Cb3T2TcQDV3JPjosDFUy_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=942
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170049
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nick,


Thnks for taking care of this, I was about to post a fix.


On 3/17/25 10:53 AM, Nicholas Piggin wrote:
> Coverity reports a possible memory overflow in spapr_dt_pa_features().
> This should not be a true bug since DAWR1 cap is only be true for
> CPU_POWERPC_LOGICAL_3_10. Add an assertion to ensure any bug there is
> caught.
>
> Resolves: Coverity CID 1593722
> Fixes: 5f361ea187ba ("ppc: spapr: Enable 2nd DAWR on Power10 pSeries machine")
> Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a415e51d077..9865d7147ff 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -296,6 +296,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           pa_features[40 + 2] &= ~0x80; /* Radix MMU */
>       }
>       if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
> +        g_assert(pa_size > 66);

SPAPR_CAP_DAWR1 is set to off in default_caps_with_cpu() for below P10 
(compat mode

cases).


So, this works.


I was planning to fix this instead with

+ if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1) && pa_size > 66) { 
pa_features[66] |= 0x80; }

just being in-line with the other similar checks in the same function.


Reviewed-By: Shivaprasad G Bhat <sbhat@linux.ibm.com>


Regards,

Shivaprasad


