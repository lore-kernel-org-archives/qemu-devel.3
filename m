Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA2BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCF1B-0003Ah-Gc; Fri, 24 Oct 2025 06:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCF15-00039p-6I; Fri, 24 Oct 2025 06:27:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCF13-0003mQ-Fc; Fri, 24 Oct 2025 06:27:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7RHfv028980;
 Fri, 24 Oct 2025 10:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BEV0Ri
 W4oeycU5an2qD7m3H+Y3RSI01tKpuf4x9qrp4=; b=XrovO5do5DoBmv6bdLBp6O
 BF/1DMs/EcGf4wpFEUJ+MZjqf7IyA8UhMGdsk9jr3Mq5kMFur09VMgSlonNv/bRy
 AtSgkF3NrLh43UdEB6rJeD6S9P0j0gEPBygM+UOLThvRsKrV89LHTyOXOqbZ2Ta8
 lg/PcFQfW7ke2u/IxdeR5cDArXnPbKrHPV6Q6yAbCY/jYPpxZ/qrMcZr6HlTHAIv
 utgQTuN7hjSIHPQrmCtUoqIZ4dcNfiN4h4Bhy2zAiJDSdG3XW64eOwcdk1qBQ3o0
 k3gyJ2c87zrjNeuO2tAkYY5egnL03K0JTG+gHxn+v5NkYkcw9/uG5CT6erpD523Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hw5tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 10:27:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OAImeg030628;
 Fri, 24 Oct 2025 10:27:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hw5t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 10:27:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OA7udE011075;
 Fri, 24 Oct 2025 10:27:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1jb6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 10:27:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OAR4cp38535672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 10:27:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 944AC20043;
 Fri, 24 Oct 2025 10:27:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3240920040;
 Fri, 24 Oct 2025 10:26:56 +0000 (GMT)
Received: from [9.39.24.164] (unknown [9.39.24.164])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 10:26:55 +0000 (GMT)
Message-ID: <d2feba95-6590-49cd-b239-234ea07432f7@linux.ibm.com>
Date: Fri, 24 Oct 2025 15:56:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 2/6] core/loader: capture Error from load_image_targphys
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vishal Chourasia <vishalc@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 richard.henderson@linaro.org, alistair@alistair23.me,
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com,
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn,
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com,
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-5-vishalc@linux.ibm.com>
 <pg226vepbq7c5ckwguxpysgirdj4sydgfl54c6wshed5ifqbvb@lu5rv4gaxokb>
 <5f54bcb6-ab0d-4777-be1c-ed50903f2333@linaro.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <5f54bcb6-ab0d-4777-be1c-ed50903f2333@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4QsZmcHfpCBe
 GxB8Soy/QB5dEWkUT7v/zy5+2rZOJtgTc4INxS6tZnh/ABqbSabkwb2NyhxlpHAs3M+jcookb3g
 tyCjGF3FKi/9ro7sFwOmxbqpZ3G4wLPsDCDF95/qAWrEHe+HRchB83zOwJzsaNvEjUgVpWWjdc0
 tHn6H59M3GxSPZKbvOEUSHs3LhgiE3LnU27rU3EtjWSOUBZI0t9oGYSLcJ7uaZJlnJ1rBKbFedQ
 kOo8U4BvQui6r6gNmfNQ1/oStIvQZxoHNmK1J6AElyg/agVcsR9qS6LRdGbOWxw/P5AOCwxNZ3I
 +jBXptgwYLTRq6UH6/c62X0VLo6ltpnzp/OLilP6l2Jhr4kG3+I1T7rlG6/GveHdnhGXnoQA4Tw
 iHCFvwEtZ/JVTpsXAGWn0xcb2yWCQQ==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fb547e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=OUYZ-xaPB0UwExXdii8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: hcubnwLJ2QmxCJT8yrsjOi1il6sF4Tt6
X-Proofpoint-ORIG-GUID: Z0jGUQ_7vWVUPmSfoaAtm0Pt6gx6gLoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 24/10/25 15:36, Philippe Mathieu-Daudé wrote:
> On 24/10/25 11:44, Aditya Gupta wrote:
>> On 25/10/24 02:56PM, Vishal Chourasia wrote:
>>> Add Error **errp parameter to load_image_targphys(),
>>> load_image_targphys_as(), and get_image_size() to enable better
>>> error reporting when image loading fails.
>>>
>>> Pass NULL for errp in all existing call sites to maintain current
>>> behavior. No functional change intended in this patch.
>>>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>
>> All tests pass for me, and changes look good.
>
> Does that imply:
>
>   Tested-by: Aditya Gupta <adityag@linux.ibm.com>
>
> ?

Yes Philippe, can add Tested-by.


Tested-by: Aditya Gupta <adityag@linux.ibm.com>


These are the tests I ran on the series:

* PowerPC tests (manually starting a VM + check-functional-ppc64)
* Build test all patches, so no patch introduces a compile error
* Gitlab pipeline passing


Didn't test all archs, but i don't see much functional changes to any 
arch other than ppc with the series.


Thanks,

- Aditya G


>
>>
>> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
>>
>> Thanks,
>> - Aditya G
>>
>>
>

