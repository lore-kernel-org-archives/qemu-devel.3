Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F5C3ABD7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqfW-0003c5-7c; Tue, 13 May 2025 10:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEqfU-0003Yy-00
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEqfR-0007vp-Kv
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747146695;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=g1byauJJ8F1ZIxa4Uifv/Nq5XjvjE/dRgS9nc6jECpU=;
 b=QH9IxYXyuEObKWswZnJ5OIz2uYwSvO/oktYcltp3MkZVBnehGJdNgJZmWMCkkhZzQpDFOy
 0+i+oyNJG2hICw0yY4BABqMZmu0U15uKeFCztb+6LFwrtoJ8+V0n7pZ+AOVXSY7Tf0Czeq
 7rsliW9OeTdc5+Wq5G8YNIYmxuoXEn8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-jepMzmegM-myPU1KYS7nBw-1; Tue,
 13 May 2025 10:31:33 -0400
X-MC-Unique: jepMzmegM-myPU1KYS7nBw-1
X-Mimecast-MFC-AGG-ID: jepMzmegM-myPU1KYS7nBw_1747146692
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D33719560AB; Tue, 13 May 2025 14:31:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77CE91953B82; Tue, 13 May 2025 14:31:30 +0000 (UTC)
Date: Tue, 13 May 2025 15:31:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 2/7] add vnc h264 encoder
Message-ID: <aCNXvhsU72ZtwKMd@redhat.com>
References: <20250430072524.3650582-1-dietmar@proxmox.com>
 <20250430072524.3650582-3-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430072524.3650582-3-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Apr 30, 2025 at 09:25:19AM +0200, Dietmar Maurer wrote:
> This patch implements H264 support for VNC. The RFB protocol
> extension is defined in:
> 
> https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-encoding
> 
> Currently the Gstreamer x264enc plugin (software encoder) is used
> to encode the video stream.
> 
> The gstreamer pipe is:
> 
> appsrc -> videoconvert -> x264enc -> appsink
> 
> Note: videoconvert is required for RGBx to YUV420 conversion.
> 
> The code still use the VNC server framebuffer change detection,
> and only encodes and sends video frames if there are changes.
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/meson.build    |   1 +
>  ui/vnc-enc-h264.c | 255 ++++++++++++++++++++++++++++++++++++++++++++++
>  ui/vnc-jobs.c     |  53 +++++++---
>  ui/vnc.c          |  37 ++++++-
>  ui/vnc.h          |  21 ++++
>  5 files changed, 350 insertions(+), 17 deletions(-)
>  create mode 100644 ui/vnc-enc-h264.c

> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> new file mode 100644
> index 0000000000..26e8c19270
> --- /dev/null
> +++ b/ui/vnc-enc-h264.c
> @@ -0,0 +1,255 @@
> +/*
> + * QEMU VNC display driver: H264 encoding
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "vnc.h"
> +
> +#include <gst/gst.h>
> +
> +static void destroy_encoder_context(VncState *vs)
> +{
> +    gst_clear_object(&vs->h264->source);
> +    gst_clear_object(&vs->h264->convert);
> +    gst_clear_object(&vs->h264->gst_encoder);
> +    gst_clear_object(&vs->h264->sink);
> +    gst_clear_object(&vs->h264->pipeline);
> +}
> +
> +static bool create_encoder_context(VncState *vs, int w, int h)
> +{
> +    g_autoptr(GstCaps) source_caps = NULL;
> +    GstStateChangeReturn state_change_ret;
> +
> +    g_assert(vs->h264 != NULL);
> +
> +    if (vs->h264->sink && w == vs->h264->width && h == vs->h264->height) {
> +        return TRUE;
> +    }
> +
> +    destroy_encoder_context(vs);
> +
> +    vs->h264->width = w;
> +    vs->h264->height = h;
> +
> +    vs->h264->source = gst_element_factory_make("appsrc", "source");
> +    if (!vs->h264->source) {
> +        VNC_DEBUG("Could not create gst source\n");
> +        goto error;
> +    }
> +
> +    vs->h264->convert = gst_element_factory_make("videoconvert", "convert");
> +    if (!vs->h264->convert) {
> +        VNC_DEBUG("Could not create gst convert element\n");
> +        goto error;
> +    }
> +
> +    vs->h264->gst_encoder = gst_element_factory_make("x264enc", "gst-encoder");
> +    if (!vs->h264->gst_encoder) {
> +        VNC_DEBUG("Could not create gst x264 encoder\n");
> +        goto error;
> +    }
> +
> +    g_object_set(
> +        vs->h264->gst_encoder,
> +        "tune", 4, /* zerolatency */
> +        /*
> +         * fix for zerolatency with novnc (without, noVNC displays
> +         * green stripes)
> +         */
> +        "threads", 1,
> +        "pass", 5, /* Constant Quality */
> +        "quantizer", 26,
> +        /* avoid access unit delimiters (Nal Unit Type 9) - not required */
> +        "aud", false,
> +        NULL);
> +
> +    vs->h264->sink = gst_element_factory_make("appsink", "sink");
> +    if (!vs->h264->sink) {
> +        VNC_DEBUG("Could not create gst sink\n");
> +        goto error;
> +    }
> +
> +    vs->h264->pipeline = gst_pipeline_new("vnc-h264-pipeline");
> +    if (!vs->h264->pipeline) {
> +        VNC_DEBUG("Could not create gst pipeline\n");
> +        goto error;
> +    }
> +
> +    gst_object_ref(vs->h264->source);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
> +        gst_object_unref(vs->h264->source);
> +        VNC_DEBUG("Could not add source to gst pipeline\n");
> +        goto error;
> +    }
> +
> +    gst_object_ref(vs->h264->convert);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) {
> +        gst_object_unref(vs->h264->convert);
> +        VNC_DEBUG("Could not add convert to gst pipeline\n");
> +        goto error;
> +    }
> +
> +    gst_object_ref(vs->h264->gst_encoder);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->gst_encoder)) {
> +        gst_object_unref(vs->h264->gst_encoder);
> +        VNC_DEBUG("Could not add encoder to gst pipeline\n");
> +        goto error;
> +    }
> +
> +    gst_object_ref(vs->h264->sink);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->sink)) {
> +        gst_object_unref(vs->h264->sink);
> +        VNC_DEBUG("Could not add sink to gst pipeline\n");
> +        goto error;
> +    }
> +
> +    source_caps = gst_caps_new_simple(
> +        "video/x-raw",
> +        "format", G_TYPE_STRING, "BGRx",
> +        "framerate", GST_TYPE_FRACTION, 33, 1,
> +        "width", G_TYPE_INT, w,
> +        "height", G_TYPE_INT, h,
> +        NULL);
> +
> +    if (!source_caps) {
> +        VNC_DEBUG("Could not create source caps filter\n");
> +        goto error;
> +    }
> +
> +    g_object_set(vs->h264->source, "caps", source_caps, NULL);
> +
> +    if (gst_element_link_many(
> +            vs->h264->source,
> +            vs->h264->convert,
> +            vs->h264->gst_encoder,
> +            vs->h264->sink,
> +            NULL
> +        ) != TRUE) {
> +        VNC_DEBUG("Elements could not be linked.\n");
> +        goto error;
> +    }
> +
> +    /* Start playing */
> +    state_change_ret = gst_element_set_state(
> +        vs->h264->pipeline, GST_STATE_PLAYING);
> +
> +    if (state_change_ret == GST_STATE_CHANGE_FAILURE) {
> +        VNC_DEBUG("Unable to set the pipeline to the playing state.\n");
> +        goto error;
> +    }
> +
> +    return TRUE;
> +
> + error:
> +    destroy_encoder_context(vs);
> +    return FALSE;
> +}
> +
> +bool vnc_h264_encoder_init(VncState *vs)
> +{
> +    g_assert(vs->h264 == NULL);
> +
> +    vs->h264 = g_new0(VncH264, 1);
> +
> +    return true;
> +}
> +
> +/*
> + * Returns the number of generated framebuffer updates,
> + * or -1 in case of errors
> + */
> +int vnc_h264_send_framebuffer_update(VncState *vs)
> +{
> +    int n = 0;
> +    int rdb_h264_flags = 0;
> +    int width, height;
> +    uint8_t *src_data_ptr = NULL;
> +    size_t src_data_size;
> +    GstFlowReturn flow_ret = GST_FLOW_ERROR;
> +    GstBuffer *src_buffer = NULL;
> +
> +    g_assert(vs->h264 != NULL);
> +    g_assert(vs->vd != NULL);
> +    g_assert(vs->vd->server != NULL);
> +
> +    width = pixman_image_get_width(vs->vd->server);
> +    height = pixman_image_get_height(vs->vd->server);
> +
> +    g_assert(width == vs->client_width);
> +    g_assert(height == vs->client_height);
> +
> +    if (vs->h264->sink) {
> +        if (width != vs->h264->width || height != vs->h264->height) {
> +            rdb_h264_flags = 2;
> +        }
> +    } else {
> +        rdb_h264_flags = 2;
> +    }
> +
> +    if (!create_encoder_context(vs, width, height)) {
> +        VNC_DEBUG("Create encoder context failed\n");
> +        return -1;
> +    }
> +
> +    g_assert(vs->h264->sink != NULL);
> +
> +    src_data_ptr = vnc_server_fb_ptr(vs->vd, 0, 0);
> +    src_data_size = width * height * VNC_SERVER_FB_BYTES;
> +
> +    src_buffer = gst_buffer_new_wrapped_full(
> +        0, src_data_ptr, src_data_size, 0, src_data_size, NULL, NULL);
> +
> +    g_signal_emit_by_name(
> +        vs->h264->source, "push-buffer", src_buffer, &flow_ret);
> +
> +    if (flow_ret != GST_FLOW_OK) {
> +        VNC_DEBUG("gst appsrc push buffer failed\n");
> +        return -1;
> +    }
> +
> +    do {
> +        GstSample *sample = NULL;
> +        GstMapInfo map;
> +        GstBuffer *out_buffer;
> +
> +        /* Retrieve the buffer */
> +        g_signal_emit_by_name(vs->h264->sink, "try-pull-sample", 0, &sample);
> +        if (!sample) {
> +            break;
> +        }
> +        out_buffer = gst_sample_get_buffer(sample);
> +        if (gst_buffer_map(out_buffer, &map, 0)) {
> +            vnc_framebuffer_update(vs, 0, 0, width, height, VNC_ENCODING_H264);
> +            vnc_write_s32(vs, map.size); /* write data length */
> +            vnc_write_s32(vs, rdb_h264_flags); /* write flags */
> +            rdb_h264_flags = 0;
> +
> +            VNC_DEBUG("GST vnc_h264_update send %ld\n", map.size);
> +
> +            vnc_write(vs, map.data, map.size);
> +
> +            gst_buffer_unmap(out_buffer, &map);
> +
> +            n += 1;
> +        } else {
> +            VNC_DEBUG("unable to map sample\n");
> +        }
> +        gst_sample_unref(sample);
> +    } while (true);
> +
> +    return n;
> +}
> +
> +void vnc_h264_clear(VncState *vs)
> +{
> +    if (!vs->h264) {
> +        return;
> +    }
> +
> +    destroy_encoder_context(vs);
> +
> +    g_clear_pointer(&vs->h264, g_free);
> +}

> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9e097dc4b4..ba71589c6f 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c


> @@ -4289,6 +4320,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      Error *local_err = NULL;
>      char *id = (char *)qemu_opts_id(opts);
>  
> +#ifdef CONFIG_GSTREAMER
> +    gst_init(NULL, NULL);

This method aborts the process on failure. We need to use

  gst_init_check(NULL, NULL, &err)

and report the 'err' result with error_report() so it
integrates with QEMU's normal error reporting mechanisms.


> @@ -625,6 +642,10 @@ int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
>  int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
>  void vnc_zrle_clear(VncState *vs);
>
> +bool vnc_h264_encoder_init(VncState *vs);
> +int vnc_h264_send_framebuffer_update(VncState *vs);
> +void vnc_h264_clear(VncState *vs);

These ought to be wrapped in '#ifdef CONFIG_GSTREAMER' too, so that is
obvious they're conditionally available, and it'll trigger a compiler
error if someone tries to call them outside a matching #ifdef

> +
>  /* vnc-clipboard.c */
>  void vnc_server_cut_text_caps(VncState *vs);
>  void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
> -- 
> 2.39.5
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


