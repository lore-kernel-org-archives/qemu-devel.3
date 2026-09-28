Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6562CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBFdI-0004AR-1A; Mon, 28 Sep 2026 13:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBFdD-000498-Pz; Mon, 28 Sep 2026 13:59:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBFdA-0002lV-FO; Mon, 28 Sep 2026 13:59:15 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SHwBV3010935
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 29 Sep 2026 02:58:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bhNfS5XO2iaI5aLMAvwzQlHQQrEAoGc5fDrXaHyQC5g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790618292; v=1;
 b=vXHwzDghWy/WugSK0hd6WwfnZw+gAQb1cums1llrFO556mobUTc8a2GSP9jqOcp3
 LUMTdOWGwz1U+xsuSkmhGq6Pd5cBKWGxUZDstEbQAr0gUOw5LAUvTQWbyQ/tpwKb
 kVy8GBblBdyrtefIj+8s48fSiNRx2235N5E4qxcHzBC8PzVJ7tB6FeahhctxPDDP
 jBT0lsG4hsUa+IqRXK5chGQikh+d9yVo1WwyH+EsGJ+FUewAP5AMeM7N/OdxOvn1
 FcSkUQkikmSCRFvOJYz1YSEe7FGdiXjVk2XpWpMtIb4nuSiqdExXs74NjH4llMjG
 4WJWA+CW7XZMzFwYCc/S8g==
Message-ID: <71854074-d5f4-4818-ae4f-4d1b9d761b46@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 29 Sep 2026 02:58:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] hw/qdev: Introduce DevicePhase
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
 <20260914-qdev-v4-2-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
 <99d1d189-fd2c-47fd-83ba-e232121096e4@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <99d1d189-fd2c-47fd-83ba-e232121096e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/09/26 18:48, Philippe Mathieu-Daudé wrote:
> On 14/9/26 11:31, Akihiko Odaki wrote:
>> Replace the bool DeviceState::realized field with the enum-valued
>> DeviceState::phase field to express finer phases in following changes.
>>
>> The QOM realized property is an internal lifecycle property, not for
>> end users. Replace it with the enum-valued phase property.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   qapi/common.json          | 14 ++++++++++++++
>>   include/hw/core/qdev.h    |  7 ++++---
>>   hw/core/qdev-clock.c      |  4 ++--
>>   hw/core/qdev-properties.c |  4 ++--
>>   hw/core/qdev.c            | 45 ++++++++++++++++++++++ 
>> +----------------------
>>   hw/scsi/scsi-bus.c        |  4 ++--
>>   qom/qom-qmp-cmds.c        |  2 +-
>>   system/qdev-monitor.c     |  5 +++--
>>   8 files changed, 51 insertions(+), 34 deletions(-)
>>
>> diff --git a/qapi/common.json b/qapi/common.json
>> index af7e3d618a7c..415a2722fc1a 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -7,6 +7,20 @@
>>   # *****************
>>   ##
>> +##
>> +# @DevicePhase:
>> +#
>> +# An enumeration of the device phases
>> +#
>> +# @unrealized: the initial phase
>> +#
>> +# @realized: the phase after realization
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'enum': 'DevicePhase',
>> +  'data': [ 'unrealized', 'realized' ] }
>> +
>>   ##
>>   # @IoOperationType:
>>   #
>> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
>> index b1c5f4780a90..ff367b2a5f98 100644
>> --- a/include/hw/core/qdev.h
>> +++ b/include/hw/core/qdev.h
>> @@ -1,6 +1,7 @@
>>   #ifndef QDEV_CORE_H
>>   #define QDEV_CORE_H
>> +#include "qapi/qapi-types-common.h"
>>   #include "qemu/atomic.h"
>>   #include "qemu/queue.h"
>>   #include "qemu/bitmap.h"
>> @@ -232,9 +233,9 @@ struct DeviceState {
>>        */
>>       char *canonical_path;
>>       /**
>> -     * @realized: has device been realized?
>> +     * @phase: the current phase
>>        */
>> -    bool realized;
>> +    DevicePhase phase;
>>       /**
>>        * @pending_deleted_event: track pending deletion events during 
>> unplug
>>        */
>> @@ -440,7 +441,7 @@ DeviceState *qdev_try_new(const char *name);
>>    */
>>   static inline bool qdev_is_realized(const DeviceState *dev)
>>   {
>> -    return qatomic_load_acquire(&dev->realized);
>> +    return qatomic_load_acquire(&dev->phase) == DEVICE_PHASE_REALIZED;
>>   }
>>   /**
>> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
>> index 861f78f94c64..efb33a3a27e7 100644
>> --- a/hw/core/qdev-clock.c
>> +++ b/hw/core/qdev-clock.c
>> @@ -30,7 +30,7 @@ static NamedClockList 
>> *qdev_init_clocklist(DeviceState *dev, const char *name,
>>        * Clock must be added before realize() so that we can compute the
>>        * clock's canonical path during device_realize().
>>        */
>> -    assert(!dev->realized);
>> +    assert(dev->phase != DEVICE_PHASE_REALIZED);
>>       /*
>>        * The ncl structure is freed by qdev_finalize_clocklist() which 
>> will
>> @@ -186,6 +186,6 @@ Clock *qdev_alias_clock(DeviceState *dev, const 
>> char *name,
>>   void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock 
>> *source)
>>   {
>> -    assert(!dev->realized);
>> +    assert(dev->phase != DEVICE_PHASE_REALIZED);
>>       clock_set_source(qdev_get_clock_in(dev, name), source);
>>   }
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 34d7b26a7303..66cff4b9338c 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -33,7 +33,7 @@ static bool qdev_prop_allow_set(Object *obj, const 
>> char *name,
>>   {
>>       DeviceState *dev = DEVICE(obj);
>> -    if (dev->realized && !info->realized_set_allowed) {
>> +    if (dev->phase == DEVICE_PHASE_REALIZED && !info- 
>> >realized_set_allowed) {
>>           qdev_prop_set_after_realize(dev, name, errp);
>>           return false;
>>       }
> 
> IMO a preliminary patch should convert to use qdev_is_realized() where
> appropriate (due to the atomicity), then this patch which LGTM btw.

I haven't found any places that need additional atomicity guarantees,
and I'm simply assuming the existing code is correct here. In the 
previous version, I converted accesses outside qdev to use the qdev 
accessor for encapsulation.

Regards,
Akihiko Odaki

