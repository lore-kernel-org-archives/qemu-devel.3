Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B8C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 17:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNErR-0003Ey-Ay; Thu, 05 Jun 2025 13:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNErO-0003EF-6u; Thu, 05 Jun 2025 13:58:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNErL-00047B-Bu; Thu, 05 Jun 2025 13:58:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555BvIww022805;
 Thu, 5 Jun 2025 17:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kthNty
 eSzxz5bVRAXkFgaWV6bHWpeP684adgEwGy1P0=; b=sqSGVt7AzfzaSiU45jkFsE
 puzQ5QW3WfA35NJQIJz+ZoBrCskQCg72Bp+1Kn7NpTvct9CzFLH41+2aw0OOtt2L
 P7voUq/zvzSUV1BJqCCl6XANUJXo8A3QLMSzftNacqp0sXQnfX49Z48aEvAV+xwe
 ITbvvb01FDYhK46whjZcHYrDVDI3QhWW3b2g3N3BIL0WAFBWNP9ZC9cRcjxPATYS
 GIjMJ+mxs5WWp1mxpetDWvOUuRONpj03JDEKd3YEkUT8nVGO/UlyRCGnGmHrpD7i
 XWez6bE/1s2jYzYnrRhm84BTOLh2+gAQ+aD+S1Rfo+hU+At1OmFHxrTsmA+7cg7A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf028wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 17:58:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 555GsIxC019883;
 Thu, 5 Jun 2025 17:57:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p5ur4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 17:57:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 555HvvlR17564346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 17:57:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E6215804B;
 Thu,  5 Jun 2025 17:57:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8917958059;
 Thu,  5 Jun 2025 17:57:56 +0000 (GMT)
Received: from [9.12.78.227] (unknown [9.12.78.227])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Jun 2025 17:57:56 +0000 (GMT)
Message-ID: <5888d51f-a85e-454c-971e-7d1f6f18dbe3@linux.ibm.com>
Date: Thu, 5 Jun 2025 13:57:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v11 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Anthony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250523160338.41896-1-rreyes@linux.ibm.com>
 <20250523160338.41896-4-rreyes@linux.ibm.com>
 <66ad7451-b7a6-4112-8f20-1af06d5b482a@redhat.com>
 <834be7a8-922a-4e39-8453-6c9a1957d3ac@linux.ibm.com>
 <1a896c28-783b-4a1e-9cf5-6b8abfe8d7e4@redhat.com>
 <adca5063-786e-4c4e-90f8-dd378a2aa71c@linux.ibm.com>
 <5248c4f1-923e-4f6b-9c3f-ac24666fea04@redhat.com>
 <02f064f7-e400-4d7b-ba04-cb5dc6ee93f0@linux.ibm.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <02f064f7-e400-4d7b-ba04-cb5dc6ee93f0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=6841daa8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cr2wzx3KPTEgbwcgCGcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE1NSBTYWx0ZWRfX4q+87J73/PhH
 sp2dGV+YrWziDV8N+w7wbViT7ElI6TZBMfOVqyzsKAS+dpdtmB4ZRcilw12EulOkqH6YZdXJL4O
 +kFoiKfV1EGU1gBTNr6aZOaN1/SvujbA/wTMXs1DJapVznL0b2z5W5Fdqi4JSXXoZbSrSnPSC8R
 1ODE5CpWITtYGawlBys25OoMJ/VCAY7aJw8JTnviDlWbAKKQYPr4ziPGS1iXrQJRm2dZe290Qjx
 ngOlU2C5U3u67l8v88RhaFL6QwgDpbqGWRZmM/eaBJXzKDUUTLi2Id5jd87IXzQztV1opgmthpI
 mg1UmCLAFzXnNcSipsSDJWQFB34/oo/lxeuAMTdlnjSbPIO0uICkAVlJkIXpDLKNsRA1DlwZKYc
 BDr/oVSO2AQc/hFD00uU7PlBtiCsIfsVT4osYHjJpB1iHnfOcJLnvkukzLcJ/XXU9DWr2/7h
