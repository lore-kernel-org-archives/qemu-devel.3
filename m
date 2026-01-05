Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B24BC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYZF-0006oa-TK; Sun, 04 Jan 2026 19:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYZE-0006oF-QS
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:35:28 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYZD-0000ka-9Q
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:35:28 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso14501924b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767573325; x=1768178125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=67P0VelRO0HOdGIIcXf1Wiy26tR6dCvSeKQN9Bwot48=;
 b=PiWxMLq1ILgLyDE4BwAafhvzNASOGFiUvhIszvbJ4SDKKogr6gdYckzDvwP5drP0BH
 qed8TtapLhm5PgTBjRPlIN1TiFT2tC09mwP11qpTYskqHKHu5lwh4qJaY6PlWuZM49c3
 MFULCFG7ji8hK45vHDqFuR7lebUmuW9P0wBtUXwWLXyiGJiIToCXgu6zBUNcD/nhFIPb
 Yf47wZsASY5T4dqr/Ygx93ItG8Nxg2TTnMOVGUsB0695ku3dP9PlnKYHhFhrk5xxt8Q7
 M8V9zFNiMSZa6wmAIrBL+ifOtK+9MnPQG6jdIzLOtCbygT1IvuzSK02Uevk+DvqsiCji
 ZSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767573326; x=1768178126;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=67P0VelRO0HOdGIIcXf1Wiy26tR6dCvSeKQN9Bwot48=;
 b=X2LZITCoAh7RtZTf3uqEOtT0MpjjhDxBuYkcpmRXZ0zb49q/JUBjd2Wx7c24oaq7i5
 4wu9e86xbMzaMufG/SNEVHqrqkvybxyBELmjupiv+OA+E87N8/G/IbzztwJHSnkp9cvy
 nVI246CSntjc4kwhE5nH1Pt3GaKdi4TbezD+Fp7VH3IlJNZMKuKgpvURix7UUMQo/6k0
 HD9+2LWX/33rgBXhDbaSnn6Jw7yI0EDuiSeK1D4LSd41GjcmuGDsIeLHtDzqMTEmq7zt
 4fuWRx+OBnS7sFOfwgz9wi2xGvVhRlLIzCivYHpXHPsUjVJoJkcX/TLePww6AGex6ZwO
 dVdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeW7Uu/roM4pUwo5XTIZVcALDgDw/r8Q8RNE72FTC50hM9wuHd00X0zipSdMzy/PxxqeSPBiEbI+Qd@nongnu.org
X-Gm-Message-State: AOJu0YyTY+gvICeJDw8Q1rGIRULOGxQFfsmnVYAF6EiA3V7LJ61Wodp/
 TdHZJwW2JjOTwUo42tDvT20Rdj9rpmrOej7umisvpho0f9BSzbQrLMo9ERPQjJGcR+Q=
X-Gm-Gg: AY/fxX7xwzyJHjzCo9J4vrwjMmkItwPZydtMFc8cAkXpoGnz1qe0OjYifvAaultxg/g
 O8GHjRu1YqQFf5q8CaLX5FnUh41YMeMyqyeVyuDEyUdvTi0md3O6myGRMQC+hmaqgYbKr+EgqPD
 k+JFMYBJ/6cYu7YOD60HlLv/f07n5lAPen+Aq1xwqK40HvVxTiVi8XSEON5/VX7xMDoNyaq+BSS
 iXMoc4brnR3pLSpf+m++CbqyATzW0rzPzLspDv+Q9zWtJw1O26vwVd8UaglnjEz8wl9ciug5WT6
 hG1DydcsW30nx88BEyiJOtCEYBy/o2WWUSfI5YLDp1dpuweyVjlAnyvqgJhrm2nnVU9Q0YkN2cG
 sYdxz/UJBedrq4fnEY0Sn7BctT3atYjMcSGZFYudTuCOfVOhTs8Iw6r6IchF0Y+0VQfPhVeGYiE
 mlH4qdlAdBUJWozGWjJlAgp0xr4jCy+w==
X-Google-Smtp-Source: AGHT+IF3A8B0V7uYMEXDCwlv5zyIQMCRvpPGPFAf+sPPcM581WNawWXnJJbD5VIQO9cLwzLLhSKWIw==
X-Received: by 2002:a05:6a00:1f04:b0:7e8:43f5:bd26 with SMTP id
 d2e1a72fcca58-7ff67455837mr44606280b3a.59.1767573325490; 
 Sun, 04 Jan 2026 16:35:25 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7aa328basm46468566b3a.11.2026.01.04.16.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:35:25 -0800 (PST)
Message-ID: <ea5b0c1a-cd90-4e98-9aef-f25e864f1a4c@linaro.org>
Date: Mon, 5 Jan 2026 11:35:17 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] target/sparc: Inline cpu_ldl_code() call in
 cpu_do_interrupt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ldl_code wrapper, inline it.
> 
> Since SPARC instructions are always stored in big-endian order,
> replace MO_TE -> MO_BE.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/int32_helper.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

