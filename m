Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D1DC55163
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 08:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtM0Z-000561-UM; Fri, 20 Feb 2026 03:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vtM0X-00054Z-FG
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 03:37:05 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vtM0T-0005hk-JO
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 03:37:05 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61K8ZZYE083449
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Feb 2026 17:36:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JZEd39lwzjw4hqNWdxANAmz3TrVPYi43xCbZD7g4IWo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1771576587; v=1;
 b=cMmdMlkmlF8VtLhAAhaBWiovpIEB4pzmRC7Zp5cNJUwWF3vUSm96l6GWFErl0RXa
 HI0Ja0fZe/PX7zF8WkI079qeQHIJk66X72SeUhajlMdYwBJJ60Q1w/ALiu2vA89D
 AdTVyOgFqU0GFcpjHrewczyOy0VYhTIoi6no0e7eVyucOl8qAsAzfQVLuforphr4
 ZILcWjmLKU1IwBgO14JBNowwEB/yHrckLYtz+kXxfKt6COhjq7I34RGJ95p1XR+Q
 fXuf5DGrb3LNjuKSiKnJgWfElThPqBV5kDDI3Sp/OGTpZtf0ug/6i/OJUmvExPkn
 LbngQduE6w9OgfY2Ax+B1w==
Message-ID: <271c635c-8c2c-48bc-b44f-91b9d268bbe2@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 20 Feb 2026 17:35:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/20] Support virtio-gpu DRM native context and
 MAP_FIXED API
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
References: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/02/20 9:16, Dmitry Osipenko wrote:
> Hello,
> 
> This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
> virtio-gpu patches that has been reviewed previously and were waiting for
> a new release of libvirglrenderer 1.3.0.
> 
> [1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-dmitry.osipenko@collabora.com/
> [2] https://lore.kernel.org/qemu-devel/20260118162856.223796-1-dmitry.osipenko@collabora.com/
> 
> Based-on: 20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp
> 
> Changelog:
> 
> v19:- Further improved improved naming of functions and terminology RE
>        GL context binding. Suggested by Akihiko Odaki.
> 
>      - Added new patch "ui/gdk: Restore original context after new context
>        creation" in addition to improved "ui/sdl2: Restore original context"
>        that now getd actual bound GL context and restores to it instead
>        of restoring to the console's ctx, for consistency with the rest
>        of GL context management fixes that ensure context is bound only
>        when necessary.
> 
>      - Improved virtio_gpu_virgl_update_render_state() with force_ctx_0()
>        and unbind_ctx() to make deferred GPU resetting maintain bound GL
>        context properly.

Both the new context management improvement and the MAP_FIXED API 
changes look good to me. For the whole series,

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thank you for completing this change.

Regards,
Akihiko Odaki

> 
> v18:- Changed dpy_gl_ctx_make_current() to use first scanout when unsetting
>        virgl's GL ctx0 and improved naming of cmd-processing function.
>        Suggested by Akihiko Odaki.
> 
>      - Added "ui/gdk: Unset context after GL operations" patch after
>        realizing GDK/GL code needed more gdk_gl_context_clear_current().
> 
> v17:- Rebased patches on recent upstream, updated doc patches with new
>        drm native contexts supported by libvirglrenderer.
> 
>      - Applied minor change that was requested from Akihiko Odaki
>        by moving virtio_gpu_device_realize() for MAP_FIXED v10.
> 
>      - Added virtio_gpu_virgl_update_render_state() to virtio_gpu_fence_poll()
>        that was missed in MAP_FIXED v10.
> 
>      - Added new patches fixing another GL context switching problem I ran
>        into recently with virgl commands unexpectedly processed from CPU
>        thread instead main-loop:
> 
>          ui/sdl2: Unset context after GL operations
>          ui/gtk-egl: Unset context after GL operations
>          virtio-gpu: Unset context after GL operations
> 
> Alex Bennée (1):
>    docs/system: virtio-gpu: Document host/guest requirements
> 
> Dmitry Osipenko (18):
>    ui/gdk: Restore original context after new context creation
>    ui/sdl2: Restore original context after new context creation
>    ui/sdl2: Don't disable scanout when display is refreshed
>    ui/gtk: Don't disable scanout when display is refreshed
>    ui/sdl2: Unbind context after GL operations
>    ui/gtk-egl: Unbind context after GL operations
>    ui/gdk: Unbind context after GL operations
>    virtio-gpu: Unbind context after GL operations
>    virtio-gpu: Handle virgl fence creation errors
>    virtio-gpu: Support asynchronous fencing
>    virtio-gpu: Support DRM native context
>    docs/system: virtio-gpu: Add link to Mesa VirGL doc
>    docs/system: virtio-gpu: Update Venus link
>    virtio-gpu: Remove superfluous memory_region_set_enabled()
>    virtio-gpu: Validate hostmem mapping offset
>    virtio-gpu: Replace finish_unmapping with mapping_state
>    virtio-gpu: Destroy virgl resources on virtio-gpu reset
>    virtio-gpu: Support mapping hostmem blobs with map_fixed
> 
> Pierre-Eric Pelloux-Prayer (1):
>    ui/sdl2: Implement dpy dmabuf functions
> 
>   docs/system/devices/virtio/virtio-gpu.rst | 121 +++++-
>   hw/display/trace-events                   |   2 +-
>   hw/display/virtio-gpu-gl.c                |  62 +++-
>   hw/display/virtio-gpu-virgl.c             | 427 ++++++++++++++++++++--
>   hw/display/virtio-gpu.c                   |  15 +
>   include/hw/virtio/virtio-gpu.h            |  23 +-
>   include/ui/sdl2.h                         |   7 +
>   meson.build                               |   8 +-
>   ui/gtk-egl.c                              |  17 +-
>   ui/gtk-gl-area.c                          |  28 +-
>   ui/sdl2-gl.c                              |  81 +++-
>   ui/sdl2.c                                 |  42 +++
>   12 files changed, 760 insertions(+), 73 deletions(-)
> 


