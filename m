Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6902EC1434
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNuZ-0007CV-9a; Tue, 03 Mar 2026 06:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNuX-0007Bx-KZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:27:33 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNuW-0006aD-2V
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:27:33 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ad46a44easo4642994d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:27:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537251; cv=none;
 d=google.com; s=arc-20240605;
 b=kORkB4OPuhZ7/sGmAjSFzvmdCkFSJxzc8I3w+I9OwVHi81W135FAWtXJf058RruF1p
 mMTnk2i3JHmfHHoPQrb4YQ8bQIQ1bi5xkJeimztHpFoNbYAQvUQJadYLouPnAhntw7Ea
 7K3diuckiICZz9EdUDGwquYOzhtIUWsbQ0FjZsIwhvx2jikBDpZM9Ogdm+gXn0ouiPw1
 5EED9wRhOemJdVKDPqnadLLaQT59C64QjqdORABOJFd7D/6l2JruZbqr2UgD/mfWE5uq
 bb60005NwQGFGtVd4lOO5GVGNYfYwpQAosrDP/OxqezUzDse+rMdY208eNW5qPMX1DJb
 dlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bwl/UmuqhM4/g/IhuVmS9Kn5HzDfeBwe3PBmNPfW3GE=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=cHYIlCgK23F0LwmuzcG3qSdGGz9DtMQXbAd36X3lrTo38NUpT/s1FiM5fFCHXR3u9d
 BJ/m2+2olb1cBMqe42ssaMKFXsS6B/0bsDvBMSjsjmYAs3GgrZobKpj6kMhIJ7K1nzrm
 IuVVv0gecfkmRAOqOdiqO/yKwKYVlUR4oKPuP9qrJRE2v3CLQI58RCW/XXluhA0qAbMK
 kWe9w5VQPObVJJXYauVk7NV35blSKfi72ptczQMIXNOJzip0CHOoy8ydIPhfG886Xkzs
 sOz9Id+QQQW4YmlTr39fop9ZunWmlSd5ceyHpp+G0HUniO4bDQvAmVgBWRIRxMkYTS1B
 lQEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537251; x=1773142051; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bwl/UmuqhM4/g/IhuVmS9Kn5HzDfeBwe3PBmNPfW3GE=;
 b=aRurYto2Ol4H6UgsUYDOSzQmcB4evoSjbaTqgJYgpuP68SuE1NXblDumdVcapptdDl
 r2TKvXXmIML43YZ2u0olz7DFHwpsK9UmzNvugKgdP6mVTY8ewe0oEUMbrBGtO2SIUA1F
 3sUYqTzFhfLrVEpI/d5dyAeAdr9uhw3ApTqC8aEMfB9PifgoNjrrJ44kEtFlZAN6Si+t
 UbNKjOcb3mbGU/keo5v/l0djfqNnVkzMlHdIdXTb/pKPg5r3F73BozpLrEdoGMyC+WiD
 Wgnz20VIsziBF0TdauTpaLIk4kg4wRbnYqg8UbecYToN5RuiSyHrPGnxK4qevq5N5BIV
 UmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537251; x=1773142051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwl/UmuqhM4/g/IhuVmS9Kn5HzDfeBwe3PBmNPfW3GE=;
 b=MMdaAOJBJy6XpLcmMxBLb/TpWgT6xGRkOQ6P+4TlWS38iJIYga4XcW7QxpVy0RDGsl
 iTW3Kv5PHutRzOFpESvdw8yHvYhMjNvI/xFQlij96yKCfmMDLZQ8vORqZPx9ayUnlzl0
 Y3KiwKOuqqHFxTLdlmkTmlBbH0ylBAHW/HY8A1X9nMz9qDkiQPWXGlLEu7r4Tj0HsFfS
 am3tFEo1c+O6Je0OCw0GEEsT9gYxVQKIXhNPt657/4crUnlP9iSaMllQYssiz4Ld5ebo
 YZ1CA6Pqepm+ejJakcBtmupx8gHH+MyVhEl6G+SZEQdo1FhaQ6PxOGpNLn6CRQqBuKj/
 D/pA==
X-Gm-Message-State: AOJu0YzbjgTC5v3cX6M8vgLvU2I5a4yJs+YGtk6g4e/h8TZmx/KRzFQU
 wisgaZd1tYVCnbBkyD8PTcAPlmu66WLU3GzdAOz2tngWfCZLx6T7y9PcVf+D2SK229aO2VZOFPl
 eHOCOO3x2VpJRlAbVM1F7485Uq2jbKk6mmxpFvA3uOw==
X-Gm-Gg: ATEYQzyvGUhBjmpeviWpYWt2IVO/9CMf8iUCchEYEGLij1dTUplaPY68E1PwtNVc4MM
 exZeOagoJqkGjRBLGyQIqSCgAWYPZ1xAShtptnwAbRcYui4rcAz6QbbmrRNUUt1yi8igPozrq+u
 EdPzeG+9zpvsTebpbIXju8N5mekKltUlFCfRFEwUCHL8FFcfidkRs+6MrrXLxNtSdzRGivhbdHi
 S3WMpwf7NswbT8jmNvtx7ncvaV3M5BRGpYLPJluqechZoYgy/qV9yde5+ZK3g7LY0V2I0fP+w3v
 /7PT74ul81cXDPI++kNASQYaWWVHe12G4bztivGoBeJsaJys7NnplUs13DBMF/446Kw=
X-Received: by 2002:a05:690e:175c:b0:64c:97ad:17dc with SMTP id
 956f58d0204a3-64cc22c28damr9071813d50.66.1772537250860; Tue, 03 Mar 2026
 03:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-6-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-6-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:27:18 +0000
X-Gm-Features: AaiRm51fNJHF0Io8q29dac6SID0toyi7KasfV9xF9UX8TlFCT4VmH-QqA6xZEyQ
Message-ID: <CAFEAcA_Y11BUgYZ9erfSgDmak5E9CdxHaAemj+7ntscDGLUTVA@mail.gmail.com>
Subject: Re: [PATCH 05/12] hw/char/serial: Remove unhelpful comment
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> There is no "is_load" flag and one can tell from the method name what
> the method does. Remove this unhelpful comment.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/char/serial.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 2c558cb9fc..f73de1ae4f 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -281,9 +281,6 @@ static void serial_xmit(SerialState *s)
>      s->lsr |= UART_LSR_TEMT;
>  }
>
> -/* Setter for FCR.
> -   is_load flag means, that value is set while loading VM state
> -   and interrupt should not be invoked */
>  static void serial_write_fcr(SerialState *s, uint8_t val)
>  {
>      /* Set fcr - val only has the bits that are supposed to "stick" */

This must be an ancient stale comment from before the device
was converted to vmstate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

