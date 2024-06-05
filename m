Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68335C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErwn-0005lz-2T; Wed, 05 Jun 2024 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sErwl-0005kN-SQ; Wed, 05 Jun 2024 10:49:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sErwj-0006Mm-OC; Wed, 05 Jun 2024 10:49:03 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 455CrWPk020902; Wed, 5 Jun 2024 14:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=+8ayBeKg5gseh08c9bcg49TTuoVoX0wwQfNzAW3AzBg=;
 b=G+6ZylbbCtFfdIkol5JqIabziL4n/Ocg5sU9N9pI5Y/p/zritrGRce+sIIZrxClUHCjB
 sI7VrZNHktH1h0knfJktGaET1dyQS5MpAdx88hL1bEhZAR40clnNUjuF9lq5X6dfsxA7
 g3CkYYQRVcz1znCga1biERB8cQF3B8cH+bPyKR1uJNTwZuu3geKIQb3EQfzbdZSySWMt
 EhzIHGQ7W69g2wlnc6K4S8YO34inqdTGJEC5nLb0Wel/fqXn0I5BRKspeU8cfs3IT4Kq
 DjjxZ3AzyiqIx+wtDXduPTlqPnxb1HMkYHuX4Ct/0fEtwr+t7txPGK+qXZuVZTszu3R+ XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjrdw8c6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 14:48:59 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 455Emgvw013215;
 Wed, 5 Jun 2024 14:48:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjrdw8c6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 14:48:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 455Dn31u026674; Wed, 5 Jun 2024 14:48:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffn4jcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jun 2024 14:48:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 455Emtao34734770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jun 2024 14:48:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EDE358058;
 Wed,  5 Jun 2024 14:48:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D5B858059;
 Wed,  5 Jun 2024 14:48:54 +0000 (GMT)
Received: from [9.67.134.30] (unknown [9.67.134.30])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Jun 2024 14:48:54 +0000 (GMT)
Message-ID: <6407dc07-8f16-4765-9da4-fd2b0e4e94e9@linux.ibm.com>
Date: Wed, 5 Jun 2024 10:48:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x: Enable and document boot device fallback on
 panic
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-6-jrossi@linux.ibm.com>
 <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n0BkEqhhpr7lRq-9bNR7UYDNC3ZhjxFL
X-Proofpoint-ORIG-GUID: 10URFGiMecPQ6niDqRKrzbKmJK3WnK9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406050112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index c977a52b50..de3d1f0d5a 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -43,6 +43,7 @@ typedef unsigned long long u64;
>>   #include "iplb.h"
>>     /* start.s */
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
> Honestly, I am unsure whether this is a really cool idea or a very 
> ugly hack ... but I think I tend towards the latter, sorry. Jumping 
> back to the startup code might cause various problem, e.g. 
> pre-initialized variables don't get their values reset, causing 
> different behavior when the s390-ccw bios runs a function a second 
> time this way. Thus this sounds very fragile. Could we please try to 
> get things cleaned up correctly, so that functions return with error 
> codes instead of panicking when we can continue with another boot 
> device? Even if its more work right now, I think this will be much 
> more maintainable in the future.
>
>  Thomas
>

Thanks Thomas, I appreciate your insight.  Your hesitation is perfectly 
understandable as well.  My initial design was like you suggest, where 
the functions return instead of panic, but the issue I ran into is that 
netboot uses a separate image, which we jump in to at the start of IPL 
from a network device (see zipl_load() in pc-bios/s390-ccw/bootmap.c).  
I wasn't able to come up with a simple way to return to the main BIOS 
code if a netboot fails other than by jumping back.  So, it seems to me 
that netboot kind of throws a monkeywrench into the basic idea of 
reworking the panics into returns.

I'm open to suggestions on a better way to recover from a failed 
netboot, and it's certainly possible I've overlooked something, but as 
far as I can tell a jump is necessary in that particular case at least.  
Netboot could perhaps be handled as a special case where the jump back 
is permitted whereas other device types return, but I don't think that 
actually solves the main issue.

What are your thoughts on this?

Thanks,

Jared Rossi



