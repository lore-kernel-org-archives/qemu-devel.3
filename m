Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF572CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtgk-0005tf-4V; Wed, 17 Jun 2026 13:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtgg-0005lG-8g
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:04:26 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtge-0003Yz-MZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:04:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8423f236418so3330839b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781715863; x=1782320663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s0EZdMS8rR382YUoOdXLvOEBlwPonagsVmUrYSvyNpM=;
 b=ziPOGGRuZWHifSqbflRFzmzS7uKZTAzuk6phkfvhGdih0BITeR9PXDQABCYG+dpslb
 motZ8U4QDyiDSVgXvLTp5hmYSB96E9DKfMkPjHqKW49a0qwRvrWPQKgrfaGh5uEhAvfc
 fw9ynmg1X9V8MdwCKPnN4o1EarWf3flBbNe6GDce0A+uiNqAAFikGGjfWBNLcE0RTsD6
 I2Iz7705ZY6QTpbv9x0wVoyHqE1//RUZaYZ3bMAsW4xbDQrZhLzZqQ3ANcqt5bZaND0N
 gdvBu65M8+8x/pk0d47kh2x5oxz8FpInaU65rYj5P67/uS7NZbibIghXmz+os/GV6Mm6
 dRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781715863; x=1782320663;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0EZdMS8rR382YUoOdXLvOEBlwPonagsVmUrYSvyNpM=;
 b=Ul6NtoGjmg4h1mW1Vbh2CLp91V6UyJgV6Ze6FcNpT1oJdgwFmiRpcYYfpILwlgXs1m
 3B1Jn5qaF1fRzsuCaA3iDQtSz0J/pYWVGOA32hKFRsVydtyrnQ1UMMwXFHJ2iI6Wqc9C
 x3qxy4ja5BNiuArq+UjAge2jKInpLRujNDDFZDeyyRHGD+JO87LOhmA4CqP7wz+ncH72
 /SzzPe65kO2hbNIK6uH68Bd9Q72EMahAe+nAYMDoLcSzWp7rFJ6jljUb/3OWGZNlKKNc
 +Xvl3a3lPtGuFsawgSWbzWEyG5XBhj6s1821IFWarZBifkWFTrpPtz3xBCttftOHrKuz
 mwgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rAXz4Rw9u6CvL/T0+gcQSrpB0DnWXtIDApiC+sespszgwVDYVLsUITZxpPEA5frwLwsNjqsHDz6Dy@nongnu.org
X-Gm-Message-State: AOJu0YwndwHtD2omz2TUZseSbQoConxRhbJSjk5srMZDLc2t7b1qdIYO
 crAOIZPojimkPMjEhaZYT/EjshRvlds+kZF/qLYDAYXZhhPTNkaTo5QIH+4gck0ECPv/RG+JYbU
 es6cB
X-Gm-Gg: Acq92OEwu+EhrIM1hLETKlwHELhtiStb1cL7iRd0RxTeEq07kaJHn1ZzYuhZld+/VEU
 eZ/SOw3cbRkZqgFqi3Myfpk1WLxb66uYVJBEZfQGjN7tVIzVej2rEcyfJmnnfNUDusYak2I1jQK
 wh6Al1mMuwMkgSGemRHQKMAdBvad2AL3edr1zLgG6HQ8ji94HjsKpfHHlwjt7D2O1jlHXvEsCFJ
 knENhMPlP4rHoNIiruonrVK71Z2/Mmjn2crBAXVRLr6OBEzPJap1E41FyvvqZPUFJosLrDOORnO
 vtRyIbqd+iUVbdGsArRFVTUlWK4P34O30n5admWPRyv7d3wG83Yp7B9Mfkvlk2aHWlYMCUsXjwa
 ls3vz9WSTXI63/PebwnHbsar+WaJmGcETEf3fK4IvnqU238o+gUhgdujhZQ8rsiXQrPh4faZbE6
 SZfv/0CFvbZKb5rDNd3S8cVE3KaAQ++JS44z3haU/QqyBLkhzuPmjctL0Uow==
X-Received: by 2002:a05:6a00:3318:b0:842:655d:1232 with SMTP id
 d2e1a72fcca58-8452414d108mr5064076b3a.0.1781715863080; 
 Wed, 17 Jun 2026 10:04:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b0226acsm16691812b3a.48.2026.06.17.10.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:04:22 -0700 (PDT)
Message-ID: <ca956432-bcc5-4fba-af3c-424fc54ce455@linaro.org>
Date: Wed, 17 Jun 2026 10:04:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] exec/cpu-common.h: Avoid including unused
 'tcg/debug-assert.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
 <20260617160426.64461-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617160426.64461-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/17/26 09:04, Philippe Mathieu-Daudé wrote:
> Since commit efe25c260cd ("include/exec: Split out
> accel/tcg/cpu-mmu-index.h") the "exec/cpu-common.h" isn't using
> anything defined in "tcg/debug-assert.h".
> 
> Include it in target/loongarch/tcg/tcg_cpu.c however, where it
> is required but included indirectly, otherwise we'd get:
> 
>    target/loongarch/tcg/tcg_cpu.c:291:5: error: call to undeclared function 'tcg_debug_assert'
>    291 |     tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
>        |     ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h      | 1 -
>   target/loongarch/tcg/tcg_cpu.c | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 7dc8cab3263..d1a04025363 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -10,7 +10,6 @@
>   
>   #include "qemu/thread.h"
>   #include "hw/core/cpu.h"
> -#include "tcg/debug-assert.h"
>   #include "exec/page-protection.h"
>   
>   #define EXCP_INTERRUPT  0x10000 /* async interruption */
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index f556234d9d2..83291c22c2a 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -13,6 +13,7 @@
>   #include "accel/tcg/cpu-ops.h"
>   #include "exec/translation-block.h"
>   #include "exec/target_page.h"
> +#include "tcg/debug-assert.h"
>   #include "tcg_loongarch.h"
>   #include "internals.h"
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

