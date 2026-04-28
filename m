Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E09FF8870
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbc5-0000wk-Mp; Tue, 28 Apr 2026 02:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbbw-0000r9-Hr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:07:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbbu-0007Pc-Dq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:07:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso58094215e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356473; x=1777961273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFU2ZGoSm/almi5MTkoDlVd5GRD8jawMKIRCUPbOpnY=;
 b=uBSJX9SwUMsZwobIDQQ0PnMPNZ2WjEm5P6859SAULbXkcXCZINkJErY0YPmnvcYguo
 kdM9uVti9pWBmbj32/XpTJfgjn8tP3VN/Jl4ANUCBTIbwkZ65W28Ll0I6J9NN1gOEYcO
 auVS9HlBb6rzc/RqLqCCC2eTS0giFZ/Lq7665yfHKYfojCuUOUDwhLS1OhhXZwi5wRrW
 u9FctW3Yn3pBCQG03vhM01gniz5/DJtUUFatiYogUsoHBieAyLDOYUymQGyH/NCkmCK7
 h++ALgFWvMtHKvg0ye0PUsWi9nvvjuSk9rQwDLFJKIUVjoWcZ70jRrXsHpLOq9kFXQXF
 3Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356473; x=1777961273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFU2ZGoSm/almi5MTkoDlVd5GRD8jawMKIRCUPbOpnY=;
 b=AdC+ehOWEqoelJ1A6j7DsmV3L265iZNSvJpKRvKgxh7y5QyryReu5yW93TN4eeNRMu
 dtSmTP9RIuaT1JQpN/CZQSu9Ltg13xczHGeWUTBFT/5QVyVGx8LGYrzi4aJsUpuxoOgs
 sAKGY+hAMYZ3ygw6Y1f4FZ2QkoLwvAP4CtonlalzHsR+TXB3zC0Jgs8czDPGXolnUv4i
 X49PxMNjKivahdxj09blZBKX1q6/dDpi/prPWMJq8QXjCfMU3BD6x0mqNGa3+H8dG0Nh
 5CWRvU1puwpwpB2/p+0Ha47qUFhw6/lBSbb6sYZT01nlCwlfBogZ3nZgGI53ODrDfPlq
 Dbzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/pgEFnwzTIIkxU9t4odVglgI6K+xYAvDAbSTI2vxQt1FIhXMQ0VaD3r5nz/zgrasdUSuKnDJMWmTe@nongnu.org
X-Gm-Message-State: AOJu0YzujInc+zTWP9XNLMxRSRvqyyYZeCkDIlEsaE+pnZwR2LIt3M0w
 57gsQboGaLBtUjso7VE+/8nk2xG0pjF3392SsDyciywzE5nhnHI9Zxe+PzyYwOZL+2E=
X-Gm-Gg: AeBDievaNMO/oOoK/MO6lXlsZdQgLUH1SSQPDMVof2AkkKqI6M4G4eyTGEUXqOfTT0X
 SYGicpCzFZgtks0ABWyRUXaFjyTgE1dqkgQVP3rynlfuA5RDA+xvQnu7UbXcobe9Rjr3kECulZy
 vx9Jz2B80bkXLgT7UqP2KoEedijxx/S7Z1ElOG1e3KsNYhJOlVhVuVYfAEuLGIL62JEqp1FQXa5
 iBwgbYVSyfD48gdhSJC8mddaOzY/9QRSqeUy3YuLlnamO8lbl+mELAeRN4/AxZwO5gHgMmoj6AD
 Yo5LfpsuSpyqx/uWgwEX8gCKYNmg7yleSv6YcwR9aFlOtHDsgVQpeVJC4B9O5FCuy9GrJu5ds3x
 gOFbEx2X77N5z9cgRgY4Zy7TYkMnuUzE68bthAToFLBf2Cghwe8pKT49hIK04PZ+b+MQiqTa8wH
 MUzcUixuQHUj9n9fxl0qyZqXejvsBki2nublUY0NCx1DxByIgFmOlOJ38bVyqCxYDBLhumJ+Ytu
 C3R
X-Received: by 2002:a05:600c:6287:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48a77aea9cdmr25306345e9.9.1777356472716; 
 Mon, 27 Apr 2026 23:07:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773a874asm45377305e9.3.2026.04.27.23.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:07:52 -0700 (PDT)
Message-ID: <8a5a57df-e9cf-47aa-a163-845929c9e7f9@linaro.org>
Date: Tue, 28 Apr 2026 08:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/84] fpu: Inline float32_unpack_raw into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-42-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

