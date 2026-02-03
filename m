Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CCCE83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn72n-0002Rd-Ur; Mon, 02 Feb 2026 22:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn72g-0002JX-Uo
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:25:32 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn72c-0002be-QM
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:25:28 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81ed3e6b8e3so2713404b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770089124; x=1770693924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X01w1Lgi640hjB1p7HlOtIn1r6cwS7uwmLcDBCpQSfk=;
 b=XjDpoqIU9h4uagDDdZssPyghTTF2bhP3lSEPpP/8tqo+uLssjMgQq4thKnc87QmW/q
 8QJI0K5vnc8NlUz+8ChhbwbRlGoq0GXtAcXpKOKsyp7YZxfH83tB4ofO8jiH0DV2F2yL
 UL+64AEfMklgJJg4+UTVOJW4otq7ZxT84N5noV4e5ymfYcAqbI8yumLNw8g0knnmq28C
 M8KwS0QJTAIehflaWiImcAGaZvPm8zYg4wy6jZ3/SnXvYr0qRTwonZew3duRH/VJNqmm
 3DnSE1rGEhVNWuz0Xb1QuFcFCkRFWCaTC/VfxGZEsWZgnnoA1rYDPWP7w5dONaOknHLK
 d+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770089124; x=1770693924;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X01w1Lgi640hjB1p7HlOtIn1r6cwS7uwmLcDBCpQSfk=;
 b=Pd8uJ1P5AETJ9T2+1L/8aQjC+hswjlTYrYdkV4pQP3dx14VK9vmzDJnPDai5NDCBz6
 J2cswDh1VT05qRix9jh+B15ggLZ+WIh1BWOVaEu2/ysfRpCl/UTPs6q27v4F2VaAvZuJ
 YMbEa7P9g/83QJIt2l6v4PlA6vSSymFSd1eg75jJIUnOlpjy2ICGLeBtH/2dG+N55Wsx
 VcrkrZbIeRXY9B6OqlqUsqmH+XMlwfp+TJWSOK1ng60M1K7Zi4Gpy2gexIg5nZGNmyqH
 oPmGsNj7N+PuA3VJzm34VTAPtb/6mYcS4VkHkinpE41i8HpGmVJ0M66sdiKWhppf2GvQ
 l70Q==
X-Gm-Message-State: AOJu0YwGo/0Sqlyf8ywea+0pOHx/UIINSNXbO2IWwdJWlo0nRWWiVWGl
 0esEXi5/JQFbB4VREE+KBWFdTAi6/MGX/IzOlwOu/FuR8DGpha6Y7R7XXQw5khbfv+HNdyKE8zT
 3pcVkA5eEvQ==
X-Gm-Gg: AZuq6aJZkDjeFp4wd/p9YU74FZfJQFoa9wForR4lodx6yv+eB3R0BuSOu3Y5/mONBdE
 o+yRpbBiu1F6nSCKFrS+mPcC5A4T7ztRX+TpuEIl8sJDvRMqL3wyMj9gJoCoWZjdtM6Kfrn7mG6
 6aQSTEJgHyzTUf5XFtq3PYY0idCRDAZ2ojaOk8OY5rda+vQzSaUICaD1UPwWluWUD7Lsv3lE3Kp
 Zu0pZXvgmj+9Ha1ly1E8M/SnGYpHE0ucyD25TboAcr0h7XiWWbPwCyNBgIBPbVf39W6srzzkKQO
 FM4NvrX3OWFUk5LMOgd4UscmKN008J1Xp5tyOFEcoJHVAbLp2Kuv4dksA+NlfRTnYuL64lm7Ybn
 LK1mTpf0y2oqInTgOeOPeWx+v88w/dcbttxkhQGTWuq/FX8rNAUeLhqCgPBEhc6ZXQ6ZjLMnNE+
 hJCc6gI39PHa4MI71c/kaC1uTDpgUO3ax/XV1fKW1aeMumrNeUlHW6YOKRBdJJD7mk0zi/cw6/f
 Zlxq1Ma6O7gpLz2qjYrzykbOnlwuH8maqow6eQFBA==
X-Received: by 2002:a05:6a21:7303:b0:38d:ecd6:60c with SMTP id
 adf61e73a8af0-392e01c230fmr13845339637.77.1770089123832; 
 Mon, 02 Feb 2026 19:25:23 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b5df0desm158747495ad.82.2026.02.02.19.25.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:25:23 -0800 (PST)
Message-ID: <1d93dd4f-90bf-473b-bb1b-8ce2b8ea12b5@linaro.org>
Date: Tue, 3 Feb 2026 13:25:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Inline translator_ld[uw,l,q]() calls
To: qemu-devel@nongnu.org
References: <20260202214050.98935-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202214050.98935-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/3/26 07:40, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the m68k target, expanding MO_TE -> MO_BE since
> this architecture is only available in big endianness.
> 
> Mechanical change using the following Coccinelle 'spatch' script:
> 
>      @@
>      expression env, db, pc, do_swap;
>      @@
>      (
>      - translator_lduw(env, db, pc)
>      + translator_lduw_end(env, db, pc, MO_BE)
>      |
>      - translator_ldl(env, db, pc)
>      + translator_ldl_end(env, db, pc, MO_BE)
>      |
>      - translator_ldq(env, db, pc)
>      + translator_ldq_end(env, db, pc, MO_BE)
>      )
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

