Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D103DFD8764
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ttb-0007kM-Qz; Tue, 17 Mar 2026 08:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w2TtY-0007kC-FP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:51:37 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w2TtU-0007JA-Ko
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:51:34 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-5091d71aa11so10923011cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773751891; cv=none;
 d=google.com; s=arc-20240605;
 b=b3KxX3I3nDS/4rZ8vnw2AgO9M5g0FQ6uHg/Lc2vHnBeRnesElSu94BLyIiSk+4hQis
 TFsnZDIqLG07wEWTyM1HQn7UQyAsy6gux8FXV5OrloxkfTlDG4LYJpPTOY+X5j3ucRm6
 qUKov2EhoClH98XYmdw0agHvgje29VQoPD7HbcGklGBOgkTs3sKMPzV0F3eOeY7Xt9jo
 SRFxa8tdltQCOIuim8OFChq6r1ws8R1zKYA1akuCeDsBWImjrHMCXdr+iwKAS3QJ87jd
 1JpB+P3H5l4H6VtHINRouMNCXANir95qx0dKxoL/oz5+V1UAhX+rWUmSONz1hixPD2RX
 IHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r5TlraWlq3PYY+El06ryqoJN5XxDMGmXvNFpOklsC7M=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=WY4TUmT1K1gwEx7Ota5kJSyePibq3IZzOfUEJIM5B2bYR9bdU+uTAMD4l0xT1kpe/t
 ViUR1X+r2/oG1RBi5yzIRHnGAhrORjcwRoi+BSYFQAqn/hhmD67xeBFQcZFmlqS0H5oU
 8OJ8VCeaZfBl+4VrBQkSiwz0YKP32yOttbrcsooFyTK6VkBVod8Jpl1duVGtO88qZsaR
 uWpXKZpPgaIByqVFTxxuOLOd12zWzoEkmMsD2xRdAs0/jFcol5zYvqbgYYQ+m6rV5O9v
 9F0ttUhVnD5NbeNKf/YHtr4jtLjz1PtOMCni52OfYQ0ZMF+fzlrQcPzqFaI6cf4uquVj
 2oZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773751891; x=1774356691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5TlraWlq3PYY+El06ryqoJN5XxDMGmXvNFpOklsC7M=;
 b=Zq7UR3xdsAoqQugaeTedL5Zk8jwkWQSLlAmV+fIgqBbS8X6Iod8wQIR14vFBW3aWKo
 Osb1RRI9o+35h+QlKVFZ8NbxuhDZHPK+4dI872J2M6lk00N2EMiKabb6DMWKgoyyM4Jf
 o167E1622EFC4pKWDkwbryaLLsSCWdMlCQtg38cjrYqr3QVgFVsFi2G8SfGrBuDprKQd
 3HffGD1BSpdLNho4xYTZIkoSHC+lUqXIfNmJh6rAw9DsG0zepl0IM4jp1wEUi2b9+R/Q
 rWVw5nnlmMK453AoprDTZOK5A1tloniHCv0Qz5WLb531IDyEFbHtVYMSaJdufH5UHJvA
 maWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773751891; x=1774356691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r5TlraWlq3PYY+El06ryqoJN5XxDMGmXvNFpOklsC7M=;
 b=hsHxtJ2tvmbJjOgqp4nh0OV3FXk9GT7r9wwgEDtG+rOcbpo6XVRg6oxDMFqzENOF2f
 dZ8/2F7XIqBOlR3Z1BHvytvoTCDQEvBFtmueFJBFx1MMyMAtR7CewjScx0MB3Wf/SqL/
 XFu+GXNvmDsVXkw48f49sH0N69wOCYn48vihpLrUjaz8uJkf2WrDAPABpbptvC2P+8NM
 /598+LNo4Ch5C5lHWnW1+j93GTp3tvLjfXsE82N3V71SyKAyVzCp206WoOaemRKrhSO1
 Y7qwRWXZHcIoLIfTPLi7BdwZm7KCa6WB56CezbH7sOyUGGhInS5LWcg6shKV82lbItbe
 bGKw==
