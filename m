Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58B6CF45A8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLaO-0001w0-40; Mon, 12 Jan 2026 12:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLa6-0001nQ-Ho
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:19:57 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLa3-0000Ue-OM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:19:53 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79045634f45so72518337b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768238390; x=1768843190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FvJgLwOWK79+/appZZ1ocbFqIedF7a3S7aY8AH9/P2Q=;
 b=ZaRJ6HjVyutAVhT+wsWmrsqJHf+zbrXHfQVAHKN/9Ad1D4JQu96zSqhiffXLSdDB7p
 fSQrJrX9/zYw2/Zak9h9q5IqfcDd0x4clFDU6sPx2oSoeZfysV4N4Ds8lX6zN4w6tWTF
 yxuVjNK3L3EwGDXDYkP64adM2UthU+DaNCDnQCpdihKm/gX9k/Xpt1IL6JNo8iiVrHV2
 XcztveLZIJ29Wdrz55CQs4yYKSHqO9a7F8DGIvo/2PtPvDr5M9Aq5alyNeDaOdY3SPuh
 qBQkaa9CXS1/gt2qeUDO1p/5wz+n6Qgy4GpCvSeX4uB5zWdBi3t6rTIFKce4PeAzUQ2m
 74zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768238390; x=1768843190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvJgLwOWK79+/appZZ1ocbFqIedF7a3S7aY8AH9/P2Q=;
 b=q26pjjl9GkCD8j6tM0ONwnVMPaeRmzGekdyDRxXagXDNCYR5mHC2UJYN9d5mxmmsGg
 90C1zTUgK40nPxG/RPFAcqyf4QFfHowXu04XhmN3jr2p3MdCSrJdTGgypxleS5aiIhut
 QVKS3JByrPuUcnqPM/uKqn8puuBXjq9XWY3X+IxA+e2MeBSJncS2cV3UuK5x0bBPJsuR
 fG2eXdZsUwcjuS3TA9pvq929A8a1FgIPBdv4VLu65SQTk/kcQ9HZ6oST4U8pcApNEtD2
 oxllcZLCfM5FvO7e2j9YHKBo94xy0iHkIsj7EXboxL5cXzNrumZCtF7NjiCMmCtGgOLB
 XVnA==
X-Gm-Message-State: AOJu0YyPZ42G39kwUluUCzJ7bUGS6+CGxIpLqNJxc4HYs/f9TfMLN/rt
 RW2Gfq3pO7C2xvHbLqAUV53MnFWJbIdo7SwLpLOJ//vPSA4sprOfBIWX43vwYG//6hSl4rl83xj
 siucd/lKf205SFhfVrEUUcDK2d3gCpRaaD5t6kR2ELw==
X-Gm-Gg: AY/fxX6qwRSZy2mWuPMy6GyqjktQlI3DKZJwNjj55ne8+yLUDvoBZ0Pt92L2YRn4BRV
 VKjfYXF7we0fbEGbn87A6n0eVpksQbRNkyfF3AXcjfK9NfhyU6bUbyxCKLOz+xXyFWuJId+V3Ck
 1kx1O0WObZPpv1I0Z6naY+zgrkkZ5DScu05JF5LN1nU3GxaPncCExQL3kvskjRL3c4kfB1k23Z9
 0mwyIg157Gm8SQIcvEWwetUmNOAae8Ifa/NiOXJnLuCKdY9m/W0GSRRDqWjRvvQ20/DAa+J6UpR
 IvKecI+AxcKnGEXrrmQWVMpvZ9tdp92vxQ==
X-Google-Smtp-Source: AGHT+IGLR/ceC2jhWgcsuNQm5AddFM0WJTvsTF6NyPeU/WN84U0BqqsNWFpcFUMlENcEaV3OkCUyG/eQh7yFAv5/2nQ=
X-Received: by 2002:a05:690e:b8f:b0:644:7913:1e86 with SMTP id
 956f58d0204a3-64716c77267mr13640179d50.90.1768238390438; Mon, 12 Jan 2026
 09:19:50 -0800 (PST)
MIME-Version: 1.0
References: <176663430090.23028.16926971585326050904-0@git.sr.ht>
In-Reply-To: <176663430090.23028.16926971585326050904-0@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 17:19:38 +0000
X-Gm-Features: AZwV_QiOPB-WcVRTYjiChcXK1SOnX0muOQjGyvaMKr-M41pbhUwMok15cOC7nm0
Message-ID: <CAFEAcA_YkEVkm_6ihHHrDv43wAEw2qceBWW2xHjZdQzW0H4KSg@mail.gmail.com>
Subject: Re: [PATCH qemu] hw/arm/max78000: Fix num-irq to match hardware
 specification
To: "~emckean" <emckean@protonmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 25 Dec 2025 at 04:14, ~emckean <emckean@git.sr.ht> wrote:
>
> From: Ethan McKean <emckean@protonmail.com>
>
> The MAX78000 user guide Section 5.2 and Table 5-1 specify 119 interrupt
> entries. The previous value of 120 was based on a misreading of the
> table which spans three pages, with entries 0-104 on pages 102-103 and
> the remaining entries 105-118 on page 104.
>
> Signed-off-by: Ethan McKean <emckean@protonmail.com>
> ---
>  hw/arm/max78000_soc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 7f1856f5ba..1e2f66428d 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -88,13 +88,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>
>      armv7m = DEVICE(&s->armv7m);
>
> -    /*
> -     * The MAX78000 user guide's Interrupt Vector Table section
> -     * suggests that there are 120 IRQs in the text, while only listing
> -     * 104 in table 5-1. Implement the more generous of the two.
> -     * This has not been tested in hardware.
> -     */
> -    qdev_prop_set_uint32(armv7m, "num-irq", 120);
> +    qdev_prop_set_uint32(armv7m, "num-irq", 119);

The num-irq property of the armv7m QEMU device is the number
of *external* interrupts (see the comments in the props_nvic[]
definition in hw/intc/armv7m_nvic.c). Table 5-1 includes in
its count the 16 internal interrupts (from 0, unused, through
to 15, systick). So to get from the last listed external interrupt
number in table 5-1 (which is # 119) to the total number of external
interrupts we must subtract 15. That gets us 119 - 15 == 104,
which is what our comment says for the table 5-1 figure.

But the datasheet also says this in section 5.2:

"Including the 15 system exceptions for the Arm
Cortex-M4 with FPU, the total number of entries is 134."

That's where we get the "more generous" number from. If you
strictly believe the 134 figure and that they weren't off
by one by not accounting for the unused zero internal exception
then that would be 134 - 15 == 119, but I am very reluctant to
believe in a non-multiple-of-8 number of external interrupts
unless somebody goes and finds the real hardware and tests
by writing to the NVIC_ISERn register bank to find where the
RAZ/WI bits start. If anybody did do that it would not
massively surprise me if it turned out that the actual number
of external interrupts is 104 and the datasheet text was wrong.

Getting the number slightly high in QEMU is pretty harmless.

The original discussion about what we should set num-irq to
in the review of the patchseries is in this mail thread:
https://lore.kernel.org/qemu-devel/CAFEAcA96fap_EJiFtX6a_PFmWeP1OPZGABueAyE_=JQwFi-spA@mail.gmail.com/

thanks
-- PMM

