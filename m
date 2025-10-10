Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADA2CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IDN-0002WZ-Qu; Fri, 10 Oct 2025 14:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IDJ-0002TR-Mb
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:51:37 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ID7-0003El-TL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:51:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f605f22easo2190713b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122283; x=1760727083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UjQu7zlrklW8bhkUH1PQfspXRlINeX0cjmG1+QQoGLs=;
 b=DBdDU8pMuCBSG3syntMZ8AmFgkXNvwAGSE/W93Yht7v00j88SiESQBbO4gkXeQkbnh
 IB7ARARa/TDA86qyKNDcN3ldPjJQSX8G56NTKgC9o5klnUJmD8ur+lCvIRVKvI64F/uv
 52ymNYb43aUNY4ObXGcHPv7elUu4jNyvR1rFrZ/KYzDFNxnDLqyfQVyNshL2pjBxpgCv
 vUMYxwH1tT1WQVeEomsaJCbY0ohRD/BysYU21z5TIEvsvV25KCPUntN9rcFrmbOq5dEK
 1YAVGWLjDjblCtAAMz+96GB+Eji3zFAOSIatU3skjBuPyopnzQl9YaTXxdGo71eKiWad
 aJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122283; x=1760727083;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UjQu7zlrklW8bhkUH1PQfspXRlINeX0cjmG1+QQoGLs=;
 b=Hz0vN4fO4FouCfyx2MGwdjQFUUq2zf1FI0jnJPFfCWfMtVrwJkeJtw1i5hMMX+rXFY
 3Dg9/6JHHZScryGPWMj/v2WvTowGrMSlDN79eUFFuGOHEE1Zd9PgujEvFKjejCpISQuL
 a/dHUYlkp6cxPL01O0X6OKVNHI3OCmLYYnZBRbHuWwu43QpqRwJf+9HIuiBIsFAIC7qP
 bnWyNAad6TKf/FlxO3+zzyY0kvQrI2jyOWpGpaWYOk2qsenw3LtwNwbrz5Q65nvROHAj
 wU2qtbAm4hAfFiBTOf3FwxdFE6guyerubqtN8ROM0rvA8IM1DegpN5kOuRlSm9nzqNI2
 5Lhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY/+9b+khyC4sKv5tNakqRERENlb35/HXdkaJrKNsxM3UP8Kdi7/FYy6pVgSATUcb2RreOIQ8CNGfz@nongnu.org
X-Gm-Message-State: AOJu0YyoKb3SWTZAryvywBwfwDqk+xYuopjYaP4rgvS7CzlSKerBrvuj
 7RPaxA6XdJsb8YdJEboiqFQ1FjnBr+GY5RoIBEuiEN5y7nrMSYGb+e3OBACdfMluDXw=
X-Gm-Gg: ASbGncvFAthV3q5dFlIsvRkRpst1qOm5OkcMVBdB63plob+nqw/4yNVSqDGGwNq4Ym1
 L1lxLKlJ00RFzKOxKXXoMSwb7Wlh3UEDhbC6J4XvzFj2JfCRYDdBkjXZehJDADlgjW7DvRo/J/X
 6Znzb73+Pi7TX0Wc6SRiclrBA9N2AmuuOZP0CRnDDQJxt+AYTNYc5iek2OnFqx+ylxNZX+mvn7x
 Hkcb6SkNAqHVR3NrPDUq5bcPisn1eFPZhr7kE9HIIGZNfcSmbpsmmzufIGcLQC4jXIzlQkF5oUc
 MjyVc6XAlQZL+kyfEpGHJR2X9vIsBCKMUO54wxjVZtxjaOevGCR4bp0zV/qVu+IGXeGhHa7Gv3T
 ynhvkOYsHeT2cEX6MRKRdQEpz9jehua/cFh0pdqLRTiq5yXDJTYhQYrMSXQI=
X-Google-Smtp-Source: AGHT+IGeh7EqjJMv17z6t9orhQkp4p7snkDCDTXPf0X6g5kZMAdbtHWlfxAx1AW+wesX7a5Hwiw9Ww==
X-Received: by 2002:a05:6a21:99aa:b0:246:354:e0ff with SMTP id
 adf61e73a8af0-32da80bbb0cmr18998510637.8.1760122283134; 
 Fri, 10 Oct 2025 11:51:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678dcc0cd1sm3035389a12.8.2025.10.10.11.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:51:22 -0700 (PDT)
Message-ID: <19ae4657-92cb-434b-979c-05f399ea7dda@linaro.org>
Date: Fri, 10 Oct 2025 11:51:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/riscv: Conceal MO_TE|MO_ALIGN within
 gen_lr() / gen_sc()
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
 <20251010155045.78220-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> All callers of gen_lr() / gen_sc() set the MO_TE and MO_ALIGN flags.
> Set them once in the callees.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rva.c.inc | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

