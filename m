Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B4AC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWiY-00082B-J0; Fri, 06 Jun 2025 09:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNWhc-0007w1-Fa; Fri, 06 Jun 2025 09:01:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNWhY-0000E4-Fw; Fri, 06 Jun 2025 09:01:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5563hlUr012122;
 Fri, 6 Jun 2025 13:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=goA0Fh
 mckQH4adWKXQhHiffRixMBPdAJ1FHvCdtxHWg=; b=pnyL/ZitBXIMMR1LIAN1ji
 Jnd9jyG07zirqZkr2QmVL+Bfxdh9S3KaN3U+eMdofMG3Dj2SzPmpfztyGoCpcnDb
 sqjyDbQ3O4Bc3copI0YkFy2qYRjqAdo1oC1G1vYL0w7xFYMzcEcL23zftPBHwzw7
 YXk4YEoFO+8Pips6HeZtwnOTltmS4sppXzqVetfxuQ+AmOfKd1TeVxjFFZQfQLHb
 MRp07j1ozMIfH/dMZVJZPGyeDzw0TQmPrvM9HrGWS2j3v8oAhrw/eRKcU5WBj3xK
 sP+T2HPPpbX8LFd+YXx2ygajdA5uORR+8r3tgVtDl/f8iUGojCNy4ctYXq+vHrpQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf068sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 13:01:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556Awaqs022550;
 Fri, 6 Jun 2025 13:01:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tsqrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 13:01:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556D1aE98454870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 13:01:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43D375805F;
 Fri,  6 Jun 2025 13:01:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4427C58043;
 Fri,  6 Jun 2025 13:01:35 +0000 (GMT)
Received: from [9.61.255.166] (unknown [9.61.255.166])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 13:01:35 +0000 (GMT)
Message-ID: <ae5c3a57-0439-4807-a924-c174563a451d@linux.ibm.com>
Date: Fri, 6 Jun 2025 09:01:34 -0400
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
 <5888d51f-a85e-454c-971e-7d1f6f18dbe3@linux.ibm.com>
 <17677999-305c-4488-92fe-49af3b08cae3@linux.ibm.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <17677999-305c-4488-92fe-49af3b08cae3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IbqwXTjCKAWx_wURKe6Zl1g4ZrbmkrFd
X-Proofpoint-ORIG-GUID: IbqwXTjCKAWx_wURKe6Zl1g4ZrbmkrFd
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=6842e6b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=33CObVDmz2fUbzhVBlMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDExNCBTYWx0ZWRfX8NUfPNbUQ95p
 /fvDU2USvVn6Ybbai6ZvfVw611Y6WBtPTuKuy9VjFIWS1YtPqnjGeV1m3NnPXyBL1n4Hzv6PmYc
 sjvqbWeCAUwdLv1X4B3Q6KfOyWHKxs6QlCNI1D/jLmNRgTGneQDiNlouZUv6hM6oEEx6KepxIha
 7xSqUtH+Bl2NPLAUMuNFbXDCrHcOGoL+jxSefGMDi8qVEEDiZTpjwpUDu3n2huMoDpod1YZU8VQ
 w+HCuit8loSSQlGfaT22yxk/lSszKoS/thb58gMUieiKi2hckM9kr5rtAoEmRXV2mgS878oot+y
 GssgRh7tZwhejJjR1BvxhhDxjg8hcw/Pcysla+K8bSbgzquHD+F3/iNV4y00O+VXhlC3qj6UfKy
 c6ygbqrVCSjKlE2HErS+C+VhWDPwDKn0JnY40SIIR7CYujdpRT1igMX/59BlJqpsfrDbgAF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 6/6/25 7:48 AM, Anthony Krowiak wrote:
