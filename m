Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C954BC0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 16:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tedBx-0004d6-BQ; Sun, 02 Feb 2025 11:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tedBc-0004Yc-I4
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:51:09 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tedBa-00070W-WE
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:51:08 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163b0c09afso60522905ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 08:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738515065; x=1739119865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hnFIu1VcGXuuuNoKPGv510zEbWbGUUZQhEJ0NAhaT4E=;
 b=gdEpioW9EeP2haJpm3eI2Vuc51CA8/gNViS12qTzA1b3ZWqQdAXNT/gBf6fHwBW+Xz
 zPqtmciTY+1WiccO2jWEt/Q9Yk1TXyBYMuW3pNQuR0E8n6ad6AX3WTOe3EUOPC5d9bKP
 WQx8PxH+xu55kAWczi/RuDDXP1ZjF4dFCv7maBNpVFban6ucGDvzTKHBsaUSlBCWElj0
 9dfXLMv11pJ58BSTmOYsCGG/YmpH+5xTsikAEbB23xYYQmMgjH6t65c+ZL07KGmpeTb9
 kJ35b0EgRFQ/kjZv1P254xnLYQenH9uQbpnymT1Or3jchIzE75Rvgx6u6hyIYO2MeiWx
 sp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738515065; x=1739119865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnFIu1VcGXuuuNoKPGv510zEbWbGUUZQhEJ0NAhaT4E=;
 b=ujkasV/aykved3qCTebMVRhxa1rlY5tB9XQP6TLyu0BlbkciUJm0nB/i1Z4aYe/ziJ
 URl9bqq+oGaJ707cXraaJyEifN+0w/sE+Ra4s1mfgjrv7Quw+7dHazWeLjV0iIbNtACi
 B/+FTdiJAURDlr1lphrNab07OQQqOiXPfzRoDXA0cfCZaRVedan9LUsL6j2u1Pxfpe/7
 f9Zj4jg6oZp9Gp6nq/KrkvxKEPo6fq5ZbHBzhvP46uXa6JfQ8wnsvib7sYbI0Gy3xGM7
 5oEMzhTVkzLpvbLLhYZzwNZqRsCjQ0kzcGSZCSaMNUmlMMI/Ta85D9zDXrb2WemZ9PBM
 UVUQ==
X-Gm-Message-State: AOJu0YwtqgXpAhfJVN5l0JwF+3W0qfow5OOaq2BIxWfjA05hMmiDtJxJ
 V8QulOJzoGk09SfHLAo15PQeEoGxES5aQOjjzre9Q8EyeCREa7852qIZ6E4WdDHHxc0mk9WrBIP
 X
X-Gm-Gg: ASbGncuL8oQ7bOvelRCuUc9M/823rr+iD4xga+ITaunGA3NzYqUUbkRx8EKlXDX/5RZ
 wMVzO3M3wHFjmlB7i/i5JUaGdnOSU0AZb2TiKwx4gDFl7VSwrnEkUc9JTtWd3Mt4I1tvps75+ps
 KH/Q6f3B97aS4JO47rgT7hWlUcPbPfx3tcCeMyovPEaoXUUcEyw2toaI0D0NiPEeHxFl0L+lg3Q
 sQ7AXoc8sewnrg9dCXD8DckxeZ3JCTakdVryV7r/mIK7qW3MFbVPVKCHP8XkOGhmY5EM3aWRMYY
 2BnDG0WQMkW14uoqvq9T+haba1qYTSamDXg0+lSOW19B+gy3xWMUKno=
X-Google-Smtp-Source: AGHT+IHI3zFycM497sNtdK+L6vLbtmphOOvP4gn3TSh91XCf1TfwUmCi+BuAmgpsBc3iEggyl6gtSQ==
X-Received: by 2002:a05:6a00:ac8:b0:72d:4d77:ccc with SMTP id
 d2e1a72fcca58-72fd0bf3b70mr26315099b3a.6.1738515065083; 
 Sun, 02 Feb 2025 08:51:05 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69cf267sm6929956b3a.147.2025.02.02.08.51.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 08:51:04 -0800 (PST)
Message-ID: <281a6120-d7e4-4607-87ba-9594b5c9c22f@linaro.org>
Date: Sun, 2 Feb 2025 08:51:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/69] target/arm: Define FPCR AH, FIZ, NEP bits
To: qemu-devel@nongnu.org
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
 <20250201164012.1660228-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250201164012.1660228-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/1/25 08:39, Peter Maydell wrote:
> The Armv8.7 FEAT_AFP feature defines three new control bits in
> the FPCR:
>   * FPCR.AH: "alternate floating point mode"; this changes floating
>     point behaviour in a variety of ways, including:
>      - the sign of a default NaN is 1, not 0
>      - if FPCR.FZ is also 1, denormals detected after rounding
>        with an unbounded exponent has been applied are flushed to zero
>      - FPCR.FZ does not cause denormalized inputs to be flushed to zero
>      - miscellaneous other corner-case behaviour changes
>   * FPCR.FIZ: flush denormalized numbers to zero on input for
>     most instructions
>   * FPCR.NEP: makes scalar SIMD operations merge the result with
>     higher vector elements in one of the source registers, instead
>     of zeroing the higher elements of the destination
> 
> This commit defines the new bits in the FPCR, and allows them to be
> read or written when FEAT_AFP is implemented.  Actual behaviour
> changes will be implemented in subsequent commits.
> 
> Note that these are the first FPCR bits which don't appear in the
> AArch32 FPSCR view of the register, and which share bit positions
> with FPSR bits.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h |  5 +++++
>   target/arm/cpu.h          |  3 +++
>   target/arm/vfp_helper.c   | 11 ++++++++---
>   3 files changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

