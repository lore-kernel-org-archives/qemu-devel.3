Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94581048927
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 01:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw9Ql-0007Jn-Ny; Fri, 27 Feb 2026 20:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vw9Qj-0007JG-Q8; Fri, 27 Feb 2026 20:47:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vw9Qi-0002Ip-7Z; Fri, 27 Feb 2026 20:47:41 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RLDLV12347359; Sat, 28 Feb 2026 01:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=M3dGo3
 zqI8K9bVpcYrH1pQiUW21B0Vmw/37M8ZNtcbs=; b=AuZX3BLWm+RGexkZUrfgIR
 GGbrHsbsRXemFqD2WOGHyTT1290NkckfDFZZxpydWCzCg0uCrKfqEFXUA5rCb4pG
 cWH0f9ntYzlGwDmehO4E4ZiIg/413qpqlLJj5gbNmuk6HjOZ6Zt3Z/grHhPXPopo
 2pGMiPhcdv0Q5yp2/iyp5FntlWNJsgh/W1XRkTbLLp9CtYxYpPJ9z2IPSG6A5jfs
 AhHpjN0RsLBaf/Y/q+dN28dVYeW+DTAHl+5LSEd+AOdN7MLsPpBXxBMoBFRze9iJ
 sxgPVUhfAs8VxsQoQ5uFNGSn7n4or7NdrA7GbSK4XpjNu1+FSzWRRWwiXXozuSJQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8594myp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 01:47:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RMsbIa030298;
 Sat, 28 Feb 2026 01:47:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkvvu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 01:47:34 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61S1lXI929950628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Feb 2026 01:47:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 254A95805A;
 Sat, 28 Feb 2026 01:47:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 853D058054;
 Sat, 28 Feb 2026 01:47:31 +0000 (GMT)
Received: from [9.61.45.42] (unknown [9.61.45.42])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Feb 2026 01:47:31 +0000 (GMT)
Message-ID: <d561af0e-7bbf-4eeb-a1fc-1bff9d65ae4f@linux.ibm.com>
Date: Fri, 27 Feb 2026 20:47:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/30] s390x/diag: Introduce DIAG 320 for Certificate
 Store Facility
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-6-zycai@linux.ibm.com>
 <a80ebb96-2f18-4be2-839e-409b3d30defc@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <a80ebb96-2f18-4be2-839e-409b3d30defc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDAxMyBTYWx0ZWRfX0pY5GwWxt5NB
 37Vk+4NymzuZy72QgyT0XG8nZvEKQUaPB9bid36c0zI2hyQArliXSqGGhOe7E+IAJpeR2r1p3me
 DM1puLtREnxzivZurT9flMOI1spnAvHbk3Xeg+hjw8vxhAawz3NjHE6yqhl4vtvjIdb2qrme77o
 U+oSKzaZPCuBWAiOas2Gfxz3qmKbTZnWWzH5PyA7ZwCDENm8jTQ3lLKp56E7WmC45gTulaUrUb6
 PF0vtC8quucsSJ4di2aozfp4lkeZRGfXbzJAr3GG3xqn69GAgKFWt72adbNpUrg0MHKgUyzullS
 OHvOWN+615P//SOiKQDLyoNqBMmKAVTZTQvQRH3Krxr5ciAKyRaItIAnMXGJQhR7YVOO88R7jpq
 ZGUX17nxaw0nFbB8W9dyxWSwYJ/47eBIBZ7Bx449eow4kucNo/vD5ssDqoyfQVCHpVmi/sT2H6n
 paohCGRHL9kZLxV3ccg==
X-Proofpoint-GUID: wmNXF8ezn9XRKJX6qLRkJwzf3ZMy0Gwy
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a24937 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=Ex4RbgpnyNBPlYhkkXUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wmNXF8ezn9XRKJX6qLRkJwzf3ZMy0Gwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602280013
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/27/26 7:41 AM, Thomas Huth wrote:
> On 12/02/2026 21.43, Zhuoying Cai wrote:
>> DIAGNOSE 320 is introduced to support Certificate Store (CS)
>> Facility, which includes operations such as query certificate
>> storage information and provide certificates in the certificate
>> store.
>>
>> Currently, only subcode 0 is supported with this patch, which is
>> used to query the Installed Subcodes Mask (ISM).
>>
>> This subcode is only supported when the CS facility is enabled.
>>
>> Availability of CS facility is determined by byte 134 bit 5 of the
>> SCLP Read Info block. Byte 134's facilities cannot be represented
>> without the availability of the extended-length-SCCB, so add it as
>> a check for consistency.
>>
>> Note: secure IPL is not available for Secure Execution (SE) guests,
>> as their images are already integrity protected, and an additional
>> protection of the kernel by secure IPL is not necessary.
>>
>> This feature is available starting with the gen16 CPU model.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   docs/specs/s390x-secure-ipl.rst     | 12 +++++++++
>>   include/hw/s390x/ipl/diag320.h      | 20 ++++++++++++++
>>   target/s390x/cpu_features.c         |  1 +
>>   target/s390x/cpu_features_def.h.inc |  1 +
>>   target/s390x/cpu_models.c           |  2 ++
>>   target/s390x/diag.c                 | 42 +++++++++++++++++++++++++++++
>>   target/s390x/gen-features.c         |  3 +++
>>   target/s390x/kvm/kvm.c              | 16 +++++++++++
>>   target/s390x/s390x-internal.h       |  2 ++
>>   target/s390x/tcg/misc_helper.c      |  7 +++++
>>   10 files changed, 106 insertions(+)
>>   create mode 100644 include/hw/s390x/ipl/diag320.h
>>
>> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
>> index 7ddac98a37..c2e8f7aba5 100644
>> --- a/docs/specs/s390x-secure-ipl.rst
>> +++ b/docs/specs/s390x-secure-ipl.rst
>> @@ -14,3 +14,15 @@ and a summation of the sizes.
>>   
>>   Note: A maximum of 64 certificates are allowed to be stored in the certificate
>>   store.
>> +
>> +DIAGNOSE function code 'X'320' - Certificate Store Facility
>> +-----------------------------------------------------------
>> +
>> +DIAGNOSE 'X'320' is used to provide support for userspace to directly
>> +query the s390 certificate store. Userspace may be the s390-ccw BIOS or
>> +the guest kernel.
> I think I'd rather say "guest code" instead of "userspace" in the above two 
> sentences, to avoid confusion. "userspace" is normally everything that does 
> not belong to the kernel, so the term sounds rather misleading here.
> 
> Anyway, with that confusion fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Will do. Thanks for the review!


