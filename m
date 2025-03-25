Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAF4C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 00:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twsXv-0002xM-Ru; Mon, 24 Mar 2025 20:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsXt-0002vy-Ka
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:53:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsXr-0002CS-Ty
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:53:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224100e9a5cso96341885ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 17:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742864010; x=1743468810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=24PDQlixzdw34rH6kOphWwVhoT+rBOM3HcHJ8gQ+zVU=;
 b=ArTrTst4IqO0+ls0GMaq6BvD7x4eUwmyNyH+Qtz4lhtyKLnf/wzH55NKrDYpaURcWE
 /9i2MDnUulxsj1DBh718b/laiqy3oucpxVhaivISFfTiMzPDhO0NIqb4bSB8rTHKN8Rm
 3RBFLhWurKQ3hU4OcM5okUEGvrGWLdwdRD81ZEuYj8JeVCo8a/YDLPi2ljqcHUaMdBtB
 oTRcyAt7v6ZUP0b3gG4X3Ul+28GPZ8CYXpHmt+gKX3A6lVa8jyATNF+33usKiXpaV34j
 tUUkV9b57PVk3UWKNR/jux7utG+W4pJ2GCvth+0G6SBRs7CJ2VsCoXQtBoexGqM0gTYX
 DDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742864010; x=1743468810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=24PDQlixzdw34rH6kOphWwVhoT+rBOM3HcHJ8gQ+zVU=;
 b=FbRc5v0BDSobUZpE5A9VH/2OA5MI3b+whsINhUxDBHAUSRShHgvVqScSvT8mqekU0g
 FSBjKySGVR5G45b1/OD+o/9WMry9Vrn4xo3sMl57ZCAqcU/TJqblUCjGKs75nDOvYAgt
 kbUy5IWXVpuqVYPNA4vl/5NJa9KgyTaF179ihcUw4p0Pz7eCpiDFX2hdweROESQ79G20
 Gij88zQJhhrpZC2Hj/DXUJS9owDJfAIiwg+bT03z4/yU6R5nBs0IZE52OY+5xcmu3DVH
 IyfIg6PlkoOf/dxb63aAdrz93MxVqjKh/W6pbS9w+S8V0HcDTh4m2TCYPWYBrQAHx7El
 Jv1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3cdH7HnCN2tVPelawYqkpuZyt64IsbVPhGLLW+eYM8o67qFfkrXh/hcGow5TPLIfxxKwhHc2FLy16@nongnu.org
X-Gm-Message-State: AOJu0Yyjc7vNOa+ieS/Y8s13ysNQHX96ObOj50iBUhao2joJDHBR2FZJ
 Ds7fFcqtL1wsxBXf9AfSkQE3PlRRBHFuTYR6BLE78Z2Nm+r0RIO9jPfXycsGIW3ah5SiMLap8zK
 Fn3A=
X-Gm-Gg: ASbGncs12/XMP3UYaZNqWcDvTew0jaGw3XhBhd0nxKq7S5XfQzmieSY8riEAQNAsekD
 sBLgMnLev9hK7/P9pxYXYRjQnWfGf2/tjiUECLnqg6y2M+ee32WtK9WYIDXx9qdKPHLMftE1D/d
 Qp+yYzWojmTVj3cyRmHz3X/N/fWqYuFWovA54yOxnzq+LyB0Cy1NJuUfpQ7VvSfV5Df4ZB1LzqR
 JeeQb6hdA/6aBXATTydQOymTlNjr/cK4ZdJM5g8kOefb1ihpeec2GTsZu4EM8TeCKGfb9I15ACZ
 X/tZe44Bz5qki5oBHUka9ltWpNo9hIg9vTv+jTElBxgcY8z+Zx/z9qjOD3cpwTSlVHsW
X-Google-Smtp-Source: AGHT+IFrlp1bj8MJgy+nFupovy+rXyEJHA4aCX943ZvSwpRxANxZDjP09rJfpYJIamxVQqNgXe2mmw==
X-Received: by 2002:a17:903:98d:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-22780d83b3emr290585965ad.25.1742864010369; 
 Mon, 24 Mar 2025 17:53:30 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811c0fd5sm77593305ad.133.2025.03.24.17.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 17:53:29 -0700 (PDT)
Message-ID: <5af46e87-5d44-4b18-be21-468a77a29595@linaro.org>
Date: Mon, 24 Mar 2025 17:53:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] target/avr: Improve decode of LDS, STS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org, qemu-stable@nongnu.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> The comment about not being able to define a field with
> zero bits is out of date since 94597b6146f3
> ("decodetree: Allow !function with no input bits").
> 
> This fixes the missing load of imm in the disassembler.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9d8caa67a24 ("target/avr: Add support for disassembling via option '-d in_asm'")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/translate.c | 2 --
>   target/avr/insn.decode | 7 ++-----
>   2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 4ab71d8138..e7f8ced9b3 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -1578,7 +1578,6 @@ static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
>       TCGv Rd = cpu_r[a->rd];
>       TCGv addr = tcg_temp_new_i32();
>       TCGv H = cpu_rampD;
> -    a->imm = next_word(ctx);
>   
>       tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
>       tcg_gen_shli_tl(addr, addr, 16);
> @@ -1783,7 +1782,6 @@ static bool trans_STS(DisasContext *ctx, arg_STS *a)
>       TCGv Rd = cpu_r[a->rd];
>       TCGv addr = tcg_temp_new_i32();
>       TCGv H = cpu_rampD;
> -    a->imm = next_word(ctx);
>   
>       tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
>       tcg_gen_shli_tl(addr, addr, 16);
> diff --git a/target/avr/insn.decode b/target/avr/insn.decode
> index 482c23ad0c..cc302249db 100644
> --- a/target/avr/insn.decode
> +++ b/target/avr/insn.decode
> @@ -118,11 +118,8 @@ BRBC            1111 01 ....... ...         @op_bit_imm
>   @io_rd_imm      .... . .. ..... ....        &rd_imm     rd=%rd imm=%io_imm
>   @ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=%ldst_d_imm
>   
> -# The 16-bit immediate is completely in the next word.
> -# Fields cannot be defined with no bits, so we cannot play
> -# the same trick and append to a zero-bit value.
> -# Defer reading the immediate until trans_{LDS,STS}.
> -@ldst_s         .... ... rd:5 ....          imm=0
> +%ldst_imm       !function=next_word
> +@ldst_s         .... ... rd:5 ....          imm=%ldst_imm
>   
>   MOV             0010 11 . ..... ....        @op_rd_rr
>   MOVW            0000 0001 .... ....         &rd_rr      rd=%rd_d rr=%rr_d

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


