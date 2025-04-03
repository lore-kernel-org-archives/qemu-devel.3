Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102E6C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 12:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0K0y-0005js-6X; Thu, 03 Apr 2025 08:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u0K0u-0005jD-89; Thu, 03 Apr 2025 08:49:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u0K0q-0001Dq-6W; Thu, 03 Apr 2025 08:49:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5333lDLB008475;
 Thu, 3 Apr 2025 12:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qB0HrG
 MXym8Lorh0LqKGXANvc8OH00/GaMjRU7JDr2c=; b=JBH9Cvu8bkRgCeQMsRAPCH
 JDjjKWgDPCaCNIMBXQayyyijRDUdJ6YAUyrV2EW8/yRUBij7GgCRGcff7YMag78m
 opud7LOCYTS02Jggj1z/HDBP3eaklOQi/6xyikIX3aNLOqs4DY8gnKHGAHELEcPo
 tyzy18yWK+2UopyA/XL+WRACa4VN1D/Ib8WFDa1xvEIOIOwRSxS7NcRXo9kmEtFs
 PZRLorrEeI6CZRhs5ZiHZQvHzRMaTixJlmxkAjadkjxYF2ylmQC7II03wJNsCrHo
 y8A2XD6S/icaD3q+KeokF7abmENfU2vyCEvL4bBBTZcKsrhPQPvvpBDrreSudg8w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45sjq9t91b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 12:49:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5339ajD6004829;
 Thu, 3 Apr 2025 12:49:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45puk0501v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 12:49:33 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 533CnWxw32703060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 12:49:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2536A5805C;
 Thu,  3 Apr 2025 12:49:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C71B45805E;
 Thu,  3 Apr 2025 12:49:31 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Apr 2025 12:49:31 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 03 Apr 2025 14:49:31 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] hw/s390x: compat handling for backward migration
In-Reply-To: <1584a6d0-63b8-459b-9f4b-84192a9256e1@redhat.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-5-shalini@linux.ibm.com>
 <1584a6d0-63b8-459b-9f4b-84192a9256e1@redhat.com>
Message-ID: <688c719a1942615ada3e438670b8fb29@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VpdScj0LDj50NqI8Ad6f24H70eE_D7WN
X-Proofpoint-ORIG-GUID: VpdScj0LDj50NqI8Ad6f24H70eE_D7WN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_05,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504030053
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
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

On 2025-04-02 09:52, Thomas Huth wrote:
> On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification (CPI) device to QOM only when the 
>> virtual
>> machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0" 
>> machine
>> and higher.
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>   hw/s390x/event-facility.c  | 27 ++++++++++++++++++++++-----
>>   hw/s390x/s390-virtio-ccw.c |  1 +
>>   2 files changed, 23 insertions(+), 5 deletions(-)
>> 
>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>> index c0fb6e098c..cb23bbc54b 100644
>> --- a/hw/s390x/event-facility.c
>> +++ b/hw/s390x/event-facility.c
>> @@ -22,6 +22,7 @@
>>   #include "hw/s390x/sclp.h"
>>   #include "migration/vmstate.h"
>>   #include "hw/s390x/event-facility.h"
>> +#include "hw/qdev-properties.h"
>>     typedef struct SCLPEventsBus {
>>       BusState qbus;
>> @@ -54,6 +55,7 @@ struct SCLPEventFacility {
>>       bool allow_all_mask_sizes;
>>       /* length of the receive mask */
>>       uint16_t mask_length;
>> +    bool use_cpi;
>>   };
>>     /* return true if any child has event pending set */
>> @@ -455,11 +457,20 @@ static void realize_event_facility(DeviceState 
>> *dev, Error **errp)
>>           qdev_unrealize(DEVICE(&event_facility->quiesce));
>>           return;
>>       }
>> -    if (!qdev_realize(DEVICE(&event_facility->cpi),
>> -                      BUS(&event_facility->sbus), errp)) {
>> -        qdev_unrealize(DEVICE(&event_facility->quiesce));
>> -        qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
>> -        return;
>> +    /*
>> +     * Add sclpcpi device to QOM only when the virtual machine 
>> supports
>> +     * Control-Program Identification. It is supported by 
>> "s390-ccw-virtio-10.0"
>> +     * machine and higher.
>> +     */
>> +    if (!event_facility->use_cpi) {
>> +        object_unparent(OBJECT(&event_facility->cpi));
>> +    } else {
>> +        if (!qdev_realize(DEVICE(&event_facility->cpi),
>> +                          BUS(&event_facility->sbus), errp)) {
>> +            qdev_unrealize(DEVICE(&event_facility->quiesce));
>> +            qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
>> +            return;
>> +        }
> 
> Hmm, first doing object_initialize_child() in init_event_facility()
> and then unparenting it here again in case we are running with an
> older machine type is a little bit ugly. I wonder whether it would be
> nicer to add the QOM object from ccw_init() init instead, similar to
> what we do with the SCLP-console in s390_create_sclpconsole() ? If
> you've got some spare minutes, could you please give it a try whether
> that looks nicer?
> 

Hello Thomas,

Sure. Did you mean like the code below?, if yes, the use_cpi is always 
true when adding the sclpcpi device from ccw_init(). The use_cpi is set 
to false at a later point, when the machine type is 9.2 or older. This 
means the sclpcpi device is always added, the output and the code are 
provided below. Please let me know how to proceed, thank you very much.

virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility", 
"property":"use-cpi"}}'
{
   "return": false,
   "id": "libvirt-16"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get", 
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi", 
"property":"control-program-id"}}'
{
   "return": {
     "timestamp": 1743681889538425000,
     "system-level": 74872343805430528,
     "sysplex-name": "        ",
     "system-name": "        ",
     "system-type": "LINUX   "
   },
   "id": "libvirt-17"
}

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index cb23bbc54b..15d9f94845 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -76,6 +76,11 @@ static bool event_pending(SCLPEventFacility *ef)
      return false;
  }

