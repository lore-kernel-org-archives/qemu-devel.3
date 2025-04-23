Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5C8C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XMD-00063t-AO; Wed, 23 Apr 2025 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XMC-00063M-2v
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:29:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XM8-00058x-TE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:29:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so34859795e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745404167; x=1746008967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIShbPLKG2KH3yHaCm1OWvCI9B08GHEGFkg8ARjb2sc=;
 b=huVpqwnsUQiFT+27hfVSCcIRIQb5T0vNYUdacqIHmQQJu+QiMwFzTal9CA5CGs2EFw
 HipfzXIyCodn893mR32ktbnTP30o7vcWLWrkp2a83Pj4MOY9U6slBmL2AiLwkP9tXZNo
 yr0lWVaysiXjCjRJM+X1eJ7DweuaCSZW+WFj1PsEU5wqjeyTN0iYjSxh+osX+5XuIV68
 q91H6T+JX2PvhEv++CAW8VOw+k3cVaJuE96J0BoT/Opf0wRt/JZh/KXgz68yLV6yN51f
 C3auBgxwp8wUlbS7ibfr+HQYZo324KoR28noBRUrwNUY2KAP4nIMP2csBWdAn02lYtb/
 +v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745404167; x=1746008967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LIShbPLKG2KH3yHaCm1OWvCI9B08GHEGFkg8ARjb2sc=;
 b=Ldx7bTZ05CnAWeL12/GuLxi7XFdkA5XkV3LqV3Pex44w8E9dMHSMAK+FlTMImsOMR/
 wtsz5rPAjAMDHNvyG5SsspPLbUykHdS7V/A05mMoygd+DDmKz7AQXQg+zz+IVazMRJ/M
 ejSirwxxsMQe8+UB0jWx4q/KX4/uXryItR+wXf2ND1gZPUMCMIaAB2879VVq8mXmnOQr
 LQuoNsS7hytXCr7eggBOe2XiKB5TCJXZ/V/MesjP5blEhRstzf10CAIPlhmnuL5JnIt9
 Zs3DZsJRf2dMXidyeoR/2uU9UGEIGqRFu2sCKu1Jy9n7U7eo0yaeHr44UnPnne1xwaL9
 chkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjunYHIgRoN6xdCrx9SJZZH5ghvA0OuMuT4zs8IUBJuoBDcBsRIIrxjGyLS2MmTxY7xM/wSxg/StTf@nongnu.org
X-Gm-Message-State: AOJu0YzV9OTWwJLXbd04n4HIEVrslUKNCl1iGhzl+cE67YqSxub4+/50
 AIObpzaOetR+w/WlzkEoCBU78yout6vYFIFwWDvSHgi414MXSNjZzqA3hVibfdu8MA9YIIlQiFm
 n
X-Gm-Gg: ASbGncsHxIcPwAvGf/EHpQUUcqnc01s8IKFA7aROP8Mq5/e5zQCv+/TKCfEH6vEN9cv
 M4YzAi1iwwy1EgT4cEaQok5IctJhBU9e5wnd230MCmTks9lLwlZlDwAjuJUKL/0pJodoQVYqhqj
 4Mu8rvQ2LN6lu8/4V0DmiAWBwdk8iZk6ITTtSscSA3aEp3ypFVY/3NOYvg0VJlF3y4FbR3ekWQE
 /BA7dS6hhIJotBLi9lPcmTx/RgFvYa+r4sfOYj+NQ4bzIrAGo0f+OeMMV5O7BTVCdfF/Gi53lmg
 rt/tPpH8B/pvWn2RX6rjINEga9K53dX92O5V+qYVwKh2mVQoEk1g34PRjQMLbcgt+Abvp9/cF4G
 FNlqQgyE6
X-Google-Smtp-Source: AGHT+IGE7A8s99yH9iE3glNThdxI7556tvTgsrWSNU8Zb2eMrDj8s8fJVp8rLjNXjk6dl6LajdC0Lw==
X-Received: by 2002:a05:600c:54ed:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-4406def1692mr125451315e9.11.1745404166704; 
 Wed, 23 Apr 2025 03:29:26 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d38118sm20570805e9.31.2025.04.23.03.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:29:26 -0700 (PDT)
Message-ID: <47a769d3-7686-40a8-9a7b-a01dcb0d9351@linaro.org>
Date: Wed, 23 Apr 2025 12:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 111/147] exec/cpu-all: transfer exec/cpu-common include to
 cpu.h headers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-112-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-112-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-15-pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h  | 1 -
>   include/exec/cpu_ldst.h | 1 +
>   target/alpha/cpu.h      | 1 +
>   target/arm/cpu.h        | 1 +
>   target/avr/cpu.h        | 1 +
>   target/hexagon/cpu.h    | 1 +
>   target/hppa/cpu.h       | 1 +
>   target/i386/cpu.h       | 1 +
>   target/loongarch/cpu.h  | 1 +
>   target/m68k/cpu.h       | 1 +
>   target/microblaze/cpu.h | 1 +
>   target/mips/cpu.h       | 1 +
>   target/openrisc/cpu.h   | 1 +
>   target/ppc/cpu.h        | 1 +
>   target/riscv/cpu.h      | 1 +
>   target/rx/cpu.h         | 1 +
>   target/s390x/cpu.h      | 1 +
>   target/sh4/cpu.h        | 1 +
>   target/sparc/cpu.h      | 1 +
>   target/tricore/cpu.h    | 1 +
>   target/xtensa/cpu.h     | 1 +
>   cpu-target.c            | 1 +
>   22 files changed, 21 insertions(+), 1 deletion(-)

Good.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


