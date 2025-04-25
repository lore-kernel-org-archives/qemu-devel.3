Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6099EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RY2-0006qn-CB; Fri, 25 Apr 2025 18:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RXz-0006lF-FV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:29:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RXx-0005LC-LD
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:29:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso26458595e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620164; x=1746224964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qLZEYa1Rnly19rkUOPIrGZDQHsDvg1SvQk0Z66367gU=;
 b=Yh14Ok+CGiQLHf7d7VD5Uh9snYCwPoZFIsUQLp0LblHSF8gDRaQQeiAinaN4i+BEFs
 unD/J/3eIruUiOkg0PsZ5yhh3/VlpuUCcCgc9Ii7/reAoX7OYFUhoFf/qm9hrEFW2HzX
 RQA1OtgvVd+wNiPfTx/gizOKgoCg0JdmS50o24ExztXYhIcwRyVR4HAvd4eeSZuUU/Qx
 3Be5Y1/g7jnfFEcK7JvW9Yv6kf+kxrdoaV0S1jP82f/pw0wCOTqu7oUIXC4Mr02XW/4I
 VXKIRO3rdig0DtbNZ3S+1YbTUFXbSSMPkei9TO0GqmqWpZFo3VrFCDdIZTH2WN4FsII9
 3zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620164; x=1746224964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qLZEYa1Rnly19rkUOPIrGZDQHsDvg1SvQk0Z66367gU=;
 b=bDeRbQfftwzgRI+nLL8/gosZl/ZlZ3ea2sJji5uaCMNBy++CGXTBDSf7TfyL6fhtHJ
 5Kd8RipfP3F709+uQCPVWnJmsb+Kwdpk327SXvbPCuelPdGIGe8GnK5dBPTrr3pOxPo+
 cKM+1XPoyYmOw24SEDRAtiR65NJ0aPlynbh5m41GpBxDa7UIgG9aEIZjjRYW6zJOvnQB
 5HimNXcPAqgpa0Zufkn9OaWDiL54ztrysFmiIk1nARS4of5zi+cA9n09dP7hgyRQITMS
 0P6SclKqzZNSCyvxi/VDceLpV5X8JzunXsTJNbhRtx+QsdLPQzhJtxp5HPeLn0/bDD2B
 whxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkQQRJ6IkNM85GjFZXH6mG8Ow9RdIY/SwRr6lpMEnMa4UIDvfbvACjh50KMXJxJghMtmMT7HwUMQjj@nongnu.org
X-Gm-Message-State: AOJu0YwegYQ5giq41eFt58irA6mC1G9dQqLbZyIm32Og+MXvNcHSgBcK
 7kFwfClmp4Q/ic9PXFdvqqfDalEuNtAFxf82UDO6fIti7EIee8B8fRJBgf6MyBRtKxrzkdM2CZm
 3
X-Gm-Gg: ASbGncs5pqBM/GO168wf0+gSj5fpnO1O7yWdUGs7Qo3NhIa5bWqlO0itZyR/cgRkoWz
 mdMtJepxyNT85deOyPNyv8a1Kc7xD/ef6tIbdWY7d/Xpudw2juotpHM5at9C34QJFgTfi7S9rlG
 mIGYEC6yM/Nxqpu7HT3IxLbCQ9o7TbljACSEN3M1XTnT+zgCCTUt+pCJ63i9saV7LSiAaH5phKW
 VmoYYUfutn0217CQfmtd5MFem1wajbsrH3lQsyh8nfoYoK4iBD+elTU0/nRT4rYV/ubWH6jlg+R
 uGA6z0Dr93+wMLoX9fXQRMwB4G+uV48/I4ZNVq1K2wM6zOjy0P28ovTrnnyq883fPyosH6D5MaO
 a31xY6+Hk
X-Google-Smtp-Source: AGHT+IGxvERkh8air50ozbgTeoJdfIUxOQT9nz7Y7+qw4LTvneWUPp7v19fh3dCJoEGKjkDsAEmddg==
X-Received: by 2002:a05:6000:402a:b0:3a0:7139:d16d with SMTP id
 ffacd0b85a97d-3a074e1e8edmr2964281f8f.23.1745620163776; 
 Fri, 25 Apr 2025 15:29:23 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538f4aasm37499145e9.38.2025.04.25.15.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:29:22 -0700 (PDT)
Message-ID: <0f59af92-958e-4599-9cf3-89327450117c@linaro.org>
Date: Sat, 26 Apr 2025 00:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/riscv: Pass ra to riscv_csrrw_do64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425152311.804338-3-richard.henderson@linaro.org>
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

On 25/4/25 17:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/csr.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)


> @@ -5647,9 +5648,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
>        * accesses
>        */
>       target_ulong old_value;
> -    ret = riscv_csrrw_do64(env, csrno, &old_value,
> -                           (target_ulong)0,
> -                           (target_ulong)0);
> +    ret = riscv_csrrw_do64(env, csrno, &old_value, 0, 0, 0);

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

