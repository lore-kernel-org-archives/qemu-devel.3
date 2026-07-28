Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94961C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokW2-0007Nk-Pt; Tue, 28 Jul 2026 12:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokW1-0007N6-D4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:18:49 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokW0-0001YM-0R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:18:49 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6680ae2031fso3904975d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255527; cv=none;
 d=google.com; s=arc-20260327;
 b=cSKwge2FsUxpot5t7AKmcDdSQ7fF40lsc0KdS+cTWcO3ILbEitqd2xrhJIBPepeWL4
 t+amez8uMezJxJuDOsbjv5o0zQVWL1O26aIeOu2IYbxnmggmY19oc4FeKuIBuBSdGVci
 FEn5T1cxX2O6gc9+gd+ZF0HO4HE4qc2NCHKJgj3e6meQPvc/wVmmf/aL8n4GK4USvwcT
 Oh1CeDvySgfVsZ6ZdQAkX4iFHbNOjKUGw/lIl7q1uGXl0qzbMf3M/6I36SCXcMxYHKpW
 5W+ZxA5v03Fd9pn5+E7ylFfF+3suG40fTeSgll1q+nuNln1wGPRxdTihApq9q7y/q5yZ
 T8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NTlmCnhs7R9EB5cLD+d3ITNgjM2W1JVz1cOqzQkeZ/o=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=la4S3HfHhrUkDD+tDuLMbJH7d8CSi2A3slZNxpEtKs3BQ/rpiueTNqAYs3dH4xgdCD
 m6bO2JFTLhl9DB/yjEcXGr8f7XWV409aC+USnyIoNN13lMFnFhtm7tJoalo20k/n8xfD
 auqL8ezLV+Q8lTtNWqqpq01554Ut+C08uLUEEGuh6iFy2TwU22Xc8Va+L7fGodIaYc/t
 LPGDWZjerW3qFq5KXm+zQjDkr+GUJdPnk0W4U9wVgXXpR3OA20pg9+D6jAh0XpI3TbPB
 RDrO55boS9CDaopt03twZZkeadtQE478kbGpUteTT9zWsO7re5Vt56duKz5bcYjwiCg2
 NqBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785255527; x=1785860327; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NTlmCnhs7R9EB5cLD+d3ITNgjM2W1JVz1cOqzQkeZ/o=;
 b=PKgH+t+x2NwfzliD/J4q0UgIXUJFIyhVmGhIfYuvwzpnh2ymR1hNDxxLUU+qLLaYpr
 yJhfy2ABzL6vVjl1NhiRTDxKAjS0M8QZnPJGpR6EkP3yciW5q4i8LtYzugnHyItKz2v3
 1icfF7pNyVaM1kb6e80bc0SLbtf00IZUvVNqlQ3vj1Mq2Hs1Oy3outhDChOs18Birv/Q
 XcAylMWZbR5pkZSUuAlApeAiNk7dUmvSj0E/uWSiAYX2/7TfQfk2cl8yy77iiKDwkCMB
 Q/fn7zHHhpliemH3ptrWk4AowdvhdDzD5BG+xOxb/2Fu8wdpsaaiKv3zL2iFTMe7a3WV
 yz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255527; x=1785860327;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NTlmCnhs7R9EB5cLD+d3ITNgjM2W1JVz1cOqzQkeZ/o=;
 b=rUsyQHzRLU3MI8Ei67bgokMh9akwtVRJ2QrXEUsgby4U4mr6fxLIynldRqoKd0qtB2
 nfmiDakQZItf5UK9He72FmJTrwMZAo3JReTfeh4WjlyUpIAD0Wa3Rh96yquHelUYb/P7
 8yE4j8vMDsAUOOO8y0fkgY2wzsBez3CZ9Fhl7JAiY7dTVQnxzBFeuEj77kRYu4ykcUbI
 wjS+VqD/PwnALrms2w+HaLMgcMmDV+adimpMNU6ZOd7Fwh1PwU22AadiVForgQV0AB7h
 CcPs7eVhGHhOggF80hkGoorJid6vUlpw70si1oZ6Y9WHpWWnVoJrM1JaBz5bAxoIdz3o
 Hk+A==
X-Gm-Message-State: AOJu0YyefOMyf10H+CcS2AvPDSzifDGS1XLtfvz80xNI2TIQdaY8zgiE
 /p5YCIR8sk2izUtTPok2C83kcw7CiR1xE1Vz6gALCvZxVgJGjuayIik9c2s2o4ERUH4uZi0L7pZ
 xdh/lzILRuQYjUx7697j8t+hRR8CDeTxbVGJMEloEDJTMQ3fvXjyD
X-Gm-Gg: AR+sD13gS84azP6pJZhi9QHF+PCAjkq/cURKpr2ATQALWVKw84tAjrFTZyZzZV7ZpCW
 poc/uF6Nh1vV3rlKc1P7LqgJ/rr8cuHR3SNZK9ypM2KWbtUGH67L2bhaGws40TvO4E0csuA7w3q
 mvSb98lFxeZB+eGBttVfJsTjyk+FyLXPnGQM74B3Nz9PGl+dKn3VRxvT8Ms95zNJam9PB3ZyAM8
 ejsyHjBwu29dkHnyWPCWhlqpa6Jjxt+94X7NkSo742Vw6yh+f6pTqHIl/89mr3AJlGMBUG7pSJR
 a+fJRXewhi3X0hn2ADI5i6o88h5gbNvaPxMe/Yg6gzu9Rg==
X-Received: by 2002:a53:e004:0:b0:667:aa57:686a with SMTP id
 956f58d0204a3-669057f7d40mr922374d50.60.1785255526678; Tue, 28 Jul 2026
 09:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-16-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 17:18:35 +0100
X-Gm-Features: AUfX_mxvewI-mWfoHo4-hjIOuWi0jluaJAG0N52CeHvZf2jZRpDinDjNIPUvPSY
Message-ID: <CAFEAcA8KdeQjsi+_Up9T9MOW6-GFtxJdGUH1K+B+-oxVg9swOA@mail.gmail.com>
Subject: Re: [PATCH 15/20] target/arm: Implement AESE (indexed)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 21 Jul 2026 at 19:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 ++++
>  target/arm/tcg/helper-defs.h   |  2 ++
>  target/arm/tcg/crypto_helper.c | 55 ++++++++++++++++++++++++----------
>  target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++
>  target/arm/tcg/sve.decode      | 13 ++++++--
>  5 files changed, 92 insertions(+), 18 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

