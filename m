Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8B1C4452D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 05:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmPGi-0007yW-Tr; Wed, 22 Jul 2026 01:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wmPGI-0007tn-UV; Wed, 22 Jul 2026 01:12:54 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wmPGF-0007VH-Hk; Wed, 22 Jul 2026 01:12:54 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66M5C0UB027295
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 22 Jul 2026 14:12:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1x87Yv68/hv4h8gC1ekid76fqo5h7iOuBFTT+mIsAFk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784697121; v=1;
 b=iS/VbEvBWnuKCHIpmunBgHyqYyJ84f+/1c6fhg9IaGV2Ci2FmNCFm8uzNfvhbBEP
 cyJxUDCOJiPwJf1Exx+syqzn4ptEv50og57EWRQpK4Ylax/NA1s8tA82uZGwW9/r
 MXQmJOU6aPM8yT72WcmmLYlQ6Xf+n4OVATvb/AN3NyMJlDNr2CCg0Ycfq9MsqhFv
 2Lz9kL4j24eZ+80Jz2tMvsmgFdP8NzhEHfX6mEQWMC5L8wOpa+KCvsnxkdchTkxO
 4JRIu3zIE0s2EPoYvPZa87+nuqSL2i2TtZzCFoeVYzLOVioZ7DsXVA81yImMkUg1
 OL90xl+TQG1zU8sJoq3cSA==
Message-ID: <a5597a0e-c18c-4649-bfd1-20d77897ff88@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 22 Jul 2026 14:12:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 15/15] hw/qdev: Prevent devices from being
 realized more than once
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
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-15-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <356ebc59-d2cb-4c47-867e-8fc693b3a593@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <356ebc59-d2cb-4c47-867e-8fc693b3a593@oss.qualcomm.com>
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

On 2026/07/22 5:11, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 21/7/26 10:17, Akihiko Odaki wrote:
>> qdev currently permits reentrant realization of the same device. It also
>> permits another realization attempt after a device has been unrealized
>> or a previous attempt has failed. Either path can invoke
>> DeviceClass::realize() more than once. Supporting repeated realization
>> adds complexity to device implementations. It is untested and likely
>> broken.
>>
>> Replace the bool DeviceState::realized field with the enum-valued
>> DeviceState::phase field. The enum has four values:
>>
>> - initialized
>> - realizing
>> - realized
>> - retired
> 
> Excellent.
> 
> I have been working on something similar.
> 
> I'd start the first patch only including:
> 
> DEVICE_PHASE_UNREALIZED (false)
> DEVICE_PHASE_REALIZED (true)
> 
> Then gradually rename DEVICE_PHASE_REALIZED -> DEVICE_PHASE_CREATED
> and add the DEVICE_PHASE_REALIZING and DEVICE_PHASE_RETIRED phases,
> so we can discuss them during the review process.

A gradual conversion makes sense. I kept the "realized" phase as-is 
because it maps exactly to the current external behavior. This patch 
splits the internal "unrealized" state into three distinct phases, but 
the external concept of being "realized" remains unchanged. This allows 
us to avoid a tree-wide refactoring, which is also why 
qdev_is_realized() is preserved.

> 
>> Realization can start only in the initialized phase. It moves the device
>> to the realizing phase before invoking callbacks, preventing another
>> realization attempt. Successful realization moves it to the realized
>> phase; failure after realization has started moves it to the retired
>> phase. Unrealization also moves a realized device to the retired phase.
> 
> So what is the difference between 'initialized' and 'retired'?

The first statement in this paragraph differentiates 'initialized' from 
everything else: realization can start only in the initialized phase. A 
'retired' device cannot be realized. This property avoids re-entrancy.

> 
>> The QOM realized property is an internal lifecycle property, not for
>> end users. Replace it with the enum-valued phase property.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   qapi/common.json          |  19 ++++++++
>>   include/hw/core/qdev.h    |  12 ++---
>>   hw/core/qdev-clock.c      |   4 +-
>>   hw/core/qdev-properties.c |   4 +-
>>   hw/core/qdev.c            |  98 +++++++++++++++++++++++++ 
>> +--------------
>>   hw/scsi/scsi-bus.c        |   4 +-
>>   qom/qom-qmp-cmds.c        |   2 +-
>>   system/qdev-monitor.c     |   5 ++-
>>   tests/unit/test-qdev.c    | 112 ++++++++++++++++++++++++++++++++++++ 
>> +++++++++-
>>   9 files changed, 212 insertions(+), 48 deletions(-)
>>
>> diff --git a/qapi/common.json b/qapi/common.json
>> index af7e3d618a7c..88a308cbd172 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -7,6 +7,25 @@
>>   # *****************
>>   ##
>> +##
>> +# @DevicePhase:
>> +#
>> +# An enumeration of the device phases
>> +#
>> +# @initialized: the initial phase
>> +#
>> +# @realizing: the phase during realization
>> +#
>> +# @realized: the phase after realization
>> +#
>> +# @retired: the terminal phase entered when unrealization begins or
>> +#           realization fails after starting
>> +#
>> +# Since: 11.1
>> +##
>> +{ 'enum': 'DevicePhase',
>> +  'data': [ 'initialized', 'realizing', 'realized', 'retired' ] }
>> +
> 
> 
>> @@ -477,10 +477,10 @@ bool qdev_unplug_blocked(DeviceState *dev, Error 
>> **errp)
>>       return false;
>>   }
>> -static bool device_get_realized(Object *obj, Error **errp)
>> +static int device_get_phase(Object *obj, Error **errp)
> 
> DevicePhase

device_get_phase() must return int to match the getter type required by
object_class_property_add_enum():

     int (*get)(Object *, Error **)

Using DevicePhase there would not match the callback type.

> 
>>   {
>>       DeviceState *dev = DEVICE(obj);
>> -    return dev->realized;
>> +    return dev->phase;
>>   }
> 
> 
>> @@ -670,7 +702,6 @@ static void device_initfn(Object *obj)
>>       }
>>       dev->instance_id_alias = -1;
>> -    dev->realized = false;
> 
> Can we keep the initialization explicit? This helps when navigating
> the code base.

Yes, I will make that change in the next version.

Regards,
Akihiko Odaki

> 
>>       dev->allow_unplug_during_migration = false;
>>       QLIST_INIT(&dev->gpios);


