Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88B7C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDgE-0000eO-Gn; Mon, 17 Jun 2024 10:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sJDgC-0000dh-4N; Mon, 17 Jun 2024 10:49:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sJDg8-0000FF-NI; Mon, 17 Jun 2024 10:49:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEUgjb007446;
 Mon, 17 Jun 2024 14:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=t
 K9C6n7yt7lZDxcqxQMwG00sDXaUsFot34rb+TKzby4=; b=nLg9B93l5/Ip7xo8n
 Lk+a1KBZTArPYhg6hHZLjlrfPJHK1XB3up7WRSnCnzhYmBPlBTQrETlDCRdJ61/j
 Qo8N8OiEEJuWXic17ZN7YIpcmW2OxNH/WttPM0q5H/xWcxn7DNWs13Ygi+HsLPQr
 Fvt/JOENC+DYm+ZRk6k63jMkQuX58iY8MtAZIPaTLV2B/cPNbMmNWi6ebMdsD5lg
 yv6/fDFy/OBLltFOfTzxjK4r4hI4jt0ONvp8pBpBkWpufemy7Urg0Cvjehu6IjdG
 EGYZwBwMbCFXUkDo83zb/uhorXDPuPP7mZlVQ/oIccs4Jp+26CJISDwsOMFWSc6i
 gJh4Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytpxx81hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 14:49:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HEh3uE024329;
 Mon, 17 Jun 2024 14:49:48 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytpxx81hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 14:49:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45HD0OaL006226; Mon, 17 Jun 2024 14:49:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9ubaxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 14:49:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HEngW654002108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2024 14:49:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 344AF2004B;
 Mon, 17 Jun 2024 14:49:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC97D20043;
 Mon, 17 Jun 2024 14:49:41 +0000 (GMT)
Received: from [9.171.8.89] (unknown [9.171.8.89])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 14:49:41 +0000 (GMT)
Message-ID: <e742d10b-d37a-4611-a554-235ebd3e57c1@linux.ibm.com>
Date: Mon, 17 Jun 2024 16:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x: Enable and document boot device fallback on
 panic
To: Thomas Huth <thuth@redhat.com>, jrossi@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-6-jrossi@linux.ibm.com>
 <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nej8FMdLyjrHAOx0yA7Pbe3khBjgmsQl
X-Proofpoint-ORIG-GUID: k3GPEy-bN5S9Z31vYv5yMmRO-SRFWp-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170112
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 05.06.24 um 15:37 schrieb Thomas Huth:
> On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> On a panic during IPL (i.e. a device failed to boot) check for another device
>> to boot from, as indicated by the presence of an unused IPLB.
>>
>> If an IPLB is successfully loaded, then jump to the start of BIOS, restarting
>> IPL using the updated IPLB.  Otherwise enter disabled wait.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   docs/system/bootindex.rst         | 7 ++++---
>>   docs/system/s390x/bootdevices.rst | 9 ++++++---
>>   pc-bios/s390-ccw/s390-ccw.h       | 6 ++++++
>>   3 files changed, 16 insertions(+), 6 deletions(-)
> 
> Could you please split the documentation changes into a separate patch in v2 ? ... I think that would be cleaner.
> 
>> diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
>> index 8b057f812f..de597561bd 100644
>> --- a/docs/system/bootindex.rst
>> +++ b/docs/system/bootindex.rst
>> @@ -50,9 +50,10 @@ Limitations
>>   Some firmware has limitations on which devices can be considered for
>>   booting.  For instance, the PC BIOS boot specification allows only one
>> -disk to be bootable.  If boot from disk fails for some reason, the BIOS
>> -won't retry booting from other disk.  It can still try to boot from
>> -floppy or net, though.
>> +disk to be bootable, except for on s390x machines. If boot from disk fails for
>> +some reason, the BIOS won't retry booting from other disk.  It can still try to
>> +boot from floppy or net, though.  In the case of s390x, the BIOS will try up to
>> +8 total devices, any number of which may be disks.
> 
> Since the old text was already talking about "PC BIOS", I'd rather leave that paragraph as it is (maybe just replace "PC BIOS" with "x86 PC BIOS"), and add a separate paragraph afterwards about s390x instead.
> 
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index c977a52b50..de3d1f0d5a 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -43,6 +43,7 @@ typedef unsigned long long u64;
>>   #include "iplb.h"
>>   /* start.s */
>> +extern char _start[];
>>   void disabled_wait(void) __attribute__ ((__noreturn__));
>>   void consume_sclp_int(void);
>>   void consume_io_int(void);
>> @@ -88,6 +89,11 @@ __attribute__ ((__noreturn__))
>>   static inline void panic(const char *string)
>>   {
>>       sclp_print(string);
>> +    if (load_next_iplb()) {
>> +        sclp_print("\nTrying next boot device...");
>> +        jump_to_IPL_code((long)_start);
>> +    }
>> +
>>       disabled_wait();
>>   }
> 
> Honestly, I am unsure whether this is a really cool idea or a very ugly hack ... but I think I tend towards the latter, sorry. Jumping back to the startup code might cause various problem, e.g. pre-initialized variables don't get their values reset, causing different behavior when the s390-ccw bios runs a function a second time this way. 

We jump back to _start and to me it looks like that this code does the resetting of bss segment.
So anything that has a zero value this should be fine. But static variables != 0 are indeed tricky.
As far as I can see we do have some of those :-(

So instead of jumping, is there a way that remember somewhere at which device we are and then trigger a re-ipl to reload the BIOS?

