Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D566C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJ84-00005O-G5; Mon, 12 Jan 2026 09:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfJ7o-0008UZ-Jl
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:42:35 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfJ7l-0007t3-UK
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:42:31 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-647374e4cccso3269869d50.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768228948; x=1768833748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buNAGQBfalbAJmlCHEuVbuvIMsReOMXWM8BJbuivDJc=;
 b=qOimXgvAW8qI/zxhusA8saXcmYfOPGdEanV1ZPP5KGYWAuQSmGmeiC/Oin8RXCLC7a
 Lp0pkv/kDXv2pWfg/jutsJub3Zh/7mVdNztuVlmgltUF1sg0owQg+gyzvh4VVdzY86cE
 JknM5lPtaBZUAYtJfnHsbOv7YoFEu+RygkmW63KYySA2Ar3W6A3XGH71wE7YZW8I/KN4
 7gFv3kjJgxNiSg4waVgVDWpr9VcIQLaG+9PvYwiB45byJCZrTVOhA0GMEaAKxZxbsSej
 QeNy946XdWuHQ6w+2URxLz+pHOdBBGstCLeDCJ0KvMOI+GzDIuN2S03nQTt9aSXf4uTJ
 Mflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768228948; x=1768833748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=buNAGQBfalbAJmlCHEuVbuvIMsReOMXWM8BJbuivDJc=;
 b=uyabxqZMd62DRqy/mUVtqXBnnyjHKJFvY+ecM1bSi0PM+ogTltgqrPlMbeY+nX2gEz
 b+fMkDlTQo3BbPCoSIXW16onZD3mmmkIbhXWxNQ4zBNu2MaCXW5f5ix6/c5r4cJ+S8Y7
 B446EeAHWdJmRwbB3Oh8p+4ne1/HFbxuLuEkXj6+sh7vhe9Y6nPjQqPokwExDSpX9NCv
 JFmcwCtLSVr9UnFJlL0zZ124ssrnXQVGI/RZjhl0sFLYQQgMnM5dRe14S+7nnVzJcd95
 Rmm0lRyj8treIlJ0gWsF6YRPvTSuUJGPfytiQCyzo83M0KSs0lbZya2ZFbmmWaxkmsMn
 T9jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+H+Uq0Pysw5ISkp0fGFCy/C8qmYmg+Dd9Y9jgPLvNKbL0WyPCHs3nnApFFXjC7pc5YdP2L1NIhBSL@nongnu.org
X-Gm-Message-State: AOJu0YwmwRL+3/1+MYZKaC2YodHBxbetA6awsu3bkz560/62hcMN9Gpd
 NV1DN3guCANyzx4TNiGgR1eZck04ZqTdvwy3unCbW4JeLHt/hIBFxl+M+2g683F7VvVxHsHTFFd
 Dcyz/uurGgZpVudv1el5S94ywXYNRjNA1CPkRsp09hQ==
X-Gm-Gg: AY/fxX4cQ0N+UvsrOtVB4MgyiTjVbMxpqWGLskk/0mSzTpOb/2tpUvMxWI5MDXG47gG
 DRskIbLKJIHYiZgR5uWaOLqCDhkV53xn+RA8eUrjxajwvWipimF/gLkG8Da/ViLvTl6cm3gY82Y
 OL86N6yjYsUYnv73t3X4mw7kG7DEYg58OVaAM621IEn1pyqobOnNrSS01hue4/oJQYL+iIP8l3P
 eCZe6QP4o+QkEAtuWfcNZ65HMknP1nNMa30zdBD9O1wUYH9zirIQ4AbhIPWao2huWWAvMgGqzkQ
 DjEKOP8nAPhoybVO48ST/Q8=
X-Google-Smtp-Source: AGHT+IEM/F4U5UwuVj1leGNwdru4kViCn08eNM8SNVJiz1vZnSlviFWQND2aWv9k+Weo3aP2PD4aUmrO5K3wy17UrjI=
X-Received: by 2002:a05:690e:d8d:b0:643:79b:fb1b with SMTP id
 956f58d0204a3-64716b71fc2mr14212491d50.21.1768228948539; Mon, 12 Jan 2026
 06:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20251218214306.63667-1-philmd@linaro.org>
In-Reply-To: <20251218214306.63667-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 14:42:16 +0000
X-Gm-Features: AZwV_QjOg70A_0pri56CpDZGx9brPDIUKsu3IHkSe4waXjTSNHPzwdGnkxhs3ag
Message-ID: <CAFEAcA-vKfpDQJws5m7C1H_N2taPmGXE=gH8hRFxHH7L3u+w=w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Jackson Donaldson <jcksn@duck.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 18 Dec 2025 at 21:43, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Unfortunately while rebasing the series registering the
> ARM/Aarch64 machine interfaces and getting it merged as
> commit 38c5ab40031 ("hw/arm: Filter machine types for
> qemu-system-arm/aarch64 binaries") we missed the recent
> addition of the MAX78000FTHR machine in commit 51eb283dd0e.
> Correct that.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248
> Fixes: 38c5ab40031 ("hw/arm: Filter machine types for single binary")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/max78000fthr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to target-arm.next, thanks.

Should we cc stable? (My feeling is 'yes'.)

-- PMM

