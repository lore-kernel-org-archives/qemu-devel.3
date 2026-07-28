Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D53C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojh8-0004IF-EI; Tue, 28 Jul 2026 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojh4-0004Gm-3K
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:26:11 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojh0-0000pP-9i
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:26:08 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so474829266b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252364; cv=none;
 d=google.com; s=arc-20260327;
 b=TnhFaPSajd2cGCkGk1DCCKQV16N79uo8o70soEEOod3v+Ii2uxoNwMHiw4Y2cGwBt0
 Y0iEWkffzuDWyMu4km0C7Ew7DpcNUseYGJEXTPe0TjT1OgRKUdgLsTieK2oRG0ZZ5Wf0
 Z76QCXV2Q9iBEydxPR886MRjVZn+qev6gVdYoLUsXc/dEvolzZDZ3kGrpsq9GETp+X8F
 cV10W0BPmQu4hhDaP68LC3Mm6/r9wkmmo9ESsVTmfjkdiNP6/mXHDo9a6RsNudKCsVTo
 qCVKGQVSLQHYBfG9s8JvhX4FR9eD2iuHbAQCh6bM/WUOlXnz9UgHxGtVcM0ePU2SNWIx
 t2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wH7tvyXI+V+oUVXrv0GN/+yTE+Vz4X90XE51nz7hzYM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=AFq9AJUjqoKV7Q+Xh+4yKadSOmqgsm4l3w+txE1vaixQVTRbKFx1rXDu83+ozg7KEG
 bNDZMQEyUlYKRA0fB7ECe1rwKdWBjRZlWb3DM9W6vxLwgvs6bMH+VTscr4b8RLbYcfnx
 awP+rhPgl5UYpo0/jlziRnJ4Oi/t2MjvfjZBEAEWLVrOidhrbaJObExVRxdpD0euityk
 gnbIX5lhETVf+fENscjIv9FglKL1wcmMhyyc0UySjOAFE0epsEwgOeceR2eBkIw0PTyl
 76SxaksNEHEY28rQZrA1qGhJBvDeohca4OwGdfZSOY37fFq20pgBM/opKs9gUyxuDt39
 gqFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252364; x=1785857164; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wH7tvyXI+V+oUVXrv0GN/+yTE+Vz4X90XE51nz7hzYM=;
 b=Pxn/5kEftHvOWC43SmQiO2xcuTyf60IEdp71UUo1uA4PXCElGumMDi4kJBcClE7Lnk
 yQsSAfsXf4TSwKAjDcHfBpOr+1pWuPrezvjsekr1+jNqk125MUFCCFZub/iK7JBd3CHj
 ZgsPX27rPctGHHowrcDKtwnat4e5/5t+Jgf+yeoTR8USGejWsyzeEOebMVmJaN3nt0tn
 XTWWPP/IgrlnhV1MjD5kKvuPhXpR9cZTs1Bg+fyTSyzxW0HtmsDb5lQjmC8TdkwBS2ZE
 yUqnMYSh29Y1ijsLBRpwsOIc1dE0QHRv3q+KTxgdyhkzfXMavwLW+lPTVWMGBFFPNNlg
 4ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252364; x=1785857164;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wH7tvyXI+V+oUVXrv0GN/+yTE+Vz4X90XE51nz7hzYM=;
 b=G1Ev8akYp3CW+xrFAvh9TQdICRBuEqV0LD2BOkIb9qwgaNTkhWeuH58G/Ax85aV+C/
 +HwVMb72a8jyC1GDbqbq1Apw0jx/AAM6CTYHpWJJOZ7pYgwCdXoML23PDdb6PcuFhx//
 XrFlYeWoRtMnlD+4k7o8LqyAzUfxIn+xhoB2RdeeTRh1XbUnvYTBGmD9WDQ11SBlZ+QK
 q+VnQGvchQFfx4UGPU4gY7HCdNQTAx+sIrQT5dlX5p58k2UxFXE4oFDr/rHYztQQUdrZ
 Bq7SSc3c3qWtK29OJGsQ9jr6K45pYnbfOXJOC0/wXoRO4GdCtPtGhzqJKxX2n2FL65ZE
 A2uA==
X-Gm-Message-State: AOJu0YzNkLmtX++76kM6sYHdlnnw9fsef14BMGPCPioGxLiWgJtavKhY
 MaTKn1IkMcMtF8iuAs7Adw18zo/D4V+ylkcFQo97GSozGa5sJIYscS4i145avalCQKBS3OLlYV/
 OCpGsMwORTBnlpuGiB/GqEYlBAbD1tOgBLelteUJPwg==
X-Gm-Gg: AR+sD1091yw6p4An6iSoO69oE7njG+1btuD9OmIa+hnKZO60XIX6u+ZRWvgDRuYfpjZ
 Gdk6uRzx0QTZJsb3nFCvEf0FmnSJv4D4NaVd7yH6g+8FTOTaIeRWkvtuaCoP7M5qc3d7rHZZnJI
 Gin/VkjfMRpbPnzM+PrVL95/g0toVOrp6wJG8v7i6PJifatBERTjVJnu3bVK1q9s/aawQbSH76J
 ux2ZKFSZKaHKKe38W5S8NONYXPYNR6LzZ0GHwZVuoiAJigbgWeIajBAUmo+qzrRlxtdiWEShUmH
 gaXyXml3Dke4mgzqXWxJAafrVhiSRPnthF4S+RgRW0Z/Q7nwu2qHiy5D
X-Received: by 2002:a17:907:3f96:b0:c12:96af:acf7 with SMTP id
 a640c23a62f3a-c1f7215156cmr160463066b.43.1785252364458; Tue, 28 Jul 2026
 08:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-7-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:25:49 +0100
X-Gm-Features: AUfX_mz4OF4H2c1CkcBA3ZOM3GuadHtto9Kpim15gj1c97i1p1joOMu-oWnwB7o
Message-ID: <CAFEAcA8Y+0i+XdMX=MNDK_UdTQ49+DiR9fLEqTQHPbxoWq9ZyA@mail.gmail.com>
Subject: Re: [PATCH 06/20] target/arm: Implement SVE BFSCALE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Tue, 21 Jul 2026 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        | 5 +++++
>  target/arm/tcg/helper-sve-defs.h | 2 ++
>  target/arm/tcg/sve_helper.c      | 1 +
>  target/arm/tcg/translate-sve.c   | 2 ++
>  target/arm/tcg/sve.decode        | 5 ++++-
>  5 files changed, 14 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

