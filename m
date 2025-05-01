Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1094FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcBb-0001Y7-GI; Thu, 01 May 2025 18:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcBY-0001Ul-5X
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:15:16 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcBV-0005Nk-Dx
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:15:15 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d7f111e9e1so16288785ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746137711; x=1746742511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vU1EE3/PLmp2MpLceyTfVUsrftwFYeCx1DLvlzIWys4=;
 b=GoAvkQKqTr0WOF+S3JFMo53En97zlsp64JeHJidzjcTPD1euDOoJIXh7sIYuzBYkxa
 GERvi50WYWyzTrU/0ziwo8nhHhh8WWm3CxRZx6YV+khOmWWvIwZBDehwFVrZGElIAKJW
 m6hsN7UrY6PJoY1E6B79vvoBtnT7aawOQC8rWJCfV6blZbLHfmSkYUER2kqGye8pVM4s
 jfkLNL1XHjOoWewnPdaP+fHoTTCmMrBzv12e2TV8zixwwpDO5M+eenYkKhGoZWYVA1f3
 0GSxD/jf2hQSA54YDQB7g1zEZXP8Dd5Dii+30218+5zLIQU0vdgsbWMyTySYetioz+EB
 Ho+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746137711; x=1746742511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vU1EE3/PLmp2MpLceyTfVUsrftwFYeCx1DLvlzIWys4=;
 b=GEPYytAW2jgfq/EWxa5GzLKc5DGPV0QKOwlmTtLOc92FH5WGz7OTxDVsvlwOtXBdJC
 /cRT+c+dcFBsbDp/q7beiUH8eMPgdsZ7x9j8U8baUZ1Iccz+LxF6tQ3wy6vgCLtO3n2H
 JTHeJY3MNtuehONs54kca/pyiMpYtoAVaBCtu9mHBCe75QO78tzECU/h3Lpw2KuivHKa
 r7j0e2e/gZBz3ETFX53MMfhk77mUeTAB3vKHD6JOxdGGSvTcTQIPFaQ3XTOkZIiRy5tk
 aRI/QFtik4jfLsNQqIGZ0uS9n5tNX1PPf5qD+cHK0cRfkG0ivqVejp7JbvKooZe2DyXI
 sGzA==
X-Gm-Message-State: AOJu0YxbJ2DM/ObOJN2QnS9FcMRMeD+QdqzA0zY1O3LRcCJd5Xl8ZlGw
 0X1CenY0QS92fb52DatRhVVijuSVsDfKOgYqCVIbMWTPzEmDYJCgYYC+OJ5z2gY=
X-Gm-Gg: ASbGncunbOs8pw/CKg7Lz/BqnnXWqP/Ol2oUVcswbaRQn8nmsdK+RKYkiDVwIYTI2Cv
 ZcH4jRZDxvpX9U6KEYJZInJsN8EEsW7GCiLRK2FHyH0S3pIL/KQuFotDxB+WOuIZX03qFV1hX+S
 E949YhoyrVmGFK+J+jS40tPMXUA5UgwNghPbOSon6vZMXDt1I5CJoly1YgDRrkFWdNkD9C+yTqF
 9rYltLHnnrmMb9yCnxncc7RG44yzKXqu9/+XrykXS5nYinRtRNbkM5jMltr3rW+c7Chn8/aLMOO
 MmC+cIir/IeoBg4u9Iu9v+7urJ/c3l65MtaCvcLTpztmJpfjVUfIdAo1TBRoTgQXVPkKr5kB1/M
 3te/ClECbbiU/WyvZV4TTGcWk
X-Google-Smtp-Source: AGHT+IHdDGuluooIBOe+alNP81Op0yRHG2UWyyhcRdVtoPrx3u2vpxM6dpqbSkuPp31TNoRvv+CB0Q==
X-Received: by 2002:a92:cd8d:0:b0:3d3:f7ed:c903 with SMTP id
 e9e14a558f8ab-3d97be54893mr7860785ab.0.1746137711400; 
 Thu, 01 May 2025 15:15:11 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f58871sm3346745ab.55.2025.05.01.15.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 15:15:10 -0700 (PDT)
