Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799FFCDD1CE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEZA-0004sr-30; Fri, 27 Sep 2024 13:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1suEYu-0004rS-87; Fri, 27 Sep 2024 13:15:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1suEYq-0000zi-0a; Fri, 27 Sep 2024 13:15:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RFYLn7025516;
 Fri, 27 Sep 2024 17:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=r
 syvZteLEZjYiV/Q2/hSs2w3z9EO8Ecn0b//nMQve24=; b=lB1a83S0hArHzjFYj
 aT6hAwga0oqc2X1FT/PGxnQkcZZdbYxhlLskbnQhMDjd6sGoOsfNaSyEo0ukletM
 +lTogrEst2BR/iDzH5YcE7U5DYT1C7z1Xu5qX5lVVsL6WLzaUpyhkdpz2lUCGiKT
 rJGQ3i8Sz4rZ6VBJ5k3RCxFbp2yUcsnCaIKm7EtQ1adFlX1hHnKUvjiEzAz0TtHG
 1uN0KamoU3K8Jitu024VrLMOGzsD5t6Mo01p2nPSyGl6g/BBEBjsgFsptX3TPFu1
 kt3qZyVjBYqV8FxlAQBbUd70nAJw0p4JNKpZdxv/AtcQdV6dO+5BS2ZdroXHK/Tx
 tW70Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvbnw5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 17:15:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48RHEpeB017639;
 Fri, 27 Sep 2024 17:15:15 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvbnw58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 17:15:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHA2bp020824;
 Fri, 27 Sep 2024 17:15:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb63nwfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 17:15:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48RHFDuW44630730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 17:15:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 369BC58052;
 Fri, 27 Sep 2024 17:15:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D122358056;
 Fri, 27 Sep 2024 17:15:12 +0000 (GMT)
Received: from [9.61.124.160] (unknown [9.61.124.160])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Sep 2024 17:15:12 +0000 (GMT)
Message-ID: <00351eda-78c2-46f6-a122-3527736d0fa5@linux.ibm.com>
Date: Fri, 27 Sep 2024 13:15:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] pc-bios/s390-ccw: Remove panics from ISO IPL path
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-8-jrossi@linux.ibm.com>
 <77cad234-524d-4166-ab1b-10666c8c676e@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <77cad234-524d-4166-ab1b-10666c8c676e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -UWHPNc4NvIeQvnD2XEocS1qVkBA8_Rn
X-Proofpoint-GUID: RduR6WpC5iVohSZrcfmIGjO3CqmPPWjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 9/27/24 11:02 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Remove panic-on-error from IPL ISO El Torito specific functions so 
>> that error
>> recovery may be possible in the future.
>>
>> Functions that would previously panic now provide a return code.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>
>> ---
>>   pc-bios/s390-ccw/bootmap.h  | 17 +++++++---
>>   pc-bios/s390-ccw/s390-ccw.h |  1 +
>>   pc-bios/s390-ccw/bootmap.c  | 64 ++++++++++++++++++++++++-------------
>>   3 files changed, 55 insertions(+), 27 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>> index bbe2c132aa..cb5346829b 100644
>> --- a/pc-bios/s390-ccw/bootmap.h
>> +++ b/pc-bios/s390-ccw/bootmap.h
>> @@ -385,17 +385,24 @@ static inline uint32_t iso_733_to_u32(uint64_t x)
>>     #define ISO_PRIMARY_VD_SECTOR 16
>>   -static inline void read_iso_sector(uint32_t block_offset, void *buf,
>> +static inline int read_iso_sector(uint32_t block_offset, void *buf,
>>                                      const char *errmsg)
>>   {
>> -    IPL_assert(virtio_read_many(block_offset, buf, 1) == 0, errmsg);
>> +    if (virtio_read(block_offset, buf)) {
>> +        puts(errmsg);
>> +        return 1;
>> +    }
>> +    return 0;
>>   }
>>   -static inline void read_iso_boot_image(uint32_t block_offset, void 
>> *load_addr,
>> +static inline int read_iso_boot_image(uint32_t block_offset, void 
>> *load_addr,
>>                                          uint32_t blks_to_load)
>>   {
>> -    IPL_assert(virtio_read_many(block_offset, load_addr, 
>> blks_to_load) == 0,
>> -               "Failed to read boot image!");
>> +    if (!virtio_read_many(block_offset, load_addr, blks_to_load)) {
>
> That "!" looks wrong here? Or do I misunderstood the original 
> IPL_assert() condition?
>

Basically all of the IPL_assert() conditions become logically flipped, 
but it is
intended. IPL_assert() panics if success condition is NOT met, but in 
the new
version an error code is returned if an failure condition IS met, so we are
branching on the inverse condition.
>> +        puts("Failed to read boot image!");
>> +        return 1;
>> +    }
>> +    return 0;
>>   }
>>     #define ISO9660_MAX_DIR_DEPTH 8
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 0ed7eb8ade..cbd92f3671 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -30,6 +30,7 @@ typedef unsigned long long u64;
>>   #define EIO     1
>>   #define EBUSY   2
>>   #define ENODEV  3
>> +#define EINVAL  4
>>     #ifndef MIN
>>   #define MIN(a, b) (((a) < (b)) ? (a) : (b))
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 414c3f1b47..31cf0f6d97 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -678,8 +678,10 @@ static bool 
>> is_iso_bc_entry_compatible(IsoBcSection *s)
>>       if (s->unused || !s->sector_count) {
>>           return false;
>>       }
>> -    read_iso_sector(bswap32(s->load_rba), magic_sec,
>> -                    "Failed to read image sector 0");
>> +    if (read_iso_sector(bswap32(s->load_rba), magic_sec,
>> +                    "Failed to read image sector 0")) {
>> +        return false;
>> +    }
>>         /* Checking bytes 8 - 32 for S390 Linux magic */
>>       return !memcmp(magic_sec + 8, linux_s390_magic, 24);
>> @@ -706,14 +708,18 @@ static inline uint32_t 
>> iso_get_file_size(uint32_t load_rba)
>>       sec_offset[0] = 0;
>>         while (level >= 0) {
>> -        IPL_assert(sec_offset[level] <= ISO_SECTOR_SIZE,
>> -                   "Directory tree structure violation");
>> +        if (sec_offset[level] > ISO_SECTOR_SIZE) {
>> +            puts("Directory tree structure violation");
>> +            return -EIO;
>> +        }
>>             cur_record = (IsoDirHdr *)(temp + sec_offset[level]);
>>             if (sec_offset[level] == 0) {
>> -            read_iso_sector(sec_loc[level], temp,
>> -                            "Failed to read ISO directory");
>> +            if (virtio_read(sec_loc[level], temp)) {
>> +                puts("Failed to read ISO directory");
>> +                return -EIO;
>> +            }
>
> Any reasons for switching from read_iso_sector() directly to 
> virtio_read() here?

I think this is just an oversight on my part.  I had thought to remove the
read_iso_sector() function entirely since it is just a wrapper for
virtio_read() that becomes redundant once the panic is removed, but it looks
like I wasn't consistent with where I removed it.  In my opinion we can 
remove
read_iso_sector() and just call virtio_read(), but either way it should be
consistent, so I will standardize the calls.  I don't see any compelling 
reason
to keep the read_iso_sector() function since all it is doing is checking the
RC of virtio_read(), which we will want to check anyway to determine if 
we need
to abort the IPL here.
>
> Apart from that, patch looks fine for me, thanks for doing this 
> clean-up work!
>
>  Thomas
>


