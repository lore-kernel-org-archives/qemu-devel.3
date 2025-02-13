Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A5C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibUC-0006BE-Cr; Thu, 13 Feb 2025 10:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibUB-0006B2-7m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:50:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibU9-0003oE-D7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:50:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4395561ab71so12053815e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739461840; x=1740066640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8h2+jYpnMwjSwRa7NtExh8i5RzcVkPt7WBhcerC73a0=;
 b=DIaZb6f27QqGX8JtTkfbDvVBO+z1NqUR4s60yUsv2MGbEOjEV3alYQcjRO3EAhwzXB
 XWJYsNUgTOCjRj3ymSLh4SB36PBSMci+s0PS5M6r4TcGtFqqo5M9p/KyA9fvTzk3QtEB
 rubNVRlHe6nD2llxKAdLFKlFNIo+lCij2Tabx7aWOhcrPZUOx2fsRObRwoK66/c0NGOQ
 HyPYuJMaa67mQ5dTHlzVBzs2bKilxcwkdv7AENnWdaEjJbABPfhoLzCewFkZdmGJoFtV
 6H/8USvVxF2kSQqA6+PEs9gK2+p83g535Uejl/hOheUGdKB09KEvFsSjD5LFuPOIkS+m
 FuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739461840; x=1740066640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8h2+jYpnMwjSwRa7NtExh8i5RzcVkPt7WBhcerC73a0=;
 b=GR3rbwaJ3fhvJ6Sdlq+seXobjBXC7ZMIoxTsKEcuRv/WhCLDybbv5ie3pc8zQGcwEE
 O4MbD3O3wFZ48s1gVYfVS0Jrr1+nyBJc2uX7QAgq0Lea7/Dg28RZ44q4/sGZ5MWysr0u
 z1iiPaVXCkQUJ0RNLX76ITjA1MthXNOT7Z/HEcnimROTF2EujAyD8tKGPoC5063V0UQ4
 cQQb0V4734Afgvsblbm3/ld37wvK5/rjkJoA6b1lGHK8m5qA7xXMhf6UQI1ET0VdZI2p
 l+MQ5yWh1NL+XRaDu/YEnRNKtRM4colbQ7WP4jp8xPcOm5dmAwaAMj7dBI3JpiN1cbmW
 +K1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgC4bVWpHK6CM2/jh9TEyDfLAjLubjEdPbFJWT/nmVZfM3hKX4YSjEwK6gQ5Y9hembDz27o4tR8+8t@nongnu.org
X-Gm-Message-State: AOJu0Yyn9krQFGXhtE8nRqVP5YEXP3R5tmkL0e3XnBvrllu1bUZJ9JUm
 aZNwp4Legujz9nLV/Wd4Q7b5gyRMLz2GVl9u3Vzo9GhpqlpbcFf4hzKKmlQmjYL0z04ccCIZVFl
 V48Q=
X-Gm-Gg: ASbGncv+vqDPuqdVxB1Pg9DsjZBc6nK/pQYUQ8gBnE7tehi/ipWNL49mHaZnpw+C0py
 4VUMa06V1q+QqfiCsdekYDVQ1cqZyWAIR4CUn0ZqRkJSxcBK+1FZ/ebTo1K8OHa3axhu5oIzZbv
 g6LJESWiVLga+L24OU0vleuz1eidYnTUgNM6VZEg+yn82bV0BdqFWx9jpAiqWwnIGtQYv2sbF6U
 wF3Vt+NQ0zOUM3pQd0cMIeZ42FvqfZjPhdYmSCCX/i7yhU4sJpjulkoM/KL7g6ZNUNUagqFVsOe
 AgUaaeb4coRChXr4ieS+Ddz66U1u6nmzCt6kUj8EFEgqRxRKJtnDIb0FZemTbDqcfp5/TBzgPg=
 =
X-Google-Smtp-Source: AGHT+IE2md/BnPpOYGn6A2Ltp08A9xyFZgbfjG8HzBY3GKgs5Tap3V4M3fyjT9K/tUszgQhcy3PV+g==
X-Received: by 2002:a5d:5f54:0:b0:38d:e3da:6f0f with SMTP id
 ffacd0b85a97d-38f2446051bmr4840449f8f.0.1739461836466; 
 Thu, 13 Feb 2025 07:50:36 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa38sm2252952f8f.98.2025.02.13.07.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:50:35 -0800 (PST)
Message-ID: <17aa46cc-c9ac-4a99-b15d-6f1e3873b65a@linaro.org>
Date: Thu, 13 Feb 2025 16:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tcg/riscv: Use 'z' constraint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212034617.1079324-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
>   tcg/riscv/tcg-target-con-set.h | 10 +++++-----
>   tcg/riscv/tcg-target-con-str.h |  1 -
>   tcg/riscv/tcg-target.c.inc     | 12 ++++++------
>   3 files changed, 11 insertions(+), 12 deletions(-)


> diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
> index 089efe96ca..2f9700638c 100644
> --- a/tcg/riscv/tcg-target-con-str.h
> +++ b/tcg/riscv/tcg-target-con-str.h
> @@ -21,4 +21,3 @@ CONST('K', TCG_CT_CONST_S5)
>   CONST('L', TCG_CT_CONST_CMP_VI)
>   CONST('N', TCG_CT_CONST_N12)
>   CONST('M', TCG_CT_CONST_M12)
> -CONST('Z', TCG_CT_CONST_ZERO)

Squashing:

-- >8 --
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 61dc310c1aa..6edeb743384 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -391,9 +391,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
      if (ct & TCG_CT_CONST) {
          return 1;
      }
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
-    }
      if (type >= TCG_TYPE_V64) {
          /* Val is replicated by VECE; extract the highest element. */
          val >>= (-8 << vece) & 63;
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


