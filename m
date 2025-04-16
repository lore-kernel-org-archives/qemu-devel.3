Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774DCC369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u584u-0001Ao-31; Wed, 16 Apr 2025 15:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u584q-000162-Qd
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:05:40 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u584p-0004aJ-1y
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:05:40 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af52a624283so34629a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830338; x=1745435138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DexrgqrBz46PbWiez+XeCJyOwzc85HAYTvD9X4KLD/Q=;
 b=bZLCYUXI9HDDqu9HYCe9dytCepGWss2JjIBWULYCCqTFU0lYCqr3JpP5ARp4D1xUjb
 48+M7fK4fqxu14DJSwY10XDnvwXpP+2dh9MBBm5+Q9KapKp0tZ5vuUYyTyMoG8A5jdo+
 hbaz1ihAet6zOyVHWVsROglF3+ZXuJHMWbbTLRMcLr+oNdhdVUTEJ7jkdeYi9TYXISxM
 ayS2RvhZT3Pe4vy3kJBauRiY3zvHwbGlvCub28hLJ3oaLE5P7U2tNCS7GVfU5KkcLn9S
 avVPWksZmRYZQ8p0BCa3EB7rI9cBU2vb4ETJSbVxTIMx8VyKyV13ELDsJuzmGRqGPGxk
 QtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830338; x=1745435138;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DexrgqrBz46PbWiez+XeCJyOwzc85HAYTvD9X4KLD/Q=;
 b=qLVAx0iFkWXAun+tT+mikTCvAnsieP/w57gsxIdC24mZgJfdsW0psUNzsbSP3lmGSI
 QKSfPS6lk4WGzgJx1ZbQrA318yuZcg8KVlGFLKO5dnR1mW/JxSsBM3HFAMimo7k/kVZ8
 qKRQqIzQ2XPclpLL6DhUU1f6CBB5pLBnv8Z04Qnu7Jf9DhkZn1Gv+Rhoy2l6gPm1o2lK
 tUCtASVO60nKYBi7aC0/aATZDoGecne2dlx6spJgh5ZNl/8VupI21SRYKIddeP+fzvmE
 GGbXPLQINBW4e3Df+wKZOs75Lz0iXY2FtQYLKAwVR5pzsA4VoeW/7yu5n7LQC1USrh95
 XLrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHkkp/TptrggYxj5K0uv0FcK7plozwOiwZB4yqhPzAk/PfC4hwnJARspvgiE2dRghICQDKS+/ej6KY@nongnu.org
X-Gm-Message-State: AOJu0YyuM9MmX1P4nP++U41PWnAM7pB8hEf1JrgOnZbsGTaX3QlICeWb
 TaUzN5BjLqvNNs/V9ctL/DFAmyulcBttS/TOk6R/rma5bTWZ3bA8MBqNw/jlZHPtL5xZgc3iRaH
 k
X-Gm-Gg: ASbGnctZ1iHZohDPZK8Fh9LFiJQQ8jdQwqZljYhyaMTN2PRA6Rp/A2Xg6eoYh7FPzPD
 j+jJmnOL/8NDr8c9PH/y40R8V1OTcOD7hciI2UXuOML3Vk4OswLNlZ/PewVN35HT7jeSizvjBwi
 7sT6xGmLKzjyG/2ZxlCSL98WMvdIWFIE/VhPBsMRt44GdJoi8DOEhoiRBmN1IcJwNSHb9WQhHY0
 r4EylVjyqiOyy699uTYOZ6d/U7m7EBME3IuDJ7oTkUGOi17hngn1+aP8SWC10usdx0WLyVCn/lJ
 kGF+gColc0RAj+SWK8JOoXPHcxGg6PdJcDSGGBvlmx8s5YVB/SlLxlAwEOwNQpOI
X-Google-Smtp-Source: AGHT+IGy8uxcZzPS7Zq840P4bCgf+lOShGlnH89AnUqPQDtxHclhu0Q89jhLMvsBns9uWfOZ6T8N9Q==
X-Received: by 2002:a17:90b:2dc7:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-3086f3c78fbmr77784a91.2.1744830337649; 
 Wed, 16 Apr 2025 12:05:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe98d9sm17952915ad.250.2025.04.16.12.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:05:37 -0700 (PDT)
Message-ID: <4ea07fb2-4d84-4176-ba30-ea7d3794c06a@linaro.org>
Date: Wed, 16 Apr 2025 12:05:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 126/163] target/microblaze: Use tcg_gen_addcio_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-127-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-127-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Use this in gen_addc and gen_rsubc, both of which need
> add with carry-in and carry-out.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index b54e5ac4b2..31afd3ab5d 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -310,11 +310,7 @@ static void gen_add(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   /* Input and output carry. */
>   static void gen_addc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   {
> -    TCGv_i32 zero = tcg_constant_i32(0);
> -    TCGv_i32 tmp = tcg_temp_new_i32();
> -
> -    tcg_gen_add2_i32(tmp, cpu_msr_c, ina, zero, cpu_msr_c, zero);
> -    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
> +    tcg_gen_addcio_i32(out, cpu_msr_c, ina, inb, cpu_msr_c);
>   }
>   
>   /* Input carry, but no output carry. */
> @@ -543,12 +539,10 @@ static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   /* Input and output carry. */
>   static void gen_rsubc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   {
> -    TCGv_i32 zero = tcg_constant_i32(0);
>       TCGv_i32 tmp = tcg_temp_new_i32();
>   
>       tcg_gen_not_i32(tmp, ina);
> -    tcg_gen_add2_i32(tmp, cpu_msr_c, tmp, zero, cpu_msr_c, zero);
> -    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
> +    tcg_gen_addcio_i32(out, cpu_msr_c, tmp, inb, cpu_msr_c);
>   }
>   
>   /* No input or output carry. */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


