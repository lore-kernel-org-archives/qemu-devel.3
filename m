Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2106FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 10:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq8ry-0002AC-SF; Mon, 16 Sep 2024 06:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sq8ru-000292-4Q
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 06:22:06 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sq8rn-0005CI-AL
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 06:22:03 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406fa5so1217380a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726482117; x=1727086917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjQKX/Qb8D93EO4xmaSZnODQy/dLuRTYQ3rhzDE+zf8=;
 b=nl72GqXhZuB5hfMhE5ViYRFZ4Jchr2uNcA3sRfiBgR///z3CbKR6EkPminazCGfuSv
 IIrfbhfMoLTk+fVTgJWGOVWMsZlWoprg+nFC9u9tV3IcBi/wuxFUPNWMqW+vYkaWE9q7
 zoVO5BzYZIcQWDITZTu8W71ujBDRLZ+tjxjlooJl7CVWj6d0EC8g97v643NtFiQjdT1v
 YVNksG0VD5x7PP180MHpNxg6v3nAaQ3HZ5e86BHB0K3cUHzupd3f+O/xHt/KlimWFV8C
 PzAzIiC2IAPoFMz5+vLS3VYCS7OA0zrCK/OImKq5QjUCwiHjHmLvHBcYPnHfSarHLZtk
 Il/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726482117; x=1727086917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjQKX/Qb8D93EO4xmaSZnODQy/dLuRTYQ3rhzDE+zf8=;
 b=NDbp0SA4v5/exHeWtL29wALTr9SnQBupCZThee4q6xo8ZhwBON3IYyXbhPlx+1gz1U
 B/nUArOy3dpAZOIbLOIlY+6WYmokQgp+ijbESlevJ+yOhXD+q+Jnd9aFXE6ytFgctjMo
 WNBy0lBKLv7wFUHbabioQA5WG4We96dC4T4CfOyzr1dq0fyZyHUnVmjLpok8M3mYEiVi
 1mwfQMfdz0Z65dsogtpDGml/wTMcm7uQEvoSAsmwsj4b/3MzxjiCOslc/2hBUqxBxUjj
 BVAaF2UbfQOavzvXkb2x81tV3BsQnyS83b6Lu22VkpK/ISY9LpUwlFNzdV7rG4T20ua4
 GzoA==
X-Gm-Message-State: AOJu0YwJjQEeSYyj/v8ek3bINHX1KSPeXaSkAd1sn/Aorm8FMHnO1xdI
 EeOwvn6gejm/0lu2nWox91MWZB2PZuZ2qCn6cNXARrFNxPeIw2IjvLHRd99TR3vhYTceJQOFSw3
 6WNs980TW+sx+6/25e04kBVfx4pbdjMYzEl0n8A==
X-Google-Smtp-Source: AGHT+IHjMPGqSIqbaU9vlsS2OVh5cAeNpvijz+xQ8L/X1iT8csBdhI83lBYmts86TA13AcfGc/l2sxJ3UogIizP7Q7w=
X-Received: by 2002:a05:6402:210d:b0:5c2:4d90:988 with SMTP id
 4fb4d7f45d1cf-5c41e2af424mr21064289a12.32.1726482116585; Mon, 16 Sep 2024
 03:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240913203216.15265-1-philmd@linaro.org>
In-Reply-To: <20240913203216.15265-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2024 11:21:45 +0100
Message-ID: <CAFEAcA_cys_FvHn=-6kg_eqUwfm8AqywLpB0iLs+A+_75fQCUQ@mail.gmail.com>
Subject: Re: [PULL v3 00/60] Misc HW & UI patches for 2024-09-13
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 13 Sept 2024 at 21:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> v3: Fixed TMP105 tests
>
> The following changes since commit 28ae3179fc52d2e4d870b635c4a412aab99759=
e7:
>
>   Merge tag 'pull-target-arm-20240913' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-09-13 16:14:33 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240913
>
> for you to fetch changes up to b3372e0ec818d7747963a2ec7ae04fd1a8152afd:
>
>   ui: remove break after g_assert_not_reached() (2024-09-13 20:12:16 +020=
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
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

