Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2B0CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYuH-0003TJ-Ow; Fri, 19 Jun 2026 09:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYuD-0003LC-88
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:09 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYuA-0003Mo-Iu
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:08 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-660e9fef1d4so2206912d50.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874305; cv=none;
 d=google.com; s=arc-20240605;
 b=XW1OvwOnj4Sf6CqYJS9X0zBEaDnPBbf0fcT//6b0ItU6/i91srnWf8xtl6ywb226TR
 Q4Qob09FTLdSx1ynfuwobIjDN6CMlQHIsGQ6ilzmAWnTq6o3K19W6WQlSaTXnQL/6mK4
 vx8awgLXQlnoFNIjQXjTfLw6JDUinIGIt3arwWj91CoG3/T5Y2Y3sx2p1qc9hzPdzWsc
 Du9MP4iAj4xcs9s+pb50mCiucZwVeqHeKEIvuNM/GoydTk/OXPU8Esn7y8cFmd8LDKg3
 +PE4rYO9NUPA4k/esXCsbmIVkA62qw6ZzQsS6efZnpVuIPFoZy2ji/De9XHVpKl1nHbE
 mRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RqlRoDWHmLfvS9rD6ZtcTX1mUk0I/tN/zqNz77rFEVo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=eQ6W4m0MCVx4Ion15uDsttKditl/rWvY89EinPhayVVnEIcxGg76lKX/tq9FMjYZHX
 k02CjCEFh6bmUkP/0xGqoO5pB3Kpl9RZvWydr84SjltCG9v5jhBVpKtbj0BpjliOw04+
 tcAqyyzqMbgw2vW44fi0Kx+i/3U0zoXmy+eXUdsQ6m0xtlLZFgHS09BoKYnh2Jqs5yLC
 0hVoWw4eLcVongZWdK/NwD9Irk3JYO4zLFQwYTfU75TEro2k7dz+Vy+1dQinAZByNnRo
 Ox1kZEW4/OeT1X+tBC4MYORsrw7VWi6Ui9AF/cD1FGtdXKbExC3RAZ3lPoSp+Kj8Z/DL
 mzew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874305; x=1782479105; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RqlRoDWHmLfvS9rD6ZtcTX1mUk0I/tN/zqNz77rFEVo=;
 b=CxVB90Ak/KpaAt3KwXjS9CRJQRtbBM98MdBvVfNWwrAdLKXRS5p+GvAC/oUpalNC5B
 TV5NzYCzYlLrRg0Vu0hZCNj+Tcj4kb9Tq/jdgkIDulPk/vSj77+QIH4iVnbpCMEKpquk
 mMOYHZI28zL8OBS20d8+CoL+iEk7LDz56I32dRacYF83OK9yDveRm+37D4f2lCSKwu0H
 6wfZR4w6288HHJzA/fXJz7PV7J6w7ZPN/iW0sHoYoVAz+0LTZ546p6tN548Kcw60Ngpi
 fEr77iMA7hZ1PBh90NeXbBfUEBlV3Ti83TlLvKr3WzdLnCXNZlRqSOmQjJV+jvt5jusS
 fl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874305; x=1782479105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqlRoDWHmLfvS9rD6ZtcTX1mUk0I/tN/zqNz77rFEVo=;
 b=mys9raOLVwOMsgWJ2M0N61wmWRh5EqTAKHaTQqunLqYKS7O86Bw5IM6t41zFFKTvZs
 DMgR+ag3uu2BcmKA8DWmSTlFHYKCcPFAq1Pq1djWcqo4VL7JzmtDrcR5oiVh8mZ7BjWT
 CgsCMxZFHd5KQURdu3ykKnio7/M89Pa4xuTK+oyNvBIB3dgnp1Rn6Pmxx9sL9sEFjw7y
 skdOjT33onjEw75QPGu+cT0Kejv1KKRWEG2B68kayv/xk+VSYoYQDRbd6whR0ZdVgDm4
 OY+cA8kLytXJxEA5h25+DizSwgoEsvXI5eyEdRju/8Ta+VN3GGVbrldmz7DnN9S+m8Th
 bdFg==
X-Gm-Message-State: AOJu0YziF7t0WLrfLic2qVVjiFRN4wX67aIS2O94YhKEaFMlpN+MLfHh
 o5WbpwU/cWQo+bbOkWimPg/GQXc60/BEfltxZ/+cy9d+8CtwGTUtfBXH3lOtsbVZba4AuyLeLdS
 GG2M8bDv/dAphIvVsP9UvCiHITRFeCmeP0UfiPSQoHg==
X-Gm-Gg: AfdE7cnNduwTh4UONhx5gU1LbbCCKG+cibD42NLHXzEgLf5YG9LkmGUrkdM9Cyv05V0
 imlUTViDVrIiZOTNLzG468Hs64W4wPIbjO5Gxii/n3MJJ/TGhI03rjgp+bwYas+Nk3Shc8Gon0I
 xhnuEQ5wttP4TwUEyawSYIggeq/yhaL611GHCyEhFYniok9BP7A6eelnoB2B4iPUn9POohCjx9K
 Vk8CL+rINFGybiWlmidJXK7g313HH/R+jmI1Y3ntqoCssABbFiDROLv3m5JUl/LmWAee/JCiNPs
 PWxD/GaRdNNk8OOS7QqVLKlEA9eAVYjz67vs7irgtQuUpfRZm4A/PaCQ
X-Received: by 2002:a05:690e:43c5:b0:660:a41d:d156 with SMTP id
 956f58d0204a3-662fca03b57mr2625501d50.35.1781874304907; Fri, 19 Jun 2026
 06:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260618040718.572950-1-richard.henderson@linaro.org>
 <20260618040718.572950-7-richard.henderson@linaro.org>
In-Reply-To: <20260618040718.572950-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:04:52 +0100
X-Gm-Features: AVVi8Ccwq7_qgOIYmBDgx1ADH5-ZqL-Rl0iAFLFGx0rj7ZVwLPBhfzWMPlfEK2Q
Message-ID: <CAFEAcA9n63_5MVVx=QRkryrS+FQW3hiQd78yD_0MWEXfC17S+A@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] target/arm: Rename isar_feature_aa64_sve_aes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 18 Jun 2026 at 05:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from isar_feature_aa64_sve2_aes to match
> the feature name: FEAT_SVE_AES.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

