Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F5CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5VG-0007fN-VV; Thu, 21 May 2026 11:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5VD-0007ep-58
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:40:03 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5V9-0003ml-7b
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:40:01 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65318dafbcbso6314228d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779377995; cv=none;
 d=google.com; s=arc-20240605;
 b=L5VhbKXJIRuuOWjtXeTmAXuOYoMNss629DNPT2FS4o3boCHGHDYnKBpflL+fw5TElo
 MT3Ao9vrNFdH4eVhCub9DJKBHlSHyW6DcLfFMWTf5r8E5ZkvsovHKeq8wRPeIE79K2FN
 dh635P6OMip3LND2chAVDmWniK4VhJtxKBx1tbAKvcEYggtYbVvDGPGlPark606G1hW2
 bwKacbCuSpvQeiS7LZgTBB6GFUDGOBHnEii9dRhOl9br/IqYEgbJAvkCGTnoQwCfScU2
 XXyFeUp3llmeSjki22+4YYP6xZHCvS4/p8bGbUfbs04WcmvEiSsPgY/fK+uK6v9+T4zi
 ovZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9igfbuUAgn9th0yGjavjkEn06WhKftK7Mrg6Y9WER/Y=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Jzu2Me0GahEsfeKqDf7LaN7vQG+Hboo6Oim8b63su4V9C2cMK529SdKpXIaazzqJ1t
 kFtFZ4FpkfnXdntiNDONE7LvHVpAywreZtaqcbRY+ykIKdU3oQAu2FW4tIcw5b/JUZ3d
 rR25Ezm+MKE88J6XI215y172rEVA9XbkKkIhpN5tX8BmHZlZUfLnJeighgH6oGS4Iqe7
 TinWozuCzhfknmg578T0HbwelobB394XdYdrC3On+Nqg+l1x+uprCVYGY8A3jbpMO5mr
 V3yIDUgdOivf1tiRFk/5Fd7m6f58XxB2AeGHvMnUbcuGMJJr3nuYHOGCJydt/JpzYBlz
 f+cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779377995; x=1779982795; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9igfbuUAgn9th0yGjavjkEn06WhKftK7Mrg6Y9WER/Y=;
 b=N12iB4wgvjWISckkKGMqRcwhPL09MCerNtHVFQgggQHl26hnI8uqOtLLwKxWMH0vD2
 DiD1/99cW6UXkex8CHXa0hwQ1N48aeZga+PMp5zBMpVpVm/4yLhSksP/gHp0Umdl0NQA
 DFzB/HavI4nhrzG5xTsbbnh1jrEUNiXWn2yrHSGfGKXTx8j0FgcjRqX+A7SroeCOEZre
 b9AVT1PkumMVz7dR3vU0QP5OwmwvK994tGGkedpNELb1NUnInD1IALAguGLfg2cZSLe6
 sfj0iyIvIlA2HniVxifAJtFnV2w27Jb+ZcDJOYRJcM3s5NBW0c+lm2NKHH0jnTBPJoOQ
 tBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377995; x=1779982795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9igfbuUAgn9th0yGjavjkEn06WhKftK7Mrg6Y9WER/Y=;
 b=mbhdL/8P15obI1gVG24RaKurfUuB2EUckqyaSakTV9XnghXopQiM87ngzeKwzjpqZ0
 XGvQxfra/E8naRZop8/EkNif2qzgDcx6kf5IsAlC92AX5B7qUDDOFUtreqYxZPZk0GNW
 BVMVbcXakv102aF3lFcl7TdWVM753m8zfR/kswkhC1ydZIJBM/H550pduOoZOXPy9XwT
 DMzq3i+1uZHV3p4VZGB4tHyqM6msE5yuLJ3784KcfgVfNqf8K7OsDZ63tK83SX2R9f8w
 tjCQJ/dpM88h9xMFzc50/ZJqee8RfIVFjykMSEY51POShFEz2ViaI2cfW+cqyOFjvHyO
 XFUw==
X-Gm-Message-State: AOJu0Yyo/oidPKouGu1S8V3GgMi01Mngo6SC5vEDRj9ImE3ao1vfUMrf
 7iP+qY7SIWJbrVWTdfCrS0qzr1F+b9bq0iGE+8Xk/2JZGKqdX1OcjqbdFm1KXrsOQBSM6P/HJsF
 gFBTF1d/sySfMRCysYKyRljISOqg7lO/DI5i7RxBaig==
X-Gm-Gg: Acq92OETqmTGrB+F2HUay4qMFZ7Qyl23/nHwOH0IiNNOQkzjU4xSX/+msbl+SrXb+rK
 DIePwH4GuQYuM+r4U87qgO63WANEH/PrpWmOu544ElGAtjw7e5WDCqeBbY/103sY3UU5YSaHb0k
 auP7sWngI6gjZ0mZ5BDVhvT8tfRYzyhahiWWSUTOvvOkRhq5KXYeWZyEI2tApvtd69ze/ffJEVb
 WYpvhrHHY+7/qN4g6sIPSZ1uiJ59rftQsqWuXSnjONLrzH9LxcwuM5k7HrqCbz3ljGGBbyCW+w1
 cy+jQb5WBdfacLs4+6bQ2D5dnCyKms62MFscENM58uF2GLYdPG71zwUWvKQHyZxNNBJUK0/6tDd
 h6g==
X-Received: by 2002:a05:690e:1688:b0:65e:4cea:a088 with SMTP id
 956f58d0204a3-65eae0e4aa0mr2926773d50.36.1779377995068; Thu, 21 May 2026
 08:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-21-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 16:39:43 +0100
X-Gm-Features: AVHnY4LPoBLFmKtSAhG_gu-VIMQ6Ji2-OcwIqUP7PlG_93PAj3pOuRR07hWTGWM
Message-ID: <CAFEAcA-Pz2Tw2AYeDy+E3HdDWtRfhSV2zSBCzNNmGzdJP=1aQA@mail.gmail.com>
Subject: Re: [PATCH v6 20/64] target/arm: Implement FSCALE for SME
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

On Wed, 20 May 2026 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 +++++
>  target/arm/tcg/translate-sme.c | 15 +++++++++++++--
>  target/arm/tcg/sme.decode      |  6 ++++++
>  3 files changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

