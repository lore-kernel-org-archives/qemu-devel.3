Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF15CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTdT-0001FU-Sp; Tue, 16 Jun 2026 09:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTdQ-0001Ew-FW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:15:21 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTdO-0002Yg-PX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:15:19 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6611669cd16so4722804d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781615717; cv=none;
 d=google.com; s=arc-20240605;
 b=Zn/SAvP7g8J5HBZmMsvgnWh3Ac/1dz2J0rkaW7e9Qv50pIRjcymz2C3LJZU/XlZRTW
 RYfp58AhU9LIbDZ9UBLUWi4e8L79hNHjI8qDIP61gAfwJbkniHfDiuPk2HyTMEQWfNwo
 9M3SAKAlWDzd5pQ4NgM35xRqEmS49+Snhud7yOQIUYIddWi0kuyjQKo+3INDaAWMw70g
 L737fnNMlPQz26Q3VOPsXByFdjmfxT2ymuIQOKUhWWek9WLnUG4RbaU7FtRr4zusC5je
 eP9E2Ln9DRQfT0F4LtFNt/vClFR4lwhyAmK51lJjpXxJxqiFPSazFB3khX647w7JMqWO
 WZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wiwSA+eYC5719VbwnHl5FA+TKINMENvh5LtGUpUzGHY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=EMdse9jPuWKEL6gEI52/5fJ98CKwoN+8V5o/x8hkxVixHhVjvP1JfOx7EnRMqI/qyb
 Rk6NTHYx0n/EmPZ7tlw6bv5BtAcoRjv4NM+8+ZVK0J0os2Dd2E+BsXeW1hTLSQ4X2cnA
 OoGP7AUox2a9cYIQNrCvKVTmemEtNJUs9f5axZ5ne00zrdybk5hDVSzwd91DvE3HL4GL
 RLmD/AeTmkmKygVQWN9P/RABOv5lkQluhr1mU6jGiVIBmJEgJdwmsE9VgpuLqek7DQ6b
 EnpSpRiAH/66p/4VOVblfsQ6hTrv1FPWIbt81F/iHRPZeilqLMdB31hf0fIAsuHy6//w
 E4pQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781615717; x=1782220517; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wiwSA+eYC5719VbwnHl5FA+TKINMENvh5LtGUpUzGHY=;
 b=Q+J1xxhaLUyfDx0DovBCeZRZt8ImRocQyFR5x+5FOW7Ou1sby6N4x7ZOCYrZj7MC6I
 k2nf/o9RYlsLc/vZjfFbocWCQaWlcNR4Fy9uh6mzwxGZi3m/p+/T2muUWDH4zL2rKr0O
 JTQhjpW04B3FQjYSi2MXGSn2JEYtjP6fLGF0RE46JeOr+Cxsx9/l4jjGc7SPzRUyeUHq
 E3VLbR32bkyQkaw1SHMcusZwIcxGno0KZMSsw1663yWODVb4ce6KI3DGriJFB7Rt7aN8
 mKeWweV00UUNI8/sMfRAl6/9EnHKy8d6ykFz7mSPPufHD79cBxd8FvCe7FbD5YdhTCdf
 I2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781615717; x=1782220517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiwSA+eYC5719VbwnHl5FA+TKINMENvh5LtGUpUzGHY=;
 b=lYry0R2hVJUvT22ae9NECuKYubsGPKLyHZ17xHvvYWEQ8+OahPzjDObVjAFekcTm1K
 1CDzgPW7GykIGoS8fK0hoNZkNRfni0pxGv1NF81j0XBbVtCnxPgTeavC/YJ4Y7phYUmd
 8q0mFI1tfcdQdgQGHFVp0lTJwNWsNBfY1WCGoaJyTmo2ckioT+4xst88dgzXCpfqO6xg
 2VAX1y4Udvq78k1FpqzxjZ+ZqMiP5MBTlaiApmLI12yCxhZPfmj7o9VPl6zZT23u6loS
 fsRhg2s7cDvcy/4//uNcpOhiA8OHluydLPFe3sJFpZ93QUv1Lr0+LsANr24FuRbW/19P
 xYYQ==
X-Gm-Message-State: AOJu0Yy3IzsJFj0fyuiJU2vQGhr675HT9aLL3i8zEYbptdJ6xqdYdfx+
 lle1fmkqOV6tkWPJqRyaWW6QqO3mJIN1rgagiYOFQXhmKdUx/Ycv24ntXWljx8E37lEsB0Vwljd
 el4ujnzZ0/l2zv1Lea4H7yL23VnM9DnISIYijNLYcaA==
X-Gm-Gg: AfdE7cmXc+hsxbGjwts8tSkLerv4tX9n/ybjn/PGDbzrhTpqoImhuMXBJrxW9j66tbx
 Gl+k2+w48v9OOR2KMbYs+h0HTEl8C11f4DFU1ryJx5lZeVqcitwNwOylukRyhkadZlELEhfai3h
 1mZ/RlyruYVzAzU2gh6xj/qmWVEHcHiT+1hjgOc9NjFNsz/nVZ+OigChYweoQauIoCDqT99BGAR
 JXKGMeWD8Ea3i9nvHesVs7krEoJUIg85xp4fs7iaYuwcnccq2N4QQmpQMkzpU690re3UMg5fBDJ
 +VDRs81WhOPq+xIWiJ6WDcMONueZlNYQgGn6IYDkxQA6C+xTEvo+F+1aeoXPXQR2/GM=
X-Received: by 2002:a05:690e:128d:b0:65e:43da:a470 with SMTP id
 956f58d0204a3-662b6190804mr2564219d50.30.1781615716936; Tue, 16 Jun 2026
 06:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-16-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 14:15:05 +0100
X-Gm-Features: AVVi8Cd4ukrQBgzMF7REWpzpomguZVt70zrJa7owfNzbxqBZgCKPTSz3Ouzr5KM
Message-ID: <CAFEAcA-CPdGLxR8Cu5U1FnijaT7aC7=xnt0=XxPLT-hFC=4kaw@mail.gmail.com>
Subject: Re: [PATCH 15/25] target/arm: Implement FRINT{32,64}{X,Z}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve-defs.h |  9 ++++++++
>  target/arm/tcg/sve_helper.c      |  5 +++++
>  target/arm/tcg/translate-sve.c   | 36 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode        | 20 ++++++++++++++++++
>  4 files changed, 70 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

