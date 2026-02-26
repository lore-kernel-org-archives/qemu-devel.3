Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A98AFC591C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 09:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvXnJ-0004RP-4D; Thu, 26 Feb 2026 04:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvXnH-0004Qf-Dt
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:36:27 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvXnG-0004w8-3w
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:36:27 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64aea64bf15so505133d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 01:36:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772098585; cv=none;
 d=google.com; s=arc-20240605;
 b=bC52+5UZ5xdnhDbMfXMCF/8mR+m1AUgcpsSAgBIORL85wmjZH3dkxWHdZTh/abQugN
 ooTMQuh558aYm3MhjfukBSLcesGJ3XGpV809pscgmeu8cyYUUvye5MAPlOz94mRnOmtN
 FTTMuqp0FWERZaiEme4HgqWJcFZcE8N4FrXylb+yVJVMXFO3XEnoN5HBNt6AukOG7RPC
 3oCOd4DuMxhDWkX/6g2KRjt7BDH/Nz6lXi9AFfLRKt30Z/bEBOR2PigcyQPJLP/G7PPk
 UlMy4lJFr5Wn1GtF8xSZqBb7uiQ3UgbqjtCcPql8xdBP9veXf1IU7o+9+sLsv/cVaCCm
 csXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=exFFOi4y79s0qeH9rSljmah4q2wm8qi2k5fExASL6tI=;
 fh=7BxPDqlzVkpEZ17CuLnPivm8aYJw211fAY8ney7dqO4=;
 b=Mp05oT3rqNgExbnfpcwTCmHqb0F638o0AEVUvdSc6fzpcU2vckyO8xnpUznH2J7yZh
 Mhmc2e6GBh4A79LFdpkd8ApTjhDXuwV9QUFpzjxwO0TEwfGPKcj/La10D046dPebCdTx
 TksNjryirwv6hUUmE5qsDDOBgh3STnbmC83M572yP8PAgmEbQBih5+GOJ6EpXp/5qjBz
 uic1YXBFjuuoQeTtoraIiFO8YhlIzTtRc2PoUFhL/lMv7HJS1ik/6WtO0hvtlh3TksJ9
 88Xgj0u2PLRcbM4q6k+y7eZmfZvKXuCGpszPr2kNprIsEnGILTW/f2Iu5W382YxCU8OX
 3v9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772098585; x=1772703385; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exFFOi4y79s0qeH9rSljmah4q2wm8qi2k5fExASL6tI=;
 b=m4Tn7FA4Hm1z2HToxDFYyVf5fjvKGBAKuCOmdqZoICPEpvLJngf+2Fm/IDj9qBZ+jn
 Y9VrXUEBR1itbo28d4qxUydIcQZumPasSoPQqlgd3H7Pso1KOmyvFo53xBXs5+Tm4Ur5
 M8pq+EgVet8Duw43rie0OPK+UOXaSqu9r/FMO37q7R6corInXolCiFsi3ZiEGUcN7khl
 gb/wd23Ok7OU9RRP4tLNaCLIeEQfAyBJUSrbjhasU4t8JoptGG7UBSkdiByNXmubU0yX
 nQt6ENa8fgF2jAdO8uu5vMcIgm6/KKDCTLoYrLETbbNGAo61tiTIAfI87CzkjeVHX4qa
 axTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772098585; x=1772703385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=exFFOi4y79s0qeH9rSljmah4q2wm8qi2k5fExASL6tI=;
 b=ZO/wtSxIGfGREhkgr+xi+E1mrQOZ56maJsuKV1h1ou07CTf/mYvM9CwYw3/DJx3TTb
 d0XKKC9T5liAyxZGuryZLiS7Rgvv6ftDcmlIj5Ek8wQxp/FvNPvJ6YXvdYccY9o/V/kB
 2soPkCOYU3GKsldC3yUgLIv6YnPpprEgiND9zbBU7LNzzFf8fpRDqiNHj0L8KifuTxBF
 86brxK39a214tET08vJYJHQJf0+1qXfVYPNtHodz9QVN5snn3bTJJbt4EtSASPXJlq3C
 cdCaBysb39lTPm2vCkbVBihR/DNv/Dnt1vOgkR1TYmAOLkHMKtD+Tmb+rPYDXM1vRwNM
 ksiA==
X-Gm-Message-State: AOJu0YydZKEB0XU0sSE+KC6+RvDzyAuUT6EaIUR+3mPFWSuN838yudvs
 vaJOMJk1tfmx3cLMGj2mrplcXyKw2cCUk+/pz28YCM2mRsm0Y2UOVfK/jaULGkoZaMtTS5wXjza
 AM64gijDVMUwmldeW9BqqpDVjK6sGbwhPEfULO61toQ==
X-Gm-Gg: ATEYQzyAmSJq9c7YyCzZjD9U2mXrKQFe4oMK37GOpQwTVlaU0uGOtnE9FzOLxb+fM8M
 UB+UXIHkqWSFdnCdVnWcl7yjcv65wB1ACN1Xxvfm7+euXHnCyG5jNxlP3qHdbNU1f75QGw5m4GL
 w+cdbtE0EY2ZK7m4ETH2PIcX8Pa13cMaWA/xlktIDM5kBP7khBecUJSURu7fsRCSq97wpoqbPIq
 i/+UO3lSkXUuKyGRwS+pIVEVoxvFt4qSG2NNwccmoOHsH5YO4CtFOtQPI+x1hrOow09fYnD/m6D
 UMyHixky2Pw+X4ceY9YmSxFKXfphOVor/Rbke7B122qz29aP/R8/tYC2O8JqcVGaks0=
X-Received: by 2002:a05:690e:14c6:b0:64c:a7d9:e1d8 with SMTP id
 956f58d0204a3-64cb7bf5664mr1110052d50.15.1772098584806; Thu, 26 Feb 2026
 01:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20260225034720.41495-1-philmd@linaro.org>
In-Reply-To: <20260225034720.41495-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 09:36:12 +0000
X-Gm-Features: AaiRm52M9nF0Hng6UTx1SMzEjHsh3PnEsfl5i3Ul4X-5bdYVsfulD1A_WQyHhTA
Message-ID: <CAFEAcA_gg-t2zwmQxf3Lunqbqcpmo7qyPDK80q2jRLiTwyPE2w@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/allwinner-cpucfg: Remove use of ARM_CPU() cast
 macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 25 Feb 2026 at 03:47, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> allwinner_cpucfg_cpu_reset() doesn't access ARM CPU internal
> fields: no need to cast, pass a generic CPU pointer along.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

