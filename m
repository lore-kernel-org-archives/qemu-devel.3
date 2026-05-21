Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28EFCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4QK-0005vP-1S; Thu, 21 May 2026 10:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Q6-0005oo-UF
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:30:47 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Q4-0004W0-N0
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:30:42 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-651d6347a69so7268210d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373839; cv=none;
 d=google.com; s=arc-20240605;
 b=hMNbqqWNOr6UlE7hd7lztsjaOON4rerLHDOh6HDGsPas8CAnVgLyLMesZZBIk67USg
 JXcmMnjFKwd3VcI5XKnmYn/uZnIYxol7NhNNo9wN3yxkjkCGncz8aYaeA1HMLk87SukK
 jSciSwcEcz3clE9bZP2TSQEXgBCgYQ8Lz4HrH5c4AHGHYggBUnEnLIcMfwAwpJaWMsnN
 DxkpT6Y3ZjcPVAOurH3//Hzp1up6xKFKKKmdTFEkZv/4Z6neack9w0A/fBwVgFZgZhBU
 mm+XT8mcQcV06J5DxLz9PErnMk24xULPfRI1w9HBB0GVMAuXrZ5nU3wVriXb0FJHi5vv
 swdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UHpUOakHGKrsWPtgderSr4NdJ/Vfh5OEciLKlTzW640=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=REiFT7o4wSnUoOL8ptoh4bS9yfp6STrzrx3dXsIz/dkH1tPIXt8TSYAkBVvMyvXTV2
 Srnyw/yG+OOzIZrOk3izgSU0xzU34QisezQSrl+gTmpcQpW71dhh9rxz/rDNOUsqky/x
 by4TL33Q289ErI/I4CJW8Ho8rCDOc322u2tJpKzipaPBLBLcPNtIZIQH4gm4S6wnic6L
 TAs8HKhAbwCrvvL1Wl3YghNwmR7K6jL91sdu08REzjapTguc/N0cWwXyIJBvvT2mVJD5
 SiRH5JNgTeOe/JpMa/KKEHcBI5iwqLub6/mYfkV9YC59obe79E6vv3XS/pekjLhL3RxL
 EWSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779373839; x=1779978639; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UHpUOakHGKrsWPtgderSr4NdJ/Vfh5OEciLKlTzW640=;
 b=jVLTuDTNbJ8qfcpEjYLF95LBrnN4Sr//Rfi9CyxnNXbvYywABp7N4LbiNM9LM+oJt8
 r9y3+VSqgrwaqmX2wxaIvQAfVQxpKZZ95K6EpcDGEgpjXyGxX1Gm4248yMhvq7SyIO3X
 esgLWP8HZc3XStgygMiF4BkkJrqCyhbsTgs82XtRkWrQW82pTUt3/9KIJu7imnxbduFF
 NALNfQDr96IRXPF9ajTSnHJ+Un+/DVOPfwIO8W+JvQGx6X4arGqYyPL7BNk2/A0F/9yS
 yUCgIUUeMpCgPyuB7GZyXvfDf9wEJv90wehgqjS4VOr34fqDTULuAetQVS9yWW/UrGJQ
 SlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779373839; x=1779978639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHpUOakHGKrsWPtgderSr4NdJ/Vfh5OEciLKlTzW640=;
 b=TsYDo3qCODoId+FD0daX1cbEbHqhnxxaDE/dYOFnE9I8/oA+6DykvJ6GCAB/1FHAB6
 iT6ye21d7GfESVXnhzfF4RLmygwNAw5ODqZ5lfBXqCUS3ZoowO2MRIKNREmVirr24YLE
 Ay3TNNjNxERubAFbpvDJuKpgpCXoh5gWS2kJLLjoot2zCe0zCYYUa74wDcY+JNFzUdUB
 bLLFMhdAbA/nm/2yI/zaDOgEnYO9uGlWyYIjeM/T7pZQX7zss+iQEnAuQB8BqUfUOXLg
 DI0bt0haK6AATZoi17BD/h/XE6kb+AJ6hUAhpm/Td0lCWUZT+CaVbR2/+5WwuJvH4Qg6
 Ikvg==
X-Gm-Message-State: AOJu0YyBxkWj3gvE/Nz9/0gzND/jdXRiuho00Y2dsH7OVajv0CxV/BKX
 U5pLfnlqcrvKccku+tLL02gAtpdT/cb1hGqDtuAQ+YggBcHLmlO7z8lQ5GceGc6hf41EYS7R+xO
 kM75zyqyR90tANPLMMdXQX/a/eJ4ptcadU41IYcV2Vg==
X-Gm-Gg: Acq92OEwTEX1wGuggjex4AEHoTwlcuoCK9DIaJ+qMfXAPAaD6HjvUbbCAUDyLSCy0Hf
 9kztR3OduVCqvB898Iqh//9SF9wt60Ow116GjEPBQR62zRArCy3rYNWbLE7NM4Ekhv6lAehYSaY
 ahgfivfa5bHXOjHBrGZNQjBAdeQPEVAzM9bbWpxrbfVWI55Wr6D2/Zqsehhqskg+eso0WnzW5zp
 QzfTPfWOoUTvztlswSBPAgCqOo63DC/S+LYoCJD0NOa7tThKsCjwVGb5RvDsngBO1VKeQ8tm569
 eo2eVPsQvOQNvu87Lj2vxwmAL3xZe4iCnIaS0E+ixrNFOSBS3BzglYt8786Z0a1DJ/E=
X-Received: by 2002:a05:690e:4807:b0:654:4441:75f3 with SMTP id
 956f58d0204a3-65eaccc6705mr1674533d50.1.1779373838727; Thu, 21 May 2026
 07:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-14-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:30:19 +0100
X-Gm-Features: AVHnY4IvWJpLgfVxCjZBTaLmEihop1ZDoBfKFzfEHhP42AUb9RL9git1HFMdvAA
Message-ID: <CAFEAcA89SVyb1pkUF4N_m1fwt_6UXzKxoM8XX6s6y6cBsMe18A@mail.gmail.com>
Subject: Re: [PATCH v6 13/64] target/arm: Trap direct acceses to FPMR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 20 May 2026 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index b013dd51cb..d2a4b0fadc 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2899,6 +2899,10 @@ static void handle_sys(DisasContext *s, bool isread,
>      }
>
>      if (!skip_fp_access_checks) {
> +        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
> +            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
> +            return;
> +        }
>          if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
>              return;
>          } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {

It took me a little while to work out how we do the traps on
CPACR_EL1.FPEN etc, but we mark the register as both ARM_CP_FPMR
and ARM_CP_FPU, and the latter handles the fp access trap part.
Hopefully nobody in future "simplifies" this if() into the
if...else if...else if ladder of ARM_CP_FPU/SVE/SME type checks :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

