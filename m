Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F970C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WGg-0003uP-6b; Mon, 28 Apr 2025 17:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WGe-0003u7-Gs
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:44:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WGc-00054r-Ed
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:44:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2295d78b433so57357475ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876636; x=1746481436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VyVhiMX5Lh43UdbKXQvjgb/waxkmkNyHGCXUfoRtI2g=;
 b=cvxgvA/kJyDkUL+euIb6LZDeVwiiOR6bb9qmo4+Bd5vIFtS6lVwk4bVBEz+7GECmzd
 hxxNczTeiQdqojT66oQD/FJGCUCPJpE6Ih1dPFVK2wl2i/MnApBJGpDLK7i3SmGQ1H52
 MSdjTfk2uXMAc9LQyrvjBxWZQX7yLPd+EdNEHmU2VAGKBcga7xVXlyPBel9A+8Qdm0aI
 L9EaCz25bcXlANbmiHNqEw5kpKHrOinAv27gIyRvfNoPdSzmE+ziLGqU/hJSe77Re/x0
 ygWWPF6pwdRk/ijXwt1LztjwK6JhZZCBLbz0WoeOed0JwfY2b5I/EcWLwt4Yh3UPre7q
 /d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876636; x=1746481436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VyVhiMX5Lh43UdbKXQvjgb/waxkmkNyHGCXUfoRtI2g=;
 b=CP5eYaiRFpLMNUmmmOHOSf1BqFYZ5Cixp+Bb4Uvyz/22CU8Gi27bxyQTtWnryxjYTh
 A+jfeVYCirzAm2J/xDtR/UXYVNT0/n5/j4LK0yD1hPcHn/EKIFl9zhcI+9Jh6wig/Zpz
 FiThNMwFQSit0pKEvqv0bZuloaZt4uNg9qwZgHzAczYDqY0YIGVj1jBi2txq5zuHVg1O
 t1W4T1kPTcuDjZj2WK7g5fy8vKw9WzGg2j9hNWYVxhYj94xbC4JopopBjH5rifAkEIYw
 xidBOCElWuD4Ypxhd4KsB0ZDq/EVeaOH8/Am+852/VqF/V8kwizCCVTVCrOaeB/hJ7VG
 jBmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrO1SLvbJr9slABh4Cjq3D32LCS7FTTC/2/toPGp7WWOiascqT4kO/ZNyFtLtgAa7autvmrXyzLHHp@nongnu.org
X-Gm-Message-State: AOJu0YwoxE+DSZE0RasH5k8Ze8EsdcVaOyuMXz3agPNyIrqLhh4sKBD6
 Nnh8ok+dza7r/qBPwubCo4fq9+1kuUppf0+HmaPlUCogrPZbOBgwMaf5OtBfUP0=
X-Gm-Gg: ASbGncu6N7ukIGMWtLZSIj5iEIJLMUPFXBhKF+gStkdPXKRksr2Cl7IOAXeTN9GqlHQ
 ccBn6BaJySQuJ9DPfcaUXsAxe3y9gw5QUyNM3A4f9Vbxfktul6BKvVbldyCe4LB5iUevaRqBS+s
 ecOp2XqxibDVF32UtEf6MLxSZ35c8kZ0uH2UoS8tQmqkPxJ/YQVlxeSb1hm/epGdwrJPLvufWIN
 74sAfYy2Xa5RHkv/zMfsQRZQ8vJbtqS0WZgfWnxGxLNseLOoWhe1l0sjwYWM8ONUeOQp5gW5PcD
 AbIUpYiP9ZlllyYUYO6s2YvDTrd5th1Rvzbq4M2wbWn1PSEg2GMlWA==
X-Google-Smtp-Source: AGHT+IEiO3uEZkKJlRhPFyTOKLUUzgbDAL6ZfQpzRO+eh1PlsEQQvD1Y7qIHBBnccreKcaSdVaAgCA==
X-Received: by 2002:a17:902:ecc9:b0:225:ac99:ae0d with SMTP id
 d9443c01a7336-22dc69efa78mr155530975ad.10.1745876636562; 
 Mon, 28 Apr 2025 14:43:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7bd0sm88369755ad.127.2025.04.28.14.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:43:56 -0700 (PDT)
Message-ID: <04224f26-6a91-483d-9b28-ab1b0bc60dd1@linaro.org>
Date: Mon, 28 Apr 2025 14:43:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] accel/tcg: Hoist cpu_get_tb_cpu_state decl to
 accl/tcg/cpu-ops.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> For some targets, simply remove the local definition.
> For other targets, move the inline definition out of line.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  3 ++
>   target/alpha/cpu.h          | 11 ------
>   target/arm/cpu.h            |  3 --
>   target/avr/cpu.h            | 18 ----------
>   target/hexagon/cpu.h        | 15 --------
>   target/hppa/cpu.h           |  3 --
>   target/i386/cpu.h           | 14 --------
>   target/loongarch/cpu.h      | 12 -------
>   target/m68k/cpu.h           | 16 ---------
>   target/microblaze/cpu.h     |  8 -----
>   target/mips/cpu.h           |  9 -----
>   target/openrisc/cpu.h       | 10 ------
>   target/ppc/cpu.h            | 13 -------
>   target/riscv/cpu.h          |  3 --
>   target/rx/cpu.h             |  9 -----
>   target/s390x/cpu.h          |  9 -----
>   target/sh4/cpu.h            | 15 --------
>   target/sparc/cpu.h          |  3 --
>   target/tricore/cpu.h        | 12 -------
>   target/xtensa/cpu.h         | 68 -----------------------------------
>   target/alpha/cpu.c          | 14 ++++++--
>   target/arm/helper.c         |  1 +
>   target/avr/cpu.c            | 21 +++++++++--
>   target/hexagon/cpu.c        | 18 ++++++++--
>   target/hppa/cpu.c           |  3 +-
>   target/i386/tcg/tcg-cpu.c   | 17 +++++++--
>   target/loongarch/cpu.c      | 15 ++++++--
>   target/m68k/cpu.c           | 19 ++++++++--
>   target/microblaze/cpu.c     | 11 ++++--
>   target/mips/cpu.c           |  9 +++++
>   target/openrisc/cpu.c       | 13 +++++--
>   target/ppc/helper_regs.c    | 16 ++++-----
>   target/rx/cpu.c             | 12 +++++--
>   target/s390x/cpu.c          |  1 +
>   target/sh4/cpu.c            | 18 ++++++++--
>   target/tricore/cpu.c        | 15 ++++++--
>   target/xtensa/cpu.c         | 71 +++++++++++++++++++++++++++++++++++--
>   37 files changed, 243 insertions(+), 285 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


