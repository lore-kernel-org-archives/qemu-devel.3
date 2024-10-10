Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2BCEDDA9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syi9I-00057N-MO; Wed, 09 Oct 2024 21:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi9E-0004wC-09; Wed, 09 Oct 2024 21:39:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi9C-0007f7-Fs; Wed, 09 Oct 2024 21:39:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0SvHZ020808;
 Thu, 10 Oct 2024 01:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=i
 4ItyDhpKmNvENSrdYDbYPdmIrrorxM2XQ2Gha5Phgc=; b=Kn3ec+MNkiGtMZsnA
 FEeFQOk5cagJPKxnXO6Yy16sVRl3Hu4l8RRZsTRSskHk8b3pVbN7H6r1HZUQBNiF
 Y0Jhuid00IICcudVQdo4wK3cwFYU5+bub/buYH6E8uM06uIG8ADp21lcLuIpx/Dx
 Xiy7zujw2SbMA9ml7iLhNCiNXcynUXS7lW5nGQ+Bt/m2d4A/BTVyr7IG4S/nUqYi
 Oo6LJ0pfrhRWYMzJx2letzkYkQ3ipa185CKWf1apDOSrvSxeyXEEqexpxYua8A8y
 XuVm+hVjOfn6ggCswr3+NCtp9jsf4uiRM4YLl2qdeaMfmy7WtowhIpyoXrqoTF9j
 oz8og==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4264dv870f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:39:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A1dKTa024882;
 Thu, 10 Oct 2024 01:39:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4264dv86y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:39:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0qDK4011512;
 Thu, 10 Oct 2024 01:38:38 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xwac4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:38:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A1cc5u37159280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 01:38:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2664558063;
 Thu, 10 Oct 2024 01:38:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB9495805A;
 Thu, 10 Oct 2024 01:38:37 +0000 (GMT)
Received: from [9.61.177.235] (unknown [9.61.177.235])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Oct 2024 01:38:37 +0000 (GMT)
Message-ID: <0798345d-fba7-4a01-8f8e-c77dfa2010ca@linux.ibm.com>
Date: Wed, 9 Oct 2024 21:38:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/19] pc-bios/s390-ccw: Remove panics from ISO IPL path
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-8-jrossi@linux.ibm.com>
 <afc6ae81-6a17-4172-a00b-90e4790af6b1@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <afc6ae81-6a17-4172-a00b-90e4790af6b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hH6el8wBTld-2UZ8vU94n_PSp6X_-Dx4
X-Proofpoint-ORIG-GUID: YjWFzKIv2wV9_YErdETG3kUf-lQTW3a_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_23,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100009
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/9/24 5:46 AM, Thomas Huth wrote:
> On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Remove panic-on-error from IPL ISO El Torito specific functions so 
>> that error
>> recovery may be possible in the future.
>>
>> Functions that would previously panic now provide a return code.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
> ...
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 414c3f1b47..7984de62fe 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -678,8 +678,10 @@ static bool 
>> is_iso_bc_entry_compatible(IsoBcSection *s)
>>       if (s->unused || !s->sector_count) {
>>           return false;
>>       }
>> -    read_iso_sector(bswap32(s->load_rba), magic_sec,
>> -                    "Failed to read image sector 0");
>> +    if (virtio_read(bswap32(s->load_rba), magic_sec)) {
>> +        puts("Failed to read image sector 0");
>> +        return false;
>> +    }
>>         /* Checking bytes 8 - 32 for S390 Linux magic */
>>       return !memcmp(magic_sec + 8, linux_s390_magic, 24);
>> @@ -699,21 +701,28 @@ static inline uint32_t 
>> iso_get_file_size(uint32_t load_rba)
>>       uint8_t *temp = sec + ISO_SECTOR_SIZE;
>>       int level = 0;
>>   -    read_iso_sector(ISO_PRIMARY_VD_SECTOR, sec,
>> -                    "Failed to read ISO primary descriptor");
>> +    if (virtio_read(ISO_PRIMARY_VD_SECTOR, sec)) {
>> +        puts("Failed to read ISO primary descriptor");
>> +        return -EIO;
>> +    }
>
> iso_get_file_size() seems to return an uint32_t value, so returning a 
> negative error code won't work here. I think you either have to change 
> the return type to signed "long" and fix the caller site, too, or 
> return 0 for errors here?
>
>  Thomas
>

Fixed by using "long" as suggested.  Also found and fixed an error with 
real_size < 0 not being handled correctly in a later part of the code 
that used "if (real_size)"

     Jared

