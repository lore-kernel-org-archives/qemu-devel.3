Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31F8C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYBn-0000nw-1H; Sun, 04 Jan 2026 19:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYBm-0000nc-4l
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:11:14 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYBk-0006ir-NL
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:11:13 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a081c163b0so121624675ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571871; x=1768176671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vJrgPVFK6uwfvnKINa3d0+00aqlsY0HQRw83EPuy8tI=;
 b=vETtuZjUch3IXo3KgWeGFe+fITO3+3/+fM4rxMIpMphqyiWrBPdlj4WvI7HjNYBV8K
 Y+pTPh9RDGB9A5blFmPuzFW2OvEjMbU3NtYTbPiA7uCaPT9SfQQV5+BjYEur6rm6DJH/
 Q5vfBCMMO6iYe7P19v1g2Y3LbVgWjaPID4rTzq+E8YuSM9e8p2ReeUXQRHOshUu3U3r2
 xRTcHOvXe6YJJtgFZtiHdioGxSk/U1jn9bXXXF5WoSyPAeraBHf/cCMwEAAVy8/Ek65T
 S7jKm6b3nvvnasAMluLyX0705VoA+x2IIKKkMsf5jeGwC+oBLHRHDBIfnQBuV8svhiEw
 wEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571871; x=1768176671;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJrgPVFK6uwfvnKINa3d0+00aqlsY0HQRw83EPuy8tI=;
 b=PesmdgfBS8xEj1nk9AvwQaSie95AG/BHkHxzPkfaCWEdTZYBfdfP/g6rXL6TQChXoR
 iZ3mZ+zusUVM1N/Q3Hhj57h1X1X6dJXJL1Wob4cUX6WAhVlFuijxW/7Pzy/OC3yYLWgd
 Zmej7BC2o6waVP0T9qBonkwWN45o3EETbraaZY1Jkxa2JvLaniZrp/YiZtOSL4sHnNPi
 zrFDQMrasqge1Rkq+ZxiSpcb1BYmzz8iK0E6pgNqgjeNRz5nA1X2osXiB9dBBiOdQFl3
 6uNA1F2j3cuS5BM4wjdqm/1OjZlYoApyUxZx9MKNuyKhH7m2pkKiySjggECXKdR2tmxe
 vQqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgW+YBFPwB/FljfmFvGRN/5tgTAlXvTWzO5alXteydJPTfxTH15OHNGdC0cc+IZwQSbW9tAScFevGJ@nongnu.org
X-Gm-Message-State: AOJu0YwEEqPxnL2cfZkIjaUgp/8yaVeRuHXSTbo2r6HcqGdLFAO0kOlD
 4H0gP8Qpb1c4llw47ShhswyNNgbUNksNhvzp7VAkHvqzEN4wwegIIjA9F/YEJxZGPoI=
X-Gm-Gg: AY/fxX6fakkJa4UtZSz5Sc0YBQRfYhDZbJjobkcOAqSPf7uEDrxTKghoZAZHzB7Gkoz
 vsygd8tAsA1IYt+A2cPOEIuqAGvngLRhMVcpnAZ4ut3t7WQh/eUJznj9iwGDpGMRYUlJYa8izUD
 g0tKMsACGfkTLqYNzcAsrZi6kttu1/0hqiYHQFpEg0qcu8RRWWw0QsnXxsncC8jz4Mshtpv+zbf
 +IfHa2OVQxn3YxHsQm9QUORzoBz4cIT0UMfWvdC1F5ffXwke0AWaywlkiv2RKHdIhU5rzUerlA3
 5lzw7sWxywyLyvP+JDrljI36JKXzDSsglgGxaMqz3+gfUTJtAtLptv3B6j58d1gLsoIVdXazXKb
 j13ncHC8+tan36gskLo+dhtMap16ihnEKB7PMk0RJzLXsGic9K6ggxABSK4XdMUQWfG3FaMOK/x
 WN/cs9PwT4kMXvvdUspKGRjL+t1+VPvWkyqvb9DTMm
X-Google-Smtp-Source: AGHT+IEFuU+yuOJzTy+I5dOKmpHE6Tcyov9G7Hna6ylS6f/M5FidFzP5HDkkm6PeTGIin1eFsbn/Kw==
X-Received: by 2002:a17:902:e804:b0:2a1:388d:8ef5 with SMTP id
 d9443c01a7336-2a2f222be85mr444098075ad.19.1767571871164; 
 Sun, 04 Jan 2026 16:11:11 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d77451sm437662245ad.96.2026.01.04.16.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:11:10 -0800 (PST)
Message-ID: <bc66522e-0c13-4c03-a7ec-86ef64a49eb4@linaro.org>
Date: Mon, 5 Jan 2026 11:11:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/openrisc: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224161804.90064-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/25/25 03:18, Philippe Mathieu-Daudé wrote:
> translator_ldl() is defined in "exec/translator.h" as:
> 
>    198 static inline uint32_t
>    199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>    200 {
>    201     return translator_ldl_end(env, db, pc, MO_TE);
>    202 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_BE
> since we only build the OpenRISC targets as big-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 6fa4d6cfa70..a6d550bbc2e 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -1558,7 +1558,8 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
>   static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>   {
>       DisasContext *dc = container_of(dcbase, DisasContext, base);
> -    uint32_t insn = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
> +    uint32_t insn = translator_ldl_end(cpu_env(cs), &dc->base,
> +                                       dc->base.pc_next, MO_BE);
>   
>       if (!decode(dc, insn)) {
>           gen_illegal_exception(dc);

Use mo_endian().  With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

