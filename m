Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E55C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Df0-0005Od-Jv; Wed, 09 Sep 2026 04:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4Dew-0005OG-Ne; Wed, 09 Sep 2026 04:27:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4Det-0001ml-Ah; Wed, 09 Sep 2026 04:27:58 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6898QtSV043268
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2026 17:26:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VPL8g6uLD1yPL2YmofawdaPYaSFwuyZbuSjzi9oSH/w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788942415; v=1;
 b=ZH2RaJ7vZQCqdV5WbzB8Vnbji508XEzzAHyBH/VeK2TZFn4P1kzv6lVKRRimwl+W
 CP58IVl9MCPqU2114OVE56G8sjB1X1ml6NehVYuQECOrYoUnmukinRdtlKmmyyAZ
 t1XN7bo84A45WSy+Sufj4GmX7CygSY4bUI8znVrIpqWUmgPoP70+GheiL9s/vrgk
 lm22c13Z+Y8akTgiJoYfePTz9X/C+Y6hUA7d6hK3ZT5o7O5GLJG+HMjUOlfmhqE/
 vFxDtPRBoiAu6nLlif3pOkQ7Cfc1zChE7GZqnW+aIJzH+D+W3wxOtxcNYKGwNt9E
 eKpRB9u8oN9/RL7Sz4M6lw==
Message-ID: <9740a849-8c34-4465-a1af-48a7fedd12e7@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Sep 2026 17:26:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] hw/display/virtio-gpu: Fix fenced blob unmapping
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <20260908-gpu-v3-6-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1C+QiHZ3Pp3Q_Dy=KCzR=UCWpYAosdQxVaqgLTnQudkVeg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+QiHZ3Pp3Q_Dy=KCzR=UCWpYAosdQxVaqgLTnQudkVeg@mail.gmail.com>
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

On 2026/09/08 19:27, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Sep 8, 2026 at 10:14 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> Blob unmapping may be suspended because of remaining uses of the
>> mapping. virtio_gpu_process_cmdq() uses the following condition to
>> detect a suspended command:
>>
>>      !cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)
>>
>> However, the guest may set VIRTIO_GPU_FLAG_FENCE for a command that
>> performs blob unmapping. Such a command will be incorrectly assumed
>> as not being suspended. Add a dedicated flag for the suspended state
>> to avoid overloading VIRTIO_GPU_FLAG_FENCE.
>>
>> Fixes: 640f9149c3dc ("virtio-gpu: Support suspension of commands processing")
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   include/hw/virtio/virtio-gpu.h |  1 +
>>   hw/display/virtio-gpu-virgl.c  | 17 +++++++----------
>>   hw/display/virtio-gpu.c        |  5 ++---
>>   3 files changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>> index 9404e488208a..3eccc4bc39c3 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -141,6 +141,7 @@ struct virtio_gpu_ctrl_command {
>>       struct virtio_gpu_ctrl_hdr cmd_hdr;
>>       uint32_t error;
>>       bool finished;
>> +    bool suspended;
> 
>>       QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
>>   };
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index 9bda572426b2..c37df91e3ed1 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -440,8 +440,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
>>   }
>>
>>   static void virgl_cmd_resource_unref(VirtIOGPU *g,
>> -                                     struct virtio_gpu_ctrl_command *cmd,
>> -                                     bool *cmd_suspended)
>> +                                     struct virtio_gpu_ctrl_command *cmd)
>>   {
>>       struct virtio_gpu_resource_unref unref;
>>       struct virtio_gpu_virgl_resource *res;
>> @@ -457,7 +456,7 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>>           return;
>>       }
>>
>> -    virtio_gpu_virgl_resource_unref(g, res, cmd_suspended);
>> +    virtio_gpu_virgl_resource_unref(g, res, &cmd->suspended);
>>   }
>>
>>   void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
>> @@ -946,8 +945,7 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
>>   }
>>
>>   static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
>> -                                          struct virtio_gpu_ctrl_command *cmd,
>> -                                          bool *cmd_suspended)
>> +                                          struct virtio_gpu_ctrl_command *cmd)
>>   {
>>       struct virtio_gpu_resource_unmap_blob ublob;
>>       struct virtio_gpu_virgl_resource *res;
>> @@ -964,7 +962,7 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
>>           return;
>>       }
>>
>> -    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
>> +    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, &cmd->suspended);
>>       if (ret) {
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           return;
>> @@ -1036,7 +1034,6 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>>   void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>                                         struct virtio_gpu_ctrl_command *cmd)
>>   {
>> -    bool cmd_suspended = false;
>>       int ret;
>>
>>       VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>> @@ -1080,7 +1077,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>           virgl_cmd_resource_flush(g, cmd);
>>           break;
>>       case VIRTIO_GPU_CMD_RESOURCE_UNREF:
>> -        virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
>> +        virgl_cmd_resource_unref(g, cmd);
>>           break;
>>       case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
>>           /* TODO add security */
>> @@ -1110,7 +1107,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>           virgl_cmd_resource_map_blob(g, cmd);
>>           break;
>>       case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
>> -        virgl_cmd_resource_unmap_blob(g, cmd, &cmd_suspended);
>> +        virgl_cmd_resource_unmap_blob(g, cmd);
>>           break;
>>       case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
>>           virgl_cmd_set_scanout_blob(g, cmd);
>> @@ -1121,7 +1118,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>           break;
>>       }
>>
>> -    if (cmd_suspended || cmd->finished) {
>> +    if (cmd->suspended || cmd->finished) {
>>           return;
>>       }
>>       if (cmd->error) {
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index d520f69e6453..dd6c09d1ddcf 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1193,11 +1193,10 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>>               break;
>>           }
>>
>> -        /* process command */
>> +        cmd->suspended = false;
> 
> The field could be initialized after virtqueue_pop(), otherwise it has
> a random allocation value. Then perhaps, drop this assignment?

The assignment is needed before every processing attempt, including
retries. A suspended command stays at the head of cmdq and is processed
again when unmapping can complete. The unmap helper sets suspended to
true when waiting, but does not clear it on completion. Initializing it
only after virtqueue_pop() would leave it true on retry, preventing the
command from completing and blocking subsequent commands.

The field is uninitialized immediately after allocation, but nothing
reads it before this assignment, so there is no uninitialized read.

Regards,
Akihiko Odaki

> 
>>           vgc->process_cmd(g, cmd);
>>
>> -        /* command suspended */
>> -        if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
>> +        if (cmd->suspended) {
>>               trace_virtio_gpu_cmd_suspended(cmd->cmd_hdr.type);
>>               break;
>>           }
>>
>> --
>> 2.55.0
>>
>>


