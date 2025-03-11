Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80211C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvJu-00020s-Vm; Tue, 11 Mar 2025 04:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1trvJr-0001zJ-D0; Tue, 11 Mar 2025 04:50:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1trvJo-0007iG-84; Tue, 11 Mar 2025 04:50:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKckUf026749;
 Tue, 11 Mar 2025 08:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PA4F/k
 MXfTK+KYtBXEnay6ZFpoCqqFeI7f3HQNgfSdI=; b=hQTt0QA+oF3JVScn/BK3sl
 QF9R43GGrRbr3ZQ3esqfoVPDibR74MAyfEob84oec/FiHT6akGPLr38AELFghwH8
 2yWBwBuND+Qv+Zvp1BUam/VXFpyn1On0GEzTKGn3YiinOfkfTP7lWsCGlqc/Jjrh
 450NZwLCy7zcdRoOIRiHghNlNSsUCZ6AJ9zbZ0OWGC0Jrz2FdifjMu2L9oq5obbF
 GaTXOtCWJTLaxkUrpEaaQMwB0X4epn3fyvUEOQfeiBG4LyaIJDR8HgG9mv+4Bs7W
 LTDbC1lqEv9ytXVe3cCDNGayko8RV6jxYDZODxXFgtzqZ8VKLMxk5csMTqOBA+5Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7a1apsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 08:50:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B8oRk8012215;
 Tue, 11 Mar 2025 08:50:27 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7a1apsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 08:50:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B8ibSw006987;
 Tue, 11 Mar 2025 08:50:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45907t3eys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 08:50:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52B8oMED36766088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 08:50:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCB0E20049;
 Tue, 11 Mar 2025 08:50:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6F0320040;
 Tue, 11 Mar 2025 08:50:20 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Mar 2025 08:50:20 +0000 (GMT)
Message-ID: <ba566dc3-6b40-4bf4-8011-7a96b330f2db@linux.ibm.com>
Date: Tue, 11 Mar 2025 14:20:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] ppc/pnv: Update skiboot to support Power11
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250308205141.3219333-1-adityag@linux.ibm.com>
 <20250308205141.3219333-9-adityag@linux.ibm.com>
 <f9ea56e0-a104-4acd-a27e-7d2813efe319@kaod.org>
 <094f0623-e483-4097-aca0-9f320b27af1a@linux.ibm.com>
 <04b8c4ce-0a58-4f50-97e4-b1cc30b8b340@kaod.org>
 <d9ca52cd-6afd-4ed2-9e99-76ca5cbf7b80@linux.ibm.com>
 <1d1021e1-c138-42f3-a563-365a22cfd3d9@kaod.org>
 <D8DAVJVMV52X.240ECM32F54AO@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D8DAVJVMV52X.240ECM32F54AO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H0Yjq9kWt-Tc9xIfhicWXLDwr5MDpwV-
X-Proofpoint-GUID: 7Ona20w0vAh7Vr9a0AQyu9SlDcCfXSOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxlogscore=775 malwarescore=0
 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503110057
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

On 11/03/25 14:09, Nicholas Piggin wrote:

> On Tue Mar 11, 2025 at 1:33 AM AEST, Cédric Le Goater wrote:
>> On 3/10/25 15:59, Aditya Gupta wrote:
>>> On 10/03/25 17:15, Cédric Le Goater wrote:
>>>> On 3/10/25 11:31, Aditya Gupta wrote:
>>>>>>> <...snip...>
>>>>>>>    pc-bios/skiboot.lid | Bin 2527328 -> 2527424 bytes
>>>>>>>    1 file changed, 0 insertions(+), 0 deletions(-)
>>>>>> This change should come first as a sub maintainer PR, to avoid sending 2.5MB
>>>>>> on the mailing list :/ See how SLOF is handled.
>>>>>>
>>>>> Sorry didn't know this. I just checked the git log of skiboot.lid and thought maybe it's this same way of sending patches.
>>>> For example, see  :
>>>>
>>>> https://lore.kernel.org/qemu-devel/CACPK8XfoKNxr6_KkDFFZm0P5w9m_ddD5E4SeuAkypXXr7swR7A@mail.gmail.com/
>>>>
>>> Thanks for the example Cédric. Now I see.
>>>
>>>
>>>> To be sent before v6.
>>> Sure, will wait for the maintainer to send it first before v6.
>> AFAICT, this person would be you or Nick, or one OPAL team member ?
> Yes, I kind of butchered the skiboot PR message but no matter.
> I was planning to update skiboot bios because it contains HOMER/OCC
> fixes we need to test the QEMU updates to those models.
>
> Power11 support is nice too, unfortunately I will skip the P11
> patches for now. They will need some updates after the HOMER/OCC
> changes but that shouldn't be too hard I can help with it if
> needed. I will try to get your P11 in asap next time.

Okay. I will push the next patches after the skiboot and homer updates then.


Thanks Nick.


>
> Thanks,
> Nick
>

