Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5F0C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3pHD-0001HN-5P; Tue, 08 Sep 2026 02:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3pHB-0001HF-KG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:25:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3pH9-0001u9-IE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:25:49 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886ParO056798
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:25:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kSVJhpP/IFr8cJLIoGEnkdDtlb9ohwwna4jK6C8+vn0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788848737; v=1;
 b=dHum7IX507+4Cf6jdmwpsVT6Ur6QimufibepiwKjXYYW5vUavTd85Hq/7qUZ4Iw/
 OkTwRLw98Whq3HxhZD60jpHgcEKC2+HW8trQGEzS8eYcpW9tPHht42zJZO/j9ln+
 TmzjphTkXty0LrgJR3j7f9HVZvdWAypp5vStsZtTbcRqsMKidR3pUr7JaCztZF9b
 LQKQmm9HSXV1WPzGauUPsOOjPgERz9Iq65qKcRTUUK6REYai3h2WkWJmdBPz+8Mp
 x0PPGbcqHTnc3/c6E5TvHiKLTyYFvliR77yfKX7L0QK9slBGpbcVEg8GfoWmQlwb
 eWi4MIfJmf+1MGW5nTrsiA==
Message-ID: <c20b1f7a-5006-4b6c-8753-386aa3a8a1f2@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 8 Sep 2026 15:25:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] vhost-user-gpu: release DMA-BUFs on scanout
 disable, reset and finalize
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-24-15b5ae6b0023@redhat.com>
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-24-15b5ae6b0023@redhat.com>
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

On 2026/09/04 22:10, Marc-André Lureau wrote:
> When the backend sends VHOST_USER_GPU_SCANOUT with zero dimensions to
> disable a scanout, the frontend only calls qemu_console_set_surface(NULL)
> without releasing the g->dmabuf[] entry or invoking
> qemu_console_gl_scanout_disable(). Display listeners (GTK, SDL) can
> therefore remain in GL scanout mode and keep redrawing the stale buffer.
> 
> Release the DMA-BUF and call qemu_console_gl_scanout_disable() in the
> SCANOUT handler when a previously active DMA-BUF exists.
> 
> Additionally, vhost_user_gpu_reset() and
> vhost_user_gpu_instance_finalize() never iterate the dmabuf[] array, so
> active DMA-BUFs leak on device reset or object destruction. Add cleanup
> loops to both paths.

We need to ensure that DMA-BUF reset cleanup happens on the main-thread.

A guest writes zero to the modern PCI status register → 
virtio_pci_common_write() → virtio_pci_reset() → virtio_bus_reset() → 
virtio_reset() → vhost_user_gpu_reset(). This executes on the vCPU 
thread. The newly added release calls invoke GTK/SDL/EGL display 
listeners there. For example, egl_release_dmabuf() attempts to bind 
qemu_egl_rn_ctx, which remains current on the main thread, then calls 
glDeleteTextures() through egl_dmabuf_release_texture(). The context 
bind fails, leaving the GL deletion without the required current 
context. EGL 1.5 §3.7.3 explicitly requires EGL_BAD_ACCESS when the 
context is current on another thread.

Existing virtio_gpu_reset() handles this constraint by scheduling a 
main-loop BH and waiting, but it also has its own race and deadlock 
issues. [1] is my latest attempt to fix it. You may review it, and adopt 
its approach if it looks reasonable to you.

[1] 
https://lore.kernel.org/qemu-devel/20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH v3 0/9] virtio-gpu: Do not wait for the main thread during reset")

> 
> Fixes: 267f664658fe ("hw/display: add vhost-user-vga & gpu-pci")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vhost-user-gpu.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index c09aca041135..3f1fd333eeab 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -263,6 +263,11 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>           con = s->con;
>   
>           if (m->width == 0) {
> +            if (g->dmabuf[m->scanout_id]) {
> +                qemu_console_gl_release_dmabuf(con, g->dmabuf[m->scanout_id]);
> +                g_clear_pointer(&g->dmabuf[m->scanout_id], qemu_dmabuf_free);
> +                qemu_console_gl_scanout_disable(con);
> +            }
>               qemu_console_set_surface(con, NULL);
>           } else {
>               s->ds = qemu_create_displaysurface(m->width, m->height);
> @@ -631,6 +636,10 @@ vhost_user_gpu_instance_finalize(Object *obj)
>   {
>       VhostUserGPU *g = VHOST_USER_GPU(obj);
>   
> +    for (int i = 0; i < g->parent_obj.conf.max_outputs; i++) {

Please bound finalizer cleanup by the actual DMA-BUF array size.

conf.max_outputs is a writable uint32 property, and the rejection of 
values above 16 happens only in virtio_gpu_base_device_realize(). The 
finalizer also runs after realization failure, including missing 
chardev, before that validation. Thus setting max_outputs=4096 makes 
this new loop traverse beyond dmabuf[16], reading and potentially 
freeing arbitrary values. Iterating ARRAY_SIZE(g->dmabuf) instead is the 
simplest fix I came up.

Regards,
Akihiko Odaki

> +        g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
> +    }
> +
>       object_unref(OBJECT(g->vhost));
>   }
>   
> @@ -639,6 +648,15 @@ vhost_user_gpu_reset(VirtIODevice *vdev)
>   {
>       VhostUserGPU *g = VHOST_USER_GPU(vdev);
>   
> +    for (int i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        if (g->dmabuf[i]) {
> +            QemuConsole *con = g->parent_obj.scanout[i].con;
> +            qemu_console_gl_release_dmabuf(con, g->dmabuf[i]);
> +            g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
> +            qemu_console_gl_scanout_disable(con);
> +        }
> +    }
> +
>       virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>   
>       vhost_user_backend_stop(g->vhost);
> 


