Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FD2C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6ZQ-0003SK-M5; Mon, 17 Feb 2025 14:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ZN-0003Rk-ED
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:14:17 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ZL-0006B6-Pj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:14:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22128b7d587so24904815ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739819654; x=1740424454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DbqZtIzdDFi8NakJhKcPrL8jLc3qBB0GLCEIjGY0R6E=;
 b=P5db6Pzyv9syz2O0TgW1BEJOKhGZCSHjettDcieEvdy66I9Orxh1O6ahAlqm3Pwit0
 AKNkM114DhFw3WBzC0Do0wTLx7dvLjOL0eu73TSBWtFu7WqBeX1jkVQuWFn/wzKKcMP/
 zEmZQJUapgaKpKy6bkffC/w5XlykY0UIgAgVwaRBDEQUGRzlM/bYi7c2DkYRM04nd5nB
 +EwM4aycGwsI7SQPYdSIjqjXo1vTNJ6ApUjvDWQk/4KXyxkuVeic0odnDTRWsnvC4Kpp
 +Z3A4OktXS0c7evY+OIfkZjZbdY4bnspqRP9TAbyaR983MzQY1a29B5CwQ6MptBHVyKB
 UD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739819654; x=1740424454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DbqZtIzdDFi8NakJhKcPrL8jLc3qBB0GLCEIjGY0R6E=;
 b=vrgVaDLiAAUzD+JaBf6cGY0CkNMWsa+dB38lQipsIgu/L3dfMGU5dYHFqTNqXX0zVd
 5V3oXZkH8CACF5d0Bbut4DxLQMOFevpHrZ0Ec8MiRT7Dk6cQTpxyyYmUBanE3aZjdhyj
 iEbnxiiBhwAPIEAVK0tmBwDWKx5Ie5p1FoZD/vQQLXicnTBLf2LYXaWS4n+TRt6Cj+Eq
 JgZGSSCnRxNTnd0aE6J45NG8X1M0eqzo1sb03z2i7isQfIFMEBJIpumRJGXpYZy2Daz0
 v+8kfbB6VVnpuHlIZWErRBV15PsCPJ+SmUxzrtrbOJFh5KzKfje6m6Tcfc8libwhmUoB
 sngA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGv7LyaGbq7azBXl8o2BNAVx4rfelZbW9+kK6Vn+1rBJ0RzTWPzR6Ejz//R+ZY+JQGsQMcwd4i9gRT@nongnu.org
X-Gm-Message-State: AOJu0YwJSksqIHOwDpygMHZv4FsJDkd+F8NS7I7wlbY0oK5huCkz4P1C
 sVA0aQNwRr/J9yTSDKYwEQ4dn7RlDjLN0lnmbyHK4mtpwodixyCuyo23wZ0FCcubjO4s9zeOoDK
 t
X-Gm-Gg: ASbGncvzGpiIjTzDS/ixjnDayap0+hua29w/1pGjv3YKdR1KELHEKju7zTv7kfGNW5+
 vOYnrCtbSXYR3pFL0XWs+xrsC6sfspkOlLleN6wU5nwtk+4r0vD2Der8r20C4pGPLwtG8aGWW06
 sU+umXdB9qUnvkQt2rOeIuF8Vz7kaynvZSK08S9A9/cuqxDchg6OZzUGKPLTMnFqTa6PJXX7LDH
 LgD9gCJAZlWc1E9nKttnpfXpGOhjF5cBy6T5YdxTwFLWqT8ub5YJM0DxPXTjA3sAshZlq2+J0or
 moBJKMt4LkJnjwg9R1AwvE25kdUhNOcxcUN4PXPoxGd/9AhQ+uewhFg=
X-Google-Smtp-Source: AGHT+IGXVTIcguF1cTNjc6/51Kg6ZDTQxeEXLzOIh/NcPyICU1dS7AXeT4IN/VVd5ubeGBV50TjB2w==
X-Received: by 2002:a17:902:f546:b0:220:e63c:5b13 with SMTP id
 d9443c01a7336-221040c092bmr127299115ad.46.1739819653873; 
 Mon, 17 Feb 2025 11:14:13 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d07dsm73738205ad.138.2025.02.17.11.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:14:13 -0800 (PST)
Message-ID: <64deaf4f-b999-41aa-ae44-876a1860a10c@linaro.org>
Date: Mon, 17 Feb 2025 11:14:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] fpu: Move m68k_denormal fmt flag into
 floatx80_behaviour
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> Currently we compile-time set an 'm68k_denormal' flag in the FloatFmt
> for floatx80 for m68k.  This controls our handling of what the Intel
> documentation calls a "pseudo-denormal": a value where the exponent
> field is zero and the explicit integer bit is set.
> 
> For x86, the x87 FPU is supposed to accept a pseudo-denormal as
> input, but never generate one on output.  For m68k, these values are
> permitted on input and may be produced on output.
> 
> Replace the flag in the FloatFmt with a flag indicating whether the
> float format has an explicit bit (which will be true for floatx80 for
> all targets, and false for every other float type).  Then we can gate
> the handling of these pseudo-denormals on the setting of a
> floatx80_behaviour flag.
> 
> As far as I can see from the code we don't actually handle the
> x86-mandated "accept on input but don't generate" behaviour, because
> the handling in partsN(canonicalize) looked at fmt->m68k_denormal.
> So I have added TODO comments to that effect.
> 
> This commit doesn't change any behaviour for any target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm confident this commit preserves existing behaviour, but
> somewhat less confident that I've correctly analysed what our
> current code does, in particular that it doesn't do the x86
> mandated "handle pseudo-denormals on input" part.

Test case:

#include <stdio.h>

int main()
{
     union {
         struct {
             unsigned long long m;
             unsigned short e;
         } i;
         long double f;
     } u[2] = { };
     unsigned short sw;

     asm volatile("fnclex" : : : "memory");

     u[0].i.m = 0xc000000000000000ull;
     u[0].f += u[1].f;  /* denormal + zero -> renormalize */

     asm volatile("fstsw %w0" : "=a"(sw) : : "memory");

     printf("%04x %016llx  %04x\n", u[0].i.e, u[0].i.m, sw);
     return 0;
}

Expected behaviour is setting DE for consuming a denormal.

As you say, this patch preserves existing behaviour so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

