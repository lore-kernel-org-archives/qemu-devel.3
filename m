Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3F1C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YZI-0003XW-QA; Wed, 23 Apr 2025 07:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7YYf-0003TD-1u
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:46:31 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7YYb-0005ND-Hn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:46:28 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8E45249775;
 Wed, 23 Apr 2025 13:46:14 +0200 (CEST)
Date: Wed, 23 Apr 2025 13:46:12 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <1186263082.4663.1745408772058@webmail.proxmox.com>
In-Reply-To: <CAJ+F1CLHF0VQHg0JYmaooVRJSZbDkQa01D__iX-5umUcQjJd1Q@mail.gmail.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
 <CAJ+F1CLHF0VQHg0JYmaooVRJSZbDkQa01D__iX-5umUcQjJd1Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
Received-SPF: pass client-ip=94.136.29.106; envelope-from=dietmar@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> On 19.4.2025 07:24 CEST Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.co=
m> wrote:
>=20
> =20
> Hi
>=20
> On Fri, Apr 18, 2025 at 3:41=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.c=
om> wrote:
> >
> > This patch implements H264 support for VNC. The RFB protocol
> > extension is defined in:
> >
> > https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-26=
4-encoding
> >
> > Currently the Gstreamer x264enc plugin (software encoder) is used
> > to encode the video stream.
> >
> > The gstreamer pipe is:
> >
> > appsrc -> videoconvert -> x264enc -> appsink
> >
> > Note: videoconvert is required for RGBx to YUV420 conversion.
> >
> > The code still use the VNC server framebuffer change detection,
> > and only encodes and sends video frames if there are changes.
> >
> > Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> > ---
> >  ui/meson.build    |   1 +
> >  ui/vnc-enc-h264.c | 282 ++++++++++++++++++++++++++++++++++++++++++++++
> >  ui/vnc-jobs.c     |  49 +++++---
> >  ui/vnc.c          |  21 ++++
> >  ui/vnc.h          |  21 ++++
> >  5 files changed, 359 insertions(+), 15 deletions(-)
> >  create mode 100644 ui/vnc-enc-h264.c
> >
> > diff --git a/ui/meson.build b/ui/meson.build
> > index 35fb04cadf..34f1f33699 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -46,6 +46,7 @@ vnc_ss.add(files(
> >  ))
> >  vnc_ss.add(zlib, jpeg)
> >  vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
> > +vnc_ss.add(when: gstreamer, if_true: files('vnc-enc-h264.c'))
> >  system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
> >  system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
> >
> > diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> > new file mode 100644
> > index 0000000000..3abe6a1528
> > --- /dev/null
> > +++ b/ui/vnc-enc-h264.c
> > @@ -0,0 +1,282 @@
> > +/*
> > + * QEMU VNC display driver: hextile encoding
> > + *
> > + * Copyright (C) 2025 Proxmox Server Solutions GmbH
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "vnc.h"
> > +
> > +#include <gst/gst.h>
> > +
> > +static void destroy_encoder_context(VncState *vs)
> > +{
> > +    gst_clear_object(&vs->h264->source);
> > +    gst_clear_object(&vs->h264->convert);
> > +    gst_clear_object(&vs->h264->gst_encoder);
> > +    gst_clear_object(&vs->h264->sink);
> > +    gst_clear_object(&vs->h264->pipeline);
> > +}
> > +
> > +static bool create_encoder_context(VncState *vs, int w, int h)
> > +{
> > +    g_autoptr(GstCaps) source_caps =3D NULL;
> > +    GstStateChangeReturn state_change_ret;
> > +
> > +    g_assert(vs->h264 !=3D NULL);
> > +
> > +    if (vs->h264->sink) {
> > +        if (w !=3D vs->h264->width || h !=3D vs->h264->height) {
> > +            destroy_encoder_context(vs);
> > +        }
> > +    }
> > +
> > +    if (vs->h264->sink) {
> > +        return TRUE;
> > +    }
>=20
> I suggest to move that condition in the previous block (.. else {
> return TRUE; }) for readibility

Sorry, but this would change the semantics totally.
Please note that destroy_encoder_context() can set=20
sink to NULL.

>=20
> > +
> > +    vs->h264->width =3D w;
> > +    vs->h264->height =3D h;
> > +
> > +    vs->h264->source =3D gst_element_factory_make("appsrc", "source");
> > +    if (!vs->h264->source) {
> > +        VNC_DEBUG("Could not create gst source\n");
> > +        goto error;
> > +    }
> > +
> > +    vs->h264->convert =3D gst_element_factory_make("videoconvert", "co=
nvert");
> > +    if (!vs->h264->convert) {
> > +        VNC_DEBUG("Could not create gst convert element\n");
> > +        goto error;
> > +    }
> > +
> > +    vs->h264->gst_encoder =3D gst_element_factory_make("x264enc", "gst=
-encoder");
> > +    if (!vs->h264->gst_encoder) {
> > +        VNC_DEBUG("Could not create gst x264 encoder\n");
> > +        goto error;
> > +    }
> > +
> > +    g_object_set(
> > +        vs->h264->gst_encoder,
> > +        "tune", 4, /* zerolatency */
> > +        /*
> > +         * fix for zerolatency with novnc (without, noVNC displays
> > +         * green stripes)
> > +         */
> > +        "threads", 1,
> > +        "pass", 5, /* Constant Quality */
> > +        "quantizer", 26,
> > +        /* avoid access unit delimiters (Nal Unit Type 9) - not requir=
ed */
> > +        "aud", false,
> > +        NULL);
> > +
> > +    vs->h264->sink =3D gst_element_factory_make("appsink", "sink");
> > +    if (!vs->h264->sink) {
> > +        VNC_DEBUG("Could not create gst sink\n");
> > +        goto error;
> > +    }
> > +
> > +    vs->h264->pipeline =3D gst_pipeline_new("vnc-h264-pipeline");
> > +    if (!vs->h264->pipeline) {
> > +        VNC_DEBUG("Could not create gst pipeline\n");
> > +        goto error;
> > +    }
> > +
> > +    gst_object_ref(vs->h264->source);
> > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
> > +        gst_object_unref(vs->h264->source);
>=20
> I think it's a bit unnecessary to ref/unref each element, this is not
> typically what the gst API recommends. See for ex
> https://gstreamer.freedesktop.org/documentation/tutorials/basic/dynamic-p=
ipelines.html?gi-language=3Dc.
> They rely on weak pointers.

