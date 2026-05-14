Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D9BCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSui-0007PW-8K; Thu, 14 May 2026 06:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSuP-0007Ob-Th
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:03:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSuN-0003jY-SR
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:03:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so37094205e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778752990; x=1779357790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYBx7xq1OOCCZhh4RQ5mzEs9yVHN4TskbrIGHQJt5lU=;
 b=D+tUYV8CvEmLx3YjRHCnKjO5lhuYusA7l+S17UtNDJpmV/yf5YzgSce0VrIGHeN6Fv
 yzzmY8/69+E70yo9XTIMCenLJPdf92hH7NEENeq7TQ9/47ShI4Euz9LrL2gE/kZOypnW
 DiOVVuTmE7tUIUR8dBkLXrCB4yGasgDfXEn5z6ON7wtgOz4ifpbYPAV+7RLrHNQvstaN
 fQhfLkDed9TxDSdibiuVOYwoA217MtkZIBteBTrsDknPEEQfYcg/Cybe40C9M2yisCw9
 qn6V3nGRfzyvnxxu2yZjXCleoFmFE8TpSW8CLA+qx3opcU7eKs6E5XTgCypsxQvenEWZ
 j+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778752990; x=1779357790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYBx7xq1OOCCZhh4RQ5mzEs9yVHN4TskbrIGHQJt5lU=;
 b=hXFilA3AaFsc8DXZHdrU5q9gd0iGmDD+4ITXQeDguL7xNgW+KoFRfkGaQwHlGycSrN
 HK7iuP3EnNXlPSAf/CA7OZfq4DAPvhNvP3tUW+b21+Eknnrh4pDjDhb9V8vakHdRbgOh
 uuAAZOHVVueenEs6ZUZaQz/LghOCoN6ZbPoYNOJHaGZOl2UUTaIAaeJfGnAU55BMSVNN
 jKc43gTrZxuARWkz6J9q4Trl92EqST9oJLvvNlVs6JUBlhNhKMbdnpaAfmq0kAoOvDBu
 aD9/yM/hCszQOhNYofmCMy9mkAVjFd8gxJD4rGVLH7RFWpoYrkYyEthO2gds2cQ02bdD
 hO4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UyDTMkgGn7K1zIxM5crnIX6iGw7RGjxepOz6SQwL1/Vf21VEw5vsksxaoyOwnYkGtuF07ZAxs3KFo@nongnu.org
X-Gm-Message-State: AOJu0YyistNR1jxBORRpeU4UN5gLuZm4ACpIH/Qul24G08cfC+DagetJ
 /o3gjsPM3wpS5OSfmqDQeFoSeuiTNI7VjS7RBl0EOJVfB2SyVEIy8MhKJDsXIS9QbC0=
X-Gm-Gg: Acq92OEVp99OKI7xMQYfO4Vd7BQMiJg7S+j91yFFWo5x9whfkY4QBQxeCpP/1AZKvBF
 6vL0rscv58oyK8apYa08MvDx6NZV/tiGzMa1Xn99kxm/CKLv4lP6nlnVWyANfnJRHDoXrnjQ7Vu
 2gf5H4IT3KQ1EPb6soZd1afJGB29NDFiBjASZdTiS3TnK3oWyLGWSyyS45gc5iPSvD0sEgmJ9IP
 44hqD9Eqcxo0KqKyTSdAO0FjquokJbhLiSKbCMRh5gd1LrX/48Wyfk5Zen8q6/fiOfEO69mBrVk
 HmlMYy0loecuiMSGwtYz5CsDN9n5PrnTbblRSQ35E8DZYA7nyEf/K8ZY6h6vYvybfDM4UebjWAk
 /gdZyp5tPldx2OiTgslMLxTrWoSBPpK10xRisAORUp5d4MwkjIir2v5rH4303QdfH9cIEZz8IvH
 pZ8uSYFtG8Qw9MA6Xhu93/iwfv7G0mkl3WK4aX7pxgMzww5nbkIVv40dFWyMahSQa598/4zbD2f
 U/w
X-Received: by 2002:a05:600d:18:b0:48a:5574:3a5d with SMTP id
 5b1f17b1804b1-48fce9bd5d1mr79674135e9.7.1778752990085; 
 Thu, 14 May 2026 03:03:10 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd6498a7esm51528105e9.4.2026.05.14.03.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 03:03:09 -0700 (PDT)
Message-ID: <19e89a7a-7156-4572-8951-c08061725f38@linaro.org>
Date: Thu, 14 May 2026 12:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/35] target/mips: add Octeon ZCBT instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-14-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-14-5062889c4d3c@gmail.com>
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

On 11/5/26 20:22, James Hilliard wrote:
> ZCBT has the same user-mode memory effect as ZCB for QEMU's purposes.
> 
> Reuse the ZCB translator so both cache-block-zero forms clear the
> containing 128-byte line.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split ZCBT out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v4 -> v5:
>    - Fold ZCBT into the ZCB decodetree entry with a selector comment
>      instead of adding a separate translator thunk.  (suggested by Richard
>      Henderson)
> ---
>   target/mips/tcg/octeon.decode | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index d8a1bfce77..5377f7b3ef 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -51,6 +51,7 @@ SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
>   &zcb         base
>   ZCB          011100 base:5 00000 00000 11100 011111 &zcb
> +ZCB          011100 base:5 00000 00000 11101 011111 &zcb  # ZCBT

What about using '-' instead?

ZCB          011100 base:5 00000 00000 1110- 011111 &zcb

Although if we were using decodetree for the disassembler
output then ZCBT would be preferred.

>   
>   &lx          base index rd
>   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
> 


