Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24ADC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1ED-0002t9-MW; Mon, 03 Feb 2025 13:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1EC-0002qT-2i
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:31:24 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1EA-0003DK-8x
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:31:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so4275203f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738607480; x=1739212280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+9vA3Gc2foqzELEFiK67kFjWezmJSC7mFkQ3zK2fzI=;
 b=EBVIOqnqjm4OTVqNOZ0UN+ogOHbz6eb5JyVbq+7sN+AMRLilZFPsiWmpQloq4UXKZl
 dkS0EjeenM87a5T3fn6lijauXqrjaKdOiXXAOVIing+drtYtXDmHWO2AGyiDIW6jJEwk
 YAgbhpdwlmvPgM/Pc9pHyl6O4xlOI01OvJu91SJw/teWPJGqKypp9ey5DNDrGdapO89n
 2nTsXTkLsZlRr9nibMbFnzvLhS7KJxpNkQ4+Hg+GxwSJafrK/mbuRfQxx3QUTzbq3DCh
 a8YA+7Un8wW5G/1pdUmGuMnP7E5zSaILFAJyW6LZXYH+CYb3QA/4mVIXJYhwkufXAaS0
 /nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738607480; x=1739212280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B+9vA3Gc2foqzELEFiK67kFjWezmJSC7mFkQ3zK2fzI=;
 b=VtCN9wQxE4apAjRjB2vPnEhghx4fZD1gk4SAHWsxLltdqlt00RafBlEZBCmG7S7dXU
 IuBt4OnloeZv42CnnGT1fi67M+rbNrjemgCoQqNiSd+MQv35NE0/eI9+o9cBR0yhK0Lu
 RM0Gevqs9bQNG7U8SqTTsTOu7HWdEzOg+Te30WBVAMqUX0SKYPCDehgnnD+CuMrAli31
 nOQviziiK/0LH5NS2h/XJou4pM1yeV2uE2/0a4xwyj1c75148nefYmvuD5wTZfRzRMLU
 9T/ZoFdJdPHAvmoo8nDG+FeGdqzf+sXgU/KBzQ38DiBmlW1cuPQ6tjnmh7ZfIVlcAUYf
 5Raw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUKeqe9ogNGxsO/Ysn+eLGzYz9v2LLAGXo+lxljIP7lXgStEJv5H3am+T7sgKj5qXP+gdI+FkU25JC@nongnu.org
X-Gm-Message-State: AOJu0Ywldy6/TS+HUfO8xMoJo5ROSws8P77km+ukAzdvWXcxXwnYiW1n
 dkTuGbcRXhWD5y6HPhCGujuvjhAjW4ir0d99QXPzsplQkkf7VuLf7Y2Q0O9vP1s=
X-Gm-Gg: ASbGncs5TO5tlowpbZ2HuIwoYidLGn0TzckWw98VZ9cWU7zVwU0ByxkEZGXvWF67Zl+
 iTPaXFxzRRWRfSoi5s57ZZUJgQ/g1xEi8447Ga1WQt9xIQimIa9otVmP3BfzHwAdVElm/9KQVVZ
 56vpYlAT41AHDUG79JcD8GF4w1UVIgYJeNG21tviSLb/hNGh9/CPRdSLBNmwNrzpTnnlG/04i1V
 QAlve/YmEp7/lggOysYgp6xOvtskO1ixXMsFA0OsjtX638LpLRU69+TgVGPGoZO5cBTERy+1VNO
 Lh6Np7o2/EqyHbgWUA6QXg3oEaHzSIEpKPZZQoPCuYwliyG1L/Knk1NKKgo=
X-Google-Smtp-Source: AGHT+IFtT2y/mlv7b9i/yjhn0WY8ZRgob2XWw56IK3thHxjVYW9+lC4uPq4MbazLT4b8vsk1v/nBIQ==
X-Received: by 2002:a5d:648f:0:b0:38c:4a5f:bf70 with SMTP id
 ffacd0b85a97d-38c520b1055mr17544905f8f.55.1738607480371; 
 Mon, 03 Feb 2025 10:31:20 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ebfdasm13666200f8f.17.2025.02.03.10.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:31:19 -0800 (PST)
Message-ID: <357240ea-9938-471b-8f24-6603dc945e6e@linaro.org>
Date: Mon, 3 Feb 2025 19:31:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] target/*: Remove TARGET_LONG_BITS from
 cpu-param.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203031821.741477-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 3/2/25 04:18, Richard Henderson wrote:
> This is now handled by the configs/targets/*.mak fragment.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/cpu-param.h      | 2 --
>   target/arm/cpu-param.h        | 2 --
>   target/avr/cpu-param.h        | 1 -
>   target/hexagon/cpu-param.h    | 1 -
>   target/hppa/cpu-param.h       | 2 --
>   target/i386/cpu-param.h       | 2 --
>   target/loongarch/cpu-param.h  | 1 -
>   target/m68k/cpu-param.h       | 1 -
>   target/microblaze/cpu-param.h | 2 --
>   target/mips/cpu-param.h       | 5 -----
>   target/openrisc/cpu-param.h   | 1 -
>   target/ppc/cpu-param.h        | 2 --
>   target/riscv/cpu-param.h      | 2 --
>   target/rx/cpu-param.h         | 1 -
>   target/s390x/cpu-param.h      | 1 -
>   target/sh4/cpu-param.h        | 1 -
>   target/sparc/cpu-param.h      | 2 --
>   target/tricore/cpu-param.h    | 1 -
>   target/xtensa/cpu-param.h     | 1 -
>   19 files changed, 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


