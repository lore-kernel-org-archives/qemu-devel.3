Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E05C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Maz-0004wO-DB; Mon, 28 Apr 2025 07:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9MaV-0004QX-PT
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:23:52 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9MaS-0004Q0-Pk
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:23:50 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4769bbc21b0so55137101cf.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745839426; x=1746444226; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t+8Mt3Ml1JWakzvw0Ml1abS9iDSvbm9RWEfJJSwrjo=;
 b=fKl7wDGG/O8E9qD6PJZfNzbg+3zQ9MFl7p3s+fNFQ14sI46qDxRYATuMf+k9+BJ0xE
 R4l9uZC81AQNCLTRQowVwNNGt3gEq5BqYKP8A3nudjV1XJ+YPH1XlUgsm6ddF8YkYa4x
 gvsqmNfLS1B6WQFurTs4Nr579/RuZNtcKQ7vF4J1K94buhQ0SLbkaAYwUjPNOn89pHwY
 MoUw/B6Ea6MqMok2C2+ZBc6weDjKA52lzVOOYZ/ej9Y3meWLU43LuZLEWE/ILTqVthWA
 ToDpCbEMQIKDPXEFcSenIvPyXcDdVLLFvqZQwNt76A8kTETLPB9FIcp574Xspgf3HpZC
 0xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745839426; x=1746444226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t+8Mt3Ml1JWakzvw0Ml1abS9iDSvbm9RWEfJJSwrjo=;
 b=OdDY0zkqX2aSSrD0Uok+YgiqlqqBtUDZlihnhvOJwpzB51EYyMbVmmrb5g+dLGLOKr
 1I5U5ZdVD0SG0KAMQXX8DwJE68MyYrZV4ZXaxMDr93ZlrG4nDD6xvQg7QqYNLuoeFiI0
 nbJism9K08RyVt4YlNaWG3WfjobdVgR5ln6+pMIQ3ZFWh+rRifJ+AVZHlYLk4Y9xjCxQ
 P0K0SiZ5/rikd0U90Ex1J0r/2yw75s8eOEBFh/Xna8Pxw+Gn/RNgCw3GWZUWa9D+Mg8Y
 VYQHO+XWwsIcfqSbOTkbwyqvjMdm7BtqqK2XNo7yY9ntwkafHsTNIZB8FD57hWZiaznc
 ezjA==
X-Gm-Message-State: AOJu0YyNIGZUssPgArBiSYb+n2s9rGCKqsjsEGosqHH8QorQraMo1trK
 UFuCoDNPu8eJgngq9/Fk9fxVJxT2/o+d4WJMlBOAb1gyfx1mYSH+8c2exGIxFs4epusE1hHhQip
 aqSNsHtKBxS6YGwm6hoFv2aH+CeY=
X-Gm-Gg: ASbGncu947Xnvfkbb3xkalTCIhlTV5QWlmuqq8vgH3tzSV1qjkQI1Tcg+S2pu9Xxg3I
 IcGsTcH6dXU7RN2cce87TNSdyWf9kS1egX/8EXpViGuOJLaOombWoe4UJjAUrkfvp4kjYimiG3q
 tJiKNG6Gb3zRPObd0YHec/GODQl3MUfRp3kIN+COBLJWt91Zr13oSQIyI=
X-Google-Smtp-Source: AGHT+IHGI7vh0A/a4CT5KNwkubYmTM3ci7egfOyX0Tij9vfDz25rEv8BfYG3168fjP0xroKN44B7X2TnVOmGQ7GnkXo=
X-Received: by 2002:a05:622a:181c:b0:477:6c0e:d5b4 with SMTP id
 d75a77b69052e-4801c2c3a5emr209669691cf.2.1745839426288; Mon, 28 Apr 2025
 04:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250419094959.224954-1-weifeng.liu.z@gmail.com>
In-Reply-To: <20250419094959.224954-1-weifeng.liu.z@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Apr 2025 15:23:33 +0400
X-Gm-Features: ATxdqUGGCntVRPvWO2Fe_GPfOwfnUl62hDp57RfZ94v6xNhBRfbHNb0GVoOhdZU
Message-ID: <CAJ+F1C+jPtvsY0yy9rZJLRLME9cC=p1bRGrXA3G1XQfJUmDXrg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Properly apply x/y scale when rendering GL area
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: qemu-devel@nongnu.org, hikalium <hikalium@hikalium.com>, 
 Alexander Orzechowski <orzechowski.alexander@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

Hi

On Sat, Apr 19, 2025 at 1:51=E2=80=AFPM Weifeng Liu <weifeng.liu.z@gmail.co=
m> wrote:
>
> On startup, scale_x and scale_y were set to 1 that didn't reflect the
> real situation of the scan-out, resulting in incorrect cursor
> coordinates to be sent when moving the mouse pointer. Simply updating
> the scales before rendering the image fixes this issue.
>
> Cc: hikalium <hikalium@hikalium.com>
> Cc: Alexander Orzechowski <orzechowski.alexander@gmail.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>


Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(Hopefully someone has enough motivation to actually understand this
change better - otherwise I'll simply queue it?)

> ---
>  ui/gtk-gl-area.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 2c9a0db425..01235f876a 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -42,6 +42,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>  #ifdef CONFIG_GBM
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
>  #endif
> +    int fbw, fbh;
>      int ww, wh, ws, y1, y2;
>
>      if (!vc->gfx.gls) {
> @@ -53,6 +54,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
>      ww =3D gtk_widget_get_allocated_width(vc->gfx.drawing_area) * ws;
>      wh =3D gtk_widget_get_allocated_height(vc->gfx.drawing_area) * ws;
>
> +    fbw =3D surface_width(vc->gfx.ds);
> +    fbh =3D surface_height(vc->gfx.ds);
> +    vc->gfx.scale_x =3D (double)ww / fbw / ws;
> +    vc->gfx.scale_y =3D (double)wh / fbh / ws;
> +
>      if (vc->gfx.scanout_mode) {
>          if (!vc->gfx.guest_fb.framebuffer) {
>              return;
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

