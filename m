Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A11DE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 07:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsbbY-0003dT-N3; Wed, 18 Feb 2026 02:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsbbW-0003d5-UT
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 02:04:11 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsbbT-0000yo-UO
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 02:04:10 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61I72T92036720
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 18 Feb 2026 16:03:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sq2NND321PSbFSgUHyGUove1i8mdbuE5JFaP5xAXOkg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1771398215; v=1;
 b=gcOEf8mtvUjJMzajn4uvotRdVPF0L2sUNlnw+mVgPeqPRSyP7o25hpmNT3YNuYMh
 Yh6OtLxrPxHmBvt+1sZ0JB0NCl64WNq6R/zoSvZmorFRMmsSNK46MrZlROKELtuT
 Se2xyWIxVLOZpDGv2L7A6UeCQPOjZtUSlqDlu4+TK+VyX83sKPkMcVyC7OIBHKt8
 eiMWMFp60yJfufw6BjIRRtucOZtiMsDkI0y11RoUHQzzqNmIeHSsk+O5jQqq60gl
 CUCcIxBIQavK73KbBenxItTlDPq/gMsrHPJ07EjgiL+AZdKE8rpR6Iv1WTyBmWyK
 O0yXl2NnHvplvOj1kTgvew==
Message-ID: <080bcab2-6f4a-43bc-b62f-64447f0f3eb7@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 18 Feb 2026 16:02:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/19] ui/sdl2: Restore original context after new
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
References: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
 <20260217214928.2970885-2-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260217214928.2970885-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/02/18 6:49, Dmitry Osipenko wrote:
> SDL API changes GL context to a newly created GL context, which differs
> from other GL providers that don't switch context. Change SDL backend to
> restore the original GL context. This allows Qemu's virtio-gpu to support
> new virglrenderer async-fencing feature for Virgl contexts, otherwise
> virglrenderer's vrend creates a fence-sync context on the Qemu's
> main-loop thread that erroneously stays in-use by the main-loop after
> creation, not allowing vrend's fence-sync thread switch to this new
> context that belongs to it.
> 
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   ui/sdl2-gl.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 3be17d1079af..ea2301305d3e 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -168,6 +168,9 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
>                               SDL_GL_CONTEXT_PROFILE_ES);
>           ctx = SDL_GL_CreateContext(scon->real_window);
>       }
> +
> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);

Looking at this patch now, I think this should pass NULL instead of 
scon->winctx instead. The patch message says it restores "the original 
GL context", but with all the "unset context after GL operations" 
patches, no context should be bound. As those patches do, this should 
also unset the context and prevent a thread from keeping holding the 
context.

Regards,
Akihiko Odaki

