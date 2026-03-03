Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B172FEC0480
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMTG-00040n-HH; Tue, 03 Mar 2026 04:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMTD-00040H-TL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:55:15 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMTC-0002Nw-DF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:55:15 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78fc4425b6bso52978907b3.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:55:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531713; cv=none;
 d=google.com; s=arc-20240605;
 b=PueFEqUJ4eu1mME7DE5XJJT/LMNcx8DDW5lGHd8hXILPvkIjZVoZCmniLYHbwZzcWc
 WeN+fl/6+6yxlDJhvlYJRuxiF+j7hRNd/63YuLz+QaLgRGCS7T9fEx6xkz5w6GIEbSCJ
 6S2K4bPKjpK4iQRYMlLC9NZdpxvIp1kAena5xisxVRj+/JcW+s6xCyaQ/z/MB+0anjrd
 5bwoVWCgadykTv17OXq+ChlOnz1bZKdd6MIPuYG5fpLHeVFlj7YXEhsR8fgqmdantSKu
 bpcXfutdy5zkw2pLjs4aYr+/3p/8wNCOfmZI7SD/UJd+O7RrRJxTw+W1G9TKm32yupy2
 m20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S9czckgZH+ZvuNJvQeHNwzw+6/69XROjabrO5sX/7tc=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=c7vdrgozPmG+oklYYi8bD2jZgZe2F7qAgd3zg5WF8rz4zvA0BE0/f2e8F8DN1AbFGB
 PTiqLiS1c7S4DphEOkjuPCcrI01lt4fwNMe/n18LZaIbKVEBho9+rd/WOFNCES2A9cHX
 hkK+jsv5lrGRWaSADt9utoKFQLfSBpdQlwdRWzsv5CRnB+SUYqL95w16tiauxwVlDaS1
 y+tf+KE9g8K73fyeQ4b9+1uHHrujLM6ykHP/NN6A4j7kto1IMR7MLUBdn+loUJHH9CzR
 FQ4/msdeKbWiyr3kcT3m7ZA83NuoDd8xxIeGnKYYdVrp62z3AiTYWRPxb8QulSOzKq1L
 wOdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772531713; x=1773136513; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S9czckgZH+ZvuNJvQeHNwzw+6/69XROjabrO5sX/7tc=;
 b=PV/pFyPlBRRRrLWEiF1kIaoUcg/sZo+MaiSrRNODtT/2rjfvf5YZFemi8HmV7xFbq5
 X4sVjRmOJBTYqU084X3dk2DGMdLIkvc7/miXaiOh6AxvMP9RW7F8hBlGNwCw3ZTU01i/
 AwE1BfLbQFMLsPhxlfAoby6yBHwxvDFfmelLGfMKLBOwYEa6dpL65FDMDC4QjZJcSj55
 vzZYEWa54mU19h8wvrUSdFFmIRMTvyWHvvyJlL66eTmMIN+J99YIMGtB8tSfdzky5Xk7
 gwuK7bsi5GaWaIfNy5i2UuVV28MiYBjpymfIu88YOLWUfcHw/9uv3Uo3K4zyar1og+Tc
 uRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531713; x=1773136513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9czckgZH+ZvuNJvQeHNwzw+6/69XROjabrO5sX/7tc=;
 b=D76Lu7cGPmOyfIm9nceTPIIRvKEDZb/9IruA7pt2HiU8puxnWPjyHj2K5kZGktw3z/
 On6X5GS9XLQd8KJ1T/SLwNxCWTyoXWIlUKUgN0/dRk9NQtoF/Tn7GlyeBXvlyT01Aruw
 XoagYUk/pC2OrUMSlUKMZH5vlpTvTv7yh7+lyPTGP1t0ZCu5wI2evEhouW3pW/a9/Nr3
 A+N7gqWnz8kafd5kvhpzDejkQJAYjxv5oQ0dnZoN4lqeWzg3EMi71u5XX8/Y3j4DPLXh
 wUgUykPM0AXXqLF66Q0qfr+xaT19mHT96goUFf+Dh2rnHR6VjjuVyaoqhVQHhWgCe3Ob
 EC5w==
X-Gm-Message-State: AOJu0YwiSWp5lkcuwq7HrVGYTgxHWCKcNWH13Ypmp2MW/Cl9DqspN9pP
 8tYyC+CtE887Pr6vHBi1wRev0NFBJGcWwmkhorV/liM0dpzNBoz2Y5kbJ7tpBLbYTbzgX6co1GA
 +oRs5snORf1bX9Y3neLghCj8oB8IRBGgHCu7Mm+l7DA==
X-Gm-Gg: ATEYQzwya+eSlJXhfvJ9Lzopy+Kl5fAQINcntloe7uDlJPjfAbfHwodikPfzXiYNkdn
 1XEWTvOVCTJqpL9c+iarSUI1KG64AajmQLZ27p566T3PQIIj7C1gXBL1x21hEF0Obwf8eFdh+uN
 JFBngznAfPmbymu76I09murRBqtQrN4IZl8ywHedLGxmxPtuUF+KeeBGmXlmz24YsGI+Oe5IyQC
 Bb1Fg2IgvTW7zMJ8uoLY4lnn3AJmHW/hNaBlZ2qnvDKJ/lVHDkIl4mrVo8sqKgA86EVTJddGIj4
 Kfmb9U/MRjetfiKBk4Nvp+DJyeIjKvsVhgHKgrqBQELShOcHh0bGslpvMGN0ykBw5YE=
X-Received: by 2002:a53:e1a3:0:b0:64c:f3af:97a0 with SMTP id
 956f58d0204a3-64cf3afa01amr49014d50.30.1772531713156; Tue, 03 Mar 2026
 01:55:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772397447.git.balaton@eik.bme.hu>
 <ff683ccd3433cdaa72aa6b5c97dc9431c67ff5c5.1772397447.git.balaton@eik.bme.hu>
In-Reply-To: <ff683ccd3433cdaa72aa6b5c97dc9431c67ff5c5.1772397447.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:55:02 +0000
X-Gm-Features: AaiRm52xNMQohsV58BYcWHRNXuT4raOPI30dAbtWaf6C0_vyNjwpMq1IJWkcwnM
Message-ID: <CAFEAcA_u=6KuDNs+DT9yOvPwNac1tTMfx+0r2drDjvKHHt+etg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] memory: Remove memory_region_init_ram_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sun, 1 Mar 2026 at 21:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> This is rarely needed and we can use
> memory_region_init_ram_flags_nomigrate() instead which is now the only
> nomigrate variant left.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

I don't think this one is worth doing. We might as well
wait until we can get rid of the VGA case.

> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index d427d68e50..b025cc53a8 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -163,8 +163,8 @@ static void xtfpga_net_init(MemoryRegion *address_space,
>              sysbus_mmio_get_region(s, 1));
>
>      ram = g_malloc(sizeof(*ram));
> -    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
> -                           &error_fatal);
> +    memory_region_init_ram_flags_nomigrate(ram, OBJECT(s), "open_eth.ram",
> +                                           16 * KiB, 0, &error_fatal);
>      vmstate_register_ram_global(ram);
>      memory_region_add_subregion(address_space, buffers, ram);
>  }

We should change this to memory_region_init_ram(), taking
the compat break (which is fine for xtensa).

thanks
-- PMM

