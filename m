Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B1C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpji-0002Ah-CD; Mon, 05 May 2025 02:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBpjg-0002AD-GR; Mon, 05 May 2025 02:55:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBpje-00005k-6d; Mon, 05 May 2025 02:55:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544KU7At017424;
 Mon, 5 May 2025 06:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=r9M5YK2I+25ZZaIwT29BswGx/SjY
 ZZCM/DSIGIWxHfU=; b=eyijREFEzSsPCkAwvmhcC7P1B80OrLPKWePqgeUahku5
 qqomfbVJJ3Rak+cdwLObSFAwGdtZzLgyHLRBQBALmsrIdMoJawc9jPMH/FfoU9HV
 4EkUm+aHeMrZKGO1dZgM4kF3IB6RH0FIauyJYaG98I1SuCELtHv8fnpCWJvRhZya
 Xu3O55xfLZKp5Hjhr8gnwJOahPA2BqKb4Yet0DD1SxbcAJ16kV9K5n7d2hbEDZxg
 p7E//dEmcC42BQ8mBo6npnonTU0hs00BRyc+UAibHf6tBAfpVhl5Cnv1kp5JzkzN
 xVdpjHXdVbvWN9gTjMDRR2JyZrKmXqfTqDuAv1f0Mg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46e65hu171-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 06:55:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5453IxkP002815;
 Mon, 5 May 2025 06:55:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfnn1m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 06:55:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5456tNnN27197768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 May 2025 06:55:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D5335805C;
 Mon,  5 May 2025 06:55:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 310445805F;
 Mon,  5 May 2025 06:55:23 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 May 2025 06:55:23 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 05 May 2025 08:55:22 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Janis Schoetterl-Glausch <scgl@linux.vnet.ibm.com>, Nina
 Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
Message-ID: <ad66ac925ff301a945ac1f56fc1d31cc@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UZ1RSLSN c=1 sm=1 tr=0 ts=681860de cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Kn5hTDTUM7iVEbZWKLEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GDsZyTawOJ0MwdXPNCkdXAIY9n5j2-NZ
X-Proofpoint-ORIG-GUID: GDsZyTawOJ0MwdXPNCkdXAIY9n5j2-NZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA2MCBTYWx0ZWRfXxlbYjVu/0x/M
 MywXuCvQEYzMfDhEV5qShsqG8l8d6+uTUdAkY1+GmVIeBRIaHrilllKHDINYQh5Xl8wV7TB3oYW
 DVfU5ImKaipiV3U1QwbWfIUs+2WWwiN3AN6F7hbBy1GdbuD/vlWsLoJ7V9LiPUpV9vFhtmJz8hA
 IxRYEOVbCrA1Ry+xuVPHK4BvenC0LYkpkFW0mg58fOjLiFoVAHVbD+lkaHyfkQWCXBQT8fjkjoD
 5zU9bjaJ2aThKniLhxK/7oPkv1uMbwY8/kISjeM2AvnekWbLKQxOGtJwQwPyEtg6RU9ksgPpluo
 vFz5IPqW/7ZOa7YRD6CNYyhnzcscqqZCYZxvnQmNI6sZY7OqvCfZOblmKeb6lFMD7mq17Ol3+pZ
 wzJ8vge7qoM1UUFMuQWY+FHKb+yM9uK40Ar8/hBScWQ+Y4ue3DkqFvQw0K1y017A4h0COksd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2025-04-28 11:22, Janis Schoetterl-Glausch wrote:
