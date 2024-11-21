Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1ED78796
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEALa-0008Uv-Tr; Thu, 21 Nov 2024 11:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEALR-0008QA-He
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:47:55 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEALP-0006V7-HO
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:47:53 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso181497566b.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732207669; x=1732812469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVJOS+Rhlkgtxl072NwhDRfn80V5P78/kYvpqtRvjSI=;
 b=I6CdGMtCONvpYVmTwTGSK27Tpnt463u1z2vKuAyi+qKWTGFF4VbeufrmcyQ6hD8jts
 J5OS0nJ4gs13X9czgao/9ua4Kc4rN+g9pXm+8H5vhHWckHnAOoZwuiicLoXx6gVmXSNY
 RPMgjI1NP8g2k225VLBmEnx6737cWoCFxvIW0xt4007vvEd6+biGSOxjKTi4h4cu2Jk0
 Ys3JNQiIiuEwFAGfD/0N+9Ssx7O6XfmYVT4mIQCUvFTVM2+Lb2dNYzynW6Qfo8WuIMPS
 ZPEEVwb49T+61YBLQKpnPu2bEoqNrNTBdpiLKlP3UlvhwkPCtefjDODvdHsPOvDs2TRO
 Wq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732207669; x=1732812469;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WVJOS+Rhlkgtxl072NwhDRfn80V5P78/kYvpqtRvjSI=;
 b=X6KW4g0fvat3heSE0K+B0PBHe+3w02PFHedNHzW4tTQqlR5NQ8pBwgO/8IbasTFS0p
 LYxGxofswGT0sPSNjb41vluTkCluFuizSrNPPZ5bI2LcIF0s+jl1mQkNMNbLCIcu+eJW
 UqM8YTepACLshyhja/xM+UQLPGEOjCGvYD0xWFEWD2vu/BSOaYnK93ZsmNV+pDnOEOBD
 KpSZ7W9zZToohAFWw0CSq73zFdW1iYJJIpqxAMJQBGSUMtjFtML634i+ywhPhMbSwTXL
 mQKkhmsQYHoZMKVR8/FuGJ1nnQq9OSp4Lf5vazqg1187oha19I+K0ux4p++P1JhegoGk
 yH5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLZzrhprqRBYdjVO7beNjciEscwopae7I/rM6p4ZfhYE5MnqT/XY96jIFmFvxCHG1twWd0OyKPvpmC@nongnu.org
X-Gm-Message-State: AOJu0YwjdOTKikmgOM+uUSFJpWliYSyoNdbVmt0dqeU8mSqDIUC7YvZ3
 gauRHFiS5AIqJEH6clloBXUPoilOKmq4YOF9IvxZdHParcHlmiG6V3d+5leUfWk=
X-Gm-Gg: ASbGncuF5l6bPXpIQCyN7rtxm8kpo4N/2nMUQt6/3CsHKKa9pVycp1cezPpAhF8U6/U
 PNnVInbbak5ZmYeyLueECmcC1TefQZXLSBlO/HqAo8GfotHqz8VSnCKvVaWEln9OF3xDTZg4Q7P
 yOayzTKJdS4P2PrhPCKZtM4VFPskUSUj3wd7pZdiwKiltTR49SkTkopplSr9/z63nw1qOdtfsuT
 OxXwgH2TVHRVk6TclPzyTKhoppKwQFT5WTATuAWgoKdjOyF
X-Google-Smtp-Source: AGHT+IHzljkr9YzL3oqJhGns1efsh8GNd5Q0GK/iA1xbOxtzAbxaB2mXNmsQxkvZjp22+ursJmopQQ==
X-Received: by 2002:a17:907:7292:b0:a9e:c947:9855 with SMTP id
 a640c23a62f3a-aa4dd70badamr754599066b.48.1732207669125; 
 Thu, 21 Nov 2024 08:47:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f4181818sm99210366b.82.2024.11.21.08.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:47:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A9B705F77B;
 Thu, 21 Nov 2024 16:47:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] rust/pl011: Fix range checks for device ID accesses
In-Reply-To: <SY0P300MB102644C4AC34A3AAD75DC4D5955C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 (Junjie Mao's message of "Thu, 7 Nov 2024 14:13:07 +0800")
References: <SY0P300MB102644C4AC34A3AAD75DC4D5955C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 21 Nov 2024 16:47:47 +0000
Message-ID: <87plmolej0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Junjie Mao <junjie.mao@hotmail.com> writes:

> The peripheral and PrimeCell identification registers of pl011 are locate=
d at
> offset 0xFE0 - 0xFFC. To check if a read falls to such registers, the C
> implementation checks if the offset-shifted-by-2 (not the offset itself) =
is in
> the range 0x3F8 - 0x3FF.
>
> Use the same check in the Rust implementation.
>
> This fixes the timeout of the following avocado tests:
>
>   * tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_virt
>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_virt
>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_vexpressa9
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>

As this is the simple fix I'm grabbing this for rc2. We can revisit more
Rusty solutions after the release.

Queued to maintainer/for-9.2-rc2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

