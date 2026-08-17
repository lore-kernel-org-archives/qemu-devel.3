Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A6CC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzdO-00052I-Rl; Mon, 17 Aug 2026 11:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wvzdM-00051O-M8; Mon, 17 Aug 2026 11:52:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wvzdK-0004U2-Mi; Mon, 17 Aug 2026 11:52:20 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HFg70f699075; Mon, 17 Aug 2026 15:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dGHlh5
 S3g+T6UVjZNkz7FDHmcTVtPtvoxS3xBE1djYE=; b=kK8y0Tg6aPhZ4O2JmopZAB
 z8SkPEH7KyrAYOLJrNee5CHR5o4ruoh2vZZihogJYjngCHt4mFYJ9KhFktvkyb/w
 Ta3n3FYf8a05+YAY7v0SkWOjUJGsHD87m9gUBLRmkez8O8e1QrR+SIg+1LnYPvmu
 Ek9PEcv9ZLtNm5LRgCrFmy0fdh4lajv5JDEenWxAwvpzCY7dNq9G5rKhe+rhGBZ1
 JRcsn0wMCMJEUIb3d1xAcEr6P8A/zs2Hw4at6+vudYD+g2r9U5iT+tS5mqTbB/MI
 GEqJqVIN+fYKOc5+5EgLOZCQKWa9qbVets+FxD6T/z1nOzjs73f5qY033PQEaorg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe2umx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:52:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFgXpo008006;
 Mon, 17 Aug 2026 15:52:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xgxkts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:52:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HFqDsv24904234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:52:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA44F5805D;
 Mon, 17 Aug 2026 15:52:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC83758054;
 Mon, 17 Aug 2026 15:52:12 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 17 Aug 2026 15:52:12 +0000 (GMT)
Message-ID: <373355f4-03a1-48c9-8a3b-9bb4addad21a@linux.ibm.com>
Date: Mon, 17 Aug 2026 11:52:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu] pc-bios/s390-ccw: Fix off-by-one errors with
 loadparm and boot entries
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com, jjherne@linux.ibm.com,
 borntraeger@linux.ibm.com, jdaley@linux.ibm.com, qemu-stable@nongnu.org
References: <20260728223013.4047042-1-jrossi@linux.ibm.com>
 <6d153b74-265a-462b-934d-cd46b2dd2088@tls.msk.ru>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <6d153b74-265a-462b-934d-cd46b2dd2088@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX9HffHkhMj7j4
 ysSpCmIhhj9grGKE4cCHkYHxDHiAQpQiEy6KaxZT3lsoULZgE0rwqGR0gIpPpITYF8qtw0ZWvSj
 cVd1UzqlHXH1YQVThXwNsMHxs1nwR3kgEXnLIpjp7dJdVwQ6SbubwOV3JQM8SrgiUK44qa2Bm4H
 ypqLEZaJGbSA5fIMWWULxS1lurvYIiys5IdRr4/mgJT8x4c0D6z/fzmHiclFjuBhYN4GnuVtSs7
 c1inmri7laqctSf/ovLYaEgtePBel+eHHt+XHvIHgFrcmE+fKPxuFzXs3zFq4Wpb6WD0Fffz0qT
 7T/YFZQyP9Kl/NCWuuaWgGGWptrctH8J87sUlojpNdiotlNM7rktWggpc7wnvQnaPud5RpPpMGq
 +mXVc3gNPykarJOtJqY8scZDDCwsl028j4kNCHnZfrNn2WwaVjH/rXsvSPgpIlHOf8kO0UkGO5B
 I4V+XenPdLV1S3vFElQ==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a832e2f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=12Gsu9bVKmHTHp1dEUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: Nxgxo6KL2bkOcvKJRBiIdP_v_ADpCLrD
X-Proofpoint-GUID: Nxgxo6KL2bkOcvKJRBiIdP_v_ADpCLrD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX8M0ZHPk4vY45
 pIty/eWZVtFewbuhMjO35w7DWVCe+NEWFMsPQVy0AU0Fq738+1dlVkQ6uz7yJ3j2gpeU7m/s1oz
 3VVwidrSzNSjytzlsA5BunGy/z8CiYw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/17/26 5:58 AM, Michael Tokarev wrote:
