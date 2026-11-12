Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7D606A8B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jylzZrpj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUdg-0001l7-KW; Thu, 12 Nov 2026 08:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUd2-0001Kq-CN
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:14:12 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUd0-0005cO-Pw
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:14:12 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so5422441d50.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489249; cv=none;
 d=google.com; s=arc-20260327;
 b=Rszh0s7IgDgtFrA7XrbMxc47tcVKDotuAXjj+XbKrkTLYoTXbz5nVNqfleg/XJdgzw
 /KI7r/Gh8FnA6OXC9UFQmolnOZtaP8mwXXLvARyY0DZbCAhcvERl/Y+Dmmxhx1xfLpsH
 uLKUfVpWiacEfPoBsxDYsiDMpWhxTXiObvLg2iM46747rUVrXtl8w/QcmkAas8EyeYPt
 ewgOS7o9u/mnJg9/iu0D7rN+J1H/UMEKuMU8CTEfaZ4qByFDmAs6xCfZ3Gj3WZiV37xj
 xGldI0hJ5/Q52NDWoP6s00aGM5Iaqh0ZMNaoXJA2jPZ6P8mVSrfgGH94K/y5OKbwGFm6
 9+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7LtHY++GitWTEfm8K9Joulk+ck8KRYsjJYmh6ZgpacE=;
 fh=t+yyg1euDRb1VoDRW8v5I2tyIqkn4Jx08yBlNKYKB0k=;
 b=O0fUXyUbPyTe8TO8XXID9V1Hcw46PeQMRpcE52BiZWM+nXzNrMtZMauSws/8Uw+cl6
 p2BGSZG1qN8hLcYJBNKtn8eUnUxSuT+XgDxyFhZJDOt+XkfHPeTfVLvSNe3n3l5AmwT6
 mZyaxyi79/axdeMHcmIrGicpGmLypf5fAFLGzzilXhIojkYALH930V8grCGf9Q4+eFB6
 7P0SytJ0tOFIYC15Yikujb4juizhAVkU0ThLoUPp6GgB0dRvxLxxPMFayIFbflo5vUms
 PlCAhhLVPQxz0cSVSEbxfyhptGeef1P79lVyilxPpUlHfH244T17vhiYz5f1ZQK+YSeP
 tB1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794489249; x=1795094049; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7LtHY++GitWTEfm8K9Joulk+ck8KRYsjJYmh6ZgpacE=;
 b=jylzZrpjjjcimekkD32uBTP5Kbzm4AVJFEuPznnXwnEnGKi53ZkXEBi/KYFrLzQSPZ
 YCimYNc/H8/S7uAgiGW7Hj/ftmpbUFNWF6P8V28ttO1iPSCj3cZyOP+sicfwdVxmp8kg
 fJavbS5qP2vFvMWTulR1rVzygsUoYWcy6LMe3lwssQK+TQxBfuE9JlYElOU136SNjFGC
 s8cjJKnrsJWr2q3dHh7NcF3PVyFxCDuGBl5npCVauc8fAozkB2vQqm0dzR6U5K0DWv9b
 vZXPcsU6EY12Ne4Gj8mxhr6aYMMnJkyjHWrYGYRwcYE6mBdUru15Z+vRT7j/MvX6FIrv
 VDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489249; x=1795094049;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7LtHY++GitWTEfm8K9Joulk+ck8KRYsjJYmh6ZgpacE=;
 b=RAjEfuiBlAesQi5gQHIQWjD6+Y1VHSZgJKp2gFxluzHwF9XQhufeCRPeMy86bvgBPs
 c6hfzBOYBj1kAC05tCJDvbTk4zaJq6RfxAO6WznO9Qr8M7G1jGqiEHAEIzYhNZloBVIY
 huNposhg3xWtXUtCvDhGD675ySzR+SH8aLsYhP/5velLC/RJHV8JE5P23AmBmB5b0c//
 wUgD2sROOP0JOcPouq4GyOqb++AVn6smAVmlySBDvzKP/2fsvITIYjUMPG4GXWrpd46L
 rkBmd6AT5YML76w7feofX0jK490p/tiP4cBnIOpnMtylLphVAh0bBdghOlhfZPPLoSJc
 eDOQ==
