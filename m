Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72686E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDhi-0006cz-F1; Mon, 16 Dec 2024 11:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNDhf-0006cb-KO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:12:15 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNDhd-0006xO-Uk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:12:15 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eba559611aso1076757b6e.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734365532; x=1734970332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TDPOoO4r7H6+hn+VQiOPXUN8IY0yg3oT3dpNNjOWGso=;
 b=dYkh3zYiYOteaCC7ZQxcCLo/AOIDoi1QPE3guu226NnB/en9HqN3WaG6pUl6Le0EfR
 eiG/UXxcYuuW1svr4uyHmSxMlU3K0QCIkf92uBWkzZ3YvK20EVqD4v6m8ybTv5fsorky
 fC8vLjn4I2zvpLzHot/zBpO9Gh98BGnZhfxirRdzfCOeqhCtJWhfukA/anu6CYX/7fiL
 WKE4SVxnlSTxs2Nj1omEI4Ma3CtA6xGkJzARr9t87k/qS8aZYwVUAycD0uD4aj1EJhcI
 +vafn9HtoQQc/jQPWT9+V6YutZKTnpkbLpBNgpMVhxBrN3dfLk0tXonviT9+9DFk9XPp
 Mz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734365532; x=1734970332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDPOoO4r7H6+hn+VQiOPXUN8IY0yg3oT3dpNNjOWGso=;
 b=cDDfJOdcLoloygPcxsE1uire1LKuQ5IUBFja1SB27D13gSYH66I6tBNquAM/zE2h6v
 B0B7XRukX6j3Siyy9ZoHl2nfhfJ1j890uCNCPR5J3I2DnMY9pSHgrlToNiwU172C9OsC
 6dIdGVEuPFkAhSYaJ1sa/X7huqGIopHhvnRC6t6Y8XTdYwLAstXstJUTp25wSmLWnT2Y
 N79gS1oSuo9Q7YXeTV8ICtfDcdqAf+WVco4MVoqeCjZQCnu8dyLHR0Zlg/wjOdVtRjm6
 xORRyveYQGKtr6tWj35JjuufyfMm5VB8KyBeiMLhfug3mQnmW23O65TbXzDMZTAr7Spn
 mQ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVanb+6iBUYwCbGYsR11M/wuqvCi6xCUjyeuzpHhQLiXzIt9YDc53UhUkLxQDEuDDWbt3k1EXEt/LsP@nongnu.org
X-Gm-Message-State: AOJu0YyS4heUipkDKsUj6v0gnpdMZkAnZADua4iHmJOaIYbzFN81vACc
 HdQeWkZwvNm4WitAd48Vpx5abSsD69MLvpLkknic4Ak41PmzetnrHzDgMsdYM6E=
X-Gm-Gg: ASbGncsLvC0gWGbyLzmLtST/vXLiXGkTJ4WVC26AIrc1PZ36mpSi5jVW2kYRCud1UqD
 kUiMamf2fX8sOEj9hnjQTxFQmMB/bPIVqMnPrVeSiUq/+unM18grkK/dgVml8EB0f+7NKBNIQfC
 PxBPk8OkKp5DikWaxrIRnfD+IRly4tSiR0JSxZ4oBP8dyHEJJierCoiK2SuWB1ELhZAsT6eCbnU
 jxAEtfmeUzXUB0Wq1QqcxMljViqne0Ng6fgxPszcjFHF3O9uljtvA9/gaJdFXwI0aRZjZcOCK34
 zJk/H7JabB9vO+QOx5YNWyh/gVeAQ30bES0=
X-Google-Smtp-Source: AGHT+IGRZfsL0hBGxeNkFvQjXne65hBOuhZlYr2QLQ2ClEklg9Ed4dBvZMPsMqq9FK1TH/d+nP1VMQ==
X-Received: by 2002:a05:6808:f01:b0:3eb:66a1:9d8f with SMTP id
 5614622812f47-3eba6895b43mr6250845b6e.25.1734365531762; 
 Mon, 16 Dec 2024 08:12:11 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb479737dsm1617019b6e.20.2024.12.16.08.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 08:12:11 -0800 (PST)
Message-ID: <558ee1e8-40c4-4517-bd34-a486826c4d1e@linaro.org>
Date: Mon, 16 Dec 2024 10:12:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Really restrict cpu_io_recompile() to system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20241216160514.56630-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241216160514.56630-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 12/16/24 10:05, Philippe Mathieu-Daudé wrote:
> Commit 38fc4b11e03 ("accel/tcg: Restrict cpu_io_recompile() to
> system emulation") inadvertently restricted cpu_io_recompile()
> to SoftMMU. Correct to restrict to system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20241212185341.2857-11-philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index 1cfa318dc6c..3ed81e740d3 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -36,9 +36,9 @@ static inline void page_table_config_init(void) { }
>   void page_table_config_init(void);
>   #endif
>   
> -#ifdef CONFIG_SOFTMMU
> +#ifndef CONFIG_USER_ONLY
>   G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
> -#endif /* CONFIG_SOFTMMU */
> +#endif /* CONFIG_USER_ONLY */
>   
>   /**
>    * tcg_req_mo:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