> On 7/29/26 01:30, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> The loadparm may optionally be used to select a boot entry, with the
>> intended range being 0 through 31 inclusive, for a total of 32 entries.
>> Previously, MAX_BOOT_ENTRIES was defined as 31, indicating that it was
>> intended to correspond to the index of the boot entry rather than the
>> count; however, some guards also used MAX_BOOT_ENTRIES as a count of the
>> maximum allowed entries, which resulted in a mismatch between the 
>> intended
>> and actual range such that index 31 could never be used in practice.
>>
>> Move the definition of MAX_BOOT_ENTRIES to qipl.h so it is shared and
>> change the value to 32, representing a count of the maximum number of
>> allowed boot entries and allowing the loadparm to accept values 0 
>> through
>> 31 as intended.  Update some instances in the netboot code where
>> MAX_BOOT_ENTRIES was used as the max index so that all guards treat
>> MAX_BOOT_ENTRIES as a count across all boot methods.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 806315279d5c ("pc-bios/s390-ccw: Remove panics from ECKD IPL 
>> path")
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>
> While this commit suggests that the original issue were introduced in
> 806315279d5c (which is qemu v9.2.0), it looks like actual bug has
> become possible only after a different commit, a4adf071dc7
> ("pc-bios/s390-ccw: Allow to select a different pxelinux.cfg entry via 
> loadparm"),
> which is only qemu v11.0.0.
>
> So I'm not picking this change to 10.0.x stable series (at least not 
> until
> a4adf071dc7 is there too, which I don't think is necessary).
>
> Please let me know if I should, instead, pick both of the commits to
> 10.0.x, or should rework this change to work on 10.0.x instead (which -
> it seems - is not necessary).
>
> Thanks,
>
> /mjt

Hi Michael,

I see what you mean.  I think an argument can be made for any case, but
I’m not sure what is most desirable for QEMU stable.  I’ll try to clarify
the problem.

The off-by-one error itself was introduced by

806315279d5c ("pc-bios/s390-ccw: Remove panics from ECKD IPL path")

which changed the loop conditions to treat MAX_BOOT_ENTRIES as a count
instead of an index, but didn’t update the value to match.  The result is
simply that the maximum loadparm value accepted by QEMU is silently reduced
from 31 to 30, which is a mismatch between the stated max in documentation
versus the real implementation, but otherwise doesn't cause any problems in
practice because the logic is consistent.

The commit you reference

a4adf071dc7 ("pc-bios/s390-ccw: Allow to select a different pxelinux.cfg 
entry via loadparm")

introduces an actual trigger for the off-by-one error by creating an array
access that uses MAX_BOOT_ENTRIES as an index, which would be out of
bounds.  There is now a logic mismatch where MAX_BOOT_ENTRIES is used as
the number of elements in the array, but then it is also used as the index
of the last element in the array.

So, as I see it, there are three possible approaches:

1) Do nothing for now, which means the maximum loadparm value is
effectively 30 instead of 31 until both a4adf071dc7 and the proposed fix
are applied together later, but it is otherwise fine

2) Apply both a4adf071dc7 and the fix to 10.0.x stable, which is the
correct long-term solution but requires extra changes to add the
prerequisite PXE menu feature now

3) Apply a modified fix to 10.0.x stable, which resolves the off-by-one
error at the current level, but is incompatible if/when a4adf071dc7 is
applied later

Option 3 would simply mean changing MAX_BOOT_ENTRIES to 32 for the moment,
with the other changes from the proposed fix to be applied together with
a4adf071dc7 later.

Let me know if anything is unclear, or if you would like any further action
from my side.

Thanks,
Jared Rossi

>
>>   include/hw/s390x/ipl/qipl.h |  2 ++
>>   pc-bios/s390-ccw/netmain.c  | 11 +++++++----
>>   pc-bios/s390-ccw/s390-ccw.h |  2 --
>>   3 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index 8d3c83a80b..b390f2f112 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -20,6 +20,8 @@
>>   #define LOADPARM_LEN    8
>>   #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>>   +#define MAX_BOOT_ENTRIES  32
>> +
>>   enum S390IplType {
>>       S390_IPL_TYPE_FCP = 0x00,
>>       S390_IPL_TYPE_CCW = 0x02,
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index 651cedf6ef..791854fce0 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -40,6 +40,9 @@
>>   #define DEFAULT_BOOT_RETRIES 10
>>   #define DEFAULT_TFTP_RETRIES 20
>>   +/* Index 0 is reserved for default alias, start PXE cfg indices at 
>> 1 */
>> +#define PXECFG_MAX              (MAX_BOOT_ENTRIES - 1)
>> +
>>   extern char _start[];
>>     #define KERNEL_ADDR             ((void *)0L)
>> @@ -381,13 +384,13 @@ static int 
>> net_select_and_load_kernel(filename_ip_t *fn_ip,
>>     static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
>>   {
>> -    struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
>> +    struct pl_cfg_entry entries[PXECFG_MAX];
>>       int num_ent, def_ent = 0;
>>         num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
>>                                         DEFAULT_TFTP_RETRIES,
>>                                         cfgbuf, sizeof(cfgbuf),
>> -                                      entries, MAX_BOOT_ENTRIES, 
>> &def_ent);
>> +                                      entries, PXECFG_MAX, &def_ent);
>>         return net_select_and_load_kernel(fn_ip, num_ent, def_ent, 
>> entries);
>>   }
>> @@ -470,11 +473,11 @@ static int 
>> net_try_direct_tftp_load(filename_ip_t *fn_ip)
>>            * a magic comment string.
>>            */
>>           if (!strncasecmp("# pxelinux", cfgbuf, 10)) {
>> -            struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
>> +            struct pl_cfg_entry entries[PXECFG_MAX];
>>               int num_ent, def_ent = 0;
>>                 num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), 
>> entries,
>> -                                         MAX_BOOT_ENTRIES, &def_ent);
>> +                                         PXECFG_MAX, &def_ent);
>>               return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
>>                                                 entries);
>>           }
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 1e1f71775e..d0498e2944 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -82,8 +82,6 @@ int menu_get_enum_boot_index(bool *valid_entries);
>>   bool menu_is_enabled_enum(void);
>>   int menu_get_boot_index(bool *valid_entries);
>>   -#define MAX_BOOT_ENTRIES  31
>> -
>>   __attribute__ ((__noreturn__))
>>   static inline void panic(const char *string)
>>   {
>


