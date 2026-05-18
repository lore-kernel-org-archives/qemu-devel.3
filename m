Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B0BCD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 14:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzDL-0003t5-HI; Mon, 18 May 2026 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzD5-0003sV-Hu
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:44:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzD3-0002bP-Qg
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:44:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2babfd18435so9619885ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779115484; x=1779720284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LxGxP54sIf9Ea7LpRahtjVWCCrPJDxFOp3Hcmc0VUEI=;
 b=Gs4a9uz3DI8/9MbAvK7HkNA8QY31IPMkj5+kY1H0Johci07oYyNkZThCHob3gFCE3M
 Df8/5NIS0ErMDI+ePa7EXvCue1OxekV2NBwRUwj6KjsS554XIldrrOlvwOPl8lengLfK
 sNGcEBcXtOJ7Lz4/XHJ++mx6gJxGO5/8VCQ7Nd2ocyOXzSuEWNEsTsXwhc3m1L2AwgB8
 +pdP69UQLBcZwzt1/m9Ei5FGMtfpqauFvlsDUyzOdA2qHDnuA0PbJ56asiWeMh5oaF52
 fEAHDuR87HRUjTBA/MgEddGh3gos3sDlSLHCeGNxb00wTJx9KU1nYUbAc3dS2bOzbKpT
 gDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115484; x=1779720284;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LxGxP54sIf9Ea7LpRahtjVWCCrPJDxFOp3Hcmc0VUEI=;
 b=QNfOTLRGSJxQ/GZHHYwrNyToLi8QdUulyt+drfo33VMimQpnF+ndL7PixBdmp8uyja
 jXDK2CzF+7hH1dXGTVqYSOtMVhkL5ukGXUBsiNsZGBMlGsxbC/DZ75hqT5TLPH3yT7X2
 EJck4GOUEi9kbxYvU1JpWskqRGNjDqIc1gdaz1GVWZtH0Rcp1jkbmgQLBOvJR5leEHub
 5+pO7gIsalL/afoC4dXGGENnfeaw8H1ND2tPXtSbqLdBQdgQl6BKByFsVGzj9Rw00spj
 UQFFv1S+hFxrkymt6weFlnv16HCj+uV8Oqj0t36OYnMRDiLpORGO2deOgIv3sccN5jVj
 I2pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yRjbR2pPJGAKyrz39Amqn/n2Wlmqe/j8/lhMHqK3rDyoBOjm7LrS9otvUp9DF1pOwB1AiNt2CMeoh@nongnu.org
X-Gm-Message-State: AOJu0YxsobiLRT+jD9r5gqQRk/E3y0XRxUdhKTqwOfekJ0crLjFYiRPZ
 Wp7pfqqdJqQWQNfqJODe9LPEaz/SQqdeMj01kWOWmqorfayYU0tiMjmOXf5vjST3C90=
X-Gm-Gg: Acq92OHJK4TD8cuaaaR9ut6NmjixxiT6mYOdeVVgI33F1Mw6FcpDa1qJPHzF6vK3i8w
 8ZP4nXN2SA0njG8XPeu6JOHYFK9LLxJtQaxxPMj/QiT5sjsljx2VrhIwMStA1czd5ZPsKl1KsoN
 DjoLgomhGeu7OhkDEIqFdD5EHCNEjxttxn4rnowcyOV/YfD68RYhsC4YI8z24IChIud8pd5Qf14
 78Y2PlaURNIyfwbgFEMK4PC7b4X9IEKnY7va+vio+72wY/592fs+RlcsOn4e+TcTE+v5vkMIhKU
 XXaMnnvoYo2Z8of62Ab1e2F94G7yzaiLovEFWi2BeCySpq1JgLtyy/hP7vv8I7INzzpxygxlZhd
 g6GyNqA66d6Mb4JvuRZ81Kp9uJq5wgVw8dzafZtHWT3yRf1pX9IQJsRSM7r8iXU6N7jtSCVELFw
 znpZ7HMyQ/xsLIcxb1YYUTt0GhXjFvBrQ19WyZ
X-Received: by 2002:a17:903:990:b0:2ae:6259:5aff with SMTP id
 d9443c01a7336-2bd7e784bd9mr161663695ad.6.1779115483729; 
 Mon, 18 May 2026 07:44:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05fcb3sm157134905ad.26.2026.05.18.07.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:44:43 -0700 (PDT)
Message-ID: <2d7e1845-601f-46b3-813a-c5b3e64044e4@linaro.org>
Date: Mon, 18 May 2026 07:44:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 24/35] target/mips: add Octeon COP2 crypto state
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
 <20260517-mips-octeon-missing-insns-v2-v8-24-206151ee77ec@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-24-206151ee77ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/17/26 22:29, James Hilliard wrote:
> Add the common state needed by Octeon's selector-driven COP2 crypto
> interfaces. This includes the selector constants and storage for the base
> hash, AES, CRC, GFM, 3DES, KASUMI, and SNOW3G engines, plus the shared
> selector-window mode used by overlapping hardware register banks.
> 
> Describe the shared HSH/SHA512, SHA3, SNOW3G, and ZUC selector window up
> front so later engine patches only add their own selectors and state
> instead of rewriting common comments.
> 
> Migrate the state in an Octeon-only subsection so non-Octeon CPU models do
> not grow migration data. Later patches wire helpers and explicit selector
> decode on top of this state.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v7 -> v8:
>    - Split COP2 crypto state and migration coverage out of the combined
>      COP2 crypto core patch.
> ---
>   target/mips/cpu.h            | 165 +++++++++++++++++++++++++++++++++++++++++++
>   target/mips/system/machine.c |  37 ++++++++++
>   2 files changed, 202 insertions(+)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 346713705a..1c552b8134 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -537,6 +537,169 @@ struct TCState {
>   };
>   
>   struct MIPSITUState;
> +typedef enum MIPSOcteonSharedMode {
> +    OCTEON_SHARED_MODE_NONE = 0,
> +    OCTEON_SHARED_MODE_SHA512,
> +    OCTEON_SHARED_MODE_SNOW3G,
> +} MIPSOcteonSharedMode;
> +
> +typedef enum MIPSOcteonCop2Sel {

This enumeration shouldn't be required -- it's all decode.

> +typedef struct MIPSOcteonCryptoState {
> +    uint64_t des3_key[3];
> +    uint64_t des3_iv;
> +    uint64_t des3_result;
> +    uint64_t hsh_iv[4];
> +    uint64_t hsh_dat[8];
> +    uint64_t hsh_ivw[8];
> +    uint64_t hsh_datw[16];
> +    uint64_t aes_iv[2];
> +    uint64_t aes_key[4];
> +    uint64_t aes_result[2];
> +    uint64_t aes_input[2];
> +    uint64_t gfm_mul[2];
> +    uint64_t gfm_resinp[2];
> +    uint64_t gfm_xor0;
> +    uint64_t gfm_reflect_mul[2];
> +    uint64_t gfm_reflect_resinp[2];
> +    uint64_t gfm_reflect_xor0;
> +    uint16_t gfm_poly;
> +    uint8_t aes_keylen;
> +    uint32_t shared_mode;

I guess you're using uint32_t instead of MIPSOcteonSharedMode for ease of migration?


r~

