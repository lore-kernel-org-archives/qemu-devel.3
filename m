Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7E1EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxP2N-0008Ur-Mk; Tue, 03 Mar 2026 07:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxP2K-0008Ud-Bl
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:39:40 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxP2G-0007pj-Q1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:39:39 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 623CceIh013122
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 21:39:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GEuwGv1Ej8RLG65zCcN4Z24FTFQJvXtnO1JEtFPe54A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772541565; v=1;
 b=tZEcehg9OfeZXuYwiAEnBt3EacC0MqzvHHaAEHTJdfqUL/dsJaX+PvMG1s5RB4Pj
 a0XQFGWjUkAT8UbmGxoYlr/MgTrJtFH6EpsZWj3jSmFZeJFLCuHa0jhq3H7bM/Sw
 Lw37Sv42VsTlzxXLeBImaPaiNeg6QMENe0tK4tzZGzh5WQ7ciko2otQ50pn+mTFq
 wlRZDURZlopn1fqsiu3hajZt1p6NYmLAs2O8HnPA+rESdaJivRxhXucLQBLnwkV4
 Bb18KMzVwkm6bYE+cPkYajWziIn4yQOc3zt2g5maFnDdhbHGcgWmnOU2qmvjsQYX
 ENunshQ9TGS/xCiUk4KKKA==
Message-ID: <e426ccd0-cc9d-4ccf-bc48-cb441ead0e86@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Mar 2026 21:38:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: Do not wait for the main thread during reset
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp>
 <87pl5laybu.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <87pl5laybu.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/03 21:31, Alex Bennée wrote:
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
> 
>> virtio-gpu waits for the main thread to destroy resources and replace
>> surfaces, but it occasionally results in deadlock, so remove the code
>> to wait.
>>
>> In particular, when running a test case[1] the main thread may wait for
>> the vCPUs to pause during shut down while a vCPU may be concurrently
>> resetting virtio-gpu.
>>
>> vCPU actually does not need to perform resource destruction and surface
>> replacement synchronously, but it only needs to ensure correct ordering
>> among virtio-gpu operations. virtio-gpu-gl already exploits this fact to
>> ensure that virglrenderer is reset on the main thread; instead of
>> synchronously resetting virglrenderer when the device is being reset,
>> it resets virglrenderer just before processing the first command after
>> the device reset arrives.
>>
>> Take advantage of this fact by simply removing synchronization between
>> the main thread and the resetting vCPU thread. The request to destroy
>> resources and replace surfaces is scheduled earlier than any virtio-gpu
>> command that may be queued after resetting ensures correct ordering, so
>> we do not need to make additional effort to ensure ordering.
>>
>> [1]
>> https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/
> 
> This doesn't seem to make any difference for me with the current state
> of the tree.

It depends on timing, so perhaps it may not be repdocued on some 
environments.

> 
>>
>> Fixes: a41e2d97f92b ("virtio-gpu: reset gfx resources in main thread")
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   include/hw/virtio/virtio-gpu.h | 2 --
>>   hw/display/virtio-gpu.c        | 9 ---------
>>   2 files changed, 11 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>> index 9f16f89a36d2..77d2214238df 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -193,8 +193,6 @@ struct VirtIOGPU {
>>       QEMUBH *ctrl_bh;
>>       QEMUBH *cursor_bh;
>>       QEMUBH *reset_bh;
>> -    QemuCond reset_cond;
>> -    bool reset_finished;
>>   
>>       QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>>       QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 3a555125be60..1294e1d482ed 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1522,7 +1522,6 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>>       g->ctrl_bh = virtio_bh_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
>>       g->cursor_bh = virtio_bh_new_guarded(qdev, virtio_gpu_cursor_bh, g);
>>       g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
>> -    qemu_cond_init(&g->reset_cond);
>>       QTAILQ_INIT(&g->reslist);
>>       QTAILQ_INIT(&g->cmdq);
>>       QTAILQ_INIT(&g->fenceq);
>> @@ -1535,7 +1534,6 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
>>       g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
>>       g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
>>       g_clear_pointer(&g->reset_bh, qemu_bh_delete);
>> -    qemu_cond_destroy(&g->reset_cond);
>>       virtio_gpu_base_device_unrealize(qdev);
>>   }
>>   
>> @@ -1565,9 +1563,6 @@ static void virtio_gpu_reset_bh(void *opaque)
>>       for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
>>           dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
>>       }
>> -
>> -    g->reset_finished = true;
>> -    qemu_cond_signal(&g->reset_cond);
>>   }
>>   
>>   void virtio_gpu_reset(VirtIODevice *vdev)
>> @@ -1576,11 +1571,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>>       struct virtio_gpu_ctrl_command *cmd;
>>   
>>       if (qemu_in_vcpu_thread()) {
>> -        g->reset_finished = false;
>>           qemu_bh_schedule(g->reset_bh);
>> -        while (!g->reset_finished) {
>> -            qemu_cond_wait_bql(&g->reset_cond);
>> -        }
>>       } else {
>>           aio_bh_call(g->reset_bh);
>>       }
>>
>> ---
>> base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
>> change-id: 20251029-gpu-c3f45747f7ba
>>
>> Best regards,
> 


