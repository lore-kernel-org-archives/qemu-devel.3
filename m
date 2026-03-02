Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA126D58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 05:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwJY-0001ff-Dd; Mon, 02 Mar 2026 00:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwJV-0001cv-MG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:59:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwJT-0003M0-6e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:59:29 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6225wxd7025418
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 2 Mar 2026 14:59:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TRnZHZ/xSz2uBRk03bbwb4UPO8vJnYWr5HpGppm7VOk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772431140; v=1;
 b=k2fPHtp7XU0QnVaLXqAaOM4vJ1TdMuWHsd/ma5jJisYVk8DXGCLzqhXohWbByK6s
 dZYkQjzZS/2RnIH3sDctjUlsT0kAyQAmowmPA3y2L0o1cntW/tYCwyn17xftPE2j
 EU+DjiBv7sIe32iKK8CTnrGl+/mYmuZJFW8CpauXvQ5909ljJAwbhbukzXSvv9yD
 l9T5TF96nR5hiN62CSnVxZinsADtYgUMDa68ITcr8PKrweZD8/7/2bT/Yy7PwFHU
 vrn5PO9MAzT9x2Hq2c9N4lHgCttD2j/IfG/0dl1fNhklG+2F2c/yKfFLQJ4mROcI
 Rx4Lk/vMtM31WNdQp6qfPw==
Message-ID: <ea2b4664-fa77-4ea5-abac-bee42f98c8c6@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 2 Mar 2026 14:58:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/21] ui/gtk: Restore original context after new
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
 <20260301204838.596994-3-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260301204838.596994-3-dmitry.osipenko@collabora.com>
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
>   ui/gtk-egl.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 0dbb429958e5..be769bcbfbb1 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -218,10 +218,17 @@ QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
>                                       QEMUGLParams *params)
>   {
>       VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
> +    QEMUGLContext ctx, current_context = eglGetCurrentContext();
>   
>       eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                      vc->gfx.esurface, vc->gfx.ectx);
> -    return qemu_egl_create_context(dgc, params);
> +
> +    ctx = qemu_egl_create_context(dgc, params);

I think it's better to change qemu_egl_create_context() not to require 
eglMakeCurrent().

Regards,
Akihiko Odaki

> +
> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
> +                   current_context);
> +
> +    return ctx;
>   }
>   
>   void gd_egl_scanout_disable(DisplayChangeListener *dcl)


