Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D85CC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMot-0003Qs-2F; Tue, 06 Feb 2024 09:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMor-0003QG-OT
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:53:05 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMoq-0000qD-AI
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:53:05 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-511538be947so2210652e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707231183; x=1707835983; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PgyAndVS4dZUfenG/kBFzhbzoUms17uafKEor9TpUMM=;
 b=onYrZG1ID6mVGJv7Bam9q55HSbcazLONHjOkZiIGYXXXFv6388R5NuVc5YUeVQQPuK
 PGlOIg9bXzg+O2z7UxxTYwy2TTn6T7Fv72APS8rlvaq78j7zVuxyb+XyxGL+7T6U5dw1
 aqsnwnC+HY6Zjs3msP0MvG4Y+u+YCQg/ipbFWl0boyDj2ysqonSLUBYU+nnHKhZEXvKC
 bspz1ARXwxv+dYnAMdIdGTtLK5HNHwTA6V86HkLwmZ0lmy4T03csg+mF94y8iUQGZV0k
 4vTiRzsMCX6CR8A5ExwIkd05apUe9AUQ3o0I1f4dSuki1HoFDSNMDy7n3EarUzpOLEKi
 wr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707231183; x=1707835983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PgyAndVS4dZUfenG/kBFzhbzoUms17uafKEor9TpUMM=;
 b=hfgQz+UC8iFdsEYt8zSKalnO4xJ9N+36Z+E8bgtX3CaQ22fofeSAf6mV2vEQgzR+hl
 A+sUscvSSUJqBpXd5/RIl9jCCaVzVnqKJezGwxt2CEMUXRzS0pDqyLzL/+Xn/oC3mOcz
 0Seh7IevlO3l9GzK3uxFsuRseA8ZhM/lY+nsi7b12OhdAMA5sceOjw0j2c0Mbv4iDbhz
 7Luu/ZeHBb6wkjh8a9GKPbV9JD+BTnFfwikoAf5fbIzQ9C0cCTT3p3I3a1ClXFCC6oyI
 f/vA5bF2v3EcXIInHQ/Foy0U7Lcr8GFq2NVat4iL6nOIGEoCtHkmre3u5o8dNd/RGOO5
 ZJ4w==
X-Gm-Message-State: AOJu0YwzdfOPSzOGBf7BVMF+mESUPOEKkjDcOWcz0GPxscOuuKjySgaZ
 f3wpqUUZlRS0rjxe2pCKSH4fod+xYmHIhfmbiGK2Zvh7Luo9Ls3kjw/evmEprqwGru3tCnvTkCh
 lboIBp36L9zV4hK84dMCAE9sLVxbetgCQk9JxxQ==
X-Google-Smtp-Source: AGHT+IFA23AlFziDXxIuyOQD2zYKHPlp8tRQVYiQBu32FEiW+rFMLLW0fPfN/AWpMzQsc21AVIXPO/KQazakJoFQh6k=
X-Received: by 2002:a19:8c55:0:b0:511:58d9:a253 with SMTP id
 i21-20020a198c55000000b0051158d9a253mr1783164lfj.56.1707231182690; Tue, 06
 Feb 2024 06:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-5-richard.henderson@linaro.org>
In-Reply-To: <20240206030527.169147-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 14:52:51 +0000
Message-ID: <CAFEAcA-KVKmRJeq9B185xFXHgrSUjm383Z8Tnr=B5DX5DeqK5Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] target/arm: Split out make_svemte_desc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 6 Feb 2024 at 03:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Share code that creates mtedesc and embeds within simd_desc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.h |  2 ++
>  target/arm/tcg/translate-sme.c | 15 +++--------
>  target/arm/tcg/translate-sve.c | 47 ++++++++++++++++++----------------
>  3 files changed, 31 insertions(+), 33 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

