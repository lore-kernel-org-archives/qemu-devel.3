Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED33D185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnlw-0004qV-Nr; Thu, 08 Jan 2026 06:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnlu-0004iw-PM
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:01:42 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnlt-0000G4-8P
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:01:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so21251445e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870099; x=1768474899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DT0+/a6z49tx3THtxzjG8Dll9DMWoGTJBqU2T35+7bY=;
 b=mg4VI50c+bVgtpAOALp2vqmCDQstvbe6lu7feadyyAlLP9cNTQwQrcprFu7unf8rF8
 g9C0Zjz42Our5KmVRxn3XJYt1GXq1QfdmMtyDctQVmtKiucJCKHPaxKmo3qfn4pgm9KT
 TF4vAi1qMKzgpmTnORLCF9H2JO2saVXK72ddVsq4vpTAj/1W/gWKHpxedXmtyqUbij4y
 zdiSoGc3TSPYl5wNZiWJJZjG5ThHvy795bcsFwgiqJZjJt72e0rqd9MZrhkteLjbSWTo
 mlGxp+bYeIjHLnj8bD/ZZQ+t/VBdZ75KtTCmVfxP4v3ZBz9wVgl1OaYMbxlxmqrsgBdS
 +0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870099; x=1768474899;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DT0+/a6z49tx3THtxzjG8Dll9DMWoGTJBqU2T35+7bY=;
 b=inKCS5ZYXHRbREOUqW54Cb2p8dPu/RVHGvUW0ArGpEWunlX6qVk4MWR/ntg8s7ORuO
 71HAHvP/hTK8KIEHs3R5d8x6iDAhsDZb2vJj62pczMfyyY2TNbzM94um5MaBgvlpRiaz
 5h4c1+sUnbk4Jvave/4HsRFg0pnpqhtCjFJBf+lNjic+Gvs+4KCLUGHlZw0Yaw14LMsR
 a2HmHFetCtCDQghRpCtshTT5xbiwuDTue2oLqe2mIWXsuOy0yW7CQJhYuEo+gVda5Qbk
 BAXUYstVTcfc0XY0y70AXxOD5CGO12zgLJsQ3UjHA2SU6aasndZ6SdlJze1RZICCeWoE
 o0FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZElaXMEi8/J1m8a15CqKOrhTHv9pfdB/aVCHURJkdF9h8hLp2eeNrWenqbYse569yY0PwEEQOCzb6@nongnu.org
X-Gm-Message-State: AOJu0Yx0mKgIgryA+/4MPwh1sB0h2Llw8dheGZO+f90eq8CK9VNOVb7V
 D0asORVdQOFWFexNJUtXvp29o5LG25pCJMSkNi9thBQj9lJLGnTa1WMdb4YY6ztdFDo=
X-Gm-Gg: AY/fxX5Nzma8KVufzh/PI4KGtkS3TmhsnT1nx/+/46FG2b14eLw1Y2F8j5RzTOMTPFO
 2M/0eQwIxlv7N91JlbD7YbabAvHEHdE1Rgw30NGDbTqsTwPIasQp2XEcQqKTG70etgYx82zq4NA
 dpQBHLJn/JydSZBbhn27EkDU4YlQ+n2NKIS9wvPCNsdU3Qq4McuUvNzJcv4SEcC7aUVjBNqvgFL
 JX5tQu4prhKiB1uOZwtNSs8wrLeunylT2kTYl3EMq7vsobMxNhOaFpdJ9xMAZOx/CIOO1DyOwTk
 12yKVJ7BxAUcr3TNnZNkqN19rMjCe3VBiayt6byl48G2WpaKOjqTS8MM+MCXLxsWaV1ahzvql4c
 rK0e3szihvMRkV3BurFDRgpYpsb9BE5Qwb1OjHn9UHLwICNQheiALT/uDkC9mK7xlk1DBcNVCk5
 slC9+JD8AsXbLWcAD6cpW/y+yUmunr3fJca8k/KiBXBExraC8ZkI4SZQ==
X-Google-Smtp-Source: AGHT+IFJi+SW4qjYJd4rSpgmVLhKMFTK35r53B2pMDYHC2E3wcyORJRlJDh34P1ZuKqeM77GAPyZLg==
X-Received: by 2002:a05:600c:8b52:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-47d84b1a348mr61525705e9.6.1767870098532; 
 Thu, 08 Jan 2026 03:01:38 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8718b995sm33364425e9.14.2026.01.08.03.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:01:38 -0800 (PST)
Message-ID: <fe97be98-772f-4451-8c04-a79edc36a367@linaro.org>
Date: Thu, 8 Jan 2026 12:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/50] tcg: Make TCG_TARGET_REG_BITS common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 8/1/26 06:29, Richard Henderson wrote:
> Since we only support 64-bit hosts, there's no real need
> to parameterize TCG_TARGET_REG_BITS.  It seems worth holding
> on to the identifier though, for documentation purposes.
> 
> Move one tcg/*/tcg-target-reg-bits.h to tcg/target-reg-bits.h
> and remove the others.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/helper-info.h                     |  2 +-
>   .../tcg/target-reg-bits.h                     |  8 +++----
>   include/tcg/tcg.h                             |  2 +-
>   tcg/aarch64/tcg-target-reg-bits.h             | 12 -----------
>   tcg/loongarch64/tcg-target-reg-bits.h         | 21 -------------------
>   tcg/mips64/tcg-target-reg-bits.h              | 16 --------------
>   tcg/riscv64/tcg-target-reg-bits.h             | 19 -----------------
>   tcg/s390x/tcg-target-reg-bits.h               | 17 ---------------
>   tcg/sparc64/tcg-target-reg-bits.h             | 12 -----------
>   tcg/tci/tcg-target-reg-bits.h                 | 18 ----------------
>   tcg/x86_64/tcg-target-reg-bits.h              | 16 --------------
>   11 files changed, 6 insertions(+), 137 deletions(-)
>   rename tcg/ppc64/tcg-target-reg-bits.h => include/tcg/target-reg-bits.h (71%)
>   delete mode 100644 tcg/aarch64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/mips64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/riscv64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/s390x/tcg-target-reg-bits.h
>   delete mode 100644 tcg/sparc64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/tci/tcg-target-reg-bits.h
>   delete mode 100644 tcg/x86_64/tcg-target-reg-bits.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


