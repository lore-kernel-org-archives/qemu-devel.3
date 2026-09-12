Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1DDC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5LQf-0002x8-Ft; Sat, 12 Sep 2026 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5LQa-0002wc-N8
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:57:48 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5LQZ-0005Pd-4u
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:57:48 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso656540a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789210666; x=1789815466; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0+jDYbDcV1eCOnW9/MLUHb62nq1PLMDE+L/NA5LNbN4=;
 b=ljtJgHNR7kNvkl4XaO+6tOX32FfZZ/rvj1nDEXWDj2i1QejrWYKI0zV49QJMoxYzZr
 bz13/cUUutpoWR3dfQjkFwh+wfNEs1gPZqkqJTdKNabuUYZR0bPIroD+d1cjIsKxSTYp
 LTkCvcac1O1rGonXcDzZQXLik+0knoPHcYbfSzuUceecN8+oMFgZl7ibZcX3EFmVmzhi
 rQetYjY9uvOZIUjzZ6IJ7eAncU8WhSLhNCIyUpALvD0jU44K30w9D2SP5BjSnlIw2062
 Gh3n5fmaKJHkeyawWjrGP/QL+opIv1GfUDU557xpj1CvFS53SD/FVVPMllOb69ueSdfr
 xgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789210666; x=1789815466;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+jDYbDcV1eCOnW9/MLUHb62nq1PLMDE+L/NA5LNbN4=;
 b=UNsWBggqusRdgdv8KH6GyxVYXo8VsUyPguZQNRPSUHEuk6SElla0k4iBudyHiV1oC3
 2Hd2vNuKlvPuEEUh8QmCWfS8xI7eAfHMba9DamqwEJbrvmZOrNF+TAkJoVoGP2p7Pq4c
 fgaNPP/8kd/2c4V1+9YmzI0uFYYSmJMD0pEVxa8X4rnG7O0My46XOzBXuS+wZl7O+ktq
 EbBtRxEya9ZQ/jNYoAW80IPtfBlF72jzOv8s3U5movMkUze64+zmXh4NxlcMHCh0Zz2Y
 PiHbePx8zy4uVCSHKAaLnIITjt0SNn5HXcDA8whwHYB4zPLyDau2/MMWO9+Qp7O+TjUQ
 WJ0A==
X-Gm-Message-State: AFuF++kL1Em1cYjtJWxnFDqjakPhIDIZ81n+JxYV6JpD4G93gb9ntcty
 +lm72OCTONmFJX0vOddIbcI08Ctzv/73ShCDvElf2i3Xhar+Whf1o1KhXxRyucOXRFlwQnFyLx+
 vWXBWAbE=
X-Gm-Gg: AYBFou240uKTIzcjk9N7uoVpWnzKevM7z5viMxEQOTPd19499EXQX98ntjZ5+IKiGHb
 MvgAy2B8TJjBK2lX6xilAQErvfOBqqv2YHTsCLpjP7tuydBmD/EOq8SqUBhKW3hTb5fre5A7FGg
 /oBBdrhgD1W8aiznDIDkTH8hxvPof0YS2DWocbEKd1rmR7cnU4qwhgewtFDeAih2x6uDxI+bJiS
 2Kf6QrCM8ka9iXTVaiD9XyL9VCnhI1KmpAwPs/DlridwtBurFG6M2WgyeHgvANJqq4jCHxQC8JD
 zRvd1TuTcAIpAEtxqp36p660TsJL1KVDG/99x0hYlKSgAtiCYiWWd0uMCLUQqy8/X0moIae5HXU
 KyAavEonxFc8smZjHpx+5OYLsMVIWTxpUtFwnI8W97qfxMozHyU5AjpPdbB7R60LklrAPSFDE8s
 I4wYT8m8F83De6a/CMk9mPvqLKkIlN7cdsRX/VCDO5e7/DIC4fHN69Hvu34rkERtKKiZSL3qwVt
 T8gopu/e6onqdnLq4DCTHrt6FcRfmbCeKPAZ6nHcxNYJiDRm1E+CJOyl9HvCWIcq97J3n9x
X-Received: by 2002:a17:90b:57e8:b0:398:dcfe:968e with SMTP id
 98e67ed59e1d1-39d9c22762emr16761928a91.20.1789210665660; 
 Sat, 12 Sep 2026 03:57:45 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b97994sm23790795c88.12.2026.09.12.03.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 03:57:45 -0700 (PDT)
Message-ID: <ae3d8e6f-6e81-4457-b46f-391889cb6c03@linaro.org>
Date: Sat, 12 Sep 2026 00:57:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Enable variable page size for user-only
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20260912102250.597582-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260912102250.597582-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/12/26 00:22, Richard Henderson wrote:
> Sparc v8 has 4k pages, while Sparc v9 has 8k pages.  Because of this,
> userland does not assumed a fixed page size (at least true for glibc
> and musl).  Allowing the guest to follow the host page size avoids
> a variety of emulation problems.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu-param.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
> index 7ec4ac84dbb..72aa89bf66a 100644
> --- a/target/sparc/cpu-param.h
> +++ b/target/sparc/cpu-param.h
> @@ -8,7 +8,11 @@
>   #define SPARC_CPU_PARAM_H
>   
>   #ifdef TARGET_SPARC64
> -# define TARGET_PAGE_BITS 13 /* 8k */
> +# ifdef CONFIG_USER_ONLY
> +#  define TARGET_PAGE_BITS_VARY
> +# else
> +#  define TARGET_PAGE_BITS 13 /* 8k */
> +# endif
>   # ifdef TARGET_ABI32
>   #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>   # else

Even better to reorg this so that it applies to sparc32 as well as 
sparc64; v2 tomorrow....

r~

