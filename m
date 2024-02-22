Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B5FC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8Uk-0001z3-4K; Thu, 22 Feb 2024 07:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8Ui-0001xN-7N
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:48:08 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8Ug-0003lH-IB
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:48:07 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so166243a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606084; x=1709210884; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7u/k5M/RI+WotHkXlqKQDkTPB/dhfYgT100Q8pNv6WI=;
 b=p5piQTB+JEwczhIm5vUJe1WXoRt7z3rk4i6X+qgTICdAWjUuDENU0ikUlD06Fh1akT
 DpoBgX3xtR20yitGoOFGe2qEei0Zd7Gjg4ZpSoq8l4+aY7+hGF6Pki/taW96HoSBwwKn
 lUh5UEdEJ3kkkh1B6pKNKL8iUXewM8BfSXJb/q1s1V5OoXI7YJDbqJh64d0ItlEs2AUb
 78MyRJoiFU74b4H5hzFiiTubG/uCMcfPJmo0yYWWSqgtDdI5hPzcaaSZy+vSwhUCBk04
 pK3AnDFkgI2Cjdcb5Jv5+ASir3jHNxoE1s8fjd6efnl6/HSANJq4op+QrL7TrJTL584Q
 +FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606084; x=1709210884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7u/k5M/RI+WotHkXlqKQDkTPB/dhfYgT100Q8pNv6WI=;
 b=C9lkJ1yNLYliGb0I8nahEDGOom8Eos8aPEsAmSCT0EDEqO9rGC1HNfR7HFGyz2jvqP
 PJCanu9SXACqpS5WDSP3TlbpUYXQx48rdjFyHqvRavq+fF/FpF/tEJeEdVY1upqW7+nL
 0H9391ImyGkMZKrQNr9ZBoCPoYm6/MXOvF/RBo9tRVhQz4aYnIKN2fP9H8yxuwlUCy1i
 6cV36R2a2AqRmN6xMWCn7ua+sozP/Bl7+XBwbbquhmsNyFCyDsuPy9qxumlvjy6krA6n
 CWFj3tSLzaLc0EvnCAGNpUVfFpyeuCAZgnpJXNNhpwN+IoI69rgmm6axv/Pb1qZiesc2
 u/Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXzbQmCgQ2tZlaaefJATOKdnJaK+a2UMYcPT7rE1y+MP726IlnRBFQHUh1/5UhGdEYC7o9Q+YtdTjp5pqhtWbIh4ISoic=
X-Gm-Message-State: AOJu0YyGGaLpps6KaPgLinnPvvlJxC8eLz3MOgR98iVlJACCBmmo0Q9Y
 D9CsH7ytthDXUdhT7JF4Gn4R6ezSQOZaxzVnIS3DNehuTCcVdcmxzd1Xx2fSA/WUtcmCeqjKEY1
 6B/gBbKgtqd1LFXukiumyKsvFOOlpPV1xHQqkDw==
X-Google-Smtp-Source: AGHT+IH1qOXRRvFDPJ/iOhfXJ8SncrzxOgTXcrgU0OB9dnz6tp7FXfMWZqFojM2Ru0Gm8CN80gBzwfms1Iq4y6pf47g=
X-Received: by 2002:aa7:df83:0:b0:564:bf98:9bf3 with SMTP id
 b3-20020aa7df83000000b00564bf989bf3mr6796702edy.7.1708606084119; Thu, 22 Feb
 2024 04:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
 <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
 <CAFEAcA_1zEQ-bT8bE=74FC24fz7HYN6j8ZLZVaDn7C47vraNAQ@mail.gmail.com>
 <87v86g8zbd.fsf@draig.linaro.org>
In-Reply-To: <87v86g8zbd.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 12:47:53 +0000
Message-ID: <CAFEAcA_z=uXM-Ez-DZDpOd4OP-DPfmEjOX0bHR66igALhvm-NA@mail.gmail.com>
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 22 Feb 2024 at 12:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Is there a reason why we aren't covering those in Windows
> > builds?
>
> I think it came down to the Windows builds being particularly prone to
> timing out and these targets being fairly niche. Do we really expect to
> catch build failures here that the other more featured targets wont?

In my experience, yes, the weirdo host platforms (big-endian,
32-bit, Windows, BSD) are the ones that developers won't be
testing on and that we therefore want to have CI for the full
range of target configs on. It's safer to skip niche targets
on non-niche hosts (read x86-64 Linux) because you can be
reasonably sure the niche-target developers test on that host.

thanks
-- PMM

