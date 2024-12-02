Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2772D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6oQ-0007Ou-5r; Mon, 02 Dec 2024 08:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI6oN-0007MH-ND
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:50:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI6oM-0007ZJ-0K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:50:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a95095efso30667485e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733147400; x=1733752200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rmX0g0MGNNVbRpmpyn/uwOzxAYd3z26y3Y9icJ1a8Uc=;
 b=iN3QzQWbBcF63G7XLudAmwBnaSYvoQNur8FOyPP6Ni2GVbZQNfSlgJAq3whf1MiZ+v
 3OxYFak2C/RRIHCrDwsZ4pWmi08Vgtt+JOZ5SrRxseO20AXl9vc8a0Rue7SJtnTBFkRj
 GKeJeDQb0dapHUjP9zGLcT/B5tkd6+pkTLgk/JwCtgmQ4wmdwznWn9ogKC9m70DNuadz
 DIhno0lNlX3WmQaJov+zZ/d+vDy2MEp6wJKPAY6V1wHfcHS0dpdRlCjgGqMOdGSYllgr
 wZs4r9LeXzBbbM/8VzmoQmc9YmGYTMZyckNl9f6+h5lZFV1T5fDCvLDkOixhbCwAgOye
 oiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733147400; x=1733752200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rmX0g0MGNNVbRpmpyn/uwOzxAYd3z26y3Y9icJ1a8Uc=;
 b=Lw4r8MtcjjD/8zcpogYNc+Zy7EGKAVvFISA3J7LCFjjPkP8uAZ/1WZUMxSxCMBOztj
 R40UJ7y+z3hDnVVnLG31LsfjOzPfjT7oX5T6uqXJbS63bIEXpc1oNEyn2vF3RPwvFvAp
 PUG7UjMqzbUb6kYq17NG6oUenIa5pClnF+q1UJZUUKecgoe+O8VJaKLpzx58J9pXQvzk
 CVCpAP9sUBJ/CEpHojtaK9lBnAIbA7CmBrcafdBWfc+vMcKZBshrDkk8DS9S+Lp7ygS0
 WhHH/TiGoVMe9txG6Usb/AbA0bdG/H/ijkpbXhHW0ypbryTv59PbiL2BNfASg8Pvb11K
 Fk+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0aS/3BiM4l4wOrVWamgydcqMbLSHecLodQ+hEOtIKUwnAkWdCICza5XJU9G+odfMV87UsfzHOP1/n@nongnu.org
X-Gm-Message-State: AOJu0YwUCigDvSaexHhErYQpOEvOdC4JZzaP2qlp/qNolRcWwe/cjA/h
 ZC9NJ2X5H/E+zvt9/Uq/YYbHoSw0OzeEeBCgmHxLh1PfyXvtP1X4zJvbK979apc=
X-Gm-Gg: ASbGncu2T9JYajOaO3vQhQo85Z9HfUML4ak7wRHnudh6dVJKN22lBhRDymROXqNPmnM
 lVUsa/NFHz+PZ7+aEeI++C6evuo3rV/BdiuxL8+LlKQ9BAf68a+0aawYFjdJhH3E4psjbX3IKbS
 alFn/KLw4/18sMjRjMPq8TO1iKrZaxi26wYz6MrbQkU9gABSZH+wOaHEJebDrkagqdr3CGrh6FB
 1xqkxTwdgbaq0h510igd1VhYakTLOibPnJfC6S1FRDanfnMM89AOlFVwolCGADFAspORJ0p8C6f
 GERE/7Dtx7Mzdmt3PBtyatEnmtTzNg==
X-Google-Smtp-Source: AGHT+IEoxFtRO93UDD7FAJTxOIW72VUHEBg9mEG6unYQonOmYQv7xtcHMM1r2jxCf+h3fxeSYMN8xA==
X-Received: by 2002:a05:600c:2d4b:b0:42c:baf1:4c7 with SMTP id
 5b1f17b1804b1-434afb94427mr141024645e9.4.1733147400170; 
 Mon, 02 Dec 2024 05:50:00 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e4df1sm183942675e9.39.2024.12.02.05.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 05:49:59 -0800 (PST)
Message-ID: <e0fda20b-56c2-4195-bc64-a75104e277a0@linaro.org>
Date: Mon, 2 Dec 2024 14:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/67] target/arm: Convert UDIV, SDIV to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 64 +++++++++++++++++-----------------
>   target/arm/tcg/a64.decode      | 22 ++++++++++++
>   2 files changed, 54 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