> On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
>> Implement the Service-Call Logical Processor (SCLP) event
>> type Control-Program Identification (CPI) in QEMU. This
>> event is used to send CPI identifiers from the guest to the
>> host. The CPI identifiers are: system type, system name,
>> system level and sysplex name.
>> 
>> System type: operating system of the guest (e.g. "LINUX").
>> System name: user configurable name of the guest (e.g. "TESTVM").
>> System level: distribution and kernel version, if the system type is 
>> Linux
>> (e.g. 0x50e00).
>> Sysplex name: name of the cluster which the guest belongs to (if any)
>> (e.g. "PLEX").
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/event-facility.c         |  2 +
>>  hw/s390x/meson.build              |  1 +
>>  hw/s390x/s390-virtio-ccw.c        | 14 +++++
>>  hw/s390x/sclpcpi.c                | 92 
>> +++++++++++++++++++++++++++++++
>>  include/hw/s390x/event-facility.h | 13 +++++
>>  5 files changed, 122 insertions(+)
>>  create mode 100644 hw/s390x/sclpcpi.c
>> 
>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>> index 2b0332c20e..60237b8581 100644
>> --- a/hw/s390x/event-facility.c
>> +++ b/hw/s390x/event-facility.c
>> @@ -4,6 +4,7 @@
>>   *       handles SCLP event types
>>   *          - Signal Quiesce - system power down
>>   *          - ASCII Console Data - VT220 read and write
>> + *          - Control-Program Identification - Send OS data from 
>> guest to host
>>   *
>>   * Copyright IBM, Corp. 2012
>>   *
>> @@ -40,6 +41,7 @@ struct SCLPEventFacility {
>>      SysBusDevice parent_obj;
>>      SCLPEventsBus sbus;
>>      SCLPEvent quiesce, cpu_hotplug;
>> +    SCLPEventCPI cpi;
>>      /* guest's receive mask */
>>      union {
>>          uint32_t receive_mask_pieces[2];
>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>> index 3bbebfd817..eb7950489c 100644
>> --- a/hw/s390x/meson.build
>> +++ b/hw/s390x/meson.build
>> @@ -13,6 +13,7 @@ s390x_ss.add(files(
>>    's390-skeys.c',
>>    's390-stattrib.c',
>>    'sclp.c',
>> +  'sclpcpi.c',
>>    'sclpcpu.c',
>>    'sclpquiesce.c',
>>    'tod.c',
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 75b32182eb..7f28cbd1de 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -260,6 +260,17 @@ static void s390_create_sclpconsole(SCLPDevice 
>> *sclp,
>>      qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>>  }
>> 
>> +static void s390_create_sclpcpi(SCLPDevice *sclp)
>> +{
>> +    SCLPEventFacility *ef = sclp->event_facility;
>> +    BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
>> +    DeviceState *dev;
>> +
>> +    dev = qdev_new(TYPE_SCLP_EVENT_CPI);
>> +    object_property_add_child(OBJECT(ef), "sclpcpi", OBJECT(dev));
>> +    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
> 
> I wonder if we should drop this and add control-program-id directly
> on the event facility. I don't see what purpose having the intermediate
> level sclpcpi serves.
> 

Hello Nina,

sclpcpi is the qemu device which handles the SCLP event type 
Control-Program Identification by performing the following.
1. The sclpcpi device indicates to the guest OS that QEMU is able to 
process the event buffers of the SCLP event type Control-Program 
Identification.
2. The sclpcpi device receives the data from the event buffers of the 
SCLP event type Control-Program Identification sent by the guest OS.
The received data is stored in control-program-id, which is the property 
of the device sclpcpi. So, the sclpcpi device cannot be dropped.

In addition, Thomas Huth told that the migration data of a device must 
be stored in the device itself during his review of the previous 
versions of this patch series. So control-program-id cannot be stored in 
the event facility.

It is possible to add the identifiers directly as the properties of 
sclpcpi (eg. system type as shown below) and remove the 
control-program-id.

virsh # qemu-monitor-command vm --pretty 
'{"execute":"qom-list","arguments": {"path": 
"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
{
   "return": [
     {
       "name": "type",
       "type": "string"
     },
     {
       "name": "parent_bus",
       "type": "link<bus>"
     },
     {
       "name": "realized",
       "type": "bool"
     },
     {
       "name": "hotplugged",
       "type": "bool"
     },
     {
       "name": "hotpluggable",
       "type": "bool"
     },
     {
       "name": "system_type",
       "type": "string"
     },
     {
       "name": "control-program-id",
       "type": "S390ControlProgramId"
     }
   ],
   "id": "libvirt-16"
}

virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi", 
"property":"system_type"}}'
{
   "return": "LINUX   ",
   "id": "libvirt-17"
}

However, Hendrik Brückner suggested to group the identifiers together 
during the initial discussion of this line item. So, I would prefer to 
leave this as it is. Please let me know if you still think otherwise.

>> +}
> 
> [...]
> 
>> diff --git a/include/hw/s390x/event-facility.h 
>> b/include/hw/s390x/event-facility.h
>> index ff874e792d..ef469e62ae 100644
>> --- a/include/hw/s390x/event-facility.h
>> +++ b/include/hw/s390x/event-facility.h
> 
> [...]
>    I.
>> +struct SCLPEventCPI {
>> +    DeviceState qdev;
>> +    SCLPEvent event;
> 
> I think you should just inherit from SCLPEvent, which in turn inherits
> from DeviceState.
> So without the qdev.
> 

Ok, I will do so. Thank you very much for the review.

>> +};
>> +
>>  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
>>  typedef struct SCLPEventFacility SCLPEventFacility;
>>  typedef struct SCLPEventFacilityClass SCLPEventFacilityClass;

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

