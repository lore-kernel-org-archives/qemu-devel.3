Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBEEC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wox0r-0003Ru-Ix; Wed, 29 Jul 2026 01:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wox0o-0003Rb-Kf
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 01:39:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wox0l-0004ls-G4
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 01:39:26 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66T5dGje092876
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Jul 2026 14:39:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dZDrbavuorXu3BfDTGC8Wkoa/lK+ghlocZ3VbuNWvKI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785303557; v=1;
 b=gGRLyQL34U6OFQ+CXNQFINLI9wGqzir499n3ROz8EyEeHE0Oh4cO12dcP3gcidBo
 MtBshtLN+tI/78+C+92N50ZKiiNYVFh3SaQk1tJdDYEYuklG6AZZ2FdYlJSr6vgb
 dCD18IYrj47So5uzVaE/p4Jt8nGXklEwsupT2ETkQuIkWcNLemm0XBtBhnLf4r6d
 dlO51glRDpIUPL7NGLoBfsu3M2AYoidV2LwC6XGSMuEVQAsHxFSI8WgsvVMwF14F
 jgM+vwWYEqy0waWW0EOTHpFjTq3MmHnXiz4sb7m+X5RIlxUoCvX6jJoV3GSNWmF3
 +cyegS0okqv8y+dT9X3S2Q==
Message-ID: <668cf7c5-7b46-4780-9e86-5d449b912ef6@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Jul 2026 14:39:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: use g_try_malloc to avoid guest-triggered
 abort
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260728101523.3041854-1-marcandre.lureau@redhat.com>
 <a661b28d-8656-4e27-8038-e7b360e550b8@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvazu9g-M7EvHZAS3_Wbd0m0s8p0BuZbwLJZm9XBuEbrhBg@mail.gmail.com>
 <6192257c-a6cc-4309-a3e2-be86ef0b3904@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvawYy4YKwyH6CD0f9PwYQ=Zi01NjxLF0VcPRoiGPrvwjDw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAMxuvawYy4YKwyH6CD0f9PwYQ=Zi01NjxLF0VcPRoiGPrvwjDw@mail.gmail.com>
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

