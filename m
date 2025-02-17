Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F96C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwcw-00068V-9B; Mon, 17 Feb 2025 03:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwcu-00068I-OP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:37:16 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwcs-0003OB-Vn
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:37:16 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2c4382d1so1463922f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739781433; x=1740386233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fy3C8j71VMbU3Urqr7xiCKxC8UYQMulPoOrpYrWTXgU=;
 b=EmEPfGKjEDnkEDO+bozcGdrPrBeE28U2ArD3XsE84mBWnEsNgyPpvb9Zal8Cr0eq5S
 YcOSagaYnop33+LuV7jTgWVakA7sJ75qrPi139hP7WCjRRpwT0SeRTUia06Oh54EOqiN
 x+tE2zMSlLif1PAH4nbS2yD/Dg4ahIXWEd2uWC79+uxZoNygvTCK9ZXvkD+QmZndSExb
 4dO0O+1TZFGAPFsSewvuRmCCkgktYRDExWLGFBnwf7UZi5olil6sj4XuYQipR6D9kHdz
 8nHjOWXD/FeSNUMJawQIaDTOjFO++E/RM8LW1EUcrxED4yaC/x7Tuqg8kNs9KWq3rXtf
 DVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739781433; x=1740386233;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fy3C8j71VMbU3Urqr7xiCKxC8UYQMulPoOrpYrWTXgU=;
 b=uX/vHyCcnDy0/oKOipayWlTWm3Uyvo5eo2PgqisHxVKfZ98XoeYW5jVGvGO67LQHK3
 bDU238C2ePnGCH+ETmnVl4ZM2NTI4Sp5wMadbkQ69RUcuEd7WBbvngMekgck/aSnSUK7
 c5imWHVg7aa7sBsM2ia2uf3ljvTws33QBaj3cI9ZKsCLOIVV1Wow0bd5YqbmYUrpFl6i
 7uPTYk+AX4W2TlFTZcDncPeJlsxtPUbeiLNqytawbk8pbBmWiOnA7NDYD+kbeY0RbiN4
 d4UsyDVuCzfYUKUGY6sHTXPT4mxVAqz+8Oe661MEj1UQIBtZf3l7VYX8MtZiHZsJPWAi
 nzow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZfIvt6Vjx8y7E83cv/EWIkfDAEZ9xTHvTA1AyPIgqNycSn0dEe7DQ8gWpVcRPxFRZzlvR2sCfZ+F4@nongnu.org
X-Gm-Message-State: AOJu0YwLk1kO9SXhE3sVCs6adVEeKDfi0bGI3ENIr/4UQZmMQQcuW+Bi
 7S2RBqvyC/1jA4wnk4cHyVc6FCMub8R26WIgHegiopPLRwR9L9qIbNwji+0ttaeu5a2OWaQDHhM
 u
X-Gm-Gg: ASbGncsz8FpndMgjorWT1RpjhV6inDP/qDasEbXNAQLRdhprSQnHJnyaQjVxFfR7LFz
 maaMrcLmPmBzYtskcMO0JL7o71LbbBKpw0HXuSwgl10jZtYqILLKMpN1UsKI70s8OM82YpD3Rdx
 +SqqG1DgOc76eZkJ8EcZaedQquMI1P/66KXdMv45968YoaQtFfqO+yOnel40fh+2wdcw/2dHOtx
 t6g1H2qI31ZB/eD58W6qvQeOQUHtb35WrvC8dgMP8VVGttT4wn8L8B8Aqijku+ZeECNEQuyeX1R
 l+NxvxoaotWRjB7suxoJWK9GGHRBNg==
X-Google-Smtp-Source: AGHT+IEE3hHTyFMOWCc+0akpGXWdQNfCCeC9MMaqr8wwrDBDhLUQie6EHOA36cSFkG4eEkFKMJ5zCA==
X-Received: by 2002:a05:6000:4024:b0:38d:afc8:954e with SMTP id
 ffacd0b85a97d-38f24cfa3dbmr19556947f8f.11.1739781432901; 
 Mon, 17 Feb 2025 00:37:12 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccdccsm11641565f8f.24.2025.02.17.00.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:37:12 -0800 (PST)
Message-ID: <d4b80040-9b33-4e84-a7e8-18c5197341b3@linaro.org>
Date: Mon, 17 Feb 2025 09:37:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 057/162] tcg: Merge INDEX_op_sar_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-58-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-58-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 12 ++++++------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 12 ++++--------
>   docs/devel/tcg-ops.rst   |  4 ++--
>   tcg/tci/tcg-target.c.inc |  3 +--
>   7 files changed, 18 insertions(+), 26 deletions(-)


> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index a10fb67da8..edf5c1c77a 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -446,10 +446,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>           }
>           return (uint64_t)x >> (y & 63);
>   
> -    case INDEX_op_sar_i32:
> -        return (int32_t)x >> (y & 31);
> -
> -    case INDEX_op_sar_i64:
> +    case INDEX_op_sar:
> +        if (type == TCG_TYPE_I32) {
> +            return (int32_t)x >> (y & 31);
> +        }
>           return (int64_t)x >> (y & 63);

Directly:

     return (tcg_target_long)x >> (y % TCG_TARGET_REG_BITS);


