Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1521C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 02:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcaQQ-0007O4-1K; Sun, 04 Jan 2026 21:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaQN-0007NS-SZ
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:34:27 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaQM-0005ym-G0
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:34:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso10163995b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 18:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767580465; x=1768185265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XJ49/pdj3sfr6hRpfnPSoK/BPc7tnomht/GqYTjk7EQ=;
 b=Qmg2ojVNEfrRF+j0SWB766/ipfSM61mnqoIBQZU7r+to8S036o1i0BHuexgFN/7RHN
 3Sxh/itNIsbjcIWcV19lnChfE1Tf+QUTLhg4HDB5RbSwhFKSPHD+HmH/9D1hdCimQlbP
 LJhG8Q3UilGxeQcA3p3/NV1BmfDdH1exJpMsnxGZmf/LGkXP75wkyokM23mpk0Ygeems
 cGqKoC5m7hV0uyPMxv1ZVg7YN5EQuY+6RMiJLe8P4NWmE0H+ifwFxd/CKxmwECAN9c3c
 lPe6Ev3IsPUp8Y9AO7Zt5Ex5OCKBh8aRcxZ+3shnAPhQ4cXC7NVYfq+kinbirzdBbRfG
 QAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767580465; x=1768185265;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XJ49/pdj3sfr6hRpfnPSoK/BPc7tnomht/GqYTjk7EQ=;
 b=KTUK8j/E8c9tYCM33pJ9q4mvF2S+LGGO/9oM7CAtiz7Jy1l62Md66Z+7Gktpj4BChv
 qY6cC1Tjxp0lJS316XjXv8u6NiUOzHfzjkez2rW7nVKSesz4aUPhJg9cG7Evp019qUiB
 hudKbrInn450VsUMDsmSWUny5MKpWtWocRsO2Mdbs8IG1zwnRIdeA4YrOhHGjGGTBFTA
 49O7jc/GFFu4zvgV2iBNv45et7VKog05ywAnDm5Y11L9XFHZRtSU9ATnLftqLWzfJpFi
 joVPOWIIRINWetz6CAQrGTMpQA8+aMLbfPx6RemuYIbqpsSKF8v2ACcKbSoUP0DfJKs6
 W/HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJNF1wK4Ys7LNJLrgOCqho/OXrf7o/ATZoRX33tDtM9zm+frj+ojY3oeMyxfRPVMIB9OI01Rwu8yF4@nongnu.org
X-Gm-Message-State: AOJu0YyyGEF0VmSnfmIJcNHczESVl2JWM7aSivJC46L3LZWTyIA0Eyzh
 l7IuAMMywFvGVt7Yya91xis/FWCCA8BmMv0H2c+f+wlTY74edaakugdKZvsIYuyXZ+s=
X-Gm-Gg: AY/fxX6j+rJf6k0tqmgeQ2dL2bQ04jSL+1S7hZNRHdJsfBAW+Kxr0pVYFc1Euj8zDZ2
 NnipEeTqrj/ux/M3chIJjMYmcSqfGO3EI6+nq6SMFeNQBjaPVuzFwOmACDKztSwoXIKTq0JakWG
 oKnCZwAGI1/N0aSkF+wX5m9d0bZ4HyEbaZALoKdF0GgMIkStvd6yOXGWwm1U20twFW5xkUxdpA5
 J7GQ6n14kYMmGkBNC3P8tfAaRiCyzh57P+BfAW/x55eTrfv4J5WYPwnMgVAUjSjzs2ZBZ7d6I6l
 4iBhpEHcGb1HivaU9dCZdu2ZRVROkCnoqwzoG4YxHFjWqiu2VbaGWMAvCDuuX7PE79YIIkHHI7r
 Yt3tlyC6W+0MZgwr7LXE+2cw2/5RaHhzIqiZZa2792TfsmtZpKeeG313r9w8H4/LsoB0cRoxa61
 Y8epW6SVjI9o+70mzfsJbPDaErYO8VCA==
X-Google-Smtp-Source: AGHT+IHG4SUraYtheI/ZNgAxHopmmt6mKj6cK+yrr5AMPhnWUIhrYBEGQjYwaogeNFXXY5lfzl6QBw==
X-Received: by 2002:a05:6a00:328a:b0:7a9:d1ca:8a44 with SMTP id
 d2e1a72fcca58-7ff655aeb1emr39599572b3a.24.1767580464917; 
 Sun, 04 Jan 2026 18:34:24 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7b31c479sm46234671b3a.24.2026.01.04.18.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 18:34:24 -0800 (PST)
Message-ID: <b3ceb526-9bef-4048-8c1e-ae38e61daad6@linaro.org>
Date: Mon, 5 Jan 2026 13:34:17 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/hppa: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller
 <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20251229225517.45078-1-philmd@linaro.org>
 <20251229225517.45078-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251229225517.45078-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 12/30/25 09:55, Philippe Mathieu-Daudé wrote:
> The HPPA architecture uses big endianness. Directly use
> the big-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=be; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hppa/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/gdbstub.c    | 2 +-
>   target/hppa/int_helper.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

