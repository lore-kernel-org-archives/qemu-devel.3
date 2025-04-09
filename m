Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF2FC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 14:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2WBd-0007o9-SR; Wed, 09 Apr 2025 10:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2WBc-0007nh-Fk; Wed, 09 Apr 2025 10:13:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2WBa-0000nE-AQ; Wed, 09 Apr 2025 10:13:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539CT7Q0019382;
 Wed, 9 Apr 2025 14:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=b2LfKs
 720wD1M9ulRYtxJdts2IvQoLrBUb/dc5p69n0=; b=Ct8m42PUGEGpRuFGzjRhoR
 2x07mE5AUxqoP6rOf5NLky+i2IJH4iGeIJ9Eb7hZTlyANcXJ9BBmEGWNNQfbOa/k
 sFO7RI13Bmvs8vDu//+772JmYI/YmIS3yJkZegNhwq50H7ezREZ6scRb8j+XoSwT
 KrWHKHxzDEEjzfFUKaER+3w6Ymn7ScU+QfQjhFb5Bxt2BueMnNMnD0Rh11tYQB5y
 LJFDJ0T+10Ngu8xPX9J2G2uVzLe7vKbEWt81Xu6fc5GAJ54Y46/Oh40qgqNkuxRj
 2z9oFkONHeeMFsnYtxnxVFqP321LqsCAeRkxfntI+TnP2LBXivhE8a/H0H4Ol9ww
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wrx2rkj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 14:13:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539AeCD4018877;
 Wed, 9 Apr 2025 14:13:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uhj2fpv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 14:13:44 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 539EDh6322938210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Apr 2025 14:13:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAA1B58056;
 Wed,  9 Apr 2025 14:13:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64F7A58052;
 Wed,  9 Apr 2025 14:13:43 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Apr 2025 14:13:43 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 09 Apr 2025 16:13:43 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] hw/s390x: compat handling for backward migration
In-Reply-To: <037d512b-5214-449c-a518-a6b2d9d5fc29@redhat.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-5-shalini@linux.ibm.com>
 <1584a6d0-63b8-459b-9f4b-84192a9256e1@redhat.com>
 <688c719a1942615ada3e438670b8fb29@linux.ibm.com>
 <037d512b-5214-449c-a518-a6b2d9d5fc29@redhat.com>
