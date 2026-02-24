Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA69DE9B269
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutBl-0001Bo-GI; Tue, 24 Feb 2026 09:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutBg-00016w-8K
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:14:56 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutBe-0005VO-Kn
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:14:56 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so406729d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:14:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771942493; cv=none;
 d=google.com; s=arc-20240605;
 b=VKWNJxOGur1U7JIouU8N2FadF0IGNnplmlSqQQZBDcTASRTHDENSjpxZduB7bjzfRN
 ob7zB4pU4xJ04AQE3FkHcH6ssOxacsD8MuXo8D/E9TL1dJBmf4c8+b5IF8iMZwmEOuRl
 GxE6EW98kwsuUHk9flPDEYuje8YQSf1BAv1chWIOeWmO2/a1CEgjlmU7/UWEGXfZPowK
 rcooDhsFkn3IFeF7tiNyK/R3q9h5iG7GvzHovFexDzAx7S/UhLHR0mHcm0YIHaYBtXSd
 r6HxGpngSOv1ZVNEcs3Tf1JKKrO2qn43x4ot9nkq+rd5VZgWuT2JX9A+JrZcVE0QX1Fc
 R7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pJYH+FDZt+A7xhkmbFnnwY7w+J6FtRi5scYK6r3B2Yg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=lQ99qoW5cduvEQR3yBzhummMyBoDE5KUQgS1iQJKnsAoZ0IofIRm8ZuCBLf0BVY6O+
 Cd68VFQSK7cu4gP/hRCksZavU3UI7FhGnF7aRR+fwNZPjECIk6YCCx4qstfms6oCXaBK
 RGfuYBogL20bhBEneHwnRP+BFuCZEY3WajhnU761+b8NjZapulhYtStTcJlZ7j8g9wS/
 9WRfIlbqyyPIfKxqFfbHwyvip5bi+zT9NBn84Al3G5GlVuhKwm5OJBXyH3hyH+03h8rd
 mXjHi66k8H4FuQqwDd7t6MkvL4SfNt+SKmyvCmaWtb1vFarkv4k+/tT+JCoxti1aBy6b
 B1Cg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771942493; x=1772547293; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pJYH+FDZt+A7xhkmbFnnwY7w+J6FtRi5scYK6r3B2Yg=;
 b=ZlAh3MZ+eJop3vkY7OmPjVFZxxunVmAe+NnJHc44AnRXdIyG8lOpBj+dnN0/PXWqZd
 VCZRvR/p5s/C/2oggkY4u0e3+/plMHjqTbqy+O370tbqfUAW8f6F1y0LjD1chQnauNLL
 5HpIVEHyq2i7lZPpX8+FcKSMFqPsvxavYSnehc4ruUF4vnwOk2qHAlGrkX2taUNeAmkz
 M3FOJBrJepdo2k6Ow7iES2qhfQPEEc8Verp2D4a7gIEx+bdUdedf97R0BG8N95O0s51/
 jFvbkPhNJYOa6uUKLWjsYPrHM2V2+l1O5mEA+tap0jsZKKUCyt7VJ3f1Q5i/5kE8Biup
 u0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771942493; x=1772547293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJYH+FDZt+A7xhkmbFnnwY7w+J6FtRi5scYK6r3B2Yg=;
 b=YhMGZahx11RmDTdepBVoc5tSUSNs8B1NS1scEJlb628UXBZQ9ZkkCQo/g2WIQxlCNQ
 4LBNPEmZqjL5n6MrG3P2AL1/BVAC2cRgKpyjCk0it7OYcEFBudzVzCpAgfTfEqfUhM88
 2FgtKoMS0L857pUU8UuKbr27oF1hJhXCxe9ujFjpLtwEjpjm/+G5FAapRYFw+E+/j89k
 Re7SbM54SE3x8Ld+nmMyY8dICrih8hL1Ie3Apghzq58h8A42ec5OxFWDBXKsRqVCWqDe
 CPbkTOy6aSpBR/IvFS0THgB07Q2Bg3M6ZfUDR//6D0m9TuFhqKAnaWmXJN7vyPkhtsnN
 gJhQ==
X-Gm-Message-State: AOJu0YzY8KvCZSmr1ASHCgTl2b1JMEQv6A1Uiwk+OhaLf1KKVKM1gH9P
 e5I66NDIVPspENcl4z0/WcGimsMG5e6NaIzufsZ58ZDuut00HhnLd8pToyyRN2U2ySLfmPZr8n3
 MjuFhz+xFcRIrCLIiD3zB/YY8vf3E0Hx8AKEyroe5bWwuazJnbDnr
X-Gm-Gg: ATEYQzxKtREUmPCGcU20zV/ZstLcNTpyq0QdwU/a82pbBl5zJcZMXcLmz1MFA5cHzN/
 qPEIpEjkIiYP8hvbGBgzyn0r4q0jZdY2mkiqawIN/n48ht4aVgnLD79zSP4Bhi4Ad/XKtJVaeJz
 vOHHuFSw7JKN/jocNFEeEfLlHVdjPCwwG9G+qkACcUoDMQR8QK3O2wFwOOcrnsulhE7yspi+3Gr
 kokU5wrP2Ed8MsiwTtqUIy9x5l38SatIe8jpwrFOeJ8wAaJGkaHW9OeOlXown6VyfZiJYu6xO6P
 q24r955NCqdOq5WH3X+l3mGGqhRli3DI43lNB6wr9gDc+i+EATt3V9Rx1n+kKQwXWucXZrN2j4G
 WBQ==
X-Received: by 2002:a53:e6d1:0:b0:648:3d3:790a with SMTP id
 956f58d0204a3-64c789c7f8bmr8415477d50.17.1771942493253; Tue, 24 Feb 2026
 06:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20260224054417.32430-1-richard.henderson@linaro.org>
In-Reply-To: <20260224054417.32430-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 14:14:41 +0000
X-Gm-Features: AaiRm52jCEOWUdDJYo5SRL0iJQ1taaB-kAGRYpWys-xASiu0gA9AUj2mxrEst-I
Message-ID: <CAFEAcA_4fgbnnL6g5F+2+TcZpHWsxg-n=-c6064PXDmD7ZN6sg@mail.gmail.com>
Subject: Re: [PULL 0/9] fpu patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Tue, 24 Feb 2026 at 05:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8:
>
>   Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 14:03:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-fpu-20260224
>
> for you to fetch changes up to b5fee33bbf2764e9540ab5e6b6af4c9493f65677:
>
>   fpu: Add conversion routines for OCP FP4 E2M1 (2026-02-24 16:21:18 +1100)
>
> ----------------------------------------------------------------
> - Reformat NaN classification to share code
> - Fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
> - Add conversion routines for OCP FP8 and FP4 formats
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

