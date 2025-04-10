Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B332CC369A4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 09:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2oFJ-0001Tj-Rs; Thu, 10 Apr 2025 05:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2oEf-0001NJ-OW; Thu, 10 Apr 2025 05:30:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2oEd-0003Kq-9C; Thu, 10 Apr 2025 05:30:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A6IEKV022725;
 Thu, 10 Apr 2025 09:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vf1yRN
 pRu0UF0Ut8lK7lEtgX5gHL8KPFNQhNmOmFMpU=; b=f+O5lsu+b8adxN4zwf+jEY
 ks2MathZFwg/MJxx8AQR2gvHtndn6L6TdZVc6Ggnt+V6/+9BivUf99DFpHi3pEh5
 uhPjY2rZ9MH4SEjhXU3J27+qaYyulZrR5SRQXx7c/iZ5xv2n/THilXjZpocI1z07
 FJGdH4LKnpBGyuVQ+uBfoESvQd+lXn6rKy9T9gBBNhmshykA/UigAzTNY7Z8ADuc
 GZkZ6J8nWmcICJhwTb5ALtc8UK21ifN65mBWXhaEuEr8V+gNeis8W/yTet9AI0Uv
 9M5g4MpWbclz3ssfhRz7jk/LNofDHEL9tDOyWFxGGqevSjkgTUXZZicpEQextGYQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x02qbt2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 09:30:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A7Kt8P029513;
 Thu, 10 Apr 2025 09:30:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k737ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 09:30:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53A9U7L331916610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 09:30:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23F1A58062;
 Thu, 10 Apr 2025 09:30:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8564F5805D;
 Thu, 10 Apr 2025 09:30:06 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Apr 2025 09:30:06 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 10 Apr 2025 11:30:06 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x mailing list
 <qemu-s390x@nongnu.org>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <7743d8f3-497f-4d7e-9f42-16d8e8fc5c8e@redhat.com>
References: <bc4a5b3f078657b8dc3045a207ba9386@linux.ibm.com>
 <7743d8f3-497f-4d7e-9f42-16d8e8fc5c8e@redhat.com>
Message-ID: <f6c486f309c25ef8603624eda5ed492c@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dDMEipBvwyW7PVdBxErWQ1awIabivm47
X-Proofpoint-ORIG-GUID: dDMEipBvwyW7PVdBxErWQ1awIabivm47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
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

