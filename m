Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76E9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 11:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx36I-0005Ce-GJ; Wed, 17 Apr 2024 07:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx36H-0005AS-2K
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx36D-00033h-3P
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713351906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gHDT09jvq4Sqx8QCUj80x2oWpDK6JpnDqdrPxJNy9so=;
 b=L5wj28e/hsGVzI5FZbsAtR+NWlO7WFRP6nNv04KmXgRIvCbcz8dNMBboxxsGyuB91cpJ32
 FPr/1crO7uYLUTpqwxNlFaAaOf6CVwC8c4HY5PTbAqFodOmdGZrwcln3+oyG/xTblf/sWw
 1l4W3Mf9J4geqousQVqSVSiJ6PF/GXA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-ABCuWk7iNdyIgpvx56Fkhw-1; Wed, 17 Apr 2024 07:05:03 -0400
X-MC-Unique: ABCuWk7iNdyIgpvx56Fkhw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0189F88CE84;
 Wed, 17 Apr 2024 11:05:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12A1140C5C7;
 Wed, 17 Apr 2024 11:05:01 +0000 (UTC)
Date: Wed, 17 Apr 2024 12:04:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH v6 1/3] ui/console: Introduce dpy_gl_qemu_dmabuf_get_..()
 helpers
Message-ID: <Zh-s1wqWU8c0GHS8@redhat.com>
References: <20240417040954.55641-1-dongwon.kim@intel.com>
 <20240417040954.55641-2-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417040954.55641-2-dongwon.kim@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Tue, Apr 16, 2024 at 09:09:52PM -0700, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This commit introduces dpy_gl_qemu_dmabuf_get_... helpers to extract
> specific fields from the QemuDmaBuf struct. It also updates all instances
> where fields within the QemuDmaBuf struct are directly accessed, replacing
> them with calls to these new helper functions.
> 
> v6: fix typos in helper names in ui/spice-display.c
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/console.h            |  17 +++++
>  hw/display/vhost-user-gpu.c     |   6 +-
>  hw/display/virtio-gpu-udmabuf.c |   7 +-
>  hw/vfio/display.c               |  15 +++--
>  ui/console.c                    | 116 +++++++++++++++++++++++++++++++-
>  ui/dbus-console.c               |   9 ++-
>  ui/dbus-listener.c              |  43 +++++++-----
>  ui/egl-headless.c               |  23 +++++--
>  ui/egl-helpers.c                |  47 +++++++------
>  ui/gtk-egl.c                    |  48 ++++++++-----
>  ui/gtk-gl-area.c                |  37 ++++++----
>  ui/gtk.c                        |   6 +-
>  ui/spice-display.c              |  50 ++++++++------
>  13 files changed, 316 insertions(+), 108 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 0bc7a00ac0..6292943a82 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -358,6 +358,23 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
>                            bool have_hot, uint32_t hot_x, uint32_t hot_y);
>  void dpy_gl_cursor_position(QemuConsole *con,
>                              uint32_t pos_x, uint32_t pos_y);
> +
> +int32_t dpy_gl_qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
> +uint64_t dpy_gl_qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_x(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
> +bool dpy_gl_qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
> +void *dpy_gl_qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
> +int32_t dpy_gl_qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
> +bool dpy_gl_qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
> +bool dpy_gl_qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);

IMHO these method names don't need a "dpy_gl_" prefix on
them. Since they're accessors for the "QemuDmaBuf" struct,
I think its sufficient to just have "qemu_dmabuf_" as the
name prefix, making names more compact.

The console.{h,c} files are a bit of a dumping ground for
UI code. While QemuDmaBuf was just a struct with direct
field access that's OK.

With turning this into a more of an object with accessors,
I think it would also be desirable to move the struct
definition and all its methods into separate ui/dmabuf.{c,h}
files, so its fully self-contained.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


