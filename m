Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0142ECCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ICK-0001AM-2V; Fri, 10 Oct 2025 14:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ICI-00019H-S6
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:50:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ICD-00036L-W8
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:50:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so33161455ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122226; x=1760727026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UhlY2Cf6mDZcITZCq+eTHCzfZuJLKMd6ZuCChyEVN1E=;
 b=iwkjXLWSAw6g4wDXsIagkS4dBpDFwpepEMRBP+583bT2aVFh/dG94Bc7ombmCCNniC
 HhdmLQiufYbfLBhJKuq5eKrLKmEKZRk7d0Y1V1Qe8imww/ogBKbN98ooWRxGHiuE+1cq
 RU6WaE++5qb5c9qHQW3msCKSU1RSxL7rFPXGnkyjYSSbRnZijATLidnaqbjDvn1eDE1K
 ENVnbb2eDJi9kvQflBcSIa6zPfVl4huViVfMJ0Qv8zZ3IknnHEAlxYAM60GRbC4jtZwa
 GvMuehgyD1jp5QBFUy891+oWv6ac52VAaso3pbIbscz9FLdAYVoJ/ijGFBy+8c826UcC
 NfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122226; x=1760727026;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhlY2Cf6mDZcITZCq+eTHCzfZuJLKMd6ZuCChyEVN1E=;
 b=mBMFQ0A23WoO4Dx1oQ+xuwrzEBaJxzHSYUBHJvOc3e0xmBABdHnPhX+d7kYsb/cQ6J
 1/yeatWyjwqZUKj8S1i5lk6ouhKGHSDu3R7fzN65Fg3wGYbc0LBPYELG+TfqNHjNmliP
 VhtnBbsRJDhVUaqGT0NhwGi26EkcmaPMfbe8U8Rf3JxBSthCxOdzKFPlkvJnsIDzUJmg
 2RHndGQ7zQ72Tzx5LgpGuuqnwk7ZCUjNLOFKjhlBdmbzLHkEsFL+9dedu3muCf8abjEf
 a8UXmYa4tJd96k0kEn/hf9L656WpMvuBcz2yhnBlegv4Z0bPrWjdz3uLgmqvKPX3hEZO
 uMbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJEDpi0SAvA1uJ54pykLrVZSMkGi5RR08x3mCRLjy022EH2XzWrU14Wo5ECfDA/nRVb7uQ1oWlVcQ8@nongnu.org
X-Gm-Message-State: AOJu0YwKI7RUivQWhTw5ybzm0NJqZH0hNCl6isb0pbr5hfO0m+aabLLj
 W+iAGVfxJwr3EfmRUZhEfxF6tdEIQNY4rgeft4AFBYzoITZqvn4erdpgj9Kk2MlsWwo=
X-Gm-Gg: ASbGncuS1HOEXbMlu3cDK2oRWdSfP/XaK2EzaJodc6D3YJL4jtn4ShKOvMPNeqzdoro
 3SHqQGJiKP449qZ1R7LMDHGP6y/SNXikR1jIf9TMg97LiDxQEgzlV1Hu5KDf2PTzXAoo8eBYjhU
 aQkZ0m99peu39VyPUq2Dfsnc/Jsz+RuEAZaxPD01Z9REnPQkIUa1UxGhtPDk+i9TCJCrN91F8Gs
 oLtTvUBtrD1ZQxc40oa0dcBpEOp7eL50ONfWT5gmDmBaQ9XSVWM7gYbJeR+kf2cDnxxvpBVPrL0
 1xxbY/v3Ny9FIXzyqNqBd8qrGkKH8UiMDJr+qqCdi82hMVIlM/kw8sh8lBtl/4J74WreF9hX4Ci
 0tUxDw0FIBensIIl1iQ/9mLrO1zGdNGaphNGgEYg9Kvinop25r3K20jaKSnY=
X-Google-Smtp-Source: AGHT+IESILdxEPBrvIzXo5EWtnQ6590EmBV9Sby1fPXmtlHk6HrCNg2jy6UAI65OBC6ai78jBno6xQ==
X-Received: by 2002:a17:903:1585:b0:267:af07:6526 with SMTP id
 d9443c01a7336-29027303346mr164211305ad.55.1760122226138; 
 Fri, 10 Oct 2025 11:50:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e47341sm63633345ad.57.2025.10.10.11.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:50:25 -0700 (PDT)
Message-ID: <74888095-3da8-492b-ad27-7204d435d24f@linaro.org>
Date: Fri, 10 Oct 2025 11:49:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] target/riscv: Conceal MO_TE within
 gen_storepair_tl()
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
 <20251010155045.78220-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> All callers of gen_storepair_tl() set the MO_TE flag. Set it once in
> the callee.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_xthead.c.inc | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

