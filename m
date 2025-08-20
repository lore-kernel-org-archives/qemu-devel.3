Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3C7CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 06:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uochR-00071n-3S; Wed, 20 Aug 2025 02:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uoch9-0006zk-V2; Wed, 20 Aug 2025 02:53:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uoch7-00068M-QB; Wed, 20 Aug 2025 02:53:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNoERU019528;
 Wed, 20 Aug 2025 06:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pkuQxT
 l2S5Zj5QE0iXeHk+YuE/QmW1S3j1GwXOgAu8Y=; b=jSWnlpS1o2HJAd6t02n9Ae
 MMu/wq6iKw/QIGa9la/lmhTK6Ab62r+T3KouyThWRvEygkBS1E6bcMr+o4G95IWg
 V22jo/3i+Ljq2KLs3FYkgck86usKLDfPzIJ+JKCkHWoL8mCMCIiKcpq00HVwHJmD
 XEA6ziMMylXjQOY7t5zJAOnd7vQytk+xkTM8Fm0v3piQ9L/l2x2mGj0PIihwkL8y
 OLGN5oHz4526+rvNQqtuW1bdYDtaOROC/Lg7KWaGTX0S7K/Tlsfb2fd5qUSL5iVL
 x40ti8COXT+0A/zElGF9qNMkV6SWnbs4Z3FoEAM8Ubqi+/EskE1hAhso56sqCAMA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vhemn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 06:53:09 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57K6d5wa014773;
 Wed, 20 Aug 2025 06:53:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vhemb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 06:53:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57K4wJ9q008716;
 Wed, 20 Aug 2025 06:53:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my42253p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 06:53:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57K6r3TP28639604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Aug 2025 06:53:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AB752004B;
 Wed, 20 Aug 2025 06:53:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECDFB20040;
 Wed, 20 Aug 2025 06:52:58 +0000 (GMT)
Received: from [9.39.17.140] (unknown [9.39.17.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Aug 2025 06:52:58 +0000 (GMT)
Message-ID: <90b6cc95-ebad-4049-a436-acd005ad504a@linux.ibm.com>
Date: Wed, 20 Aug 2025 12:22:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/ppc: Add stub for pnv_chip_find_core()
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-4-philmd@linaro.org>
 <eff37ca7-d977-450e-85e0-ca8e4f6f3d5a@redhat.com>
 <ba766eae-e8e0-436a-ad30-625744b872e4@linaro.org>
 <199516cc-a180-4859-b10f-17590c8c7f19@tls.msk.ru>
 <1368a4f5-2984-417b-9224-5d6f866ccc85@tls.msk.ru>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <1368a4f5-2984-417b-9224-5d6f866ccc85@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vSWRmHffL9OjmiclA-EDA4kLJuEcq0Kh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXzGYXp6e9mwTU
 g9kVyWtquEYaDwW8Q332UjKTG/x18VKfPL6EbZdM2/h83gK9pPQBBlmZ+7tPqLvH+alElFtmHr5
 WNF9ViFRl8wvl/gTupeeCAULAcWdpI9PsBc1Q/DRHppAHyqn6LZXDFq15ZLh2Xu0yyjWtNaLKqa
 12B/SzTNL8kXbCfSVjX0JS/mSRAma0YvnplmjfRF+4eyzuEhzVePI0pgT2fn5GDBj/2IlNLSoXO
 QFypIWXo7bbLc+V7QuoOZ1BqHrv9luYGWt4vL75YHk6DPnUAE7c7sLVOxMI4xcVksgbqoJMg7tb
 G0YiwITz1ShF0G2wRwfoIhjTYOJR5X7CG6YJJPH2hC1xR89GfEvQJEIG7VmSmYvvRJzwR1aXfhg
 S/rkatgKIWtrwiWjiez7AB9W/nQing==
X-Proofpoint-GUID: BGHBK46LupuvoiTh5IV4SZ_AyBRI8mLZ
X-Authority-Analysis: v=2.4 cv=KPwDzFFo c=1 sm=1 tr=0 ts=68a570d5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=R0I-Ol8fVH3hxnWSoNUA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 10/08/25 13:30, Michael Tokarev wrote:
> On 13.07.2025 14:18, Michael Tokarev wrote:
>> Hi!
>>
>> Has this change been forgotten?
>
> Another ping?
>
> Or can we assume this change isn't needed anymore? :)


Thanks for the pings Michael.

About the change, we will post a patch-set soon with the suggested 
change by Cedric.

I was on vacation past week, so couldn't see the mails.


Thanks,

- Aditya G


