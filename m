Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF85C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2hW-0003W2-Jl; Sun, 26 Jan 2025 08:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2hU-0003Vg-7b
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:29:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2hR-0004Eq-3w
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:29:19 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso62187755ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737898155; x=1738502955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IPTBLcttobsWy21RwUh+XTunijYgyXBhrLQxors11og=;
 b=UMArb8onu5KSe1Ct3PelLffO3uvlew/sNrNc1MYfsSmYfRYQHTFVbXAd1LpM1VjF0r
 rrJoHW7cS42LEBqd3lJ5qHVPgDDh4MJimRwmuEpiQZcPHwV+oVQNUsb8E9DvGqAVzQ/b
 awYvL+XlP/eMl4KXxHtaeF3bCmrRym/EPhwUydyyf6SNZg30fsBvse0Ie9uhCFGdr/cW
 Z0iHcJqHOZEXSn/pJMO+pdDrlY5mu5ojwZj3kuMJj2QIEE5/0kvU7h/TsO/IygfBn/2w
 7t9TXx4ZVkVefNfkypJam44ZJ1a5iXk/IMf2Yh8XQtKLT6P6BFCY4DZU1NwU+mUhtRoW
 DKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737898155; x=1738502955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IPTBLcttobsWy21RwUh+XTunijYgyXBhrLQxors11og=;
 b=tPjzOD30FQzVKLuMULCLkExPOQIJBsTpvtVaNS7SxrR/jGvLTA2jKuzgoX/zdMdYzk
 AeBOVzsELJO3vHNbi63Vyqur81fLGM5ffTufXLXmHp8SZWsR8wz5pRXo6AIrJ4suh2+Q
 4yQkn/6rm+IVxnQZD1CtpTW70FxWZOiBLlorlk+goQlQ1rL+zMh5LYtSsmV7hbJSyxQt
 02NPdkpiCFwzCaOTtpQlVgGzqCspLfn185ppcEQkooNp/TwqEeY+rVXL4+PpWYUQwMxe
 uRCpcNjr0LMMqipGVzekg0ZivESTeWh2DW2+BNC+0GHg1eu5qrxAfJrSuaHTTEwp2c6E
 7PFQ==
X-Gm-Message-State: AOJu0YxCxrRzJIRVG6HesMBe5lzhzJXKA8Uf88xiAtyU50JbqndB4ark
 hXC02NG7aWB9pIjjfxUk66wiFU/3qPoyd+ixqvYXoAKTZS5E4aFzXeA6WqrQIL/f9kEBVM1T2bN
 8
X-Gm-Gg: ASbGncvUfco7Kh+k2gL+W+5x1bgnUmZzJBEhaGPoGyY5qyGDfVYHPgib7Q08LC4j4IZ
 kV01rctb8uAF80F0hXfW/ILc9K1/bGJtOhH1Rf0Z/bP+EsY77EP7yxTl71CCXmmJSSx6VVo/OB0
 Uwg7mNaRPeFR8iDPFjiIm820E6uL47IZHlw6HOH0AsdtSsWTSmLGgCKcqj36RJ8usL5AXIkmuMO
 MO1rJAK/yI/xThKzMiI3pncvFCpTRNZiHPKeYrfLXo/NN2NUsn8vLiMuN7uxqSjMsCBdtjRlrqo
 13ClJnswok8eZR8r3SxeMBI=
X-Google-Smtp-Source: AGHT+IGEFGYIt5PexMpfdxdy486JYaPFszmzHVn8pFJ2A8IHLxX37rFxdvFm8204VoULDGjDLiQo5Q==
X-Received: by 2002:a17:90b:50c3:b0:2ee:8aa7:94a0 with SMTP id
 98e67ed59e1d1-2f782d732e0mr46826768a91.32.1737898155576; 
 Sun, 26 Jan 2025 05:29:15 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa5700bsm5205518a91.17.2025.01.26.05.29.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:29:15 -0800 (PST)
Message-ID: <71a0a6d8-3736-4ae5-8f21-1fe5855e03c0@linaro.org>
Date: Sun, 26 Jan 2025 05:29:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 72/76] target/arm: Enable FEAT_RPRES for -cpu max
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-73-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-73-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
> Now the emulation is complete, we can enable FEAT_RPRES for the 'max'
> CPU type.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

