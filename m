Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0664BC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5fQ-0000FZ-BI; Tue, 21 Jul 2026 04:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm5fK-0000F8-1f
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:17:26 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm5fI-0001Nx-CU
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:17:25 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-80a123ef90aso66395747b3.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784621843; cv=none;
 d=google.com; s=arc-20260327;
 b=BDd+xoBMZckzg6PhOASraaPYD0EHgezv1GfKkH6kxg+Nv7H3GUMc7eLO1R7vkHvZYn
 fe5VXKhrVPSuA1wdtYCG4XYj0np9z5r/7hCyja1/2dXrVqE6v8XHFSnI8JVUSK6qGSXI
 0LtpBcAc2YsFBNT1gdZWChOuAMhYj2Ovm1mk76dhdcHJkORJKlZPhEXLsL8eWpPOEcEg
 sIbiTHcVmYeKqFZBVvWXI0dD/n5zYKc3rwU1jR1ElQJ7Y3ZoIPKM781rn3m3S06zuboT
 3jVDbFsouvSEefyu4/ff+onHL9eVsGHkBYQZais2TYdE0CAtOhPOGjQR4JtLMREGW9vl
 Cvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uRmidZqvaK3SlITRFi+wxqFFhl2CGenbjqZsWNchpbg=;
 fh=anZl6Td6NaKjHGFM8y4oK3yu8UEI3L8plTd5OD+C2Mo=;
 b=iDJ2b0ivXMXWrSaROG1APJOC+6pv7Y2ElJ9/bMpUxFut9XH8/wEkf80Pa4DjirQISI
 WnznUM69RW2+uiJwItTWQ5py7Fh+rNVqmt5SRKiB2GrApR9tRfiyCirI3pbLe7WbG9EX
 P1RWUs4uk5b09wpNWl16EjAxPaV5jhW5NvwvVo/GOrWcQ1fev5cs3qjFdHoXV68NMzr2
 1WAZccjw0XBW+/u4V+sntK2+Zl9dLaTHPIW9RganfucwwI/mtgdczlsFYdTs/wvc74G5
 YOwtBci4V8kD4dAdUxLXqAo7jttHBRvnyZaIL7JvnEmkgz4qzuzn6IjVm+pIyUxOfZaE
 ZfgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784621843; x=1785226643; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uRmidZqvaK3SlITRFi+wxqFFhl2CGenbjqZsWNchpbg=;
 b=T7TAzmvT48q5OUSMvD99txSKlIm07QSD1pMTB8CIyUudErRGdb8iTGyqukefZ6dPGX
 /5CJ/12XGWry1pxp7m1LLCkBm8wZSKgSGbR1N8fA87Hgf7UiNJi75n8bz+Pys48iE0B2
 izg2t+GJvvY916p3d9IT3fm/XACiD6ypWDp2VTteDNYCLpK0jk3DJW95Hp6PSXDGtIdd
 UmFkpKDFFKuBqQCjKkiduymHcgxOOeIjJMQaL6bmABQFE/Z4yNS1Ykin+fA601Mq03Sq
 y0RG13UoDz6l83UmA3Fjg7ml18YE6FxBns3108/2VOaHLP6i1W099aAnsLLR+81B8ueZ
 QjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784621843; x=1785226643;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uRmidZqvaK3SlITRFi+wxqFFhl2CGenbjqZsWNchpbg=;
 b=c6IKLhXisZGW8a+hS9LjgISB5iZgMPx3t4MmE+XmHz10R/UI+/Ie2h8pyB6RmAByQD
 CNGuap1K3n7gyOiv8yQ3NGlPaH0m5/6abA00A0CVQ0To8b8tjLBh2zwx0EyvRrrTnCuL
 1DqyaFxZU4rTlD4/FFFML8jElF3V/xCSCPSPg1EiQ1uueZBSeYR8Wvog03vU2a4HwTQ7
 i2KFUbkrnH8UxaORaDLYJWLHxzjsGWYojppli6Np5gUkS+EK+bOk834QK5z7F1CLIAnn
 O5LGDqxzbgutsy9VXS+T8POzoy0hKXhmtGlety66BT5NWGscd+jc6f+GY/EM22izRO80
 d/FA==
