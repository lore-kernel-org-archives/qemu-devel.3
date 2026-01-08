Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED31AD1D48E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwT1-0000Ra-VH; Thu, 08 Jan 2026 15:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwSm-0000Pj-CB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:18:32 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwSk-0002V1-Tj
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:18:32 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c213f7690so2400527a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903509; x=1768508309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6x0RBGXsgLcgZYPwtba+uMEW1qnp44KKnlck9JCvNqY=;
 b=IVKEUszBpL8soqGf/yUSMwTlp8Q3W2QzDWJDK0rllW2I1u0X0keycKqU6n3tTBssvR
 SbNwm6FA1eJLdc03X7r8vw6PWmk+OmKtRACqQAmBgQc7PiUbUllvbrj61bx+ms0Soeg5
 V3UZd/VkLqQDJUdiskFKYSRHOKZkFnxCfTdKWxWm3fM+EfkZ9YmEdl9fNlsQsFOyPGIt
 O2bDXcoaHn04vBoBBPKFdISA4Gb0auDHOBEV8N7Ydz5MatptmyRmdsO/dcAvcvNnbipF
 efJeCN6sN1vV1B4MjG/sZx9D4LfJsHnJ3UkmyVjGQp+vj47h2SokxPA8nD5ywjS4K2Nx
 b4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903509; x=1768508309;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6x0RBGXsgLcgZYPwtba+uMEW1qnp44KKnlck9JCvNqY=;
 b=ItVwuXxo8Qp+MHyo1xTCtN4j45JfF6+go/mXWROtmKnuBDla65q836EQZERB6skNPW
 4k48hOTv2wfmT0rCuZR08ryIW6UsGoHAMNBF7bafQaLxnz4G3F8KFjpOUbF8Yk+sNG4R
 m+Wd2o3IHO+7TQcHAURxJ6roOVrMz89ye/ALxMWhVKiAANepQ38HY0bp2Jz4lnqwwZrs
 JzZoyVLyjPkTJlj09eF2mTxj/X017TgA5N3E34S0rZWIVX2z5ywJsiWPc3AbZnobIR+M
 8Smzl5P0/3+m75R4AikIpu5zplkb7+EYMyjEtk6Jg9pP+abOIJKal0dtHeazESXBZZ/H
 jcvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURKL7XxQs4qwhpsCWGBZHs9z8ZrPxDpL99KneUjOxel9eSBRM8pL0SIJrTYTIwNMQv1rOCFFOwtw8H@nongnu.org
X-Gm-Message-State: AOJu0Yx2Sp38ANt0qyoMzPFmeImPY4N9tq8g6mGFcpZh7mgIXAfUFaYS
 ff/QjeoMtdlTogFJxQAjBWsYQIE9p7oPl0A0NW1UkogaluvYJp6FRlHyIqAAm7/WgKY=
X-Gm-Gg: AY/fxX7X8ydQxYPgVfcTzKZcLPLlcUfAD2iFPgYEtOcyPcklvS2x62kcQxNiUzIYRyq
 nEE3cOj3o0uA3/lvnPT8JkzWhA8QuWo7teykECjya6NpUCDSONd0x+AhRXm8VbylW81uWiP9Lwy
 1mzIZggg0f/DAyu8yhffYWa1gxQcqYjUY/ilYmtIw1hb9/fCq3j0hp2sDvRg07AiHkHkVZiAl+0
 +JSAlpz9FzXyNuqcYgzQ+m4IqH1dTJ3MNJydyCx2Af20+W4zJDT12AU+Udubvy4930satZh904+
 aTWyP8yu2atmkYa6JqF7EQcqkRjKvWPHngMpzI8QpcHY8y2DM/bodsBgBCNX1kpqQKnt6YmSOQV
 RpBmDPylMNRxzvvk7LDIAT+2L2KTZ1Stg21C6yYQqSiKV6WB0P4i15qF5oe8zVmg58/BRkXCNcf
 sTBFUB6Kh0GctAWitDolLlY7PKj/hyVZv5SC2Ar/vh1bhbHVZl0Q6XPNEw
X-Google-Smtp-Source: AGHT+IG/u84QAWBfbyUCH0XkMXVVYwgUfGaeOKYO4/4ckpfFo9TbOoZolubrv06l0qY763sXupc2eg==
X-Received: by 2002:a17:90b:1d45:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-34f68b78f32mr7816574a91.16.1767903509225; 
 Thu, 08 Jan 2026 12:18:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6af48a75sm2161568a91.1.2026.01.08.12.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:18:28 -0800 (PST)
Message-ID: <f80a7df3-5858-4206-b4f6-df702f3a194d@linaro.org>
Date: Thu, 8 Jan 2026 12:18:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/50] meson: Drop host_arch rename for mips64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> This requires renaming several directories:
> tcg/mips, linux-user/include/host/mips, and
> common-user/host/mips.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/include/host/{mips => mips64}/host-signal.h | 0
>   tcg/{mips => mips64}/tcg-target-con-set.h              | 0
>   tcg/{mips => mips64}/tcg-target-con-str.h              | 0
>   tcg/{mips => mips64}/tcg-target-has.h                  | 0
>   tcg/{mips => mips64}/tcg-target-mo.h                   | 0
>   tcg/{mips => mips64}/tcg-target-reg-bits.h             | 0
>   tcg/{mips => mips64}/tcg-target.h                      | 0
>   MAINTAINERS                                            | 2 +-
>   common-user/host/{mips => mips64}/safe-syscall.inc.S   | 0
>   configure                                              | 8 +++-----
>   meson.build                                            | 2 --
>   tcg/{mips => mips64}/tcg-target-opc.h.inc              | 0
>   tcg/{mips => mips64}/tcg-target.c.inc                  | 0
>   13 files changed, 4 insertions(+), 8 deletions(-)
>   rename linux-user/include/host/{mips => mips64}/host-signal.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-con-set.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-con-str.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-has.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-mo.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{mips => mips64}/tcg-target.h (100%)
>   rename common-user/host/{mips => mips64}/safe-syscall.inc.S (100%)
>   rename tcg/{mips => mips64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{mips => mips64}/tcg-target.c.inc (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

