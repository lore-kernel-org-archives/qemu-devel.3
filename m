Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647CAC98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kc4-0002yd-1j; Thu, 24 Sep 2026 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9kby-0002xm-1n; Thu, 24 Sep 2026 10:39:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9kbw-0004I5-Gi; Thu, 24 Sep 2026 10:39:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6Lpu2028087; Thu, 24 Sep 2026 14:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HW2C6+
 KmDFdPiGFkXkEflf2xNH748hO/VN0+GBjwSZg=; b=W1tmSpTCbvs7BSfXN7yHik
 m7HGUO9IK5lKfXFllAB8y7yGNbm0dMJSfYobbavdQwGHTekOleXkbSKDpz3mTyxa
 xwh8SrMwVMt+vENErN/m6Xeb8P7WeUu4HTtIXnUIqA1k2dbXYNH7e8HBrcV/qUL8
 e74V6jUnv3aWDwSyAo3oJa7uElbUjpF9TEfEbq3R30Ig4tWps61w1PPXK9pr39n2
 gCgUFGlZk1hx/pg1i2Ja6TNMFbuOK0nK6lFBZDlLpPzpQE0h96+tvGSeYDe57CYr
 W/VgNxDIaMgiieTLgL4BSNU8XzDtrwgofykZHhyP3Lac6ptwh2dF+mKuiQMUBdGw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1s2r8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:39:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENetZ2232008; Thu, 24 Sep 2026 14:39:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1x93r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:39:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEdcUH46006764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:39:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E761620049;
 Thu, 24 Sep 2026 14:39:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 982C420040;
 Thu, 24 Sep 2026 14:39:37 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:39:37 +0000 (GMT)
Message-ID: <ea7dd9b0-0ba6-4485-a488-eb5fe9d5a570@linux.ibm.com>
Date: Thu, 24 Sep 2026 16:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] s390x/sclp: Reject short headers in PV case
To: Janosch Frank <frankja@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260922201526.2383047-1-farman@linux.ibm.com>
 <20260922201526.2383047-10-farman@linux.ibm.com>
 <84b2133f-a8e2-47d2-8fe7-46c2b92118c5@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <84b2133f-a8e2-47d2-8fe7-46c2b92118c5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QKhkxTdMreStnTPG_382bk_hXL4NNyuT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX48lo3aFbi0iK
 8MLW2cNDYtyFfarNxllr7h7FylinHkjjvAp/Lzrxa/bZogK1Wbh/Xy0gZYIaiVh+mXUNFqKfiRO
 VgeVGZw1nURRUQKjh0IZFsygzNCn/KtvH6SM13WUvc8yACqnbcyv/UwZ9ya2rLYTj0P3IoyvewX
 IunCExgJ1vmC7aBxg8bt5QeiXRaG/tdPdcKY2+py5O+A11AXf3H+t1rZokdZOPXZ19H2D1wOdaE
 F7ZVA89hF8NRmsnID/hdo+eel1XVYCcUnz7PUE1Dyz13d3cVbUPnPIAc9UZPLaVdkO2jStJwYpT
 xEcvvTuqm2e+eZDhOj/XHGkJ6zUo+YNzJg7kWbr5SWpFXWWhxocRfYGeaT99xDUxEPsYnaROhIs
 Yv36TQ/PjawmDO80v5WlPBM6MSOz8KD8f9AteEK+f619rZlClNH4eSvcPCo5HC1CVCOgvEOoWQs
 5S/cwJzgSv8Cyrs/qxA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab5362e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KtSC8xqL46-p2JaDzLIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX8f2NjfFqQJtk
 /0BKoU5KI0NrVW/IN1exxn3TRv1cYaBNGd/sKeau77PZNjIEI4U7Bue9HBk2fUI8lwuMOf1FMfA
 NOvxL7qjMfZOEcxwNkoQcZA5/IgYpcs=
X-Proofpoint-GUID: QKhkxTdMreStnTPG_382bk_hXL4NNyuT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 24.09.26 um 16:36 schrieb Janosch Frank:
> On 9/22/26 10:15 PM, Eric Farman wrote:
>> An invalid length in an SCCB header correctly generates a specification
>> exception for the regular (non-PV) codepath that processes an SCLP
>> instruction intercept. The PV case doesn't, even though such a thing
>> should already be sanitized. Since a short length will cause problems
>> later down the line with the storage that will be allocated based on
>> that size, put up a defensive check and return if it is too short.
>>
>> Cc: Janosch Frank <frankja@linux.ibm.com>
>> Cc: qemu-stable@nongnu.org
>> Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided length")
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
> 
> How would you hit that if the architecture says FW will automatically inject a spec exception without exiting to the hypervisor if length < 8?

As I said in my review, current UV will sanitize this, so this is just defence in depth in case
there would be an implementation error.

> 
> Did you witness this happening?
> Am I missing something?
> 
>>   hw/s390x/sclp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index d8b655efcc..ad8129a5d8 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -277,6 +277,11 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
>>       s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
>> +    /* Do nothing if the header appears malformed */
>> +    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
>> +        goto out_no_write;
>> +    }
>> +
>>       work_sccb = g_malloc0(be16_to_cpu(header.length));
>>       s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
>>                            be16_to_cpu(header.length));
>> @@ -290,6 +295,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
>>   out_write:
>>       s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
>>                             be16_to_cpu(header.length));
>> +out_no_write:
>>       sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>>       return 0;
>>   }
> 


