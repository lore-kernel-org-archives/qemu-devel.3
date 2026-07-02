Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72DDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLnz-0002yo-Oy; Thu, 02 Jul 2026 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLnm-0002yD-KJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:06:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLnk-00021k-3o
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:06:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c99672293cso20913095ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783015572; x=1783620372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YHp3qTrwnqyG8gtZe9J4Osishaoqr2bqlcF+ZcKAw2Q=;
 b=qUWS7hyk/+E8SLNL/D/hY7pJfOn6reOfuKnC/b5hFcIiMer34+6G6hDhAjqMqp+wlz
 rgaCoFdZ/EuSmIo7Q4OohyBhiLoePls/A5E01M4ahSAZz7EuPx//jnWwH8rtfkqJTUJR
 3s5kE/WfDTQq38oYNsNC8eOtwQUjKfYKoU2dOiOw/pmtbWrzy3OK2Svdaq27vK6IthLm
 jYgIKnUBk+q/m2GNIykcNle8LgdQMkE0dZc+XH/tUMbXJoV/AfrggQ5efqjYjL0ggwE0
 ugtBdMeosoW/Ku0gXEIbFP+z7v5yfq7QJJ9/CWPA1PMsc4fyPVL1+BMtsMfPz4D6mlVF
 6HMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783015572; x=1783620372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YHp3qTrwnqyG8gtZe9J4Osishaoqr2bqlcF+ZcKAw2Q=;
 b=prZ7w1FZ7Ffao0ZGmOi99RdDAJyBT9CRT1hZuHRXgOd2F5CgbhsYkk25ST7h3tnzaP
 CHvo2JgbDN3MzkgZYooE5KDK+0nJxx8/1FVLoPo0D/aF6dW9OIvG8/tfgak+y3DJKfTy
 rlI72DY1PdDmKgspYSYrH3TOThAZcRx8wVOsxq8Ub4gGk+kdTy24DHOFn+j80ZY1Jlfq
 Mx/kyOBIXp420N1NR8Rn2D5vaKR7nk2hfWjPDZmIGtCgj+LJvcoF4yypdglfmH0aEHXS
 WLXRdshUL0cJOpzDVLqSgppr57FweZ8Rhnyv8F6Yu5Ezy9ut50/gwtsZHo36VDpctmy5
 cxUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpM1ZigkfvsCDi8u7GP/zVVA5Zl7dO39NNG9UoyHBaiu5Ije4z+nR5Tlzkr+3ZyDonIWyrnxhREUDCh@nongnu.org
X-Gm-Message-State: AOJu0Yx4dcQvHPTeYSH8QL6OTBvtd+BRO0GNr2H2KmsRU/znurTExsRp
 IgS8GzcPxJsRFqTWbdlTozLU3wi75m4NDDzdy5Mj+gU7sQU2+BRAtzRrQjAJrl92HEo=
X-Gm-Gg: AfdE7cm5o4akyjrPSTwFGqexfx53u81hTP6bf80gp1W9dD0pAkcYkzrezOqwyi9q9Uu
 alruAV8QqqRhpM0k+8o5GoiCu/kAe2qXKkW+/hCfYjx/j+u575lZTJwQ4fUT3vqX3rrrVGgAuPZ
 zNo9prkXavJQIJSEeDrNPT8T6VTTZd2uF8a+zKvyy5Rl1pEUAEPPvjWUmrRDONdnBEkr7VyVV/9
 fKHMl+HKLhuBKfc/HYl+dlv7/dGhSQngwhrJ5OUseQBt55CbA3EebgPB6Nm8kI2WI0D6VNaobre
 eL1ltpWJAi96l/yDuBAFEwxb/Mtq0MnatkQ1/79S/rpGBRuDgS8tDqfWCK9tCrnZciSN/OTq5yB
 vhDJj+3Nk0SG7ckYK3RC0eXmxuo2H8StxyTcOgPPLrA10EzOP0RjwMau/IqrEoqLhx/yZAp6Twp
 Z/Lt3r/OG3Vv6EBtlXb2HGU3ltfbA7WyBQzpeqmgfCXx5Dvi9N0Qhs6RB6Ng==
X-Received: by 2002:a17:902:e746:b0:2c9:ed4a:c3a1 with SMTP id
 d9443c01a7336-2ca7e6ff0b0mr79237615ad.19.1783015571845; 
 Thu, 02 Jul 2026 11:06:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9aa052d5sm17268385ad.78.2026.07.02.11.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:06:11 -0700 (PDT)
Message-ID: <2bd90440-babb-4cc6-8ab0-71b21ed9dc7f@linaro.org>
Date: Thu, 2 Jul 2026 11:06:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] target/xtensa: Move watchpoints handling to
 check_hw_watchpoints()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-27-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-27-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Rewrite check_hw_watchpoints() by moving related code from
> xtensa_breakpoint_handler() to it. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/xtensa/helper.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)

Eh.  I gave you an r-b plus future work for the previous, but if we're going to start 
adjuting all of the backends, let's do it right.


r~

