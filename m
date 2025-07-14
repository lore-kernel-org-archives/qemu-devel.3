Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F62AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubM4g-0007kr-Sg; Mon, 14 Jul 2025 12:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubL9m-0008Nw-1N
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:31:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubL9j-0004JG-LL
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:31:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so3866548b3a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752507110; x=1753111910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w+XCHuvqEWoKHh0e8TjkTEIwLPUiMtDfVFO9vyDJur0=;
 b=P16Qdiw070xkWNZDQffC0lZotxIf1pWTcQunRF5rH47qdWO5kF71O8YDwp13micfOK
 R14/9eI2pwYzy6E31N7iDdd7BvsNUL0urAGESPjHfMQY7IYu5QX2Klzw90md/NZIR+Z4
 PaEhipmqD/I8tEWebh5iiT6QDGGJRewVQpIdCa4sApPHXzQZqEFHNiQTLY42ooGUFOPO
 sbs1+YJZSCJRtXeGgPcPMVuICAcQ+6oO6YWuk5LCQZuTmJ1yJDtT9nIkOrj9R3fSmmOC
 mx1wi7mrexHVOffGbCqaDunN7IVpyyV2dWgAjtPGp4fWedWaOoVgwx6EvjoFHhXHaDOz
 tB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752507110; x=1753111910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w+XCHuvqEWoKHh0e8TjkTEIwLPUiMtDfVFO9vyDJur0=;
 b=YsrcaB42CBmocH7XrBaAkeqV3N7r98LfJbojnbhf0O3k6TAKPG4FDGje6X0Oiiufec
 qxjE8woPe0jBBSaVo3yMcLNt5ZhHHlMD7QrRqWUqAvZLtBnUor/9B1vxYzLLuRrCZsc2
 Kki4/7NJ0hsxGo0s8mu8y/8gumowQsSQlGHj80TKQ34j3nC89ayZPWRJ+yRWyMZZiXlG
 ZObDONmTE5TLyysaGSxwggwJ8fZvY14BQ84mkdh2WdH9Ccf4Thw9GJDSdLfidQg8J3Be
 +VTFpYD2SPlgx+LJtmhRcHyAGgp4ya+iy5+enoUOjy/NGHDjXguhRrxb8/S9zWMq3/1d
 u53w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDKamiKp2dokAw3vPrbNjBTj1JjCmoFCH6hwutDt7jXflFdm0vCEoHbO01Mk2TSr04HIrIYD9cgqOb@nongnu.org
X-Gm-Message-State: AOJu0YyoQ8qfRbmko+9zL7VNlXTTJag0dGqb/zvgOHZ59/ZcYmcO7Fot
 UA6KPPz0c4XepzlOUHpdj1RIKMSjccauPrYSsIwV3bpwm2C8QXhiFNHTHe/oNbmIN7Y=
X-Gm-Gg: ASbGnctQA+uKPxvmKtUD2eNC/3R/Du2ZNY/RMdBPu7AZv1VzIQMNNC24un3CkqCTKqh
 idWeb/3x0eIyIvi72XXzlKN1DE1oRtkIq46gVKyQeH4RSiuPnD5oSuS8SeZjhxTzbfYGCyTXOOB
 gd2Zmt8z29CBxovSiCrrf8boZUF0vprj37kyF5+UtfudjoUkDp2B4m9TNbm8MRoa833TzHVL420
 gT0+vSTuTL9CoHAp0zCY5IjRAibBGYbkF1Y1CxuBypJw6c3yTH0KpOt6ESj3vFZuh32hXKNi8CZ
 Sor7nnRGnjKJmSfzM67kBrfIrkyjA9zgdDpJQvrq5arvhEgi+qu6cJQS2WyfXf5aX2rW9IP/8Ov
 PSBTPHvjPDbMo7Wp0p3z7PKkmXHxh+64yJEE=
X-Google-Smtp-Source: AGHT+IEj9kImh2b6Ual47lsgq+9XBsPlQLjsNBbOzTu6vbSIihYJ90uQ1ds+r6IFHmUEkc8/Ey1ZsA==
X-Received: by 2002:a05:6a20:6a24:b0:232:a762:def with SMTP id
 adf61e73a8af0-232a7625735mr18670217637.30.1752507109733; 
 Mon, 14 Jul 2025 08:31:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe731effsm8924001a12.77.2025.07.14.08.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 08:31:49 -0700 (PDT)
Message-ID: <0b438773-01b9-42e1-8edf-2330e50387f8@linaro.org>
Date: Mon, 14 Jul 2025 08:31:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Provide always-false kvm_arm_*_supported()
 stubs for usermode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250714135152.1896214-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250714135152.1896214-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 7/14/25 6:51 AM, Peter Maydell wrote:
> If you try to build aarch64-linux-user with clang and --enable-debug then it
> fails to compile:
> 
>   ld: libqemu-aarch64-linux-user.a.p/target_arm_cpu64.c.o: in function `cpu_arm_set_sve':
>   ../../target/arm/cpu64.c:321:(.text+0x1254): undefined reference to `kvm_arm_sve_supported'
> 
> This is a regression introduced in commit f86d4220, which switched
> the kvm-stub.c file away from being built for all arm targets to only
> being built for system emulation binaries.  It doesn't affect gcc,
> presumably because even at -O0 gcc folds away the always-false
> kvm_enabled() condition but clang does not.
> 
> We would prefer not to build kvm-stub.c once for usermode and once
> for system-emulation binaries, and we can't build it just once for
> both because it includes cpu.h.  So instead provide always-false
> versions of the five functions that are valid to call without KVM
> support in kvm_arm.h.
> 
> Fixes: f86d42205c2eba ("target/arm/meson: accelerator files are not needed in user mode")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3033
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm never sure when we prefer to use stub-functions in separate C files
> vs when we prefer to have ifdeffed stubs in headers. There are several
> ways we could fix this compile error, so I just picked one...
> ---
>   target/arm/kvm_arm.h | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>

Thanks Peter, clang with --enable-debug is indeed a combination I didn't 
try. I'll test this too now. Going through this topic, yes I noticed 
that gcc always folds the any if (0) condition, and, based on a Richard 
comment (I can't find now) it seems that we used to rely on that for 
other parts of the code.

The fix you propose works well (initial goal was just to remove 
CONFIG_KVM, so having CONFIG_USER_ONLY is ok), but I wonder if there is 
something specific affecting clang in this case and preventing the folding.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks,
Pierrick

