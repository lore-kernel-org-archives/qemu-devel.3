Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6083DCD6E49
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZxN-0001yT-27; Thu, 28 May 2026 08:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZxF-0001xi-BV
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:35:17 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZxD-00026A-7L
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:35:16 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so10780631d50.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779971713; cv=none;
 d=google.com; s=arc-20240605;
 b=FKXyAgVxBn3Xn+ELcoa0a7aRwRoVdRnvsy2ObQDu6XjrGecxc5j84iK0LnaumrCxQT
 SpV7U0rM1zYuvTiOHpGJ4R7YSGAJ4MrUYikgI4y2KGkNJU8NTyjLgd5RjCZ98HErJdtX
 z2B6JM/VYM6F8ZdiRT543MSluLblgWq2du+xPzvHpUnYyLiy6l2+jFVdSfKg6vy4Rne8
 HeothE3eEq0zjpJV+mcv7vDSPp8Gp8hLJhaSrMyMwBNuLMgBtz+l8AirhNZbYzu3pHCZ
 OCRyVZl7s4M/P1ovFc2uBtW8/LwfckqqSZhpLCmV0n4yqEy5erE3LKdMLDqvgo1fKYnp
 uVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ACMhcH+FB6zeYIrQqDuvdFXd8HVUUYZ0H3Mf5TAXE60=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=ji9VsIhdrmzyvbvOtH45WhDutfw7BGuIUet1xkpnqe4K76yHgRKTm/3tdSYkPjv/XV
 EO+aeyfRGkBxNcftBwkS8xlqXjPCCc44E8JQeijTSZ8K9hWpQIPYL6ooM93bTch5Uz+0
 fWo0O4h7hhtqMH/8ksEpbKOpgJFJwK7ZdZSagMrlwJr2FHsKexxE5hRwrM/vZQYnwALr
 YAnV5OTak0rZOWRs4JrWe9vEdbOf132fRUGi9vAcZqVv2v2NvFebL2zoEINxBFthLB11
 AFAbAN2RN0lJLVHCiBhjJN9WQqd67x4+XXuaHoqH1xGJRpBFBZmvuSPnh6aO3joc6WlD
 icRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779971713; x=1780576513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACMhcH+FB6zeYIrQqDuvdFXd8HVUUYZ0H3Mf5TAXE60=;
 b=UM7MaRq3PA2XArnUUckKmEieOC1ULfvVSoRokYX7CJaPCxLF3UJEg8p0lCVe69vs54
 b2F3QNvkZu2dgSPKcxQCMYCLS5MDoHR8ssN6SkviUZppGR9vum1A+HPDsuoiJplU+wTg
 hAdHmiRZH2JWcNqqb/Ibr2WECyGd51UncVuv0pi9vjurpvTm4AmSi026Or76VVELMzEl
 KDW4W+Wgh5bScv7whdm0H7P7etxwcOduNZvk12LYbAX3+xtX9Rc3kkX1A4WiMGbu8N8J
 asOLeCyDQtAYwfoTsQvvEk1xqyk+wCrAuZpa6QC3Cbxmn0iELbnvOMNICb/67Flv2TOq
 L3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779971713; x=1780576513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ACMhcH+FB6zeYIrQqDuvdFXd8HVUUYZ0H3Mf5TAXE60=;
 b=sgon25Rp5VdSY6+C0UPjG9CZhBTyBJyjWt3riwspiSYo3jz8L1OhK+MRtdgN4lHXoV
 4076yR4JNuYEnPZzLIaHkQy3yh/qiOrAJvkwTHGNGniP0B8/+wKrPMlYCvRrP4kSuG79
 q3ECHSKUKJGzMjfhCNiLwCw1QbsX4hAx/PcAZmDTxo/F88o4YEVe53vdPjwgm8QJrah1
 5D4dbfQzhjMvzabiyrV+KBSTHEnA+XbJSq8W5ekll0FwP0w+P+F/VgASVC3W/BvRHxoE
 w51IkbD1ldwxJHpC9/a9KS1npNpf0Zy7jNfQW3MzPEoDTmj9ngPtMb2fU/bNV+r+gq/q
 5mkw==
X-Gm-Message-State: AOJu0YyH7/A/bI8rUKJJksZ1Ei5m6J8Win4NHtpRjCqXXVypJoCWXAH1
 YGTR1TbgVE65E8G+0Q8Fdk8LwLtN0DA8sEgoAMj6e1fheyLuLCl4FwFOdJ3fp2HojEjdAt5vhIx
 F4Q4+iRuePy/ISpI9OkoBE2K+A053cDj2bSfrS0RGkA==
X-Gm-Gg: Acq92OFQalzkbrBlGb4RL20n9GOQyiI79RWaeRfDLOLD5T1A2bYBiwI19dnD11kKyyA
 3j9rw46DBEBQaARfL1q8R+i3DdGLJuO1dktmbJiDA+VKY4R/6Sglw82dHJyCFcoUvAwA2t+NjZA
 8eoaWqcff8X8tQQqs01BTWXs8mJgz+Yu4YRKR6HAc+AybtMvvX0W7SNsCjsbhsZl9uwHQsQ16eC
 cH2Op1m3HJa7KS7YDfeSgYXyfTIExScWhwo2Bpt9L5PHDJAPnfF8BFBH5IBjiM8WXnma4yCA8BG
 HNvsjIOsGlLkoEn68RwQjkyK6vjsex/ChXsN9HhXfzNaLRXC+wowdbSUsj+hna0YPadOv8syN6x
 S6A==
X-Received: by 2002:a05:690e:4090:b0:65c:7129:5c66 with SMTP id
 956f58d0204a3-65ec98e90c8mr23297120d50.41.1779971713413; Thu, 28 May 2026
 05:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-13-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-13-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 13:35:02 +0100
X-Gm-Features: AVHnY4L93mOwQjaimywT7PXLnnhUJz39G5c5TkIXt0BaXM_FRX047jnlXmPxpHk
Message-ID: <CAFEAcA8=DTddA2oiv2SjggC1O=A3PdXbO25Ut7AcNp=6nsuqXA@mail.gmail.com>
Subject: Re: [PATCH v7 12/16] hw/misc/zynq_slcr: Add CPU clock outputs and
 ratios
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Add CPU clock outs und derive the related domains from the
> base CPU clock ration. This makes the CPU clock domains
> visible and keeps their ratios consistent with the hardware
> clock tree.
>
> We also need to set the reset values during realization to
> ensure CPU clocks are properly enabled at startup. Without
> this, CPU clocks would have a frequency of 0 Hz, which
> causes problems in the a9mpcore timer implementations.
>

> @@ -630,6 +667,9 @@ static void zynq_slcr_realize(DeviceState *dev, Error=
 **errp)
>      if (s->boot_mode > 0xF) {
>          error_setg(errp, "Invalid boot mode %d specified", s->boot_mode)=
;
>      }
> +
> +    zynq_slcr_reset_init(OBJECT(s), 0);
> +    zynq_slcr_compute_clocks_internal(s, clock_get(s->ps_clk));
>  }

This doesn't seem right -- devices should not reset themselves
in their realize methods. What exactly goes wrong without this?
This device's reset method's exit phase handler computes the
clock state and propagates it, so devices consuming the
clocks should get the approrpriate information ath that point.

thanks
-- PMM