Message-ID: <988a1b63-de48-49b3-97c2-fd202865b0e8@linaro.org>
Date: Fri, 2 May 2025 00:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 1/6] qmp: add QMP command x-query-virtio
To: Jonah Palmer <jonah.palmer@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, mst@redhat.com,
 qemu_oss@crudebyte.com, kraxel@redhat.com, si-wei.liu@oracle.com,
 joao.m.martins@oracle.com, eblake@redhat.com, qemu-block@nongnu.org,
 david@redhat.com, arei.gonglei@huawei.com, marcandre.lureau@redhat.com,
 thuth@redhat.com, michael.roth@amd.com, groug@kaod.org, dgilbert@redhat.com,
 eric.auger@redhat.com, stefanha@redhat.com, boris.ostrovsky@oracle.com,
 kwolf@redhat.com, mathieu.poirier@linaro.org, raphael.norwitz@nutanix.com,
 pbonzini@redhat.com
References: <1660220684-24909-1-git-send-email-jonah.palmer@oracle.com>
 <1660220684-24909-2-git-send-email-jonah.palmer@oracle.com>
 <6c7189cd-b6dc-e954-f39e-b90ccb6e0361@linaro.org>
 <31d76035-3b8c-c9a1-4fd3-d3cc6af5f69c@oracle.com>
 <6c917ccc-c458-3545-de73-6f9aee132b45@linaro.org>
 <87bkolrfu6.fsf@pond.sub.org>
 <fa6b712c-f785-8fc6-27a7-47f1386d51e2@oracle.com>
 <875yenmjqg.fsf@pond.sub.org>
 <3d3a1106-3a11-36e0-7446-96c338595198@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3d3a1106-3a11-36e0-7446-96c338595198@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/12/22 09:54, Jonah Palmer wrote:
