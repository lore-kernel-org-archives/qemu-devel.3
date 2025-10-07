Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6DFCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 19:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6DeH-0006fe-Tx; Tue, 07 Oct 2025 15:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1v6DeF-0006fN-Re; Tue, 07 Oct 2025 15:47:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1v6DeD-000380-6t; Tue, 07 Oct 2025 15:46:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597B7NTE022573;
 Tue, 7 Oct 2025 19:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Hgk7Zs
 gWFlP+QMZzGqVdCS4lHIMIb93uTANVeRH0PyU=; b=UI+mOiQ+hBw5t4v7OMy8CV
 KuV8urmKkMsp0rE+QiC8Ix4MhbUSVto7Ljj5mESJargmZfiGFzOlWBiC4a33HyWp
 a8GSVfYQ0Ng68CFqvbQAM0SlkWjBX0iSGXWvLLhAkue1eVuq5/vpJZqkqbH4Sy6s
 yVERNEuxGM2wdRLMvTDgxyfj4Edt7/9m62bTt5eASX4f+utFMYtA8zHKDB4vUPUC
 LwxL3EHDllvRpJqiAdECQhQ5sgYpdeB99NAMRmftjOJ2B+AOKSkQbtsKa14mWhJW
 L6ldgXtX+PemFetBRYkjAfMWe9VToufXLBET7LilwAVpXF94xele4hvPGsRoiCTw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h1c6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 19:46:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 597JCQPb019689;
 Tue, 7 Oct 2025 19:46:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kdwsd8x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 19:46:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 597Jknna29098590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Oct 2025 19:46:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B50AD58053;
 Tue,  7 Oct 2025 19:46:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39B7E58043;
 Tue,  7 Oct 2025 19:46:48 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Oct 2025 19:46:48 +0000 (GMT)
Message-ID: <07d8155c-05eb-461c-8be4-6a78ed0a0076@linux.ibm.com>
Date: Tue, 7 Oct 2025 15:46:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/28] s390x/diag: Introduce DIAG 508 for secure IPL
 operations
To: Thomas Huth <thuth@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-11-zycai@linux.ibm.com>
 <45084e29-1d7d-4922-8bf3-25ead6236549@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <45084e29-1d7d-4922-8bf3-25ead6236549@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfXyfNYLw2HrrVU
 iigkXZSom/kXqWzQwpFG7jl1Z//xTT1vofi7yRa9nLt08DkcAun1vze+wjcTqRO0yXfoEupN8WN
 BhMXqI+/D0DIvuqLaX8eobrWY/nSLqEMBqIczvzswjciG/M0bJ7e9MX9Nln2LPtmeWmQ0YBMcVX
 ODAUKY2MQ2Pa7MBVxW/8oHUGBJOZO9vvAa301s2Dz9CbW7YIBvbOtw7Q2VFdHy7nLsNf1Dz1+VW
 kpf7NUCed6tZLArj6b3gIT0g8CWI/23g6iBCNeLrut+FGVlP2wTTnkrDVAtz598VBojEs0UYBbn
 36+TPJMItWKDN+9TiKiPNoOdHT2YKepyFhA+oD23ZkrBOwagFlNI5Wfw3aBOmS6xU2okWwUYe8Q
 VnKPowDedqj/Qdlt4cKkEgc8sTrl4w==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e56e2b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=Ts6tOb6YaRzjPTZ2sFIA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1lPDCyuzUco22Z0HzkPDnPspKgffukQ3
X-Proofpoint-ORIG-GUID: 1lPDCyuzUco22Z0HzkPDnPspKgffukQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 10/7/25 05:47, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
>> From: Collin Walling <walling@linux.ibm.com>
>>
>> In order to support secure IPL (aka secure boot) for the s390-ccw BIOS,
>> a new s390 DIAGNOSE instruction is introduced to leverage QEMU for
>> handling operations such as signature verification and certificate
>> retrieval.
>>
>> Currently, only subcode 0 is supported with this patch, which is used to
>> query a bitmap of which subcodes are supported.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   docs/specs/s390x-secure-ipl.rst | 18 ++++++++++++++++++
>>   include/hw/s390x/ipl/diag508.h  | 15 +++++++++++++++
>>   target/s390x/diag.c             | 27 +++++++++++++++++++++++++++
>>   target/s390x/kvm/kvm.c          | 14 ++++++++++++++
>>   target/s390x/s390x-internal.h   |  2 ++
>>   target/s390x/tcg/misc_helper.c  |  7 +++++++
>>   6 files changed, 83 insertions(+)
>>   create mode 100644 include/hw/s390x/ipl/diag508.h
>>
>> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
>> index e28f0b40d7..0919425e9a 100644
>> --- a/docs/specs/s390x-secure-ipl.rst
>> +++ b/docs/specs/s390x-secure-ipl.rst
>> @@ -48,3 +48,21 @@ Subcode 2 - store verification certificates
>>       storage specified in the VCB input length field.
>>   
>>       VCE contains various information of a VC from the CS.
>> +
>> +
>> +Secure IPL Data Structures, Facilities, and Functions
>> +=====================================================
>> +
>> +DIAGNOSE function code 'X'508' - KVM IPL extensions
>> +---------------------------------------------------
>> +
>> +DIAGNOSE 'X'508' is reserved for KVM guest use in order to facilitate
>> +communication of additional IPL operations that cannot be handled by userspace,
>> +such as signature verification for secure IPL.
>> +
>> +If the function code specifies 0x508, KVM IPL extension functions are performed.
>> +These functions are meant to provide extended functionality for s390 guest boot
>> +that requires assistance from QEMU.
>> +
>> +Subcode 0 - query installed subcodes
>> +    Returns a 64-bit mask indicating which subcodes are supported.
> 
> Technically, this works also without KVM, right? In that case, I'd maybe 
> avoid the term "KVM" here, and just talk about "IPL extensions" and "guest", 
> to avoid the confusion about whether this feature can be used with TCG, too, 
> or not.
> 
>   Thomas
> 
> 

Fair enough.  None of the secure IPL code leverages KVM, so we can
reword the document a bit.

-- 
Regards,
  Collin

