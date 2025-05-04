Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6FFC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc1k-00045L-14; Sun, 04 May 2025 12:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc1g-00044y-02
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:17:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc1e-0006vo-3A
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:17:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74019695377so2960040b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375428; x=1746980228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gPGn+MwZnc8xQd76t/xYLdPoUTnlVwwJ6Dg5FznPQUQ=;
 b=ydHiTSg+SbjbxN2PelS0QBIIvuv5kCH6EgRmhKn0LRr1d4+x4aRl59yu0Dk5aLP+Qv
 HbJHQ5VmHBtPLES8nLppP+MrsHXoJx6dTwBkvIvty7467xLPLXooHaUgJ4WEdDcXKPoM
 tbz/IgqBa8egSQ85pUPiLL2p6actqd7oJbwbK0tL1YtWPKkrDFwzqjOI1IpBXI/M2nS4
 HynSOKFvxnDiu/jeL+ow4knI1lG5LmGPThjTkX4w5r1kGjlblG4czwA02ktZ7AII/HJ8
 Gf3sxTFocTJ6Q9Zxq5xyb1YYh1gPX0qT1n723w5AsRZCWLKDxMRiyAvli8fmqB3g79no
 l4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375428; x=1746980228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPGn+MwZnc8xQd76t/xYLdPoUTnlVwwJ6Dg5FznPQUQ=;
 b=sZeUodnSJFDv1o/tyC6OF53CwJ5FlDT/wf/+ylL3zEwyam+EWkbh3ha/Y5guRtZx2l
 A+aUoXWM5lZEbXczl9IZaxo7uwUD05UuhEDxWtBWuU4wrkoPOVV3cbQ3D880/cteoVoe
 tK5YKB31YYef5X8JYhygNN2b0jKXOe/u0/eRPDKBLt5HTBz1Gz4vBGNzCFwwuf4l+kd3
 +iK23EROBiJwUJV3AGYJTbLQOwjfRjZIJE8cRuAg21NweNbq53iqUZJ/nEzXAIiuSVUh
 15g8/fE2rK5ztVSIYyd8FSK1L1kPLRIdirvKDxKlJ3ah6tQKJbgaGnRhL+Zh3t1q76pi
 Ox4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFddSgt9ELp8XvReQoIabsch8X/ZciNq1sjSYOrdI4K0rQFkFJZcuUJWedtYURTjo1nqocCSAAFc1h@nongnu.org
X-Gm-Message-State: AOJu0YwDu289T/dEeZR9HQWGPRNBwEtGFaM6kMi9k/Xfb8v+NpwPUKMs
 52rNCqA0MMJfgEPYhZE5puqscQUnzF+D0hiaSPc5eRUTJ4hm6k0xcyxMBJj03uE=
X-Gm-Gg: ASbGncuMBjnuYq7GPTg6ijdYK1xPZBDYU993E0WqJPCFb0iFKESZukW9kZ09BPF+ayG
 yOG9MXIb7wRdCl6kU5kzb6Wauql3AIWaxrTom9goE0bLc79e5NgA8AgV+2BXT9kDUzBtf1MIyG3
 2cseWUGHsyVz5d2VHxAXpRfwX9OhpeMEjVULItw20IIS4yDGuV3Hvp1LffAap5J+i+f5qcT7Fd+
 XL3pMULVbG5BmUTcFd7zbIHbVXQQ81Ujmd+7jf/9inEh7vXk+wio+NtO05M/Sv07p4v5nEcleoz
 4Jvs81HKEu31l1LJjlgN5u9GEwf9obknZlZwKbYK3udr1NJiZ5TAgUmCBjmzwrVrR7ueUJO1BXZ
 kd6tdEgU=
X-Google-Smtp-Source: AGHT+IF3G5/bfGBl5sy8J3dBUbGQQ6KrLbeTzkDrhzSDPBYgiKocLSfoMUYlYUoHUsjZG5gmsH1W8g==
X-Received: by 2002:a05:6a21:9614:b0:1f5:769a:a4bf with SMTP id
 adf61e73a8af0-20e97eaa02amr6564145637.36.1746375428049; 
 Sun, 04 May 2025 09:17:08 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3b7afd4sm3293173a12.33.2025.05.04.09.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:17:07 -0700 (PDT)
Message-ID: <5b152664-a752-4be8-aa15-8c71c040b026@linaro.org>
Date: Sun, 4 May 2025 09:17:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/40] target/arm/helper: use vaddr instead of
 target_ulong for probe_access
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-17-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/3/25 22:28, Pierrick Bouvier wrote:
> +++ b/target/arm/tcg/translate-a64.c
> @@ -258,7 +258,7 @@ static void gen_address_with_allocation_tag0(TCGv_i64 dst, TCGv_i64 src)
>   static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
>                                MMUAccessType acc, int log2_size)
>   {
> -    gen_helper_probe_access(tcg_env, ptr,
> +    gen_helper_probe_access(tcg_env, (TCGv_vaddr) ptr,
>                               tcg_constant_i32(acc),
>                               tcg_constant_i32(get_mem_index(s)),
>                               tcg_constant_i32(1 << log2_size));

This cast is incorrect.
You need something akin to tcg_gen_trunc_i64_ptr.

Alternately, do not create TCGv_vaddr as a distinct type,
but simply a #define for either TCGv_{i32,i64}.

In this case, it'll be TCGv_i64 and everything will match.


r~