X-Proofpoint-GUID: ZqBS0otn4uFGCq-Vw72nceB2X-1gAj6p
X-Proofpoint-ORIG-GUID: ZqBS0otn4uFGCq-Vw72nceB2X-1gAj6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 6/4/25 9:47 AM, Anthony Krowiak wrote:
>
>
>
> On 6/3/25 4:30 PM, Cédric Le Goater wrote:
>> On 6/3/25 20:01, Rorie Reyes wrote:
>>>
>>> On 6/3/25 10:21 AM, Cédric Le Goater wrote:
>>>> On 6/3/25 14:58, Rorie Reyes wrote:
>>>>> Hey Cedric,
>>>>>
>>>>> You mentioned the following in my v9 patches
>>>>>
>>>>> "In that case, let's keep it simple (no mutex) and add a 
>>>>> assert(bql_locked())
>>>>> statement where we think the bql should be protecting access to 
>>>>> shared
>>>>> resources. "
>>>>>
>>>>> Does this still apply down bellow?
>>>>
>>>> Anthony replied :
>>>>
>>>> https://lore.kernel.org/qemu-devel/ed2a2aa3-68a7-480c-a6a4-a8219af12d7b@linux.ibm.com/ 
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>> So we'll still use WITH_QEMU_LOCK_GUARD?
>>
>> If a lock is needed to protect the list, then 
>> ap_chsc_sei_nt0_have_event()
>> should lock/unlock too. WITH_QEMU_LOCK_GUARD() is just a pratical way to
>> do so.
>
> Since ap_chsc_sei_nt0_have_event() is a single line that returns
> !QTAILQ_EMPTY(&cfg_chg_events), wouldn't it be better to just
> use the QEMU_LOCK_GUARD macro which, if I'm not mistaken,
> will unlock on the return statement?
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>>>
>>>>> On 5/26/25 4:40 AM, Cédric Le Goater wrote:
>>>>>> On 5/23/25 18:03, Rorie Reyes wrote:
>>>>>>> These functions can be invoked by the function that handles 
>>>>>>> interception
>>>>>>> of the CHSC SEI instruction for requests indicating the 
>>>>>>> accessibility of
>>>>>>> one or more adjunct processors has changed.
>>>>>>>
>>>>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>>>>> ---
>>>>>>>   hw/vfio/ap.c                 | 53 
>>>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>>>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
>>>>>>>   2 files changed, 92 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>>>>> index fc435f5c5b..97a42a575a 100644
>>>>>>> --- a/hw/vfio/ap.c
>>>>>>> +++ b/hw/vfio/ap.c
>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>    * directory.
>>>>>>>    */
>>>>>>>   +#include <stdbool.h>
>>>>>>>   #include "qemu/osdep.h"
>>>>>>>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>>>>>>   #include <linux/vfio.h>
>>>>>>> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>>>>>>>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>>>>>>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>>>>>>   +static QemuMutex cfg_chg_events_lock;
>>>>>>> +
>>>>>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>>>>>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>>>>>> @@ -96,6 +99,49 @@ static void 
>>>>>>> vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>>>>>     }
>>>>>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>>>>>> +{
>>>>>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>>>>>> +    APConfigChgEvent *cfg_chg_event;
>>>>>>> +
>>>>>>> +    qemu_mutex_lock(&cfg_chg_events_lock);
>>>>>>
>>>>>> please consider using WITH_QEMU_LOCK_GUARD()
>>>>>>
>>>>> See note above about bql_locked
>>>>>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>>>>>> +        qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>>> +        return EVENT_INFORMATION_NOT_STORED;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>>>>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>>>>>> +
>>>>>>> +    qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>>> +
>>>>>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>>>>>> +    g_free(cfg_chg_event);
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * If there are any AP configuration change events in the 
>>>>>>> queue,
>>>>>>> +     * indicate to the caller that there is pending event info in
>>>>>>> +     * the response block
>>>>>>> +     */
>>>>>>> +    if (ap_chsc_sei_nt0_have_event()) {
>>>>>>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>>>>>>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>>>>>>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>>>>>>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>>>>>>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>>>>>>> +
>>>>>>> +    return EVENT_INFORMATION_STORED;
>>>>>>> +}
>>>>>>> +
>>>>>>> +bool ap_chsc_sei_nt0_have_event(void)
>>>>>>
>>>>>> hmm, no locking ?
>>>>>>
How important do we need to lock this? When I lock this method my guest 
freezes every time. But when I only lock the get event, my code 
continues to work as designed
>>>>> See not above for bql_locked
>>>>>>> +{
>>>>>>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>>>>>>> +}
>>>>>>> +
>>>>>>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>>>>>>                                             unsigned int irq, 
>>>>>>> Error **errp)

