Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE3E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVpJ-0004Zv-Qd; Wed, 11 Dec 2024 18:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVpI-0004Yq-5H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:09:04 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVpF-00031U-Ie
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:09:03 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5879011f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958539; x=1734563339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zsmSPaG3Pa+CQ9Uj41IVqOgCCcirEC0d/DLzNavG/yw=;
 b=D/XTV3e5if5NyFYt9T7gU0yIuZwhKcHu7XqlNb2ifDQuQyT4Vk3L8zY4FMS5oPHqsv
 t5unyjxi+P/ea3yUzQdfhJMCeJ/M4GCG5ctr3JgDTzgcmDTbpT2Vdh8+o4uMCtRZAlhU
 Ww/rpo/e5+OC6oUXx0OZ+K5cXHKMFOO5ldpO2c9KjG8pJwXahmr2YltCSTpAqBO0gSWQ
 d7Mce7ARLAn7BSUhJz/0XFdHyStO63lnaPkZ1rNDbW+qITnr/CmsxjJtuhDQ6RBPqPDn
 nn4/uesH/7uBLq2jkA7Irxchhf9EO9KLo+jidDamkFhn9qEnXV+mCaUc675MFJKc3pkm
 2C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958539; x=1734563339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsmSPaG3Pa+CQ9Uj41IVqOgCCcirEC0d/DLzNavG/yw=;
 b=iEPkGHlKSWf8ecl15S0t79nXIY5E103DQYlIbL5eyfGS03F1BOC2jy+HqQ62zLaTzy
 FIXxs0S1NyDYIU/eyfhpW+EspiClNL0M8E6MtJonHPdVW1euAuhS1O2hOuxUvxGvK81o
 64cwtKyt24zZR2NnyY2iVP304UdfBLnseRSmFE0Ex7I2S1jhsrUrW17K94x9Kvb5g3eH
 AfNr8xO78dEDK721hE2sISr1xBPxBzL+YUN+wzHJGQc5stLxFckfexTmL0CwDBQy/Za5
 i0aTL3EHzL2mdaJzFiiht08sjyOgd4QMp8E41ifPA+TunjapRbElCLICAegeTzJrQGnX
 dexw==
X-Gm-Message-State: AOJu0YxoiaKKXp6O+r3BvS9aBQPF/beT1yD3mZR2ZLk97/8+RfhIaarb
 BLJwTOBM+E9eRzKjVMibazqkdzzPnEBKyaYUy+RmnkJ9kVT1ryGnm4k0zaJZ+svtBkYNFbO1+CP
 Z
X-Gm-Gg: ASbGncsWSxu+avKs8GgoJWm9sa2mTJRq+wDZMgl00Jq/sngEpHxwH8cAkHfOqW7KtmK
 9ereS5jEv1vbNCwS+/EgKEn2YLbICbqPwYSPLFkPTkKpeU8HRNzM59eo/k3nUxchX0aXqJ+ehM5
 bpIDZXDncf8yEo8m4VMoowJK4sAjHUiotn68jPBf/K6fwehdaqNFYO52kTr1r94jB3H3CwnQig6
 PTaQCw6J33DYA8DQOOQxPlDIpXWxw7rc+UFFHM462SmoxAk9IIKE1jT9h76rb/LvXFTi5Nm8PmA
 c9wFkKs01TrHK6WiYrimwu3z
X-Google-Smtp-Source: AGHT+IG6Rv9KqV5Sxr1Tcg5WIW10bMeeVfK9fLiqheiI4qEhoVfQpzLx2CVeLjGDJiVnKs2z9vrbog==
X-Received: by 2002:adf:e18e:0:b0:386:4571:9a22 with SMTP id
 ffacd0b85a97d-38787695702mr1024951f8f.31.1733958539517; 
 Wed, 11 Dec 2024 15:08:59 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878252d22csm2297033f8f.110.2024.12.11.15.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 15:08:58 -0800 (PST)
Message-ID: <6e1e69d8-a9f3-4a30-83c8-84c5647578d5@linaro.org>
Date: Thu, 12 Dec 2024 00:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] target/xtensa: Remove tswap() calls in semihosting
 simcall() helper
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241211230357.97036-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/12/24 00:03, Philippe Mathieu-Daudé wrote:
> In preparation of heterogeneous emulation where cores with
> different endianness can run concurrently, we need to remove
> the tswap() calls -- which use a fixed per-binary endianness.
> 
> Get the endianness of the CPU accessed using the libisa
> xtensa_isa_is_big_endian() call and replace the tswap() calls
> by bswap() ones when necessary.

Instead read here:

   In preparation of heterogeneous emulation where cores with
   different endianness can run concurrently, replace the pair
   of cpu_memory_rw_debug() + tswap() calls by put/get_user_u32()
   ones, which still do the same under the hood, but simplify the
   code maintenance (having less sites to do endianness code
   conversion).

> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/xtensa/xtensa-semi.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
> index fa21b7e11fc..2ded8e5634e 100644
> --- a/target/xtensa/xtensa-semi.c
> +++ b/target/xtensa/xtensa-semi.c
> @@ -30,6 +30,7 @@
>   #include "chardev/char-fe.h"
>   #include "exec/helper-proto.h"
>   #include "semihosting/semihost.h"
> +#include "semihosting/uaccess.h"
>   #include "qapi/error.h"
>   #include "qemu/log.h"
>   
> @@ -323,15 +324,12 @@ void HELPER(simcall)(CPUXtensaState *env)
>               uint32_t fd = regs[3];
>               uint32_t rq = regs[4];
>               uint32_t target_tv = regs[5];
> -            uint32_t target_tvv[2];
>   
>               struct timeval tv = {0};
>   
>               if (target_tv) {
> -                cpu_memory_rw_debug(cs, target_tv,
> -                        (uint8_t *)target_tvv, sizeof(target_tvv), 0);
> -                tv.tv_sec = (int32_t)tswap32(target_tvv[0]);
> -                tv.tv_usec = (int32_t)tswap32(target_tvv[1]);
> +                get_user_u32(tv.tv_sec, target_tv);
> +                get_user_u32(tv.tv_sec, target_tv + 4);
>               }
>               if (fd < 3 && sim_console) {
>                   if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
> @@ -387,11 +385,8 @@ void HELPER(simcall)(CPUXtensaState *env)
>                   const char *str = semihosting_get_arg(i);
>                   int str_size = strlen(str) + 1;
>   
> -                argptr = tswap32(regs[3] + str_offset);
> -
> -                cpu_memory_rw_debug(cs,
> -                                    regs[3] + i * sizeof(uint32_t),
> -                                    (uint8_t *)&argptr, sizeof(argptr), 1);
> +                put_user_u32(regs[3] + str_offset,
> +                             regs[3] + i * sizeof(uint32_t));
>                   cpu_memory_rw_debug(cs,
>                                       regs[3] + str_offset,
>                                       (uint8_t *)str, str_size, 1);