X-Gm-Message-State: AOJu0YwIs/sE9qIDcd5Y5dqQ+Fff7WNFZefPMb7sNcmuCVjF8QtRSa9d
 8xmkheNqoV0LOMeNTZnGdYGL5WLPTF/aciSlNJFlgMOMmKELrYdy8BCCrZDyyhAHVANR4NvYxWD
 0p84mJxLvM5eMgAKgeYN+wbyK/mVrs7qwg5J2vGBS4Q==
X-Gm-Gg: AR+sD13DnnkxNDDx3ZPKw7p4AdV6IaYsaA+tKKcl4Vv9TLkRDSIk5uMyQj6d0EvWhJh
 zQaCmAa1U0ScBrdeC0YzVY5/NPgIn36+VROWEl0ra86rZ1N3J92tsdydvGHs39ifGA7l/Pde+xS
 cs6EPbEedU0RxOJoza7h3InbHpdweZk/P4uqxI0xMcg3tlQraHVIL+uHmwVPllFKbMxpj8vi8Do
 NaZYLYJPVsVnN7pnuIA+/8fb1qgxGXlMaaeO9Cc5bm5kHZKU3Egg1yl84gCC6uYr3WOmeh99lEM
 ySp6OJhrGSXrFR/vCZh2f1zH9llBp1PF0B50+Yp47VsgEg==
X-Received: by 2002:a05:690c:6893:b0:81e:7b95:c77c with SMTP id
 00721157ae682-81ee28f1752mr84175247b3.19.1784621842622; Tue, 21 Jul 2026
 01:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
 <20260717-fix-v1-7-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-7-cb9f7d49dc52@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2026 09:17:08 +0100
X-Gm-Features: AUfX_mweEwgykiOE-u7JfG6-JQICty0OsmAIfugw44mw9h82Z6l6zMstGbwvRis
Message-ID: <CAFEAcA_jkg8G=hQdsS-FEaHd658SbJqTzMAWrmvjREmXXbx1hg@mail.gmail.com>
Subject: Re: [GIT PULL 07/15] ui/vnc: fix out-of-bounds write in lossy refresh
 dirty marking
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 17 Jul 2026 at 12:54, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> vnc_refresh_lossy_rect() marks a full VNC_STAT_RECT (64) rows of the
> dirty bitmap when refreshing a lossy tile. When the display height is
> not a multiple of VNC_STAT_RECT, the last tile row is a partial tile and
> the loop writes past the end of vs->dirty[VNC_MAX_HEIGHT].
>
> For example, with a 2160-pixel-high display (VNC_MAX_HEIGHT), the last
> stat tile starts at y=3D2112. The unconditional 64-row loop writes rows
> 2112..2175, overflowing 16 rows (640 bytes) past the dirty bitmap into
> subsequent VncState fields.
>
> Fix by passing the effective display height into
> vnc_refresh_lossy_rect() and clamping the inner loop.
>
> Fixes: CVE-2026-61475
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3935
> Reported-by: "Vulnerability Report" <vr@darknavy.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 8d91cee4d9f..c957731877f 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3000,18 +3000,18 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x=
, int y, int w, int h)
>      }
>  }
>
> -static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
> +static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y,
> +                                  int height)
>  {
>      VncState *vs;
>      int sty =3D y / VNC_STAT_RECT;
>      int stx =3D x / VNC_STAT_RECT;
>      int has_dirty =3D 0;
> -    int height =3D MIN(pixman_image_get_height(vd->guest.fb),
> -                     pixman_image_get_height(vd->server));
>      int rows;
>
>      y =3D QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
>      x =3D QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
> +    rows =3D MIN(VNC_STAT_RECT, height - y);

Hi. Coverity points out (CID 1664010) that this added line...

>      rows =3D MIN(VNC_STAT_RECT, height - y);

...is a duplicate of this pre-existing line, so it does nothing.

Were you intending to clamp a different variable here ?

thanks
-- PMM

