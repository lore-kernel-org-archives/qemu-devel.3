Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33609C79FB8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4EgY-0000nK-2K; Wed, 09 Sep 2026 05:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4EgX-0000nC-0R
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:33:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4EgV-0002G7-4O
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:33:40 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6899XVfa069177
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2026 18:33:31 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=y06twJOXrc59ROXVfy9bxW5xZ37E2igKJckwZBiGKk0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788946411; v=1;
 b=Q2Psh4U8k8+/Ce8JAKgYcEiWz5GLun/Hx+Tf7Tx4PYRcHhhBy5ExjxOUnlI+NY6z
 5TKaXZqy0/TWyZsrM4LJ7GZUkrhnSm8Hv5g4KJ8CpyyyGY6YJZ7h9JYQ9H92HeXr
 rePvd/3gbfE/iy6NlBJtMKOPCzVV55XakGwtwFBbaMsY/uReLOaPQ/j7IUUCodxr
 JMcmZHKRosb6505jmNyQLxfryZLEAYz8Rayxy3hB+iqkghgS6GUM/3/CFCSmoK87
 ZIAklb7c7CIS0XuQN1/3YgZ04Nd+nLXi/T747YcLKrFh3d0i8gEW8f3DzL2/seGu
 1G6gydN6x5osOIDPQQyL2w==
Message-ID: <6bed3d15-8d76-4802-b335-0615131e3572@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Sep 2026 18:33:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/25] virtio-gpu: consolidate disabling scanout
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-20-15b5ae6b0023@redhat.com>
 <0699b5e3-23de-4199-9689-c5b98a7c4583@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1C+Ymzre7AdX=Gy66YL_OHwAgH9e06qqMNxLCvJNbt0kpA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+Ymzre7AdX=Gy66YL_OHwAgH9e06qqMNxLCvJNbt0kpA@mail.gmail.com>
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

On 2026/09/08 19:42, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Sep 8, 2026 at 10:46 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/09/04 22:10, Marc-André Lureau wrote:
>>> Use the common virtio_gpu_disable_scanout() to reset the scanout state,
>>> including GL state if any.
>>>
>>> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/display/virtio-gpu-rutabaga.c | 4 +---
>>>    hw/display/virtio-gpu-virgl.c    | 6 ++----
>>>    hw/display/virtio-gpu.c          | 7 +++++--
>>>    3 files changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>> index 8a82e96b7461..8697dd6936ba 100644
>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>> @@ -312,9 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>>        scanout = &vb->scanout[ss.scanout_id];
>>>
>>>        if (ss.resource_id == 0) {
>>> -        scanout->resource_id = 0;
>>> -        qemu_console_set_surface(scanout->con, NULL);
>>> -        qemu_console_gl_scanout_disable(scanout->con);
>>> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
>>>            return;
>>>        }
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 79d4c0b569fb..87d1fc3d5f65 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -618,8 +618,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>>>                ss.r.x, ss.r.y, ss.r.width, ss.r.height,
>>>                d3d_tex2d);
>>>        } else {
>>> -        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].con, NULL);
>>> -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scanout_id].con);
>>> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
>>>        }
>>>        g->parent_obj.scanout[ss.scanout_id].resource_id = ss.resource_id;
>>>    }
>>> @@ -1426,8 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>>>        int i;
>>>
>>>        for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
>>> -        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
>>> -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con);
>>> +        virtio_gpu_disable_scanout(g, i);
>>>        }
>>>    }
>>>
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index ae1f87ad68b2..cb096cb349cd 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -435,8 +435,11 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>>>    {
>>>        struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
>>>
>>> -    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
>>> -
>>> +    if (scanout->dmabuf) {
>>> +        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
>>> +    } else {
>>> +        qemu_console_gl_scanout_disable(scanout->con);
>>> +    }
>>
>> GL needs to be always disabled when clearing a scanout.
>>
> 
> Ok, I removed the else condition.
> 
> Are you going to review the remaining 1-23 patches?
> thanks

I reviewed them all. I have comments for "[PATCH v2 02/25] virtio-gpu: 
fix use-after-free on blob cursor after detach". The other patches look 
good to me.

Regards,
Akihiko Odaki

