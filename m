Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E45C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr1K-0004QY-Tv; Fri, 31 Jul 2026 13:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr14-0004I3-Fs
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:27:28 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr12-0004Ic-6H
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:27:25 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6688dfaed31so1496750d50.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785518843; cv=none;
 d=google.com; s=arc-20260327;
 b=Cl77Bps5yIi+938ZhxKYdonGxWJZHRFugP9MOL5itLANAKLYgDw4qTtnR78P6SQO0C
 jo67FDEMQWelLqnbTYOgPYpJ/J1/EfVW8yGIOO1Rj/J0GzJYTy8p2wDOF/vTqfgYstDb
 CemGDgVE7upGZkj/KXwOPtgf2uaJ7rBsdSiC+yqEEND+Hh/6wPx9RJykcTN2/uI7I/Iw
 0842HCGr+ftZKSCfVx5CpAyKpZpRXkCFEeqwQtaN9f0+7njbNPfCNGTEeN0WSSHqifmu
 NdpXcvZkfPzjDDE/J+LpQGBZiezCfDOaspASe/hLoViLMZOwqltIUFWAkteOaoWuvQQG
 DqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wek5xfOA0Otj0eDidEirlD6SqrJC0fmWS4T2++it0nA=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=isbz5iNMY4ZR/uy37jW1iKrFbGvI2Cq7XJeBxG23t191zT5ssBVb7tnf4OfuTnZIBH
 rvSomOYKWOL9bNNQpnXwblnQbJp1oYNYtpln7yoJP9w786GJ6QKyVvMQbJBJ/5a2q/F8
 OmQuncXA/nGxNWDoipLxVM42eTeYQQ82eqYGC7ODR5qr6kogq2ICWW67NPUnV2RIQAge
 DgCiR6tsR+m0TTMnKY6v5SckjJ4+s4SiSCPAqOktmKILyOX69Uby6mszL/SrUdHAN4o+
 ex2g7HrjLJm699Kce7UQSR2eOZGGjcEKdTfp4BYuf1nHjwrQCF1jBBnpdKEFinBtFIrm
 54Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785518843; x=1786123643; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wek5xfOA0Otj0eDidEirlD6SqrJC0fmWS4T2++it0nA=;
 b=v5vVtsrLsQ+HjgkfmE91EepE1wjP1cYEQquTun8eA4nSWgdTbWWkmUgehHk8CRDifm
 CUBfR7TA3wqAuwYxrVCw6ti9wKZ4AnF3UYRivq5xFIU8+hS9VWq/LdPyHSJMYJtRlOfp
 226ycFl6FEpo1m/GQzfb9Fz/RG2EJ+TW4NuEFRngWbMp1jaip6qBFg4bl3uK+A9T5Y8N
 7qO4XUFmuA6db90D2XixkKzdnqfMbbMcN+0U0FzevJmJ/gunH5CUbtDFr+WK6DtMid1u
 ebxKSz4BzcbRGgHRbhuzladQ9fOk3yllt89QarVHiR+/i7lM0Mu2HS81IOfJgQVD4zz0
 OOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785518843; x=1786123643;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wek5xfOA0Otj0eDidEirlD6SqrJC0fmWS4T2++it0nA=;
 b=DC4OkMvfuiproETj8a4It5T/cXCyAFPFvSbI+Gx3nQm2+6R7Z892n5ST3sB3/0h9LZ
 vJGIRTWPgel8QTQu7cIrulcNcSrPjkmid6QBnVNuDMvDCfGx9YnmkH2X0iD3yhZoHfXF
 mcE7QPHpeqzHARhwVngTXudjY0YECBjQBGaJGvkOB3nTp/H7OwZa1zi4MJIntpSsA8ih
 gNa48FK2tEOGxPc1tUo9lYIYnK1b+ClV+9BxoZf9yF/kA9lze4vHFGjTTk8pIcNbLiJZ
 ESMEPSifDBg1NpIPt+FtmfYCjgxS1lTjA9NUEqhIX6VZ0HMLGFsXwYFcTemMR7+UPyWS
 cVQw==
X-Gm-Message-State: AOJu0YzfqybkwMb7hhQzD9e/4oqfFzkPfROAu1NCJSofQFNrdw+uzky1
 qopjwvjWMKHbtvGYmYalwrUEAX87M9B9k3eYB+j9/wJeDAYTQfkhU05KrF1ThDYWYOYT7NuIuwn
 21/X41zT8BfP6getYT8wyOaY/ALeIcD9BmK2l0ohMNuxfpgf4Pwef
X-Gm-Gg: AR+sD139I705mlMwVSd8pMOSeWeGDdDOhFArusu9zDE6Bbyzc14g1vLXCMq1f2L/umq
 jXrd6GRORguCU3idN0f7UY82EhRG7Aqcn42g36/gcMm4MfFGzPH2PHKVHJkvYnh8UUljWNE7gge
 lJaKAHZeSqjg24hMYjdchJ+wzs8qnaloNR536Y9tLc7v34E3u5QINMh6YFDrTYIC29TUPKRlKBm
 gQgDO3pA30CFM6WKL1rKaWFmXETzeqkDSKij1NvzELP0XqQSVWSSARGOteJ/8GCdlF7U+zXV3VL
 yhXV8c7p+mHv7VtH3nqaKHPprBOpmMTRfolRX6x9s+GkMNvOhSAzocYN3qOpbye7/l5tegktwhc
 dEZW5fUKpMgmYQNom2slwVgEcJEIT
X-Received: by 2002:a53:df4f:0:b0:668:8b5b:75ab with SMTP id
 956f58d0204a3-6694f22e9cfmr681966d50.49.1785518843068; Fri, 31 Jul 2026
 10:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-7-richard.henderson@linaro.org>
In-Reply-To: <20260724030616.76180-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 18:27:11 +0100
X-Gm-Features: AUfX_mwrPdSdXes3DzYe1EXaENmNj76OHt0b3ye6024O7jE4EBTQdtbzGvFZdik
Message-ID: <CAFEAcA-Ts+oYSU+OwKWGDQGbKSPRLB=o_f2H6f=mRONEb_KLHQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] target/arm: Enable FEAT_FGWTE3 for -cpu max
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

On Fri, 24 Jul 2026 at 04:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c        | 1 +
>  docs/system/arm/emulation.rst | 1 +
>  2 files changed, 2 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

