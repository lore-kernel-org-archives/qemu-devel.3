Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC90AF8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVlw-0007IN-1r; Thu, 16 Apr 2026 19:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVlo-0007Ey-1I
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:05:12 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVlm-0005O8-7V
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:05:11 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d95017a68so64075a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776380708; x=1776985508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+6veR2pGHlHj7K/mhDttRxbVu6/5iF4oun6Ke7K+qA=;
 b=IuR1goEanX5HWcdbRhYEeO3SE5vVP31BpFh3l0IWoTJIw20FL4WmrvghJ3uLzl6OqC
 I5AAjvuAlcDYiqKTR1ojT6poM1pN1vWiY59te3vW1cafViavibVnGWyAWPjZEL0IShmR
 KR2t7tcEdV/j4xc2iuTviuDLfOJAHGburKq8MNtgXqU5R7bFa1F3/bd1aLw150C3PBpT
 IOw6+zuOqdbbTHpKz+lWHYtcKI3/5u9gZ7Bqkysr/AGms16iTHGhccfYgNdZbbWcAgUn
 dyY10Otr1nkV5uyhfv/DwoQGOZ0xtTb/o5O8kV2w8hcirNBVDs9RmaTrifynuyGg1GjH
 FIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776380708; x=1776985508;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+6veR2pGHlHj7K/mhDttRxbVu6/5iF4oun6Ke7K+qA=;
 b=FArPqqiXHcLO3iK2T9QJ/OjbtrtcD5D+cN5Y6AQLJI6UOQGX0fgTxmg4TpXlVT2os0
 e2wPkODZu+VQurIiA31LN1/h7CkpidCVrwrDzXmWw41BThwJVlKFtn+Xug/tdpSlKtof
 ewWOJcU0ifxTotLyWs3WWZd+9tqEaKWXNVdcFKmSGWNdTJXx5fRNyGmqmmMP4P5hyNZI
 H3Y8WWx7iK0V06Jx7FdqVx9rzL7rP0EZEbkkb2ZaG5PTCACXwhfMsUSvF48CR2z9nh25
 dCg2bU05IVZBExlizw57XFuBhQLKnCy0XkRJtIl7DXykqWIdMREa/fqmUYmb+vFrPrLL
 bRTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UpjMc3WXRlto7A8WexOF2dz81u5uvsyrNhFAZzSiyw/CYlOQLI5Z3gCtZZlNcj7JNwgs6yoxu04BY@nongnu.org
X-Gm-Message-State: AOJu0Yw9lt59dH7pSgI0I8yT6mHfp4tEpUwfvZQ/yB3kbaIa8ohvIdYI
 GZ1G/W7TtNwvLFkecT3SwOLDfDvmLkjW9BPDVMT+4xZbExh+pYx6rrvYsEsPaVda0Nc=
X-Gm-Gg: AeBDiesDiV2hn/6waTZ75kUnZ9o3QXkxxsoFUUP6vBL42gksX+6lyACFOSKXr0MPj4g
 nr7Y0GW4LMyD7pVxnuqvwZqe+P0wHVOV0gLMicuRG47B5N1rQGoUOhVxrtdG9PkZL00ArcQDkJP
 Ad5bbQzmxOxjxqeTzJIPaAu7LB/OM3dkv2fmJBD+lDfX6ks9QIgSImczyPPxzPclgnVj5GrHpX4
 cjSSKYFFX+hLq0AaBr/NPPhLMrwpBVb0oaqMMkWODlTdsR672Oe1nxhpskJlrIUA9Om/cOmtFjA
 P6Rzn8Mlzk5fNr+KaNTyA+tYnFVdiG5waKJvzSsFdWOOnf8rXnBxzyz4S3r/S5JO1Amm3wuMJZS
 xZ9gTY4aVQDfZpdeCFxiiWgeyZFwruQr76Uih8rX6cv4BWkpUeVMA5/ddv7QjKDU6zlzJ6HJUq5
 xCwC29U+pFs700bOcz6/jBEXNN8NAQbzI6jplSBXdI1loCp1qfgH7q+N7KgbZF4Qw7rxRdmLcVI
 yIsHZWgu6HRjQa88xKR6wbBIpCrsJPodH9pVXEReH3R9UPErybR+WKJVVrhb6Rrng==
X-Received: by 2002:a17:90a:da8c:b0:35e:581c:6bca with SMTP id
 98e67ed59e1d1-361403ca597mr324739a91.3.1776380708156; 
 Thu, 16 Apr 2026 16:05:08 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fe07c7sm10988a91.5.2026.04.16.16.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 16:05:07 -0700 (PDT)
Message-ID: <223c45a0-1fcb-4976-aa3a-89b8127d04e9@linaro.org>
Date: Fri, 17 Apr 2026 09:04:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] target/mips: Remove unnecessary target_ulong uses
 in LD/ST Multiple
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416210508.30686-1-philmd@linaro.org>
 <20260416210508.30686-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416210508.30686-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/17/26 07:05, Philippe Mathieu-Daudé wrote:
> @do_r31 is a boolean, @base_reglist a size (size_t) and @i an
> unsigned index.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 32 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
> index 7be2cad89d6..fdc192e9c14 100644
> --- a/target/mips/tcg/ldst_helper.c
> +++ b/target/mips/tcg/ldst_helper.c
> @@ -228,13 +228,11 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>   {
>       MemOpIdx oi = memop_idx;
>       unsigned mem_idx = get_mmuidx(oi);
> -    target_ulong base_reglist = reglist & 0xf;
> -    target_ulong do_r31 = reglist & 0x10;
> +    size_t base_reglist = reglist & 0xf;

Why size_t, for what is clearly a 4-bit quantity...

> +    bool do_r31 = reglist & 0x10;
>   
>       if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
> -        target_ulong i;
> -
> -        for (i = 0; i < base_reglist; i++) {
> +        for (unsigned i = 0; i < base_reglist; i++) {

... which you later compare with plain 'unsigned'?

Using 'unsigned' everywhere is fine.


> @@ -252,13 +250,11 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
>   {
>       MemOpIdx oi = memop_idx;
>       unsigned mem_idx = get_mmuidx(oi);
> -    target_ulong base_reglist = reglist & 0xf;
> -    target_ulong do_r31 = reglist & 0x10;
> +    size_t base_reglist = reglist & 0xf;
> +    bool do_r31 = !!(reglist & 0x10);

You don't need the "!!".  That's implied in the assignment to bool.


r~

