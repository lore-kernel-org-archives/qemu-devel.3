Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8413CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUlr-0001Mg-NP; Tue, 19 Aug 2025 18:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUlh-0001Ja-AU
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:25:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUle-00063Z-1i
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:25:24 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e2eb9ae80so4667498b3a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755642320; x=1756247120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hjm40C1Pz7jGioTUAXK4nGc8ovztYSjb3V5cdY26FwY=;
 b=xtLxwwBktBYo2nFbfvQqSAf09LeeY28faFZNOswwkL7cYDmZarcoGdpKzoMiJIfmlK
 cwJpaugS0+D6mnwaLWgiHk+FtvO9uqrXf0AFAu6vYLCtcSwVfHZP9pKu84jwvKzakaon
 j5axfL8q3/QRAHFDnylkCpFyrkBOrZc58w2IWMzYFQEuT3c7RVA6C9ZyNBpdqYxyGsal
 EwU+pojEkGPH3rhcw471n6mk8XqG7Mo2Vhtx7qKsOdd5cUvfFrC7uCYSDEJmRPhgdYV1
 qwHB5ZddcpZF8PtKYJsiI6XjiJEhMLTlITce2Jqt4QuwLW/ZkLUhRiAmHwQSmvmgxWo2
 y80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755642320; x=1756247120;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hjm40C1Pz7jGioTUAXK4nGc8ovztYSjb3V5cdY26FwY=;
 b=AnkF3Iy5T2Z0JN2MumEkkFE9WYExdFWMfXZSPGvjLAFXKPgBz1xchggUyQ7t5oU/MP
 3qzYmaLnETahzSKJBVqCeEZQ9GejfEqKobrPRApyPoMsVeTAPkak4gvnM0MdmSV+LjSP
 25EnK6v0BlKGw2cuK237HfrCppRGzeEySM9AWN+F3HUob28HCVXGkimniHb1HCMfw2z2
 QLhP3rBHWWmggRAwBbmaR5ArIp9rZxQ+zDTW6o5s4rHzYu9S3WiKkNc6HMQy1rseWkNH
 9VMhqQtHvUnUvlhgV35YdTQnFipdcZ1BdMYgfqA+ECpKFm7nvNw8L1fFfao1vIKgpiQ1
 fcaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXshuh6ENaVm6PtP0QiCqkkkO+GJ/Eqeeqa6wYz9w4OSWXhG8myxIRP3se50mNMzvke1x1tRnXmnVaz@nongnu.org
X-Gm-Message-State: AOJu0YzGRPYLoiPyy9NMXJLzhZPWxnFuLYpVHosjqAo1aqtp2Ao3kuZd
 VtlJMX4Eu3TN00KhZfu1i8UcJimbsw+iiYP+DuCAzNdBOWIyBwO5T0Vr/PNTPPQXrPM=
X-Gm-Gg: ASbGncswqOvLT0RCMdTJkDZfUd/YugxLuIjx7qXoohi3wYnPojSXaMpFI57iBxMeNmt
 EKU/L7tN0IZI1/M0Q8NtfdXn0CMByaTLc6+AAbpoa2Wp4X6EjKQsFGb/ozjkI3SlBscNKO+2CxY
 JWWwC2Qv8RTEPkR6gvWgCRDfO8BtdHpPLNMUownKCrFuRQnK57Ux247guNAIDmxUQDKdjlaFGAy
 R3Kjjvl7eMoDfWHxVeJFOhUZdbbiYFRUgBUywbXp+5CZCy7OmniYHfCrXSZA8npG5YmSaEzx/IK
 w3yBSzGBj8hJ6UmdHdGYDkskZI0NxMbwEVIKToNE2XLQpIa5Jnu5MTMA9LyCKuC1zTmLhM2g/x8
 ntHnFyNYJUsghqnfzW7Z4CGjauY2iPdN3uA==
