Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923E0C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 04:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4CCO-0007gA-OM; Tue, 07 May 2024 00:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s4CCM-0007fJ-G0; Tue, 07 May 2024 00:13:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s4CCK-00079K-Dt; Tue, 07 May 2024 00:13:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44743JwC024608; Tue, 7 May 2024 04:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vvY04gXkOB4D+WEsP1Bo5LAC7Hd2KZz6ylAewgoVbok=;
 b=pOZVaJw+oXf4kz1Qla5pa+xDv8SU4po2aJG5O6Vu04XWrpZGBaTJL5pfc9FQLBJBg/L8
 kXt8fozLaFnvIrIx1fKQRW0pgKZ3usSJgIul0FxmMQM+/uUB+bxcFXp9Z3ki9+KcZqkX
 p1NA4oVp5wDH2mmGv1hgyh4+SIv6leDAXswZgET06K51G6l90wYFYi5cLTZMKgFvlMzN
 ICT/owCY8XP85sQDa51mt9wfN95iO8DCfHzqHxSI3U0x6waClx7JDpG7QY2vIsjjaQb/
 paOtpajwS3pZ8DXE9GzgmAvIK8c5aDChAyftCad/cKJGMBQXLD6g5tYEYYicZ0LnzfgC eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xycxa80m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 04:12:52 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4474Cq7J004196;
 Tue, 7 May 2024 04:12:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xycxa80m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 04:12:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4472KYn6010584; Tue, 7 May 2024 04:12:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx0bp3wyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 04:12:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4474Cl2u23069196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 May 2024 04:12:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8EF058065;
 Tue,  7 May 2024 04:12:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABF7458063;
 Tue,  7 May 2024 04:12:45 +0000 (GMT)
Received: from [9.109.243.194] (unknown [9.109.243.194])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 May 2024 04:12:45 +0000 (GMT)
Message-ID: <9efc3c34-2330-4337-bf69-3a7a13d691c5@linux.ibm.com>
Date: Tue, 7 May 2024 09:42:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spapr: Migrate ail-mode-3 spapr cap
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20240506115607.13405-1-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240506115607.13405-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8qjel7rWCsZL2moTsD4zWg0KjTguwxao
X-Proofpoint-ORIG-GUID: HpXFXOU2ysAp8zb-Kt-ZBr0Tv_l2ZXl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_01,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070029
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/6/24 17:26, Nicholas Piggin wrote:
> This cap did not add the migration code when it was introduced. This
> results in migration failure when changing the default using the
> command line.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ccc5a4c5e10 ("spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for H_SET_MODE hcall")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   include/hw/ppc/spapr.h | 1 +
>   hw/ppc/spapr.c         | 1 +
>   hw/ppc/spapr_caps.c    | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 4aaf23d28f..f6de3e9972 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -1004,6 +1004,7 @@ extern const VMStateDescription vmstate_spapr_cap_large_decr;
>   extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>   extern const VMStateDescription vmstate_spapr_cap_fwnmi;
>   extern const VMStateDescription vmstate_spapr_cap_rpt_invalidate;
> +extern const VMStateDescription vmstate_spapr_cap_ail_mode_3;
>   extern const VMStateDescription vmstate_spapr_wdt;
>   
>   static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d2d1e310a3..065f58ec93 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2169,6 +2169,7 @@ static const VMStateDescription vmstate_spapr = {
>           &vmstate_spapr_cap_fwnmi,
>           &vmstate_spapr_fwnmi,
>           &vmstate_spapr_cap_rpt_invalidate,
> +        &vmstate_spapr_cap_ail_mode_3,
>           &vmstate_spapr_cap_nested_papr,
>           NULL
>       }
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 0a15415a1d..2f74923560 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -974,6 +974,7 @@ SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>   SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>   SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>   SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVALIDATE);
> +SPAPR_CAP_MIG_STATE(ail_mode_3, SPAPR_CAP_AIL_MODE_3);
>   
>   void spapr_caps_init(SpaprMachineState *spapr)
>   {

