Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F9DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6b8-000857-1C; Fri, 26 Jun 2026 09:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6b6-00084o-P8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:27:56 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6b5-0004T3-0b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:27:56 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-662bf1dab83so1515926d50.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480473; cv=none;
 d=google.com; s=arc-20260327;
 b=RDBOjGSzdh1s3fvd3UTJT2597yad0e85VHEZlsOvfYFFZLT0RL7z6pw3dg0aOeCitV
 FRxxffE5XbA/snPnhCDoyGviLBrctQUAiDnznfAdDy8MTBMBiIPPqQ1Em/wgdfvqx72/
 M/TWqQBs2HWme50nTaUbUAgc1vDXiwt9TcSXJRnuxRRT85c9NyNRJJlk2dEEnD4Ck91n
 8qJPGBAvpRuUwR6pOyA5zE64SIctMU1CfxC9yKHtkkZNlcoraG7w6EB3601Bg0MRP9aP
 bQW8KvVASfXccLq6F/aBTCwx2trr3c3X1II8jxUmA2dLXwvM2DYNnTZceSE+mO0cSFh0
 R0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=FvcFBAlvkZnz1L4n1RO+biOYZdyyMzT/RN97osbvNlbyqbBNmDRLM+wixWPhUnjWsb
 5A9WKt8s7iYRx+9fyUJLVpZ3ffPmD4TTVc4ORaFIQvxU3RQaD52wIP9brpTRUX5FvbSR
 R8bXd4ghAjL5O5JatF0b8SF386XEXZ6ykX9pXtaUEO0gy/rt9LZIIlBcIpW2y8inhhg0
 cfQZFp0i977kxZSLkqVGqQfmAqt5l7+7O8MuXJ5RxC1MO1aB2k0nhbHAuFj3yuECSGpB
 WN4/hoUZT4O+5WVykywBkNMLC5GRZGy4Ucrm/txjpI3sychX0uZXdLrd4bJlijk2KYg3
 xDuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782480473; x=1783085273; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 b=OZf8fLOiXlenzl2YhUBApvyVPJQmUIcCTTJgFFxQuqzUTG6Rj8TLw45mo0RUlH7ohv
 ygLRmYkYG3ks/07yaejtvHGVKaSG58qjps3up+xcc2UXvi/YCF3uPwcVPpmmI24xpqEb
 nlc7yiz0P86RBBUFjGTCkLWXBzOL139CGnC6rZEQAQkLd9xtkntw91cJSlAxvoOFUvB+
 IVPvqzxy/g6vXLLCi8sQ7zl6EjaTqOoRm8cE47AtwGAQjlTsNfOwDFTq7nvyH/35NeqA
 ukuI781msV8v5OJhh9zrkdKrcaZA5Aq/0NoKZWNZY9Jjx+anOf2A5vC5HUvX8qwePjdC
 H4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782480473; x=1783085273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 b=TKCkUlAxa/UemUPEXIC3g9JEtfiuB6bcvSpwuTM/yZqOXbFYYsCzufOITgFlbJxMpv
 WKSZfRyn35mqRSuyyuRCxTO7KBwU0Dga5aJH17hV9bHn/4lbSg+AZhy4Eg55D6DFqDg4
 qKjWOmUvWeY5uB/9FdPHARZfB5VX6vCRaO3qLRfgoxUzntRccP2veYqXXUlJFTFgRT4P
 CW6o6qBopC368jvijk/QGB2iCtukZ+Njl5FCKklPma7AKbjRvXLB4ksTN3F9yPO+2cm/
 EQU7AVG7ag5+UgL7D75kEe/Og31KkH0n5UBDqVrQdqipgKj8zxQbhtjJU0jwmOTpWxdy
 7KYw==
X-Gm-Message-State: AOJu0YxIygsZCsReLsRUM0Rx7rqqt7FbwcWY5WGJR2dYJ90fKsWcArXd
 6bFLgtCpGlaVldR7oGX9K5Srdd44cSgqRqBdFfkBOwTMXD2hRmNy+hxTNDR+Lj6Ke0o1d2R0n71
 w60ayOCkGB7rbZYAOB67RZMUXUyo02XWP5dvNTDuzOw==
X-Gm-Gg: AfdE7clu5nzi7hot8RXzUF4ZcXNNpCSgiMsMXuGzEsEnpxbn6eKCAhZ2W61YFDArjeT
 60SCMLo5/0ZCvCq7QV97Dj8oDthx85pStr9LOubup0JxuM1oCz5pU8v1x64k1i0V7HGXFuIXlUo
 URiE6oR1+68BPQ7yWQFz82T1lri3ld29olpTKxSPgOLj4sCov2nAKuQH4tEtqYd3lIanTSP/Tdw
 cVwX717F42D6GD1YkpY6oBiQ5RY0cqBIKn1kte1rXoZG9gWSD6dxRbDDKGtI112OlO8E9G7ncEJ
 795ipKqlgWNuu9fEngQKZ2CnCYRmxIN7m8k3Hgo2W8JjSNft6oJICJ+0
X-Received: by 2002:a05:690e:1304:b0:664:9bf9:3dbc with SMTP id
 956f58d0204a3-6649bf944d7mr2183759d50.33.1782480473338; Fri, 26 Jun 2026
 06:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-15-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:27:40 +0100
X-Gm-Features: AVVi8Ce-yCl951hmDpeLYpY6CU-Tt2DRGkd_qxEQpl952alAI1jO0rygJ1LfstY
Message-ID: <CAFEAcA_i9JLDPaRmjyyONAhQWknZK5jexGXnZu6MdpF7XJbY6Q@mail.gmail.com>
Subject: Re: [PATCH 14/15] target/arm: Implement USMOP4[AS]
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 25 Jun 2026 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

