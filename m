Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E091CC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIvH-0000Mk-3S; Sat, 02 Aug 2025 16:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIrc-0003tY-Pw
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:29:56 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIrb-0004Cg-Do
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:29:56 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e8fce318224so1346070276.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166594; x=1754771394; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sc9Fmw/CiCl6OW0JVF1SIO2gvJ969UCi3RoF5Ut39IU=;
 b=MJFwZTloeKLSo3O6YugjJbIJWLYLkgBtTqmKhimQFy4QiM0Rz9DjiKxSeUCeGO0/7/
 7QUXGjBEFR0a/sZogetECV7bIE+Y6upONTvU4mUgrHMbSXq/WB66rMdqXq2BYMmYqgzk
 MCX03oZIxedsFrWab2FYevlcGyrZ1jmYySCria17k4IFv/u4YVs2oi2Wh5SSVM/jCBBw
 Ol8xXfPrsf/e7Us/3n2A5lEEHwz5twdrruAMpotFFTCnNT2d3jkPmWL9p1O3IRnZCOgs
 iigiCmX8oGbgBHLFOcRnkefN7pLksRjS+f+easlFcxxGml/HByaNB1EexJ+ZqGCHOH9Q
 bfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166594; x=1754771394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sc9Fmw/CiCl6OW0JVF1SIO2gvJ969UCi3RoF5Ut39IU=;
 b=S/0gDVqN3B/nVV7P5nzI++BLNfoNq2swaaC6CLg6/iQoXXM5ytKV/30Hyf/D/X9MzO
 RkJANJeeQR67LHVZDAAwbqczoxyN6cSB/wlFahKSBKPm6gOKsVXgVWvv4Im+Hp8JRRwA
 sCO61zoXDlV+CtQBC6fAFMWO3/u83LczMGCurO4E0R+J0xfL3B9Ntn+HjD9wvl3bsp5I
 OQB9lf1Wt3ekaeehHhDRIUpMF9i3JLgyDZ6vgoQRylRI5tHrDhTzOhcQ+iVNPnW1T473
 iOIOnOtp6RA+P5nG2pbae5x0zzLcWwpC2+9P/KjBRUMibCm49w+6XrPNXNfOmkeXsJfG
 vx7g==
X-Gm-Message-State: AOJu0YwYT9IKvGOIlrGalWdaJVJMpFQgGG+T22YssvqumQcEbEFjfSAa
 0KZm/XYFmslNMCBMBMlSdDm/rONhb2g3XPhFrvICLJezAmeeBdz3t7b+C8orO7JktJvgV6Dz2L1
 2goj/NyXUT0R/SuR7Ot8b1FR8NfJDkZQuR4Vhmajfmg==
X-Gm-Gg: ASbGncuLzL5wreJ7zjB5YTTuLaufv5OtauIIMganbVpLWNPU5DTQPBwHLECgjaH2hdQ
 +PRy8kILpbW/dN+M7x1bpUHh5lUh9/WgDHExEHi3xI3FdPIGzAEBny1qB+hkmL/9hPtdDLP0yy9
 KASzsP+OqxShor3X2VEAiYRNvMOZ4CpewFRxi7pH1vh3yj2XTvd+lll/YQvp3GX1cC9vUnIQ9u/
 xg5duShaqpGA+qyFiM=
X-Google-Smtp-Source: AGHT+IGHPqBXw183SwZdsqp6/bR7RvBB7uUY1uZJmRSRWGkUbT3tlahLViSTrDguXWE5bW3g0B0TqATzkqMXtOGZqbA=
X-Received: by 2002:a05:6902:540f:b0:e8f:e77b:a404 with SMTP id
 3f1490d57ef6-e8fedfca53dmr4990265276.2.1754166594143; Sat, 02 Aug 2025
 13:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-72-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-72-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:29:42 +0100
X-Gm-Features: Ac12FXwmb8zYB5_XMuW-7w0O-kKUtop0k97bj_ypLRfojSvSr-D6gBeBC6cUAvk
Message-ID: <CAFEAcA_JhCnCDorVz4YzDoqVg0dGiVcNPmzj4jrM+Jmd62Xvnw@mail.gmail.com>
Subject: Re: [PATCH 71/89] linux-user: Move elf parameters to sh4/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Wed, 30 Jul 2025 at 01:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/sh4/target_elf.h | 4 ++++
>  linux-user/elfload.c        | 9 ---------
>  2 files changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

