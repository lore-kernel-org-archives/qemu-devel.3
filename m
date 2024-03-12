Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114BFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyCO-00079M-Dw; Tue, 12 Mar 2024 05:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjyCI-000790-TH; Tue, 12 Mar 2024 05:13:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjyCE-000157-SA; Tue, 12 Mar 2024 05:13:22 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C978wk015326; Tue, 12 Mar 2024 09:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vE+AcQCL+BPUM1uIcwyd8cOQ9CQt7wD/6k577H0trYE=;
 b=oWh150MYdhCO0JRaeA4yw+hNiGU5tJ/OXgNXcwYNDc13gYaI9sreT/F/v246V9FLSzEA
 ied6rmyO3FJYQ2SXmbIQ2WRmO/W7e0U+8mwGINR0xRfCMtrfD1RvQNO8fhfrt7YAsjiu
 Csf6PEAo7o8RBb6atNG3BDzk0AG//pQyf6tZG1RMMABgPwIh6FrOacg3D/wdtZzeaA82
 MK5752J+SVNpR2G0iNtqwBO+9hG5QF89C4ODgGh6J1PCjnlhT7LnaQsJPAV+2p7x8Gb0
 FdCtKogydlCzWR+Lyd0nrEnMjnb2sBXPm17ZUyAEfnf5a5MZsn0ie3Ekl2dtZCh8L5VT DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtm4sg2st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:13:12 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C988WZ017401;
 Tue, 12 Mar 2024 09:13:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtm4sg2sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:13:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C6UFtE020435; Tue, 12 Mar 2024 09:13:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kkwxbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:13:10 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C9D8Kb42074506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 09:13:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93D4058070;
 Tue, 12 Mar 2024 09:13:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F0D758056;
 Tue, 12 Mar 2024 09:13:04 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 09:13:04 +0000 (GMT)
Message-ID: <aec73651-6cb6-4a12-9b4b-f3b9d891b170@linux.ibm.com>
Date: Tue, 12 Mar 2024 14:43:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] ppc/spapr: Adjust ibm,pa-features for POWER9
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-6-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240311185200.2185753-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jIkz0MdGi5jJVvoL0mKGkl125_0HzO-Q
X-Proofpoint-ORIG-GUID: LulRnOa4lLugybOUAtFCMQu2laQmXyG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=989 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403120071
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> "MMR" and "SPR SO" are not implemented in POWER9, so clear those bits.
> HTM is not set by default, and only later if the cap is set, so remove
> the comment that suggests otherwise.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7d7da30f60..247f920f07 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -248,14 +248,14 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
>           /* 16: Vector */
>           0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> -        /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
> +        /* 18: Vec. Scalar, 20: Vec. XOR */
>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
>           /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
>           0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> -        /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
> -        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> -        /* 36: SPR SO, 40: Radix MMU */
> -        0x80, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> +        /* 32: LE atomic, 34: EBB + ext EBB */
> +        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> +        /* 40: Radix MMU */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
>           /* 42: PM, 44: PC RA, 46: SC vec'd */
>           0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
>           /* 48: SIMD, 50: QP BFP, 52: String */

