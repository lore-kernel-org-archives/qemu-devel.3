Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FD0CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1Uq-0005tS-Vy; Wed, 29 Oct 2025 04:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1Um-0005sz-S4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:25:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1Ui-0006oM-07
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:25:27 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63c3c7d3d53so10832438a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761726320; x=1762331120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8RpHZceh3oEgvJpGAbrYKBgwZB/moGhMTqC+WWa6nKU=;
 b=q3LnSon6YjgjDSmtHLuYoW+q/c4hqHKM9xPXjU0i2EYwFF11Op3S9UUIqZMpNaTN4R
 BTGPIh96vOenBfgQjl2wR2Ttiwb5PPav1av4Xl6yLDZsyuZevJxLHNjeMClDQQZ+OTij
 C2a7KhVfdZvHxjfHDsy/j/Isw51EMk5xXQT48ooCddea4mNsGWrSaoABVPTF3tXo9v0v
 vhApZO1A74QUS4hQajvxT8eDzy9uny+XIcp45gvyOBDkefgnAhUSnoDFkT/hkMxOvwm2
 HMLo8B/KIck/aMa1wJJi/CeDRYxCLzt/MT2M09etWFaqv0fa+zKY3AijNXVcGgVgHVQ+
 sxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761726320; x=1762331120;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8RpHZceh3oEgvJpGAbrYKBgwZB/moGhMTqC+WWa6nKU=;
 b=LqIxsb8ok/oAr3QRWzVLpplPunYS24qJx8FOQ0viK4yUfPNRnUF2M0GlX+kMsdcxj7
 SVAjSK+vFeWgbh2qMBL4UHBtal30e7ORDqpKjuf3+tZNcAeVVt8Ebs7l2cFoNhlGKgBM
 sJnpaIFEL8AdcVvwXcd/GelJvNoCz88UzbMDH11+rfn/kx1wRQv8C/GjDR9wENBVSQTm
 5Hu6Ay8CFUIbpEq9rwVil6gaX7jEM1Ase6Q/uK/MasnDvDfXr78oUf6gLhXpWEZpq58h
 R8NcPo0uu5L3t3Lx2osc2RA/dfVzltN/91mhkPVgGKeG7pIaD1BAHmC3GdKI+bcMuv8v
 YAKA==
X-Gm-Message-State: AOJu0YzPkev74LG8zD/N0bdemyGKcCVKd0G5zzRWnM2t907cX3zDaX01
 /DqTQ5dV4UDBBWjdsgif99NpyLM8MXJ2xLS3x8Q3YN/UZIDc3F99tOivKPrB2cRtl0t2FZXHJyd
 UvhpBBeE=
X-Gm-Gg: ASbGnctTQZJ7a2JJM7MyCeOuCYsU/tkuKPvd+iXXULemQxDq55VLTBEM5pbqJudWot7
 XvGseA/N5kA/hSfaaOxbmTDj/MSqjjIDN0co3iPOuvvIdwALTPj6FtlesB0xV121kFO9hRJtefS
 EoKt9DRNdxrORBCE60UwudwCxnbrMfMeFMILxxZjVi29kjUfOoYQsyijK4ROffuVeMUQLcwgYjJ
 SMKqhZkYtLJbK2ZQHqfSlrcfaYwY9JJ+2S8sEL0F52nkiET//qLb9QuiltQ9oV/PnRZSNNaMkTi
 tbfODdE6vqNE6Cv2EGdysZOqIX9PVQl30rExdUgmdEpv2AmE6618F+8YYB+b2ryVrwRqtmmuz8E
 79ssuB7Jd7bGEqtRHFZZu9YH89zK7rPvloHZgT81DM79ocCLuI2lp/4WtCfMIIs+Rk3rNEDSn9Y
 BriYkpWu/CXEtuo/RE9H50cS9WGDE=
X-Google-Smtp-Source: AGHT+IG9DyJnt4IW5ycAT//z8Ah0JsUHEbHkwmu6OYeLkTjHBmLUruK1zpf23nnXpoVBEOVK2SaP/A==
X-Received: by 2002:a05:6402:26d4:b0:63c:8eb8:9cd with SMTP id
 4fb4d7f45d1cf-640441abea6mr1525261a12.16.1761726320111; 
 Wed, 29 Oct 2025 01:25:20 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e86c6d7d3sm11189055a12.27.2025.10.29.01.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:25:18 -0700 (PDT)
Message-ID: <2d6680bf-14f9-4a0e-ae88-ea48f9a70652@linaro.org>
Date: Wed, 29 Oct 2025 09:25:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] tcg: Delay lowering unsupported deposit/extract2
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
Content-Language: en-US
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
In-Reply-To: <20250928163155.1472914-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

Ping.

r~

On 9/28/25 18:31, Richard Henderson wrote:
> Reviving a 2 year old set of patches:
> 
> The opcodes that we generate early do not fold away nicely when operands
> of deposit or extract2 turn out to be constants, especially zero.
> 
> This isn't particularly rare either, as various target ISAs implement
> constant shifts with extract2 and their zero register.   Or the compiler
> expands x = y | mask with x = deposit(y, -1, pos, len);
> 
> Delay lowering of these unsupported operations until optimize, when
> we have performed constant propagation.
> 
> 
> r~
> 
> 
> Richard Henderson (5):
>    tcg: Simplify extract2 usage in tcg_gen_shifti_i64
>    tcg/optimize: Lower unsupported deposit during optimize
>    tcg/optimize: Lower unsupported extract2 during optimize
>    tcg: Expand missing rotri with extract2
>    tcg: Expand extract2_i64 with extract2_i32 on 32-bit host
> 
>   tcg/optimize.c | 257 +++++++++++++++++++++++++++++++++++-----
>   tcg/tcg-op.c   | 311 +++++++++++++++++++------------------------------
>   2 files changed, 352 insertions(+), 216 deletions(-)
> 


