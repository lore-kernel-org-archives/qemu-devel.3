Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9F3E9D826
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9XUt-0005ka-9E; Sun, 05 Apr 2026 20:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XUo-0005jc-6S
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:07:14 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XUk-0007u1-GR
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:07:13 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c76b6abdb73so2447289a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775434027; x=1776038827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=slSFtjU1YjQyQth+eFc4WxP0SsRZFlbFNm+apaDVArQ=;
 b=iP6l63p+hYaDQyNULLq1Ems7QAYK8PxpM2dfb1Wz0bMR4dhA9m+b4xOUFOW00GLtE4
 IqT3iHO3t+zyITT/V/DhUDV8qdhbzbPzo4ZG2+mA01vpxXwjYnAPxH1I5UJ1p864bL+t
 Lp68nLwk1Xc15Mn3rG2BPHmU/SnKp33ajtH7ERbwlsdhPyo4ICEBf7gyXaLbgydfSvfs
 UENXz5q+ECZXD9BJVOQeRUXM9D1xIj/Es/RMgWwN3I4X47zA2QuBu98315Lt4xKzErc4
 dZgM4TFUetZnC0bqvmnKyZie6n2nh3LYR/BwMGOvCyYVLszTcOiVrzsbFyvyaKvTlgOx
 a8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775434027; x=1776038827;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=slSFtjU1YjQyQth+eFc4WxP0SsRZFlbFNm+apaDVArQ=;
 b=K3jPzmsXV1gzHubRazXly1qT6/dT+eNazsnfOaV67l2bko+eWqJlxE4V9vMRRp56Sf
 kUX38UxninvrAbGUU32zjy3fTeFhDxg/4GVwQERB1tSAugfVHTY3WEzon1IzjuwIgAL9
 kvjjtgMM0qsz5JZoE2aGmuS2lU2bf9oEU//dh5w46JjeijsbM5721HEHw1GYLA0MlBW+
 khGN2YYTAVZqu5dxHetsFKdixcZXMRvy5n8wiupPt2/1NxGxTheixtCPuZ/Zl1IytK6N
 UAlsv1F6Vut9HhPqr37AfRwNK7B4DzH6t7YkuU5nhSCtuGcEC/tduaXUYprtWGK9v8/v
 PNvA==
X-Gm-Message-State: AOJu0YxDUmseD65Co/G5fIKhtvLLrOYonnbJlz/zo+dMM8qX7kgvfL2/
 jpPc2vk4eaR1i0NthZ+k7mpmDU6y2ZtCJ3oyCf3kkK9c8wYt8eU32IVx5O0FP8avfhKUq7O3wmG
 uYQRb
X-Gm-Gg: AeBDieuk27Aq/8+vqc4Hle9xsZxmxfnvRiBL9jB5q1x6Kw6fhvpSAJGB1KCsLR8QH0c
 K5htW+O1L03uqcMSg8gp5/cQo5+XIzk/Ugf8nNR3uw71UHYyJWz2wEgJHIp9KjV7P8VL8kPOpTe
 lNOiAr/RTn4lg7ZF0K0IJWlPmaO0AH5cTCxOVNsUXlbGCsfWEFBitSEHmd87VfKcnLEv28QHNA0
 Qs4HjzV6GiXLoyzPYC/pijfqZUXFmxVO2yyQ3h7GSmsfaRLiZMlzBUNhDM3EWwcEL9uaLt/dL0J
 DbNEumi6spLjKLXY32FCfp+WiXEybGPwDaWAIfs10TgA46XoHTq/4kWRAQNqACPq/7D6tbGBLjL
 vVxRxo8AjaXE0hZDhM+/fQz+Y5H7qgaJZqCR9mz0qxFAeWIvyIFxBKR65hIQ23ntFYf8n75A+XJ
 DQKi8wpawVexz1Cw63ryz387ItRL+I/4Ws4QpUkeHvGRbYqVplGHb/dF43YkG8pQt+jGhX1PFEe
 bkdzw==
X-Received: by 2002:a05:6a21:99a6:b0:39c:8c0a:d09b with SMTP id
 adf61e73a8af0-39f2f110f1amr10533186637.49.1775434026510; 
 Sun, 05 Apr 2026 17:07:06 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c657e5f3sm10009844a12.23.2026.04.05.17.07.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:07:05 -0700 (PDT)
Message-ID: <2bb98586-c9b0-4b0f-828d-a4d10d40a14e@linaro.org>
Date: Mon, 6 Apr 2026 10:07:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/35] target/arm: use syndrome helpers to set SAME_EL
 EC bit
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> This removes the last use of ARM_EL_EC_SHIFT.

Why not remove it here then?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
> index 5214e3c08a8..07a52643e71 100644
> --- a/target/arm/tcg/debug.c
> +++ b/target/arm/tcg/debug.c
> @@ -56,7 +56,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
>        * Similarly for watchpoint and breakpoint matches.
>        */
>       assert(debug_el >= cur_el);
> -    syndrome |= (debug_el == cur_el) << ARM_EL_EC_SHIFT;
> +    syndrome |= (debug_el == cur_el) << R_SYNDROME_EC_SHIFT;
>       raise_exception(env, excp, syndrome, debug_el);
>   }
>   


