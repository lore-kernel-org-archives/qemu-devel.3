Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C345FC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjzb-0006qu-Ov; Sat, 25 Jan 2025 12:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjzZ-0006oh-Vx
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:30:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjzY-000642-D0
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:30:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2164b662090so60583055ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737826243; x=1738431043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e1kvS8LY+a+JPrlXdGCZI5Bd4VjjuTxHfPfZ0ZvMK+E=;
 b=TdmaPJSbWTODMTWDF6N23VLoGr4+oQXIfCYFWtKHMtenDAL4nL3KEjLQ6Vd20n5dOf
 /8LYLPQSEZpHKssPmRnEJdYYShWhb63oIWLjVCyhrMLvs2dynwdJP5cvNx+kxx2+cyWt
 /1wT+MQfme8K/wwuWF07buEocvlvtXha8FvSkVuJNk4fgq8B0HhbAxm2AJInK0xgOIWu
 +vaATuH0lH5aUjVf9MXi6+pjWfd+e77Le7v1AhiHkwNagEYsG5R+R3xSoGL5jM59gxy7
 XKEUsrKE5FNtuV/AqgfslC/WyUFS+U275Dl4au4soTGUIjDGmatmsHrfQCTdzTH7ida4
 UzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737826243; x=1738431043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e1kvS8LY+a+JPrlXdGCZI5Bd4VjjuTxHfPfZ0ZvMK+E=;
 b=TLnc2hRgIwcB3orRWYQnksQgF8BqTqPQQ8vcZNf7eJvcnLzNBBJuX4LXxQoOze86ug
 oY/eGUbQiVZky0Tz5uNH3KqKms6IvEe0apnc9R4I3xxWbyyVPF9rtsB/CGWSTKOOj/9d
 0FeYur2Zps+eptLPmg9iSR+y847u1xbgNAeTMPB3L8svR1zDvqdyHzJXYMKpyptQAHuZ
 XWKEwFE4FTqkarUe73STX6lk4dv++5w8ABeeqrnM6ios+5l7f26VzSTDfPhH8/G8gpxO
 H6EVJcnQr+kIEk4f8eOzDlIbbtvIM5oOb5LqwfO/4UzWQRty3p0yBabbErlZQlykaz1I
 kz9w==
X-Gm-Message-State: AOJu0YyQiCRzvuyEBHAuoAToBUSMFFI6G36N/Sa4DvuxsnMaCC+d5Bd2
 zvnFoLKtHRJK6jPkibOT0hdlT4DZRkTqCg+d4zKpf/hUAVNWdCPOKua3OC4C8RMfDnJZmrYXBpk
 o
X-Gm-Gg: ASbGnctx2/iDh6javngAroy++lGFybNKiQWJqZIeZtpuZlYtqyqsa10uM4W01ZJs8kz
 PLE41trBVt4JnzNXyjUjyroBcEWp/+c+jWZ9fUfXqOqoaxRgSSGSEVB4eS4YH6W2MyrloZkPWMi
 h2wnre5nV20g2DyVpMJzaBFN1bCFtqfxe5Qd9peg2+qHbiIhPRkC1f/SBVpL4QZHVa/Vqj2MEoO
 enWkEyr0btRfFb8XNq0eU2xx1WU81l8uTLRP/yVQAmcaGIRe3fe3PMwfM+VvbonqTeD3fgXRn7l
 0ps5lkWeKmr0E5vCbU+JPA==
X-Google-Smtp-Source: AGHT+IEwOnBL8a7Auh8KW7+Bhk154Jmf4n3aIbv6vEsijQ73S9NyMAbNM5JJvya0zVOrrVglYfxwmQ==
X-Received: by 2002:a05:6a00:2382:b0:725:ef4b:de28 with SMTP id
 d2e1a72fcca58-72dafb365b8mr45148182b3a.17.1737826243085; 
 Sat, 25 Jan 2025 09:30:43 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78ee97sm3946830b3a.166.2025.01.25.09.30.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:30:42 -0800 (PST)
Message-ID: <06047146-5018-45ef-94f2-f2775d9d85f0@linaro.org>
Date: Sat, 25 Jan 2025 09:30:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/76] target/arm: Add FPCR.AH to tbflags
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-32-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-32-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
> We are going to need to generate different code in some cases when
> FPCR.AH is 1.  For example:
>   * Floating point neg and abs must not flip the sign bit of NaNs
>   * some insns (FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS, and various
>     BFCVT and BFM bfloat16 ops) need to use a different float_status
>     to the usual one
> 
> Encode FPCR.AH into the A64 tbflags, so we can refer to it at
> translate time.
> 
> Because we now have a bit in FPCR that affects codegen, we can't mark
> the AArch64 FPCR register as being SUPPRESS_TB_END any more; writes
> to it will now end the TB and trigger a regeneration of hflags.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h               | 1 +
>   target/arm/tcg/translate.h     | 2 ++
>   target/arm/helper.c            | 2 +-
>   target/arm/tcg/hflags.c        | 4 ++++
>   target/arm/tcg/translate-a64.c | 1 +
>   5 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

