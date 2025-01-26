Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4136BC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1pz-0002CK-AE; Sun, 26 Jan 2025 07:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1pn-0002AO-N5
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:33:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1pl-0005ed-KT
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:33:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21634338cfdso83429435ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894825; x=1738499625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BWwMiEZJiR58HFyi4IKeQpKQEGbxhPiaxRX7ufEcjpw=;
 b=e8p0OrKKbI9zqjLAlVVGP262fQRnQpsVJ7q3zpd1ZL73g4DIvzR/M1Aix3NtZyMx6I
 M1aIU1/yJXWr37h21eTmzzlhCCD3QwjDmjDSxnnytHtfHMD5ERdBVnrSBb9VBPBqFyki
 aM3NQrFKa/r5aTEPQI76cqoJSLqfjpJClJ7s8GhiAw+wzQMWOn42/vg+xev9eCBq5s/k
 xm346nl4IlQ0vVGdfduLvcJ34xboGvjaS0Ro6HiDWxoVvZaUF3zBzD6BPviPkfktveKz
 rbT4dZom8Lf3Z/HBN4CZtZ3y3uL5erJrNOITVyIlAqaQq4u03H/GM+skLntJ+r6NnJjF
 7Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894825; x=1738499625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWwMiEZJiR58HFyi4IKeQpKQEGbxhPiaxRX7ufEcjpw=;
 b=DRhYx+kcbI4SFf9rvSCLNf0H/gAyjzJ/Hr0AA+lR1TT+XafR12dBVoZqcWeuRE0rUk
 DbXMzsboDUa1YinMidWqWqsw4d836Uh2ekXqip4V7AsT3c4dfOKKgJt6ZtT0WKXUhDt+
 75y5Ygfr6JAaFYGAr04/TePw6UOlmtAPvWRn4mfty3zGafU+tX1wIPDSw/i7bCKQ61qh
 vIsffJnRTk/izN+3x7ZsoBrnbS8Z2B1Yq+NgPKU3Xu40qmqAGNAADWdWkYDTllGiE19c
 m8iHgbPJFTmHjqouk/wemsZdES6ZHDbW+gtaZvTXQcJk5meUIdtnw1Cj+s0MlqYguRus
 /hBQ==
X-Gm-Message-State: AOJu0Ywi5YytzeVrOe6ifRUqvU0zz82mtHq7DkvYTbFeFiz/inEcPMVR
 SgT8hQZOQOOoT2QDItCdljtH4UwSUCvReCr9i45KvJrmfmPLbapm+SPcj5cEjlZ14cMcAzE2aBx
 c
X-Gm-Gg: ASbGnctmL+PFiKnwT+Jd+T4lySaDI3/WXQ0bxxfw4GIcDyH757w8q1mCgQ3FH28p+mM
 st2BZYwF4DyB7XC0Li7qRWATqpsr/33ew2YypVqezY5+2DCrNTA9LsSu57JFdE+GVYNK64g5d78
 okTIn/qFpmrboeb49YbiNCITf4Dh6A5HlBkL7HI/gmjNqKEUZE8qv1YRlcXxEa0MD/hsGgyy3x3
 zaL5FMkr/04gD5DvRcqJsrl0U06TFORfytVbexZ4PN/Kg7qhy60D1c6K3+LWQkhpU34c2iZoOPt
 6CXgjpBQa+FWB3on/7vyhr8=
X-Google-Smtp-Source: AGHT+IFW/0EuWSC+SrWhLX86HOzrcg+E8fPgmau3OKtBjBInlVoaRjjCIyShLA7bnMHFHP46xnVwNg==
X-Received: by 2002:a05:6a00:e07:b0:725:ef4d:c1bd with SMTP id
 d2e1a72fcca58-72dafb9b331mr50738079b3a.19.1737894825229; 
 Sun, 26 Jan 2025 04:33:45 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6a031fsm5347786b3a.14.2025.01.26.04.33.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:33:44 -0800 (PST)
Message-ID: <6ab2c032-6919-4fe7-8baf-5b87d2479d32@linaro.org>
Date: Sun, 26 Jan 2025 04:33:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/76] target/arm: Handle FPCR.NEP in do_cvtf_scalar()
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-42-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-42-peter.maydell@linaro.org>
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

On 1/24/25 08:28, Peter Maydell wrote:
> Handle FPCR.NEP in the operations handled by do_cvtf_scalar().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

