Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31967FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 14:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp7Jc-0003Hu-1M; Fri, 13 Sep 2024 10:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp7Ja-0003HL-6y
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:30:26 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp7JY-0002f3-E6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:30:25 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53660856a21so1004472e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726237822; x=1726842622; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kpb8BbY7i4T4v3ULC8ET41Z7790TnbBTOoJfA2gr4wM=;
 b=rK78a4hAwur3n5tA3W/30r4tU+uV4YYhFlYyzrZ1/7r9T/6A4CI2b3uPkXvB9mYJSX
 lTcCiMTLoNqJ/OU0fmwpFoYYhYJIIbw/0IAvXjMSus1FoC+x6Tp1yAxNNmBLFwgLFNRC
 2TE+SJJe4DxKJXXzbAM34VetO24QLbUG0Sb2y5QqXOnXItyZBVs2L6mopU1jpFQ5ZpuY
 6dVvz4o8EQaeGYXfUf7LhWRMcBwNdmAh2GbqPTHRVYQnrkTMj9cWnRI0EHglpMIm6nm1
 3/0hJz4GanXxpuJvTmJAOYxgjDphavS+YhIPeqwdvO3/26kEmSDVcu7wPB+qt2dF+ePn
 oABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726237822; x=1726842622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kpb8BbY7i4T4v3ULC8ET41Z7790TnbBTOoJfA2gr4wM=;
 b=RdE+gXh7v+AqoRDNGhMlpqLwQNBN5AA3O5nO5dAY+TLo6+jaj5lAAVjSysM4SahvGW
 xVQqHowaGms34snWWeqDCxph2cdZdN3mPI15P2CietD/MSJiAlGYvYczaJIkG7ihLgIs
 vHZ2iYg753osKaIAYzWBZ8C2Xfm3qrEOWo5kSw2hBGcQTsQKUcYA2g830TenSkY55Wru
 rckkk2PWrN3w02NOuuo/18WgcNmsAUowQTVdgDwdQTtSvM3vYAdQGG4FMWr1n8FrKTjT
 5lTLMCDLAoWjq8w9BvT446Ju13KOCpzk87p5GPGVK0myFe6lR0S+UaAnR4DNgLAl3I9U
 odzg==
X-Gm-Message-State: AOJu0YxGgVQcSHNPmzENtzv+8BtW3uYKt1sBS0dvsUjWvPBABZwNlBif
 b0JmVFubXWKaWeGskO42IitizvfVCXWngJ+ZaZ++X+bUKw/jgkMlbyXfXUNWvShaULNBuZPvoPw
 dNLfB0HWD8Bw+szIqagQTBo4R+hTPddGAuCYM4A==
X-Google-Smtp-Source: AGHT+IFIOVvWjzziCxPtwUoa4lDqfIZUzLyubU9wP9o5ClgPwmKwpKr38DeRK78DOUHHSwJNTW54ayUt+GcT7cXOTBE=
X-Received: by 2002:a05:6512:350f:b0:536:55a8:6f78 with SMTP id
 2adb3069b0e04-5367fecd0eamr1559180e87.17.1726237821965; Fri, 13 Sep 2024
 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240912065227.67848-1-philmd@linaro.org>
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 15:30:10 +0100
Message-ID: <CAFEAcA9uxg_du0PQKpFf-tmcQWWY-u54v7c685F7JNXF2vKpsA@mail.gmail.com>
Subject: Re: [PULL v2 00/61] Misc HW & UI patches for 2024-09-12
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Thu, 12 Sept 2024 at 07:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> v2:
> - Fill Pierrick's commit description suggested by Eric Blake
> - Include TMP105 fixes from Guenter
>
> The following changes since commit a4eb31c678400472de0b4915b9154a7c20d833=
2f:
>
>   Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/sts=
quad/qemu into staging (2024-09-11 13:17:29 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240912
>
> for you to fetch changes up to bd480a2baab659abe90da878bc955670691f53a8:
>
>   ui: remove break after g_assert_not_reached() (2024-09-12 08:44:48 +020=
0)
>
> ----------------------------------------------------------------
> Misc HW & UI patches
>
> - Remove deprecated SH4 SHIX machine TC58128 NAND EEPROM (Phil)
> - Remove deprecated CRIS target (Phil)
> - Remove deprecated RISC-V 'any' CPU type (Phil)
> - Add fifo8_peek_buf() to correctly handle FIFO wraparound (Mark)
> - Minor cleanups in Designware PCIe, PL011 and loongson IPI models (Phil)
> - Fixes in TI TMP105 temperature (Guenter)
> - Convert Sun ESCC and ADB mouses to QemuInputHandler (Mark)
> - Prevent heap overflow in VIRTIO sound device (Volker)
> - Cleanups around g_assert_not_reached() call (Pierrick)
> - Add Cl=C3=A9ment as VT-d reviewer (Cl=C3=A9ment)
> - Prevent stuck modifier keys and unexpected text input on Windows (Volke=
r)
> - Explicitly set SDL2 swap interval when OpenGL is enabled (Gert)

Fails tests on some CI configs:

https://gitlab.com/qemu-project/qemu/-/jobs/7820098438

ERROR:../tests/qtest/tmp105-test.c:103:send_and_receive: assertion
failed (i2c_get16(i2cdev, TMP105_REG_T_LOW) =3D=3D 0x1234): (0x00001230 =3D=
=3D
0x00001234)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/7820098228

ERROR:../tests/qtest/bcm2835-i2c-test.c:84:test_i2c_read_write:
assertion failed (i2cdata =3D=3D 0xad): (160 =3D=3D 173)
(test program exited with status code -6)

-- PMM

