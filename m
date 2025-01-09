Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B35EE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1TS-0000j6-R8; Thu, 09 Jan 2025 17:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1TR-0000iu-Gl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:57:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1TQ-00088B-06
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:57:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43635796b48so9709475e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736463474; x=1737068274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wH+K6oUpzDH4Za0j4WDbFTRNWu1mcAEUP1Hbot4NK0w=;
 b=NuwAkmqmtOc6idKFYMpI2ckoWhwd1UI7ymh0q8mDX2icerzf+FArYV8n9LLXrZ9fx8
 YnzV/dxKUqSuBYB7rHpr/9o83CvBRHx52YayRV623s0fGfbyMDZci0T0sarwL+jY1QdU
 /Suob4rToITSyFbpFOdhxYclMsEgmtBmJ3co8OyaPMFhJpQ7IhKqu2xckZ3DlM9zBi4g
 5vVKWN6F8yUxWFpJC77ufeu35cx9bHj1mdm9Hdtxr7PdmDIcbRaOHVeZAmKH13XSi6Er
 DWH0p/8GjHU5qZDRCTTAROqMlFgl7VyjChiwmwsCYj9vIO9D1JJK2ix2BsdGk7ySwh2Z
 3Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736463474; x=1737068274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wH+K6oUpzDH4Za0j4WDbFTRNWu1mcAEUP1Hbot4NK0w=;
 b=MF1bvpcuEb9Bnm4UGQeMT8nGPW1KWGtrXyeAz5wY9bp0t770Docugg+v8U4JTwkmRj
 NuKAR7s0N+EwLrWcvTOJ6cjtMDRbnXt3F7FnoM7Vpv8O2D5IAjVbCGLOR7i+Zd0T0l3Y
 u6e4acanKs6rXVZPmWwh5oD4thC8766DR/VWKlDnkzsdExRfHHZYRzJpK6eNNeHoHDpQ
 tezAO6wluVNmVGRb+ujLCdfW+8xAlnb+GKk2OKxIJ46PiCAqbP1viouyUmkoROSoyWRT
 I8W1R6+1GDID+EOMm3gVU3kR+8pn8jr47LU7FKjvgBibQx58inmqRBEXVaS7ZeYhQVRy
 7YNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqrQE3etHoIDj5PYVnT4FetL+42X2eGv5t4HrYGQa34/7jsFuvDxc6gUHlQ73M0WOYBxNlMH5HhEsF@nongnu.org
X-Gm-Message-State: AOJu0Yy7xkxXy4Npne25sBj243Aa+BW0EKdnPJar5LFtLz8UNyp2VplE
 y3fAo3vbW8pdRzw6MsGF9p+qjCzrWB/UIb6IyWxmxsvhwLP+3CAsiYi36bmRl/s=
X-Gm-Gg: ASbGncvSNJSZ9SbM0Tb/Mo5fbABEH/Fql9ikHOzJdf4c0WihOFc5FTHzJQtCPBMhOU2
 6e4IOsOZEJkhl0Ip1Kx+KDr3DOQ8firD48hzD/8KwzPe5t0n+CrWpMfIH7pkoZ3U51pgNUxC7P3
 smO6fg1mluy1v/lbD4AAuUlFh3poXvsuH2ksi7+/6MpRCNVrG2mTDh5mBWIrJj4UfGj+ikxj8Ce
 T+A+3d1LDhnK+rBLdbsXnzEuZj53igXpLMAQo3eFt+VEWczCyNQxo/0ju4mxDGBKPS42aMdgUAo
 v6gUjzsdLFpvMSQOsTsj8GPY5QI=
X-Google-Smtp-Source: AGHT+IErjc1OGztfQhzyNwG+Mwpnr1/VRV5+qTucrZe0FUJAcm6KZAqNXWqwkh9i9zJg1JGNkd4EBw==
X-Received: by 2002:a05:600c:458d:b0:436:1b86:f05 with SMTP id
 5b1f17b1804b1-436e9d7b925mr35297815e9.11.1736463474148; 
 Thu, 09 Jan 2025 14:57:54 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1bebsm2903368f8f.95.2025.01.09.14.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:57:53 -0800 (PST)
Message-ID: <5312f830-c530-433a-a000-4c9ea1cc16d4@linaro.org>
Date: Thu, 9 Jan 2025 23:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/81] tcg/arm: Add full [US]XT[BH] into {s}extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-38-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> The armv6 uxt and sxt opcodes have a 2-bit rotate field
> which supports extractions from ofs = {0,8,16,24}.
> Special case ofs = 0, len <= 8 as AND.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target-has.h | 17 +++++++++++++
>   tcg/arm/tcg-target.c.inc | 54 +++++++++++++++++++++++++++++++++++-----
>   2 files changed, 65 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
> index 316185500d..d6ca35ed1a 100644

Missing:

-- >8 --
@@ -41,8 +41,8 @@ extern bool use_neon_instructions;
  #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
  #define TCG_TARGET_HAS_ctpop_i32        0
  #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
  #define TCG_TARGET_HAS_extract2_i32     1
  #define TCG_TARGET_HAS_negsetcond_i32   1
  #define TCG_TARGET_HAS_mulu2_i32        1
---

> --- a/tcg/arm/tcg-target-has.h
> +++ b/tcg/arm/tcg-target-has.h
> @@ -82,4 +82,21 @@ extern bool use_neon_instructions;
>   #define TCG_TARGET_HAS_cmpsel_vec       0
>   #define TCG_TARGET_HAS_tst_vec          1
>   
> +static inline bool
> +tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
> +{
> +    if (use_armv7_instructions) {
> +        return true;  /* SBFX or UBFX */
> +    }
> +    switch (len) {
> +    case 8:   /* SXTB or UXTB */
> +    case 16:  /* SXTH or UXTH */
> +        return (ofs % 8) == 0;
> +    }
> +    return false;
> +}
> +
> +#define TCG_TARGET_extract_valid   tcg_target_extract_valid
> +#define TCG_TARGET_sextract_valid  tcg_target_extract_valid
> +
>   #endif

