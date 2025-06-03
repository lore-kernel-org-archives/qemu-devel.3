Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82B3C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 18:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMVxN-0002kp-Iv; Tue, 03 Jun 2025 14:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uMVxL-0002k3-0N; Tue, 03 Jun 2025 14:01:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uMVxH-0000sX-T6; Tue, 03 Jun 2025 14:01:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553GIKJ7027006;
 Tue, 3 Jun 2025 18:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZNZXV6
 F0JtCDeXEaatLp+E/rOKPFvEmS4SkO74JP6Qo=; b=CVivrdinUKbJhsJty+lQ2T
 mQYTfHQC4tWWaTuJQQBf7qGU4r6/h0nIuvhvgrhTvTtetO2fIOeeVpUDhuvc8eqS
 do+mK7vNTnJ35WSrSXSW1UnKruvLwJry0mt/Y0Rh1bfyme8HrQusK1+fIdL4t9lk
 wLv7mWiaaCBExxKz91IvyoA7eDC3iecWoqh+24IrcoemEbM6wqtPuSP291S3tX24
 0pmPsQhphWrow16fpNuEXE4BquSFxtnFasKBHKxGLaLJpHizZsMdHsVLyhHWMFEk
 D7QFBh/5lBjbpEFEszfnxwZlHucmhb+FpdM5MBb5GEGjPcMrC/n4JhNTGybuPuYw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gw1x0hb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 18:01:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553Hk1OB024754;
 Tue, 3 Jun 2025 18:01:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmbxt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 18:01:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 553I1cmh29491948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Jun 2025 18:01:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A21A5805D;
 Tue,  3 Jun 2025 18:01:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28C4D58059;
 Tue,  3 Jun 2025 18:01:37 +0000 (GMT)
Received: from [9.61.255.197] (unknown [9.61.255.197])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Jun 2025 18:01:37 +0000 (GMT)
Message-ID: <adca5063-786e-4c4e-90f8-dd378a2aa71c@linux.ibm.com>
Date: Tue, 3 Jun 2025 14:01:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v11 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250523160338.41896-1-rreyes@linux.ibm.com>
 <20250523160338.41896-4-rreyes@linux.ibm.com>
 <66ad7451-b7a6-4112-8f20-1af06d5b482a@redhat.com>
 <834be7a8-922a-4e39-8453-6c9a1957d3ac@linux.ibm.com>
 <1a896c28-783b-4a1e-9cf5-6b8abfe8d7e4@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <1a896c28-783b-4a1e-9cf5-6b8abfe8d7e4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE1MyBTYWx0ZWRfX7fn8MKYupKG0
 CNCECt3FaHRa0ET5yzPem7WNg4c0JcGraacfC2Ppa2coDhERgbSKBwJ60doTZXdRRy2ltuOv7ue
 mIvfhNqaDIIjyIfC98xzLHerbPmksxwiou4jqOnUeLM4n6Ds/aCAPUwaTcMoQBFe/FPQmdneBEN
 qBg6pnDaiLUoyYsvFPyY/k+doJZPFylhGfC6umwLven7fCVvWNpcLOA360bOpjBRyL/+KkqdCrg
 bRO0nRYI0OQNz2pkCJF8KAnPRCiFV8SU2EXMj1bSKwRx/JtIuGbj41OG0Q0YTKsGLzwJpWhV5Y9
 oe1lD4S5nFZ+vbkkvpGHECeK1+UGfmEN1Pfy0VEMMku0zdgv78uuEGAKoHoY6KtUgxFbtskycIY
 oTZU6XOwWwWPEvvxZLTD427I4C2cEZQCkPtM2fgm7ThQobCOOO9PRtoLCWuMgBalI1VmyLuh