On 2025-04-09 07:30, Thomas Huth wrote:
> On 03/04/2025 16.33, Shalini Chellathurai Saroja wrote:
>> On 2025-04-01 15:55, Nina Schoetterl-Glausch wrote:
>>> On Mon, 2025-03-31 at 16:00 +0200, Shalini Chellathurai Saroja wrote:
>>>> Add Control-Program Identification data to the QEMU Object
>>>> Model (QOM), along with the timestamp in which the data was 
>>>> received.
>>>> 
>>>> Example:
>>>> virsh # qemu-monitor-command vm --pretty '{
>>>> "execute": "qom-get",
>>>> "arguments": {
>>>> "path": "/machine/sclp/s390-sclp-event-facility/sclpcpi",
>>>> "property": "control-program-id" }}'
>>>> {
>>>>   "return": {
>>>>     "timestamp": 1742390410685762000,
>>>>     "system-level": 74872343805430528,
>>>>     "sysplex-name": "PLEX ",
>>>>     "system-name": "TESTVM  ",
>>>>     "system-type": "LINUX   "
>>>>   },
>>>>   "id": "libvirt-15"
>>>> }
>>>> 
>>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>>> ---
>>>>  hw/s390x/sclpcpi.c                | 38 ++++++++++++++++++++
>>>>  include/hw/s390x/event-facility.h |  9 +++++
>>>>  qapi/machine.json                 | 58 
>>>> +++++++++++++++++++++++++++++++
>>>>  3 files changed, 105 insertions(+)
>>>> 
>>>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>>>> index 7ace5dd64e..969c15e43d 100644
>>>> --- a/hw/s390x/sclpcpi.c
>>>> +++ b/hw/s390x/sclpcpi.c
>>>> @@ -57,8 +57,11 @@
>>>>    */
>>>> 
>>>>  #include "qemu/osdep.h"
>>>> +#include "qemu/timer.h"
>>>>  #include "hw/s390x/sclp.h"
>>>>  #include "hw/s390x/event-facility.h"
>>>> +#include "hw/s390x/ebcdic.h"
>>>> +#include "qapi/qapi-visit-machine.h"
>>>> 
>>>>  typedef struct Data {
>>>>      uint8_t id_format;
>>>> @@ -99,10 +102,37 @@ static int write_event_data(SCLPEvent *event, 
>>>> EventBufferHeader *evt_buf_hdr)
>>>>      ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, 
>>>> ControlProgramIdMsg,
>>>>                                               ebh);
>>>> 
>>>> +    ascii_put(event->cpi.system_type, (char 
>>>> *)cpim->data.system_type, 8);
>>>> +    ascii_put(event->cpi.system_name, (char 
>>>> *)cpim->data.system_name, 8);
>>>> +    ascii_put(event->cpi.sysplex_name, (char 
>>>> *)cpim->data.sysplex_name, 8);
>>>> +    event->cpi.system_level = ldq_be_p(&cpim->data.system_level);
>>>> +    event->cpi.timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
>>>> +
>>>>      cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
>>>>      return SCLP_RC_NORMAL_COMPLETION;
>>>>  }
>>>> 
>>>> +static void get_control_program_id(Object *obj, Visitor *v,
>>>> +                                   const char *name, void *opaque,
>>>> +                                   Error **errp)
>>>> +{
>>>> +    SCLPEvent *event = (SCLPEvent *)(obj);
>>> 
>>> Do a checked cast with SCLP_EVENT(obj).
>> 
>> Hello Nina,
>> 
>> ok, thank you.
>>> 
>>>> +    S390ControlProgramId *cpi;
>>>> +
>>>> +    cpi = &(S390ControlProgramId){
>>>> +        .system_type = g_strndup((char *) event->cpi.system_type,
>>>> +                                 sizeof(event->cpi.system_type)),
>>>> +        .system_name = g_strndup((char *) event->cpi.system_name,
>>>> +                                 sizeof(event->cpi.system_name)),
>>>> +        .system_level = event->cpi.system_level,
>>>> +        .sysplex_name = g_strndup((char *) event->cpi.sysplex_name,
>>>> +                                  sizeof(event->cpi.sysplex_name)),
>>>> +        .timestamp = event->cpi.timestamp
>>>> +    };
>>>> +
>>>> +    visit_type_S390ControlProgramId(v, name, &cpi, errp);
>>>> +}
>>>> +
>>>>  static void cpi_class_init(ObjectClass *klass, void *data)
>>>>  {
>>>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>>> @@ -114,6 +144,14 @@ static void cpi_class_init(ObjectClass *klass, 
>>>> void *data)
>>>>      k->get_send_mask = send_mask;
>>>>      k->get_receive_mask = receive_mask;
>>>>      k->write_event_data = write_event_data;
>>>> +
>>>> +    object_class_property_add(klass, "control-program-id",
>>>> +                              "S390ControlProgramId",
>>>> +                              get_control_program_id,
>>>> +                              NULL, NULL, NULL);
>>>> +    object_class_property_set_description(klass, 
>>>> "control-program-id",
>>>> +        "Control-program identifiers provide data about the guest "
>>>> +        "operating system");
>>>>  }
>>>> 
>>>>  static const TypeInfo sclp_cpi_info = {
>>>> diff --git a/include/hw/s390x/event-facility.h 
>>>> b/include/hw/s390x/event- facility.h
>>>> index f445d2f9f5..39e589ed44 100644
>>>> --- a/include/hw/s390x/event-facility.h
>>>> +++ b/include/hw/s390x/event-facility.h
>>>> @@ -169,10 +169,19 @@ typedef struct ReadEventData {
>>>>      };
>>>>  } QEMU_PACKED ReadEventData;
>>>> 
>>>> +typedef struct ControlProgramId {
>>>> +    uint8_t system_type[8];
>>>> +    uint8_t system_name[8];
>>>> +    uint64_t system_level;
>>>> +    uint8_t sysplex_name[8];
>>>> +    uint64_t timestamp;
>>>> +} QEMU_PACKED ControlProgramId;
>>>> +
>>>>  struct SCLPEvent {
>>>>      DeviceState qdev;
>>>>      bool event_pending;
>>>>      char *name;
>>>> +    ControlProgramId cpi;
>>> 
>>> I don't think this should go into SCLPEvent.
>>> Rather SCLPEventFacility or SCLPDevice. Otherwise all events,
>>> so also quiesce and cpu_hotplug have a cpi field.
>>> 
>> ok, that is correct.
>> 
>> I gave it a try by moving ControlProgramId to SCLPDevice. With this, 
>> the migration data is stored in dc->vmsd of TYPE_SCLP as shown below.
>> 
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 5945c9b1d8..4d6d5bb857 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -424,6 +424,29 @@ static void sclp_init(Object *obj)
>>       sclp_memory_init(sclp);
>>   }
>> 
>> +static const VMStateDescription vmstate_control_program_id = {
>> +    .name = "s390_control_program_id",
>> +    .version_id = 0,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
>> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
>> +        VMSTATE_UINT64(system_level, ControlProgramId),
>> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
>> +        VMSTATE_UINT64(timestamp, ControlProgramId),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_sclpcpi = {
>> +    .name = "s390_sclpcpi",
>> +    .version_id = 0,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_STRUCT(cpi, SCLPDevice, 0, 
>> vmstate_control_program_id,
>> +                       ControlProgramId),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void sclp_class_init(ObjectClass *oc, void *data)
>>   {
>>       SCLPDeviceClass *sc = SCLP_CLASS(oc);
>> @@ -438,6 +461,7 @@ static void sclp_class_init(ObjectClass *oc, void 
>> *data)
>>        * which is a non-pluggable sysbus device
>>        */
>>       dc->user_creatable = false;
>> +    dc->vmsd =  &vmstate_sclpcpi;
>> 
>>       sc->read_SCP_info = read_SCP_info;
>>       sc->read_cpu_info = sclp_read_cpu_info;
>> 
>> @Thomas Huth: Is this ok?, thank you.
> 
>  Hi,
> 
> that also does not look like the right place to me ... can't you move
> the migration state to the TYPE_SCLP_CPI device instead?
> 

Hi Thomas,
I will do so, thank you.

>  Thomas

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

