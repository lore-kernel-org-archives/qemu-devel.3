Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA8AC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBGA-00027a-OA; Thu, 22 May 2025 15:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIBFB-00013R-WC; Thu, 22 May 2025 15:06:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIBFA-0006Xk-A2; Thu, 22 May 2025 15:06:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MF02oP026860;
 Thu, 22 May 2025 19:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=osJTwj
 gBsYSOVAlBgXN03B58/9Q0yjewkiwg17B2KT4=; b=dLZDx4cFOjBRPgE2cE/66H
 ZYBCct3oUf7Iefp81D0wTs6Fj6eXVWv9w2qBgRVLZxvlKWA+WpIbEDYPHG+BMfhT
 579A4gU2kAorsnezxCIRMpOhCwO1PGzRovtueSzN9UOYBcDPWfELAiDntVXKe1Qq
 JjPUyihtyROZ155FpPiwbjiFwzvsap9wgfyrCYHDxT2KkRjVqIN5H+76bPbXJtQ7
 ThxKwZKj5GxFSSuFy1t6MTfRgHw64PLo5mOFjr0TYUU+jWWzibDrgRdRSBysYfeE
 YBpHc8+pysKxPdXNzW2QiicxjVVuFAJlBDyukR7oF/DTJ/pTUchMoSQwd9e+MRiw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t669h69f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 19:06:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54MHMGgo024617;
 Thu, 22 May 2025 19:06:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkravm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 19:06:00 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MJ5wYE21430788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 19:05:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF19D58054;
 Thu, 22 May 2025 19:05:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7276958045;
 Thu, 22 May 2025 19:05:57 +0000 (GMT)
Received: from [9.61.89.69] (unknown [9.61.89.69])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 May 2025 19:05:57 +0000 (GMT)
Message-ID: <dabf0d9e-5dd5-493b-82e3-920d0ca96195@linux.ibm.com>
Date: Thu, 22 May 2025 15:05:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-4-rreyes@linux.ibm.com>
 <7d1699d4-6d7d-4de3-a0bc-6dd345d9c2dd@redhat.com>
 <147f3278-bd20-4339-9dff-bf6a43ea0a48@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <147f3278-bd20-4339-9dff-bf6a43ea0a48@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RrPFLDmK c=1 sm=1 tr=0 ts=682f75a6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=daVjc4-f4LzRCDcAgo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: evQgZlfeBdfqumpMo_PP2UkCrYBy64cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE5MyBTYWx0ZWRfX6DqRDDFapZNk
 WrbCB6N3NGfKih35tnheCUbDOp3Ab8aLz0GrRydJKn/OM6ikAu28XXlAQOeuNkBLL2toQZeYspz
 8fYat4vFGQ6lHHSeBQxIQ8BI2b6I+8y5LxMg+exdG8wwGd9VdMz1pyi75aaPGbdpWHF96w2ZtO9
 WFY0COanoKxyHrRD01ov8oDsDOBDFSsfQW4AfCr45mecuFQKPVUkW5GtNJKJWopNV5OqaE2ussX
 tSo3h0/b3C9NqGgVKdEjjIeGgKzSMfrV6q98p4jQcbN+/HrbGMVW/3YVC2YvgWKEtYuYf+IC0Ko
 4Jh+/hGD7WQk8/2fuF+TwQd4ny8I9T1wHZDX5xODGY2aZEWHPBZ3EfA+eZRd1nfTb4WEdgmpYFQ
 UyyRVDd1hqcBLHFHO3X0wXHCNdlyAaCrdvAE3z8yoBpXw9EXbracqaeyA58/SDDcFLh1lYVo
X-Proofpoint-GUID: evQgZlfeBdfqumpMo_PP2UkCrYBy64cd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_09,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220193
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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




On 5/22/25 1:17 PM, Rorie Reyes wrote:
>
> On 5/22/25 9:30 AM, Cédric Le Goater wrote:
>> On 5/12/25 20:02, Rorie Reyes wrote:
>>> These functions can be invoked by the function that handles 
>>> interception
>>> of the CHSC SEI instruction for requests indicating the 
>>> accessibility of
>>> one or more adjunct processors has changed.
>>>
>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>> ---
>>>   hw/vfio/ap.c                 | 39 
>>> ++++++++++++++++++++++++++++++++++++
>>>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>>>   2 files changed, 61 insertions(+)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 5ea5dd9cca..4f88f80c54 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -96,6 +96,45 @@ static void vfio_ap_cfg_chg_notifier_handler(void 
>>> *opaque)
>>>     }
>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>> +{
>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>> +    APConfigChgEvent *cfg_chg_event;
>>> +
>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>> +        return 1;
>>> +    }
>>> +
>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>> +
>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>
>> btw, I don't know if this was discussed. Are we OK to manipulate the
>> 'cfg_chg_events' construct withou locking ?
>>
> I don't think it was discussed. Since I made it static, should we 
> think about locking the construct? If so, would using 'static 
> QemuMutex cfg_chg_events_lock;' to declare it and use 
> 'qemu_mutex_lock()' and 'qemu_mutex_unlock()' to lock and unlock when 
> needed? Tony, do you have any thoughts on this process?

See my response to Cedric. If you decide to go with locking, I don't 
have a problem with using QemuMutex.

>
>>> diff --git a/include/hw/s390x/ap-bridge.h 
>>> b/include/hw/s390x/ap-bridge.h
>>> index 470e439a98..f4d838bf99 100644
>>> --- a/include/hw/s390x/ap-bridge.h
>>> +++ b/include/hw/s390x/ap-bridge.h
>>> @@ -16,4 +16,26 @@
>>>     void s390_init_ap(void);
>>>   +typedef struct ChscSeiNt0Res {
>>> +    uint16_t length;
>>> +    uint16_t code;
>>> +    uint8_t reserved1;
>>> +    uint16_t reserved2;
>>> +    uint8_t nt;
>>> +#define PENDING_EVENT_INFO_BITMASK 0x80;
>>> +    uint8_t flags;
>>> +    uint8_t reserved3;
>>> +    uint8_t rs;
>>> +    uint8_t cc;
>>> +} QEMU_PACKED ChscSeiNt0Res;
>>> +
>>> +#define NT0_RES_RESPONSE_CODE 1;
>>> +#define NT0_RES_NT_DEFAULT    0;
>>> +#define NT0_RES_RS_AP_CHANGE  5;
>>> +#define NT0_RES_CC_AP_CHANGE  3;
>>
>>
>>
>> please drop the ending ';'
>>
>>
>> Thanks,
>>
>> C.
>>
> Will drop in the next version


