Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93B3CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohyL-0003UR-QX; Wed, 20 Aug 2025 08:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uohxP-00034Y-Mz; Wed, 20 Aug 2025 08:30:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uohxN-0002uP-4Z; Wed, 20 Aug 2025 08:30:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KApEBn007900;
 Wed, 20 Aug 2025 12:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+UwXJX
 tYhiD9guNLIdCsHkTXsXPVj3p+gzL0vwu13TQ=; b=Jv0apyrLKHyjgQ3EDzvYeF
 Pka84Pyb6iIN1+ZP8doL8xyPWbmLNlDEOh6oyuLWGAmmrZRziuFoEmIBCRt9KexB
 HyDSmll38UCRu58i58AsFSYMug+j0DNh0h2er5tbyleyciH2VvuVzg2sMQQiNw/x
 g3nrw+A0AqtToc7nABCRHm1TPvnkN0Y3e6k2V5hDs5ZgnMFcGqZvx9g9C1WpXJgU
 MfPN9uxQjDPLVw4TM5ql9v12Zo0VX+VxJ+DKbUpWfxAchQW76vOQcNIgN9zNHvW5
 9+W4sAHk462QN3gXu1VGhGFiQlph+fAitZoJyMUfA2FZHA6JP+y31P/xWAlxu7BA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vtqvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 12:30:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57KCStI9008891;
 Wed, 20 Aug 2025 12:30:17 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vtqve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 12:30:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9VS0u015619;
 Wed, 20 Aug 2025 12:30:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my4237j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 12:30:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57KCUDHI58917208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Aug 2025 12:30:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 360E12004D;
 Wed, 20 Aug 2025 12:30:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D57120043;
 Wed, 20 Aug 2025 12:30:09 +0000 (GMT)
Received: from [9.39.18.124] (unknown [9.39.18.124])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Aug 2025 12:30:08 +0000 (GMT)
Message-ID: <ab2288fc-a319-4d11-a48e-2f286fbf90e1@linux.ibm.com>
Date: Wed, 20 Aug 2025 18:00:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/ppc: Add stub for pnv_chip_find_core()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-4-philmd@linaro.org>
 <eff37ca7-d977-450e-85e0-ca8e4f6f3d5a@redhat.com>
 <ba766eae-e8e0-436a-ad30-625744b872e4@linaro.org>
 <7a537212-3634-4fe4-b574-b9287c75cb2c@linux.ibm.com>
 <4dbb1946-9b01-4b66-a0e4-f49bcd19df42@linaro.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <4dbb1946-9b01-4b66-a0e4-f49bcd19df42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VWlXznzexIMK4fLoW6z3PYXwJMDvwNFy
X-Proofpoint-GUID: LR7vZ84FZW_k0Wp8vKdew0p5dpNR2OGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX0jFiYRp7pi1T
 GVUsfs54cZLrIbxLregyxBt+ixwnjOOgKhrgCX0VciT8bewyJYTCI3Z/ebxVK5hFcWi7+MMIgH4
 Fz0jfOs/DHftHM4EOZV1++3S0DEHL0DZ7smUmUZA7Lmhof+y9aypgV2S0PjFKdGGqL9EYB7z5j3
 LPggTpdWaVLD+dqH6ZnisyVzpkjjoaxxs4ZIb1qonfK72bbjDEc0qP0Qk9XAqgDNwGvtkx00csA
 4UmQem2K6yF90D4kGVDD6+SdzQTMWLq6Yh6gpv0XzcPCFMIlNJDK6W0Eg87/L5cdXNLDYKP9EjK
 gInWZvPtkyG7bFMd1/DXZYIro6Wk4P9zAranQ42CvwIj/zbD1xmBX3Ran9lX/b91/ESznQauSAX
 4tTBmdKUEgZfCQ8RWCux5BrzFb7pmQ==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a5bfda cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qMk-t8dg1BIzOFzmaMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

+Michael

On 11/08/25 14:10, Philippe Mathieu-Daudé wrote:
> On 22/7/25 20:04, Aditya Gupta wrote:
>> Hi Cédric and Philippe,
>>
>>
>> On 26/05/25 17:21, Philippe Mathieu-Daudé wrote:
>>> On 26/5/25 13:48, Cédric Le Goater wrote:
>>>> On 5/26/25 13:23, Philippe Mathieu-Daudé wrote:
>>>>> Since commit 9808ce6d5cb, building QEMU configured with
>>>>> '--without-default-devices' fails:
>>>>>
>>>>>    Undefined symbols for architecture arm64:
>>>>>      "_pnv_chip_find_core", referenced from:
>>>>>          _helper_load_sprd in target_ppc_misc_helper.c.o
>>>>>          _helper_store_sprd in target_ppc_misc_helper.c.o
>>>>>    ld: symbol(s) not found for architecture arm64
>>>>>    clang: error: linker command failed with exit code 1
>>>>> > Fix by adding a stub when CONFIG_POWERNV is not available.
>>>>
>>>> The fix would be to add an abstract handler to implement SPRD accesses
>>>> on the PowerNV machine.
>>
>>
>> Is this what you meant by an abstract handler ?
>> https://github.com/adi-g15-ibm/qemu/ 
>> commit/0abac37032a5ef66d64a649ce04f24876bf9007d
>
> I think so.
>
> Avoid using target_ulong if possible (I suppose SPRD only exists on
> 64-bit CPUs so can be uint64_t).


Thanks Phil. Posted along with your suggested change:

https://lore.kernel.org/qemu-devel/20250820122516.949766-2-adityag@linux.ibm.com/


Thanks,

- Aditya G



