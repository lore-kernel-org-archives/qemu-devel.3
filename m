Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B96CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2TD-0003vh-Hh; Fri, 26 Jun 2026 05:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2TC-0003vS-HS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:03:30 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2TB-0001Y9-4o
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:03:30 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6649fde483bso417697d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782464607; cv=none;
 d=google.com; s=arc-20260327;
 b=cU/6UazbA3TNqrBfEg49bF4KyCOzaIWuqTbqlsvj0DOBfWj3mtpKfCSmz1Sz/ByxUX
 ejVMs8E3Y2AHQgdnltSTyfJGGS11vJGSG8jyWCKQsNJ7hVgsG/vF5iCoQ9cw50JzmbCg
 Zt1Oo/mQKW9p2CfAxbfHdlb5wrvfaQehDwANXdT9uqcm4Rlu16B4MpHziYunPvdkog3t
 AdExSnijCRol3hKzV+OY0IrQpgghrJyeKJkxhbXwWnSJpRlKQ/w3Nhb20vASWtrnqXr4
 p+T5lw9Ampvf68RurmJJ36zwqUZ3Ts1bDyr6HnPGcZAGZmY4jiU1N2v7paUR6z4CcvAv
 JWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rzbTLX9MgIHGjJ8QPBBC83qnuPUQRbdnZjonROf51h0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ZaPDj5/ozUrv0p1bkywTfdThMLQVLXgZ1t/reEIYUL6aEU9XIvkj9dVQsT2O+ccrQ4
 cZLh7V16fVoKJu6CB89bv9C6JvxB+XOm8gXfrFFGsCpRHS3Tr4UV0us5gXajDWUyyjCX
 2ljwJAu4Qjy3ekCGkE6zASBjoZp6Ln0cUVZs7p42Ra18uSvwmeGyHwuKTkPrUEHaOVjO
 pViTcxKB94uLsXSt0ivJrr+JuzMM5ieRkFGjGlm3K26WV4U7wUL3+CvFl74+bKgTP0Kh
 BuRyvjwX8tYgimzKT/Gp4Ji6W684zdb0IGBKEhP0oihFQDszb3cUgzI8mlg750QGuMEF
 REGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782464607; x=1783069407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rzbTLX9MgIHGjJ8QPBBC83qnuPUQRbdnZjonROf51h0=;
 b=tnVtUo+OOxH5Cpbc3knFmwdDGs4fzh0BcAEo65h9WdMuwLI2BScxZCaxpQ66oHXv47
 BlQlxc3vMHs8isOG65kFaqFY0fek9cWvzbU2x1LvNdqMOiYsDyXr5ni0WBvtM/ZGvgJC
 jhpy6+fgh+jBnqj2I9B9g5Ycm+V+QWm6mxTlMb6Iz/WKzEGybBloFEQ3Vvb6gv7XYW62
 7+FXP8PpIucOkxhqHRcLlztzXcJeJfPn5UPLy+YaV2wH2hqKjn+yw5FCr4g6W3YRgpjZ
 gaH78QA7rnTQs0vdZ+/1VKmotegFtTkn7iTfiQMe/lP8TbDzOeAeF+dKt2yt8pBPbUSN
 PCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782464607; x=1783069407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzbTLX9MgIHGjJ8QPBBC83qnuPUQRbdnZjonROf51h0=;
 b=pNsRUh26fKPtgNeDrDNay7o45J2VzsL8hRtX82io62fzAlCC5K/neDP1gQDRyVUuIS
 SaxO/e+Fhh9pDm5I4hJD+08pxRwwHI1HcFhfkhyEqdTDyLpjv2kdJ+RLi/jPhexMTBsT
 auWOTuVrrs2laq8GHrj/eB2LhTwNtrE6SW1DOlurIkauW/hOVoJZNbw8GVa/quuQeKbe
 6wvOa9DRH0Hz1YWCvAZ4NY5BEPVUf2kDxkkypl4MM/+7gzaZjUYOQyQigJoz29zLfmxy
 eK/Vh0iou5RagkNV6oo4NKnPVkG8a8nIoecS3eouE+GiuxFZlezyGOelVp0ZH4JiVD9e
 l+fw==
X-Gm-Message-State: AOJu0YygJnbTYoxKAywlBf1JJBp3yaW1Lneko/h85+ZgtAlDdKfR0DuA
 jX1dXF+pEv1aLUKkWHZUD07IIveLB0/aQPZarQBfZOSHkZBVceh6OeXHBIp4V2iM8rsEVPgxKRm
 V7rsXZ4vVsaLGJit16ttDwD1h0JPqCfSi4RAMGrjCzA==
X-Gm-Gg: AfdE7cmiQyNtO1m3HoWtBTSvQl2yP/BExXIbO+yv7KpM4fYoNdfu9GU4Hw1NF64KdWN
 EA2dTS/OfJN+4h3zgttnih6gRoR6QZsF0S50lVt1+drG85aTKZTTN5VYQ2NKFsQbIIfBTAnGGqf
 aOdu16jD8rpyvzaoWNa0BiikUXkft1P5woDuE9OLdZlxjusT/yppgLX1PjLrI/3lTtBbckHn5Fb
 4FP12GpyEEJ64T8XJ5AipTswyAX23sPvypRgYMaU4ccDD8U907F+UypdxWbzQj/ax441JsR+JVH
 dxsMEEstvtE2FDVFh//SJPkkQGkLiRiUSnU51XuHr0JxpZcSPzQj40w4
X-Received: by 2002:a05:690e:148b:b0:651:bd70:1622 with SMTP id
 956f58d0204a3-66487ade410mr4707242d50.10.1782464607362; Fri, 26 Jun 2026
 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-2-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:03:15 +0100
X-Gm-Features: AVVi8CfGGWQ8yrB6A7EGkSdUN1O7z-s_9qQy74UNkYrn7PtG4nmmHMVkALjboh0
Message-ID: <CAFEAcA9VxO318H9KwC7R7TmrHia8QVW5yqcG+Wutw2oyLFfZeQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] target/arm: Enable FADD/FSUB (half-precision) with
 FEAT_SME_F8F16
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 25 Jun 2026 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These two instructions can be enabled with either
> FEAT_SME_F8F16 or FEAT_SME_F16F16.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      | 11 +++++++++++
>  target/arm/tcg/translate-sme.c |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

> +static inline bool
> +isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
> +{
> +    return isar_feature_aa64_sme_f16f16(id) && isar_feature_aa64_sme_f8f16(id);

Should be ||, not &&...

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

