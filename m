Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8760C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx4cu-0003JX-P9; Tue, 25 Mar 2025 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tx4cq-0003Ir-SA; Tue, 25 Mar 2025 09:47:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tx4co-0005c5-Uw; Tue, 25 Mar 2025 09:47:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCSRq5013331;
 Tue, 25 Mar 2025 13:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9Xe5U+
 5eMeHUIVPtmke8pC/Mqs6nNJclVj5XBD54RfY=; b=fbqBPI8RSyAE1tisn0LthG
 WauNZiqSeGV7FqHiBNJkfgMfb+X/HfSLU6So0+58xpKEp4/B/Tx1n1jcZgpHAg/l
 xlKJFd+8x82NGCI1EdFR7C35Fun8oPjp0qejG+lVta14cXVvwXK6tMwTPbV2Qpqm
 B035trsSeTZHnYMCn46Ll7m2peKJa3Kpoy2vTDQh5Dt+YZb4Urkhi5Q4l/GQktwE
 9RjdYLfMN8rRwZ1G707fUQ2qqtrYZPh60TInHjdK5Bd3LhzJ8DN3jY6H5tlLAc2V
 GY+4LYlHGfzD6Y+uFSbwe+XfuSUYOPVPvOIywEeEQOB+zFYpuR8o2QPo9QSy5RyA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kvh30cj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 13:47:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PAVxrJ005796;
 Tue, 25 Mar 2025 13:47:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82ba5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 13:47:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PDlJqr29754032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 13:47:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28F3B58055;
 Tue, 25 Mar 2025 13:47:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C39058043;
 Tue, 25 Mar 2025 13:47:18 +0000 (GMT)
Received: from [9.12.79.26] (unknown [9.12.79.26])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 13:47:18 +0000 (GMT)
Message-ID: <a043e145-5f18-4489-8335-58152e262654@linux.ibm.com>
Date: Tue, 25 Mar 2025 09:47:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/5] s390: implementing CHSC SEI for AP config
 change
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
 <20250311151616.98244-6-rreyes@linux.ibm.com>
 <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uyiiGidUHhS87KMpGUdbJ7ZCcFxh4Q86
X-Proofpoint-GUID: uyiiGidUHhS87KMpGUdbJ7ZCcFxh4Q86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 3/17/25 9:41 AM, Thomas Huth wrote:
> On 11/03/2025 16.16, Rorie Reyes wrote:
>> Handle interception of the CHSC SEI instruction for requests
>> indicating the guest's AP configuration has changed.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   target/s390x/ioinst.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>> index a944f16c25..f061c6db14 100644
>> --- a/target/s390x/ioinst.c
>> +++ b/target/s390x/ioinst.c
>> @@ -17,6 +17,7 @@
>>   #include "trace.h"
>>   #include "hw/s390x/s390-pci-bus.h"
>>   #include "target/s390x/kvm/pv.h"
>> +#include "hw/s390x/ap-bridge.h"
>>     /* All I/O instructions but chsc use the s format */
>>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t 
>> ipb,
>> @@ -573,13 +574,19 @@ out:
>>     static int chsc_sei_nt0_get_event(void *res)
>>   {
>> -    /* no events yet */
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        return ap_chsc_sei_nt0_get_event(res);
>> +    }
>> +
>>       return 1;
>>   }
>>     static int chsc_sei_nt0_have_event(void)
>>   {
>> -    /* no events yet */
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        return ap_chsc_sei_nt0_have_event();
>> +    }
>> +
>>       return 0;
>>   }
>
>  Hi!
>
> This unfortunately fails to link when configuring QEMU with the 
> "--without-default-devices" configure switch:
>
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_ioinst.c.o: in 
> function `ioinst_handle_chsc':
> /tmp/qemu-mini/target/s390x/ioinst.c:587:(.text+0x1ce1): undefined 
> reference to `ap_chsc_sei_nt0_have_event'
> /usr/bin/ld: /tmp/qemu-mini/target/s390x/ioinst.c:578:(.text+0x1d1c): 
> undefined reference to `ap_chsc_sei_nt0_get_event'
> collect2: error: ld returned 1 exit status
>
> I guess you have to rather use some callback mechanism, stubs or 
> #ifdefs here instead.
>
>  Thomas
>
Hey Thomas,

Just want to let you know that I saw your review and I will address this 
issue



