Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF54DFF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5iX-0003Z3-28; Wed, 29 Apr 2026 10:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wI5iR-0003Ye-U4; Wed, 29 Apr 2026 10:16:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wI5iO-0007jl-SJ; Wed, 29 Apr 2026 10:16:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TAuKcM3102032; Wed, 29 Apr 2026 14:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bbjXqx
 fb2+OhEWBJTMXk7jb3s9Zpk9DmuwZueg2CXkI=; b=fbEYKPQEWxYLrHCdP56Q4c
 Ic8DN5CQCO4KsKx9EzsF27som7SFE8Q4D2tOnpH17aTXhXqis9Jz1m/15NNtk5Gp
 Z7Q0clqZkiRol+leCQD+KBf51SZIBCKy+G4+KUuCSoxZbON1CN5Z9rp6Z8kAK0bc
 uPckf04lAcI3ML4U0QxVBPh9ic501YmB4rp5HO8sQ7Hqu2GpapA/n+QLCcqbSwX2
 BXAv5Usywb3WozsfkYyrqAtISUbiuH+yAInFN3X+gLyOCQDoIoFwcfBg/0OmwoXm
 5ZUiXxAC2KxY0xLKnle5RHhIcLl3xgZvW7CunMT+phxqqMbhWJiz4uvCWpLabhKg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44u0ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 14:16:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TE8pKc031662;
 Wed, 29 Apr 2026 14:16:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avxpnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 14:16:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TEGSff27263670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 14:16:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AA3858056;
 Wed, 29 Apr 2026 14:16:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA8DB58052;
 Wed, 29 Apr 2026 14:16:26 +0000 (GMT)
Received: from [9.61.119.68] (unknown [9.61.119.68])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 29 Apr 2026 14:16:26 +0000 (GMT)
Message-ID: <af003f75-120d-4b0c-a5f6-68d091b014b1@linux.ibm.com>
Date: Wed, 29 Apr 2026 10:16:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-21-zycai@linux.ibm.com>
 <d2aff9be-2597-4d58-9185-0c805114669a@linux.ibm.com>
 <efe0260f-a428-4a45-b62b-f9060a108e45@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <efe0260f-a428-4a45-b62b-f9060a108e45@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ooh2Ps786fZL_298Iw4C74E9UNyHRIYF
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f212be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=cC6wzO2QcW86-TqmWJQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ooh2Ps786fZL_298Iw4C74E9UNyHRIYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MCBTYWx0ZWRfXx1e2j2YsYZX3
 N1gs/mICudjLEg9FnL3IKlodPBi8pOrZ7XS7Z3bBczCpobto88k9W685yCdDAN1ATiiLzv91qlD
 e3+/5IZplm/ZsJcozzs1OpiOZSORKYSZ+IH1+DN21cWXOV0U8ObcqAbZq+BNt9KecqoPzM11UtG
 /y3Afdy9v+Htsq/E5s0/gG9BFwgJEVIxa6skMTr3QgDlbR4EJrydOdidU7/s016msM6S7cgwPaP
 jc3r9STXsPL1Rl3ANxubqd0EBJVDwcs5KKbhdIXboHDj5UEP5uYBRVJ6UELT8fRZEvbymAtrt36
 029kV3MWYEwvw7CcKETllskvVJRuS+EhntBRXC5sUpqu193Mg50iyzHyWq7Dkt/esiM9ebspRdx
 fgIVV+htxOQOmswVzxYF3c1+uASkN25XRlx81cwnBWqIF+Z+WygbNJP4UuDlB8EmGNvDmgOnNkT
 n8dYHK/JyzJPg2vbZFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 4/28/26 2:42 PM, Zhuoying Cai wrote:
> On 4/15/26 12:36 PM, Jared Rossi wrote:
>>
>> On 4/2/26 6:14 PM, Zhuoying Cai wrote:
>>> Add address range tracking and overlap checks to ensure that no
>>> component overlaps with a signed component during secure IPL.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>    pc-bios/s390-ccw/secure-ipl.c | 58 ++++++++++++++++++++++++++++++++---
>>>    pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++
>>>    2 files changed, 69 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>>> index b66ca9ca7e..d2079e19bc 100644
>>> --- a/pc-bios/s390-ccw/secure-ipl.c
>>> +++ b/pc-bios/s390-ccw/secure-ipl.c
> [...]
>
>>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>>> index 6d65cd5596..c625ac2e3a 100644
>>> --- a/pc-bios/s390-ccw/secure-ipl.h
>>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>>> @@ -24,6 +24,21 @@ typedef struct SecureIplCompEntryInfo {
>>>        uint8_t  flags;
>>>    } SecureIplCompEntryInfo;
>>>    
>>> +typedef struct SecureIplCompAddrRange {
>>> +    bool is_signed;
>>> +    uint64_t start_addr;
>>> +    uint64_t end_addr;
>>> +} SecureIplCompAddrRange;
>>> +
>>> +/*
>>> + * Custom struct for managing a list of secure IPL component address ranges.
>>> + * Tracks up to MAX_CERTIFICATES address ranges with an index counter.
>>> + */
>>> +typedef struct SecureIplCompAddrRangeList {
>>> +    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
>>> +    int index;
>>> +} SecureIplCompAddrRangeList;
>> I don't think 'index' is the correct name for the variable. Something
>> like 'num' would be better, since it is the total number of address
>> ranges, right?
>>
> “index” refers to the index used to access comp_addr_range, but I agree
> that num could be a better name since it represents the total number of
> address ranges. I’m happy to rename it if preferred.
Yes, please do.  I think calling it 'num' is more representative of how 
it is
actually being used, e.g. the loop in is_comp_overlap() doesn't loop up 
until
a specific index in the array, it iterates through all elements.

While I'm thinking of it, can you also please change is_comp_overlap() to
check_comp_overlap()?  Prefixing it with 'is_' sounds a bit weird to me.

Thanks,
Jared Rossi

>
>>> +
>>>    static inline void zipl_secure_handle(const char *message)
>>>    {
>>>        switch (boot_mode) {
>> Regards,
>> Jared Rossi


