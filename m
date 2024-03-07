Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F26C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAFG-00035l-MV; Thu, 07 Mar 2024 04:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riAFE-00035J-I6
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riAFC-00026t-RN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709804453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/v4X4oBVsqDyu+zVfeDxffHIQ11OHc5jyDFyB4jGFQ=;
 b=P33wT3wEnlTH+Yb7pVceJHzrH3RJh3rjXaqOGkERL31crVXg1J4bE/46E/P3s9YUevZuRj
 yfa1MCLsGNLf+vIU57TMInC88ZBROYuF/AITQQYX36x+t/0DW4tLPhzWWJ8o9zwVaDmohg
 QFOC+adZlQkkcXdkQkszq8GDaZ78a/8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-Xn5kKH84OZq4e8mdFJ4CWg-1; Thu,
 07 Mar 2024 04:40:52 -0500
X-MC-Unique: Xn5kKH84OZq4e8mdFJ4CWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB6113830093;
 Thu,  7 Mar 2024 09:40:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DE4E17475;
 Thu,  7 Mar 2024 09:40:51 +0000 (UTC)
Date: Thu, 7 Mar 2024 09:40:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
 VC is invisible
Message-ID: <ZemLoa0JLXJW9l0F@redhat.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130234840.53122-2-dongwon.kim@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 03:48:38PM -0800, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> A new flag "visible" is added to show visibility status of the gfx console.
> The flag is set to 'true' when the VC is visible but set to 'false' when
> it is hidden or closed. When the VC is invisible, drawing guest frames
> should be skipped as it will never be completed and it would potentially
> lock up the guest display especially when blob scanout is used.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> 
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/gtk.h |  1 +
>  ui/gtk-egl.c     |  8 ++++++++
>  ui/gtk-gl-area.c |  8 ++++++++
>  ui/gtk.c         | 10 +++++++++-
>  4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index aa3d637029..2de38e5724 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -57,6 +57,7 @@ typedef struct VirtualGfxConsole {
>      bool y0_top;
>      bool scanout_mode;
>      bool has_dmabuf;
> +    bool visible;
>  #endif
>  } VirtualGfxConsole;
>  
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 3af5ac5bcf..993c283191 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -265,6 +265,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>  #ifdef CONFIG_GBM
>      VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>  
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                     vc->gfx.esurface, vc->gfx.ectx);
>  
> @@ -363,6 +367,10 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>      VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>      GtkWidget *area = vc->gfx.drawing_area;
>  
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted = true;
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 52dcac161e..04e07bd7ee 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -285,6 +285,10 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>  {
>      VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>  
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted = true;
> @@ -299,6 +303,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
>  #ifdef CONFIG_GBM
>      VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>  
> +    if (!vc->gfx.visible) {
> +        return;
> +    }
> +
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>      egl_dmabuf_import_texture(dmabuf);
>      if (!dmabuf->texture) {

If we skip processing these requests, what happens when the
QEMU windows is then re-displayed. Won't it now be missing
updates to various regions of the guest display ?

>
With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


