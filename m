Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC60CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsaG-0007M5-F2; Tue, 09 Jun 2026 05:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsaE-0007Lm-Vn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:17:19 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsaD-0003yK-JM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:17:18 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66077c46c5cso4677534d50.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780996636; cv=none;
 d=google.com; s=arc-20240605;
 b=ONBPWwgGM7cWcZ+pd0LSmfkHpuSNOWOo0riz//0kC9rRJDazNi8mVxH4LnXZauPXtn
 GsF+a8IJyGcrZSKFO6iAJoul6vs3aqWZLeOSXOw80HbYt1Cd6vi7bel8z/s3Hh405IPY
 PKnhJrzHMuxTqIzv0TV64nUELNJPm7j2bIi2AX+IDL9m+AeI55/HMK3U8rL3K11tSplm
 alymUzyT/wqwJKARxn7862QSo6K+5bYXfEvJkiKMwp/h+8XHJUS0LsasBi4WyXxHMt7X
 HynXEBg8hhXUOlialKbj8g2KedNKSg6kI/SE4BfufvKesWihL0vl1gv2kbIoHfxUpNEG
 Wmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hyl+NSU+z7n/jaoyu122o8hmgO2jF+BUr2MmeWg5PGA=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Cz3hR7koz8u7u05Spg2JtQ1PaXKKLQXN5Jl7MzSvwCHf8iAv0clY6x3JhBcnsdgGmn
 qrOz/WVx7ekI2O4QoLduB5xY+SAd+13f0xBKaT8vd7fEXY+KvpKEghrSPXPdBcdEI+Hz
 W8fn8Wy6y+JBprFJwNJ2MwY5dUYLKFGcXbAAPSTQ4m8hkS2wBy/BLTQJ5cBTSlzF0YNF
 gQ+fHNVEKLUirfXSS23azZiGq6r6CylOpiJrlSYhkf6uC8hcc5pjIXOD5TQgEO8ZnCQd
 5GTHYK1Zaj70876BJQmHSivb+J9pS1yJkMrO/I7uIa61EhOtY3NbwQzocRGoZmPEbRfF
 83Pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780996636; x=1781601436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hyl+NSU+z7n/jaoyu122o8hmgO2jF+BUr2MmeWg5PGA=;
 b=Mx9qz0kTd208lld7qrbyfmd8iiWkzQXNCvpAI6/fI3NS3+ViiB+JtWp3d4heplTG6g
 GXjIr3dKD92RFkmAunM5Lv1XZ9CtQKXMsx5W6HifFRtJHldZnXlxK/k+Mbqp7iuswy5u
 xoS7KrMbPouVtEfVqdIKvymUpqacfNwufkmtqQDB3TBd0fRJREGGgonWgZF69iVFlO9r
 zS2dtBcSFME7z+fBWrOu1BgIsSLb5u7HKEk4jvIJobNzSW42tCbQ2c7oYlLjgTLPYzDd
 vdCfcqEVdTESjsWQhgB0CgkHDcdmzM8VG1NkTRZWew1Nonsg46/cf965FwSKygf6jPb3
 jmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996636; x=1781601436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hyl+NSU+z7n/jaoyu122o8hmgO2jF+BUr2MmeWg5PGA=;
 b=kj1BqoTEdhok6Zb0G0fvqblYqp9FDfX0PFPygtH7zmS1YdP6dNoFkoL1ElaEWa2reE
 VC13V3S0T1vY+GjqrRN69LWxQ6nBFcS7d9pO/KX9NKIf47zvpZC0F0dQCEs0t1ZRXItA
 UItuEmSNmjT1//vG7hJhwDPi51RqsBK+s++Mj19Dk1gIDTR6kij7dGHrEfOisU0dFTOp
 8pJcyg01RmWbMF8pUW7k3wiYkRK9ROMybRCxPYfUFnkUfssdB3yZwUU20IlnHPc1uxca
 /Q1XbTdV6rbI6QweIVKc1pYscCXQsHZOa0k5vGzt04f2ESntJpyooblyuP5V2SuHmvQc
 Dc4w==
X-Gm-Message-State: AOJu0Yx31a+KOpTP4nVB0ehTeY1z42miN1gPfIXy61ZjD+XVukoZLZ6r
 p8ilUhhfjWalrP+y5vEt/2ShtgbeNSwWXtGgG9xYQUtujvpeMDyFHyrUA6hzx1ot8tN6TGHH/s4
 aMBdr3aigdfp25sBiUx8lPSNUW307LHZbtCZOvVddFQ==
X-Gm-Gg: Acq92OGufXUld56/QBRVhA0gMwPRIayHhXcRUBj6fHAF+qSw50gLBslAKHir5fb8543
 n+acYbpNqCcvrkcwrIkgNsVVIjLzjta0DRgpoAkMDFacggXwM2QoCC7LrLGbXsNIQlfBnjbU/xw
 pYJeVbQhTjAa1p1YKN083QxsEAZVwGVh8ve+CXo9Hu2Fd3LiWA5iVZwtZGxT/NDfK6zfhWWBdAU
 aEBYqoRW4yMzys77nM2lt/3OTOMmpQ8Gm+XvWOqAQHAPH1q6RSPk/w1f8hSaACxQxQOI9fvt7n0
 KYJec32uAzfMriXqY77yUIczG9mqHEHaIhjvc3z+y6H56ZuWchr+DSgdqqn0rduYs2be8o4GEFd
 OnA==
X-Received: by 2002:a05:690e:43da:b0:660:a41d:d166 with SMTP id
 956f58d0204a3-66106fe1a5bmr11617104d50.58.1780996635962; Tue, 09 Jun 2026
 02:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-22-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:17:03 +0100
X-Gm-Features: AVVi8Cf4Ga5fzjo0LJDFY9fr1o2kRvNnabkydRzO6PwyiBaCpbZmjf_CRJ23OZY
Message-ID: <CAFEAcA-ELhFuW5Ghv90FLmNg_Kyq1oa+0o+j2EPVs5snz6CkLg@mail.gmail.com>
Subject: Re: [PATCH v9 21/45] target/arm: Implement LUTI2, LUTI4 for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-defs.h   |  5 ++++
>  target/arm/tcg/translate-a64.c | 38 +++++++++++++++++++++++++
>  target/arm/tcg/vec_helper.c    | 52 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  6 ++++
>  4 files changed, 101 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

