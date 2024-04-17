Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABA0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 11:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx3AY-0006er-83; Wed, 17 Apr 2024 07:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx3AW-0006eR-LW
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx3AU-0004Dw-Io
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713352173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o1rbVAIoX7TXNfqxVTwv3mwt7I97mpUQZPoq0eqLMw=;
 b=XodjYp3MIUUm7CX9AkE4bSVll1N4R+0FFuTbl+6F39Co9Wmo0F5hnxfIVwPC8QataSqdJW
 sciTmnpmdyOqsGZitKnZ+2APby3Q8kxF+Gg2cU3yUFy1X/DjNMGcVpkYXG7ZehUU801K6s
 Tpsghq1inBAy/tvwMYgFrr1Ozqez9rs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-KP6rjqoVNeiBxfymyHtJrg-1; Wed, 17 Apr 2024 07:09:31 -0400
X-MC-Unique: KP6rjqoVNeiBxfymyHtJrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36FAC8021A4;
 Wed, 17 Apr 2024 11:09:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1932B51EF;
 Wed, 17 Apr 2024 11:09:30 +0000 (UTC)
Date: Wed, 17 Apr 2024 12:09:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH v6 3/3] ui/console: Introduce dpy_gl_qemu_dmabuf_new()
 and free() helpers
Message-ID: <Zh-t5DLthtRPTnL9@redhat.com>
References: <20240417040954.55641-1-dongwon.kim@intel.com>
 <20240417040954.55641-4-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417040954.55641-4-dongwon.kim@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

On Tue, Apr 16, 2024 at 09:09:54PM -0700, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This commit introduces utility functions for the creation and deallocation
> of QemuDmaBuf instances. Additionally, it updates all relevant sections
> of the codebase to utilize these new utility functions.
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/hw/vfio/vfio-common.h   |  2 +-
>  include/hw/virtio/virtio-gpu.h  |  4 ++--
>  include/ui/console.h            |  8 +++++++-
>  hw/display/vhost-user-gpu.c     | 32 +++++++++++++++++--------------
>  hw/display/virtio-gpu-udmabuf.c | 24 +++++++++--------------
>  hw/vfio/display.c               | 26 ++++++++++++-------------
>  ui/console.c                    | 34 +++++++++++++++++++++++++++++++++
>  ui/dbus-listener.c              | 28 ++++++++++++---------------
>  8 files changed, 95 insertions(+), 63 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..d66e27db02 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -148,7 +148,7 @@ typedef struct VFIOGroup {
>  } VFIOGroup;
>  
>  typedef struct VFIODMABuf {
> -    QemuDmaBuf buf;
> +    QemuDmaBuf *buf;
>      uint32_t pos_x, pos_y, pos_updates;
>      uint32_t hot_x, hot_y, hot_updates;
>      int dmabuf_id;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index ed44cdad6b..56d6e821bf 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -169,7 +169,7 @@ struct VirtIOGPUBaseClass {
>      DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
>  
>  typedef struct VGPUDMABuf {
> -    QemuDmaBuf buf;
> +    QemuDmaBuf *buf;
>      uint32_t scanout_id;
>      QTAILQ_ENTRY(VGPUDMABuf) next;
>  } VGPUDMABuf;
> @@ -238,7 +238,7 @@ struct VhostUserGPU {
>      VhostUserBackend *vhost;
>      int vhost_gpu_fd; /* closed by the chardev */
>      CharBackend vhost_chr;
> -    QemuDmaBuf dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
> +    QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
>      bool backend_blocked;
>  };
>  
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 3d9d8b9fce..6d7c03b7c5 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -358,7 +358,13 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
>                            bool have_hot, uint32_t hot_x, uint32_t hot_y);
>  void dpy_gl_cursor_position(QemuConsole *con,
>                              uint32_t pos_x, uint32_t pos_y);
> -
> +QemuDmaBuf *dpy_gl_qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                                   uint32_t stride, uint32_t x,
> +                                   uint32_t y, uint32_t backing_width,
> +                                   uint32_t backing_height, uint32_t fourcc,
> +                                   uint64_t modifier, uint32_t dmabuf_fd,
> +                                   bool allow_fences, bool y0_top);
> +void dpy_gl_qemu_dmabuf_free(QemuDmaBuf *dmabuf);

Since you're creating a new allocator/deallocator pair for
this, please also call G_DEFINE_AUTOPTR_CLEANUP_FUNC so this
struct becomes usable with g_autoptr(), even if we don't
currently have an immediate need to use g_autoptr.

>  int32_t dpy_gl_qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
>  uint32_t dpy_gl_qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
>  uint32_t dpy_gl_qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);


> diff --git a/ui/console.c b/ui/console.c
> index d4ca9e6e0f..ea23fd8af6 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1132,6 +1132,40 @@ void dpy_gl_cursor_position(QemuConsole *con,
>      }
>  }
>  
> +QemuDmaBuf *dpy_gl_qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                                   uint32_t stride, uint32_t x,
> +                                   uint32_t y, uint32_t backing_width,
> +                                   uint32_t backing_height, uint32_t fourcc,
> +                                   uint64_t modifier, uint32_t dmabuf_fd,
> +                                   bool allow_fences, bool y0_top) {
> +    QemuDmaBuf *dmabuf;
> +
> +    dmabuf = g_new0(QemuDmaBuf, 1);
> +
> +    dmabuf->width = width;
> +    dmabuf->height = height;
> +    dmabuf->stride = stride;
> +    dmabuf->x = x;
> +    dmabuf->y = y;
> +    dmabuf->backing_width = backing_width;
> +    dmabuf->backing_height = backing_height;
> +    dmabuf->fourcc = fourcc;
> +    dmabuf->modifier = modifier;
> +    dmabuf->fd = dmabuf_fd;
> +    dmabuf->allow_fences = allow_fences;
> +    dmabuf->y0_top = y0_top;
> +    dmabuf->fence_fd = -1;
> +
> +    return dmabuf;
> +}
> +
> +void dpy_gl_qemu_dmabuf_free(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf != NULL);

It is normal practice for all XXX_free() funcs to
accept NULL as a valid argument, and operate as
a no-op. This makes code more robust, as it can
blindly call free without checking for NULL ahead
of time.

> +
> +    g_free(dmabuf);
> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


