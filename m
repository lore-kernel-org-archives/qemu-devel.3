Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF531076370
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7oMm-00022w-KM; Wed, 01 Apr 2026 01:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7oMk-00022P-TW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:43:46 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7oMj-00041S-Av
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:43:46 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c742d4df00cso265922a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775022223; x=1775627023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1dzfpJzU6CmcTkrKo+GaBiwdTe1HzTxbeV4CIuodwys=;
 b=jlTZpnv5iP9TubIr5fW8jEjqu/7gbaI0AT3z4E0HJtzym9kBmNEV/64d9UcxtVbAGH
 IOx08bAvBA/QrcblnMtsfHZm56iCe+yf44XuS0s9yy5urKRsEyVfhZY91l+PRmBLYEsT
 lgYI82cTQ5Of2D2GtsddR8AjzpYHWE0ysLHwku2cT3BvgbAM4tGK1xgsQtv3gNYpNN4Y
 0PLcvkNz6ZIE1YFRoCx/8ePE8L6I3LzJIAsUsiq0LOJp3sDM0xCH5HknAdeIlc3pundT
 YT3kIG2hKLTUyT4KI702Im08/8k1yzDqi85a4EzB621hQGQ1ji9+DzPgLg0LpiXOxDs5
 jHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775022223; x=1775627023;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dzfpJzU6CmcTkrKo+GaBiwdTe1HzTxbeV4CIuodwys=;
 b=aby5+xUNinAP4ik/jp/eB9dNfw3rZ+hm9j9QqMlEwHCbq/2kYEwuJYQsDXhu54KZZn
 YImvlHgb4Dwa6EXo+f5i9vSkJNr+zWD+5YSaQQTnpWLERbv2b47CfjVS2ZjNuvuS8+y2
 qT/3NfBcnFFHGsUDhBZ49Gd/ggl8kgq7qiRy2Q+DNiXLY+d+eXJO/3Fg6O+35GLRA/P6
 obhq285CU/JF87W8jGHSza291jxhKu0xAdpSHhYHZJ1bbvJiXaxv7GFFhdi//vy6SpF2
 dz/2ps32MDtz3LgADduRMk2GNoyL2ZMdYuVe7QOptlBavEKJD8aDDQmdy1zyM47zugtt
 7xHw==
X-Gm-Message-State: AOJu0YyQfj5eoton0wJa43THnu1IE39XJPRjk9d8cuC+q9yS2N+KGbOz
 wagUdsb97bb2u4lyvfeTxDfPwJQ4AXmbnGMByDndI5+zzOXvv1cyIhmeRZ6TtsPcgbC2n5A7JE5
 Rv/ZuDk8=
X-Gm-Gg: ATEYQzwUJ7fj/4BVRqNug9Bj++Tc7SDPXUaWi5WKVCjdkU+GXIW9bgbHw2qmcZp+c7G
 +nJYSO+zEKMhzEgDriUl0j+hI9CjZuMRujM9y782itGKlysJHvcgtinbVnUJnaI3+mVl2Di0gth
 DuG2GkXXsqc645CbcjlDE/vhgMB8QM472o+w40BzxenvWdoW6+U98Foory32iRGLzes0BkqOnNe
 XlkOdAxwR35IP0Lkll+Mhj3GF7qZrHZSveOxOLswm8FBzvZgpL1caknKZHVZfeF4DSd6TL9uDma
 3fSr4AaR9DvmNf/aqqQsC7HKM7Yn/XLzG7VY2D1qxE+ckTAFf0xO+yt4STi8pBDTjWZUGLAxG1D
 glRmoQpX4RyWKyU1UbpEwymU8OJ5b47pztTeu90h94ityhiLonXUCSAu7C3Pm0rR06Dd/3AvyjV
 2Mjdb+Q8w52/idQxRcisFqrLVloHv96gwsHzWapnHcWm50tS02W4EMQnL3osp4dMkXy3XZ4SgYU
 M5MX4q0BKXxcg==
X-Received: by 2002:a17:903:1acd:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2b25eeb97b8mr58623485ad.13.1775022223344; 
 Tue, 31 Mar 2026 22:43:43 -0700 (PDT)
Received: from [192.168.68.76] (122-150-206-150.dyn.ip.vocus.au.
 [122.150.206.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242765d55sm132505475ad.41.2026.03.31.22.43.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 22:43:42 -0700 (PDT)
Message-ID: <595c4e17-c6c8-4281-bee2-8ed50d27d582@linaro.org>
Date: Wed, 1 Apr 2026 15:43:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/35] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 3/20/26 23:05, Alex Bennée wrote:
>   static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
>                                             int coproc)
>   {
>       /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
> -    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
> -        | (is_16bit ? 0 : ARM_EL_IL)
> -        | (cv << 24) | (cond << 20) | coproc;
> -}
> +    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);

!is_16bit.  I'll not mention it again in the series, but take as given.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

