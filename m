Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAF1CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1PD-0002FF-Un; Thu, 21 May 2026 07:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wQ1PB-0002Er-JY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:17:33 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wQ1P9-00059k-Nh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:17:33 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-303f2fb7225so4287472eec.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779362250; cv=none;
 d=google.com; s=arc-20240605;
 b=fmeeJHt4YgzHlktA6ESkfujSJ2hZdxhVRtQqLZOAc9TjudXFOD8sZOpA2H5DVqGgGe
 lBlHFj+kN6ZGSBC2H5x8quIh8XX/7UimbJ+/GxoAZOdx/72fqQzTGscRH0jWuuQsF45Z
 au5E/lu4x/okrMJk9qHkkVTr9+6OA2pUaHxxQl0pqrSiwmtTYrNCT3vxEJZjHFkEGxVt
 rYXSgh9bsJNnHeG+8CrJSwnnGi/TG/wr5VH0ACwD75NJTce61W3oozB21FrXDRcRrepl
 18jO+UHnnSXxN6xOBi616F/VNcpLGDxWARWCqIvujbdlw2igDi1AUUkdUkzh76qMPh+0
 gQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nIX3NTj9INwIfv1Bi9RBLvg4HVeaythAzpOSfbT011o=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=LHzTFt2/8IUuWBeOYyfOv5RdpBKGPgm4/DvXPtRDqzZRijHAwezzpEKJp9zudnHoBG
 r63CPN+Nhd0IN0NVonMnlK5Wf0ROKTTV/hJT3KByx2gNsyfEnPwG5NoE+C22QekKNf9g
 aYctvoXUouz6E4wbjWIsGhNE1b6J5OjhsWrujnVty9a3ZiMPgIvphsXzatFTpPU7QEoa
 r9qzPz/5sfIg6s6caWftMRrym56PvJhGJukbkrVRl96zD7MRDHuTe0GjtCdSqWcXdchY
 8SOD1ACWVhYgBo+Rcbv5q+O220gbMc2trPUiLzIxkk9IQSmDnDk4TsGkpZZl5/Tc/fXZ
 sNxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779362250; x=1779967050; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIX3NTj9INwIfv1Bi9RBLvg4HVeaythAzpOSfbT011o=;
 b=YxD3T/BieM9W4BV/r99s5N5tMWp1HOhj7vCNPyvhK15hA561c07zKG7jZ2YpfTALWN
 WZ8Yu8WllUfjjEQ7Xj0Jeazbm2ZUDuVrF+bdhyJNu5fTzS3jdsARO/s3gcilo59dzNFu
 QhOnVf9BOeNxXN9VXdNoChJK3IqO+16ldOudfjGyQ+BF0e+WPjiLeeqXJcYDTWxyscrO
 rwGp6l7vvbuCvXKdtTCXC3lsJGXFXSauF0IBrVLmUhaFaghJncNxZ2kYHrtqXr/a9kuG
 RSUyVFPLNOiERB55eCh1GLEA/appF6fJp+4/CN3RG8njhf3dhlFGjO+z6acwX/UvXHMk
 BYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362250; x=1779967050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nIX3NTj9INwIfv1Bi9RBLvg4HVeaythAzpOSfbT011o=;
 b=WstzcTcxRQZ2hv40F3DlVsQD2pd0gyBFqhXUpb+qLlGtw8LzI1/OjsHteqBXXoEOZb
 5PLYyfv8PlvfxJLcZLzAAvS3MtlMjKuoLp9LNBWhet0CFWVGOJDvePUOlU3dBs3JaJVu
 8jiMeYrF10nQyxfKqlh7lczo3xrtkRqLK47KxZoLNsqoPRkYkdn3uGuptUtpxXNLbRip
 1JBoaqezuAYOdQJ3VwGklxq4EjdFoRtsfWSTHzDakomdRzmcHOhsMU8QhL+3RAE3A2bD
 my+428THD+MhCjXQhmCMXWR/8fRNzD0vmWu3Qyr7TJYFMNabLP0fsSacxFSNq4Yc9N2o
 o2PQ==
X-Gm-Message-State: AOJu0YzIfy8um+faOMPTffpjnb5pHACWFLZFbBK9I73Qr1WKYF+HK/Fk
 xBLPq6T98wdO3CHGOzSwrA1BZMT1tk4pnnVCAuG2hQfQzxceqMcefvUEYiecri/euvEw9cYYZE+
 8rEtPcK/wr8aRjEk4d+Bmls5X2Qm5M80=
X-Gm-Gg: Acq92OEVOsSsSt7xnnv5FrNtSQrVSaaJ5e5ilmxQ+DKGYVpzWFbLqzuyo1mkE3/HTXY
 2HPqOJ2iLl1NRxhFEtTwbiYrRsgoHJ5hdKM6d4LDdHvGxBKJ3nWYTEjpNroRs4Xu/8VJs6wgp6I
 LCXu+5eNzIJluhXd49625albUxaRUTj/FDyKWeaCnmTKmk5vXbfyz05kW8hikXSgJkN6Crd3DSk
 QTMStnDd431Sv8r+ij2SuHsT5ZKabDXPqGdrYHPrU65JeQPdsiHP1GX6pUBznYq5oTdDE3g974m
 1TW+r0j4HmqMNnyT34u63MJ0vKWfuYbI8VYkv7Y=
X-Received: by 2002:a05:693c:2c0b:b0:2ed:e14:42ea with SMTP id
 5a478bee46e88-3042faf598fmr1426563eec.35.1779362249930; Thu, 21 May 2026
 04:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260521004226.1914121-1-dongwon.kim@intel.com>
In-Reply-To: <20260521004226.1914121-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 May 2026 15:17:17 +0400
X-Gm-Features: AVHnY4J8w8DtBzMGHbyphsolzc_pTqWFlQqIfaz320JH1s9YbpvcOaS4MNNUWVU
Message-ID: <CAJ+F1CLN+y6vopPwY2gE=dHPQAjptOxFjaapzf01aHmK1a+gVw@mail.gmail.com>
Subject: Re: [PATCH] ui/egl: reset framebuffer state when creating new EGL
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Thu, May 21, 2026 at 4:48=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When an old EGL context is destroyed, its associated OpenGL textures
> and framebuffer resource IDs are already implicitly freed by the
> driver. However, the cached IDs and geometry attributes stored within
> the egl_fb structures remain stale and invalid for the new context.
>
> Call egl_fb_destroy() on the guest, cursor, and window framebuffers
> in gd_egl_refresh() to safely clear these stale fields back to zero
> before they are re-initialized under the new current context.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk-egl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 7c5c9b2428..fd14b391ed 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -163,6 +163,12 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>              surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
>          }
>  #ifdef CONFIG_GBM
> +
> +        /* resetting old ids to 0 for new egl context */
> +        egl_fb_destroy(&vc->gfx.guest_fb);
> +        egl_fb_destroy(&vc->gfx.cursor_fb);
> +        egl_fb_destroy(&vc->gfx.win_fb);
> +

Hmm.. It looks like the whole block is flawed.. All the destruction
should be done before the new context is created in gd_egl_init(). Or
was gd_egl_init() intended to be called only once? Tbh, this is X11
stuff I think we should get rid of..




--=20
Marc-Andr=C3=A9 Lureau

