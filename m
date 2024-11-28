Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292FCD69105
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGe6l-0006AC-Lx; Thu, 28 Nov 2024 07:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGe6j-0006A0-Tq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:58:58 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGe6h-00011Q-Al
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:58:57 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5ee645cf763so317526eaf.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 04:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732798733; x=1733403533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/NCzGmnBhpIg9O/nO+yGhpiPPlY+xWJuGozNhuOek5o=;
 b=aD1Cq7dqW5TKTKLLEqlGlBBd4QO7aGD503o17V9OlzSc9OHKYc3fvmlxBm4D+4z3Kw
 MbmS8TnBoGn9K4zETmVrULg60C/TO9C6qUQxMQCgbVdiVe7EPx2vAUV2xdMDSgxyADhd
 rwSjWGFjYnPrRm4STFqZ/rLdCzWXsc8d9j8GKYxEs/2LSQHsSyORQr5jMcC079NTNFgp
 Hm5jkJ+KBDwHQmWl9LzF3Vg8krdD5DCy1lQq381PPhDEOBgNyGO6RBXtdwJTUk0PBnSJ
 lK0oGfDUeDr0BxVcb/mw9Lf8U01aYPKomTKOR2zwkeHAcRSysUl7ZyPrLOr0nN84fEN/
 unsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732798733; x=1733403533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/NCzGmnBhpIg9O/nO+yGhpiPPlY+xWJuGozNhuOek5o=;
 b=gW5MoPUxXXXnumbNlxcKxTNQbEvBD4Y4oMVOg2lfxXkuHirXZuun2lL5UAhs/gJkUR
 OIKwJV8uvrHY0eHqRkSXNemSgWwkLzQYrvYGJ0CxAhbluBu0RU4Pv6Ryn8vCDlqbiNee
 fqE/iWIVCaez3/6kV96puwYawOXCyuotmdAfAMp5QIzsJOGbfuI5Og77nagahDDu1yFJ
 d1V1eOxgux8vjabOq89ibcMcNzrb/VTGqJPNhkx3Vbyv+gD+vjnE8tslhSK7m8wPyDUb
 DHSwYaRcKnAqWywOT9Ewm4jk8tuUYUONMvauFKvswalU4XTB9sSPBED5RO8djvlN+TWC
 3U5w==
X-Gm-Message-State: AOJu0YyfO2wMIDl+MoIxCGx7ye+i7Fdfla4IsLtFhQTk1z+mtydtnUEx
 Z9F+Nz0a3n9gHy4awdrU52ObK0g3qDJAdB4lpzZcIhEd12SP7lUelfCPuU6ic4NlbrqYsFfrbvs
 kH1E=
X-Gm-Gg: ASbGncuPOsEPFapgHpIX+IVU6igvhM3Ww6W6a4PZhzfsZv2PJHStH6FGvGvC6ygKhof
 ELRXaS3jK6QJwARBbme9JmlgRrHkLBwmVacfQbLkZdiFkhyARE4LfBoRzq5x3+l6itwNnDFWAHX
 hHdCGbn5pnRceoGmTLJbdZlSLd2OpB53gB0DJDl3Ak0aCqwQcjmYYxRbL3t/sWaW+cc2clNT+Mv
 upBE8oqEFvvLaB9ZYI1EyVG2sDY/nNhgJ6uK6WbHv7maOk8ztOhDJeNuTNIDnetvsCiyL4Latls
 qhn8VDkz2SSxCR5vFz5O9Vfa3F4b
X-Google-Smtp-Source: AGHT+IE1uUQHGgW1PE7s7tR/WtVS+ctAwsMW/7vjkkhykUAN1QN4GWwlqBkTTdAD4Zt7fVXAQNlFyg==
X-Received: by 2002:a05:6820:2183:b0:5ee:ebcb:e6e9 with SMTP id
 006d021491bc7-5f20a168f5cmr3811778eaf.5.1732798733254; 
 Thu, 28 Nov 2024 04:58:53 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a3a920dsm287820eaf.20.2024.11.28.04.58.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 04:58:52 -0800 (PST)
Message-ID: <c6ea5acc-e07f-4eb8-ad8a-b339f27c9102@linaro.org>
Date: Thu, 28 Nov 2024 06:58:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: qemu-devel@nongnu.org
References: <20241128103831.3452572-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128103831.3452572-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 11/28/24 04:38, Peter Maydell wrote:
> In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
> cs->exception as a shift value.  However this value can be larger
> than 31, which means that "1 << cause" is undefined behaviour,
> because we do the shift on an 'int' type.
> 
> This causes the undefined behaviour sanitizer to complain
> on one of the check-tcg tests:
> 
> $ UBSAN_OPTIONS=print_stacktrace=1:abort_on_error=1:halt_on_error=1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -device loader,file=build/clang/tests/tcg/riscv64-softmmu/issue1060
> ../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63 is too large for 32-bit type 'int'
>      #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
>      #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9
> 
> In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.

Semihosting is completely artificial and should never be injected.
The maximum "real" cause is

     RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT = 0x17,

We ought to hoist the handling of RISCV_EXCP_SEMIHOST higher in the function, before these 
calculations.


r~

