Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B41C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgi5-0006Uo-0n; Fri, 18 Jul 2025 04:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucgi0-0006LZ-Ar
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:44:48 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucghy-0004fO-47
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:44:47 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e5d953c0bso19990197b3.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752828284; x=1753433084; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6plV1daOnaS0viPD8kTW2UzxjVaHv69dHs3pH0C1vwE=;
 b=XEepcCyGMitm0FL9Vtabjob/LT/N3+CU2KrBeB3P19Goaa4D4hslyEje2deCfkF17P
 kyESkvJ2tai0Msmfkv2Dm7IR0zaNbPY6Vzs4n8KkHeT1vVdgmgoAd1PO6eB1sJHBXSSf
 IXdeyTcJkS7xOS82wk5sNvs3UEH9OQ0QR797nrZBQV+5ieyk56T8ds57ynJVF3GoxdZj
 67tv1zTx2+ZNdoxbeUqT4CF1RHmDCAAYSc8LRBJz2JSBrahE92Ywpe8mmbTKi/ffDXL4
 V3k2kWprxkryQN9gVHIbwEj3hWjjNMXquzC02vGHCPsbeNj8SnOvH6piSrKei18aPKRh
 520A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752828284; x=1753433084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6plV1daOnaS0viPD8kTW2UzxjVaHv69dHs3pH0C1vwE=;
 b=ZlVCcr+KWFE+b1KDdTrS5iFa6GgtYDYDVHtcLwZB790sGzp1uZJ980BUIDoEnfItyt
 IDhu0B/BjYiMDKNon7VXXDsDxJxvjXNUY+KHJpLxmVJD6aWgja86xFOAuEjKO+9b2JLw
 kw6crnyhYg4e0UBbFraFwfXc2jOPeWy6mlDRGhOLjvCw4neQhI+mmLK1wj5NtNg9SdCe
 NZhIKnkw1IVJ3Azilv1WDjebNagZzXr6hBK7XUEpAJmtIpYGD4V9it0hwOpLjQxntFOr
 P9VmnFDHweNiyaeQWB49GmszUq/QqnKibX1eQGHDqsd/l7JzRwm1jsuGRDVgdd1BYpDC
 csbA==
X-Gm-Message-State: AOJu0Yww4V8iu7I+giJpY3/30rHCPUdQtgofMWV74SggehYwqGr/iyoM
 LQnhW7C71tJ7g6NMSjnABz5UHZRqa3cduaESWNoSakZU6KDBDQBWFOpoRR1UzFtgrUw+2Vw4epo
 dJk+/8j9kcqov4tUyYX9cOr9az05ViGjlf00m5uN3Iw==
X-Gm-Gg: ASbGncsbvDGFcoiyF36uwnCc8DY/OM2VqvaYTkhR5X+sx+w2ncGRBM63iyjvC57HXY6
 ynpOOHlgRSxVOzcQuyC3qvHAIFyxtgBH5kiOLJqo6tFbzhqBxWgbDTq7W/yTig4oJeaNGTsT4lK
 CqEDBC4aFKIruLzci6cWyfywZcSyQvTQdwmprCXATIYDHMpsZBHGjaY1D9/icPAPBvBZy+4skiV
 oo/6iKE
X-Google-Smtp-Source: AGHT+IGXLzRoDOupopHjlm1O+E2XhcbjODJypBzPWavUO/jtOUufwfM2F6fJuz/SyGM9wRbjKxoThwqPR/2UPad5I+c=
X-Received: by 2002:a05:690c:620e:b0:718:37f7:66d6 with SMTP id
 00721157ae682-719522b1c02mr22993007b3.25.1752828284578; Fri, 18 Jul 2025
 01:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250718062607.2209900-1-vivek.kasireddy@intel.com>
In-Reply-To: <20250718062607.2209900-1-vivek.kasireddy@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jul 2025 09:44:33 +0100
X-Gm-Features: Ac12FXxWedL7Wt2vV45KEjLTvn7uM5c9l_AGVCrxNzgxtGyw65qtS8VU-vQMycM
Message-ID: <CAFEAcA-rTkSQe5zm2bLXA-DSoeo2pwC07NGPCGevwq7KXyE26Q@mail.gmail.com>
Subject: Re: [PATCH] ui/spice: Destroy the temporary egl fb after the blit is
 submitted
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 18 Jul 2025 at 07:29, Vivek Kasireddy <vivek.kasireddy@intel.com> w=
rote:
>
> The temporary egl fb scanout_tex_fb is only needed to facilitate the
> blit to the display surface's texture (ssd->ds->texture). Therefore,
> destroy it after the blit is submitted. And, also make sure that it
> is empty initialized before it is actually used.
>
> Fixes: f851cd65 ("ui/spice: Blit the scanout texture if its memory layout=
 is not linear")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  ui/spice-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 9ce622cefc..401d6c4aba 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1191,12 +1191,12 @@ static bool spice_gl_blit_scanout_texture(SimpleS=
piceDisplay *ssd,
>      uint64_t modifier;
>      bool ret;
>
> -    egl_fb_destroy(scanout_tex_fb);
>      egl_fb_setup_for_tex(scanout_tex_fb,
>                           surface_width(ssd->ds), surface_height(ssd->ds)=
,
>                           ssd->ds->texture, false);
>      egl_fb_blit(scanout_tex_fb, &ssd->guest_fb, false);
>      glFlush();
> +    egl_fb_destroy(scanout_tex_fb);
>
>      if (!ssd->new_scanout_texture) {
>          return true;
> @@ -1330,7 +1330,7 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
>      }
>
>      if (spice_remote_client && ssd->blit_scanout_texture) {
> -        egl_fb scanout_tex_fb;
> +        egl_fb scanout_tex_fb =3D {};
>
>          ret =3D spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);
>          if (!ret) {

It looks like we only call spice_gl_blit_scanout_texture()
once -- would it make more sense to put the scanout_tx_fb
variable inside that function rather than making its only
callsite set it up? That way the function owns, sets up,
uses and destroys the egl_fb.

thanks
-- PMM

