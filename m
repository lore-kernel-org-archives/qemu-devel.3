Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A176DCCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GQN-0001kP-64; Fri, 10 Oct 2025 12:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GQJ-0001jx-My
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:56:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GQ6-0007jD-4z
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:56:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so22103965ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115394; x=1760720194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmNuqnDzh7GH9R3GIWxB7v1xjQNjsOrsgQWrbfpdeuY=;
 b=qZ2+wvkOKKw44jKSzgqx6vYeUiGZvIfGxYQ4o91MNJC9VtP3HfMrD99hZLj9rLhFJW
 /3vI0g77la5SRAf2uhr3rUHnFin78qMtVlS+nBUPsrh5iziO/zAj5dbX62VNt5MX6J1a
 ca+W4dbP4+2L9SQrVfh4Bn3sJjPFn/2viyefFW/OR8T74/z3J3KgyqpdUBrkfhMJWsWW
 frjPFwEnQdbvMTGb4Q22Dfwbt/lLWMFY9oldHYuiktCCQszRIVDqChhxsiWfzPCDQXNI
 yH10XeoqZYffwoMg53UtjRHKr5OAx03fpLz7bz59ElvQILgExkNJv5l6Ug8zEgyaQPKH
 jNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115394; x=1760720194;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmNuqnDzh7GH9R3GIWxB7v1xjQNjsOrsgQWrbfpdeuY=;
 b=rON/vKzjLOHutAM8fTV+ZzzXFKHowXMiQLdv9TdKvrrwn6BXAW2HScSB1WKsXaoMTA
 GLRo3+WqA79cuugGh850hnZbHIAkV+2/x8ZP9fzccmMmBKJUvq+Uv62o22dTFzUXGlxA
 QvVzxdKSP37G6NA6cUEvVsNueD4RS4jzBchFJ1mytVx0wbB+rw25cKOJOw1N1NBUJhoJ
 ONMD4H1bFDel5TGUn+Uz3d/tT0G+gmLJ6lwvhgqVsDa8a7PtD84MtTKRQwdcdNRpNTu4
 8wlCnM8gHz/WHyOx04PKYBI9T1LjtwcDTde9wAJ7fsdHC1PdLG1BatSqYaB1Tzmbo2XU
 Q09g==
X-Gm-Message-State: AOJu0Yyz0Ni1DoGMdOMoxpk0Z9cFMv3SS/2oJCV/ay9PfBixFDcEQqpH
 HNB1QODaKKZyjhCTw/0lungClyFQeeF7efU9FZXCfDKiGY3jyMJNTwJz5s3UIfHDz5urNkdiZVe
 PBnQjC1o=
X-Gm-Gg: ASbGnctDGOFVrJ/sVarDVdKH2/HT7oXSVKFdcrIXtiyKLvGiJb1e6K1uRxGezq/Hxm/
 mdiAft4rDVr+XPzaNzGb2vqqFVK//sgW0Jm4Zyl4UBQEnCZKAp+hpoM64GWWkp0C/GSX9ZT064x
 Btj5iUzgdc1ddYNwC2YMGMpZWDWV3ucQmgWKojoCXEoupfvEKKouWuxMB4zHJn5YByB7MYj2AI3
 4ZSrZE25Nyrelb/b9I8iUe81lqpEoCTgNgoR2wcajCfgt6KgudSHPqBLFMCbHW6e8i0mydSZuLw
 9QldSWaaGkyDt4YKP1y7AZR6IU3cNEXQCntx0S+9rgB0ODdfjtKBhYNDKketX8nc2iFG5giWGuY
 uPejR+vHaMtCCR/Pwhl3qQ3TuvMnX4dBsCBYkkz2oR8ziI2bbTx5WIXzzeUM=
X-Google-Smtp-Source: AGHT+IEcrZPQCyR3Ha6wMoetrAMCfPKeknfIUCKfGrgwdVfDmjsVgXwLMfEHyewoxZoZcNIt6hNj2g==
X-Received: by 2002:a17:903:1a06:b0:283:c950:a783 with SMTP id
 d9443c01a7336-2902741e42amr161600355ad.56.1760115394179; 
 Fri, 10 Oct 2025 09:56:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f941a5sm61715065ad.127.2025.10.10.09.56.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:56:33 -0700 (PDT)
Message-ID: <aaf9e7ec-04ec-4eae-b107-fe1053823bfe@linaro.org>
Date: Fri, 10 Oct 2025 09:56:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] target/tricore: Remove target_ulong use in
 gen_goto_tb()
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> translator_use_goto_tb() expects a vaddr type since commit
> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
> translator_*()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 7c6e3095971..dd09f0651f5 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -72,7 +72,8 @@ static const char *regnames_d[] = {
>   
>   typedef struct DisasContext {
>       DisasContextBase base;
> -    target_ulong pc_succ_insn;
> +
> +    vaddr pc_succ_insn;
>       uint32_t opcode;
>       /* Routine used to access memory */
>       int mem_idx;
> @@ -2811,13 +2812,12 @@ static void gen_calc_usb_mulr_h(TCGv arg)
>   
>   /* helpers for generating program flow micro-ops */
>   
> -static inline void gen_save_pc(target_ulong pc)
> +static inline void gen_save_pc(vaddr pc)
>   {
>       tcg_gen_movi_tl(cpu_PC, pc);
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index,
> -                        target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index, vaddr dest)
>   {
>       if (translator_use_goto_tb(&ctx->base, dest)) {
>           tcg_gen_goto_tb(tb_slot_index);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

