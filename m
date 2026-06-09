Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594CACD98C7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz2v-0006Ph-VQ; Tue, 09 Jun 2026 12:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz2u-0006Or-Ax
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:11:20 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz2r-000607-So
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:11:20 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bec449cf976so800432166b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021476; cv=none;
 d=google.com; s=arc-20240605;
 b=LWWsKtYUEzxBpXsBwgQUsT2dGmNX8/bF4/CYtR4UMrzgzSdJWL25ZooiD4rK3wsFAx
 4JnxSBqOdBvwnc6Vz4Fee4ZqJ6r4T12PneT8IA6tA5hvpm89mz9CeTaripLwRCN1ZtUs
 q2MhgtHp8L4KrkCXwhmzNVdn7KYLg9QSl5PbexmePK7do1u43PY5gSFJTywbdVi6zEWd
 yzKINOL09lbYIlyD7Oy8O4cCLcTb39KM9g6LO9N4mfV2lNATXcyAxOZNPG03QLMnEh0i
 DNw+OcHppgtn8mXqa6+WkqJmYVDFAKh1kfaMxCF8aMYEFkBJJTfixiywxrhpnMIl0V+L
 sveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bmbZtOBEhzGzWB5lH6BsUTwAB8cq+OSXLFA+O8hG9ys=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=gf+qFZdXtGDuRF1DVfHOeIJC72ce/l2PNNkoe4J0NJZwrREAkscSVzWlnoo+AaQG4R
 TuXZklJmLR/qruoqTJN5/NVx8Jl5PJEw8AYG385u1b/oGqk35YyIihlElV9SxXeh2WgX
 SXnugJvj+VkvqniYHgFP9xsxOBLd84V5xmXhWgx+9bOvIcU5EwBbLyow/4zeea/OQuur
 6o5xg588fhYAG853Kzr0GHH3Q+E0abmaZzAeEl3LYzk1M6etL87I6H1afdw0LXwEyIQq
 iqsyHZeVqDQGo6Q8fm1TfXx06hyCVOYqkjf/gJR18ZPohck/K5ukgNxltmz4rZ88lI/3
 wjFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021476; x=1781626276; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bmbZtOBEhzGzWB5lH6BsUTwAB8cq+OSXLFA+O8hG9ys=;
 b=FyFp2JE1o7tIUtskAV994KD/ltPUNMDCEtkE4dELd7tGv4uPTJd6kSZno01GjAIEtN
 17c6I2i/LIJx3S6zcoxSHeC4RJVPqCC0GAIRdS6QGZz1s1aUTkQcWiU10ux1PiIem2Kd
 2NH+Uf7ziImwRfhiJiSg7MEumAJr2nGMSiZnptgSXMdNP3UAMPsEmkov5NwiB1gpwBvE
 uoveM5oUbTg7hrjZl1nrdlpwW15Cl0Pmo/tupC2qMURmKaGOaHqWtuRkTn8MfqklXCnY
 4uoSD7NydjUJKV0wuSbSqx5YztuhirfrUlxG7tlcoW7v/YQvk290Xx+2QHDNPKsKndv+
 XVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021476; x=1781626276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmbZtOBEhzGzWB5lH6BsUTwAB8cq+OSXLFA+O8hG9ys=;
 b=PHZRLWgyBKHKx8bpISGbWn0cHy0OI5ESC18C11MkRug3xqUM+KJiQyH2UJcPMQsRC/
 uOICnV5iItEZ4luYoD8pcziIqLyaXA8rKLynfPs9Afx7sO3iUeiF5ui+kLL3/BVW1N4t
 g4/cbv8ZsWxzc9D2TRgeZbs7EmOfyUwANfdDrBRLAXT6/TMQ5Fnw1YWn0kYXUhMuIwJ7
 qbIF82A9JM/YicK8Y8GXBcvYmcTKsVQm0o3Fns6w7f8K2SfZMQgfVZ2V/t3YQWJ4MkyO
 7BqfXt+Y3f/dBwAhoT9xBIotFgmJYU9W+D77PmDAeOrWw/JvOtf4nKF3HoNW3M5aH1Cw
 YG8g==
X-Gm-Message-State: AOJu0Yw3RbiP8oVBmF4SwFsJvW6la67DXSsLXMLdaLOSPc9E1HPUna9a
 KjgiwB8DSx5xOTvBar6+B2h6Um5frYjmJPe/OmboIEI5uq0i0I8DTRw0aUOscBn/IDkPOqVDtMz
 N6F67SGNhdqUWaKX6/RykKjNKHAmosp16JyUMK/68BHzkLFshxwsf
X-Gm-Gg: Acq92OG68YsP+cnfGFSjsma2c7uyNCmUEFqFt32biv3SU/XPgjnunQ3DD3tYe0CdzkB
 FAClV8ArXjwnr/mRU3XHMC12X41ksv269BV+aCQGvOYJUNdRyQBhSvrh14lTP/RGQo2RPBn0HwM
 s+Fr4EhJvhv3bpsi3xlkpi3gYyfGGMB4Ab+/+BrcGSFdsFWNclnzX5PAStNyRXG+kT/m72W+ADm
 3Z7mk9bHWj5w8i9PAEX8Fpb/cjJG5aEHjxA9XiG+wBeS3HRIRCX1Hb1w4cZ5XHQYtugAZmww1X5
 3ApD+geBbLa/mdevomCLHog084wl12L9K6SextiblCrx+q8kSvRQE2q6mTBuT5rHt5qLCin08yw
 ptg==
X-Received: by 2002:a17:907:6e87:b0:bd4:6da5:d5b2 with SMTP id
 a640c23a62f3a-bf3703794a5mr911572066b.1.1781021475982; Tue, 09 Jun 2026
 09:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-34-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:11:03 +0100
X-Gm-Features: AVVi8CcgL6vAWIBrUePYMYsaq1j7dH9KveOcBIv8dUe_FINXbQIAN6wMiZQJMEQ
Message-ID: <CAFEAcA-TX97Vqv7VWUi1UzSq+=+yMTG_c=UX5Mu-r7SO6pG8nA@mail.gmail.com>
Subject: Re: [PATCH v9 33/45] target/arm: Enable FEAT_FP8FMA, FEAT_SSVE_FP8FMA
 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 2 ++
>  target/arm/tcg/cpu64.c        | 2 ++
>  docs/system/arm/emulation.rst | 2 ++
>  3 files changed, 6 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