X-Gm-Message-State: AOJu0YzHuPvQS8ybjdS+VIIsVYO49cmofKzaLPvod0AYNpcIdhbyKbLj
 d5aST3QZIBeMYzSbO3UNqTu7fcn4LLkCYjO8YuNvBT8XzE5jkzJDPtHyGPelbeUKDAmCe+Gvn1W
 ZmoNgv24sUg6GloPcuIBDNJ7M40i1xnE=
X-Gm-Gg: ATEYQzwjfWVM308PMX8OdU29QG5eGtjTF6+Q4ezurOpPlR0iop0J4f0u4jni/v346lI
 dk+IeIgV3Po9w+PenPdYvUfu15XirVoUzqrqL2983zKlozq0PJ0t+bCyELH92bCYOi73zfXumo/
 4J8dhweP41yX+lo64y6m3dUyeUT4+wi8T/uqAE2LAv1ERMq9kTk4c4xigv4pAwhhWD0TJgMD2fz
 rYNlMAhxsXTjybxdGBwaKBrMT7ym5JdrF8Z78DBB8KxTRp1BqyEsRQCfyS4u7vilSa3MrhFfQo5
 9wl/11qz
X-Received: by 2002:ac8:5702:0:b0:509:2135:ed59 with SMTP id
 d75a77b69052e-50998178d61mr40239821cf.36.1773751891343; Tue, 17 Mar 2026
 05:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260303010844.1925737-1-dongwon.kim@intel.com>
In-Reply-To: <20260303010844.1925737-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Mar 2026 16:51:19 +0400
X-Gm-Features: AaiRm52YsRV1dQgBH9rjVHKVKUo60uK2EUM07UYEvGkZiCYB07PUlJqph-Q9LyU
Message-ID: <CAJ+F1CJ9E9YyWMcJVTSRz2ehJegQbuud8T4j4vqowubnBg_iHQ@mail.gmail.com>
Subject: Re: [PATCH] ui/egl-helpers: Fix FBO recreation and prevent texture
 accidental deletion
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Tue, Mar 3, 2026 at 5:14=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When egl_fb_setup_for_tex is called, we must handle cases
> where the texture ID is reused across different GL contexts.
>
> Texture Preservation - If the new texture ID matches
> the cached ID, we must skip egl_fb_delete_texture to avoid
> destroying the texture we are about to use.
>
> FBO Recreation - Because FBOs are context-local and not shared,
> a cached FBO ID from a previous context is invalid. We must
> generate a new FBO handle if we are re-validating the same
> texture ID in a potentially new context.
>
> This prevents stale FBO usage and unintended texture deletion
> during context transitions.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/egl-helpers.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index e3f2872cc1..7ac64f3ba8 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -111,15 +111,23 @@ void egl_fb_setup_default(egl_fb *fb, int width, in=
t height, int x, int y)
>  void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
>                            GLuint texture, bool delete)
>  {
> -    egl_fb_delete_texture(fb);
> +    if (fb->texture !=3D texture) {
> +        egl_fb_delete_texture(fb);
> +    }

That change makes sense, and prevents reusing a destroyed texture.

> +
> +    /*
> +     * If fb->texture =3D=3D texture, the existing fb->framebuffer is ti=
ed to
> +     * a previous GL context. Since FBOs are not shared across contexts,
> +     * we must create a new FBO for the current context.
> +     */
> +    if (!fb->framebuffer || (fb->texture =3D=3D texture)) {
> +        glGenFramebuffers(1, &fb->framebuffer);
> +    }

This, I don't understand. Assuming the framebuffer is used in a
different context, shouldn't it generate a new framebuffer regardless
of the texture?

Also, aren't these leaking framebuffers?

Can you identify cases where egl_fb_setup_for_tex() is reused in a
different context? shouldn't we prevent this instead?

thanks

>
>      fb->width =3D width;
>      fb->height =3D height;
>      fb->texture =3D texture;
>      fb->delete_texture =3D delete;
> -    if (!fb->framebuffer) {
> -        glGenFramebuffers(1, &fb->framebuffer);
> -    }
>
>      glBindFramebuffer(GL_FRAMEBUFFER_EXT, fb->framebuffer);
>      glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_E=
XT,
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

