Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2D3C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59lw-00066T-Tp; Wed, 16 Apr 2025 16:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59lu-00062v-Po
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:54:14 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59ls-0001ju-TX
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:54:14 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so22142b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744836851; x=1745441651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sg7tj8104noKZCryNDyv9NQ18S6Xk+63binuvj7LW4o=;
 b=Vuel/mriiiEr1gZvLJo4A9i6UIA9yNuYJ1YDY6D/ZouyD4jOnUITkvr9JMkCuDtEtr
 niza13ECq1VsiajHHA4sKWiQeQkhGJIP8uEivbhMP69wt0Ziey/glfZA4ml2QR1Uzs/S
 UMx8N3s55PL3p7sGhYndWpvpSrFWT+f+9jbdapFWBuKm359Rmm3tN4JlOz0swIyWHKNP
 gInYqv1UyNFc5JyiIAqi9SzChEgpWntsid4p8XynEtkIbfWmHxejnjBm5lb1jhm9yCFa
 wN1fuyFvHkuKOKKVmGK/UGriC8aKJcm7H+4phCHQCoR86fepcV0kRgJgnPBLpjYTxo/V
 l75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744836851; x=1745441651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg7tj8104noKZCryNDyv9NQ18S6Xk+63binuvj7LW4o=;
 b=ZAw0IH+JksCySfLTw78ucT8h4XBeD6Sd8GfN8u7rwl/CFtXn7r8HNHuG3v6JaPV/c3
 hzEVBeaQsr473uSVVkeyX67WL3z7n0yF1RfecXmWz7M+ErfUcHJXFxxEeynvY3fkgYWZ
 NhCV+7fPLwhzbzX1328U/sqFvF3s+AcBTsHe5Qr/CS8OYzwc/YPkJKM+7X08JtXf564U
 a+OLELCK0wMqGE7/IUALFpyEMRTnXXY2HGIYQtmZOVVsepgciKCGoa7bvyWk5j6rVmiB
 s5/k+MngPcUfGhUaRfrmzCfKuelpw63mV8HHTmraAbUVdiXMqZKlpC9oCCrSX4W/qkP/
 9Sig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA37Mso0dFOzLTKYV/dwTL9Oq0T1nRNpoVicniOnF2LYYwe51gkn8s7vI1UIUXNcI1KWYtAgw8L8cn@nongnu.org
X-Gm-Message-State: AOJu0YwPA988LDxPCFFdiGPa+01kq9B67H2X8EO8qR5DQUcv2piAR69O
 Ly7FCOK1/UDLoaqxhCU8nOVgS6cD7q9v/f+zARJexpNLiTdS3+LwkWHAJ6pf9DU=
X-Gm-Gg: ASbGncsWTJ0bMZ0TuUf7pc90DWDtZF7hdzxXePmb2dfBZIUaA9al3hQ7F6XQ2I4EFQ2
 oUVyfcLejru4yw58B1vD1sgrteETBW8PhAZd9+AbZepn9byan+N1A8x9r+Y4XUIlL9u351Gc3T4
 aByLnEPtgAUFyJRs2BaYdcNK0SNDbOlmvEqeepd0ayjSBXDU0/2yZ7Mi8d7XHhqO32AZO0VbWmi
 13DrY1FYRmh4MW78q6aK7ZhA90Rex6obXOeGVYy3fb+izaRhAguJY7B+zujk00PEG37Eo1ppBae
 XWglfwOHGHuMJW36Aik6VDlW6mNHoitt0OaIb+GzC9IHCd+tKvi/3A==
X-Google-Smtp-Source: AGHT+IFRRp7um7lKp92faPBQehEKOgJ66f78z4Ou0/jwi5UHp0i04JVwin8kY8t/DgkI42i++h8osw==
X-Received: by 2002:a05:6a00:ac2:b0:736:3be3:3d77 with SMTP id
 d2e1a72fcca58-73c267c9faemr4723857b3a.16.1744836850519; 
 Wed, 16 Apr 2025 13:54:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd219894bsm10945281b3a.34.2025.04.16.13.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 13:54:10 -0700 (PDT)
Message-ID: <4ef5c7b0-e885-4634-b3b4-66b8d40b9946@linaro.org>
Date: Wed, 16 Apr 2025 13:54:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 158/163] tcg: Stash MemOp size in TCGOP_FLAGS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-159-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-159-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/15/25 12:25, Richard Henderson wrote:
> This will enable removing INDEX_op_qemu_st8_*_i32,
> by exposing the operand size to constraint selection.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
> index 73838e2701..b0872d6637 100644
> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -91,11 +91,15 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
>   static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
>                        TCGTemp *addr, MemOpIdx oi)
>   {
> +    TCGOp *op;
> +
>       if (vh) {
> -        tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
> +        op = tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
> +                         temp_arg(addr), oi);
>       } else {
> -        tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
> +        op = tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
>       }
> +    TCGOP_FLAGS(op) = get_memop(oi) & MO_SIZE;
>   }
>   
>   static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


