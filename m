Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA113C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5cE-0006fV-4U; Mon, 17 Feb 2025 13:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5cC-0006f7-5f
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:13:08 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5c8-0006Jg-C2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:13:07 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-221057b6ac4so34298165ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739815982; x=1740420782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MumVYAqw8hG2ePHGTquJb8dqbtWe+33qkK+LWjfDdVg=;
 b=JysZhXjmfIgxtB49ZbmZQVGuG6KufXp/f456rtIzlpgJUXBmC+z2oXGv87BmBUj/Zb
 ACbRYeQokexlhhkI+NWlXC7E6I+g6s/o77AYmzL9kq78UZ2EIxOLAjGqarwPwyrbuCAu
 dPR4Vn5KYO4ZWtQFjaodKEjteBzLbtNXs3SKM/o+h9eKFwR5Swf3aqSs6kzBeCQjHZre
 5Gx7gjb/4B9tyLK68R2EwK+j7jEZpeTO/fE/B9JJFrgQ6y5BSY6xIBubX7KUOLw7L8A8
 rJO4csjSwIBaIJNJCTcE6GI2SNmcGh3JhZTV9ic2NqVPp1KNm5ezSw2/fXVRurxpG3Aa
 YnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739815982; x=1740420782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MumVYAqw8hG2ePHGTquJb8dqbtWe+33qkK+LWjfDdVg=;
 b=XqsWdfBs2imVZ/WDUc1AdPLjgIBr8svvrS1H6FPYMmssX8rn/HwkXNh7o5DxD1bhd0
 pwDTJP4w3odGuWcRtrYQApeItMaTsGLSbflmrwP7BCjxbhEAythpfXsdTtr/eAnlvgub
 Wt1sFQgU3RCqmrmtNhgcFOGVrV8ItZbhVHvK4O+1njXJc6JXS0fOapK1s1H13v7mR3Vq
 T1TNeq1od29mTgv2J5ftXVP0b+3GiQ22Jnik8FVncC44tMAwcReq/kX7Nq5aXBJlZup7
 vpSzMqEm4iok/Rm4TCiA9H2Hs55rk3aX2sCfoUk71+ciVFZt9R+osUsnUjNg46aux/h3
 LBOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjcYqQEX2StKgQL/uhsnbDI6iYN0+0I6Ebu3bTIL9nk3embYcPy0D10RWwzmXaRosqGyGOQkjpe3UH@nongnu.org
X-Gm-Message-State: AOJu0YysmtCNRFGD8YHJfRPcLDRwjzyz3N2XevlBkmpvG9FoKXN+l2j+
 VK7CaHu0UxI336RBwfNqhZ+qNZnqMyPxGHaTJTpxqL7txJHxZJJZjJTD4VWQvT8=
X-Gm-Gg: ASbGncu8F2InahZf0jCR520zOf07mJjWi6Bgo4A5VqcXhEmvtQhHrvlDAXKl+bGcu7K
 troKlcbHC9y/6MaIAbvdvwflhv9NYsKxN6CQrCuSPYHYiB3+sWKhSDe0lhw81MHh9gPJXytdc0S
 tRWOnt7ZXPvoFwUDs6PrLWTDcPF9wMpn8YDblAlrAJNOTKQKoaRuADlrZPyU8IuHJor8CwWuT8r
 qwncbgkbJ27plf2YKxgN/reYcAQjUB8hIFQ4RmmOMYosbfTUfEx0ZgVWRBQ4jZLSuHoCCqlAtZU
 DNongKLJGXXjWUAsmZLDUKktYz0e35Xm2KLcBINlV9Sjxl8vtxLWm/M=
X-Google-Smtp-Source: AGHT+IEHqivoQ2h4oI5HCAYdJcZQatAGwdTyYBRbomnGlZ8Fxuq9kK85PlKvtSUWbGPjnTtoFDTrng==
X-Received: by 2002:a05:6a00:1882:b0:730:957d:a80f with SMTP id
 d2e1a72fcca58-7326177625dmr18516465b3a.2.1739815982666; 
 Mon, 17 Feb 2025 10:13:02 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242761962sm8789458b3a.135.2025.02.17.10.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:13:02 -0800 (PST)
Message-ID: <f6708ee2-74e1-4ea3-9fa7-ca4d43ad7e36@linaro.org>
Date: Mon, 17 Feb 2025 10:13:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] fpu: Make targets specify whether floatx80 Inf can
 have Int bit clear
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/17/25 04:50, Peter Maydell wrote:
> In Intel terminology, a floatx80 Infinity with the explicit integer
> bit clear is a "pseudo-infinity"; for x86 these are not valid
> infinity values.  m68k is looser and does not care whether the
> Integer bit is set or clear in an infinity.
> 
> Move this setting to runtime rather than using an ifdef in
> floatx80_is_infinity().  (This requires us to pass in the
> float_status to that function now.)
> 
> Since this was the last use of the floatx80_infinity global constant,
> we remove it and its definition here.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h  |  5 +++++
>   include/fpu/softfloat.h        | 20 ++++++++++++--------
>   target/i386/tcg/fpu_helper.c   | 20 +++++++++++---------
>   target/m68k/cpu.c              |  4 +++-
>   target/m68k/fpu_helper.c       |  2 +-
>   fpu/softfloat-specialize.c.inc | 10 ----------
>   6 files changed, 32 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