+static bool use_cpi(SCLPEventFacility *ef)
+{
+    return ef->use_cpi;
+}
+
  static sccb_mask_t get_host_send_mask(SCLPEventFacility *ef)
  {
      sccb_mask_t mask;
@@ -438,10 +443,6 @@ static void init_event_facility(Object *obj)
      object_initialize_child(obj, TYPE_SCLP_CPU_HOTPLUG,
                              &event_facility->cpu_hotplug,
                              TYPE_SCLP_CPU_HOTPLUG);
-
-    object_initialize_child(obj, TYPE_SCLP_CPI,
-                            &event_facility->cpi,
-                            TYPE_SCLP_CPI);
  }

  static void realize_event_facility(DeviceState *dev, Error **errp)
@@ -457,21 +458,6 @@ static void realize_event_facility(DeviceState 
*dev, Error **errp)
          qdev_unrealize(DEVICE(&event_facility->quiesce));
          return;
      }
-    /*
-     * Add sclpcpi device to QOM only when the virtual machine supports
-     * Control-Program Identification. It is supported by 
"s390-ccw-virtio-10.0"
-     * machine and higher.
-     */
-    if (!event_facility->use_cpi) {
-        object_unparent(OBJECT(&event_facility->cpi));
-    } else {
-        if (!qdev_realize(DEVICE(&event_facility->cpi),
-                          BUS(&event_facility->sbus), errp)) {
-            qdev_unrealize(DEVICE(&event_facility->quiesce));
-            qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
-            return;
-        }
  }

  static void reset_event_facility(DeviceState *dev)
@@ -499,6 +485,7 @@ static void init_event_facility_class(ObjectClass 
*klass, void *data)
      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
      k->command_handler = command_handler;
      k->event_pending = event_pending;
+    k->use_cpi = use_cpi;
  }

  static const TypeInfo sclp_event_facility_info = {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c1001322e0..f077ecaee1 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -260,6 +260,21 @@ static void s390_create_sclpconsole(SCLPDevice 
*sclp,
      qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
  }

+static void s390_create_sclpcpi(SCLPDevice *sclp)
+{
+    SCLPEventFacility *ef = sclp->event_facility;
+    SCLPEventFacilityClass *efc = EVENT_FACILITY_GET_CLASS(ef);
+    BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
+    DeviceState *dev;
+
+    if(efc->use_cpi) {
+        dev = qdev_new(TYPE_SCLP_CPI);
+        object_property_add_child(OBJECT(ef), "sclpcpi", OBJECT(dev));
+        object_unref(OBJECT(dev));
+        qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
+    }
+}
+
  static void ccw_init(MachineState *machine)
  {
      MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -323,6 +338,10 @@ static void ccw_init(MachineState *machine)

      /* init the TOD clock */
      s390_init_tod();
+
+    /* init SCLP event Control-Program Identification */
+    s390_create_sclpcpi(ms->sclp);
+
  }

  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
diff --git a/include/hw/s390x/event-facility.h 
b/include/hw/s390x/event-facility.h
index f445d2f9f5..ba20161023 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -204,6 +204,7 @@ struct SCLPEventFacilityClass {
      SysBusDeviceClass parent_class;
      void (*command_handler)(SCLPEventFacility *ef, SCCB *sccb, uint64_t 
code);
      bool (*event_pending)(SCLPEventFacility *ef);
+    bool (*use_cpi)(SCLPEventFacility *ef);
  };

  BusState *sclp_get_event_facility_bus(SCLPEventFacility *ef);


>  Thanks,
>   Thomas

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

