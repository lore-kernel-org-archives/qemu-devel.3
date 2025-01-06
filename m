Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FFFE77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUuyv-0001xB-TY; Mon, 06 Jan 2025 16:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuyr-0001wN-D4
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:49:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuyp-0005g0-Mu
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:49:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso65845985e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736200184; x=1736804984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tvSmWWxJBaU2Q2R3chhzfZ+WOW9u/Z+l48CxifzB8JU=;
 b=BCcjElDNMaWmQCYtDJc7Xv3GoUvoaN5ijoSk5rhDwhEs7lCqMxkJ5SUgvU9ZtuLTiS
 qrSByAuaMLetnfQa9kpyx8p1m6a3/maxRN+y3JnBLYVxDiA2tlNUgx12wExix+y4nxE5
 y6ypJfxWMrwfkrDnXPrMdCz1mRn4rrlrS2s+7wtoLYkZnR1LERy4wPDyp6q+61WJRb4P
 WSUdXrK8Kc5itq3ALJ0gxQEelJnsbIU3NrXp9cjHGqAlW4mUho7+bJOF/5OS7W5N5ICv
 umQRDyOyAtl1KNrI/BUrQOx3yxAVLFHtY9XoeXv2BLUFpZ2f25xk1BYi0uFk6n3ecmuF
 ft5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736200184; x=1736804984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tvSmWWxJBaU2Q2R3chhzfZ+WOW9u/Z+l48CxifzB8JU=;
 b=YoZLPDLNyQXt4kxr37ntMiOCyZMTH2acYmQ8srms62g5aGWKR0eisLu9dv+rvBpyee
 BbCLfi6YmK+6ZhjhsRkICukIzYsnJh3c30PSWOyoYVaf7p8p9EGaNrQHQCh8vdjmgW+j
 dA+GVSt5Kcx/lO15bPNcyh5g6A7q4pwq9D4y7XUAfdr6+zHXdGMhNDjTxrc0xdDSKGnG
 A3DLqG6kwHh8a4ta/le/K3mR91f0nyKRcGtpCvsyn+l+/imNyASVgvIAQJCXrsU1FpBF
 duA8EGdVASkZcjh/8GMPAzJd2f4Q+bIv2eZM0kMBSJXRFZebsODoF1x/PAH7PqIQFEhA
 9xWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQP8Pog5ARVMA4fvTvPlvw31v1QHSkBBamqx5yF6fze06e8LlQsjwRBbgfh4NVpHr4CVtBkcRg9iEn@nongnu.org
X-Gm-Message-State: AOJu0YzWfo4vB+rtJacY/lwDlK9p92bL7nPkxYpxWckeT6LKb85TglxH
 9i2DDy8omUehiBIwaqHvEUKuHSSXtbbgCNj/PG971Svj2EbZoEC9tHfHaRkf/C2Fm2YqF5Mwsek
 CMEg=
X-Gm-Gg: ASbGncsVlyhI9vqVhCLeEOMZK4rMD+xj97v4veGdAhV5C+aaoe9DW9gs1zWEsx/RjzU
 CkHPItXSOwvau6S1AJY8eKUguZPlLl5uICXO1wAi2vMgYhqKhfjGvCYMFR2Cq1Y/GNbHfoQZBT6
 vAgvc2668fYvGEmY+i1iYfjB29yM8f0IFQG2u6WgcfDewTT8OuN1HPd6COdLqFV17zA0BI2zkkD
 I6NGYkaYydzYWId+OGx2g2d8Mta/QULe4RvEZBnFp9FXx9nh0nhuS+qizK34p0BE/a1kbwhR4pq
 KuqLQHsPRJn4oarBC4erFuYj
X-Google-Smtp-Source: AGHT+IG62Gw3E6K2ZCBSjoxLHqY+RM875B/itMWmdcCFy7dMsvwo2Z4jOjGKqXdyAs5kfNHLBbY3vg==
X-Received: by 2002:a05:600c:4586:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-4366864364dmr527580885e9.12.1736200184352; 
 Mon, 06 Jan 2025 13:49:44 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acc02sm48253776f8f.104.2025.01.06.13.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:49:43 -0800 (PST)
Message-ID: <9342a208-5a9c-4737-ad9d-1b115b66ed47@linaro.org>
Date: Mon, 6 Jan 2025 22:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/73] tcg: Merge TCG_TARGET_HAS_{div,rem,div2}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-22-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Richard,

On 2/1/25 19:06, Richard Henderson wrote:
> Pass a type parameter to the macros; this is unused with these opcodes,
> but will be used with others, so keep it for uniformity.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  24 +++---
>   tcg/aarch64/tcg-target-has.h     |   9 +-
>   tcg/arm/tcg-target-has.h         |   7 +-
>   tcg/i386/tcg-target-has.h        |   6 +-
>   tcg/loongarch64/tcg-target-has.h |  11 +--
>   tcg/mips/tcg-target-has.h        |   9 +-
>   tcg/ppc/tcg-target-has.h         |   9 +-
>   tcg/riscv/tcg-target-has.h       |  11 +--
>   tcg/s390x/tcg-target-has.h       |   6 +-
>   tcg/sparc64/tcg-target-has.h     |   9 +-
>   tcg/tcg-has.h                    |  19 ++---
>   tcg/tci/tcg-target-has.h         |   8 +-
>   tcg/tcg-op.c                     | 136 ++++++++++++++++++-------------
>   tcg/tcg.c                        |  12 +--
>   14 files changed, 139 insertions(+), 137 deletions(-)


> diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
> index a6c7cdba5d..6734fd63e7 100644
> --- a/tcg/ppc/tcg-target-has.h
> +++ b/tcg/ppc/tcg-target-has.h
> @@ -16,13 +16,14 @@
>   #define have_altivec   (cpuinfo & CPUINFO_ALTIVEC)
>   #define have_vsx       (cpuinfo & CPUINFO_VSX)
>   
> +/* optional integer instructions */
> +#define TCG_TARGET_HAS_div(T)           1
> +#define TCG_TARGET_HAS_rem(T)           1

Can you explain this change?

>   /* optional instructions automatically implemented */
>   #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
>   #define TCG_TARGET_HAS_ext16u_i32       0
>   
> -/* optional instructions */
> -#define TCG_TARGET_HAS_div_i32          1
> -#define TCG_TARGET_HAS_rem_i32          have_isa_3_00
>   #define TCG_TARGET_HAS_rot_i32          1
>   #define TCG_TARGET_HAS_ext8s_i32        1
>   #define TCG_TARGET_HAS_ext16s_i32       1
> @@ -52,8 +53,6 @@
>   #define TCG_TARGET_HAS_add2_i32         0
>   #define TCG_TARGET_HAS_sub2_i32         0
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_div_i64          1
> -#define TCG_TARGET_HAS_rem_i64          have_isa_3_00
>   #define TCG_TARGET_HAS_rot_i64          1
>   #define TCG_TARGET_HAS_ext8s_i64        1
>   #define TCG_TARGET_HAS_ext16s_i64       1


