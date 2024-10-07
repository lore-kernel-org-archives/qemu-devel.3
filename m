Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5392ECFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkFa-0006J0-2C; Mon, 07 Oct 2024 05:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxkFX-0006Ia-8V
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:41:55 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxkFV-0005Dg-KW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:41:54 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e1bfa9ddb3so3176169a91.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728294112; x=1728898912;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ehRLYOqJMlyPgZRW62N1mZWU9xDQTIDSc0HZbfKZiE=;
 b=cW6DGtDbIuKkqfYf9QJYJb28YIubtWPFmxk3FXvzGXArOTvJvSmPQzfffGp5OVHHXM
 raFVW6CkXPwb/8TaZeczkXO/PZwHrjio/KD3OLyukVG5yOgrMrW6XUas+EGRow8Hd1DV
 hbBWOkSkStEu/aVcNndav9KO41RzsRPR5Gp+RuB4jZNmFde+LZL1s1LSbZnv3Xrsd+Lc
 GqhNhiu9f7w1QTOEVU/LumB7RiLvmxVkiv17TwDDZ0nrg0sk3KvV+9xVR7jZrYWovEvM
 w02UpW7QL6HdbD4p4oEygmlDMTh1jXhysIVSc7W15zzaRRW2PfegKTpthD0hQG937yKU
 0Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728294112; x=1728898912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ehRLYOqJMlyPgZRW62N1mZWU9xDQTIDSc0HZbfKZiE=;
 b=HMEvnbrMOhT8orDLxgokq2Qd8o5opWpNEoBXAEhdHxQ335TxGZ/OU8peZTL7A/i/Po
 UhmdUtQVz6mh8JZ/pFvMdi+DHBYZrYIgvzWePvy36lbq6yPLlpCD0rMwFchphYDITvOp
 y3U61KglqhMyo9bSs/TGidFVaB7VYhdQY/v6mCsjY0H49jdb3ymCLqL4WEyouJWQ7bID
 GVU/yQBKkII2l8DRZh6RkhewzGD+wuJ0p+bgEN7f1nvkSVUsETGmEUwTKuY+mIaTtc6C
 VqhpkrHQn1xE8kN6LOjOrt8KpVqphe432Kq+EYcC/23je9RnhLBMw/up4CaEJ6jZ1me+
 7USQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh6tuwIPlxDvXirTntCVYPfG1yfjnbu7AOxMACtEBUWDOhHcugnTAnnOlOALkBJRRMhvK0AKMa3sqU@nongnu.org
X-Gm-Message-State: AOJu0Yxnj3Gr8l2xTte9RHO8Liam6N8dGdwL+n8oRjH4P6+TUvw/F5Lt
 BjFtK0i/4tBNE5iOpHQaXevvEJeE6+ts0tZ+sTnFsCz1IzyQvvPzkQlbAoH7kgk=
X-Google-Smtp-Source: AGHT+IEnC6HOTMmjS8l3lJieLXEIhh0ERQ42AvOErS02dDLzOKR0FhuRZDhflodulGpftCWOcvM1lQ==
X-Received: by 2002:a17:90a:e7c7:b0:2e0:9b59:c0d0 with SMTP id
 98e67ed59e1d1-2e1e63e3315mr10597475a91.41.1728294112071; 
 Mon, 07 Oct 2024 02:41:52 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e86a9400sm6571412a91.47.2024.10.07.02.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 02:41:51 -0700 (PDT)
Message-ID: <02d2089b-3d67-42ec-9efb-4287fc9dd3b0@daynix.com>
Date: Mon, 7 Oct 2024 18:41:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] ui/sdl2: Restore original context after new
 context creation
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
References: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
 <20241006232350.3198759-2-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241006232350.3198759-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

On 2024/10/07 8:23, Dmitry Osipenko wrote:
> SDL API changes GL context to a newly created GL context, which differs
> from other GL providers that don't switch context. Change SDL backend to
> restore the original GL context. This allows Qemu's virtio-gpu to support
> new virglrenderer async-fencing feature for Virgl context, otherwise it's
> impossible for virglrenderer to switch GL context from a thread that waits
> for async-fences.

The expression "to switch GL context" is somewhat unclear. I suppose it 
means to switch to the newly created GL context. It would be nice if it 
describes why such a switching operation fails.

> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   ui/sdl2-gl.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index e01d9ab0c7bf..b1fe96d6af22 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -168,6 +168,9 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
>                               SDL_GL_CONTEXT_PROFILE_ES);
>           ctx = SDL_GL_CreateContext(scon->real_window);
>       }
> +
> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> +
>       return (QEMUGLContext)ctx;
>   }
>   


