Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62078C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZhN-0003ez-CM; Tue, 30 Jun 2026 10:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1weZhL-0003e8-TD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:44:27 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1weZhK-0005WU-Ex
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:44:27 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-37d70036426so2148410a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782830665; x=1783435465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1oaq69YHpeBKD8kDAPf/6A0v+jb3TVwS2/YK35XUKhY=;
 b=ZBXLmCQv9xjZJBzGzNG0+fFqqe48QrFnjrw05k+GzT71UqS13mxEccwBq091pghb2Y
 gKiw3hF0oQfW9A4l2CBbKBN1dDXG4calEziCbW1ztGRD/OgPeyLG924dzeZQyXXwMgK7
 cAi8sFFE/SmvAY6bDiDHUnDVS6uBmUL107x+9xCBpV3MErN8Ypz8uprsxN0zsxf9o4GF
 BKBioTwfLTMp4jbQpfJyaBzkhwLzWEKDLCsBt1ilTfznhIootuLPot+cpnw7CQsCnvMd
 mxi4pli1q1za5CrhOZUp9U3Cf8uR4AEx6Mc7jdk3WBM9MxRvmSZWASGv7egm5AkdnaRO
 TGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830665; x=1783435465;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1oaq69YHpeBKD8kDAPf/6A0v+jb3TVwS2/YK35XUKhY=;
 b=sjDNe7+bhFzLIjW0HvRLgbAV/4f+0Vfy84E/tO1J7haFrRaxF8w2EnTqBxH42G/5dv
 wMMsSL6qB4GKSQqahYF0mTcEVJnMuOy6oujU5EyYYb+ZL1D7lTe4WrhTqDbecinGZcy7
 qpWSDS1MwqP0z93x/5BIo/SNmereZ6G6mqoBPwBIjgOx/pBGrhSzQLW87xCyBRvmQKQ1
 BaPeOJ+ntB67ZwJzIHYEcb/1nn0gOPx0cVrneGJqSm7Czf3VCTEYTlUnkHorYqx2JAia
 2E1/l/GdvVljk0dU2RWH8V+P+cpxdtc2jFBwOdFA0ZV2GL9WNut/M6BwIzZqC9xDG0YE
 TQMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCorE5WCPM4p88btxv4YS0i+eA/+PgWuKC+xSsq04Ix532sI69r2WW1c0B+4iXHDCHYuSS8gje7kgQ@nongnu.org
X-Gm-Message-State: AOJu0YxpSUHB+hj75EmjzO88yBsRVRBIp7qnauHcZt5v0pr0hL2h0Owp
 61Me8aFrLzB3BeWLul+0uAYe9INU//1m3Pro5mEbTUBWaxHjooQ7X5cE2wq50wWsHmw=
X-Gm-Gg: AfdE7cnQOcmHuD72bn55l1s6YdZwuMyABAEk7h0YmumF15qZshvj3PZq3gvCIzNm4vp
 gnp5Jp6SXpfQG8/WxVimnWSRFXmWxpKKMAOge4LJAleFYrNRL3nAVVVoPbWt7gUO6zY3Q820kQD
 IenupzVdl8PlPnbSU4eh7gCmvs7xjRyC9uKT7prFYaT/MGzco+/jdcQQqcaVRIF9urA/NTS7750
 W4CKTjbiiChIEJOJp2VDXXKrvVJS8bH3yy0mrG4hEeLp3Kloqjj7HuMKyvjwMAhgJkqgsWTpPEI
 3m2B9Txj7BqqhBxmDZrQZgd3V2L+8uqjrw/eSZqzcKcoKt5F1eVaRpifW3uSnsB4LhDDNy4pGGz
 6nYBcO1+nguF74vRQNzK7z+aL5lx54cMujFcNwsOE+HN7NUbCY+NqV0AkpzfMnlFhGAs9fziZ7Z
 UxThZwsq+v79G68+tWBHRZONmWossmmq4KsKioRI+CGmmfvrN6emQwTgvv0w==
X-Received: by 2002:a17:90b:3cc7:b0:37f:d27f:5186 with SMTP id
 98e67ed59e1d1-38052758d53mr2938853a91.25.1782830664651; 
 Tue, 30 Jun 2026 07:44:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095d29965sm1249a91.1.2026.06.30.07.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 07:44:24 -0700 (PDT)
Message-ID: <09e8110a-0d39-4333-85f0-908ccc64c92f@linaro.org>
Date: Tue, 30 Jun 2026 07:44:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] target/arm/tcg: Implement new instructions for
 FPRCVT
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alex Bennee <alex.bennee@linaro.org>
References: <20260630-jmac-fprcvt-v3-0-f4840d5e0a7f@linaro.org>
 <20260630-jmac-fprcvt-v3-1-f4840d5e0a7f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630-jmac-fprcvt-v3-1-f4840d5e0a7f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 6/30/26 06:16, Jim MacArthur wrote:
> Adds the opcode format for the SIMD versions of FCVTXX and [US]CVTF.
> These use very similar logic to the FP-to-general and general-to-FP
> register versions which exist, but use another SIMD/FP register
> as source or destination. The source and destination size rules are
> slightly different.
> 
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h      |  5 +++
>   target/arm/tcg/a64.decode      | 15 ++++++++
>   target/arm/tcg/translate-a64.c | 83 ++++++++++++++++++++++++++++--------------
>   3 files changed, 76 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