Message-ID: <f89e0dd54376a42f91dd95d2985696f4@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sWIt5Z1-uefKx0OagDgDY7P3oKiF8l8d
X-Proofpoint-ORIG-GUID: sWIt5Z1-uefKx0OagDgDY7P3oKiF8l8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025-04-09 07:49, Thomas Huth wrote:
> On 03/04/2025 14.49, Shalini Chellathurai Saroja wrote:
>> On 2025-04-02 09:52, Thomas Huth wrote:
>>> On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
>>>> Add Control-Program Identification (CPI) device to QOM only when the 
>>>> virtual
>>>> machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0" 
>>>> machine
>>>> and higher.
>>>> 
>>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>>> ---
>>>>   hw/s390x/event-facility.c  | 27 ++++++++++++++++++++++-----
>>>>   hw/s390x/s390-virtio-ccw.c |  1 +
>>>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>>> 
>>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>>> index c0fb6e098c..cb23bbc54b 100644
>>>> --- a/hw/s390x/event-facility.c
>>>> +++ b/hw/s390x/event-facility.c
>>>> @@ -22,6 +22,7 @@
>>>>   #include "hw/s390x/sclp.h"
>>>>   #include "migration/vmstate.h"
>>>>   #include "hw/s390x/event-facility.h"
>>>> +#include "hw/qdev-properties.h"
>>>>     typedef struct SCLPEventsBus {
>>>>       BusState qbus;
>>>> @@ -54,6 +55,7 @@ struct SCLPEventFacility {
>>>>       bool allow_all_mask_sizes;
>>>>       /* length of the receive mask */
>>>>       uint16_t mask_length;
>>>> +    bool use_cpi;
>>>>   };
>>>>     /* return true if any child has event pending set */
>>>> @@ -455,11 +457,20 @@ static void realize_event_facility(DeviceState 
>>>> *dev, Error **errp)
>>>>           qdev_unrealize(DEVICE(&event_facility->quiesce));
>>>>           return;
>>>>       }
>>>> -    if (!qdev_realize(DEVICE(&event_facility->cpi),
>>>> -                      BUS(&event_facility->sbus), errp)) {
>>>> -        qdev_unrealize(DEVICE(&event_facility->quiesce));
>>>> -        qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
>>>> -        return;
>>>> +    /*
>>>> +     * Add sclpcpi device to QOM only when the virtual machine 
>>>> supports
>>>> +     * Control-Program Identification. It is supported by 
>>>> "s390-ccw- virtio-10.0"
>>>> +     * machine and higher.
>>>> +     */
>>>> +    if (!event_facility->use_cpi) {
>>>> +        object_unparent(OBJECT(&event_facility->cpi));
>>>> +    } else {
>>>> +        if (!qdev_realize(DEVICE(&event_facility->cpi),
>>>> +                          BUS(&event_facility->sbus), errp)) {
>>>> +            qdev_unrealize(DEVICE(&event_facility->quiesce));
>>>> +            qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
>>>> +            return;
>>>> +        }
>>> 
>>> Hmm, first doing object_initialize_child() in init_event_facility()
>>> and then unparenting it here again in case we are running with an
>>> older machine type is a little bit ugly. I wonder whether it would be
>>> nicer to add the QOM object from ccw_init() init instead, similar to
>>> what we do with the SCLP-console in s390_create_sclpconsole() ? If
>>> you've got some spare minutes, could you please give it a try whether
>>> that looks nicer?
>>> 
>> 
>> Hello Thomas,
>> 
>> Sure. Did you mean like the code below?, if yes, the use_cpi is always 
>> true when adding the sclpcpi device from ccw_init(). The use_cpi is 
>> set to false at a later point, when the machine type is 9.2 or older. 
>> This means the sclpcpi device is always added, the output and the code 
>> are provided below. Please let me know how to proceed, thank you very 
>> much.
> ...
>> @@ -499,6 +485,7 @@ static void init_event_facility_class(ObjectClass 
>> *klass, void *data)
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       k->command_handler = command_handler;
>>       k->event_pending = event_pending;
>> +    k->use_cpi = use_cpi;
>>   }
> ...
>> diff --git a/include/hw/s390x/event-facility.h 
>> b/include/hw/s390x/event- facility.h
>> index f445d2f9f5..ba20161023 100644
>> --- a/include/hw/s390x/event-facility.h
>> +++ b/include/hw/s390x/event-facility.h
>> @@ -204,6 +204,7 @@ struct SCLPEventFacilityClass {
>>       SysBusDeviceClass parent_class;
>>       void (*command_handler)(SCLPEventFacility *ef, SCCB *sccb, 
>> uint64_t code);
>>       bool (*event_pending)(SCLPEventFacility *ef);
>> +    bool (*use_cpi)(SCLPEventFacility *ef);
>>   };
> 
>  Hi,
> 
> you certainly don't need the (*use_cpi) callback here.
> 
> I'd suggest to:
> 
> 1) Add a boolean flag to S390CcwMachineClass in s390-virtio-ccw.h
> called "use_cpi", "cpi_allowed", "has_cpi" or whatever.
> 
> 2) Set that flag to true in ccw_machine_class_init() (similar to that
> hpage_1m_allowed flag)
> 
> 3) Set that flag to false in ccw_machine_9_2_class_options() so that
> it gets disabled for older machine type classes. Important: use the
> class_options() function here, not the instance_options()! Also not
> that this should go into the ccw_machine_10_0_class_options()
> functions instead once v10.0 has been released.
> 
> 4) In ccw_init() you should now be able to use "S390CcwMachineClass
> *s390mc = S390_CCW_MACHINE_CLASS(mc)" to query the flag from the
> machine class.
> 
>  HTH,
>   Thomas

Hi Thomas,

I will do this, Thank you.

-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294

