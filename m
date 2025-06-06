Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5F2C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 11:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNVZJ-0001sU-4B; Fri, 06 Jun 2025 07:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uNVZD-0001rU-V7; Fri, 06 Jun 2025 07:49:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uNVZA-0007zZ-Bj; Fri, 06 Jun 2025 07:48:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5563h4Vw019429;
 Fri, 6 Jun 2025 11:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GhJgtV
 EdB3b50S0HLz4l8jOFo70bx/9J/VFaC3lSEHg=; b=YmsnZcUGXYpmuOhkkWvEOf
 C8HFiQvOl32/n1O14oDDXloBA5GprLPS8rMla/NjzQoLMOCT6Xm8i38qPn+v7yYE
 04Hs+jGTVeUsvMh8LDz1Y8JUPgWJODaogmY3YI399bUCG9FObynck/yoI9hjtnFD
 UveamqTEG8OFFEHH6SZWwD4vAYxKM8ayFShe0DlkdXn1TjZWdjCuMmLK4UIrjlMN
 /PlZsOYTuX8W+rKrD8tt8Bpmc9ENFzLLzYWxA92K/glpQEgSHCd2+IP4rEO1fWm1
 9Y/9hoXmvx/EYoh0JBFl7AXmmO5WOyArYNwC6hyaY79wWLRx9geOCM5rWlyQfcJQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf068fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 11:48:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556BfpxB022527;
 Fri, 6 Jun 2025 11:48:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tsfn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 11:48:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556BmGA630868096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 11:48:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85C375803F;
 Fri,  6 Jun 2025 11:48:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57D9758055;
 Fri,  6 Jun 2025 11:48:15 +0000 (GMT)
