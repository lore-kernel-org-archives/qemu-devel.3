Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A4CD41D46
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBYu0-0002jD-6D; Thu, 14 Nov 2024 07:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBYty-0002it-Po
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:24:46 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBYtw-0006f5-T9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:24:46 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cf8593ca4bso132615a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731587083; x=1732191883; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d3Zr56rVpRPBCvSgcoYTySp3vkQbhuoBFeXwsSxaBvo=;
 b=TjCF3re/BGuelBvWShoV55g5A0ocEmdCZw8M8Fz8cb+Bgo0PmMjgCzeoQDm5QtyPkf
 6kO5ZyEdh1nZfXI91en5UqclRDgufwKSOwBhKx51Hec314HMmiwr75pDdrverwBadLbu
 pCi0rrDtLL1kRsw+H/dbW027yhqCFHqqxYHzar8LIk9zPtMJu6UlNWuh/UX3+QSzpPZ8
 gyGMlwU9scnZAZASHoms/J1pwm60uM/w9yavyNrUkk8DmY7IWPwTdkntmQbHB8s0jCZ4
 4sfNOV6v8qE56QPsq/hyZysNF9SiNSmfNPJvte0kvvH1ZpD/MZeFL1Bl0VbWPwluFtbI
 8UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731587083; x=1732191883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d3Zr56rVpRPBCvSgcoYTySp3vkQbhuoBFeXwsSxaBvo=;
 b=Kqj10Iqlo2G5WoCRnvm1goDBSoe4RbDA7v2el+A05Rhms4/icucmvFwC9PQpbspHrr
 HzLEde8ifXYXKlJO2U4BGT9Z/6T0PkInASMEFevfoi68l8bj5t1GThWG2fZvKdZnFjhH
 IobuP6xBg7p9uudP9YgxPiIpAgFaVAU9AKu67Gle74yBr7yqTWiATYjC9lAqJdsaSNs/
 SeyZseurwC6tFORbySg8jEskktYqVotZdY4ib3xPU2PfJRkCT2Yh8XjVRtNQ3ozsoyfs
 I3Zq0ix/zsaRLi4YVdpEJG1gbFy1JM6sJfavIsFUk4xJLvUjt5LVWpfUzeI9Ijz8xz5a
 J9Tg==
X-Gm-Message-State: AOJu0Yxl/quRAnAu+olwyUFC2La/9GMTBGsgM3fliLKVXdnNpFZVi+ci
 kFxvPFxx6HDsXVyjjq39d5RiDsVhmXEdhDtxrL/E4Wq12dCePzqG1yD9eDggM/yrCsyH1Vef5t6
 OZrIcSBiqtgaa0rpa9UMTverI/sW3sFDqkrIqXA==
X-Google-Smtp-Source: AGHT+IECuEFSLtiHmVmYcfNVlStIWgHV52bsNSOD4Ta+BXjifSck05nBUA/UKUPLOJKZJeWXUishrg9JhuBaarplJNU=
X-Received: by 2002:a05:6402:1d4d:b0:5cf:74b0:36b1 with SMTP id
 4fb4d7f45d1cf-5cf77e86514mr1547396a12.7.1731587082528; Thu, 14 Nov 2024
 04:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20241112141232.321354-1-richard.henderson@linaro.org>
In-Reply-To: <20241112141232.321354-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 12:24:31 +0000
Message-ID: <CAFEAcA_CsWCNKOqNKJe37JRXnOPikLSRq9FyMR+T0sLLkAidLA@mail.gmail.com>
Subject: Re: [PATCH for-9.2] target/arm: Drop user-only special case in
 sve_stN_r
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 12 Nov 2024 at 14:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This path is reachable with plugins enabled, and provoked
> with run-plugin-catch-syscalls-with-libinline.so.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c | 4 ----
>  1 file changed, 4 deletions(-)


Applied to target-arm.next, thanks.

This looked like stable material to me so I've added the
cc-stable tag; let me know if you think that's not
appropriate.

-- PMM

