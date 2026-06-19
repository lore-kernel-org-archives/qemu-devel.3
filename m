Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389FECD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYyz-00085c-61; Fri, 19 Jun 2026 09:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYyv-00085D-Ny
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:10:01 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYyu-00054E-EG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:10:01 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-662dc387b7aso2432347d50.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874598; cv=none;
 d=google.com; s=arc-20240605;
 b=aykO4hLp9Ak55bsrp7AWrTYz9U3HvI2GUz6qsbxNGS9H2dQfB8CpLzdhII9swXDCN+
 JRZ7+YTZdk66o+EDnctTP0MTWfhnVGpURy4J7zk2cw06R9TSd1cdh3+GlVFU67Z59uXT
 wMheXqm7YdmaYi1Ypv1xv1iMQ2WR5WmjTjcCI6+RbBSRiflrCt5FEVR6HOMK8xovmoNW
 qkGnM0jk35cBQ7KVQ1VXcgPKB+uCMBDqNfs8A9baQk9a37sgi6WfeHelHs9zQdqPbDAS
 6y0c+QpxMzktW1bCUzN5HyhNuyS1uf/LSTVvZmOdtgfhSEki1Ktpyl2X5BqmaAz64Mmf
 IK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EyQpzKbExiusE9kCIQBpIVjezDAJyYtoBUFbitbxGPw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Qm8gdG0K+Srx8ugSQ1cnPOXkj1NMSba0BZ/8RCIiKNLRPGcT1QeRwJuS5o/Se0i/+y
 GLqI1KiXCiCDZ37GJBnnQNsp9pcB0EnMAt9bcD4velSz7/EdpODTfYQgyQRyxCA4L3E0
 1KBC2iaUS/Ytl+7b+wwexYr6AddHXwoAk7EWwKnscpL7V5Ty7i+eEsGi0lKfN09q5GFs
 lMTCbBSZi3HY7xhXM3jYG1ITOvxjX0tveytDm1GbuchkMWR0EOkCkK5nKobf0B6+yUBu
 gnQ8AxQLmry1FXMQ6uX+SFrfIhF2xa6G+LiAYN4UDwBvOTLWGQyQboMZgW1TFvVSkKH2
 fCJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874598; x=1782479398; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EyQpzKbExiusE9kCIQBpIVjezDAJyYtoBUFbitbxGPw=;
 b=Ce2VGqpaBXgny4C0bd78E0tS32rt+jxLSlB3CUv3AJ/MaqWpyLp05LIXLfzQbOc8gM
 Iv9p83jtoaTx3BCwdHNgfc1S0Qa7h1hUk1NWKVKqNwvasL4oOrFlYzrgRwooIGrEsQJU
 ToRM/IbyP9Mc+2uJ58G/WGvw2L4TvN2ryxfJhH26aXqKr4dybEw1SYjFlZdI/+4ssYtg
 MO1n0McbpHzl8EjCbyPWrwbRqX0FfxGYJKYt7X1/7OQa+JJ7D0ifJKe8MfHoW9HDckdp
 HD8ibF9JfyhwwdPXZf7bUXFnTy+y/MSPSBIwI3u/3/WL6LmVOF2y79OYHwpbUmUSAP1B
 apoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874598; x=1782479398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyQpzKbExiusE9kCIQBpIVjezDAJyYtoBUFbitbxGPw=;
 b=pvtWhYpufLGNMuhvIGvUxbTVf3rhTVEJszOAiof87ucHgHImr0aehvkque1rVcMk6p
 aDgGeX8fitjcV5A9yf1w/xP/WXOToMMMg78E0ISVE1pVrWPv5eoCvjy08gR1dhd/t+98
 b/M2jxbeWrsBBH6dMVc4O1BpTytvqAHK1Kkz1JvGum/t/k3BGae+wNDCsyq6qUZFoADR
 xfeDAYmlXwVgHa3xC+gRg3ToUczM+qD7Gu8/hSzOoJrLAHolvNA+rdci/7NwJW4fG5P4
 wlDv9RVDptVUMfnOjJ5SCqWdQ1g9eJVLHjtnuYTv5kR3jRkMoMu2GdJjTlwdGTClZj8P
 3RXw==
X-Gm-Message-State: AOJu0Yx7rRwGt1sE4HjthO1nZldmIbNk5AysgtbMrBqC2NJ/CDkb1rAt
 Jvqhv2nWlRF2sz7e8qkTjVQSDeZsQQs3UBWoM8pnCb2RBlrmRLZCUlEoQTmS7RpkemdJIidfO9V
 LcD5RbfppIR/hFz5/k/W5kED3eNBelEAJdtTBCtTxWg==
X-Gm-Gg: AfdE7clmQ6hW3aayCbjGMX0eAC/U5UeYgSRrlNvNz3KYpA+srybaWNaCd2F+vgcLS61
 JKMRoM2FyEXKo1TA6+QygvPUigcgLWaEJV3EDgkVD4plukqcuKUgDeHPQV7rqgvNv/QOLq813y8
 fBM+szs4JOO6GkexmUtvk4Uj1Rs3Di+iUPg3FodQhujetUp8u7dVVZeI54vL3qBSbEmcPgtZxRj
 BtPRfUASfoY1rIhPGafNf9lPMNskZeUw+dkFlDpwQeBO4iuwwFJYs43RWendg/ruH3mKG7YXWfL
 PzfD+qK5CEJSPL5boyDSYeP043XMWuFojxvhQ8nR0dKjlYC8xVILDe1Cw9j7J6BKngs=
X-Received: by 2002:a53:b00a:0:b0:65d:bbff:41c6 with SMTP id
 956f58d0204a3-662fc91fe61mr3175084d50.24.1781874597917; Fri, 19 Jun 2026
 06:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-2-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:09:46 +0100
X-Gm-Features: AVVi8Ccb6l-CQdHhaUjZqhHvT30ukc7maVpMKHT8uD79ZRXahJADRAtmjGwHLlw
Message-ID: <CAFEAcA9xiMePa58V78LumvGgPNu92dMbGHvPQRQop5CAn8TzUQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] target/arm: Move tile_vslice_{index,
 offset} to vec_internal.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Thu, 18 Jun 2026 at 05:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move in preparation for being used outside sme_helper.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