>
>
>
> On 6/5/25 1:57 PM, Rorie Reyes wrote:
>>
>> On 6/4/25 9:47 AM, Anthony Krowiak wrote:
>>>
>>>
>>>
>>> On 6/3/25 4:30 PM, Cédric Le Goater wrote:
>>>> On 6/3/25 20:01, Rorie Reyes wrote:
>>>>>
>>>>> On 6/3/25 10:21 AM, Cédric Le Goater wrote:
>>>>>> On 6/3/25 14:58, Rorie Reyes wrote:
>>>>>>> Hey Cedric,
>>>>>>>
>>>>>>> You mentioned the following in my v9 patches
>>>>>>>
>>>>>>> "In that case, let's keep it simple (no mutex) and add a 
>>>>>>> assert(bql_locked())
>>>>>>> statement where we think the bql should be protecting access to 
>>>>>>> shared
>>>>>>> resources. "
>>>>>>>
>>>>>>> Does this still apply down bellow?
>>>>>>
>>>>>> Anthony replied :
>>>>>>
>>>>>> https://lore.kernel.org/qemu-devel/ed2a2aa3-68a7-480c-a6a4-a8219af12d7b@linux.ibm.com/ 
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> C.
>>>>>>
>>>>> So we'll still use WITH_QEMU_LOCK_GUARD?
>>>>
>>>> If a lock is needed to protect the list, then 
>>>> ap_chsc_sei_nt0_have_event()
>>>> should lock/unlock too. WITH_QEMU_LOCK_GUARD() is just a pratical 
>>>> way to
>>>> do so.
>>>
>>> Since ap_chsc_sei_nt0_have_event() is a single line that returns
>>> !QTAILQ_EMPTY(&cfg_chg_events), wouldn't it be better to just
>>> use the QEMU_LOCK_GUARD macro which, if I'm not mistaken,
>>> will unlock on the return statement?
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>
>>>>>>>
>>>>>>> On 5/26/25 4:40 AM, Cédric Le Goater wrote:
>>>>>>>> On 5/23/25 18:03, Rorie Reyes wrote:
>>>>>>>>> These functions can be invoked by the function that handles 
>>>>>>>>> interception
>>>>>>>>> of the CHSC SEI instruction for requests indicating the 
>>>>>>>>> accessibility of
>>>>>>>>> one or more adjunct processors has changed.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>>>>>>> ---
>>>>>>>>>   hw/vfio/ap.c                 | 53 
>>>>>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>>>>>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
>>>>>>>>>   2 files changed, 92 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>>>>>>> index fc435f5c5b..97a42a575a 100644
>>>>>>>>> --- a/hw/vfio/ap.c
>>>>>>>>> +++ b/hw/vfio/ap.c
>>>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>>>    * directory.
>>>>>>>>>    */
>>>>>>>>>   +#include <stdbool.h>
>>>>>>>>>   #include "qemu/osdep.h"
>>>>>>>>>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>>>>>>>>   #include <linux/vfio.h>
>>>>>>>>> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>>>>>>>>>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>>>>>>>>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>>>>>>>>   +static QemuMutex cfg_chg_events_lock;
>>>>>>>>> +
>>>>>>>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>>>>>>>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>>>>>>>> @@ -96,6 +99,49 @@ static void 
>>>>>>>>> vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>>>>>>>     }
>>>>>>>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>>>>>>>> +{
>>>>>>>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>>>>>>>> +    APConfigChgEvent *cfg_chg_event;
>>>>>>>>> +
>>>>>>>>> +    qemu_mutex_lock(&cfg_chg_events_lock);
>>>>>>>>
>>>>>>>> please consider using WITH_QEMU_LOCK_GUARD()
>>>>>>>>
>>>>>>> See note above about bql_locked
>>>>>>>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>>>>>>>> + qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>>>>> +        return EVENT_INFORMATION_NOT_STORED;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>>>>>>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>>>>>>>> +
>>>>>>>>> +    qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>>>>> +
>>>>>>>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>>>>>>>> +    g_free(cfg_chg_event);
>>>>>>>>> +
>>>>>>>>> +    /*
>>>>>>>>> +     * If there are any AP configuration change events in the 
>>>>>>>>> queue,
>>>>>>>>> +     * indicate to the caller that there is pending event 
>>>>>>>>> info in
>>>>>>>>> +     * the response block
>>>>>>>>> +     */
>>>>>>>>> +    if (ap_chsc_sei_nt0_have_event()) {
>>>>>>>>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>>>>>>>>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>>>>>>>>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>>>>>>>>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>>>>>>>>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>>>>>>>>> +
>>>>>>>>> +    return EVENT_INFORMATION_STORED;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +bool ap_chsc_sei_nt0_have_event(void)
>>>>>>>>
>>>>>>>> hmm, no locking ?
>>>>>>>>
>> How important do we need to lock this? When I lock this method my 
>> guest freezes every time. But when I only lock the get event, my code 
>> continues to work as designed
>
> Try locking in both functions, but instead of calling the have event 
> function from the get event function, use
> !QTAILQ_EMPTY(&cfg_chg_events) in the get event function. If you are 
> holding the lock when you call the have event function, you will be 
> locking the same lock twice and it will hang when you lock the second 
> time because the lock is already held.
>
Let me give that a shot. Thanks Tony
>>>>>>> See not above for bql_locked
>>>>>>>>> +{
>>>>>>>>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>>>>>>>> unsigned int irq, Error **errp)
>

