Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4B6CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rHb-0002PJ-IJ; Thu, 09 Oct 2025 10:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rHP-0002M3-6K
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:06:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rHJ-0007qL-M1
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:06:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so1109585f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760018749; x=1760623549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oar5S2MDsF+wyqIbZKpmyBL/RuhZegbYJ/qa2Q8oUfQ=;
 b=bUAhqN6N7+ZANxBndX74r3L4bt8Af0V4tgscCJNFqzvpjvqF/KkUGe/0SG7pDYc+o9
 FOA7Rgteow1sDHKMtGWJT3zS+4eVAvQq5NLQwYLlo6MPEls4gy7ZiZHnRr0FpPRNa79Q
 h/VXNw0+QfQZHPmoQGzZ/tnBdRzSn366FT9t3PCRBCLUiTjDyLfcWuLsYIxVYEvoRfPM
 ZGybOTCzfYC6mgYgLqL9MJSUyWhUtt9gw7FWiwjilav7Vb94TdD2WKmxkOe6DY6UnE0Q
 r16H0FDuPAe1JTFwmD28jLX7Tfz9Lm/zO9ou1IfYax1hmgj/4p1kXeAVfq22/TBJVsHd
 BRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760018749; x=1760623549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oar5S2MDsF+wyqIbZKpmyBL/RuhZegbYJ/qa2Q8oUfQ=;
 b=YBh8lqYOyOFF2+cNY46eHC1Q6vtnO8dl1wvrdbH5owEnUmRN6jxmRtWqgNpP1EGwdJ
 4HI1qoE1wo9YnUNBybeVUwzTTNlgXqdY8OBjAMwhxDcK/ddCJG1tilSTkACc/piked7S
 39JQBO0GbOb1jYwYfpZn/wmV21DP2Be3KlCCHxARcgjPQVH8wmgtrbMgOeTatuS/kUMw
 AcBRLI5NLcvWvrYGKUU+/ouJ+hvfxN/9+1vDsHKmrHuaCAKzoIkYrV7Rf6+j+Ho13ET/
 cxFkv5wPgDwRoh301t4gqd/OrOe5jMOD9MGEHhHWqm83uRpKDbHUp8AzzjglHJNR+jMy
 ZIwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtZG/E67QH1cnc7X3C3Tl7aHf7fuWcZX2QSk5BfrUdRhCAOhbVs4Djd/ANh8s1uceYRFyPKW0qUQsf@nongnu.org
X-Gm-Message-State: AOJu0YyY3+ZSfmGMllCIHZo3VMVsCVowB0scTpDE1sjspGkDSV8VKweF
 z2zirVJ/LWjpIaUs1d2QYxO4KwolEa6Y8FI6UYiEYaegz/hgWkZcRc9tfqw7gfxeqwJTfGagOlI
 5Md97M/309w==
X-Gm-Gg: ASbGncvCdob6p86yWLdOZziPSmAB1jsOxcoREOcuDH2EL2Sg5afMtOBVhxesQl8b+Jg
 qbBHl9+itE6N5b0EA0CUnkY+n/zXuRaBRvD7xn9jxd4RylHkzfuBKlJO3eo4UhTAmK9KSeNIULy
 DxE15h7wRq4g6UR3YGCuJgGmkqNjOknJs62c4GbIM3Wj4i5V3UBEl5xtQBc9foIZAWDgnCKOPpl
 KdchCGdOEfEe1yan5VVGGJ7PX2WzIxYLo0I82tLT2jqDgPKNJPJ+lcVXF0svSiyNSwjmaOfJsGV
 aekWK9hJW+IGoJSv/i9ve3lw1KmD5k4JZFncOYwyfDscS0L0KOE7f6i2M5Q4lpivrXM3GIljPW9
 YxfYoN9Cn0YeKIhoFWDVf8THCqzQdzAA35CXmdMMS5iwxYCT+hYyjnAyImwIo5YTsUu+cs32VcP
 hCY1Ti0QJ0OfJhjX8E4w==
X-Google-Smtp-Source: AGHT+IE2D4M230aaTk9lJHp1g11jpnttWCLWU1EwW4auiKpw8Zh1hwUcGu/qUCGhBw9QFqHZ/ovQsg==
X-Received: by 2002:a05:6000:18a6:b0:3dc:1473:18bc with SMTP id
 ffacd0b85a97d-4265ef6e3fdmr4288228f8f.0.1760018748676; 
 Thu, 09 Oct 2025 07:05:48 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c49sm35161004f8f.3.2025.10.09.07.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:05:47 -0700 (PDT)
Message-ID: <fca0cb2b-df1f-4853-a600-59f79851881c@linaro.org>
Date: Thu, 9 Oct 2025 16:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 42/73] target/arm: Split {full, core}_a64_user_mem_index
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-43-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 8/10/25 23:55, Richard Henderson wrote:
> Separate get_a64_user_mem_index into two separate functions, one which
> returns the full ARMMMUIdx and one which returns the core mmu_idx.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


