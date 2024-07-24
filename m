Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44CCC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVpT-0003rv-5z; Wed, 24 Jul 2024 02:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sWVpQ-0003qp-Mk; Wed, 24 Jul 2024 02:50:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sWVpO-00019B-K7; Wed, 24 Jul 2024 02:50:24 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5xULr001835;
 Wed, 24 Jul 2024 06:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=I
 BSnQl3poTAw7i8WVF0BLy4bhM9aSNG2pjHK6dIic88=; b=E/Pd4acn4aLUCSRrX
 gLdvF6NgZYnw8zlcxzde5l1H18yKBBRCwUy3JciCa4V4BIrnIwk9qp4DdkLrvxCJ
 LXBS1syQGqypIMgJf5XRF6hnJdStOA8qc757feLHgO/zmUHDApQmg+HJSI9vYyEw
 xC38Ij1LVSBc7o+aIVx3lgtpK11tnlSMOrGY2kc57yTnoIc2GJ7AGNGsxyqb266I
 PWBWlS+97C0F/YbeXGHH1KJm+JDZm1CtTAvJ2xRhActPzPYWDNQP17pxoPPSqD7e
 5kAXS/2p6Y1fSNeMYrMN3K252UEDHsTV9+6GAl0dAbpwkSLhJ7Eg5EuxOTyTscIU
 yRGHA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxa02tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 06:50:18 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46O6oH59022179;
 Wed, 24 Jul 2024 06:50:17 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxa02t8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 06:50:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46O5Gg0K007084; Wed, 24 Jul 2024 06:50:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72pdny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 06:50:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46O6oBrD42664440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 06:50:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED1DF201A1;
 Wed, 24 Jul 2024 06:31:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4307C2019C;
 Wed, 24 Jul 2024 06:31:16 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 06:31:16 +0000 (GMT)
Message-ID: <593c3cf9-0ab2-45e2-b973-b3cba73336f5@linux.ibm.com>
Date: Wed, 24 Jul 2024 12:01:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] target/ppc: reduce code duplication across
 Power9/10 init code
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-2-adityag@linux.ibm.com>
 <D2WO0N28SBFF.DGV2VYFLHR8K@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D2WO0N28SBFF.DGV2VYFLHR8K@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hoTJ_8eDC_MenZR5n5nZ7qBLADKoXFiS
X-Proofpoint-ORIG-GUID: 8jqZl9IIe_vxvx3jEAqPIHztADikjlIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_04,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=558
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240046
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

On 23/07/24 10:52, Nicholas Piggin wrote:
>> <...snip...>
>>
>> +    PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
>> +#define POWERPC_POWER10_PCC_PCR_SUPPORTED \
>> +    POWERPC_POWER9_PCC_PCR_SUPPORTED | PCR_COMPAT_3_10
>> +#define POWERPC_POWER9_PCC_LPCR_MASK                                        \
>> +    LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                           \
>> +    (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |                  \
>> +    LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |                 \
>> +    (LPCR_PECE_L_MASK & (LPCR_PDEE|LPCR_HDEE|LPCR_EEE|LPCR_DEE|LPCR_OEE)) | \
>> +    LPCR_MER | LPCR_GTSE | LPCR_TC | LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE |  \
>> +    LPCR_HDICE
>> +/* DD2 adds an extra HAIL bit */
>> +#define POWERPC_POWER10_PCC_LPCR_MASK \
>> +    POWERPC_POWER9_PCC_LPCR_MASK | LPCR_HAIL
>> +#define POWERPC_POWER9_PCC_FLAGS_COMMON                                 \
> POWERPC_FLAG_POWER9

Can we keep PPC_FLAG_POWER9 here ?

Like if all PowerPC flags start with PPC_* ?


Thanks,

Aditya Gupta

>
>> +    POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              \
>> +    POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |       \
>> +    POWERPC_FLAG_VSX | POWERPC_FLAG_SCV
>> +
>> +#define POWERPC_POWER9_PCC_FLAGS  \
>> +    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_TM
>> +#define POWERPC_POWER10_PCC_FLAGS \
>> +    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_BHRB
>> +
>> +#endif /* TARGET_PPC_CPU_INIT_H */