Received: from [9.61.64.137] (unknown [9.61.64.137])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 11:48:15 +0000 (GMT)
Message-ID: <17677999-305c-4488-92fe-49af3b08cae3@linux.ibm.com>
Date: Fri, 6 Jun 2025 07:48:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v11 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
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
 <5888d51f-a85e-454c-971e-7d1f6f18dbe3@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <5888d51f-a85e-454c-971e-7d1f6f18dbe3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XxBqw3a7ipSgxbAMS_Od1Tm9fBDosc1t
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=6842d583 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Urs5WllyQESC8Q30aFYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XxBqw3a7ipSgxbAMS_Od1Tm9fBDosc1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEwNCBTYWx0ZWRfXyyX6TWL7JOsa
 FaUDQWrmOLXKh6fgtwN6lv6MJwITo3xyz4Rs05lNQXNVJ5F51yQwzPQ9zkLFawSit+6o1dsPpMb
 +gFFCPfLSQY787m7CUqhF7XsmCfNlS2w12TYgjpT9dDP3xn4HZFHlCG723tjbwdFr/wp2FqDPU1
 ivzdbbQC9l2HK1X6oTWQykShQk7hGHSM671jn7J+iZw7AF1ds7VykAZcxXycVpjlvhKbwdjNrDC
 43Wl5OAHye+jY++fsohn0eUme9XOpbDsVH+7YI9mzax9GQPKbRCz5Fwp2mndh+sFPFXEhrILSar
 7poFnAO0GGqm9wTSLLrMIWHHuQppWvhXPCX4LrcwSXbkZNTcqhcin0XGQTAFAYrWLvM/QeZCeKK
 OyeH36zKWRnkl173GkNLifSAoLv7I0PkpZOmjGeAjax64oTJcoVCv8S/7d/nr68ujcAS89zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060104
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 6/5/25 1:57 PM, Rorie Reyes wrote:
>
> On 6/4/25 9:47 AM, Anthony Krowiak wrote:
>>
>>
>>
>> On 6/3/25 4:30 PM, Cédric Le Goater wrote:
>>> On 6/3/25 20:01, Rorie Reyes wrote:
>>>>
>>>> On 6/3/25 10:21 AM, Cédric Le Goater wrote:
>>>>> On 6/3/25 14:58, Rorie Reyes wrote:
>>>>>> Hey Cedric,
>>>>>>
>>>>>> You mentioned the following in my v9 patches
>>>>>>
>>>>>> "In that case, let's keep it simple (no mutex) and add a 
>>>>>> assert(bql_locked())
>>>>>> statement where we think the bql should be protecting access to 
>>>>>> shared
>>>>>> resources. "
>>>>>>
>>>>>> Does this still apply down bellow?
>>>>>
>>>>> Anthony replied :
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/ed2a2aa3-68a7-480c-a6a4-a8219af12d7b@linux.ibm.com/ 
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> C.
>>>>>
>>>> So we'll still use WITH_QEMU_LOCK_GUARD?
>>>
>>> If a lock is needed to protect the list, then 
>>> ap_chsc_sei_nt0_have_event()
>>> should lock/unlock too. WITH_QEMU_LOCK_GUARD() is just a pratical 
>>> way to
>>> do so.
>>
>> Since ap_chsc_sei_nt0_have_event() is a single line that returns
>> !QTAILQ_EMPTY(&cfg_chg_events), wouldn't it be better to just
>> use the QEMU_LOCK_GUARD macro which, if I'm not mistaken,
>> will unlock on the return statement?
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>>>>>
>>>>>> On 5/26/25 4:40 AM, Cédric Le Goater wrote:
>>>>>>> On 5/23/25 18:03, Rorie Reyes wrote:
>>>>>>>> These functions can be invoked by the function that handles 
>>>>>>>> interception
>>>>>>>> of the CHSC SEI instruction for requests indicating the 
>>>>>>>> accessibility of
>>>>>>>> one or more adjunct processors has changed.
>>>>>>>>
>>>>>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>   hw/vfio/ap.c                 | 53 
>>>>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>>>>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
>>>>>>>>   2 files changed, 92 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>>>>>> index fc435f5c5b..97a42a575a 100644
>>>>>>>> --- a/hw/vfio/ap.c
>>>>>>>> +++ b/hw/vfio/ap.c
>>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>>    * directory.
>>>>>>>>    */
>>>>>>>>   +#include <stdbool.h>
>>>>>>>>   #include "qemu/osdep.h"
>>>>>>>>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>>>>>>>   #include <linux/vfio.h>
>>>>>>>> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>>>>>>>>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>>>>>>>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>>>>>>>   +static QemuMutex cfg_chg_events_lock;
>>>>>>>> +
>>>>>>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>>>>>>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>>>>>>> @@ -96,6 +99,49 @@ static void 
>>>>>>>> vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>>>>>>     }
>>>>>>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>>>>>>> +{
>>>>>>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>>>>>>> +    APConfigChgEvent *cfg_chg_event;
>>>>>>>> +
>>>>>>>> +    qemu_mutex_lock(&cfg_chg_events_lock);
>>>>>>>
>>>>>>> please consider using WITH_QEMU_LOCK_GUARD()
>>>>>>>
>>>>>> See note above about bql_locked
>>>>>>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>>>>>>> + qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>>>> +        return EVENT_INFORMATION_NOT_STORED;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>>>>>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>>>>>>> +
>>>>>>>> +    qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>>>> +
>>>>>>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>>>>>>> +    g_free(cfg_chg_event);
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * If there are any AP configuration change events in the 
>>>>>>>> queue,
>>>>>>>> +     * indicate to the caller that there is pending event info in
>>>>>>>> +     * the response block
>>>>>>>> +     */
>>>>>>>> +    if (ap_chsc_sei_nt0_have_event()) {
>>>>>>>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>>>>>>>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>>>>>>>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>>>>>>>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>>>>>>>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>>>>>>>> +
>>>>>>>> +    return EVENT_INFORMATION_STORED;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +bool ap_chsc_sei_nt0_have_event(void)
>>>>>>>
>>>>>>> hmm, no locking ?
>>>>>>>
> How important do we need to lock this? When I lock this method my 
> guest freezes every time. But when I only lock the get event, my code 
> continues to work as designed

Try locking in both functions, but instead of calling the have event 
function from the get event function, use
!QTAILQ_EMPTY(&cfg_chg_events) in the get event function. If you are 
holding the lock when you call the have event function, you will be 
locking the same lock twice and it will hang when you lock the second 
time because the lock is already held.

>>>>>> See not above for bql_locked
>>>>>>>> +{
>>>>>>>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>>>>>>>                                             unsigned int irq, 
>>>>>>>> Error **errp)