On 2026/07/29 7:03, Marc-André Lureau wrote:
> Hi Akihiko
> 
> On Tue, Jul 28, 2026 at 11:17 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/07/28 23:33, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Tue, Jul 28, 2026 at 6:28 PM Akihiko Odaki
>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>
>>>> On 2026/07/28 19:15, marcandre.lureau@redhat.com wrote:
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
>>>>> returns an error to the guest rather than crashing the host (glib
>>>>> behaviour).
>>>>>
>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
>>>>>
>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>> Based-on: <20260710134720.2317856-1-marcandre.lureau@redhat.com> ("[PATCH] vhost-user-gpu: fix integer overflow in buffer allocation")
>>>>> v2:
>>>>>     - accept NULL 0-size allocations
>>>>> ---
>>>>>     contrib/vhost-user-gpu/vhost-user-gpu.c | 25 +++++++++++++++++--------
>>>>>     contrib/vhost-user-gpu/virgl.c          |  6 +++++-
>>>>>     contrib/vhost-user-gpu/vugbm.c          |  5 ++++-
>>>>>     hw/display/virtio-gpu-rutabaga.c        | 14 ++++++++++++--
>>>>>     hw/display/virtio-gpu-virgl.c           |  6 +++++-
>>>>>     hw/display/virtio-gpu.c                 |  5 ++++-
>>>>>     6 files changed, 47 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
>>>>> index ee9858c397ce..0fd115300425 100644
>>>>> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
>>>>> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
>>>>> @@ -487,7 +487,7 @@ vg_create_mapping_iov(VuGpu *g,
>>>>>                           struct virtio_gpu_ctrl_command *cmd,
>>>>>                           struct iovec **iov)
>>>>>     {
>>>>> -    struct virtio_gpu_mem_entry *ents;
>>>>> +    g_autofree struct virtio_gpu_mem_entry *ents = NULL;
>>>>>         size_t esize, s;
>>>>>         int i;
>>>>>
>>>>> @@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
>>>>>         }
>>>>>
>>>>>         esize = sizeof(*ents) * ab->nr_entries;
>>>>> -    ents = g_malloc(esize);
>>>>> +    ents = g_try_malloc(esize);
>>>>> +    if (!ents && esize) {
>>>>> +        return -1;
>>>>> +    }
>>>>>         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>>>>>                        sizeof(*ab), ents, esize);
>>>>>         if (s != esize) {
>>>>>             g_critical("%s: command data size incorrect %zu vs %zu",
>>>>>                        __func__, s, esize);
>>>>> -        g_free(ents);
>>>>>             return -1;
>>>>>         }
>>>>>
>>>>> -    *iov = g_new0(struct iovec, ab->nr_entries);
>>>>> +    *iov = g_try_new0(struct iovec, ab->nr_entries);
>>>>> +    if (!*iov && ab->nr_entries) {
>>>>> +        return -1;
>>>>> +    }
>>>>>         for (i = 0; i < ab->nr_entries; i++) {
>>>>>             uint64_t len = ents[i].length;
>>>>>             (*iov)[i].iov_len = ents[i].length;
>>>>> @@ -517,12 +522,10 @@ vg_create_mapping_iov(VuGpu *g,
>>>>>                 g_critical("%s: resource %d element %d",
>>>>>                            __func__, ab->resource_id, i);
>>>>>                 g_free(*iov);
>>>>> -            g_free(ents);
>>>>>                 *iov = NULL;
>>>>>                 return -1;
>>>>>             }
>>>>>         }
>>>>> -    g_free(ents);
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> @@ -828,8 +831,14 @@ vg_resource_flush(VuGpu *g,
>>>>>                     PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)) / 8;
>>>>>                 size_t size = width * height * bpp;
>>>>>
>>>>> -            void *p = g_malloc(VHOST_USER_GPU_HDR_SIZE +
>>>>> -                               sizeof(VhostUserGpuUpdate) + size);
>>>>> +            void *p = g_try_malloc(VHOST_USER_GPU_HDR_SIZE +
>>>>> +                                   sizeof(VhostUserGpuUpdate) + size);
>>>>> +            if (!p) {
>>>>> +                pixman_region_fini(&region);
>>>>> +                pixman_region_fini(&finalregion);
>>>>> +                cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>>>> +                break;
>>>>> +            }
>>>>>                 VhostUserGpuMsg *msg = p;
>>>>>                 msg->request = VHOST_USER_GPU_UPDATE;
>>>>>                 msg->size = sizeof(VhostUserGpuUpdate) + size;
>>>>> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
>>>>> index 550fd03bf5c4..20bae57d0fe4 100644
>>>>> --- a/contrib/vhost-user-gpu/virgl.c
>>>>> +++ b/contrib/vhost-user-gpu/virgl.c
>>>>> @@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
>>>>>             return;
>>>>>         }
>>>>>
>>>>> -    buf = g_malloc(cs.size);
>>>>> +    buf = g_try_malloc(cs.size);
>>>>> +    if (!buf && cs.size) {
>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>>>> +        return;
>>>>> +    }
>>>>>         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>>>>>                        sizeof(cs), buf, cs.size);
>>>>>         if (s != cs.size) {
>>>>> diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
>>>>> index 710d54529779..e2d8385fd857 100644
>>>>> --- a/contrib/vhost-user-gpu/vugbm.c
>>>>> +++ b/contrib/vhost-user-gpu/vugbm.c
>>>>> @@ -13,7 +13,10 @@
>>>>>     static bool
>>>>>     mem_alloc_bo(struct vugbm_buffer *buf)
>>>>>     {
>>>>> -    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);
>>>>> +    buf->mmap = g_try_malloc((uint64_t)buf->width * buf->height * 4);
>>>>> +    if (!buf->mmap && buf->width && buf->height) {
>>>>> +        return false;
>>>>> +    }
>>>>>         buf->stride = buf->width * 4;
>>>>>         return true;
>>>>>     }
>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>>>> index e28aad94eead..60f64d9a8fa7 100644
>>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>>> @@ -360,10 +360,20 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
>>>>>             return;
>>>>>         }
>>>>>
>>>>> -    buf = g_new0(uint8_t, cs.size);
>>>>> +    buf = g_try_new0(uint8_t, cs.size);
>>>>> +    if (!buf && cs.size) {
>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>>>> +        return;
>>>>> +    }
>>>>>         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>>>>>                        sizeof(cs), buf, cs.size);
>>>>> -    CHECK(s == cs.size, cmd);
>>>>> +    if (s != cs.size) {
>>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>>> +                      "%s: size mismatch (%zu/%u)\n",
>>>>> +                      __func__, s, cs.size);
>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>>>>> +        return;
>>>>> +    }
>>>>>
>>>>>         rutabaga_cmd.ctx_id = cs.hdr.ctx_id;
>>>>>         rutabaga_cmd.cmd = buf;
>>>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>>>> index d9e5b0110497..028ab776df6a 100644
>>>>> --- a/hw/display/virtio-gpu-virgl.c
>>>>> +++ b/hw/display/virtio-gpu-virgl.c
>>>>> @@ -615,7 +615,11 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
>>>>>             return;
>>>>>         }
>>>>>
>>>>> -    buf = g_malloc(cs.size);
>>>>> +    buf = g_try_malloc(cs.size);
>>>>> +    if (!buf && cs.size) {
>>>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>>>>> +        return;
>>>>> +    }
>>>>>         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>>>>>                        sizeof(cs), buf, cs.size);
>>>>>         if (s != cs.size) {
>>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>>>> index 8607d0c0b581..9bacd38b4521 100644
>>>>> --- a/hw/display/virtio-gpu.c
>>>>> +++ b/hw/display/virtio-gpu.c
>>>>> @@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>>>>         }
>>>>>
>>>>>         esize = sizeof(*ents) * nr_entries;
>>>>> -    ents = g_malloc(esize);
>>>>> +    ents = g_try_malloc(esize);
>>>>> +    if (!ents && esize) {
>>>>> +        return -1;
>>>>> +    }
>>>>
>>>> This converts the entry allocation to g_try_malloc(), but the resulting
>>>> mapping arrays still grow with aborting g_renew() calls.
>>>> dma_memory_map() may return only part of an entry; with fragmented IOMMU
>>>> mappings, guest-controlled entries can expand into more IOVs than
>>>> nr_entries.
>>>>
>>>
>>> The goal is not to make QEMU OOM-safe. Even when malloc returns
>>> non-zero we may reach that and get killed. This patch is more a safety
>>> guard for easy guest triggered allocations that can crash QEMU.
>> I agree we are not going to make QEMU OOM-safe, but I'm not sure where
>> we draw the line between "easy" and "hard" guest-triggered allocations.
>> Even if the IOMMU mapping isn't fragmented, the data from ents is
>> essentially duplicated into iov right after, doubling the allocation
>> size anyway. I feel it's easier to avoid reasoning by just consistently
>> using g_try_* in this function.
> 
> 
> Ok, maybe it doesn't make sense for bounded-allocation to use g_try
> then. It's true that if the IOMMU mapping is fragmented, we could end
> up with an allocation that could fail. I am not sure we can do much in
> this case but rather have a reasonable limit like
> VIRTIO_GPU_MAX_IOV_ENTRIES (16384 * 16). Otherwise, happy to convert
> to g_try_renew() for now..

I'm not sure what a reasonable limit would be. With fully fragmented 4 
KiB mappings, 16384 * 16 IOVs represent only 1 GiB of backing.

The bound in [1] applies only to non-virgl blobs. This mapping code is 
also used for virgl resource backing. Such resources are not limited to 
framebuffers and may be used for accelerated rendering or compute, so 
there is no similarly obvious size bound.

There is already an RFC patch to remove the 16384-entry limit for GPGPU 
workloads [2], so we may not derive a new limit from that value.

[1] 
https://lore.kernel.org/qemu-devel/20260727-blob-v2-1-d0b9af38a975@rsg.ci.i.u-tokyo.ac.jp/
[2] 
https://lore.kernel.org/qemu-devel/20260116084409.326062-3-honghuan@amd.com/

Regards,
Akihiko Odaki

