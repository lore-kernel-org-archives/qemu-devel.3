Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ED2C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viflw-0001xp-BL; Wed, 21 Jan 2026 16:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1viflv-0001wx-BR; Wed, 21 Jan 2026 16:29:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1viflt-0000h4-N8; Wed, 21 Jan 2026 16:29:51 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LCU9ZA028524;
 Wed, 21 Jan 2026 21:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ROwZ2i
 74gkv3uHwoF2HCWBwlxl3ru29UCpfUHCFvICA=; b=hftmPchOlpkF48WgN6v2yu
 Br3GWxeRqug1HaCKZyIX7SIsOapWgNPfJ29EVpEz58g+PFR07+tHSXTw3r7TCL1k
 ajxoF8R7iKOz+AgHinOdEwGA2uKEFQUFiGVV65LUuUMTyqoHTpkcM8NoPdu4NGSL
 4PFH+Sc8pEWFRef8xvXynJdcnnLLfJV2VZnwNvSeee2ug1wNNRaR9udd9dgo01GU
 PGQqq/kYBwHcjIMWtVrJXIEepq7nrnqfvBhPadRzK1TPxYvuwPNOzUXgV46cYeS9
 hdkmM2X7iTa0oZQMOSZ+7/K/a562ALi0B7eCMDbIwb87BW/JzLw33pgBDzcc3W6Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60et2kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 21:29:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LJfZS8001441;
 Wed, 21 Jan 2026 21:29:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjxcye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 21:29:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60LLTgPL20578886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jan 2026 21:29:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6580458058;
 Wed, 21 Jan 2026 21:29:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E0C5805D;
 Wed, 21 Jan 2026 21:29:40 +0000 (GMT)
Received: from [9.61.163.161] (unknown [9.61.163.161])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jan 2026 21:29:40 +0000 (GMT)
Message-ID: <137ae89c-ddc0-44ae-a9bc-2b6cb0a62953@linux.ibm.com>
Date: Wed, 21 Jan 2026 16:29:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/29] pc-bios/s390-ccw: Introduce IPL Information
 Report Block (IIRB)
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-14-zycai@linux.ibm.com>
 <e5a34764-4fa2-40c8-af80-8bd5aefd1e63@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <e5a34764-4fa2-40c8-af80-8bd5aefd1e63@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=69714548 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=FoqJY8j909O2fm7tPbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HYXyaY37Tfbz3e-NwASjJq3-GqQjZ7Sf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE3OCBTYWx0ZWRfXygRWiOw4JlcK
 XgGILbNfAUHvb0Xm91pUA7SoUS3m/PAZzndgd0e9INj657s0Pm27yNbLQAmSLha3+nrhFD6Ygt1
 MUBCz1aQE72EW90E9RUR+BrCmFmGDasG42HpDYryfE7IkfXHzOWaP5Pkr1TJaFLXB23DBwRpHJV
 9UT82t/8j9T+F9f6zckDYBjTmdIoEFpNEIucoiJMmJeMC/h8VTXMzSJS8lnkSQa6INiIAXgzbAY
 5+wW6oZ95HXtXM02X7WDDxS1uAZYJBEBwZz+W8UoxGpQ/0jlVr3SeA4N5uzVRNeYoNsV/vNOKN0
 59NCYEoQBlwf84pTCGAjziStCSQJRbLn202Gsp+FDwo9S7YlaE8pGc0puQ90y4829jsDzeKXPS0
 f5vnYhkG+UMhKh+m5tLr0LLasDHoUEIBZsflUdlJu6ooYtk1jbcg4zvQqQs3mREcGayEP+Dma/h
 5QDJj40mD2WL34bN5bw==
X-Proofpoint-ORIG-GUID: HYXyaY37Tfbz3e-NwASjJq3-GqQjZ7Sf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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



On 1/15/26 4:34 PM, Collin Walling wrote:
> On 12/8/25 16:32, Zhuoying Cai wrote:
>> The IPL information report block (IIRB) contains information used
>> to locate IPL records and to report the results of signature verification
>> of one or more secure components of the load device.
>>
>> IIRB is stored immediately following the IPL Parameter Block. Results on
>> component verification in any case (failure or success) are stored.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  docs/specs/s390x-secure-ipl.rst | 13 +++++++
>>  pc-bios/s390-ccw/iplb.h         | 62 +++++++++++++++++++++++++++++++++
>>  2 files changed, 75 insertions(+)
>>
>> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
>> index be98dc143d..29c5d59b99 100644
>> --- a/docs/specs/s390x-secure-ipl.rst
>> +++ b/docs/specs/s390x-secure-ipl.rst
>> @@ -86,3 +86,16 @@ Subcode 1 - perform signature verification
>>      * ``0x0302``: PKCS#7 format signature is invalid
>>      * ``0x0402``: signature-verification failed
>>      * ``0x0502``: length of Diag508SigVerifBlock is invalid
>> +
>> +IPL Information Report Block
>> +----------------------------
>> +
>> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
>> +IPL Information Report Block (IIRB), which contains the results from secure IPL
>> +operations such as:
>> +
>> +* component data
>> +* verification results
>> +* certificate data
>> +
>> +The guest kernel will inspect the IIRB and build the keyring.
> 
> This needs more elaboration.  Is the data listed above used in
> the keyring?  Maybe rewording to "The guest's kernel will use this data
> in the IIRB when building its keyring." ?
> 

Thanks for pointing this out. The data in the IIRB is not used to build
the keyring. I'll update the text as:

"When secure boot is enabled, the guest kernel will inspect the IIRB."

[...]