> 
> On 12/7/22 08:22, Markus Armbruster wrote:
>> Jonah Palmer<jonah.palmer@oracle.com> writes:
>>
>>> On 12/2/22 10:21, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé<philmd@linaro.org>  writes:
>>>>
>>>>> On 2/12/22 13:23, Jonah Palmer wrote:
>>>>>> On 11/30/22 11:16, Philippe Mathieu-Daudé wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 11/8/22 14:24, Jonah Palmer wrote:
>>>>>>>> From: Laurent Vivier<lvivier@redhat.com>
>>>>>>>>
>>>>>>>> This new command lists all the instances of VirtIODevices with
>>>>>>>> their canonical QOM path and name.
>>>>>>>>
>>>>>>>> [Jonah: @virtio_list duplicates information that already exists in
>>>>>>>>     the QOM composition tree. However, extracting necessary information
>>>>>>>>     from this tree seems to be a bit convoluted.
>>>>>>>>
>>>>>>>>     Instead, we still create our own list of realized virtio devices
>>>>>>>>     but use @qmp_qom_get with the device's canonical QOM path to confirm
>>>>>>>>     that the device exists and is realized. If the device exists but
>>>>>>>>     is actually not realized, then we remove it from our list (for
>>>>>>>>     synchronicity to the QOM composition tree).
>>>> How could this happen?
>>>>
>>>>>>>>     Also, the QMP command @x-query-virtio is redundant as @qom-list
>>>>>>>>     and @qom-get are sufficient to search '/machine/' for realized
>>>>>>>>     virtio devices. However, @x-query-virtio is much more convenient
>>>>>>>>     in listing realized virtio devices.]
>>>>>>>>
>>>>>>>> Signed-off-by: Laurent Vivier<lvivier@redhat.com>
>>>>>>>> Signed-off-by: Jonah Palmer<jonah.palmer@oracle.com>
>>>>>>>> ---
>>>>>>>>     hw/virtio/meson.build      |  2 ++
>>>>>>>>     hw/virtio/virtio-stub.c    | 14 ++++++++
>>>>>>>>     hw/virtio/virtio.c         | 44 ++++++++++++++++++++++++
>>>>>>>>     include/hw/virtio/virtio.h |  1 +
>>>>>>>>     qapi/meson.build           |  1 +
>>>>>>>>     qapi/qapi-schema.json      |  1 +
>>>>>>>>     qapi/virtio.json           | 68 ++++++++++++++++++++++++++++++++++++++
>>>>>>>>     tests/qtest/qmp-cmd-test.c |  1 +
>>>>>>>>     8 files changed, 132 insertions(+)
>>>>>>>>     create mode 100644 hw/virtio/virtio-stub.c
>>>>>>>>     create mode 100644 qapi/virtio.json
>>>>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>>>>>> index 5d607aeaa0..bdfa82e9c0 100644
>>>>>>>> --- a/hw/virtio/virtio.c
>>>>>>>> +++ b/hw/virtio/virtio.c
>>>>>>>> @@ -13,12 +13,18 @@
>>>>>>>>       #include "qemu/osdep.h"
>>>>>>>>     #include "qapi/error.h"
>>>>>>>> +#include "qapi/qmp/qdict.h"
>>>>>>>> +#include "qapi/qapi-commands-virtio.h"
>>>>>>>> +#include "qapi/qapi-commands-qom.h"
>>>>>>>> +#include "qapi/qapi-visit-virtio.h"
>>>>>>>> +#include "qapi/qmp/qjson.h"
>>>>>>>>     #include "cpu.h"
>>>>>>>>     #include "trace.h"
>>>>>>>>     #include "qemu/error-report.h"
>>>>>>>>     #include "qemu/log.h"
>>>>>>>>     #include "qemu/main-loop.h"
>>>>>>>>     #include "qemu/module.h"
>>>>>>>> +#include "qom/object_interfaces.h"
>>>>>>>>     #include "hw/virtio/virtio.h"
>>>>>>>>     #include "migration/qemu-file-types.h"
>>>>>>>>     #include "qemu/atomic.h"
>>>>>>>> @@ -29,6 +35,9 @@
>>>>>>>>     #include "sysemu/runstate.h"
>>>>>>>>     #include "standard-headers/linux/virtio_ids.h"
>>>>>>>>     +/* QAPI list of realized VirtIODevices */
>>>>>>>> +static QTAILQ_HEAD(, VirtIODevice) virtio_list;
>>>>>>>> +
>>>>>>>>     /*
>>>>>>>>      * The alignment to use between consumer and producer parts of vring.
>>>>>>>>      * x86 pagesize again. This is the default, used by transports like PCI
>>>>>>>> @@ -3698,6 +3707,7 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>>>>>>>>         vdev->listener.commit = virtio_memory_listener_commit;
>>>>>>>>         vdev->listener.name = "virtio";
>>>>>>>>         memory_listener_register(&vdev->listener, vdev->dma_as);
>>>>>>>> +    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
>>>>>>>>     }
>>>>>>>>       static void virtio_device_unrealize(DeviceState *dev)
>>>>>>>> @@ -3712,6 +3722,7 @@ static void virtio_device_unrealize(DeviceState *dev)
>>>>>>>>             vdc->unrealize(dev);
>>>>>>>>         }
>>>>>>>>     +    QTAILQ_REMOVE(&virtio_list, vdev, next);
>>>>>>>>         g_free(vdev->bus_name);
>>>>>>>>         vdev->bus_name = NULL;
>>>>>>>>     }
>>>>>>>> @@ -3885,6 +3896,8 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>>>>>>>>         vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>>>>>>>>           vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
>>>>>>>> +
>>>>>>>> +    QTAILQ_INIT(&virtio_list);
>>>>>>>>     }
>>>>>>>>       bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>>>>>>>> @@ -3895,6 +3908,37 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>>>>>>>>         return virtio_bus_ioeventfd_enabled(vbus);
>>>>>>>>     }
>>>>>>>>     +VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>>>>>>> +{
>>>>>>>> +    VirtioInfoList *list = NULL;
>>>>>>>> +    VirtioInfoList *node;
>>>>>>>> +    VirtIODevice *vdev;
>>>>>>>> +
>>>>>>>> +    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>>>>>>>> +        DeviceState *dev = DEVICE(vdev);
>>>>>>>> +        Error *err = NULL;
>>>>>>>> +        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>>>>>>>> +
>>>>>>>> +        if (err == NULL) {
>>>>>>>> +            GString *is_realized = qobject_to_json_pretty(obj, true);
>>>>>>>> +            /* virtio device is NOT realized, remove it from list */
>>>>>>> Why not check dev->realized instead of calling qmp_qom_get() & qobject_to_json_pretty()?
>>>>>> This check queries the QOM composition tree to check that the device actually exists and is
>>>>>> realized. In other words, we just want to confirm with the QOM composition tree for the device.
>>>> Again, how could this happen?
>>>>
>>>> If @virtio_list isn't reliable, why have it in the first place?
>>> Honestly, I'm not sure how this even could happen, since the @virtio_list is managed at the realization
>>> and unrealization of a virtio device. Given this, I do feel as though the list is reliable, although
>>> this might just benaïve of me to say. After giving this a second look, the @virtio_list is only really needed to provide a nice list of all realized virtio devices
>>> on the system, along with their full canonical paths. If the user can find the canonical path of a virtio device by searching the QOM
>>> composition tree, and assuming we can get a @VirtioDevice object (in code) from this canonical path, then the rest of the QMP/HMP features of
>>> these patches could be done by solely by searching the QOM composition tree. However, I think having this list of realized virtio devices as a
>>> subset of the QOM composition tree is worth its weight, since the user no longer has to search the entire tree to find virtio devices and piece
>>> together their canonical paths. Of course, if we're somehow able to generate a similar list in code by searching the QOM composition tree,
>>> then there would be no need for this @virtio_list. However, it's really not clear how, or if, such a list could be generated by parsing the QOM
>>> composition tree.
>> I'm not debating whether to have the command right now.  I'm debating
>> the introduction of variable @virtio_list.  Please consider...
>>
>>>>>> This was done to have some kind of synchronicity between @virtio_list and the QOM composition
>>>>>> tree, since the list duplicates information that already exists in the tree.
>>>>>> This check was recommended in v10 and added in v11 of this patch series.
>>>>> Thanks, I found Markus comments:
>>>>>
>>>>> v10:
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu- 
>>>>> devel/87ee6ogbiw.fsf@dusky.pond.sub.org/__;!!ACWV5N9M2RV99hQ! 
>>>>> LqeLFhE8PtTTg_qKRuP9Kgz5pyTNZLhYeRzp4a2oS8c3D5W8- 
>>>>> irZoBW0L_Lf1ozm3qYidYhuVrjxjsAw$  
>> ... this:
>>
>>>> My recommendation there was to *delete* virtio_list and search the QOM
>>>> composition tree instead:
>>>>
>>>>       @virtio_list duplicates information that exists in the QOM composition
>>>>       tree.  It needs to stay in sync.  You could search the composition tree
>>>>       instead.
>>>>
>>>> The QOM composition tree is the source of truth.
>> Let me tell you a tale of two patches.
>>
>> One created a niche QMP command.  It also modified core infrastructure
>> to keep additional state.  State that needed to be kept consistent with
>> existing state forever.  Consistency was not entirely obvious.  The
>> command examined this new state.  The examination was simple.
>>
>> The other one created a niche QMP command, and nothing more.  The
>> command examined state without changing it.  The examination was
>> less simple.

And 3 years later I hit this niche command while trying to remove a
legacy field...

commit 4987e5bf2e9262094fd89d2b8e4d5bd6c4c7312f

+    /**
+     * @use_started: true if the @started flag should be used to check
+     * the current state of the VirtIO device. Otherwise status bits
+     * should be checked for a current status of the device.
+     * @use_started is only set via QMP and defaults to true for all
+     * modern machines (since 4.1).
+     */

(we are removing all machines up to 4.0)

>>
>> One of the two patches had a much easier time in review.  Which one
>> could it be...
>>
>> Please give the other approach a serious try.
> 
> Ah, okay. I see where you're getting at.
> 
> Sure, I can give this approach a try and see what I can do with it.
> Just FYI, I wont be able to get to this right away until sometime early
> next year.
> 
> Jonah
> 
>> [...]
>>