X-Gm-Message-State: APuU4Z/KawnZ5Tadrcgyw2hiom6y/4iR5RYeVVk/kbWEY9+KWok4w3qq
 Q0as1U6Qz0MJoix9XUco40f4wO7aJllIt5UHmO6gB9ZUQQXPv5gfofte5hg3CcYi6Dt4D/QuT9D
 fzs2FUkh13ZzSAD/sb/UkqsZaEXQWnTh5oWIV85ESHg==
X-Gm-Gg: AYBFou1wVEhr1xxw3o7BxEq7wt6iz9mGKtGXxMUJFMXf3OB4aTFhqGIOg9Ax+7Bz/xT
 RnFoSK/PzWCnAbZrogd4eCP2RuXWXBpQnp2cqKxUnruKjywWQ/P4SWmWew0iw5G1J04NvkTkZzT
 66XlNZZQfLQwBQocdA3Cls72lXoBFgkTN0bYRZAJ/iOSyX0JOnQ6FOLhwWxyAS0OkYzcH/4DgTO
 YNuLE+Jv4Hg/9wB/zEPPMoKII4ozSpzMOv3U1oMIb01lD02NcJZxisOzEM6mmHZeCK+ch49K1VP
 p2+oun0R4ERMOuckzSYysEXc+vChbIQn1ME3EGh/6DdBF374Bm2zTVhmUs1i8RwOxh+JP41QwR2
 MBh8aVx9ozg9VkQLvDXOQB4FdTMYVEaWVJ80R3NuxWoWmuC5XOYbMt+5scghL+hSTlMwn3KZMTG
 d/yLm7GKBp2OiArh9Ca1gywolZG19x+7kpq2IWAnzStA==
X-Received: by 2002:a05:690e:43c1:b0:67c:1d54:d59a with SMTP id
 956f58d0204a3-67c67f77193mr2534972d50.47.1794489248919; Thu, 12 Nov 2026
 05:14:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109035234.722952-1-hywei787@gmail.com>
In-Reply-To: <20261109035234.722952-1-hywei787@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:13:57 +0000
X-Gm-Features: AclHuK8FbQHgTYgmpTC-r0WAoJXKqcEz_i60jjtZnOVDEcgnmKmALYn-_bniKRg
Message-ID: <CAFEAcA8r7=nZCE03ekQeT=u3mXR6eDrsQ8RtyE9svFm8Ziif4Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/bcm2838: Route SPI0 interrupt to GIC
To: Hanyu <hywei787@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Hanyu <hywei737@utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 03:52, Hanyu <hywei787@gmail.com> wrote:
>
> From: Hanyu <hywei737@utexas.edu>
>
> On raspi4b, SPI0's interrupt is connected only to the legacy interrupt
> controller. Linux guests whose device trees use the GIC therefore
> can't detect an SPI0 interrupt.
>
> This patch adds a two-output IRQ splitter to deliver SPI0's interrupt
> to both the legacy controller and GIC SPI 118. This follows commit
> fb3e0557a4cb ("hw/arm/bcm2838: Route I2C interrupts to GIC").
>
> Testing
>
> Add these options to the QEMU invocation:
>
>   -device m25p80,bus=spi,drive=flash0 \
>   -blockdev node-name=flash0,driver=file,filename=flash.bin
>
> Before the change, probing fails and /proc/mtd contains no devices:
>
>   spi-nor spi0.0: SPI transfer timed out
>   spi_master spi0: failed to transfer one message from queue
>   spi-nor: probe of spi0.0 failed with error -2
>
> After the change, the flash is detected:
>
>   spi-nor spi0.0: m25p80 (1024 Kbytes)
>   # cat /proc/mtd
>   dev:    size   erasesize  name
>   mtd0: 00100000 00010000 "spi0.0"
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3013
> Signed-off-by: Hanyu <hywei737@utexas.edu>

Thanks for fixing this; the patch looks good to me.



Applied to target-arm.next, thanks.

-- PMM

