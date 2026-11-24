Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66E606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lykpLDvQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVp9J-0000uX-Ex; Tue, 24 Nov 2026 06:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVp9F-0000sZ-5p
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:57:22 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVp9C-0005ME-Qe
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:57:20 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67db0791748so4924890d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:57:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795521437; cv=none;
 d=google.com; s=arc-20260327;
 b=n1XJU+t/fAIYLJFBuj6B555f+NcwmMTq8+IEE072R2Y1tUpi0xq7XbCiWfIultADai
 pB5CU3//oHC9+Zg2OfXu7tUeLdiybnMwpew/IGP8o8Y/6VfGEVlA+sc6kfW0OYZvcuW2
 h+YMiJgQQ/5kjvEnDOL8S5QwNWbN5TcwdTsPJRrf9oCln17dP1tZ549A0qaKmH8MrKpS
 OEIEoaveCwK8jVSkcxl9pr2RGSsHpqw4VPv1oBdxx7qSPEKSUtDAY3L+mY4x8SLNmlGi
 37BoapaJ9i7jG26Jd9EBBla+e8+DHdnl9aBi8uZ8VdQ9qyp3sVjqKUQdeU01n103NV+1
 yUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0MDOHy2N6YmVjrGmAl4CImJR7XoBMdumWhtlCn4ZVzc=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=G+qg8RsG5h1q84U02KCyWwJ815+CHhj2AaY8a1PJ74ud00xmN47EIS79KpyOZoeUvP
 1tzodXQSF5ILESSerIEL0sox/vAWGMpoEHAHvLmtokAFmDmTk+CTHCfjXxvrwfj+fGwl
 bhXSu/RxhRgAvGb7rYECFsxKKzqh4LXEydbuSJhEKh2iMOBlkcYBium8UR1PajYMMhS2
 pvRkQhtHha4GHQEeAwUOr4pNDExZeyXZhvN7hzihFL+qbFGPNUiOfNxBfZvnMB5hPN+a
 oti+pkvKV9A6hMhhOgaPlbto0C+5PMARCMhWipsilF7QEIWdCsieQewqo3oB2+MDjXTc
 1miA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795521437; x=1796126237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0MDOHy2N6YmVjrGmAl4CImJR7XoBMdumWhtlCn4ZVzc=;
 b=lykpLDvQI69iMNTP9dcTnYAyn/pUvNFGOqd+xvrXSUz6/e/nggeKNfivP92ISaB4mA
 SeNYIpkKy056jtsaHe7Yx9x4h+MPehX0rXeDvGZeQjK3L6YSBRAStJexFB42eeODcFls
 fQdKW+cMkRim0Idg5RAWyDEXE9ORlLf60iLrz0zr3eHecSYqaka0z6l9HABFuMxDB7vA
 0ey08+EZpmxFrcYeOPe6caaqQKNBzL72i13JaEHBFUKX84+FcEUWZn2Z4HXde3ZjFKOr
 21iXi7C+MevNXVahPmBDloTZXXqQvfxzlIwRk7acAHIA6KKR8RBPSaSZDpXJhHAWHqi+
 oHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521437; x=1796126237;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0MDOHy2N6YmVjrGmAl4CImJR7XoBMdumWhtlCn4ZVzc=;
 b=kZSMOfFyz5IVQglXVuqvlw5uAhm9wnpC/u973ienmsvqqAZnP12/PhmsfaSwV5DQOI
 2ZOpHq1IpfgVAixf2kaPHw6MGgLpvUNyUDdnFqE73a6o4PHxR+mAReyqPc+5rJcToKm8
 CqQDsnK6/qSvnToUhDAO0j3qQu5yhK47G+X5exOfYdK/xuNjlNR8NKfpSOrKqHnPNG1u
 7dtU3vVXgpZYpVQUiKOZRswraLFLRe/Jgs//DZHrPcYOQqbQ1zzltk5N8/383ROVdBDJ
 xvRVr3pK85K/cwK0jRexzAgPrZDl6F8EaqoapvAxFQOKiC4TtFTDHZaOMocxnb8r6Yi1
 gxjA==
X-Gm-Message-State: APuU4Z8FuyN+6Syo1zDN83pQEwzufFG2H3gryTYQIiFNrroLEKt5JCh+
 Hst5PnpiSQeFu2N2y49VMadz8zx48WZJsDoh5GU301bK0YruN99czm+b2jgIUVXGmlEjxjHitBz
 RqvHBtI9PzjRHZW3LlrFVA6jgltGj1/5DGHV8/HOFPw==
X-Gm-Gg: AZFdTZebUwSFoarC+KnN1oVwHMnnRppwH6JyAuE/uJHEEdZua9REYfGpVXyGgOSI7M6
 baZ/GZA9t2EjU/PV3rk7EBuS6UpiT+RriqYTnIRndYAl2GVO2SXqUxE9LmENQJZgE8WzOPJgMks
 3PQi76o9f52P85mKtdztfutUEwM74TAu0zG2RLwPT5wuWx+QGbzH0mG+MikUFPmHOiVT6SkjpGe
 DO2qXxxr5olV+Fe4eyEc99jSn1RfQoYEYxrczicT/6wdVLgObnhRKLUNq7Ow1aA3kLIKIjwFFTw
 RFwcdPu598KD/yXHqQcKzTl/4IxZoCQuEQjlrFmiK+lzYpW+hbBz9DqPX2+iaV4n1iwnnL0RTCI
 K5sUe/K4rw5kHGTfPqSWr9oIZoNqswe67L45NrNba0Y6rThjNgO1JuFNVd9XpK5wMCbVFOD2lOP
 NoIrGEwf/KKvG0ZtfYQVjD
X-Received: by 2002:a05:690e:1341:b0:67d:c045:d0ca with SMTP id
 956f58d0204a3-67df43cf81fmr5918841d50.25.1795521437383; Tue, 24 Nov 2026
 03:57:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-5-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-5-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 11:57:03 +0000
X-Gm-Features: Aa3M54pDBlE-WROAFL42lu1ICIfmJ-WIu5Mlw5YL1uqUYyTP-4V7l5d6Keb6xZg
Message-ID: <CAFEAcA_gBnmP6Qj8-Zms7urRdDhrOv7d_t2Dc56_GUj-fF15pw@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 4/9] hw/sd/sdcard: Fix incoming migration of SPI
 mode cards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 22:54, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> sd_vmstate_pre_load() powers up the card when the OCR state is not
> part of the migration stream. Since commit b66f73a0cb31, SPI mode
> cards are already powered up at reset, so the incoming migration
> of a machine with an SPI mode card aborts in sd_ocr_powerup():
>
>   Assertion failed: (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)),
>   function sd_ocr_powerup, file sd.c, line 409.
>
> Only power up the card if it is not already powered up.
>
> Cc: qemu-stable@nongnu.org
> Fixes: b66f73a0cb31 ("hw/sd: Add SDHC support for SD card SPI-mode")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d82aa35f6f87..d922e813c102 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1067,8 +1067,11 @@ static int sd_vmstate_pre_load(void *opaque)
>      /* If the OCR state is not included (prior versions, or not
>       * needed), then the OCR must be set as powered up. If the OCR state
>       * is included, this will be replaced by the state restore.
> +     * In SPI mode the card is already powered up after reset.
>       */
> -    sd_ocr_powerup(sd);
> +    if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
> +        sd_ocr_powerup(sd);
> +    }
>
>      return 0;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I think it would also be fine to just drop the assert in
sd_ocr_powerup() if you prefer.

thanks
-- PMM

