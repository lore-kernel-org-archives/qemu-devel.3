Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23042C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7l7-0005HP-1L; Tue, 25 Mar 2025 13:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7kw-0005AN-33; Tue, 25 Mar 2025 13:08:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7ku-0006kI-HU; Tue, 25 Mar 2025 13:08:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PFCB6K027910;
 Tue, 25 Mar 2025 17:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3rpw8S
 VEJKeysuOEZjfXWXJKyFIvKjnp7WJNviOIPX8=; b=MyvnZwhTdXHnTztvTbJ8U8
 VoFiSrtVlkhq5EVepHaRKGDD3KH34iULOdIKngrspFbHHCf92EZoNce5i7CrzWf8
 Qms6YVM5cybxFIXatkuMaG8jesr7Qh0lYCd1IiUxgbZr+3E5ChMMWuguvw7X9xW+
 KA2opb215f6zxMPdrV2//LLM2RIqnkKizqHn6Vb7hyjUMOD6xONZdvTopz79QnnS
 B2JOe7eWfi5zw7sYbuizPQDoML5dC1cLyVCzxu8rixNhVFZlIzcgBME4sQFrpVMB
 67suOw3SSNMrIaaPTxHqexfwUL8hgf2T9DmEnZl4ZZezqPaOTCODl+9sWVcOgrNA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjwx3a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:07:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PH1rE6016895;
 Tue, 25 Mar 2025 17:07:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjwx3a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:07:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PFxIDq030308;
 Tue, 25 Mar 2025 17:07:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htckqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:07:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PH7kkf47579414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 17:07:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88DFC20040;
 Tue, 25 Mar 2025 17:07:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B83720043;
 Tue, 25 Mar 2025 17:07:44 +0000 (GMT)
Received: from [9.39.16.55] (unknown [9.39.16.55])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 17:07:44 +0000 (GMT)
Message-ID: <8567b41e-f2b8-413c-93b8-15c74788c171@linux.ibm.com>
Date: Tue, 25 Mar 2025 22:37:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ppc/pnv: Introduce Power11 PowerNV machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-8-adityag@linux.ibm.com>
 <952b3afa-dc63-4230-bdff-5decabc8c25c@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <952b3afa-dc63-4230-bdff-5decabc8c25c@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dzTDWTWfacBgB-bS2dKmiXM2OxcD9TOY
X-Proofpoint-ORIG-GUID: zrpkYuUyckh25lm8qQ-3WQxBa61cLRLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/03/25 20:17, Cédric Le Goater wrote:

> On 3/25/25 12:23, Aditya Gupta wrote:
>> <...snip...>
>>
>>  +static void pnv_machine_power11_class_init(ObjectClass *oc, void 
>> *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
>> +    static const char compat[] = "qemu,powernv11\0ibm,powernv";
>> +
>> +    pmc->compat = compat;
>> +    pmc->compat_size = sizeof(compat);
>> +    pmc->max_smt_threads = 4;
>> +    pmc->has_lpar_per_thread = true;
>> +    pmc->quirk_tb_big_core = true;
>> +    pmc->dt_power_mgt = pnv_dt_power_mgt;
>> +
>> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>
> There was a lot of work done to have dynamic PHBs in the PowerNV
> machines. This was to add support in libvirt and this goal was
> abandoned when people left. I think we should consider removing
> it as it adds unnecessary complexity.
>
Thanks for telling the history behind it, agreed this is unnecessary, 
will remove in v7.


> Anyhow,
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
Thanks for the tag Cédric !

- Aditya Gupta

> Thanks,
>
> C.
>

