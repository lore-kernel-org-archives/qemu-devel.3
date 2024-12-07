Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1DFE7717D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 21:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tK2nQ-0001ar-EB; Sat, 07 Dec 2024 16:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tK2nO-0001aL-Sx
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 16:57:02 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tK2nM-0005uU-Du
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 16:57:02 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea696c4dcaso1779995b6e.2
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733608618; x=1734213418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8HnQYRVJBjl/B1ZbZhLv6NEZbB6lt/Wz1EdDXsNs0Uo=;
 b=lB3EajJ9pXNIcj9m8XaANDE+GAaTVuK2MxaxnIogzU5FDVjKaQrosVT/aR7eCiYQEx
 pnKelMJ1czHpnmz1gYXspqf56WwzYewLhjnr34uYNSHUJskwkTARUN6oY2fR2bVPAZhE
 ZXl24XtOW1VfyB5pC4TgfTbSghniIIqWCTNFuFDx5y1fRMGdoV4MdsImFIl9Yifix7bA
 kxh6JfSa0ztXBnbtpFUJEOlrx3Ke8g7ZkfpESzqBVDCA0y/qwIkuXppYfQoeO0N06Vga
 zJCeGeIa3Opw9HH6lk+WYtYGgU3pOQNZXDY0F4zeQQemDf+kVg48UsmyIWFKUoKkp5Wp
 ktcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733608618; x=1734213418;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8HnQYRVJBjl/B1ZbZhLv6NEZbB6lt/Wz1EdDXsNs0Uo=;
 b=XUx3PWgM8SEeAtoFkk6zRr7gFDgaYjs7JRFZmz4iQK9CYlU3ZKMAYZjwffBaISKlDo
 I8qAIw7DqGWqMfN0kaP4vY2ClrAeHsfRcjZOaKaZm4KOEhGx0dkvFJb/5x76oVWwWRnh
 bnLEMzmuYuXG0ZioFoJYfiptGkExorPxcRiPjVPk13fqeGxlh5W+l/Kp5NKy/zGROG1/
 UyjwHKrp7PYyaFuoVzTIRwnUsBBJu+He2qpC5gwm3IY9tKx8lCAf8AHz0jTPgDNZCXXV
 bc9Lj+ROzvnr6Z9tDI/6ZOn9YErHlEOJOzzq/dezVNAHV4JgBqTgRO6NQivYZKMETS6y
 lK1Q==
X-Gm-Message-State: AOJu0YyZrr487ouMVjG/bB30tihSkBjZZSP2EeQIK5TtgHOQyoPE0/0Z
 yNHLcneuAgH3xoFTdmh1bS/WnrYf5H2TYjU8crsAZi6gG6sCDLnxE9ox075OifU4ZyZLL+SEaP3
 dS8uu9rvb
X-Gm-Gg: ASbGncticHpg+yPcjGqAPj1DnAiOLRNzNwDM8okk/IRL8148t979xa077IxsDf7SQt+
 i0q8maerAFxhg0wvS6RCuAj3Za86XSHyURwhGRHQ9MItiOLTW1cGGib2REBdziuA8Me2vpt5M3P
 DNQRRdthi8JBubyYVdzeaqPS2JoIXVmZHGpJYPf/9453w8qh8AKovXwQiaHMaYlxotOZeI5Gzgj
 YlvLcp9wjfhhu+mxmaoouzwLRqGv/6G/MpEH3rk9/0RIzxb0mz4JLvDJFlxs/9J0jIz5nAfwAKi
 Ha1hgEH6kla0+qnC0DWlfRbl6TBF
X-Google-Smtp-Source: AGHT+IFOxij0L9r5CP3YEQiW2d0YPwInnAE9ZuNIDoogbUSNkm/v5Bq2ctBlW4iaazY0pGoK38r01g==
X-Received: by 2002:a05:6808:d46:b0:3ea:63e2:1aa9 with SMTP id
 5614622812f47-3eb19c16946mr7477863b6e.7.1733608618669; 
 Sat, 07 Dec 2024 13:56:58 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b8bfdsm1434600b6e.17.2024.12.07.13.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Dec 2024 13:56:57 -0800 (PST)
Message-ID: <79b8fdc6-bbae-4068-ab29-08e32cfcc058@linaro.org>
Date: Sat, 7 Dec 2024 15:56:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/arm: Introduce fpst alias for helper.h
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-2-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20241206031224.78525-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/5/24 21:12, Richard Henderson wrote:
> This allows us to declare that the helper requires
> a float_status pointer and not a generic void pointer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 9919b1367b..cb722c491b 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -1,3 +1,7 @@
> +#define dh_alias_fpst ptr
> +#define dh_ctype_fpst float_status *
> +#define dh_typecode_fpst dh_typecode_ptr
> +
>   DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
>   DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
>   

This should go into include/exec/helper-head.h for use by all targets.


r~

