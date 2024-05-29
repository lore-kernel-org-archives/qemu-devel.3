Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50ABC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 04:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBMN-0003c0-UQ; Wed, 29 May 2024 00:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBMJ-0003ZS-8X
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:56:19 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBMH-00023N-6u
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:56:19 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52961b77655so1854385e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716958574; x=1717563374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RjQLcO+jti6a0l4UzCHBRgK9x2OIJpQajNqtYvux1Gs=;
 b=px88/112qtgkdEjwCJFE2RZob5/EDRhmThq+MqYONT45zzexaPPiSceuXEfV7Dp3Cv
 6ujvc9gCxxGnyTugdJVogpDFbHPDKXkLhmmH3jJmiO0SRc+HMqqxcbw8Q5why4FDAhuZ
 dMzn4ANZvPdPPknbsU7uhS+8qy4rdo18b+CiAy7jQWLqx6NNrm5OIey6tPkv03VNcVpX
 X+IewI3gjDxCropJJTfavi7l9uiDo2wv1HmH+/On04FOL/OHIaqVIW9N/SJYFah+3Ssu
 x/BER5ES9IYBw/TJOITfYIDgSrEZG2kVucFtBig6wae75ibQS7Snq8eAZck7Yz+wz602
 Gz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716958574; x=1717563374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RjQLcO+jti6a0l4UzCHBRgK9x2OIJpQajNqtYvux1Gs=;
 b=PSz6sKgl74hvHl1JNnPc181oi+ewCUpKMPprqkzYqNgRnUf5Z0Cox8PdFINzgHg5YY
 IEIDKwqazuTkCwkwSN4UZoqnVUa+qLXs1T+wM0KEerksYkx477iSPGGurcbE6ag+GOdd
 qV9vPz35FtxyfzUpcqyWoHZG/LJsgFYy+Nv6VNGmllbGjhFDbWNMGDzSeH32j370y4L3
 B7pvOICOhjDCRgwSq3cCenK4hl9cBoCNC2FlzfRP9AkKYwpkJVVhL9Z1l73sE7uMLmZT
 u9RhBZFnQR3MCmxHDEfCtC0PiMcpN+yLde7D6HlqQGM+IPn1rPxAd6cm+zqdT/Gzl9Se
 UQcw==
X-Gm-Message-State: AOJu0YzVdoWpzK1Z7o0cJDIC1g+ZCIbUmarWnJSXeeRjYtFrsIVMbvoS
 QMTZXkJEgy+6Cm8Q006eMg0i7MSUtqgKkVBHEDrElfoOZtA8q08OQS0+V48Pn5/AGDTjOecK3dm
 i
X-Google-Smtp-Source: AGHT+IFcL7ZWs9vLZjW7XUeP+QY60hoD+A5njo8CuJalM3wyzhhx7mp4aZRhDsZ4kCV/FBefAulNsg==
X-Received: by 2002:a05:6512:3096:b0:523:87b6:2ac2 with SMTP id
 2adb3069b0e04-52965199527mr11586460e87.40.1716958574179; 
 Tue, 28 May 2024 21:56:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c9776e2sm681725966b.91.2024.05.28.21.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 21:56:13 -0700 (PDT)
Message-ID: <fcbe4473-b460-4eae-ab33-e6e1ed723878@linaro.org>
Date: Wed, 29 May 2024 06:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use get_address() to get address with
 Zicbom extensions
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <cmuellner@linux.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Zhiwei Jiang <jiangzw@tecorigin.com>
References: <20240419110514.69697-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240419110514.69697-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

ping?

On 19/4/24 13:05, Philippe Mathieu-Daudé wrote:
> We need to use get_address() to get an address from cpu_gpr[],
> since $zero is "special" (NULL).
> 
> Fixes: e05da09b7c ("target/riscv: implement Zicbom extension")
> Reported-by: Zhiwei Jiang (姜智伟) <jiangzw@tecorigin.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
> index d5d7095903..6f6b29598d 100644
> --- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
> @@ -31,27 +31,27 @@
>   static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
>   {
>       REQUIRE_ZICBOM(ctx);
> -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> +    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
>       return true;
>   }
>   
>   static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
>   {
>       REQUIRE_ZICBOM(ctx);
> -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> +    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
>       return true;
>   }
>   
>   static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
>   {
>       REQUIRE_ZICBOM(ctx);
> -    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
> +    gen_helper_cbo_inval(tcg_env, get_address(ctx, a->rs1, 0));
>       return true;
>   }
>   
>   static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
>   {
>       REQUIRE_ZICBOZ(ctx);
> -    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
> +    gen_helper_cbo_zero(tcg_env, get_address(ctx, a->rs1, 0));
>       return true;
>   }


