Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4CDC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz6gS-00007e-NS; Wed, 26 Aug 2026 02:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wz6gQ-00007S-9o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:00:22 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wz6gN-0006Do-6s
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:00:22 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67Q601wH006539
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 26 Aug 2026 15:00:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=f9vplhf98mD7C+XXFGHQjjBCFYBEkefYmWgfmbURvh4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787724002; v=1;
 b=VoXi7bYR3wP7Rt7eesGNjpPuoWPFLiDqWQs5l5UO1wsTzQA8qmlaIxprNQWDa+4s
 3cspafTt2o3OzjikeS7RWqKmd41qg8bDAp5zCYWm3JmjsFe8frL3J743jPylTiNT
 Nf52WfIh35kvQdPBkDxpq994rffT+vW0qvFVRJbTxM9RF9qLoYgYal0gS7d6t0yY
 k+aTcXcxf7w0bZWMumhplyeqWK4XYbf/QDL4ryTdE/UKdGGTpVIQUAZEs5OK7fvA
 SLU6zRgO+Yax1t+uEzpsGxmteVGUOSpmyFAwlHHvlyf0UiSmVDAeapJTtrkqdJNY
 yetQEnb7fKPTsLDhuKIGoA==
Message-ID: <28d800c2-b6b8-435f-bdc3-79fe0ce1a3b8@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 26 Aug 2026 15:00:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] ui/dbus: disable scanout iff dmabuf is current
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <20260825-virtio-gpu-cleanup-v1-2-d3bb612b9975@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-2-d3bb612b9975@redhat.com>
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

On 2026/08/25 19:20, Marc-André Lureau wrote:
> Narrows release_dmabuf to the active scanout, as the device & console
> may interleave new scanouts before releasing old ones.
> 

My AI agent is so nitpicking about the lack of Fixes: tags and its 
suggestions look reasonable, so I'm leaving them as comments. For this 
patch:

Fixes: 142ca628a733 ("ui: add a D-Bus display backend")

