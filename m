Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CFAC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpb1c-0005jf-9o; Tue, 04 Mar 2025 17:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb1Z-0005jG-SG
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:46:06 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb1V-0003rV-HO
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:46:05 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2239f8646f6so62473515ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741128358; x=1741733158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/k9h+yCavWavbcD0RTVfSpDouu9fS3l5eQs0LDAiBw=;
 b=WIHX/RymUUyCmgxS7WVgMOYzzp6tGANDNUoL1EaEyWwVebllf6ltk4tP8zso99y+9p
 KYOZ+pi5jYrKsmFXwBSNB+vHTvu9li7xzEWAyJVI6fJ9ii3PHYgTn4SMaySDNohnCCLJ
 Qn5gj0UCkolZy/16A3FawOfjvoxuCnlZiILVfxTbazQSG9MVx/KLAk5Xk9OBKnTJwSaK
 H9Ip3soqq0BV9R4cLfMzLzymstjyvwlaSkKcQ9T6ujhSp2qy2iTHUEbAxBgzduf5BvDH
 JUpcPUxClNTJE0/dkjSslWP2FBxGbyTjUnZiwHcyXJD2SJv19R568RKBl4LfkEVfFDHq
 pqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741128358; x=1741733158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/k9h+yCavWavbcD0RTVfSpDouu9fS3l5eQs0LDAiBw=;
 b=emgkuZNTvD/XlGZmep2iy3tDmxqBhZIhu9163E68Q7aAmksapqECiMu+j1/GwIxOvc
 SSd+A/BLsvbWFI+zyVvHvGHe0yjKIjMtjXNylffOpHEpV8J8ojvJumbe4AXtvedxIHez
 yP8dFpGhYzevukDT+01t9UwkSPhJdYzasbDZUgAHmuhXukd7AnMJJxfPRk03B0G4z0U5
 p158Dy4Eu9XOPi3GnrNGKWNzpgp+JKmIs2AzqCDFJUBXJfmNdR5Va4ZkFJ0i+mLGDNyS
 KeOaHUmUp2qjhEsuWH8lRKLBpP0Ep22+IJj43nAP6ZJ3j1dAbwVVp/gFuks6uZ/P2fSz
 GnRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHgELTYArHqFsZXz4UtrvWAGPm/nckyufbt4e44ZPYNVCgooUq/0MUPbf0eJB0kcbPVdCTByUUA4cw@nongnu.org
X-Gm-Message-State: AOJu0Yx5cJjRj1fMVjupriIVufkiRTqp3FqA/wyNlXjRIQFnvkCwXjzG
 5HCxtuV9EteMHvAjPNE+LLi5pVXU97aHlQOFZ+uupWi0g3hQs14goCET3I8AVOdjpFj15qJFq5Y
 3
X-Gm-Gg: ASbGncvIzYOuCY3y8bKsulllAt1LIJyHHc9CLJdD9nB3hkFnTAOHZwA6GGUwUtzZM+I
 9VQeFJGEWi0mnNasP6mUjffs3KlNcYkTDlgdQPhwyEirEwpkbk/CJxpvfG1nD76lOandDZGHShB
 T3/BbSPvEYpyLBaoFxAUmMz6CUGIPUvs9Pk55TnF8b0RWvor8BS5LJgyQR8qtlNqzzCFDxjEwmF
 lBgNOV82CZulJ6Ju/tbWUq/jGoD6Xayjw5kHKuFP58uXJdZgHmQeAn3vJe6Ui58dL0Pd+GHVPCu
 63CYgfzPPXeCteWaLoLk8yf3NCIlOpaFxxtqoxNcNsYPv9k3jtkMhky7WzPFRetUDQx0RoZe/0e
 u/O4Hzn6/
X-Google-Smtp-Source: AGHT+IE8TuuMCVlp3MAABMc50Q4jAzq9RXvyEwgtrbaFlm/RgNvITfrbO+LC3XSrDwGC9kPmdo/S8w==
X-Received: by 2002:a17:903:22d1:b0:223:4bd6:3863 with SMTP id
 d9443c01a7336-223f1c644f0mr16333205ad.10.1741128358496; 
 Tue, 04 Mar 2025 14:45:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504dc93csm100938865ad.167.2025.03.04.14.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 14:45:58 -0800 (PST)
Message-ID: <ac986fa1-00ae-4870-a78b-208834a555a3@linaro.org>
Date: Tue, 4 Mar 2025 14:45:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/32] tests/tcg: fix constraints in test-i386-adcox
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-16-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250304222439.2035603-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/4/25 14:24, Alex Bennée wrote:
> Clang complains:
> 
>    clang -O2 -m64 -mcx16 /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c -o test-i386-adcox -static
>    /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:32:26: error: invalid input constraint '0' in asm
>            : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>                             ^
>    /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:57:26: error: invalid input constraint '0' in asm
>            : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>                             ^
>    2 errors generated.
> 
> Pointing out a numbered input constraint can't point to a read/write
> output [1]. Convert to a read-only input constraint to allow this.
> 
> [1] https://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20101101/036036.html
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> ---
> v2
>    - followed rth's suggestion and removed additional matches.
> ---
>   tests/tcg/i386/test-i386-adcox.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/i386/test-i386-adcox.c b/tests/tcg/i386/test-i386-adcox.c
> index 16169efff8..d653fa86a7 100644
> --- a/tests/tcg/i386/test-i386-adcox.c
> +++ b/tests/tcg/i386/test-i386-adcox.c
> @@ -53,8 +53,8 @@ void test_adcx_adox(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
>           "adcx %3, %1;"
>           "adox %3, %2;"
>           "pushf; pop %0"
> -        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
> -        : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
> +        : "+r"(flags), "+r"(out_adcx), "+r"(out_adox)
> +        : "r" ((REG)-1));
>   
>       assert(out_adcx == in_c + adcx_operand - 1);
>       assert(out_adox == in_o + adox_operand - 1);


