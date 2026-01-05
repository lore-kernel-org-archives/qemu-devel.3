Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC43C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYSZ-0004oU-Ki; Sun, 04 Jan 2026 19:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYSY-0004o2-4q
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:28:34 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYSW-00009V-IR
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:28:33 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b9215e55e6so8218811b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767572911; x=1768177711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5d8mDRCUPZMOX4pneV54RBN8eRFWAyOjJKjW9u9wgfs=;
 b=HbioiJFpRDZrQpR1YdoZ90yk8l1HUAWGnBM7w9n0cwCsuhyjetgGGcxFb8szSoJG1S
 T3fjEx3f4nMrg/dlVWaOLFxnxr7agZvNv/+TuV2fMtRbtWEu5fsogCjfqT4Wd/HNxoki
 iezqnMbaapJIytZzY1woF6i/vUmMOfwqm62ZrXm1QrSihYnTMlOaoe1U++zrEGp2U5xK
 xTyfw1hiO7QGLzacfJFRQOh0xEXDP4AK3/hCfm5J840vCurhsTTSQAfaY5f6M6IEZP4w
 NGvut1CEdUMsBGExbfIlqdkpEsBZUAoQeJBRuL3tZQSz8c5RsbBBW3dy7BT1xP1Hl4zd
 KqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767572911; x=1768177711;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5d8mDRCUPZMOX4pneV54RBN8eRFWAyOjJKjW9u9wgfs=;
 b=WA0Tc6HPeEwn4JFRhfGW2CkjgaR1S2JbPt8Eko5SEvLcAmTNDAZM4MPXTeFcVwruoE
 WlyDNw6AYxLgEOYZi/mYYdDwKdxCz33G46Bn4MZBim0jjhgWZg06utsmOLaOIvuAYDBc
 NYMbPpLrxeTJycwmQ2Px+v2RRHK5qdQ95hWLFCEAMw7q09WxRNYaYCL77KriL0LMNd9H
 p/X8qWT9i7TQ1PDNkVo7A2NR3Ka22Z0oQVuV44hpTwM3M9FGw9x94ua5lgMICjPIOERo
 D2+CQb1+rMBDonh0yEzKdPwT6CFuV41y2KYCMjEcNWXkdtyxLYQOmRc8vqZ/ZWBJYsqX
 Tcqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqihS2WTtPxiq+dJudOIitVZp1k8lBz7DjdFU73QBWOo/ruRXVjYsmvouGycNgGKFrFflGiHeQIw7O@nongnu.org
X-Gm-Message-State: AOJu0YxbWXMhCknw/WFYFoJZJSpPjqctPMIsWJRWXzSondFpYmGeKJGQ
 hXBipHBfWbPU2kNUDlfChIBLmO5+r4KefZoD+Z2gy8kkKVGLNCKHXySXmxk2/xCtd5g=
X-Gm-Gg: AY/fxX78ln2wlVt8K/M1CZiPfbN55wfBOrTjt8uBDGUJdxLHsvc+2ipg0kMCUuqpBgz
 Vn0jB9HF1tNT6v4zRcifSkafWxbpZ4M2BHIBihx+nu3tCX9rlAKqiGiZtOnUxlcXy9x+4LTHNuf
 KJkiVdvHlgZuQqAx97izSB9yUK2rTJXCZBfiRHfyY7bhiwkHnjzbLUu1a30GBrtErW/JMpKt6rp
 0issP6DRDNn56xcl/PWHnp60//j63tFWyPkGtytzEbITLKA5M8mAAGUxQFmS01JLcLdaTErhO6S
 lNCJgmg/YrYtGNFzzAg0YqIuM71Dh2UUbioItRpurAYaCwH8s+KV0RfDr9FSgwDybZKAYkfy3tV
 xYzAKu+h8sUZ/7Lt5xAUdaB9Q5VtI6MVHGGWfMQoH940VVDseRu1IU9J8cyYnRI0=
X-Google-Smtp-Source: AGHT+IG/QEXcWYM779PUrFeUlcpocLiDWvbZjwRIoDucYcHmqh8G9yyzsYHrCcryXmZcwVhEDbV9Vg==
X-Received: by 2002:a05:6a20:7489:b0:340:aead:3c with SMTP id
 adf61e73a8af0-376a96b943fmr45899998637.37.1767572908930; 
 Sun, 04 Jan 2026 16:28:28 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f47709616sm4399047a91.11.2026.01.04.16.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:28:27 -0800 (PST)
Message-ID: <789b00e0-d1c5-45d7-85ff-ae2e76d95bdd@linaro.org>
Date: Mon, 5 Jan 2026 11:28:20 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] target/sparc: Use explicit big-endian LD/ST API
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
 <20251224162642.90857-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
> The SPARC architecture uses big endianness. Directly use
> the big-endian LD/ST API.
> 
> Mechanical change running:
> 
>    $ for a in uw w l q; do \
>        sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>          $(git grep -wlE '(ld|st)u?[wlq]_p' target/sparc/);
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/ldst_helper.c | 36 ++++++++++++++++++------------------
>   target/sparc/mmu_helper.c  | 32 +++++++++++++++++---------------
>   2 files changed, 35 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

