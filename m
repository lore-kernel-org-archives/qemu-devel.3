Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2029BF436BB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmLd-00073z-N6; Fri, 17 Apr 2026 12:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmLZ-00073X-Qu
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:47:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmLY-0005lF-3z
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:47:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so13519695e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444430; x=1777049230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQ4h1UD4AUxGiWPVBEk10Epis/sCNJJ+eXo3oJDn2hc=;
 b=kw2T73u6/Mi6rq4P7s1eNO/CRafvxcl7ZH3auVk1S+pdd09T7QmTzbNglfSTCTa/wu
 g3AkJos30mJHOLfzP+UeJUe4nPWt+60hguDckAOT9o585hIqteB54WVLeImJvkRVLCiV
 vhEnfIz84gzzChv+DvR5j3/U+fqutw9qp4t5TlaTLXXIFMJrmIvuTw1Nf6X1QRetMxjm
 wmrEsIOrFQe8k9aKHFV84M3m+xG0a9qmpl/ecC1UV433jIbLDusl99FnjqHvaYUV2oTx
 GtWXU/fIiTRP3h9FSfJhv/ya65YnTzeae8P0Ij+GbNtsazUkNrFop5ZhoTOpUTcDZPqW
 EOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444430; x=1777049230;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nQ4h1UD4AUxGiWPVBEk10Epis/sCNJJ+eXo3oJDn2hc=;
 b=b52QDjWb8uLJUKtOMcds98rXuEHRhB/74BhzeZbSeQJTiWkrdwAzHsDgYzyvtV7wuO
 8nflxCt2bFlcGJnhdrigTbS4eS/Zz/C3ABcg1bIBfjBm/beI4jX2t6GhRhDpoNHGhMx9
 S88K52XQUi+9Ktak1nToCA0nu4GPZCV0ZDbuqzCw3YGAlZs+SEyW3/d+NOQx6sWui01V
 wMvVWNlTE070hUBjbMxdMRrR7uPzwI25Zc9i84A+glVjk+MryVX4ZI/8a1GnKXymua/S
 PhcvKyKIvotVaTBMv91fX5K8AeJT2UgRUcLwTYGZkSQhKQcbbLuMHCpJ2TAhPSThoh+3
 /vhw==
X-Gm-Message-State: AOJu0YzVeut7LET/8dqwcAnneUxz4Hu9CPsKnQvfDuKndoURRiK8DHEM
 0COZnWzRT8fhab+r7phGnu+gFTZt0boBTm5ow5emPb+96nEAuO2x9Smkp9SqSIdfnqKwtngC871
 ySceM/9Hwhg==
X-Gm-Gg: AeBDievjzmiqLVulCrSQN8pYroNJMbKTe6PmFFPtUbwq8DXWIKt4D3/bRPZ4cu1oRcU
 LzcNZFUxybALmxwWLfv2C6aGk96INHvyPGmdRe7FOMcD2bU2IcOMaG+NsNfqLyWWMR26ZDNUjNc
 A5lUvpUoU/B9l/BgAQBpqa9SIzS3Z1mXOh2KDKRHd2qsHcFJMS6uSUryTz703XfQuObGv9xIQcR
 kjifU/xDvuCo//+GFzTCYPIoBOhBAp1NPNvly2CuBuBfGuc95lkVPab4OUJTeluIbLLppAA5pZh
 yvh/zGrvFfNT0T2h4ru1esstUXC7QJXk5L5aHj3l4cEvQ9KEtIh2d08eEXQ3QXtf6BqijSoMuFq
 z/kcW3kv8h2f7ktg5ovV5FbC0GLInASu2cifN7JCwjYobu3CvbA60wfn/wbLPYkXcmF8dQr8yXe
 /rZnhUlPSJyZBYFXB1yBieOEpuBlTP+1bxAg==
X-Received: by 2002:a05:600c:8582:b0:485:4006:960c with SMTP id
 5b1f17b1804b1-488fb7710e1mr40723245e9.16.1776444430491; 
 Fri, 17 Apr 2026 09:47:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm50295405e9.11.2026.04.17.09.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:47:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 212325F94F;
 Fri, 17 Apr 2026 17:47:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anthony Roberts <anthony.roberts@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui/sdl2: Fix assumption of EGL presence at runtime
In-Reply-To: <20260409110256.684-1-anthony.roberts@linaro.org> (Anthony
 Roberts's message of "Thu, 9 Apr 2026 12:02:55 +0100")
References: <20260409110256.684-1-anthony.roberts@linaro.org>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Fri, 17 Apr 2026 17:47:09 +0100
Message-ID: <87zf31pm9e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Anthony Roberts <anthony.roberts@linaro.org> writes:

> The original commit had a section of code which worked on the assumption
> that if OpenGL was enabled at build, it was present on the end user machi=
ne,
> and calls could be made to it. This is not always the case (such as Windo=
ws
> on Arm devices).
>
> This line should have also included a runtime check.
>
> This commit moves the relevant line to inside a runtime check for OpenGL.
>
> Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
> Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>

As this got missed I've queued to virtio-gpu/next, thanks.

> ---
>  ui/sdl2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index aaaede56e0..987ad334bb 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -120,15 +120,15 @@ void sdl2_window_create(struct sdl2_console *scon)
>=20=20
>          scon->winctx =3D SDL_GL_CreateContext(scon->real_window);
>          SDL_GL_SetSwapInterval(0);
> +
> +#ifdef CONFIG_OPENGL
> +        qemu_egl_display =3D eglGetCurrentDisplay();
> +#endif
>      } else {
>          /* The SDL renderer is only used by sdl2-2D, when OpenGL is disa=
bled */
>          scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1=
, 0);
>      }
>=20=20
> -#ifdef CONFIG_OPENGL
> -    qemu_egl_display =3D eglGetCurrentDisplay();
> -#endif
> -
>      sdl_update_caption(scon);
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

