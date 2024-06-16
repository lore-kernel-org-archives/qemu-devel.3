Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05969C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 23:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIzYD-0007Z8-5x; Sun, 16 Jun 2024 19:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sIzYA-0007YG-K6; Sun, 16 Jun 2024 19:44:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sIzY8-0002mA-Q9; Sun, 16 Jun 2024 19:44:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GNQuLW006544;
 Sun, 16 Jun 2024 23:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=y
 LqF9YQCPtVk5ZgVJCxRgQsBP2XNF2M7X2DPN1rT/lQ=; b=qjYhi8BoSVbwyKKCz
 iGwDv8W5qAed1QRxLYcLAUj77DAliLI5DsRRorMjc7sCRDV+UJfp8Ec3oUXogNi/
 Vq0h+YhmvjHlWL7KXmKtapafVfcJgBgGPDouq/ST7qWX/KId83zXRlmLIyze1cN+
 yuxjJ59tKe2xbOnDhTf0K4+/LjqGS99PkFrx73ImI/dmjOD20PUDXofljQB7Q8TP
 cLE19K4VmPoOnJ//Hh7X3e9twG8eH5vAr4+siKPjcLR/zz3UCV97OsFFe2vIN85t
 WlOxbPJsd+PMTG2Rn5cXmeLXvz4SQ5KcwVBaQF2i7JrsfzjHYp05UrS2fs3VAbVB
 /KNvQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yt8efg54j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Jun 2024 23:44:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45GNiboP000497;
 Sun, 16 Jun 2024 23:44:37 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yt8efg54f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Jun 2024 23:44:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45GMB2ZW006227; Sun, 16 Jun 2024 23:44:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9u5pn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Jun 2024 23:44:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45GNiXPv53608908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 16 Jun 2024 23:44:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDA2B58060;
 Sun, 16 Jun 2024 23:44:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3D6E5803F;
 Sun, 16 Jun 2024 23:44:32 +0000 (GMT)
Received: from [9.67.62.243] (unknown [9.67.62.243])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 16 Jun 2024 23:44:32 +0000 (GMT)
Message-ID: <062b6182-7599-4012-bc10-6ba85e624df1@linux.ibm.com>
Date: Sun, 16 Jun 2024 19:44:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x: Enable and document boot device fallback on
 panic
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-6-jrossi@linux.ibm.com>
 <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
 <6407dc07-8f16-4765-9da4-fd2b0e4e94e9@linux.ibm.com>
 <e421b171-ae66-4282-b204-f29847d6a80e@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <e421b171-ae66-4282-b204-f29847d6a80e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0m2LzVVz1l7aqDg2Sks1NRrMPdjvjOkm
X-Proofpoint-GUID: PPtlCEzmI1V71I69X39_dzhdykMryMlW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_12,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406160183
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/7/24 1:57 AM, Thomas Huth wrote:
> On 05/06/2024 16.48, Jared Rossi wrote:
>>
>>>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>>>> index c977a52b50..de3d1f0d5a 100644
>>>> --- a/pc-bios/s390-ccw/s390-ccw.h
>>>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>>>> @@ -43,6 +43,7 @@ typedef unsigned long long u64;
>>>>   #include "iplb.h"
>>>>     /* start.s */
>>>> +extern char _start[];
>>>>   void disabled_wait(void) __attribute__ ((__noreturn__));
>>>>   void consume_sclp_int(void);
>>>>   void consume_io_int(void);
>>>> @@ -88,6 +89,11 @@ __attribute__ ((__noreturn__))
>>>>   static inline void panic(const char *string)
>>>>   {
>>>>       sclp_print(string);
>>>> +    if (load_next_iplb()) {
>>>> +        sclp_print("\nTrying next boot device...");
>>>> +        jump_to_IPL_code((long)_start);
>>>> +    }
>>>> +
>>>>       disabled_wait();
>>>>   }
>>>
>>> Honestly, I am unsure whether this is a really cool idea or a very 
>>> ugly hack ... but I think I tend towards the latter, sorry. Jumping 
>>> back to the startup code might cause various problem, e.g. 
>>> pre-initialized variables don't get their values reset, causing 
>>> different behavior when the s390-ccw bios runs a function a second 
>>> time this way. Thus this sounds very fragile. Could we please try to 
>>> get things cleaned up correctly, so that functions return with error 
>>> codes instead of panicking when we can continue with another boot 
>>> device? Even if its more work right now, I think this will be much 
>>> more maintainable in the future.
>>>
>>>  Thomas
>>>
>>
>> Thanks Thomas, I appreciate your insight.  Your hesitation is 
>> perfectly understandable as well.  My initial design was like you 
>> suggest, where the functions return instead of panic, but the issue I 
>> ran into is that netboot uses a separate image, which we jump in to 
>> at the start of IPL from a network device (see zipl_load() in 
>> pc-bios/s390-ccw/bootmap.c). I wasn't able to come up with a simple 
>> way to return to the main BIOS code if a netboot fails other than by 
>> jumping back.  So, it seems to me that netboot kind of throws a 
>> monkeywrench into the basic idea of reworking the panics into returns.
>>
>> I'm open to suggestions on a better way to recover from a failed 
>> netboot, and it's certainly possible I've overlooked something, but 
>> as far as I can tell a jump is necessary in that particular case at 
>> least. Netboot could perhaps be handled as a special case where the 
>> jump back is permitted whereas other device types return, but I don't 
>> think that actually solves the main issue.
>>
>> What are your thoughts on this?
>
> Yes, I agree that jumping is currently required to get back from the 
> netboot code. So if you could rework your patches in a way that limits 
> the jumping to a failed netboot, that would be acceptable, I think.
>
> Apart from that: We originally decided to put the netboot code into a 
> separate binary since the required roms/SLOF module might not always 
> have been checked out (it needed to be done manually), so we were not 
> able to compile it in all cases. But nowadays, this is handled in a 
> much nicer way, the submodule is automatically checked out once you 
> compile the s390x-softmmu target and have a s390x compiler available, 
> so I wonder whether we should maybe do the next step and integrate the 
> netboot code into the main s390-ccw.img now? Anybody got an opinion on 
> this?
>
>  Thomas
>

Hi Thomas,

I would generally defer the decision about integrating the netboot code 
to someone with more insight than me, but for what it's worth, I am of 
the opinion that if we want to rework all of panics into returns, then 
it would make the most sense to also do the integration now so that we 
can avoid using jump altogether.  Unless I'm missing something simple, I 
don't think the panic/return conversion will be trivial, and actually I 
think it will be quite invasive since there are dozens of calls to panic 
and assert that will need to be changed.   It doesn't seem worthwhile to 
do all of these conversions in order to avoid using jump, but then still 
being exposed to possible problems caused by jumping due to netboot 
requiring it anyway.

Regards,

Jared Rossi

