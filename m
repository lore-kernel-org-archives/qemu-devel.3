Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3724D58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwbe-0006R0-UD; Mon, 02 Mar 2026 01:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwbc-0006Qm-Uz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:18:12 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwbZ-000581-Bj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:18:12 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6226HiEk032334
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 2 Mar 2026 15:17:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=P6jjvqmWm/u5xZmWcznUIVIw1HxvnhQxZoN7fM26p7U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772432265; v=1;
 b=A33IigGmRF5Ma1u1LWfnytvGc5yi3SYzKLR7TFZ4HwhsSbEh8m9XUpFvSwOVojpN
 JCR5r+EEPBmD8iuJOW7tBCfh9YxlCHF2YhQlV8oBbN/irGDK9uGC3RH4B5LkuGUa
 hgC118ZGlYw2zIziMIf4SXp9hwDM7F8+YOAJXgFEjcTe7H1wHB+QFUnF5+Lfc4jB
 ydtMu8OkfxK7Sg/amMFMN8bxmx8RZgfCTICed4pYmFZzJpo7LA9KYFwNLa87O4x/
 QFXPr8lABj8JLBiTaD2w+rxAQw3YQLwxkhgP9Pp/wrI7rdgM+eBCWCb2y23zUgkO
 2aIuyct4NT3jPo2iHESZJg==
Message-ID: <f0d5a977-9636-40c4-aab2-a6360d0e61fc@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 2 Mar 2026 15:17:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 03/21] ui/gdk: Restore original context after new
 context creation
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
References: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
 <20260301204838.596994-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260301204838.596994-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/02 5:48, Dmitry Osipenko wrote:
> Get currently bound GL context when creating new GL context and restore
> it after the creation for consistency with behavior expected by virglrenderer
> that assumes context-creation doesn't switch context.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   ui/gtk-gl-area.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index c709b2ce0f63..55c2c55ee93b 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -250,17 +250,19 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
>                                           QEMUGLParams *params)
>   {
>       VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
> +    GdkGLContext *ctx, *current_ctx;
>       GdkWindow *window;
> -    GdkGLContext *ctx;
>       GError *err = NULL;
>       int major, minor;
>   
> +    current_ctx = gdk_gl_context_get_current();
> +
>       window = gtk_widget_get_window(vc->gfx.drawing_area);
>       ctx = gdk_window_create_gl_context(window, &err);
>       if (err) {
>           g_printerr("Create gdk gl context failed: %s\n", err->message);
>           g_error_free(err);
> -        return NULL;
> +        goto out;

I don't think this change is needed. We do not change the bound context yet.

>       }
>       gdk_gl_context_set_required_version(ctx,
>                                           params->major_ver,
> @@ -270,7 +272,7 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
>           g_printerr("Realize gdk gl context failed: %s\n", err->message);
>           g_error_free(err);
>           g_clear_object(&ctx);
> -        return NULL;
> +        goto out;
>       }
>   
>       gdk_gl_context_make_current(ctx);
> @@ -283,6 +285,13 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
>           g_clear_object(&ctx);
>       }
>   
> +out:
> +    if (current_ctx) {
> +        gdk_gl_context_make_current(current_ctx);
> +    } else {
> +        gdk_gl_context_clear_current();
> +    }
> +

This function already calls gdk_gl_context_clear_current() and 
gtk_gl_area_make_current(). They should be replaced.

Regards,
Akihiko Odaki

>       trace_gd_gl_area_create_context(ctx, params->major_ver, params->minor_ver);
>       return ctx;
>   }


