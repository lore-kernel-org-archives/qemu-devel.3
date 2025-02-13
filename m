Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36B0C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibWr-00070M-MK; Thu, 13 Feb 2025 10:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibWg-0006zs-8N
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:53:19 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibWd-00046j-JS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:53:17 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439585a067eso11147125e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739461993; x=1740066793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WteOlRokIyF5hOLsiHiTsEjEre5cJ0D0adJc9uJVDB4=;
 b=OTTFXpJgE0ulYQpJV+JVbi6opsKsAXiiB/ci/IKKms7Az8IdVSJ/Vxn7VJiS8zLlex
 AG7lsuJ2uFbCwXNbhfsQQx8othM/gyn7/tZG842IENShNLggKiKMGNNrSapztFIMP/Lg
 MsQ5xOTKRHe+6FKK39vrE5MB3CXeuPxoEOP9YeqAR6p8Ay+HaDoR6SoHOjOHc0+ixkzD
 2x8NYzblG+XsPn0lELTHkxgx7TeR90UQQkUBCr8zEoyYaPLO3WbdQ/U9ZxXUfE0hEYsr
 eRYhhZ2I7eyiZT/vTiUKZ/Ss8P3FR3+gIMRfuMKXMym4t/4wH1FWjEfJmuHtS2zSatMs
 s1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739461993; x=1740066793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WteOlRokIyF5hOLsiHiTsEjEre5cJ0D0adJc9uJVDB4=;
 b=lbovETpPRT6o50mWeQMuwmx37ALlfjNd3KHrdoNpKvjHFwEPAPFwXFEl4eSPDbb3hf
 mf3s3M37Ar3U8x7+Sz0JHuEiYM2mzZYttPR9NKpJHGO7/gShZoIU7ViG1r+If15vPqJb
 RAbsBe8vgbR9fQDIpxSm8KUZHwARBb8tRwFDSuPSnTprWNlDZLrnBHk4dbWP/a8cyXeN
 zGtTXwzLYpR36esfLsBpbzjJCs9KbcxeCLo3U2M5aHHUP640kiLt4vxLy598JDCyMk8I
 9Hy6wTir4duovYxetzjOijeHwNdQdY/q8YFv7L+x2qyzSC3DX7saV0bb40QhzXL8Sv4u
 f1KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1KobgMU0JO4xeWKv3saARkYcu9pNF0lq9RXLTsfZU+4NsTdCfXLrERZ8eEsDcZRW67NejpbzO7Rqr@nongnu.org
X-Gm-Message-State: AOJu0Yw6v7LCle7VIC5aIa9DDW85UfA2cRPPxPRKGn7GewdcorAwkCkD
 EMAzV8NLOXkPoy2bZwm1r4I2kMLElmwCp52isLQwQNqU+v9drTkfIeFKT2CHHEH5oCEfVnpM8JB
 iqn4=
X-Gm-Gg: ASbGncsXGDkuq4tAN7ZxotswCxmHbecXV7TJyx5fayk+ACJHhatBgwHjW4Y9EvAhrnE
 gIYyIEzDHmLjamwNAsXmB9W67usfP83ceBg8CWLhaNDX5Zh4jMk02db0tUG3HfBOs1TON2V7sRw
 sMUdr08fPuIf7j5BBeTZ/Lcio42svq6WUFDTjvNIzI7lUluFn6OZt/P2FJkTZotLPbhlHKP//BH
 5em8raH2o3+BoOan0VXL9KhYw7uyBNrEXLgrWZ0A62Q6aMTu8yrHKRx/NDnbA/i6b5G4/hJgBDe
 WbrWNw3DGltcK4tsLuvFbVTSSK9I6gOOt4PKhRrixxlO3LzLF/WFtxGal2GGnrKWgf3VTkiLHw=
 =
X-Google-Smtp-Source: AGHT+IENEYv6Gw9t/2AiUGCUjKUNlvWmMqWZ33AW5Wx9bvmokoYZcrfR6TwOo66fvkwOzUI0u6ofXA==
X-Received: by 2002:a05:600c:3b92:b0:439:4c83:2b8b with SMTP id
 5b1f17b1804b1-439581b192dmr78062525e9.19.1739461993473; 
 Thu, 13 Feb 2025 07:53:13 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4118sm2300842f8f.18.2025.02.13.07.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:53:12 -0800 (PST)
Message-ID: <1f69ca30-64f4-4f97-af89-f0933d11f6e3@linaro.org>
Date: Thu, 13 Feb 2025 16:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tcg/sparc64: Use 'z' constraint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212034617.1079324-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 12/2/25 04:46, Richard Henderson wrote:
> Replace target-specific 'Z' with generic 'z'.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target-con-set.h | 12 ++++++------
>   tcg/sparc64/tcg-target-con-str.h |  1 -
>   tcg/sparc64/tcg-target.c.inc     | 12 ++++++------
>   3 files changed, 12 insertions(+), 13 deletions(-)


> diff --git a/tcg/sparc64/tcg-target-con-str.h b/tcg/sparc64/tcg-target-con-str.h
> index 0577ec4942..2f033b3ac2 100644
> --- a/tcg/sparc64/tcg-target-con-str.h
> +++ b/tcg/sparc64/tcg-target-con-str.h
> @@ -16,4 +16,3 @@ REGS('r', ALL_GENERAL_REGS)
>    */
>   CONST('I', TCG_CT_CONST_S11)
>   CONST('J', TCG_CT_CONST_S13)
> -CONST('Z', TCG_CT_CONST_ZERO)

Squashing:

-- >8 --
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 733cb516512..69df3c2a17e 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -76,7 +76,6 @@ static const char * const 
tcg_target_reg_names[TCG_TARGET_NB_REGS] = {

  #define TCG_CT_CONST_S11  0x100
  #define TCG_CT_CONST_S13  0x200
-#define TCG_CT_CONST_ZERO 0x400

  #define ALL_GENERAL_REGS  MAKE_64BIT_MASK(0, 32)

@@ -340,9 +339,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
          val = (int32_t)val;
      }

-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
-    } else if ((ct & TCG_CT_CONST_S11) && check_fit_tl(val, 11)) {
+    if ((ct & TCG_CT_CONST_S11) && check_fit_tl(val, 11)) {
          return 1;
      } else if ((ct & TCG_CT_CONST_S13) && check_fit_tl(val, 13)) {
          return 1;
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


