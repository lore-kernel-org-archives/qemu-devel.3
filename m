Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BEFE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzUq-0003gG-DL; Sun, 28 Dec 2025 17:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzUo-0003g4-LW
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:44:18 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzUn-0001iV-7b
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:44:18 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78a712cfbc0so78438637b3.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961856; x=1767566656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=76IDxknxXBqoX1oyS1Cyd97J3Ofy/PVxbMiSLpg6Xds=;
 b=ndP79bGP6rwLm1OnIV7UuRR5VrxTtlFymxVjT4FgiCeFkxBZ1ZBQP0T2PLqbUSNk0N
 ZkYL8rBHPXw6tTd86j7yIzA69beFIrLNH2k9V6+RRScuqcf9rhNdrgV8c3sfo3vjhCOn
 AIRCSklrjBw+IrBAIUMymwTTbGiDjiUjhYH6Ubs9osv0AjKPzVWBQtpyyPg2mhsB+Kyh
 m0CGajKN//xYDarQVGuVnu3tGsLmaWdH9i3HZRS8eSmIPdKKUL56W5xTvvhA9h4zSKMc
 69VDW/1BsO2nZddtOY4Q5m1xXbjQd4ghZnWMPz2VyoqpMLBz2jy9SZ/zLtoj0fQzneNr
 5BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961856; x=1767566656;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76IDxknxXBqoX1oyS1Cyd97J3Ofy/PVxbMiSLpg6Xds=;
 b=l1OGwiXLy6g8YXjLeuFvxcalov/k4PGq2Gchag+lyRM7ypu5WyLhjUNJ2rhDGB69fp
 ppH/q33Aw1kZOw9BrzuagwnQ2NTzjgl3GnKIZjMgUw4X0j0jC3+KeD8DzhHLeZO9W7ew
 NQgNQlmtr/VQ7B1tj0UQKe+X1kbH/Kzkfp2YtoPIFLpgwDYzy+grfh3Z0SPHHGMo7xiF
 n8I3b6Ef4S7b2e8UwqJebQ8RcfO/5P1YQiEnOEf2i4DQw64GJ2dooEsWx2+ZRobQ9QfQ
 72XRheeQJ2FlMqUr8832r3Zs8itRihvSKBXdy8WV0Knesn9TjAe+N76Ty52UdI14FiO/
 LyYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWMVHAlf2V/nXQEkruHN0UOXftH0Vg6l56+HTVagnJCpTKXcC6Aw1IDtS+aGnWcbjy2PdTU8IsOvQ4@nongnu.org
X-Gm-Message-State: AOJu0YzFUyVOhQKqTXiIO22GfTkeeWATHJKZQd0dEXYfEKNOeLbQKj01
 NEbHcdk6ervAZryQX19jtGzq31OE3BjaBMssLog8PyEBUpZ3414OlSt/aQo/LYX7UGI=
X-Gm-Gg: AY/fxX4ca+VW2pfexZzQlaq4NjDWiNEVJrgp2J3IKJcr6n0ZldGopCSkatgG1J/OgvV
 Nua9tw0QgZzqRiDv6Kgp563ybvu+j1xBgJzJNK3QB2AHuR7shDwhjf4iwjrclkMfJfkfAj2tfzg
 fHT7nS0VoHq4RipQFVv5iulEhseIfpbiya8D3/Tud8YcM8YLW5x2xfclwYlDsuNQhFdUBE3PHIj
 tCPkR3oy1SReTGmUDbACiEhtkEqJtHl75XNuCE7RAbUO6N1FCmyEKVP+gtd8Wm9M+Aa0a+T2gHm
 425t5EOFZIjW5itgvkyKVSPwihtIQw9HmX2x4CigmqfKl1S9L+pITyaHQ5CdmXFE+Q5uBLgB923
 lFE+h14m5syhuw3/P79sO78sj1APqFZtEp2t4iL+qm1KJEniJ7wypAKi4HDvDZKY0KWYvPAMzLo
 4KIwUR8wo6evU0gVddA1blWkIS9JA1iZQ9q7pk9gEppP9Ka93SaRO/x+mRjd6GWKE=
X-Google-Smtp-Source: AGHT+IHUwBvmSkAT+1bHYC8PR7TsHc5k0tL+n4z5uEi2/uGKw0CkNypzzmabQiNXd0IP7SqtGQV7DQ==
X-Received: by 2002:a05:690c:4903:b0:786:379a:51ec with SMTP id
 00721157ae682-78fb40490edmr223211617b3.46.1766961856027; 
 Sun, 28 Dec 2025 14:44:16 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb44f0670sm107973147b3.26.2025.12.28.14.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:44:15 -0800 (PST)
Message-ID: <03d03449-9bf8-48a6-9eb2-9446339a7349@linaro.org>
Date: Mon, 29 Dec 2025 09:44:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/tricore: Inline translator_lduw()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20251218213229.61854-1-philmd@linaro.org>
 <20251218213229.61854-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218213229.61854-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/19/25 08:32, Philippe Mathieu-Daudé wrote:
> translator_lduw() is defined in "exec/translator.h" as:
> 
>   192 static inline uint16_t
>   193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   194 {
>   195     return translator_lduw_end(env, db, pc, MO_TE);
>   196 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since we only build the TriCore target as little-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/translate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

