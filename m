Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814ABC83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 22:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uctHb-0000cr-4K; Fri, 18 Jul 2025 18:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsn0-0006DN-8q
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:38:46 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsmy-00062Y-MS
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:38:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b350704f506so2177061a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752874723; x=1753479523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NRfWVhKnyB1HSmXC6npdGvPwbFR81eqtzCrl0rkYyHg=;
 b=zXmiixc6JoD494ZpyBb2JMsEWMuMIiZjuZlc+AWnML6nmHqVQy7YXUxivsUTL/Cpis
 xOavvaNY9bNA48IG9v3jP05t07epOhERm3K4B4qAwURYVAnY0LBMuUkRiaA3BzBUPh18
 LLtky+yCls/Nm2bh8h6xAekbfcRMTZIR6IY+YAmn0MbfuIU6DfZ/UHkgLuMq3ciLnSLs
 FUaFR2p3iI8I9/TZwcuHy5rfcwQElkXMtn2jG+VZfrqzAwqNNEO/D8bQlTJYNFR/iJvk
 wxGwB2lJE2tZSEPFf8PiVrcmKnBnYzDU3jR2ivQH5qh0ftXyZNxIuJz9VsX9AF6d0rF8
 pFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752874723; x=1753479523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRfWVhKnyB1HSmXC6npdGvPwbFR81eqtzCrl0rkYyHg=;
 b=WUpNw0LEJMsdDRDrzChQ1PFZ//k7xCu0DMWnDc69zYpw2+ZpaSpcNKJOQ8X0sk4Ssb
 vJbzCbY2WGYSWRgm+DzK2yEGXwSGuHp7aj71ZCth0dTVODGRoqYB/xtz5xbkGCW0GLOG
 Bdstwb6gfZmno/reuLd9KQfD+/nvoMbOJEMyKbC16rb0O4r2bPV3m9iPrh0z5POQz1cj
 u7XPnInSaA3WhfrtVWgBMsfIuVsMyBNXtyVf8Dmcvjfa49s+BsYf2ITFTffmNQZAiDAO
 +eLdX+vdTaYvYphs02VkPdvPFpFwederdAfw5JyGTEAuxQLQOGSiWCioozZ3Tg3xP3aU
 9y7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/W75yzc/lks0Qb5l0tJIJyt/Ty76SaQHa+rqQkAyAIJt5BukHL1r/c6C+Fv5wVHDYCzB7eh9URUW1@nongnu.org
X-Gm-Message-State: AOJu0Yzr3a2voiYfd5I2jH3GUeFfAff7ClgDPrbWXzSHAu1m845FL1fD
 1F2yQ5IRj8Xdq3s8flU5fWeKvLXy+4xjLDFY9eE6RR9VjkztAHqOQcBW+MAiX4H4bpCsgwLge9T
 G8Ch3
X-Gm-Gg: ASbGncs1UyCIfXZmo6UqsEcH/ojJu8F3+yt20YfeYsI27imSeLg01qza+Mi63p8kXbR
 r1dC9a2wIrX2qgyjWBwYNuFlOZQxRUwf7lBg9m2dDqigw0Hgjpbam/shxq+NS6Q5z1JahIGEkr0
 JeHEWfR8wU52ZY+pzHvZKv4MTY5KUzWnbNSLdv1R6hWbxPQ4juZ5cQLucGevVYK6DPk2RX6lRcG
 v1OYwhCpBGbeuNN+TeOJxgfMvs1xh2+hHAGv4gF46s3/B3fxI6c4RXiOzOcsGCpcYrDtDS7YyFS
 XBxQi9dc0erA5py2Tex9NHbPZiHnZArbU9nidd5PqBfUrn1dVizP8Te+wODclq0YE9pE6v1B8Yk
 R7gj9nGMUCneR4zGzZAGZkUyKMX0fr72Z9rSx7O1V4w==
X-Google-Smtp-Source: AGHT+IEueRLFbC+ERyhOPVI+MGq4YykPSHcuJTvZd4m6X1Nz3fK0d/wkK5Wca7Qdt9Yn6fD6u3xSAQ==
X-Received: by 2002:a05:6a20:9186:b0:1f3:20be:c18a with SMTP id
 adf61e73a8af0-2390c79a037mr13437569637.10.1752874723079; 
 Fri, 18 Jul 2025 14:38:43 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c84e2175sm1738216b3a.1.2025.07.18.14.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:38:42 -0700 (PDT)
Message-ID: <c7398952-a030-49c9-9455-5602cbdd2e21@linaro.org>
Date: Fri, 18 Jul 2025 14:38:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 04/10] target/arm: Add BFMUL (indexed)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250718173032.2498900-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 7/18/25 10:30, Peter Maydell wrote:
> FEAT_SVE_B16B16 adds a bfloat16 version of the FMUL insn in the
> floating-point multiply (indexed) instruction group. The encoding
> is slightly bespoke; in our implementation we use MO_8 to indicate
> bfloat16, as with the other B16B16 insns.
> 
> Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper.h        | 2 ++
>   target/arm/tcg/sve.decode      | 1 +
>   target/arm/tcg/translate-sve.c | 2 +-
>   target/arm/tcg/vec_helper.c    | 1 +
>   4 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

