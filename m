Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F061FC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Qei-000328-57; Tue, 01 Sep 2026 11:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Qeh-00031t-H3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:44:11 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Qef-0005Bb-UT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:44:11 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81ed2a06b9eso653867b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277443; cv=none;
 d=google.com; s=arc-20260327;
 b=HsEGp1CA0lypWJyehiGr4UnzjbI8C5MAXbCoigOLMxiXEjKACmLtjTElPLMyFNRDls
 D7IWdDVZ/bBAZXCh0V85W08WLxbG/3vH8c7TZCOaRtc+vl8GkxpBP6JkMkLn+KIgj9kQ
 IcVP8jAjn43oHcH/vmldVehekw4SBfCjLTrZtQ66L5e6OPububdrjvgKQ6kL31qd1BWe
 p8rABC8FGdjOarUmusjQLOvvCF7twZjcGUFKo+h3pfowlcoI/xacWAxYbe0cmxmlrI5q
 mbWg4JDrF4Xv9D4tzgv96sNVPvkscUQDS529Z7UuoVM2d/HIljXv/8bOtFju/Q8773t7
 hPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1kvjv5Gfdk/GMHKRwBrkjHRbEfyU/KRdl6K73Z8xPg4=;
 fh=vx6WqBV7ZkFr5+0c5croOznQhRJT596ekVEWV1sovE8=;
 b=N15iIwd75UmnqxtN1elWTfQVwCrQ7FzYY8g93klkjW3Uv+fOq2wrYXvNj4ET9bCm+h
 AXabydXk40wwMUPBXtd4dgbec4scoFi56w5YZy9XRHcdcZmeEqnVsnd9WfEV/m0zK1na
 5dnZXM+BPv+IE+HxECEG9nkjXVIvGjer22xG2WLSDZ+ZpDh71qjz250qaqwanuaT1Jsx
 RA1l2mf4/2YWZdRW1yzRCgi+kews+hs0pzMVOGpb2Anyw3TH2yj3v5OTc2WHmUNfyxGi
 oxg/uKoMicDsZKjwrha5wUUASetiz7fOhLHl1bunLqtPOtzcmx8Tvo81twff+Vp9bebW
 DWjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788277443; x=1788882243; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1kvjv5Gfdk/GMHKRwBrkjHRbEfyU/KRdl6K73Z8xPg4=;
 b=yUXEMo5tbn1ZAU/i7dVVbDJXLf8c9yN3NQT/6lsMoa2VV691vwqvBcT75HLl9VolWZ
 Lw/hgLCpJXi0UOqVlyrqHqgQA5X9goEm2bNHhHW4CNA9PGfglMBr2ol1tLFXwxwCGMUp
 5lQ2EijfjnCbePyx3f/aK1lMnYb4WDdZJgAq3OqpYfb8jXKirDM3uyWwYnl2oC13sRyN
 AHNUbKPMg2rcXtrHBwPVGpEmGNfpqSjffW9I/jrb62ssHwhFXgu8wjPAyED6LQSUypBg
 cIOVa5I3rE9o9uMUMxuvC7z3Iy4xmvPxY4HRMLNkOB3zq3kxLJ4rfee+ZGF04FSwy/b7
 iucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788277443; x=1788882243;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1kvjv5Gfdk/GMHKRwBrkjHRbEfyU/KRdl6K73Z8xPg4=;
 b=ngFGDbNL6NMyzSpMRRR27kyBjQv/fm968ibO/2xsKD3Yarqd64LuyE8On+9RATUCYn
 Y3aiT8w/UyZhDtfJ+BxlCzN0/7VhHNvVIOvQz2ELrzjh5/gk1Oe1KD5ks2ZehfOTTKH6
 A18AKNvyC1Ae50DUb+zcjQURImLb6RfRMZJfvN+LhjUjPQsXPDkGNdvoOayuKfd6AZbk
 DwpINptcyv0EZBYc0rBvOg6gPNM3uZTDhDiCRkgUPE7+O0ls8iNNd0wrlBL8CRwgjqd6
 qUgFwv0jp5E8Yb41bjCBIu93KKWuVMqR9nnrBwXZsLIB8qMKMHEXFei1oxGzlOHl3mow
 QCjQ==
X-Gm-Message-State: AFuF++lN+l4tTxQvJu7yOqddJ3+mH33cmURiZTI9oPYPHlaQq3Gsbs/l
 /0sq8Yw1k3CWCYvB62CKwwnnI9d9ox98ek+7KHtOU3aWMbwtIbTE0oLK2uk3N5QWVSya9bdGuUF
 7p6xxKcVg1uU9MRJomSxV0lobP8VR8u41bGODTkT4Ebt7ybr+NxiPfQ8=
X-Gm-Gg: AYBFou3kxO4QrsA1ZTEMDBoZb33VOPy48mr1PzT8rFp35b7KpwQ5WcHczVrr664ChuF
 uOLGLGx0ETgycBgYyKOn3ODP5zD8K1m7DD2kjKObYXarAMNW/75uh1b5toUmg2rOogGAI21f0+/
 Iex2z/tHldU8sTk/ZDBTv+OKRU1L+dSd0NpW5op4nvbXQXbX5kjVgM7l7+6oUVUWblMPdwJDmFk
 MbL2rKnl9iI2jgSiniTQgzD9s0+xVVtryfWD+191wScxlYChd7+OMi7D8S+yxPhv+H/nu9fmlVn
 +blTERRmFBlTeCGM7GdmYX8d/3g+JkZS+ipq7qJPHunc9vgTGpBTpywH9uTpBZfcFZxCsPzK/l2
 kkKbMwv6Poc1vN2sT87LmDY0lLXeI
X-Received: by 2002:a05:690c:a642:b0:820:15ad:522c with SMTP id
 00721157ae682-85d67251799mr116246197b3.11.1788277443006; Tue, 01 Sep 2026
 08:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 16:43:51 +0100
X-Gm-Features: AcwNN1X_-5DwmKotV19zndnktRTnWLg1Di2wnrhkJJV_liuHxx3Ln1RlQZS1iok
Message-ID: <CAFEAcA9CXPA=3AHqqCu8Kv9iHUGra37wBUfVcikMdBrAkX54qQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] accel/tcg: Change tlb_fill/probe_access to
 (addr, first, last) tuple
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sat, 15 Aug 2026 at 21:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The driver for this RFC is
> https://lore.kernel.org/qemu-devel/ce3a48b5-9847-4cc4-a02f-86db497c91ae@linaro.org/
>
> Based-on: 20260815194549.1377505-1-richard.henderson@linaro.org
> ("[PATCH 00/23] target/riscv: Reorg vector load/store")
>
> But also merged to master, so for avoidance of doubt:
> https://gitlab.com/rth7680/qemu/-/commits/tcg-probe
>
> Convert probe_access_full, probe_access_flags, and the backend tlb_fill
> hooks, but not (yet) probe_access itself.  I'm less certain about that,
> since its uses are (1) less complicated and (2) there's also a path,
> which I can't prove isn't used but neither can I find, which avoids
> both watchpoints and notdirty pages.
>
> I've tweaked the riscv pmp check to use the new parameters.
> The similar Armv8-M code is a bit more complicated to push through,
> and I need to study it a bit more.

I think this is a good API change, and getting rid of the confusing
"probe with size 0" is definitely worthwhile. I think we need to
be careful as we do this refactor about places where we calculate
a "last" address via "addr + size - 1" and that might wrap around;
I've left comments where I think that might happen.

thanks
-- PMM

