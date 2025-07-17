Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A19C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGf-0005d1-KZ; Thu, 17 Jul 2025 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucKqL-0001HE-QG
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:24:06 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucKqI-0000VH-Tk
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:23:57 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7183d264e55so6936977b3.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752744230; x=1753349030; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oy8N3oJhZgmaRv2TkjtpHwp25xp6e+hHsepELZyYigI=;
 b=y632JgrSw48SBJIEjqwNly93feUnW8dmmCwqRY+iaXsvPH6G5+p8Ezab3/4/F5UE9S
 BwqDecmcQLaqsPgjlidtvuyyVH7SkyBEHlHQWuCNxfzjV89liiS0EdnwJaxVjN3N8ntl
 W8FkseN9HlGUznDoi11yAOSEPIk0xOkIpp3lv7pw/OYkFMv5R9zWlVP+DNr85kLMr/lF
 AFnYlxX261fUmiPXfFYRXmMlQbqQSYVj9/aicCLvWCTL19LwGh4e+eLzjkq0O9g2kc2I
 fNYQ4LsNRYNdYH+7gGfb2oULqg0KL1MKFE+ZUHfrSX5DBCgMo/CudFy3L5M0/YFsve3x
 z4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752744230; x=1753349030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oy8N3oJhZgmaRv2TkjtpHwp25xp6e+hHsepELZyYigI=;
 b=fyoxw8NXDGLw8VQgW9VxYNkSQyuwT2KS6Jd2XDgkT/lUzPYbMvO2Yf3zf45Kd9FWPW
 5/73ciHQJAkIdPKDphUVSJ3XYED2cwc3yAilRBxTyADA7jGhClWyKPfdHnsOp9s4UoLk
 fsS+VgT7X6srttDCmYRorhgKXvR+Gtvdk/xMtD/Fa/tXDfCI9g+R16kug9/FUP2u3bwS
 7TlPMmoP5CbE8htNRNUk6kQ4rwi+IJGcb/TFL4eZV9XwXVPr9GFUe5Nl5J7cGCUV1X+w
 tFCBixtDHvjh9Yy56UHe3cAAyS5Mg8kFhZYrUZQWmLT35v6yowUwsoIn+UtVPuyjymYK
 CvoA==
X-Gm-Message-State: AOJu0YwcY5m/kvIZDwAHWkaoKhZj6S1YZaO8jX6MMo0/0c4EbhBcc5TV
 mSaqtHflukl9aOt5LwSRiVdCPr1DbsOsiKSI3wO5177e5HujcunFUI/C5Wl6LyeskCFp55BTZUt
 ufiRkxyOlhcus0RsjT2jkBc/1IrYzTQOqoYuuLii2+g==
X-Gm-Gg: ASbGnctBybSfcNPLMmqnZK7Iep8KH+WcTpm4tBsKu7crY46kxj39i/2lVdlQnlVCALS
 5AwI3/UOlFlf6OZRdw7f40/WK0p9U8qa5JW37CKyrLOUOTkqgdV42VBHzvijT/f7MrHBTxjE7Gv
 av+rviaLNTYeMzy1a45DxJasmEhEUWb9BVJMvnU4eOTQ5aqCgOOQ/0Yclc+cvqp5kvZlSiggMFg
 zZ7HuHhV3IECZq0VW8=
X-Google-Smtp-Source: AGHT+IGCuIfEgEzUnCGUtLFPi9YpCh2t6Ruu5Lk7hzw/tIWJi62c/871zWhBKGU6VaKu1LiScIIfnh1VinhEfSf+6co=
X-Received: by 2002:a05:690c:6704:b0:710:e7ad:9d41 with SMTP id
 00721157ae682-718a3361f20mr24922947b3.12.1752744230255; Thu, 17 Jul 2025
 02:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
 <20250715063301.145191-10-marcandre.lureau@redhat.com>
In-Reply-To: <20250715063301.145191-10-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 10:23:38 +0100
X-Gm-Features: Ac12FXyMxUKvAwvKDNRkgGvmPf-pPAhwgHyufcg-xjmOIaPEQiVfNAnkNQZxe4c
Message-ID: <CAFEAcA_humAdK=eco8GNgO77d9tJUP_mTsoyuG=uEFCCSc34pQ@mail.gmail.com>
Subject: Re: [PULL v2 09/13] ui/spice: Blit the scanout texture if its memory
 layout is not linear
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, 
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 15 Jul 2025 at 07:43, <marcandre.lureau@redhat.com> wrote:
>
> From: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> In cases where the scanout buffer is provided as a texture (e.g. Virgl)
> we need to check to see if it has a linear memory layout or not. If
> it doesn't have a linear layout, then blitting it onto the texture
> associated with the display surface (which already has a linear layout)
> seems to ensure that there is no corruption seen regardless of which
> encoder or decoder is used.

Hi; Coverity points out (CID 1612367) that this change
introduces a use of an uninitialized variable:

> @@ -1269,6 +1329,15 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
>          glFlush();
>      }
>
> +    if (spice_remote_client && ssd->blit_scanout_texture) {
> +        egl_fb scanout_tex_fb;

We don't initialize scanout_tex_fb...

> +
> +        ret = spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);

...and we immediately pass it to spice_gl_blit_scanout_texture(),
which will unconditionally call egl_fb_destroy() on it.

> +        if (!ret) {
> +            return;
> +        }
> +    }

thanks
-- PMM

