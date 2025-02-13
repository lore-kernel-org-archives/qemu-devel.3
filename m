Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBBAC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticXR-0006QX-0j; Thu, 13 Feb 2025 11:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticXP-0006QD-1X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:58:07 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticXN-0005nG-F3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:58:06 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-219f8263ae0so18846655ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739465883; x=1740070683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yLSbzG6ML45iHZ+vj4SzYhnUOLaM3mfQ4WRjmCJ8nII=;
 b=nKPMDaX9/zxch8zD5eb8NnBA1kjQ0//ToyiBrVlU9oPE16zr6F2En/1HFju7LoCjit
 I6nh2My+KdTlyiDPuonZryTIEzRLsxy3wZO+pqUx7uQQrOefcOYENLIFAmrA/Sggd+td
 DOLQ1ZoG56IdTIWSv4pH0mgKShQq9L8wYlejDO0PvFK1EL/8gmOIW7Enh41Skguo7Wvq
 cPpmz3xOv6kal1gOhDmj1f8QfDuF2A59sn/N8+jnlCMBt6a9eBAMz4qhEKKHDYdUTVNi
 EMw//njL8+LphAsStVO3dRjYUKyhEJhPRamVfmKoBi+0EHeYzhL1+gX3jyfjbnzdbw+0
 nK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739465883; x=1740070683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLSbzG6ML45iHZ+vj4SzYhnUOLaM3mfQ4WRjmCJ8nII=;
 b=oHAaUvBEUWi3rcMSUnzU9GEMU1c/V9G6rjXB+R3XhwZ89YttOFOsqXGbJsx4b1t9uy
 k6Hhs6dxJfYfzSqg1bAV6OoDSQIesQSjCvv9uH5KUSmHPrmNRiGOzEjtMNjBBZykbh3i
 rralEQnMzJ2LjD5cya9GOaiN6sJQg033DdAMiwwVz0LvkYWcTzks2w2EIdJZVgm1Fewt
 +cJsKaD4YSfxRfHqyeXGrj2hFUfRTYO7f/JR8uzBPfdoLzkuRzuTFu+tDoGeHoa8nAKJ
 FReriOvDh93NoJuNIdhS2RDXTxCnJwQ9iXNVp/PYXUQJ6cw0PsCRO+RT7nRlRtTNKEeh
 ym3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDchOOMGEMVROSQp3T7Kz/b42UiU3C2zEdIQqTd8GittwLNy9G1BmAzd2iH6ZPHbDXS9yHvLrIyTFj@nongnu.org
X-Gm-Message-State: AOJu0YwXvOyBmeVBNfwBam9dOU+YMtn2YLYCTr7d4B3J1yFwvQfl6G6q
 FW3dwQHLaLsnKZCAQbYWUc7rmc3/zcKSJDzVh01TaC5lKD09glIwNb4NpvByHl8=
X-Gm-Gg: ASbGnctEU/gC3dNXAzCsct3YafoelUS6v8db3xxGxAKK1kEHNZjmCvS0MHYnvvD7GDx
 ooJf7BiXf2vHMkOpVw7MwmXYxYQFdrybxqlkT97V544zgX8NDUubBr7MkoVqOwBiDFNlLKj5zRy
 UbXf0feI2j58L8MqUGx/r0TH8mnCuy9I5Fq7F5IsNPmrSQL/9jjufCPOKajUuKTFaZIVok5Hpf9
 1WUGhg5RdCSyk9eU+7wcRmCIrbybsLd+ZOP3ol9p5vR0K1rOeyo4OjLbJmHx4Mowx5+q7BLfS5F
 uJ2XjluIvMXeuAWc1anQs1WU81OQFjwTBoq1PnBEhLGWj7y307Z2JNU=
X-Google-Smtp-Source: AGHT+IHoKu9no66LZzBuMHWqarQg68mxx1/eK3mwTwqAWk1/9HVKJdT6WG0srm4lhBHXA5H8SgwS7w==
X-Received: by 2002:a17:902:d543:b0:216:501e:e314 with SMTP id
 d9443c01a7336-220bbafa000mr128534615ad.20.1739465881759; 
 Thu, 13 Feb 2025 08:58:01 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53499fesm14632425ad.34.2025.02.13.08.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 08:58:01 -0800 (PST)
Message-ID: <ddc4ca31-22ab-4818-88d9-08f299559945@linaro.org>
Date: Thu, 13 Feb 2025 08:57:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Fix gdbstub incorrectly handling registers
 f32-f62
To: Mikael Szreder <git@miszr.win>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250203145056.83567-1-git@miszr.win>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250203145056.83567-1-git@miszr.win>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/3/25 06:50, Mikael Szreder wrote:
> The gdbstub implementation for the Sparc architecture would incorectly
>   calculate the the floating point register offset.
> This would cause register pairs(eg f32,f33) to point to the same value.
> 
> Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
> Signed-off-by: Mikael Szreder <git@miszr.win>
> ---
>   target/sparc/gdbstub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> index ec0036e9ef..5578fa9813 100644
> --- a/target/sparc/gdbstub.c
> +++ b/target/sparc/gdbstub.c
> @@ -80,7 +80,7 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>       }
>       if (n < 80) {
>           /* f32-f62 (double width, even numbers only) */
> -        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2].ll);
> +        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);

I don't understand your issue with f33, since there is no such thing.  Sparc v9 has f0, 
f1, ... f31, then f32, f34, ... f62.  The odd numbers above 32 do not exist.

Certainly the indexing is incorrect afterward.

Originally,

   f32 = 64 -> (64 - 32) / 2 = 16
   f34 = 66 -> (66 - 32) / 2 = 17

whereas your replacement gives

   f34 = 66 -> (66 - 64) + 16 = 18.

One could rewrite this as

   (n - 64) / 2 + 16

but that's algebraically identical to what we have now, so I don't see the point.

One plausible adjustment in this area would be to reject odd numbers from this block and 
let them fall through to 'return 0' at the end.


r~