I cant see whats better there, or whats exactly the problem with correct re=
ference counting?
=20
> > +        VNC_DEBUG("Could not add source to gst pipeline\n");
> > +        goto error;
> > +    }
> > +
> > +    gst_object_ref(vs->h264->convert);
> > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) =
{
>=20
> Can you use gst_bin_add_many() ?

will try to use that.

>=20
> > +        gst_object_unref(vs->h264->convert);
> > +        VNC_DEBUG("Could not add convert to gst pipeline\n");
> > +        goto error;
> > +    }
> > +
> > +    gst_object_ref(vs->h264->gst_encoder);
> > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->gst_encode=
r)) {
> > +        gst_object_unref(vs->h264->gst_encoder);
> > +        VNC_DEBUG("Could not add encoder to gst pipeline\n");
> > +        goto error;
> > +    }
> > +
> > +    gst_object_ref(vs->h264->sink);
> > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->sink)) {
> > +        gst_object_unref(vs->h264->sink);
> > +        VNC_DEBUG("Could not add sink to gst pipeline\n");
> > +        goto error;
> > +    }
> > +
> > +    source_caps =3D gst_caps_new_simple(
> > +        "video/x-raw",
> > +        "format", G_TYPE_STRING, "BGRx",
> > +        "framerate", GST_TYPE_FRACTION, 33, 1,
> > +        "width", G_TYPE_INT, w,
> > +        "height", G_TYPE_INT, h,
> > +        NULL);
> > +
> > +    if (!source_caps) {
> > +        VNC_DEBUG("Could not create source caps filter\n");
> > +        goto error;
> > +    }
> > +
> > +    g_object_set(vs->h264->source, "caps", source_caps, NULL);
> > +
> > +    if (gst_element_link_many(
> > +            vs->h264->source,
> > +            vs->h264->convert,
> > +            vs->h264->gst_encoder,
> > +            vs->h264->sink,
> > +            NULL
> > +        ) !=3D TRUE) {
> > +        VNC_DEBUG("Elements could not be linked.\n");
> > +        goto error;
> > +    }
> > +
> > +    /* Start playing */
> > +    state_change_ret =3D gst_element_set_state(
> > +        vs->h264->pipeline, GST_STATE_PLAYING);
> > +
> > +    if (state_change_ret =3D=3D GST_STATE_CHANGE_FAILURE) {
> > +        VNC_DEBUG("Unable to set the pipeline to the playing state.\n"=
);
> > +        goto error;
> > +    }
> > +
> > +    return TRUE;
> > +
> > + error:
> > +    destroy_encoder_context(vs);
> > +    return FALSE;
> > +}
> > +
> > +bool vnc_h264_encoder_init(VncState *vs)
> > +{
> > +    g_assert(vs->h264 =3D=3D NULL);
> > +
> > +    vs->h264 =3D g_new0(VncH264, 1);
> > +
> > +    return true;
> > +}
> > +
> > +/*
> > + * Returns the number of generated framebuffer updates,
> > + * or -1 in case of errors
> > + */
> > +int vnc_h264_send_framebuffer_update(
> > +    VncState *vs,
> > +    int _x,
> > +    int _y,
> > +    int _w,
> > +    int _h
> > +) {
> > +    int n =3D 0;
> > +    int rdb_h264_flags =3D 0;
> > +    int width, height;
> > +    uint8_t *src_data_ptr =3D NULL;
> > +    size_t src_data_size;
> > +    GstFlowReturn flow_ret =3D GST_FLOW_ERROR;
> > +    GstBuffer *src_buffer =3D NULL;
> > +
> > +    g_assert(vs->h264 !=3D NULL);
> > +    g_assert(vs->vd !=3D NULL);
> > +    g_assert(vs->vd->server !=3D NULL);
> > +
> > +    width =3D pixman_image_get_width(vs->vd->server);
> > +    height =3D pixman_image_get_height(vs->vd->server);
> > +
> > +    g_assert(width =3D=3D vs->client_width);
> > +    g_assert(height =3D=3D vs->client_height);
> > +
> > +    if (vs->h264->sink) {
> > +        if (width !=3D vs->h264->width || height !=3D vs->h264->height=
) {
> > +            rdb_h264_flags =3D 2;
> > +        }
> > +    } else {
> > +        rdb_h264_flags =3D 2;
> > +    }
> > +
> > +    if (!create_encoder_context(vs, width, height)) {
> > +        VNC_DEBUG("Create encoder context failed\n");
> > +        return -1;
> > +    }
> > +
> > +    g_assert(vs->h264->sink !=3D NULL);
> > +
> > +    src_data_ptr =3D vnc_server_fb_ptr(vs->vd, 0, 0);
> > +    src_data_size =3D width * height * VNC_SERVER_FB_BYTES;
> > +
> > +    src_buffer =3D gst_buffer_new_wrapped_full(
> > +        0, src_data_ptr, src_data_size, 0, src_data_size, NULL, NULL);
> > +
> > +    g_signal_emit_by_name(
> > +        vs->h264->source, "push-buffer", src_buffer, &flow_ret);
> > +
> > +    if (flow_ret !=3D GST_FLOW_OK) {
> > +        VNC_DEBUG("gst appsrc push buffer failed\n");
> > +        return -1;
> > +    }
> > +
> > +    do {
> > +        GstSample *sample =3D NULL;
> > +        GstMapInfo map;
> > +        GstBuffer *out_buffer;
> > +
> > +        /* Retrieve the buffer */
> > +        g_signal_emit_by_name(vs->h264->sink, "try-pull-sample", 0, &s=
ample);
> > +        if (!sample) {
> > +            break;
> > +        }
> > +        out_buffer =3D gst_sample_get_buffer(sample);
> > +        if (gst_buffer_map(out_buffer, &map, 0)) {
> > +            vnc_framebuffer_update(vs, 0, 0, width, height, VNC_ENCODI=
NG_H264);
> > +            vnc_write_s32(vs, map.size); /* write data length */
> > +            vnc_write_s32(vs, rdb_h264_flags); /* write flags */
> > +            rdb_h264_flags =3D 0;
> > +
> > +            VNC_DEBUG("GST vnc_h264_update send %ld\n", map.size);
> > +
> > +            vnc_write(vs, map.data, map.size);
> > +
> > +            gst_buffer_unmap(out_buffer, &map);
> > +
> > +            n +=3D 1;
> > +        } else {
> > +            VNC_DEBUG("unable to map sample\n");
> > +        }
> > +        gst_sample_unref(sample);
> > +    } while (true);
> > +
> > +    return n;
> > +}
> > +
> > +void vnc_h264_clear(VncState *vs)
> > +{
> > +    if (!vs->h264) {
> > +        return;
> > +    }
>=20
> unnecessary

This is required. For example if you disable h264, vs->h264 is=20
always NULL, and we unconditionally call vnc_h264_clear().

Why do you think this is unnecessary?

>=20
> > +
> > +    destroy_encoder_context(vs);
> > +
> > +    g_clear_pointer(&vs->h264, g_free);
> > +}
> > diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> > index fcca7ec632..853a547d9a 100644
> > --- a/ui/vnc-jobs.c
> > +++ b/ui/vnc-jobs.c
> > @@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig=
, VncState *local)
> >      local->zlib =3D orig->zlib;
> >      local->hextile =3D orig->hextile;
> >      local->zrle =3D orig->zrle;
> > +    local->h264 =3D orig->h264;
> >      local->client_width =3D orig->client_width;
> >      local->client_height =3D orig->client_height;
> >  }
> > @@ -204,6 +205,7 @@ static void vnc_async_encoding_end(VncState *orig, =
VncState *local)
> >      orig->zlib =3D local->zlib;
> >      orig->hextile =3D local->hextile;
> >      orig->zrle =3D local->zrle;
> > +    orig->h264 =3D local->h264;
> >      orig->lossy_rect =3D local->lossy_rect;
> >  }
> >
> > @@ -284,25 +286,42 @@ static int vnc_worker_thread_loop(VncJobQueue *qu=
eue)
> >      vnc_write_u16(&vs, 0);
> >
> >      vnc_lock_display(job->vs->vd);
> > -    QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> > -        int n;
> > -
> > -        if (job->vs->ioc =3D=3D NULL) {
> > -            vnc_unlock_display(job->vs->vd);
> > -            /* Copy persistent encoding data */
> > -            vnc_async_encoding_end(job->vs, &vs);
> > -            goto disconnected;
> > -        }
> >
> > -        if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
> > -            n =3D vnc_send_framebuffer_update(&vs, entry->rect.x, entr=
y->rect.y,
> > -                                            entry->rect.w, entry->rect=
.h);
> > +    if (vs.vnc_encoding =3D=3D VNC_ENCODING_H264) {
> > +        int width =3D pixman_image_get_width(vs.vd->server);
> > +        int height =3D pixman_image_get_height(vs.vd->server);
> > +           int n =3D vnc_send_framebuffer_update(&vs, 0, 0, width, hei=
ght);
> > +        if (n >=3D 0) {
> > +            n_rectangles +=3D n;
> > +        }
> > +        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> > +            g_free(entry);
> > +        }
> > +    } else {
> > +        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> > +            int n;
> > +
> > +            if (job->vs->ioc =3D=3D NULL) {
> > +                vnc_unlock_display(job->vs->vd);
> > +                /* Copy persistent encoding data */
> > +                vnc_async_encoding_end(job->vs, &vs);
> > +                goto disconnected;
> > +            }
> >
> > -            if (n >=3D 0) {
> > -                n_rectangles +=3D n;
> > +            if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
> > +                n =3D vnc_send_framebuffer_update(
> > +                    &vs,
> > +                    entry->rect.x,
> > +                    entry->rect.y,
> > +                    entry->rect.w,
> > +                    entry->rect.h);
> > +
> > +                if (n >=3D 0) {
> > +                    n_rectangles +=3D n;
> > +                }
> >              }
> > +            g_free(entry);
> >          }
> > -        g_free(entry);
> >      }
> >      trace_vnc_job_nrects(&vs, job, n_rectangles);
> >      vnc_unlock_display(job->vs->vd);
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 9241caaad9..aed25b0183 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -972,6 +972,9 @@ int vnc_send_framebuffer_update(VncState *vs, int x=
, int y, int w, int h)
> >          case VNC_ENCODING_ZYWRLE:
> >              n =3D vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
> >              break;
> > +        case VNC_ENCODING_H264:
> > +            n =3D vnc_h264_send_framebuffer_update(vs, x, y, w, h);
> > +            break;
> >          default:
> >              vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
> >              n =3D vnc_raw_send_framebuffer_update(vs, x, y, w, h);
> > @@ -1326,6 +1329,10 @@ void vnc_disconnect_finish(VncState *vs)
> >      vnc_tight_clear(vs);
> >      vnc_zrle_clear(vs);
> >
> > +#ifdef CONFIG_GSTREAMER
> > +    vnc_h264_clear(vs);
> > +#endif
> > +
> >  #ifdef CONFIG_VNC_SASL
> >      vnc_sasl_client_cleanup(vs);
> >  #endif /* CONFIG_VNC_SASL */
> > @@ -2181,6 +2188,16 @@ static void set_encodings(VncState *vs, int32_t =
*encodings, size_t n_encodings)
> >              vnc_set_feature(vs, VNC_FEATURE_ZYWRLE);
> >              vs->vnc_encoding =3D enc;
> >              break;
> > +#ifdef CONFIG_GSTREAMER
> > +        case VNC_ENCODING_H264:
> > +            if (vnc_h264_encoder_init(vs)) {
> > +                vnc_set_feature(vs, VNC_FEATURE_H264);
> > +                vs->vnc_encoding =3D enc;
> > +            } else {
> > +                VNC_DEBUG("vnc_h264_encoder_init failed\n");
> > +            }
> > +            break;
> > +#endif
> >          case VNC_ENCODING_DESKTOPRESIZE:
> >              vnc_set_feature(vs, VNC_FEATURE_RESIZE);
> >              break;
> > @@ -4291,6 +4308,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, =
Error **errp)
> >      Error *local_err =3D NULL;
> >      char *id =3D (char *)qemu_opts_id(opts);
> >
> > +#ifdef CONFIG_GSTREAMER
> > +    gst_init(NULL, NULL);
> > +#endif
> > +
> >      assert(id);
> >      vnc_display_init(id, &local_err);
> >      if (local_err) {
> > diff --git a/ui/vnc.h b/ui/vnc.h
> > index acc53a2cc1..a0d336738d 100644
> > --- a/ui/vnc.h
> > +++ b/ui/vnc.h
> > @@ -46,6 +46,10 @@
> >  #include "vnc-enc-zrle.h"
> >  #include "ui/kbd-state.h"
> >
> > +#ifdef CONFIG_GSTREAMER
> > +#include <gst/gst.h>
> > +#endif
> > +
> >  // #define _VNC_DEBUG 1
> >
> >  #ifdef _VNC_DEBUG
> > @@ -231,6 +235,14 @@ typedef struct VncZywrle {
> >      int buf[VNC_ZRLE_TILE_WIDTH * VNC_ZRLE_TILE_HEIGHT];
> >  } VncZywrle;
> >
> > +#ifdef CONFIG_GSTREAMER
> > +typedef struct VncH264 {
> > +    GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
> > +    size_t width;
> > +    size_t height;
> > +} VncH264;
> > +#endif
> > +
> >  struct VncRect
> >  {
> >      int x;
> > @@ -344,6 +356,9 @@ struct VncState
> >      VncHextile hextile;
> >      VncZrle *zrle;
> >      VncZywrle zywrle;
> > +#ifdef CONFIG_GSTREAMER
> > +    VncH264 *h264;
> > +#endif
> >
> >      Notifier mouse_mode_notifier;
> >
> > @@ -404,6 +419,7 @@ enum {
> >  #define VNC_ENCODING_TRLE                 0x0000000f
> >  #define VNC_ENCODING_ZRLE                 0x00000010
> >  #define VNC_ENCODING_ZYWRLE               0x00000011
> > +#define VNC_ENCODING_H264                 0x00000032 /* 50   */
> >  #define VNC_ENCODING_COMPRESSLEVEL0       0xFFFFFF00 /* -256 */
> >  #define VNC_ENCODING_QUALITYLEVEL0        0xFFFFFFE0 /* -32  */
> >  #define VNC_ENCODING_XCURSOR              0xFFFFFF10 /* -240 */
> > @@ -464,6 +480,7 @@ enum VncFeatures {
> >      VNC_FEATURE_XVP,
> >      VNC_FEATURE_CLIPBOARD_EXT,
> >      VNC_FEATURE_AUDIO,
> > +    VNC_FEATURE_H264,
> >  };
> >
> >
> > @@ -625,6 +642,10 @@ int vnc_zrle_send_framebuffer_update(VncState *vs,=
 int x, int y, int w, int h);
> >  int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int=
 w, int h);
> >  void vnc_zrle_clear(VncState *vs);
> >
> > +bool vnc_h264_encoder_init(VncState *vs);
> > +int vnc_h264_send_framebuffer_update(VncState *vs, int x, int y, int w=
, int h);
> > +void vnc_h264_clear(VncState *vs);
> > +
> >  /* vnc-clipboard.c */
> >  void vnc_server_cut_text_caps(VncState *vs);
> >  void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
> > --
> > 2.39.5
> >
> >
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau


