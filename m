Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE85C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkcF-0007Cx-TJ; Wed, 04 Jun 2025 05:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMkcD-0007CW-De
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:40:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMkcB-0000FK-Gn
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:40:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so37449155e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749030053; x=1749634853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0v4oRkMmogR7y0B5fp1lSGMcOWf9pIns4sZawS0F7Rw=;
 b=knIcpxkw+srhXDpqOt6oSUGc0iVKQPNA1IT1m5RTJQk0pz9KjaPATA9NdM5Z6KkZf3
 SBHRx5oaPG3C8rKszxroQZMRCBgDy8iJV9PlKfVcTbOBWzOR/IyY8jAGlVyB9N7dekiT
 Z3VZBAsUfxxNzJi1bCTf/DkaMTRphL9t7Kxs8kdf1OmqOr/MaA5r89L1QjJ0SBMslcXH
 D6D40cMEQ8/c87gbON2ZBpibOITcOV0R9N3zcx3WNSaBmQ5gjM7dHs8wakyaEaI8kEpO
 j1m4KYdGrruwKEeOsgyapl5AwdCGVdiqTMxL9WN4kHVYSf9gbhPbChvjh4OXsmhRhW9V
 Q9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749030053; x=1749634853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0v4oRkMmogR7y0B5fp1lSGMcOWf9pIns4sZawS0F7Rw=;
 b=sjdRdMYIeEQrvr1wvrdVo7RG3A/gs6OAcv03LwrgzT5VwfzFa9AK6yXbM5KzX8KWe9
 lCh7x/Z6rQtkWv6E/Yr+rADMkVbjqvXy8+NfcjT0CORz/KRuKHImJxYNUduzPueajo3Z
 CiNnQ1QD2Usxaem4HTvQYEz2uYhRwd/GbH1ZGYxGjsQwQnY6x8UQJfSXrmjomUUWdXaX
 N5xzALg/PPPgx4U8gr34tknF27se/ot93VKx70ijuqmHAQZYZAizvYk3gXjIBep5eGVX
 7DHZL0ic9KaG+XIlxHDEn3LsVG4oLKsw/93o9yJfAbRv34Jl6yZHNT/FGsqK2W414x6S
 6RqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2OCyza0/8GkL7I5IwClCN3p3T3/llyEq/EBpN9vOexcgaH4S6dMtvPMVnjcEUuH0gIGCi1dT82Cw6@nongnu.org
X-Gm-Message-State: AOJu0YzqUSXfbvPEPJclAqHLu1QyZZmBFfVbtRs5Xw9T1IhaYEH3Ubut
 g7yJJOehUtp8mpk56xIG6XE/w93TPQVIJ5IbOKPbaaWX+IOjWkaIQdngW4w6iDihW0I=
X-Gm-Gg: ASbGncsTjkpcuQSMt8KSsb3Yh5ckte5ICNvVCiBwE6Fcx4IkZF/X/sl7Ws7rIT/GfEh
 i/bpiVkwd1BtTnFjIg0bKQD7/G5aLlQd070SQ1sgNmZ6kIJYF892ATEbRnk+oUrg7o4ZHWJg1ux
 sNDwHQcXt9wkz8I6z68+YQK5LQLs+qn5s/pc+cXm7gOXQneE8Co2otaGAWs2R6duxw6DS577ZLn
 OGn2GFArrIm5M2Kr+v/F0FocDETki3D/nCoksT2kKIwW+u7CNhzEj0zlyQzmAwnMDs/ZxPOwjq9
 m11uAh6dpz9Qo5Jd9r1iLDyOkmAmpVqZZEEGdq3W55+YotOJeKltvRefKL54dzyP2C8X5q95+op
 dMHZfljkCv8ju29BfNJM=
X-Google-Smtp-Source: AGHT+IHgObejxF6HksytVWqARvUA6SgJFgLDsW39XwVBGsPhN3arFNRRyosGMfKHjXh24ArFMJCFFQ==
X-Received: by 2002:a05:600c:4f8b:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-451f0b105d0mr14413825e9.21.1749030053424; 
 Wed, 04 Jun 2025 02:40:53 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b8f0sm20869872f8f.6.2025.06.04.02.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 02:40:52 -0700 (PDT)
Message-ID: <9702baa7-55a7-4ea6-8536-7c614c608e5c@linaro.org>
Date: Wed, 4 Jun 2025 11:40:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] target/loongarch: fix vldi/xvldi raise wrong error
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Cc: maobibo@loongson.cn, lorenz.hetterich@cispa.de, qemu-stable@nongnu.org
References: <20250604084005.528539-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250604084005.528539-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/6/25 10:40, Song Gao wrote:
> on qemu we got an aborted error
> **
> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Aborted (core dumped)
> but on 3A600/3A5000 we got a "Illegal instruction" error.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
> 
> Fixes: 29bb5d727ff ("target/loongarch: Implement vldi")
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..9d82d162a9 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>   {
>       int mode;
> -    uint64_t data, t;
> +    uint64_t data = 0, t;
>   
>       /*
>        * imm bit [11:8] is mode, mode value is 0-12.
> @@ -3570,17 +3570,25 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>           }
>           break;
>       default:
> -        generate_exception(ctx, EXCCODE_INE);
>           g_assert_not_reached();
>       }
>       return data;
>   }
>   
> +static bool check_vldi_mode(arg_vldi *a)
> +{
> +   return (a->imm >>8 & 0xf) <= 12;

Preferably (as easier to review):

       return extract32(a->imm, 8, 4) <= 12;

Otherwise patch LGTM :)

> +}
>   static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>   {
>       int sel, vece;
>       uint64_t value;
>   
> +    if (!check_vldi_mode(a)){
> +        generate_exception(ctx, EXCCODE_INE);
> +        return true;
> +    }
> +
>       if (!check_vec(ctx, oprsz)) {
>           return true;
>       }