Regards,
Akihiko Odaki

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 68 ++++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 2e2f6ba4183a..5a72c7eeae59 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -91,6 +91,8 @@ struct _DBusDisplayListener {
>       guint dbus_filter;
>       guint32 display_serial_to_discard;
>       guint32 cursor_serial_to_discard;
> +
> +    QemuDmaBuf *scanout_dmabuf;
>   };
>   
>   G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
> @@ -119,6 +121,7 @@ static void dbus_scanout_disable(DisplayChangeListener *dcl)
>   {
>       DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
>   
> +    ddl->scanout_dmabuf = NULL;
>       ddl_discard_display_messages(ddl);
>   
>       qemu_dbus_display1_listener_call_disable(
> @@ -298,9 +301,9 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
>   
>   #ifdef CONFIG_GBM
>   static void dbus_scanout_dmabuf_v1(DBusDisplayListener *ddl,
> -                                   QemuDmaBuf *dmabuf)
> +                                   QemuDmaBuf *dmabuf,
> +                                   GError **err)
>   {
> -    g_autoptr(GError) err = NULL;
>       g_autoptr(GUnixFDList) fd_list = NULL;
>       int fd;
>       uint32_t width, height, stride, fourcc;
> @@ -309,8 +312,7 @@ static void dbus_scanout_dmabuf_v1(DBusDisplayListener *ddl,
>   
>       fd = qemu_dmabuf_get_fds(dmabuf, NULL)[0];
>       fd_list = g_unix_fd_list_new();
> -    if (g_unix_fd_list_append(fd_list, fd, &err) != 0) {
> -        error_report("Failed to setup dmabuf fdlist: %s", err->message);
> +    if (g_unix_fd_list_append(fd_list, fd, err) != 0) {
>           return;
>       }
>   
> @@ -332,9 +334,9 @@ static void dbus_scanout_dmabuf_v1(DBusDisplayListener *ddl,
>   }
>   
>   static void dbus_scanout_dmabuf_v2(DBusDisplayListener *ddl,
> -                                   QemuDmaBuf *dmabuf)
> +                                   QemuDmaBuf *dmabuf,
> +                                   GError **err)
>   {
> -    g_autoptr(GError) err = NULL;
>       g_autoptr(GUnixFDList) fd_list = NULL;
>       int i, fd_index[DMABUF_MAX_PLANES], num_fds;
>       uint32_t x, y, width, height, fourcc, backing_width, backing_height;
> @@ -360,9 +362,8 @@ static void dbus_scanout_dmabuf_v2(DBusDisplayListener *ddl,
>               break;
>           }
>   
> -        fd_index[num_fds] = g_unix_fd_list_append(fd_list, plane_fd, &err);
> +        fd_index[num_fds] = g_unix_fd_list_append(fd_list, plane_fd, err);
>           if (fd_index[num_fds] < 0) {
> -            error_report("Failed to setup dmabuf fdlist: %s", err->message);
>               return;
>           }
>       }
> @@ -395,20 +396,36 @@ static void dbus_scanout_dmabuf_v2(DBusDisplayListener *ddl,
>           G_DBUS_CALL_FLAGS_NONE, -1, fd_list, NULL, NULL, NULL);
>   }
>   
> +static bool dbus_call_scanout_dmabuf(DBusDisplayListener *ddl,
> +                                     QemuDmaBuf *dmabuf)
> +{
> +    g_autoptr(GError) err = NULL;
> +
> +    if (ddl->scanout_dmabuf_v2_proxy) {
> +        dbus_scanout_dmabuf_v2(ddl, dmabuf, &err);
> +    } else {
> +        if (qemu_dmabuf_get_num_planes(dmabuf) > 1) {
> +            error_report("Peer does not support multi plane dmabuf");
> +            return false;
> +        }
> +        dbus_scanout_dmabuf_v1(ddl, dmabuf, &err);
> +    }
> +
> +    if (err) {
> +        error_report("Failed to scanout dmabuf: %s", err->message);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
>                                   QemuDmaBuf *dmabuf)
>   {
>       DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
>   
> -    if (ddl->scanout_dmabuf_v2_proxy) {
> -        dbus_scanout_dmabuf_v2(ddl, dmabuf);
> -    } else {
> -        if (qemu_dmabuf_get_num_planes(dmabuf) > 1) {
> -            g_debug("org.qemu.Display1.Listener.ScanoutDMABUF "
> -                    "does not support mutli plane");
> -            return;
> -        }
> -        dbus_scanout_dmabuf_v1(ddl, dmabuf);
> +    if (dbus_call_scanout_dmabuf(ddl, dmabuf)) {
> +        ddl->scanout_dmabuf = dmabuf;
>       }
>   }
>   #endif /* GBM */
> @@ -589,6 +606,10 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
>                                    uint32_t w, uint32_t h,
>                                    void *d3d_tex2d)
>   {
> +#if defined(CONFIG_GBM) || defined(WIN32)
> +    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
> +#endif
> +
>       trace_dbus_scanout_texture(tex_id, backing_y_0_top,
>                                  backing_width, backing_height, x, y, w, h);
>   #ifdef CONFIG_GBM
> @@ -607,13 +628,13 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
>                                backing_height, fourcc, modifier, fd, num_planes,
>                                false, backing_y_0_top);
>   
> -    dbus_scanout_dmabuf(dcl, dmabuf);
> +    if (dbus_call_scanout_dmabuf(ddl, dmabuf)) {
> +        ddl->scanout_dmabuf = NULL;
> +    }
>       qemu_dmabuf_close(dmabuf);
>   #endif
>   
>   #ifdef WIN32
> -    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
> -
>       /* there must be a matching gfx_switch before */
>       assert(surface_width(ddl->ds) == w);
>       assert(surface_height(ddl->ds) == h);
> @@ -686,7 +707,14 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
>   static void dbus_release_dmabuf(DisplayChangeListener *dcl,
>                                   QemuDmaBuf *dmabuf)
>   {
> +    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
> +
> +    if (ddl->scanout_dmabuf != dmabuf) {
> +        return;
> +    }
> +
>       dbus_scanout_disable(dcl);
> +    ddl->scanout_dmabuf = NULL;
>   }
>   #endif /* GBM */
>   
> 


