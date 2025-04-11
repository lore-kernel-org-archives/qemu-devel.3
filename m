Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A11C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 17:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3ISu-0002I8-40; Fri, 11 Apr 2025 13:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u3IS5-00029d-Fu; Fri, 11 Apr 2025 13:46:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u3IS3-0000vP-I5; Fri, 11 Apr 2025 13:46:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGjLkp010946;
 Fri, 11 Apr 2025 17:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0TCHbE
 DWPRfBCeFGoUUgq7dClll66r03sHOtI37zQ6Y=; b=BvTuDKQtSfextQFziTP8Ia
 6icJLe6im/Ef32Xkvbnr6QbMjASwZBjDlipj7dAbaii9WGMRrHVRAslZFSxRW/qz
 Xiz+oTYbZwTmg0deTUleKSXvuaCDa/bEiN3WKwgDTm3GdkIQK8I07UyEclq9eNj6
 vqtV9CiArvsBPRLCg1Bn2psJeWkteIdlH+IQ0a5eX6wzhzL9sZZhrwKPHT2Ahwvi
 1xgNjPwZog7UqAYqfRWV+AyLXabALCMeyJG7W+y7UXwECy6do/dczBAkZ7CAUYv1
 sq7epHQtj2MPWrGmkXADJ1jzpIYeEmXaMUDYA9maQR2Leq7hUZSw8SqdA9FgbTEA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y343sm12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 17:45:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGoqit029513;
 Fri, 11 Apr 2025 17:45:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k79xdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 17:45:45 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53BHjhhS25297560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 17:45:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A13AC5805A;
 Fri, 11 Apr 2025 17:45:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6330958051;
 Fri, 11 Apr 2025 17:45:42 +0000 (GMT)
Received: from [9.61.177.130] (unknown [9.61.177.130])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Apr 2025 17:45:42 +0000 (GMT)
Message-ID: <97cc380e-89c2-49dd-be2a-3ec8caf5b86d@linux.ibm.com>
Date: Fri, 11 Apr 2025 13:45:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/24] Add -boot-certificates /path/dir:/path/file
 option in QEMU command line
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-2-zycai@linux.ibm.com>
 <2e8a1ccf-5073-48dc-9641-c80d95d65b93@redhat.com>
 <Z_kRtundT0x2-LxY@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <Z_kRtundT0x2-LxY@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mNJMTBBLvbpER4ZCG8YLj6Y-lRZYRTea
X-Proofpoint-ORIG-GUID: mNJMTBBLvbpER4ZCG8YLj6Y-lRZYRTea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 4/11/25 8:57 AM, Daniel P. Berrangé wrote:
> On Fri, Apr 11, 2025 at 12:44:17PM +0200, Thomas Huth wrote:
>> On 08/04/2025 17.55, Zhuoying Cai wrote:
>>> The `-boot-certificates /path/dir:/path/file` option is implemented
>>> to provide path to either a directory or a single certificate.
>>>
>>> Multiple paths can be delineated using a colon.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>   qemu-options.hx | 11 +++++++++++
>>>   system/vl.c     | 22 ++++++++++++++++++++++
>>>   2 files changed, 33 insertions(+)
>>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index dc694a99a3..b460c63490 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -1251,6 +1251,17 @@ SRST
>>>       Set system UUID.
>>>   ERST
>>> +DEF("boot-certificates", HAS_ARG, QEMU_OPTION_boot_certificates,
>>> +    "-boot-certificates /path/directory:/path/file\n"
>>> +    "                  Provide a path to a directory or a boot certificate.\n"
>>> +    "                  A colon may be used to delineate multiple paths.\n",
>>> +    QEMU_ARCH_S390X)
>>> +SRST
>>> +``-boot-certificates /path/directory:/path/file``
>>> +    Provide a path to a directory or a boot certificate.
>>> +    A colon may be used to delineate multiple paths.
>>> +ERST
>>
>> Unless there is a really, really good reason for introducing new top-level
>> options to QEMU, this should rather be added to one of the existing options
>> instead.
>>
>> I assume this is very specific to s390x, isn't it? So the best way is likely
>> to add this as a parameter of the machine type option, so that the user
>> would specify:
>>
>>  qemu-system-s390x -machine s390-ccw-virtio,boot-certificates=/path/to/certs
>>
>> See the other object_class_property_add() statements in
>> ccw_machine_class_init() for some examples how to do this.
> 
> With other arches that use EDK2 (x86, arm64, riscv64, loongarch64) we
> pass this info via fw_cfg
> 
>    -fw_cfg name=etc/edk2/https/cacerts,file=<certdb>
> 
> Assuming this series is trying to implement a pre-existing s390x machine
> standard for passing certs, then it seems inevitable that it will need
> a different config approach than we use for EDK2.
> 
> With regards,
> Daniel

Thank you for your feedback.

The -boot-certificates option aims to provide a path to either a
directory or a single certificate on the host. The certificate(s) will
be loaded into the key store and used during signature verification.

s390x will likely need to handle certificates differently from other
architectures.

Regards,
Joy


