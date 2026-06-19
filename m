Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA67CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZXq-0002lF-O5; Fri, 19 Jun 2026 09:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZXp-0002iu-Et
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:46:05 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZXm-0000sP-60
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:46:03 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so2043099d50.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781876761; cv=none;
 d=google.com; s=arc-20240605;
 b=KE4R5T1qkKy0RpChOeBfsS1tavzynHW1kzvp11grUeX8syzTTQNZO0Jx58a6FKH8u9
 mW9awRWQqEjIDf6KYwpwZCvIFNyTsmIZ6SzwDPAULRxKTbHm2g7MMBRDikbwct02KoAJ
 9SjJNkqY42fij93VIf/R2eMkLFyd7VHtkWTZp22eX63k9Xpj48U7VbIz7gTX9f0AloYz
 qwycurOq8kXVq1EgSCHyMc9HdnutXGq5qNDHwmaQW+8ha3fQxA5mlrIvmPtCQVl884Cr
 +3MvKGWBiAOWM/O6S7+25Gs3fHtTrFKMLKLewFrpNd9mk+CeTYIZnIokJE5YtVkZ1T/7
 izrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gh21bSGzICET5QSLCfmfqBZ8RR7gAGyR6ylIzI85FuU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=QViFafXDZNegQpS32WLIpU9xLivGILlaJnSVHpdxqtTv86/WiMO/whSsAlo+uYApNY
 a10ZNAPwk3mwX5mtXn3XHsia06C9yWnVZSAA+rsr4dnE3fGM7MziOLfbl3f17bH0BdIt
 aUnqjHYZy0wcSdr/bR+NXEbMZVgaQ8RqotQa4Wi+s4NpMzp4SWCYWSBtPqInXBpJEnx5
 GiuLFBBchhMIqyKQI9KB5vAxM+w5/sRVVb6bssD2fhej6QJwaHRsBP+CLM4hgC1OlrWi
 m//CMyv4EIgnoNuNy0dnTgiBeRN0NhqS/eZfW7Dlhblela9ox/aRgFcpd3EoGsHj621H
 IuOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781876761; x=1782481561; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gh21bSGzICET5QSLCfmfqBZ8RR7gAGyR6ylIzI85FuU=;
 b=qCmJeoHQsQHruUY+FoGemp0LN6XSsx+22qNKlx0nTeZBNCRkLowcEaXjDoQRyCk027
 IG/UdgoOqs/lPULBGZkWKF4RDs3gxyagJChW55fZHOR6n6+dCmj2YyoHRmqRnBoWqljK
 dEZWfKJcSYupAhNIyIWeyr6G4A99A8KwrVrky9Ao4Vb1gPphQACr5EVYzXQVxmUbwlLT
 ZtVLFe4HRsG58/GKSROAVXjUYjWa5o0HKKAna//GyTK/mFk04OIrRu8nXtowjc1nImMf
 fIt2j6cC78kyA6OxtIBCzqqSoqas2mMtFFcOEXvFKqg89kBXDeAhnm0mtcOfxY93c7Tx
 Mynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781876761; x=1782481561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gh21bSGzICET5QSLCfmfqBZ8RR7gAGyR6ylIzI85FuU=;
 b=EFRy+aTVJF+tyomSt1hQ0RZBCHeo+qW/cO+Iqr+yI9TrYmM/Zl1vU4TbMwhQh6E1cg
 EaH3uWLcu6o8mnzZAntOfb2y8PYFcNTo5EeIJPn0/+NHt82mxQssIaVsML0k4pH9p6Iu
 S07geBK89PsMJT/zaVp92MCOTPrLi2i4JVksd8E4fn5Ge/rLVJFq31AtG4MC7619FqGM
 KIBate5Z6aZjcedJtjma4RxzPUtz8BmzwM094bah8+H1avNeu/s149RGCKI9F8h2PAaK
 zA86VQQb/O2kXVCecYUkWumCo2CQoLVfrNFomQBQrqfgKwpCWvcMm+g/ldCASwbbXiCh
 a3yQ==
X-Gm-Message-State: AOJu0YyAVuku/EJ+qE0IFuK+0ES1/gTcAmP7GPD0ExonwzCOLLLtTgHa
 J9JPPu/3uN3CSkw2cJyK6yG+QM5FnZyG/iuiVhVdRgw4Tombvenx7bTp5q1P1bW8kILEPW7szRT
 h+ZYFjGNQoV0rT+ZjcdW/MHzyC46AUJQgalo25VvODQ==
X-Gm-Gg: AfdE7cm2rlqdTSFXXl02c3d8i9+fmPXao27vkN9MUtSP3Cl+47byr9WyalEiE9k/7JW
 NxAwdi8DbyK4S0kphFceO+HIuNbE/fBw2gHsouYfOLmiM68M6jECv+3HMzJ/hs0W2aoTxn1JIad
 Bp+xN9IYlQH3OlJumuKD68nYeaAvt6YdRhOUHqR/CKuo0oir8VXEVgkSO34B2NdozKPStqY6yFL
 bkFfHERRPGVK9QSHSrv/EZxYs9xYAs9e14Do6dj5Xwpt6YOuABbs5q28ug493fo1zbpp2DHtwTs
 qYb8HHt7IQYtedINEmJHreFrm7oiJeA3OVSfMp7KrDbKonE7AM1755oo
X-Received: by 2002:a05:690e:c4c:b0:662:f9a7:e4ac with SMTP id
 956f58d0204a3-66302ef7a55mr2121613d50.6.1781876760659; Fri, 19 Jun 2026
 06:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-7-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:45:49 +0100
X-Gm-Features: AVVi8Cd5skPzp8FhT2NgTRKG4J1ADudgr9jxXl45tBwa3aE2nkskPZfEFGeehAo
Message-ID: <CAFEAcA9ObA++6+3pTjciW+F7vVP3RBR9PtYCDVqsPSyG0DJajw@mail.gmail.com>
Subject: Re: [PATCH 06/10] target/arm: Implement FDOT (multiple and single
 vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 18 Jun 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 8 ++++++++
>  target/arm/tcg/sme.decode      | 3 +++
>  2 files changed, 11 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

