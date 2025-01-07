Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A54E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 10:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV6q0-0007aE-GU; Tue, 07 Jan 2025 05:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV6ps-0007Za-U1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 05:29:21 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV6pq-00042r-9c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 05:29:19 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43618283d48so110834755e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 02:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736245756; x=1736850556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ywiefD4Rhx9vcDIO5Klq9wrpnNmDphSG+IFS+CEuP1E=;
 b=LQsXDUrBaH65k7Vc3ySfa9Amx3z+8VVsWCvuXrBgad1lls/fOeEMZptqMVXUNnpjsn
 NCoWSi5aNnx/kI0M7t4LLbkP/8KJz4SDdqblO29Dbz75CtSznCTHS2bBtTH5g9cx9ucO
 VqrIal915QAs7JFLodHfWdYIoUU0YCLFBwsuCjXrtl+AvLWsfvd7BBBikGcZX1vvlNV8
 7Qgie87Tp41LSgY0XbQUPq18t2ZYxOjzZV/d32PaYTT+CILZeJ3CQr7y8Omz7k/+dFlL
 U6n4kBOK2DJ3BaVRqJ9iL+8HzPxnAATeXGQGZSsxFdsMJuRvhWP4wchdKiZjNglMqYA/
 Tm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736245756; x=1736850556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywiefD4Rhx9vcDIO5Klq9wrpnNmDphSG+IFS+CEuP1E=;
 b=V0QTFWMymJKold6fggw2pNdWNEdov2SklTqhE4zaOV1IMpQMMeTRMD29b3meBe6VFh
 tCJ9+2qMaj8tZPPcQA9F/wwwHk4dhTazSFWjXNNP7suWROB3PoW6hP5yvcniYcsgzSoc
 lfvCgYNjLOpcl34eOoKAUkCs63MiSafzWMFORl5j0R8KHqH97ovf75fFd751mTYLnnP7
 BQwkyjinEz695wOY79FxvhMmJPbsd6sibv9sLZJFaIMRXD5mESsRLeqysj6db4zjYrQL
 orxqcxKFMtYF1S0a0ID21XhsuF88vtQj1wL466vJ1Ho/QORvxLSW7KNhJmEViKwaMjJN
 Qoxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi8BBX0g5lViOl5O5Y/56W6RAQ0zCBKOi5Ls/Pb1So1zpLLnXe1gKzdg1cf9nFrrH0gPXTdCnx+ctK@nongnu.org
X-Gm-Message-State: AOJu0YwGyygWGyXpb+XQKElIKoeU629IlfhRLUr1hsQfZ8jBT0AptX4/
 6g5mtOomzAPlbONvCbCLmhoL8g2em75ux23USaM5dOdevAL193+ksYk6qd6XyFo=
X-Gm-Gg: ASbGncv/1W8PEdrYYUrMfZesy+AEELUiyeWv2AHV2yGWmRVUlOBicZUVbgeqmpudiJA
 rs6FIujpBEzQ26juaoFo1b4TD02YjavGrKGGl6OPCBcUAdQgS5WL7BRKpXEQvDjs9tYwBBKiv9d
 YWJybb+yQPae9ab34BNXWkaQaRzxBIuQj3b6BB2JrNK35+Ay2MZ6QJCZ/LxST6ymzutbztJlyl7
 A3cYlI+vkAImFXRPwd+1oL8pO8/9t62QO4eLbp5wH8pM8+BHWzDBf+QeqgNh4w9f/AlgChfB8G0
 xPeHXuFvUmyCLbcgQ0jFyKVR
X-Google-Smtp-Source: AGHT+IHdgu3rZd1SbU6BMBgcgFjCOU+/qPS2CA5TTfFjtfR950JtHj+BrWS9/jiOWwyqr5J1SO0Kaw==
X-Received: by 2002:a05:600c:1c22:b0:434:a1e7:27b0 with SMTP id
 5b1f17b1804b1-4366864338fmr490517525e9.11.1736245756052; 
 Tue, 07 Jan 2025 02:29:16 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366120088esm591097095e9.13.2025.01.07.02.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 02:29:15 -0800 (PST)
Message-ID: <05497e58-43ad-41de-b868-223aafa6ed3e@linaro.org>
Date: Tue, 7 Jan 2025 11:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg/riscv: Use BEXTI for single-bit extractions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com
References: <20250102181601.1421059-1-richard.henderson@linaro.org>
 <20250102181601.1421059-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102181601.1421059-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 2/1/25 19:16, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target-has.h |  8 +++++++-
>   tcg/riscv/tcg-target.c.inc | 13 +++++++++++--
>   2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
> index 10e61edc45..ea38ee5cbb 100644
> --- a/tcg/riscv/tcg-target-has.h
> +++ b/tcg/riscv/tcg-target-has.h
> @@ -64,7 +64,13 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
>           /* ofs > 0 uses SRLIW; ofs == 0 uses add.uw. */
>           return ofs || (cpuinfo & CPUINFO_ZBA);
>       }
> -    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && len == 16;
> +    switch (len) {
> +    case 1:
> +        return (cpuinfo & CPUINFO_ZBS) && ofs != 0;

Why can't we have ofs=0?

> +    case 16:
> +        return (cpuinfo & CPUINFO_ZBB) && ofs == 0;
> +    }
> +    return false;
>   }
>   #define TCG_TARGET_extract_valid  tcg_target_extract_valid
>   
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 12c3cffcc0..83ec7cd980 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -162,6 +162,7 @@ typedef enum {
>       OPC_ANDI = 0x7013,
>       OPC_AUIPC = 0x17,
>       OPC_BEQ = 0x63,
> +    OPC_BEXTI = 0x48005013,
>       OPC_BGE = 0x5063,
>       OPC_BGEU = 0x7063,
>       OPC_BLT = 0x4063,
> @@ -2307,9 +2308,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>               } else {
>                   tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
>               }
> -        } else if (a2 == 0 && args[3] == 16) {
> +            break;
> +        }
> +        switch (args[3]) {
> +        case 1:
> +            tcg_out_opc_imm(s, OPC_BEXTI, a0, a1, a2);
> +            break;
> +        case 16:
> +            tcg_debug_assert(a2 == 0);
>               tcg_out_ext16u(s, a0, a1);
> -        } else {
> +            break;
> +        default:
>               g_assert_not_reached();
>           }
>           break;


