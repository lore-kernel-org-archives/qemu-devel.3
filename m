Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E09CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ICL-0001BN-QL; Fri, 10 Oct 2025 14:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ICJ-00019b-60
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:50:35 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ICE-00036i-Ug
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:50:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-279e2554c8fso23486075ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122228; x=1760727028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jD6FDbyFziq8qif7ZBySOkszr49hvhT/4c8Q4bH8sxs=;
 b=Jv3vRVuXY5DJhSmExLtO9PuD4rjgX1CEjvid5FqUCqrcE/Tvzugk25dFxYDOeaxRYa
 qlouaqEUAr6fSC4igITYDsamXjDUw1yQ3XJHT6iiHo/aGe9RBpJort4lqnIa81pLQcGE
 FrgDK+sjVKA8xC8w7x4ndsl6H5wYXK4C0vzHLf87JAMjgkTL+SI5W1fdKbX+OU9QueTU
 9EuyFq9IPxxqV9Wn2bXRmuEvlgC8QQwJDU2ezYbC2yAInEi9csLJHTQZsLpCYAz8XC6e
 Jbgtf7m0SR5wY3GVSuOhITW6sdDaIyJev5LOZDI3W75DL6/Zn4h9GYQZQ/dyJEDXmzWn
 pL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122228; x=1760727028;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jD6FDbyFziq8qif7ZBySOkszr49hvhT/4c8Q4bH8sxs=;
 b=A87tNV9sFzdJQuh+grwtw5TqVsCC77jdqLEVUHiWe4GdUibtCczhjx6wzcoQsYjg95
 ercSUBEowVQRTisMMlScouf9qksMyNnzusNhUu/IeU2ej7eWSUZW7xUmFNnblQ2Tc9XV
 yYIfOvCzARd1sYDA8hhyYo3xcdVqRNuHa5We9h+EVEWc0ntvcWNr7Ro1PGsv7umTxMT1
 +pZfBI/hb+woGZhEi1mC2NweGYgg4EHzXRGBV88fvFZIuPSOvnCUXGNnGwcABRt+GD/R
 7Nc0Ey35kHSEYC69cGNudnk6Tlg0LXLEq34KkMAIHOwbf/h/WzWJpajiQUVx+HahDuJA
 li1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzwDf/9S81X6DD9qSJK+tK5ILOir2EKW7nrckZ0ieCiqmELkb1bJVoJRZU4pi54Nc+wIfBu3V4xUNg@nongnu.org
X-Gm-Message-State: AOJu0YwBfrF17nuwKkRX34a5KnuwD2u4bRWxdaeshEZl0zt/Yx+LQUiV
 G/0vE2BRBqBfrQI0qE92qrtMcCkydhg02XLAvqqmKFshjrZqRZWjhSzP1Mx2zDJLs/A=
X-Gm-Gg: ASbGncuPhX4hWQOt22zgVfDLKv/bYpWMS8IltdV2/BoUTjqjoosJOoKMjrhnuWVGwkP
 YGaVeO9VAgYMocyOsB+e/4twHFcJYW9qbusJbgbEEZEyaAKl/9sjoiLxPAzseS2oZfC2CZqOsqv
 WSQdcIy3mC+l32Sanxx8ns8nRey2HdHt9dUptYw2+7I4tHGy+S5eKJ+9mIZ+u9qj+F+fwFGx6h1
 5RCP4kYhNIV+2E4x/Dl4Fh2le9ZyePUDSzQ888EpGLwml2jc5U0TupT6LHByQhieAi3AjlRrxdW
 sKP3oOkTFb6I0nNfOwrtdThMoRZ1XVWdcnw8g5sSO4qD54xdlHdXw7XAYfDqfdEQrsFYCIVl4dS
 5/fc652wFLWZP8DS4cT9B1NPrMNjJNeoMksfOnsr5zmxhCiIiXuU2lwJRHG0=
X-Google-Smtp-Source: AGHT+IH9Rxyg/ZdMH9yZCdjThGzML/xEOCmx9OLBvnqLhVZ22a3k45c0jjvDk/kHdMWhRMCo2we/WQ==
X-Received: by 2002:a17:903:3c27:b0:262:79a:93fb with SMTP id
 d9443c01a7336-290272c07b4mr151689305ad.32.1760122227870; 
 Fri, 10 Oct 2025 11:50:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e47341sm63633345ad.57.2025.10.10.11.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:50:27 -0700 (PDT)
Message-ID: <6d5ffc4e-bea2-46ce-a209-c8e8748313d1@linaro.org>
Date: Fri, 10 Oct 2025 11:50:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/riscv: Conceal MO_TE within gen_cmpxchg*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 10/10/25 08:50, Philippe Mathieu-Daudé wrote:
> All callers of gen_cmpxchg() / gen_cmpxchg64() set the MO_TE flag.
> Set it once in the callees.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/translate.c                    | 1 +
>   target/riscv/insn_trans/trans_rvzabha.c.inc | 2 +-
>   target/riscv/insn_trans/trans_rvzacas.c.inc | 7 ++++---
>   3 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

