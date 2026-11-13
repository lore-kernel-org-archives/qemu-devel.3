Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF17606A33F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=uR4Ow0ut
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xS16d-0000yW-De; Fri, 13 Nov 2026 18:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xS16a-0000wF-Lm
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 18:54:53 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xS16W-0007B9-Gk
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 18:54:52 -0500
Received: from [172.31.11.120] (m85.aaa.bbb.ccc.bctel.net [209.52.143.85] (may
 be forged)) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ADNsa2F040351
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 14 Nov 2026 08:54:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=aZ1WawsCISDemwOoHOqHd7q2/JRcnlH5KJamL7fPwVk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1794614078; v=1;
 b=uR4Ow0utJAPWPISxSY2Pg3AlNjWVun9/0XcPFwkatnnRHqnToZzk7nAtn2VAwzSf
 cu08Ye+jCv138N8P7vubR1Q2wygvps0cX9LfwE7jWsx8jMJHsh7Vjn22ChPS8Iik
 OUwUhIJdAi2scP9gfTqTaQkvU4UwTImTSk1jtTuG935ilkdhw4oIBuUH3E/makFN
 WgDqlFTw6OS/BR5/LKIOmU8ib+HfYysa9NhIi92k0RlknnVRTmXJZndRxXAiwtGB
 n/GPzLDlEbvNfFmEr+UPZGbVYaX7Zh9NFt2Ua+pWWdt1bCbIVuqJTZClD5rcjU3a
 BL/9CP9FqnqISAc3FEJwVw==
Message-ID: <23ed503d-01ed-4ef4-96d2-e31ca00d4bd9@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 13 Nov 2026 16:54:36 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] hw/display/vhost-user-gpu: reset scanouts on the
 main loop
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry@taktcycles.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
 <20261113-issue-4848-v3-4-98e4fa3e77eb@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261113-issue-4848-v3-4-98e4fa3e77eb@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/13 9:29, Marc-André Lureau wrote:
> vhost_user_gpu_reset() runs on the vCPU thread when the guest writes the
> device status. Installing the placeholder surface there calls the
> display listener without the EGL context being current, so the D-Bus
> listener receives a surface without a texture and aborts on the tex_id
> assertion.
> 
> Defer the display cleanup to a bottom half, as virtio_gpu_reset() does,
> and wait for it when reset is triggered from a vCPU thread.

This suffers from the same issue the following patch series addresses:
https://lore.kernel.org/qemu-devel/20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH v3 0/9] virtio-gpu: Do not wait for the main thread during reset")

Regards,
Akihiko Odaki

> 
> Reported-by: Dmitry R <rdmitry@taktcycles.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vhost-user-gpu.c    | 39 +++++++++++++++++++++++++++++++++++++--
>   include/hw/virtio/virtio-gpu.h |  4 ++++
>   2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index d3b720d08a73..46e7fc136583 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -18,6 +18,7 @@
>   #include "chardev/char-fe.h"
>   #include "qapi/error.h"
>   #include "migration/blocker.h"
> +#include "system/cpus.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
>   typedef enum VhostUserGpuRequest {
> @@ -635,9 +636,9 @@ vhost_user_gpu_instance_finalize(Object *obj)
>   }
>   
>   static void
> -vhost_user_gpu_reset(VirtIODevice *vdev)
> +vhost_user_gpu_reset_bh(void *opaque)
>   {
> -    VhostUserGPU *g = VHOST_USER_GPU(vdev);
> +    VhostUserGPU *g = VHOST_USER_GPU(opaque);
>       int i;
>   
>       /* release the scanouts before virtio_gpu_base_reset() drops ds */
> @@ -653,6 +654,25 @@ vhost_user_gpu_reset(VirtIODevice *vdev)
>           qemu_console_set_surface(scanout->con, NULL);
>       }
>   
> +    g->reset_finished = true;
> +    qemu_cond_signal(&g->reset_cond);
> +}
> +
> +static void
> +vhost_user_gpu_reset(VirtIODevice *vdev)
> +{
> +    VhostUserGPU *g = VHOST_USER_GPU(vdev);
> +
> +    if (qemu_in_vcpu_thread()) {
> +        g->reset_finished = false;
> +        qemu_bh_schedule(g->reset_bh);
> +        while (!g->reset_finished) {
> +            qemu_cond_wait_bql(&g->reset_cond);
> +        }
> +    } else {
> +        aio_bh_call(g->reset_bh);
> +    }
> +
>       virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>   
>       vhost_user_backend_stop(g->vhost);
> @@ -699,9 +719,23 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
>           return;
>       }
>   
> +    g->reset_bh = virtio_bh_io_new_guarded(qdev, vhost_user_gpu_reset_bh, g);
> +    qemu_cond_init(&g->reset_cond);
> +
>       g->vhost_gpu_fd = -1;
>   }
>   
> +static void
> +vhost_user_gpu_device_unrealize(DeviceState *qdev)
> +{
> +    VhostUserGPU *g = VHOST_USER_GPU(qdev);
> +
> +    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> +    qemu_cond_destroy(&g->reset_cond);
> +
> +    virtio_gpu_base_device_unrealize(qdev);
> +}
> +
>   static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
>   {
>       VhostUserGPU *g = VHOST_USER_GPU(vdev);
> @@ -722,6 +756,7 @@ vhost_user_gpu_class_init(ObjectClass *klass, const void *data)
>       vgc->gl_flushed = vhost_user_gpu_gl_flushed;
>   
>       vdc->realize = vhost_user_gpu_device_realize;
> +    vdc->unrealize = vhost_user_gpu_device_unrealize;
>       vdc->reset = vhost_user_gpu_reset;
>       vdc->set_status   = vhost_user_gpu_set_status;
>       vdc->guest_notifier_mask = vhost_user_gpu_guest_notifier_mask;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 631dfc63a4d4..c8cb91032968 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -276,6 +276,10 @@ struct VhostUserGPU {
>       CharFrontend vhost_chr;
>       QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
>       bool backend_blocked;
> +
> +    QEMUBH *reset_bh;
> +    QemuCond reset_cond;
> +    bool reset_finished;
>   };
>   
>   #define MAX_SLOTS 4096
> 


