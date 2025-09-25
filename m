Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB82CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jdN-00016i-88; Thu, 25 Sep 2025 06:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jdL-000164-Bn
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:55:31 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jdF-000174-GS
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:55:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f1153f4254so375788f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758797715; x=1759402515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mT2MgS+CJ41bUz4QS0+6lv3oqxZrg3YQgs/2kcsYbUw=;
 b=SGbQ8PXXlBFl0wCE1xJSkwCjjPLc1ak0KbZnR5ivsVL/rTl/LACHwzUX4oRIqdz0N0
 LLQ6iVW+Pg+maNB2xSGDK7FkOeLjtgRNTUTBXPNAEEf9w5HMDUUhuK+XetTUMyfRdLNM
 IZiXFbW7T6O6jhE9+2gCP1XyYkcF4LwjoVuwKJlI3vtteh/LYActNok8GMaWTsdrVjIL
 m+LGqSAPj0utJU62c2XMDtXs6x9Vm0ger4EMZquOTQDgvpaYmXjiyhLjFyFFBTUO7q9o
 HroGHEulenMtSBH7QsXDM/Y9fBP9lsMa7QSuPGSgah2KE+z8GEUJpjYoqUyke/Ue7eeJ
 dIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758797715; x=1759402515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mT2MgS+CJ41bUz4QS0+6lv3oqxZrg3YQgs/2kcsYbUw=;
 b=WZhEUTZVAPpLpRp+ol6hL9D99CqlLGMV06CNGh2fF15i57bbQRQO8u2uPZgKecmr1F
 QB3aVeWx+nsPTShpqMEZULVvGVXlXLOdc7BbgdL877/MKTDeunR8LmAuQDuas4WNWHE6
 wR5ycqdQIUnH7dM4JbJUK8SirSRBhmOgmAMw/oD59lM3VEx3CoXFFJbPR0O7vaRSS4Rw
 3ISN0htx1USTA+7gFhBHpLa5PCBRTqIakm8I8+LDQYnV6sg/GwhMhq8UJPNQ4A/RNsoH
 Ujs5FfUO0cXHT6pu/0xTOi9rCO4tH8gobjcuU9JkY6Hvao128TRxMDnPh79/Bvmsz5Zu
 /7fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm//GXK9qAyzih+pFUgL2PSLLsa2BiBv2X9+6vLroYaRDvwQKRCEyEWIo3u+FjWADyXtXyojhrd8Lp@nongnu.org
X-Gm-Message-State: AOJu0Yw7sOhC8uktBpjiX4jS33nLRJVKr0++Pg2KTxCFLFHYWgOUMyVW
 1NnssI3a5kVKvxLUrqT/sGKQEOiHNKXAU+38KDB0FWa0PcMP9cVC2fIDDPErXXBjy6U=
X-Gm-Gg: ASbGncvfqTwGnKbA2EPxRZGEd1lP875M9Esc/uz5PQCK76W46oIzT6aZiDFjFjgldg9
 ND+eL6kd9YK4UF0YGmQq2lKGC+P6B5CQYxmAmVNDs98I760PnARX8/gyjvKD4XrCzYnPCdz/zNX
 2uXS/S59KCLGzRZyl1Ya0E5jBGec0RZjQkIyX9QRd2u9af9g3OLUuNCM3pfQY5WwJ78N/r1cjEw
 2C2ROu1tLejF5lHbWU/XIpcqWUJhiM0eUKE1EWUHbKiFSSZYqUkP1cxagL2M4bkoio9rGuk26M/
 TlqDubiznhzJfJhGx/ee8TDjz+J2iu29XeCriApq0csk6hNX2v/Gqg+HmgEXw+MPToRuiWWHO4T
 ePuIT3oX0mbBAiCLiZ/QFNOUtkCZVYg4pxyWeOE3QhQn/J8kmMYYTnRdvmzSTuz06Yg==
X-Google-Smtp-Source: AGHT+IFlaN/dgeEOiN8heFVjpNvshJYffSw6dOoVEEwdXZyl/OvFRIjEfQnJVASeNxI7izggNOxZ/w==
X-Received: by 2002:a05:6000:2285:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-40e4364289amr3163126f8f.17.1758797715260; 
 Thu, 25 Sep 2025 03:55:15 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33be363esm29190695e9.15.2025.09.25.03.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:55:14 -0700 (PDT)
Message-ID: <8610fe54-be24-4dd3-b22e-f6817f5d8949@linaro.org>
Date: Thu, 25 Sep 2025 12:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/36] target/arm: Split out
 add_cpreg_to_hashtable_aa{32, 64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> The nesting level for the inner loop of define_one_arm_cp_reg
> was overly deep.  Split out that code into two functions, for
> the AArch32 and AArch64 paths separately.  Simplify the innermost
> loop to a switch statement over r->state.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 147 +++++++++++++++++++++++---------------------
>   1 file changed, 76 insertions(+), 71 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


