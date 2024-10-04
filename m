Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00BDCF8856
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 18:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swmxi-000104-Hz; Fri, 04 Oct 2024 14:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmxg-0000zb-4N
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:23:32 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmxe-0002Wx-Hp
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:23:31 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c89668464cso3084608a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728066209; x=1728671009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvLlRdLKJPdszF4enlY1FyhGNngo4mPeyHf5RkZPKts=;
 b=ZETUI8Otv/Y81YdypVCMRb7hTjZrP9QmoN1fEZbc5yIaHQoXNanb/dGswBxakgdcpu
 Hif6tiYLEDqPghb2izMVoxySnUMRbJqp9ivPIPusYGl8R8Dl3Cl3V95+pLAaw2Ve3NAX
 lSKY5udcQy/EoByyrW+dy7el5baBu7/cciPMDfzpC/W4YbAPUzaaB2wsNye22c5R1Q6I
 B3PYLA9fX5q9OTHxdObWuK1uREGSiv1jA3yWbiDRKRAN7iO7e04b7xcVSDKYEK4sD9oX
 d4Tq1mhRPc4p8hQgPulRT/LtbbfHvRDW8+tx5/rK6eePRh9HQEApfAuXihnzSJGpKfcB
 oQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728066209; x=1728671009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvLlRdLKJPdszF4enlY1FyhGNngo4mPeyHf5RkZPKts=;
 b=KhEcXE5/wH+/E9Ic+dMUvI/SZjpEpdU0RTp3zisEZf3zE+Xwt9BShN3dOCIx8vMCDY
 XtoC1X2PS+xAZsLob7SjHsKh7jYA4Ks0gre6DFaomTMl/yEKc/HdEspBw26A0ZpGD5XO
 Ibh5E3R3NaILK/6B0vf+oqNHLK6/UPDl3fT3xCZ59uJoOYRbxr3hhSJKg9sq7obePZiq
 FbPNDvf9OmfcAzh4W+XG4alh96ewGlN6eeHbky5Q5bVOJEGjMe4u0Pt0ju9/XZ859Wph
 3AjGG2Rf7iOkh3QlvcJHgMi4rASxLnAGvNdEK5jzWi0jBLiZ/fsX5xolloM37DZwcUDp
 4iUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNuLTca4Xpwq8DcoERW48AUImnzRJ1OAj27wmUOfzYD+yOB/xmHcWzFjMQdQvOZn1krkLXNL7GYi2N@nongnu.org
X-Gm-Message-State: AOJu0Ywx7iXfhky9/cObs8v8RquDFIeY9A3bxkYNV49Aj/IgzB5GrkGw
 8WDDHxwmKaduuH4gchNLl55UjkmSdDfLTxHTokBsh9NAIDc6zMoKNETgtdmfukyysyucmrDRizT
 aWFNWaK1xfkkdIAhEL9qRL2jD2RAihT1nRrhh8z8l+/dq+XO8
X-Google-Smtp-Source: AGHT+IHCFZ24YLOKInGdwq4r8kbR3+FXzMCVbD5c9eiygEz6coIg3wgIUAyv7sV4UWweJkXAnGSXPuEkQQvnvFZDHfE=
X-Received: by 2002:a05:6402:440b:b0:5be:ee30:9948 with SMTP id
 4fb4d7f45d1cf-5c8d2e14ea3mr2502999a12.8.1728066208313; Fri, 04 Oct 2024
 11:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
 <20240927150738.57786-3-rcardenas.rod@gmail.com>
In-Reply-To: <20240927150738.57786-3-rcardenas.rod@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 19:23:16 +0100
Message-ID: <CAFEAcA-6xoyYHJK-ZEHL9OzPwj4367ZqQ5d1DqA0hNKMhczV+w@mail.gmail.com>
Subject: Re: [PATCH 3/4] STM32: new GPIO device
To: =?UTF-8?B?Um9tw6FuIEPDoXJkZW5hcyBSb2Ryw61ndWV6?= <rcardenas.rod@gmail.com>
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 27 Sept 2024 at 16:08, Rom=C3=A1n C=C3=A1rdenas Rodr=C3=ADguez
<rcardenas.rod@gmail.com> wrote:
>
> Generic GPIO class for STM32 devices. It can be used for most of STM32 ch=
ips.
> Note that it does not implement configuration locking mechanisms.
>
> Signed-off-by: Roman Cardenas Rodriguez <rcardenas.rod@gmail.com>
> ---
>  hw/gpio/Kconfig              |   3 +
>  hw/gpio/meson.build          |   1 +
>  hw/gpio/stm32_gpio.c         | 386 +++++++++++++++++++++++++++++++++++
>  hw/gpio/trace-events         |   8 +
>  include/hw/arm/stm32.h       |  41 ++++
>  include/hw/gpio/stm32_gpio.h | 109 ++++++++++
>  6 files changed, 548 insertions(+)
>  create mode 100644 hw/gpio/stm32_gpio.c
>  create mode 100644 include/hw/arm/stm32.h
>  create mode 100644 include/hw/gpio/stm32_gpio.h

Oh, I forgot -- could you consider adding some tests for the
new device? We have tests already for stm32l4x5_gpio in
tests/qtest/stm32l4x5_gpio-test.c which you can probably use
as a pattern. You can add the test cases as an extra patch on
the end of the series.

thanks
-- PMM