X-Proofpoint-ORIG-GUID: r0bU125Y8tcH5dUThUrTnEEWllf3S2KN
X-Authority-Analysis: v=2.4 cv=HcIUTjE8 c=1 sm=1 tr=0 ts=683f3884 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bJ3aoUm06WCa-iZPxaUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r0bU125Y8tcH5dUThUrTnEEWllf3S2KN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 6/3/25 10:21 AM, Cédric Le Goater wrote:
> On 6/3/25 14:58, Rorie Reyes wrote:
>> Hey Cedric,
>>
>> You mentioned the following in my v9 patches
>>
>> "In that case, let's keep it simple (no mutex) and add a 
>> assert(bql_locked())
>> statement where we think the bql should be protecting access to shared
>> resources. "
>>
>> Does this still apply down bellow?
>
> Anthony replied :
>
> https://lore.kernel.org/qemu-devel/ed2a2aa3-68a7-480c-a6a4-a8219af12d7b@linux.ibm.com/
>
> Thanks,
>
> C.
>
So we'll still use WITH_QEMU_LOCK_GUARD?
>>
>> On 5/26/25 4:40 AM, Cédric Le Goater wrote:
>>> On 5/23/25 18:03, Rorie Reyes wrote:
>>>> These functions can be invoked by the function that handles 
>>>> interception
>>>> of the CHSC SEI instruction for requests indicating the 
>>>> accessibility of
>>>> one or more adjunct processors has changed.
>>>>
>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>> ---
>>>>   hw/vfio/ap.c                 | 53 
>>>> ++++++++++++++++++++++++++++++++++++
>>>>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
>>>>   2 files changed, 92 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>> index fc435f5c5b..97a42a575a 100644
>>>> --- a/hw/vfio/ap.c
>>>> +++ b/hw/vfio/ap.c
>>>> @@ -10,6 +10,7 @@
>>>>    * directory.
>>>>    */
>>>>   +#include <stdbool.h>
>>>>   #include "qemu/osdep.h"
>>>>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>>>   #include <linux/vfio.h>
>>>> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>>>>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>>>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>>>   +static QemuMutex cfg_chg_events_lock;
>>>> +
>>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>>> @@ -96,6 +99,49 @@ static void 
>>>> vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>>     }
>>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>>> +{
>>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>>> +    APConfigChgEvent *cfg_chg_event;
>>>> +
>>>> +    qemu_mutex_lock(&cfg_chg_events_lock);
>>>
>>> please consider using WITH_QEMU_LOCK_GUARD()
>>>
>> See note above about bql_locked
>>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>>> +        qemu_mutex_unlock(&cfg_chg_events_lock);
>>>> +        return EVENT_INFORMATION_NOT_STORED;
>>>> +    }
>>>> +
>>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>>> +
>>>> +    qemu_mutex_unlock(&cfg_chg_events_lock);
>>>> +
>>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>>> +    g_free(cfg_chg_event);
>>>> +
>>>> +    /*
>>>> +     * If there are any AP configuration change events in the queue,
>>>> +     * indicate to the caller that there is pending event info in
>>>> +     * the response block
>>>> +     */
>>>> +    if (ap_chsc_sei_nt0_have_event()) {
>>>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>>>> +    }
>>>> +
>>>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>>>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>>>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>>>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>>>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>>>> +
>>>> +    return EVENT_INFORMATION_STORED;
>>>> +}
>>>> +
>>>> +bool ap_chsc_sei_nt0_have_event(void)
>>>
>>> hmm, no locking ?
>>>
>> See not above for bql_locked
>>>> +{
>>>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>>>> +}
>>>> +
>>>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>>>                                             unsigned int irq, Error 
>>>> **errp)
>>>>   {
>>>> @@ -192,6 +238,13 @@ static void vfio_ap_realize(DeviceState *dev, 
>>>> Error **errp)
>>>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>>>>       VFIODevice *vbasedev = &vapdev->vdev;
>>>>   +    static bool lock_initialized;
>>>> +
>>>> +    if (!lock_initialized) {
>>>> +        qemu_mutex_init(&cfg_chg_events_lock);
>>>> +        lock_initialized = true;
>>>> +    }
>>>
>>> this could be replaced with a constructor routine. See hyperv.
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>> Noted
>>>
>>>
>>>>       if (!vfio_device_get_name(vbasedev, errp)) {
>>>>           return;
>>>>       }
>>>> diff --git a/include/hw/s390x/ap-bridge.h 
>>>> b/include/hw/s390x/ap-bridge.h
>>>> index 470e439a98..7efc52928d 100644
>>>> --- a/include/hw/s390x/ap-bridge.h
>>>> +++ b/include/hw/s390x/ap-bridge.h
>>>> @@ -16,4 +16,43 @@
>>>>     void s390_init_ap(void);
>>>>   +typedef struct ChscSeiNt0Res {
>>>> +    uint16_t length;
>>>> +    uint16_t code;
>>>> +    uint8_t reserved1;
>>>> +    uint16_t reserved2;
>>>> +    uint8_t nt;
>>>> +#define PENDING_EVENT_INFO_BITMASK 0x80;
>>>> +    uint8_t flags;
>>>> +    uint8_t reserved3;
>>>> +    uint8_t rs;
>>>> +    uint8_t cc;
>>>> +} QEMU_PACKED ChscSeiNt0Res;
>>>> +
>>>> +#define NT0_RES_RESPONSE_CODE 1
>>>> +#define NT0_RES_NT_DEFAULT    0
>>>> +#define NT0_RES_RS_AP_CHANGE  5
>>>> +#define NT0_RES_CC_AP_CHANGE  3
>>>> +
>>>> +#define EVENT_INFORMATION_NOT_STORED 1
>>>> +#define EVENT_INFORMATION_STORED     0
>>>> +
>>>> +/**
>>>> + * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
>>>> + * change event
>>>> + * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
>>>> + * data
>>>> + *
>>>> + * This function checks for any pending AP config change events and,
>>>> + * if present, populates the provided response structure with the
>>>> + * appropriate SEI NT0 fields.
>>>> + *
>>>> + * Return:
>>>> + *   EVENT_INFORMATION_STORED - An event was available and written 
>>>> to @res
>>>> + *   EVENT_INFORMATION_NOT_STORED - No event was available
>>>> + */
>>>> +int ap_chsc_sei_nt0_get_event(void *res);
>>>> +
>>>> +bool ap_chsc_sei_nt0_have_event(void);
>>>> +>   #endif
>>>
>>
>

