Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB23C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 20:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcVuv-0003AE-5N; Mon, 27 Jan 2025 15:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcVut-0003A2-M3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:41:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcVur-0004fH-Fc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:41:07 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2161eb95317so86455415ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738010463; x=1738615263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=70jgPy2Z/QYdI3UgWuImziCNXeNrQV3FgGpgfywprkY=;
 b=S5QadgUTgeFUzOgDyovH3X4mqiKlpa4ssICh8kBi/ZlR6iLdeF5lYcpSxmQMevLhB+
 nO7EEfvijMuDDCttmBbS+0XBEjds9yh2synbpC7a0KKXF4CBDDKc+VSr4LTEUbVhcN6J
 4kYVVzpc/ZO81KhW+efPCKq5PQ5JshQQAfPbT1Z3BaLHlSYKgvU8iUyj0WdKZtldspn6
 AMqInEMwTV1uy9BXEy00OvSToViOYRpa8W1CAPFn7yB87GnR9qcEYPOE6GIku1SKv9sq
 b3Qirl0BnbHaiTvQNT/Rqaajz7DJvW50J7DAadD0yk8eveUDPasEXoTNtU8yMg5vbNUp
 7urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738010463; x=1738615263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70jgPy2Z/QYdI3UgWuImziCNXeNrQV3FgGpgfywprkY=;
 b=SvNNWKO9NUIKpQandYDSEbj+SYRpp/zG57ShEjbK8T62WuOxXUMB3z4Fop/1db8NZC
 +a1tNRSeD0EgkS6n4Qg6byMYbpwUyKKEahhbeOwOa3rU5uDgePbD4n4MBQHqSBZuzHoT
 J7nbdE0Tdmr3ee6jx8/+bFVcIy2B6i37Vndih/hI7BG0CwqNWR6dxoawnmcw+SFqEivn
 EWQxfXlkp713RaDJZDHLBCMjlMuk7s8LHVJx3adnCwOYMtzCTQOnKwG/KsZvJvYx9hdU
 tGBTFp3KqnF8OrnTHAlIHt6wlQUYRG4omXTiINvUwMqJ6DLAW5bp51j7rPr0Uw3Dpl6i
 7Flg==
X-Gm-Message-State: AOJu0YznhmS3nBf3e2ebzFtbmiIYX08fnulL4hnRSw0kxYqhEfqYuuGG
 RxGULbbyVAE1U3B23mu+cwuCPlcjFUZq9G1d05QwtIQ0Pv3zSB73rEfIgWxRqCeO/7aYn5wv8L0
 a
X-Gm-Gg: ASbGncu84GWOipblYPELaHI+NrWDfwErEUoNT4JHct6OiILjNae0QGpQGeziqcMQCud
 qcs8F+faHHvfSURWWsIGJi6wDWlr3fFimpR/U6QmTryZpSQ+rD6x83bbEX/Tc0nHeANNLiwYZTZ
 AfQQkOG9DP8Bx5kWu+kDWbv0h2VHpTzq+4CkA+2MMNmCljw1auKNl4G4rnTAtYrV7n3/3/QCqN6
 wp4EB9eZy5dLrmSPVoL9QCg6IyY0cs+soPRSGhW5/n50kq8LQEuEaBcm9U+8uZUTnzNIQk5LYe6
 rFMTo/Bwo0ysfZVf28PhwgnmZXuMQJ7AGowO5MCX2/szrC8=
X-Google-Smtp-Source: AGHT+IFszxTwgxInFmGikM99x4HAs1lqNp5kZBCT0UmBxgqNGvTYuZ5wdM4Mvu7BouB9LOeD9BxEkA==
X-Received: by 2002:a05:6a20:6a82:b0:1e0:d8c1:cfe2 with SMTP id
 adf61e73a8af0-1eb2158ef4dmr62109833637.34.1738010461818; 
 Mon, 27 Jan 2025 12:41:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48f898107sm6908519a12.31.2025.01.27.12.41.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 12:41:01 -0800 (PST)
Message-ID: <0e8eeee3-62d4-4c4c-9145-26983e0691d7@linaro.org>
Date: Mon, 27 Jan 2025 12:41:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/76] target/arm: Handle FPCR.AH in negation step in SVE
 FMLS (vector)
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-66-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-66-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> @@ -4910,9 +4958,15 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
>               if (likely((pg >> (i & 63)) & 1)) {
>                   float64 e1, e2, e3, r;
>   
> -                e1 = *(uint64_t *)(vn + i) ^ neg1;
> +                e1 = *(uint64_t *)(vn + i);
>                   e2 = *(uint64_t *)(vm + i);
> -                e3 = *(uint64_t *)(va + i) ^ neg3;
> +                e3 = *(uint64_t *)(va + i);
> +                if (neg1 && !(fpcr_ah && float64_is_any_nan(e1))) {
> +                    e1 ^= neg1;
> +                }
> +                if (neg3 && !(fpcr_ah && float64_is_any_nan(e3))) {
> +                    e3 ^= neg3;
> +                }
>                   r = float64_muladd(e1, e2, e3, 0, status);

It occurs to me that with AH=1, we can use the float_muladd_* flags.
We couldn't use those for AH=0, because there we *need* to negate NaNs.


r~

