Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A1AC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DvW-0002kd-10; Wed, 09 Sep 2026 04:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4DvT-0002jr-Ar; Wed, 09 Sep 2026 04:45:03 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4DvQ-0003RS-I9; Wed, 09 Sep 2026 04:45:03 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6898iCdm050419
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2026 17:44:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=s/KjUcmqZojjrkD/PSgVC5X4OhNmtHu3r8VVzaolkSM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788943452; v=1;
 b=gsGW/npqKBWKUuLjWUYccpfGQBnvrCEnjUMpIgKuS77qdnfSvaMYwibdeEwglK4f
 SHiG4+r79GC7TprLHwjwQffBSw6jOVDMnw+tWd6syfxENac9tyacYw1auYoGCFSt
 /pBSQRbb4EcHFPgTouoXBw5hZrjZ3Gf07s+P5LtHrqamnS/+QxsYheWsGPK56Okf
 9OUWiAhCEBDug4CAh0aIFGKg4D3b+UpwBIOz4VvjV1xx3wJIHk7udy23qTm71xQi
 +tjCnYuiSzx4IxjkRSOkyit9sOVi6EBDOkSc9q9S6RegjLKZBfXBNobihMU2sEiK
 Zd3Q1aJZe5uQyOryObPiIA==
Message-ID: <d1cf90f1-d759-42ae-bb97-e5e70ec7a845@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Sep 2026 17:44:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] virtio: Introduce virtio_complete_reset()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <20260908-gpu-v3-1-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <20260908143611.GB1016680@fedora>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908143611.GB1016680@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/09/08 23:36, Stefan Hajnoczi wrote:
> On Tue, Sep 08, 2026 at 03:11:18PM +0900, Akihiko Odaki wrote:
>> Introduce virtio_complete_reset() as preparation to allow asynchronous
>> reset. It is unconditionally called in virtio_reset(), but a follow-up
>> change moves the call to each device implementation.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   include/hw/virtio/virtio.h |  1 +
>>   hw/virtio/virtio.c         | 14 +++++++++++---
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index c99cb19d8865..1431be1389f2 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -507,6 +507,7 @@ int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
>>                                         MemoryRegion *mr, bool assign);
>>   int virtio_set_status(VirtIODevice *vdev, uint8_t val);
>>   void virtio_reset(VirtIODevice *vdev);
>> +void virtio_complete_reset(VirtIODevice *vdev);
>>   void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
>>   void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
>>   void virtio_update_irq(VirtIODevice *vdev);
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index daa5607338c9..8d5f58a02df6 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -3423,11 +3423,10 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
>>   void virtio_reset(VirtIODevice *vdev)
>>   {
>>       VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>> -    VirtioSharedMemory *shmem;
>> -    uint64_t features[VIRTIO_FEATURES_NU64S];
>> -    int i;
>>   
>>       virtio_set_status(vdev, 0);
>> +    vdev->status = VIRTIO_CONFIG_S_FAILED;
> 
> Why is the VIRTIO Device Status Register set to FAILED during reset?
> I don't see this in the VIRTIO specification.

The intent is to keep the status nonzero until virtio_complete_reset() 
finishes the reset. Any bit would work, but I chose FAILED because it 
looks saner than other options; the bit indicates that the guest is not 
going to interact with the device until the reset completes, which is 
indeed the case.

Regards,
Akihiko Odaki

> 
>> +
>>       if (current_cpu) {
>>           /* Guest initiated reset */
>>           vdev->device_endian = virtio_current_cpu_endian();
>> @@ -3448,6 +3447,15 @@ void virtio_reset(VirtIODevice *vdev)
>>           k->reset(vdev);
>>       }
>>   
>> +    virtio_complete_reset(vdev);
>> +}
>> +
>> +void virtio_complete_reset(VirtIODevice *vdev)
>> +{
>> +    VirtioSharedMemory *shmem;
>> +    uint64_t features[VIRTIO_FEATURES_NU64S];
>> +    int i;
>> +
>>       vdev->start_on_kick = false;
>>       vdev->started = false;
>>       vdev->broken = false;
>>
>> -- 
>> 2.55.0
>>


