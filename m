Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A758C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 14:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzH3l-0001vO-9a; Tue, 23 Apr 2024 10:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzH3i-0001v3-Uv
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 10:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzH3g-000824-J7
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 10:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713882223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+y7p+FBxgNQUaUeRw+z6LCWSzNDju4bxHvFZutC/x14=;
 b=IoLv+Zszq7oovtHsf3QKKm7Uni8GWind/hMYzgmvBrzIzNgvDBbtTwESDgPAb4ILzdzjDk
 BNZ0uICYUWkwYtjFD8UE8r9NHZw8cFqwUZ4U5zK0nCl4x8IbwfvILqZortVsFrAH3Ayb6v
 KnsXX5227iB2iZcg/Mv1mPSKjl9VfVQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-TfatqREEN0untQ4qCzMjiQ-1; Tue, 23 Apr 2024 10:23:40 -0400
X-MC-Unique: TfatqREEN0untQ4qCzMjiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9ADD104B503;
 Tue, 23 Apr 2024 14:23:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B2081C060D0;
 Tue, 23 Apr 2024 14:23:38 +0000 (UTC)
Date: Tue, 23 Apr 2024 15:23:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v10 3/6] ui/console: Use qemu_dmabuf_get_..() helpers
 instead
Message-ID: <ZifEaGr7L9FCTGSl@redhat.com>
References: <20240423022253.1003295-1-dongwon.kim@intel.com>
 <20240423022253.1003295-4-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423022253.1003295-4-dongwon.kim@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 22, 2024 at 07:22:50PM -0700, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This commit updates all instances where fields within the QemuDmaBuf
> struct are directly accessed, replacing them with calls to these new
> helper functions.
> 
> v6: fix typos in helper names in ui/spice-display.c
> 
> v7: removed prefix, "dpy_gl_" from all helpers
> 
> v8: Introduction of helpers was removed as those were already added
>     by the previous commit
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  hw/display/vhost-user-gpu.c     |  6 ++--
>  hw/display/virtio-gpu-udmabuf.c |  7 +++--
>  hw/vfio/display.c               | 15 +++++++---
>  ui/console.c                    |  4 +--
>  ui/dbus-console.c               |  9 ++++--
>  ui/dbus-listener.c              | 43 +++++++++++++++++-----------
>  ui/egl-headless.c               | 23 ++++++++++-----
>  ui/egl-helpers.c                | 47 ++++++++++++++++++-------------
>  ui/gtk-egl.c                    | 48 ++++++++++++++++++++-----------
>  ui/gtk-gl-area.c                | 37 ++++++++++++++++--------
>  ui/gtk.c                        |  6 ++--
>  ui/spice-display.c              | 50 +++++++++++++++++++--------------
>  12 files changed, 187 insertions(+), 108 deletions(-)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 709c8a02a1..ea9a6c5d10 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -249,6 +249,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>      case VHOST_USER_GPU_DMABUF_SCANOUT: {
>          VhostUserGpuDMABUFScanout *m = &msg->payload.dmabuf_scanout;
>          int fd = qemu_chr_fe_get_msgfd(&g->vhost_chr);
> +        int old_fd;
>          QemuDmaBuf *dmabuf;
>  
>          if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
> @@ -262,8 +263,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>          g->parent_obj.enable = 1;
>          con = g->parent_obj.scanout[m->scanout_id].con;
>          dmabuf = &g->dmabuf[m->scanout_id];
> -        if (dmabuf->fd >= 0) {
> -            close(dmabuf->fd);
> +        old_fd = qemu_dmabuf_get_fd(dmabuf);
> +        if (old_fd >= 0) {
> +            close(old_fd);
>              dmabuf->fd = -1;

I think we shoul hdave a qemu_dmabuf_close() method for this logic


> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 1aa440c663..4861c8161d 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -259,9 +259,13 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
>  
>  static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
>  {
> +    int fd;
> +
>      QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
> +
> +    fd = qemu_dmabuf_get_fd(&dmabuf->buf);
>      dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
> -    close(dmabuf->buf.fd);
> +    close(fd);

Again, we should have a qemu_dmabuf_close() method

>      g_free(dmabuf);
>  }
>  


>          } else {
> -            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id,
> -                                               dmabuf->width, dmabuf->height);
> +            stride = qemu_dmabuf_get_stride(dmabuf);
> +            fourcc = qemu_dmabuf_get_fourcc(dmabuf);
> +            y_0_top = qemu_dmabuf_get_y0_top(dmabuf);
> +            fd = qemu_dmabuf_get_fd(dmabuf);

This is where it would use a qemu_dmabuf_dup_fd(), avoiding
the subsequent dup() in the method call

> +
> +            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, height);
>              /* note: spice server will close the fd, so hand over a dup */
> -            spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
> -                                 dmabuf->width, dmabuf->height,
> -                                 dmabuf->stride, dmabuf->fourcc,
> -                                 dmabuf->y0_top);
> +            spice_qxl_gl_scanout(&ssd->qxl, dup(fd), width, height,
> +                                 stride, fourcc, y_0_top);
>          }
> -        qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->height);
> +        qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
>          ssd->guest_dmabuf_refresh = false;

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


