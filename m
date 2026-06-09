Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8942CD8CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrlQ-0002Yt-SQ; Tue, 09 Jun 2026 04:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWrlN-0002YZ-Ri
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:24:45 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWrlM-0002va-38
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:24:45 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66061993294so5508271d50.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993481; cv=none;
 d=google.com; s=arc-20240605;
 b=amXB0wIriSVpshufKLgg58YfmwDYQldaMx43SkybzUVRsUYwoYuZpQfg/UXmzHT1tD
 bH74rhE3rYNH38cgyqwEReXgdgiIc9AqDwkAfOsdFQP/jlBdL6Hl20Zc4CxPGuq28Y2x
 M2BoSk3UK97ZaPhjUwQd3lWZSYohqsn6zNSVhibFAbhJbuGRV1vlmxtJbuLTPLgdBwOc
 8TcvywhTWtxQYUJUGdGVpbfzMgFoT877Hl1Jb15blxGgoZHeSgv4VYgTimsXSTC8WHGp
 45fEu44lcMTUiiMJQKnnsloGaQ5O55zSf987YdX5YvVgu/asU390ZlKoZi/MCIgWyZ9Y
 HJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gvRmu949fyV9dIe2hiEzyWUsojQhzItGWn2M0PgLXlk=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=XEMGBp1T7Kl8dX7KFM8bsvNZj6j32L+Z5rs5VQw0AQ8dPvJTtZgz7UR1wt5uwAVD4g
 TSEB0AjWlH8S0Wvve4JYtAuOpzzqbfPtc/BEmZV5Q7PsRp8zVNSJi5Rvd3cokWYzBCM9
 sfsa0wBrJej/723Gl2xD4yKFYw1ezb0kzTrA1pS9AiLCVS1Fe5gwDzPqbq5sWDQMdKZ4
 R5okv04RcKyMq1YYFUOlRAG+bmQCITzu9tcjnYYS3BJQe8XBsduNh3JQ/0T9pqSs9nUz
 X25u0TMtZaxFyL4ANcNXt/Wn+egUZfFSlTa3IQdIu0dRlYvm9Iv7kRumhB9OjxFutOj0
 Es5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780993481; x=1781598281; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gvRmu949fyV9dIe2hiEzyWUsojQhzItGWn2M0PgLXlk=;
 b=YlISL381CnvVBFY+6UrZp2BikQJtpihODzBKAWZH5oEln9catKrbFtWG4A5dPWd/90
 KF4Y+AAppj7vOHlKxbpzAwlhlkR7krhyBiEYNNv7HtXcZdHJZG1xAHjADWTtAMmSF6J/
 chDRvSn21l1JDVagz7RndwBC/sMXCGvdat5spjTHG1KbsjxIeJDUwEVXnhdJMguPWAXk
 yRSbNtVtJcAWRhEvbi22DNap0FkZtZZs3mlgWuUhyaRiOJHH2YtfKdTmHjzEYDWXAcI6
 wK0JWd3AyvHh4aj9qT6Pq0eIAPi1e1dM4mEV/FEj0CYGRptYaKiE0PISsYIrTQSE5PYP
 dqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780993481; x=1781598281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvRmu949fyV9dIe2hiEzyWUsojQhzItGWn2M0PgLXlk=;
 b=bc37ppffJziR+t/HatZGLurH0Z4nAGYBQyDeIoEIV55JKi5SHaqExSre1DkEZ3x/2n
 wPcsYTB/DdJRzVl9+BFeAvN141JnrCMZBTft1c9Wsvt7nr7Yd+xtSjRgmu21WOlxip35
 fkq+twZmiY0PE99+4/hEwtoaBVWNrDebB45uUPIYXsJZz0opwomhNGxF1DzsylcPCFgR
 lAdSrv9ZAsUHfdp0f2NrUtC2vvOzsvAypDmZUzXmTw/wBbgaUITBHSmAG+YboUpoHdIK
 K951Ju4YHhhbeuEAN4eNQzlQcCGqM8i5k2N/+NEdtvbO+fH8dGe/PEmmsOoqhohAJt2m
 Haxw==
X-Gm-Message-State: AOJu0Ywbkqz9VBzUCY3LyW1gE1+h4LFq1n8ZSU9/qbBRgCkjhot/29gh
 /mnnycXfil6Q2iU3TP+aHfnDZ+JNqGfFOBDmNwGeZ0WZiy2pFd/cG+gGM7i7D+BOq1Rf1lyua1K
 9PoqXk4BzHNXpx9/0Gbil+ktxmxAzSU0g6r5J9iLNaw==
X-Gm-Gg: Acq92OExCDGesOtDUBzDUwwn+Rk0DK0I3ZwfKt6yuGs5aWs687QHCKrwuTGmDmkZe1j
 DBUFRBi576zKmN2zxyl9YyvBrOODEFpWb3jxRhgSrJb38YHuDhfn7JcJgeoq5cv0Rzc8mU0mttD
 eEPo/2Uk8Dfve0PNl8bDyuiGmFAEHsrFscgGZU7l+8Qkf9tZosRwwDpJmCOHCek24p3ovD49ULV
 fdtS9hQLgXqs4dKqyzG8K4zIQGaUp2oHJ+7OlbE6BrEwM8eiHcypmSWtwE+Bs35/YfnzKsGuhIo
 oxitVgMcuX8AYaLgeG19MisoFWVEzrYiZt/8nMc8r/js35WQuYly43EJUGfZFMt3Nd++GURmopw
 48g==
X-Received: by 2002:a05:690e:418b:b0:65c:17fe:6d49 with SMTP id
 956f58d0204a3-66106ffee84mr15462245d50.61.1780993481177; Tue, 09 Jun 2026
 01:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260608190155.637067-1-richard.henderson@linaro.org>
 <20260608190155.637067-2-richard.henderson@linaro.org>
In-Reply-To: <20260608190155.637067-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 09:24:29 +0100
X-Gm-Features: AVVi8CdSYh72XjmG4Q0bvfCNdGpdxtKvywQm9bw8VqXmqIjLLxGQV9hXZRqBiKs
Message-ID: <CAFEAcA-u9nG8cnX2_suYNZj_+L3coWL+DT9VdewbO_OZfDR70w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpu: Handle all rounding modes in
 partsN_uncanon_normal
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 8 Jun 2026 at 20:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Missed float_round_nearest_even_max when recomputing round.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-parts.c.inc | 1 +
>  1 file changed, 1 insertion(+)

Fixes: 72330260cdb ("softfloat: Add float_round_nearest_even_max")
CC: qemu-stable@nongnu.org

(dunno if hexagon hits this codepath, but it doesn't hurt to put
the fix into stable)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

