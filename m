Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120CAC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Ys-0008F6-KU; Sun, 26 Jan 2025 08:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Yp-0008Cq-Sh
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:20:24 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Yo-000348-Ed
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:20:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2163dc5155fso62014185ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897621; x=1738502421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P4V94JWlnJ1+dGXpuLflnL5WbeiUkrgcq67G95XX+sQ=;
 b=BrF4s6KfhTazqmGcRKbtUrkuAbX25fqGvQZCKlXVmX4gB9106F2h1o77uT1Wmzr9Tx
 UyLL+Hd6wlhTwLRSUpojVCyCE+WpbO3wPowNVmikoE3JzYo8fTIhV7AMRi4JvtcWindo
 clL+u1ZkBwx+PKljztBYaEo64mqAufKRFi139G29ZGYQrKlGtzl4T6RjzO/0BPTdzkVN
 KZjMDyeDPaQSt55Nj8UTvKtEU5m2CifBjxql9Z3rrmlpR1Rx1cmv1LZjggVTT4vmurPA
 jGcrjlHTGCkPz54NYA4mTh9tMXQ9vnV1o2kP1S6bd6NOYd1Pb/h1LI5lEwelUFqE/3hq
 UMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897621; x=1738502421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P4V94JWlnJ1+dGXpuLflnL5WbeiUkrgcq67G95XX+sQ=;
 b=RLi4x07V6FUW6c046mQ+/gSddboqZFZ7GRxobM4BoJP6IeDbVCwxKRDNGheTo7Q6Bj
 69b+OC4ExstZT13ETUXnlFb7RMuv5RSEnUxlEOYubW+l4pHHwY3JUjQmAsvVFq7p77lm
 bbZx3Y/xiguFY5i/ivtkfPu2VL+ePjj6MM2QaLn8gQZ+PeCPGT2iKS4HgGohxpIu3nw4
 jr/25Cf6li+xkup0YtRPMF0W7POiFbSQGukjX+nQSk0D6wijC8zFIkLittn2J7AopxrZ
 EX03dwfbMgGOAbDzye9iweldrTBZHpvMl9Jh1rpnwSuXmqW9jzZpMwh4cNQl46CmnlKW
 qweQ==
X-Gm-Message-State: AOJu0YwSuZgYyNmUqc5lUj7QygTYmxx2Ve88TcPP9R4+3G56nsUkzlV0
 MBZF/r4FlgXg4xn+1dClNnP+0srul6bChsXurYP+UE2vRMZ12/ddAIt3EKjSxMsSGAkKq7ey+Lv
 m
X-Gm-Gg: ASbGncvo/9h4NQIb7R+0Up0CHbgpbduSr0T0SqurERjcJN+sPhYadahsIrM0/eUDVhi
 sWVHxhCk4e5WYZrhA9Cbu4nz8LdXK+fXe3g0avR1PIpIJCWh/M/jLeJw/dfIZar2+goaYn5EP+V
 /sGmfajaymyrq3XMXTM+TCEYp+A/F/EkeLUZoNv+YJl6ir1PY8NUipFB8NgMhGo4zOfUxnq+j9O
 WX92jBR4v3G+hRe5Wekj96rPn0LxtxhTi5rv1thtwedXORhiYRbViHJ5u7fwJJlZlADCu/agMIt
 wl6a2texKTUDmhN6ywcLFss=
X-Google-Smtp-Source: AGHT+IE031xGuyh+TogflPJfomVtIFUeSWdG483dq6R/NCpWsV8+mmne7j7qc7LrAngo8h9b+syeFA==
X-Received: by 2002:a05:6a00:3a11:b0:728:e52b:1cc9 with SMTP id
 d2e1a72fcca58-72dafb35f9amr57599454b3a.18.1737897620966; 
 Sun, 26 Jan 2025 05:20:20 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a7608b1sm5145391b3a.116.2025.01.26.05.20.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:20:20 -0800 (PST)
Message-ID: <6a944080-7d4a-400e-bb9a-aecedf0caa48@linaro.org>
Date: Sun, 26 Jan 2025 05:20:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 66/76] target/arm: Handle FPCR.AH in SVE FTSSEL
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-67-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-67-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> The negation step in the SVE FTSSEL insn mustn't negate a NaN when
> FPCR.AH is set.  Pass FPCR.AH to the helper via the SIMD data field
> and use that to determine whether to do the negation.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sve_helper.c    | 18 +++++++++++++++---
>   target/arm/tcg/translate-sve.c |  4 ++--
>   2 files changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

