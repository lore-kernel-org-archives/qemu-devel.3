Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C9AC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjyU-0005zQ-Pu; Sat, 25 Jan 2025 12:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjyR-0005yl-SE
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:29:36 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjyP-0005Xg-Oh
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:29:34 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216634dd574so37788335ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737826172; x=1738430972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4SN+sfWnK2MT9AjVs+6GboebcgnFQGpnmol7mYWF9A8=;
 b=CTTXg4vloCLz2sZtmot2eo6/7ZCzwA4n2pi8Aaxa9sm5jE5K6Z+cC7JhRGy7OC2uBa
 /9vkaQt9m2ABFQUpmjXK3QVOqpzzod7/TassAbCk1yq0JGCTD0Xyk5HkgFrFYauvBSkM
 1XLY1cIXDQacg7mVcTHjKcrcb0yHz+2WKiVlMRAGdGPzl96r0wy4VHHwzbm8kKKaYdK7
 c5M1eoPc7yyCSAh42cv3ADY9TZuUZEy9BMQnVRTRd6Zpd7htXwsjX9D7DsiYNYK/9ZPt
 5Dft01C/vV16DbzkABGxEH6Cg5vKajiURDxcyRqH9n6m8oXS3hvnaiJen4hcDkx/4K2a
 vJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737826172; x=1738430972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4SN+sfWnK2MT9AjVs+6GboebcgnFQGpnmol7mYWF9A8=;
 b=ohFms1KRRlOahJhPO6+QUEr0W/nK+HcmHDhlsZAoOSk1e3PUcIAPR9NFtGZbO4vmes
 pJBZ//FE4ogbpUrFeMHObpUwdvJEe95AQ0cvJPiHPNKyg9K2cBwWnli0fZVAPHi+52Y9
 oZPZw8E8kvBrSU+kA0nXk9q3ub1TB7WT2THGmU/BYskuPXvyOqzFbplg7t97t52RyI5j
 E7vgGfXe1E38zl8W11AdmIYVtfxnpZ+EBkiJXuPWp45sNR/ZUkSMvwlZsnyE3aCvt0HT
 kcpTjQTyzWfDhqGKDpGZ16c6jKlNLNX1Z1oc3n5Nd4IoN3OyOoMBeooe8f9I0NvQ3Qrv
 eCoA==
X-Gm-Message-State: AOJu0YzUYL1p9s01PfIuVT3mth43gw+gOzj8sIylODoDLT+W4f8gW9IJ
 NzYAO3oRNkHWSVmRASOXDUWP8XkX31fhQjBBrAK3et79A/yoFpuW3/ojug2L++oKVCMLUHhw90G
 5
X-Gm-Gg: ASbGnctFnD/TVJwExTMNWRcck9SNarp45eDgtO84uYWwn0wsvpnLzAGWODKHBtfiuBf
 yM3GduGIFlztr4WgZSP93Ka84Sa3w3vEmxkIyr8iNp47zb6k2TgycZmaTzR8fOsKziJAX3nuHf2
 vA6wqJUlNnp9fZNFRJLpImLbjjxwwwU9cH2JRz9mGkzsuxR7q7+GMQ9V97no2kEx4QX4WznsYuJ
 QJ9LNt4SyyNO+RmmwvyYRZ3pcRpWZKXZ9TWfAMl1S+xLwq+HYuuTBF3XZUi98cems/MC/gGXGTl
 x1UfIi9P8me/EQvxw6sYpw==
X-Google-Smtp-Source: AGHT+IEx7vz4/qiIPvI88VDe+fCHuDlKwsM3dS2DHZtIPTFQZcoSesDmFoF1upWyQ+zyvJTXEfEPTQ==
X-Received: by 2002:a17:902:f68e:b0:21c:17b2:d345 with SMTP id
 d9443c01a7336-21c351bd47amr421319165ad.3.1737826172309; 
 Sat, 25 Jan 2025 09:29:32 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414cc20sm34890705ad.165.2025.01.25.09.29.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:29:31 -0800 (PST)
Message-ID: <63ad1ebf-03c0-4bca-b0a9-b70234bea00c@linaro.org>
Date: Sat, 25 Jan 2025 09:29:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/76] target/arm: Adjust exception flag handling for AH =
 1
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-31-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-31-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> When FPCR.AH = 1, some of the cumulative exception flags in the FPSR
> behave slightly differently for A64 operations:
>   * IDC is set when a denormal input is used without flushing
>   * IXC (Inexact) is set when an output denormal is flushed to zero
> 
> Update vfp_get_fpsr_from_host() to do this.
> 
> Note that because half-precision operations never set IDC, we now
> need to add float_flag_input_denormal_used to the set we mask out of
> fp_status_f16_a64.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

