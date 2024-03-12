Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxpE-0002ad-CK; Tue, 12 Mar 2024 04:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjxp4-0002ZJ-Bz; Tue, 12 Mar 2024 04:49:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjxp1-0005ZA-4w; Tue, 12 Mar 2024 04:49:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C8kInv007709; Tue, 12 Mar 2024 08:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6KyAXOMhNBQlD68qhjqmu6gZ6FmaqjrQLsw0dvlkufU=;
 b=U+k27faIr7HitYxfi4bKGrod+xvKkAqqZJz0pkxqcLc3/FCrhNaTSlKuEahQ7dsYJP5Y
 FFiZm8YACAYcG4FgTDKaOdaEGYcZYU0zGsKu13IeeCb38VrF4pM8yh4yu8aq+wJCHKKX
 hZwyoO2miaAy+mkz3usGjIHcEGh/LtqOqG6ioR77akBinC5yJv3mJ1684aWusZ/MqyHr
 9bSoJgQCQLAziXXJEckhip/GwJqfkliidWJVcvTasbXoixPfhnXJ/lWG8GhCLqu1HfDg
 9xSrQxCbIsNBhHyOt76GcqgMij5RJMYukS1s4UlFGegMB7uP5G3XEhAYNSs1RAA2KmlT EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtjtq0swe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:49:13 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C8kKlE007940;
 Tue, 12 Mar 2024 08:49:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtjtq0sw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:49:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C8eOcR015477; Tue, 12 Mar 2024 08:49:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fyp3c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 08:49:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C8n9kI47907204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 08:49:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3596C5806A;
 Tue, 12 Mar 2024 08:49:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 287C358052;
 Tue, 12 Mar 2024 08:49:07 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 08:49:06 +0000 (GMT)
Message-ID: <d6723eb8-d5fe-4ae6-b1f3-5c701e5e877b@linux.ibm.com>
Date: Tue, 12 Mar 2024 14:19:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] ppc/spapr: Remove copy-paste from pa-features
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-5-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240311185200.2185753-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uknv7mlR-VtI0hP6P75M2X1rqLWZ6Lq0
X-Proofpoint-ORIG-GUID: pAYwrstXyQUEhYpptggwX4juTUOAcDUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120068
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

Hi Nick,

On 3/12/24 00:21, Nicholas Piggin wrote:
> TCG does not support copy/paste instructions. Remove it from
> ibm,pa-features. This has never been implemented under TCG or

s/or/nor ?

> practically usable under KVM, so it won't be missed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5099f12cc6..7d7da30f60 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -254,8 +254,8 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
>           /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
>           0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> -        /* 36: SPR SO, 38: Copy/Paste, 40: Radix MMU */
> -        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
> +        /* 36: SPR SO, 40: Radix MMU */
> +        0x80, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
>           /* 42: PM, 44: PC RA, 46: SC vec'd */
>           0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
>           /* 48: SIMD, 50: QP BFP, 52: String */
> @@ -288,6 +288,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>        * SSO (SAO) ordering is supported on KVM and thread=single hosts,
>        * but not MTTCG, so disable it. To advertise it, a cap would have
>        * to be added, or support implemented for MTTCG.
> +     *
> +     * Copy/paste is not supported by TCG, so it is not advertised. KVM
> +     * can execute them but it has no accelerator drivers which are usable,
> +     * so there isn't much need for it anyway.
>        */

If doing a re-spin, you may consider comments on prev patch applicable
above as well. Either ways, with prev typo fixed:

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   
>       if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {

