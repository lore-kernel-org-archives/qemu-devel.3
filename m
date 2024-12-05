Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616A1E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJHS-0006qz-Cy; Thu, 05 Dec 2024 16:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJHQ-0006q8-FD
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:21:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJHO-0004oO-V4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:21:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so14748695e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733433657; x=1734038457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y8pEetl/WyEfupSbgMWjuqo3VBoEr25mm3nu7MTgTDQ=;
 b=qJ7qMvrikL8F7sMzc6NJMNjifS2X92fjSAAncRyPUkqpZ1szj4rFO2Yg1AnzFi2jRa
 5xNXzWtRscHWLAcYfnPonDmfIjXTKPAfufI3X+nUzXJaClINWp5kakMDFgMMUSSByGSg
 8l9XoMpwEyy/L0AT8ZCPasybBDIBUTZlfakyByEQRMiQMuaHnWTvaL/toJrmKmxtss9s
 4Bgf8vTw/2oDANy0rs8TcxIaNn2vTRqA0NqtBGq6O9/4yKfa32POKKToHqplXZV3zYs/
 LG9j52m5XsQcRTxQYG1kT9kbc8qe+YAIWyqwityAzack0oW7XP73Jd7pwY+GvndyRAAW
 h4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433657; x=1734038457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8pEetl/WyEfupSbgMWjuqo3VBoEr25mm3nu7MTgTDQ=;
 b=jDezt7g+50/5LBapkZKo94bS93H/0849FrByh58JzqrEJcg3K9o57kTisJp5voaoa2
 SOAoUVhVryZzP+LCNI9n8GSkYZ4BWkN0c0YkmBmOAIUb9uEwNr6HTbGtI4w4wAPoyS+5
 3ud/sV6yq4+0j07hff4U8awccoRHGF+uVRg2Sztjbpt84SrhKiqjlEXN4cxMwJBlFmdc
 pIUyZ7snYYdZor5q6FR3l0pi5dwo0mBvTtFeoV3eRj5lTG9OBdEm53B7/tDrqegS2sXN
 UppW75SQOJCH/vBD6PXBOWlFEHKshWupY5UOYQqcCtauDxXGqNrNwjtIF1Ez+F/2WjUA
 bn+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY6OnLB1wKsVmpL8OQDqQYgfyzEmC6VOcfetxMFGqCemUo0W5BEHafarXGTQXmgMDvTdoLHYxHbUC9@nongnu.org
X-Gm-Message-State: AOJu0Yww8lwacyrSeCYMAL+DdA1GQrmWM240swj3dfM8dEJg6J7uVafR
 OH6GOouFLmw+NRLT4VLVcK9IXZIdTNXamsb9hOQqJzYu3mbh4RSw8QbLV9n+GJU=
X-Gm-Gg: ASbGncsgHmgOsmIiu+BMiRLTmaoWuycpHoITtUGs+zTDxDQOlBsaAq4uCptKZZnD0ph
 tUHuHDaE+3pFPhIU9InZoalLgdBKTieyGEKosX/Tzxjox1OuSyz94dORIa0R1gxATNqlMltEaih
 Z3kR4JcPLH49bfUXUhSRt1aqDDOrnx36GQqs7ojm9wVb0GAjxmbIo2lzCECQh+Pe52uesKuW5Fc
 FmubpgHhzUDqbeqBccnmIJedx86Cr1z/F4JeE5gaX6gV2T9n0tRcUVWoLbYz+1Q2D8X1pzmhBi3
 QwG5Ys3UAc8b0rp5hg==
X-Google-Smtp-Source: AGHT+IF3xnXbl/xR7p5VhvuWpElW1B0yJ6etx6JPeVw6Jp+HtTZOHfmNNY/5HJ4z/2ORIRCw9wRr2w==
X-Received: by 2002:a05:600c:198b:b0:431:5a0e:fa2e with SMTP id
 5b1f17b1804b1-434dded65fbmr5382435e9.21.1733433657280; 
 Thu, 05 Dec 2024 13:20:57 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d5280b60sm71931055e9.25.2024.12.05.13.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:20:56 -0800 (PST)
Message-ID: <d02f5bc5-87b6-465e-871f-521a49a27b22@linaro.org>
Date: Thu, 5 Dec 2024 22:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/67] target/arm: Pass fpstatus to vfp_sqrt*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Pass fpstatus not env, like most other fp helpers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h            |  6 +++---
>   target/arm/tcg/translate-a64.c | 15 +++++++--------
>   target/arm/tcg/translate-vfp.c |  6 +++---
>   target/arm/vfp_helper.c        | 12 ++++++------
>   4 files changed, 19 insertions(+), 20 deletions(-)


> @@ -10403,6 +10401,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
>               handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
>               return;
>           case 0x7f: /* FSQRT */
> +            need_fpstatus = true;

Should this change be in a different patch?

>               if (size == 3 && !is_q) {
>                   unallocated_encoding(s);
>                   return;
>   }

