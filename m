Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0BACFB451
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 18:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxsGS-0003gK-Le; Mon, 07 Oct 2024 14:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxsGR-0003gB-8C
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:15:23 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxsGK-0003ND-V8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:15:22 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e075ceebdaso3385471a91.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728324915; x=1728929715;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4LqouA+i+jupi1YNBtUoZli+HVICtPE7Ga/Yg67kZLA=;
 b=e+s+ONnK11t9x/Py2T50rOiakInXh2vZ2CnneKfw7IqRbLx6dASlf+7+ugdbdR5UEq
 cScWnISYWab9jdSzug9/Loo2Ng3/RU/pDz6xIwrVmJcPrM5hCEaO9IDxf9BD/PJf9aai
 pAftCcDFmeCxkSFyzCxVMKfpDABE2Rv4GXwhmXGYiYC36VAc9ktU77x79E3ANHMpiQWE
 oHdjG9P9LwvsWrkDCYvvhtMz9g20jGjXc1NodvbCRWaf7LS/iToVPvdoJkvlSRb6UsGT
 2q238nMg71/d3yWrXp0mzLQAIxWdHclr1yeQdLl2RItvaYhfbgivPff5CR2YfTRKOrwS
 FsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728324915; x=1728929715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4LqouA+i+jupi1YNBtUoZli+HVICtPE7Ga/Yg67kZLA=;
 b=TgPFdG7qD93lWHGLSoGDfjfPV2s2kn7+yKI2b9182Un9NzARaVhRROn8KtzAlMRLYm
 n8hZFwqXiJQDIrTKHl/uhatOm7tQF8KKvNkxYRkxUW0+JmYkdWeLTX7/rMENy7WUui71
 GO8Zmm6Om2MHZtT/mMuYbqNqc7TK5r7N3UnaUWInVp1uIbrU54m3ArkY09C87T/mk9nu
 VE8IczFCRl1hYvwYGw6Xp0922uMsQbJKU0UTipn9B9/00wLKHga+jQmqQR8bI8X3GqNn
 z93DdMg9Z/9ZDSFb1RxcpUIHsK8qSPvzup+Aqtcf5yIZS2RL2hFcF6TekAsSkuI9NnxA
 2IDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE4C4LXS8FGi8B6uo61gpPjJPJpf9hq1msBJWEcqr+2r4ls5+6TgK2jSoYQMbHXDv4JFciCCgnyrx/@nongnu.org
X-Gm-Message-State: AOJu0Yy7faenaVzbh+wDdepxz5KyzseIL2saTTHOk9aJTvEKpso9ns5m
 CKPES7FYTxojjuydXaB1aZrEuL61iWFHga0L7jxfVGQVKOV9JVIOJm11srehEVQ=
X-Google-Smtp-Source: AGHT+IHrxVk4owZyQWDZR+8x0nWTl/HHv1T7eOBqO0Cuh65hcfMYfN+b9nBwjqPi1M8c1A5ch7KP9g==
X-Received: by 2002:a17:90b:4c04:b0:2e0:db81:4f79 with SMTP id
 98e67ed59e1d1-2e1e620efadmr14518164a91.2.1728324915423; 
 Mon, 07 Oct 2024 11:15:15 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b128847sm5756447a91.49.2024.10.07.11.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 11:15:14 -0700 (PDT)
Message-ID: <6ae662db-fba6-43a5-8be9-8de01dd4f476@daynix.com>
Date: Tue, 8 Oct 2024 03:15:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ui/sdl2: Don't disable scanout when display is
 refreshed
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
 <20241006234353.3201037-2-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241006234353.3201037-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/07 8:43, Dmitry Osipenko wrote:
> Display refreshment is invoked by a timer and it erroneously disables
> the active scanout if it happens to be invoked after scanout has been
> enabled. This offending scanout-disable race condition with a timer
> can be easily hit when Qemu runs with a disabled vsync by using SDL or
> GTK displays (with vblank_mode=0 for GTK). Refreshment of display's
> content shouldn't disable the active display. Fix it by keeping the
> scanout's state unchanged when display is redrawn.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>   ui/sdl2-gl.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index e01d9ab0c7bf..4975d923db38 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -51,7 +51,6 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
>       int ww, wh;
>   
>       SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> -    sdl2_set_scanout_mode(scon, false);
>   
>       SDL_GetWindowSize(scon->real_window, &ww, &wh);
>       surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);


