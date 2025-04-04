Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B04C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lFO-00074V-Od; Fri, 04 Apr 2025 13:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lFI-00073f-JW
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:54:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lFE-0004HO-EI
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:54:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso18211975e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743789258; x=1744394058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFHDYNFCvc6baT9Yeb1YbbPIaEKtJzgAujom/NTNINY=;
 b=yusF/FxzaJNgEwTppLVkVXY2RGelBZ6sjd8LHWjuhkOopfjUGhaosZmPSiSg0A7oJg
 xJw0KV/ZovDUuryGTta9Ny44bEbqdO3MGrPdri0pGADKIZ0NxHywklSgBYh1pCvkS3Kz
 fEQQVJ3c7h3dmr8c+27XhNwU5e0Hy2kWIhB0V77vbaqKBVkzBHqtzy58dKKLKfxYA4ef
 RJnwg+7jgzrncJDEjHo26lOmUkXaCmpdc8/wNAEkNEVU8WZiuNGPRlcAp1kKo08PxOPV
 SrWcNpoRtAypb1AYKhEukjNmvIU8ewownhQGs1LIydmDhA8CX+UTMF4VHUc6rHV3DLRM
 hx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789258; x=1744394058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFHDYNFCvc6baT9Yeb1YbbPIaEKtJzgAujom/NTNINY=;
 b=vTgHTrvEcOLB7pScSv54LhJzkyhojEbM/IvYljrKmm76iB734EW0RezVoy71AqURRt
 v8KTYt/RG8sXlVgLz85vpsKtoWQwyBJfJx4gQbDgLk+K3umImlsqrWMUwu5l/lrQYG5k
 OUWMdE5UFMJe+ji1q6OsEVdfEIyWgKkGgd6ocBjdP74eG64oIFkVolVVvzrax1klkVxA
 sc/+VdTU5Xa9emR++0gZ0A3a6SnDZdA8StIE9IibJPxxUF33ysTW47LHDeSZDgLpkKYR
 bHO3JUiH7/ZqGBcieMwSS5KNj3ewO9u04FHAeXaHv74V0mJ7LVKtocWWgrlxinmRrmmn
 NGtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWys0sBWjeSg/JTSn3KY/NlIIzRcpvxRfLkKVcnG66mGRACUlb2VRvmr8PUV7qY2CUFvIATLW7exeVN@nongnu.org
X-Gm-Message-State: AOJu0YwiWc0LdI68iEXuKvypulEuXi5jYEERwVY2lFtECrs2xyV1/g74
 3CbOCQMYhU4vYGEYgDWpMiCzn/beJdKBFs7SC2eP+FvmyyKPlkYSC96puCTP9bQ=
X-Gm-Gg: ASbGnctutVy1ck4xFWJ8XRnub4XANEQvwYiccLXyGVlG0Q4NKZHSLGx6RIyFUokrAjl
 AgO6S/TglO7w0eQ9yPSc1kre2uVUaI/S/rVD5tEebUCL97jplsUK3AZuhdLqsfYic8z+bYL8Ttc
 rF/7NJaorugjNpL2gZkRGVMi4d/5yLKi4z/b6SLmRACgtNMZwVB+WYODi7xNpBTrAVRb4aOnQ0W
 ZKj88m1FEAnl+us6F3Lbxr1IRjvhOB0Y1Roo2gOdAwqNEJ40J7zWhlqq1O7cHzdyxMePNz3d5BR
 nAF0sXZv4XeN+FuUku5lYH563vxPdTMjGlcGOyA9gAwn9IYnq+Ez18AKWmDUNN9Qc6gIkg1cVWx
 7cI+DTO/K7riIyD1wRg==
X-Google-Smtp-Source: AGHT+IHkl2miSLyxFy49HDxG/yj3YVlNrflkxgaj8LoU3712YCu8pXugNcpHb+0b1PK2pqniVEqckg==
X-Received: by 2002:a05:600c:1e27:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-43ee0615d04mr5098995e9.4.1743789258517; 
 Fri, 04 Apr 2025 10:54:18 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226a12sm4846330f8f.83.2025.04.04.10.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:54:18 -0700 (PDT)
Message-ID: <37d0e076-76d1-4035-9ce3-6d19707a730d@linaro.org>
Date: Fri, 4 Apr 2025 19:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 07/19] target/hppa: Replace TARGET_LONG_BITS
 -> target_long_bits()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-8-philmd@linaro.org>
 <85685271-bfb2-4bee-827a-a2693feaae35@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <85685271-bfb2-4bee-827a-a2693feaae35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 4/4/25 18:48, Pierrick Bouvier wrote:
> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/hppa/mem_helper.c | 3 ++-
>>   target/hppa/translate.c  | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)


> The temptation is good, but please do not touch any target code at this 
> point. We want to focus on defining the API first, and we can perform 
> codebase changes as a second step, without letting any occurrences of 
> the old macros/functions, instead of just adding "another way to do it".

I meant to remove these patch before posting, to focus on ARM, but
apparently forgot to do so...