X-Google-Smtp-Source: AGHT+IEWa784FsjfvJwCOwMy1uyJQNceVjQlNUvZoclauXM/4KB9ASwvuPW6Xk9+nyogr4JbacEBlw==
X-Received: by 2002:a05:6a00:3a24:b0:76c:c48f:d7ab with SMTP id
 d2e1a72fcca58-76e8dc35cd0mr1032541b3a.13.1755642319598; 
 Tue, 19 Aug 2025 15:25:19 -0700 (PDT)
Received: from [10.0.0.90] ([120.159.20.238]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d14e531sm3463541b3a.50.2025.08.19.15.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 15:25:19 -0700 (PDT)
Message-ID: <eb741401-fbc2-4ffc-b3da-83fe5646a03b@linaro.org>
Date: Wed, 20 Aug 2025 08:25:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/35] tcg/wasm: Add deposit/sextract/extract instrcutions
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
 <c59e13b025fd8a631463ce6033c50b02d3906b38.1755623521.git.ktokunaga.mail@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <c59e13b025fd8a631463ce6033c50b02d3906b38.1755623521.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/20/25 04:21, Kohei Tokunaga wrote:
> The tcg_out_extract and tcg_out_sextract functions were used by several
> other functions (e.g. tcg_out_ext*) and intended to emit TCI code. So they
> have been renamed to tcg_tci_out_extract and tcg_tci_out_sextract.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   tcg/wasm/tcg-target.c.inc | 104 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 91 insertions(+), 13 deletions(-)
> 
> diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
> index 03cb3b2f46..6220b43f98 100644
> --- a/tcg/wasm/tcg-target.c.inc
> +++ b/tcg/wasm/tcg-target.c.inc
> @@ -163,7 +163,10 @@ typedef enum {
>       OPC_I64_SHR_U = 0x88,
>   
>       OPC_I32_WRAP_I64 = 0xa7,
> +    OPC_I64_EXTEND_I32_S = 0xac,
>       OPC_I64_EXTEND_I32_U = 0xad,
> +    OPC_I64_EXTEND8_S = 0xc2,
> +    OPC_I64_EXTEND16_S = 0xc3,
>   } WasmInsn;
>   
>   typedef enum {
> @@ -380,6 +383,66 @@ static void tcg_wasm_out_movcond(TCGContext *s, TCGType type, TCGReg ret,
>       tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
>   }
>   
> +static void tcg_wasm_out_deposit(TCGContext *s,
> +                                 TCGReg dest, TCGReg arg1, TCGReg arg2,
> +                                 int pos, int len)
> +{
> +    int64_t mask = (((int64_t)1 << len) - 1) << pos;
> +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
> +    tcg_wasm_out_op_const(s, OPC_I64_CONST, ~mask);
> +    tcg_wasm_out_op(s, OPC_I64_AND);
> +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg2));
> +    tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
> +    tcg_wasm_out_op(s, OPC_I64_SHL);
> +    tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
> +    tcg_wasm_out_op(s, OPC_I64_AND);
> +    tcg_wasm_out_op(s, OPC_I64_OR);
> +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
> +}
> +
> +static void tcg_wasm_out_extract(TCGContext *s, TCGReg dest, TCGReg arg1,
> +                                 int pos, int len)
> +{
> +    int64_t mask = ~0ULL >> (64 - len);
> +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
> +    if (pos > 0) {
> +        tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
> +        tcg_wasm_out_op(s, OPC_I64_SHR_U);
> +    }
> +    if ((pos + len) < 64) {
> +        tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
> +        tcg_wasm_out_op(s, OPC_I64_AND);
> +    }
> +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
> +}

This is no better than the generic tcg expansion.
You should omit it.

> +
> +static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
> +                                  int pos, int len)
> +{
> +    int discard = 64 - len;
> +    int high = discard - pos;
> +
> +    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
> +
> +    if ((pos == 0) && (len == 8)) {
> +        tcg_wasm_out_op(s, OPC_I64_EXTEND8_S);
> +    } else if ((pos == 0) && (len == 16)) {
> +        tcg_wasm_out_op(s, OPC_I64_EXTEND16_S);
> +    } else if ((pos == 0) && (len == 32)) {
> +        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
> +        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);

This is worth keeping.
Compare tcg/i386/tcg-target-has.h, tcg_target_sextract_valid.


r~

