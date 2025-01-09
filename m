Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F4CE7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1WJ-0001Yv-GZ; Thu, 09 Jan 2025 18:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1WH-0001Yn-V4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:00:54 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1WF-0008TZ-V2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:00:53 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso11240625e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736463650; x=1737068450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YjygxAKM95Rct/ctuPEP9lcVB5DIBN18J/oGiX4mUww=;
 b=v9S7EHnbVRLnvSa82W3hg9B3YuNMXb5U4eLNdF3bIcwdke9H4tho9vJ70mVVAgVFh8
 1sLydnRoYQowjmXqFrXVaYArWZ9SOBWranE14lRoYE2/PXZEz3sBw1VBYUwjbRj6dpad
 NW1iA4DR6/dUprInt1cZpoMvRtyrMtOHcfmxxfMpW0XQkaiKBC5m7jRPntr7BYGPRd2E
 lAU7kTH/6dIhedp5GXbKy7VNs++blk/xvqDlRt9xfhwwXMH7DWWPJqqAs6Ow6xVziN8v
 ZbCQaDjXYbq4ehOuVWIzOPVbGx1jUDmBEGpFS17SuH11A1eRO7282/uD3alz+XQxz6TW
 PVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736463650; x=1737068450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YjygxAKM95Rct/ctuPEP9lcVB5DIBN18J/oGiX4mUww=;
 b=FJXe6bhAvcqetL+TP7kqF7VlG00KYAgkLEqQRoa1g81otF5/Sc6D+2ov6R1+uSn5lm
 GjxCQIQPieAW6rMxqdmMsAnBsYyhwfatHWkBA7RJSS9dFOd+jlRpb6TZkSxtJiYq4LYC
 /KOL8dKW9BuwD5eH+ZAtHRqIIA8xfwrw1hBXOOTuUKGxZixxJa++OMH3Jb5Oz461YDZe
 qNkbbnpiKI9TB3DJY4bZmDdI3SkfzZolbIdXO0AE9Zkpv4Bjy+41YBoXWTW/tvEn6owR
 MzUpeQ0AWn0bH99665pCkLGy75dQxZZMnKPPcN3jVpjxTrYBII9I2w7blzwLg/VSFPHy
 owJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU60lTkaO7cc4oRcYvq19nhWEIZUBfZ0o48bO3oLZPgqybCTS82VQ3eg6zFWGRETH5OpGjY1Bx1llJb@nongnu.org
X-Gm-Message-State: AOJu0Yzi72vMzv/CXAmrUAh4tZgDAnyGyMSQWnlZyUd8qJEMvOxmYdCi
 nMybVxaaJtL0EpjMguCmdMcEkLoT3yJYTL+6Yd6BKk0LFnOzYITWAO99wGDcZpE=
X-Gm-Gg: ASbGncszQq1ixARZj3/74JH9TEy0Jd5o4IeBwulv1kx4IwCZCg1BATSCj08ff6PFlPh
 bWFhxv9j9HWrt036C3aHrBv/IF+U1PsZS6CMXgWTHpemBdD8x2da8lxhZfeHOkpPY1haM6BW8hn
 upHGv555cgdtz3N0pKMzOXK3RnSo4gAlJo2WYZfI2qEuTze86+d0LLbIHNoGKn/PE2YEMli5yy5
 KZD+AW5oXu5daUKMc+JriaVmOL/l5mL7hPgGYQoPxMder75EcNRJTWyC7Qbck8r6IAi0Lerbj4u
 i45MLZpHCzyQRPfOyACXFu+Nt/Y=
X-Google-Smtp-Source: AGHT+IGe1aV4tUU8W/gdoWOVrUz3thzMV4Ne82XzjHKxAY0oJJTFlZ8PcwEVBslqTt+Ux9AeKwWofA==
X-Received: by 2002:a05:600c:4314:b0:434:a802:e9b2 with SMTP id
 5b1f17b1804b1-436eedef4damr7995295e9.4.1736463649932; 
 Thu, 09 Jan 2025 15:00:49 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d3bsm33586825e9.31.2025.01.09.15.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:00:48 -0800 (PST)
Message-ID: <45d29837-466b-4439-a8d5-b522e1135263@linaro.org>
Date: Fri, 10 Jan 2025 00:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 44/81] tcg/sparc64: Use SRA, SRL for {s}extract_i64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-45-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
> Extracts which abut bit 32 may use 32-bit shifts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target-has.h |  9 +++++++--
>   tcg/sparc64/tcg-target.c.inc | 11 +++++++++++
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
> index d9ca14cc3d..2db461efed 100644
> --- a/tcg/sparc64/tcg-target-has.h
> +++ b/tcg/sparc64/tcg-target-has.h

Missing:

-- >8 --
@@ -33,8 +33,8 @@ extern bool use_vis3_instructions;
  #define TCG_TARGET_HAS_ctz_i32          0
  #define TCG_TARGET_HAS_ctpop_i32        0
  #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
  #define TCG_TARGET_HAS_extract2_i32     0
  #define TCG_TARGET_HAS_negsetcond_i32   1
  #define TCG_TARGET_HAS_add2_i32         1
---

> @@ -68,8 +68,8 @@ extern bool use_vis3_instructions;
>   #define TCG_TARGET_HAS_ctz_i64          0
>   #define TCG_TARGET_HAS_ctpop_i64        0
>   #define TCG_TARGET_HAS_deposit_i64      0
> -#define TCG_TARGET_HAS_extract_i64      0
> -#define TCG_TARGET_HAS_sextract_i64     0
> +#define TCG_TARGET_HAS_extract_i64      1
> +#define TCG_TARGET_HAS_sextract_i64     1
>   #define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_add2_i64         1
> @@ -83,4 +83,9 @@ extern bool use_vis3_instructions;
>   
>   #define TCG_TARGET_HAS_tst              1
>   
> +#define TCG_TARGET_extract_valid(type, ofs, len) \
> +    ((type) == TCG_TYPE_I64 && (ofs) + (len) == 32)
> +
> +#define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
> +
>   #endif


