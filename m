Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECE2CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yTC-0002GP-72; Thu, 09 Oct 2025 17:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yTA-0002FR-AL
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:46:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yT8-00009d-Et
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:46:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso2147519b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760046396; x=1760651196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yH9rkVcbNCM36NMVF9sE4RvCifuw15BN/p2JcH2r5VA=;
 b=vdzmx0Rmp0inwKcxO6j26rWzWN1nqKTF4siNepTBI7vroddasGtgu9oed4PfPyfI7p
 qypXGfZ2UzhxO0F6YQ4CRygPCYEOAqjZ1wWce0S6W4oDLZYRNp43TM/MgipMp3WVcZHj
 yG2Mc3+26poF1TxYP44BQqoF4t38/WrQ8/G2SX02qASSpE+IdcWUlGyyNo2O8XwIxgmH
 jqYFXROlhw35BqpLvNiAiMTlHlW/+NBnzWHdDciPQ7DJ/Ip5kLYvQwDMecQl5YwWV5Bl
 EsKdvFYpwUNeOBizPD45K0X362qSH2wCCO54MphTmMQvIcejZjUt/uJz1hEmGmjbGNlk
 U8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760046396; x=1760651196;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yH9rkVcbNCM36NMVF9sE4RvCifuw15BN/p2JcH2r5VA=;
 b=u1oZDP9IGXoLr2XgNCiJINxbj5LeIk8pL8wA6mMoAdjtJ7MBPhwkFNPSQDH357M+2d
 qFVxHoG3ZwnBbsZQ1pcwU+EriF1AbXzTlQOl76flml5cJN0lgXcDMYWJl7OvYEyDFSlG
 HfCciko7QHVsi+65P1pqdezee7+77lUR+zuvPmskmQ/hzgCjMUhsVJ7G7zpvLOBPXykG
 NYRdZIeMgRRIR9o3PWNSZhUm5Hg8vxdhZNyfQN36H++JkFXvzNbOVTO6CT+sh08qrWFt
 BszgnNNied0wGaAV8ypFREFf/n2CZZUKxLDz50REgjLrHS/JH5mrjzvxqJxm5JLT73kx
 8mBQ==
X-Gm-Message-State: AOJu0YwesXaZDoU0qMX0nmjAQtGuNY8hl68BPixLlEZruuj72E05+Tsw
 aXMtu58HlH8grAuikd4jFhp86USyljxnG3lJm5T8hyXdeoxw4x9TbcOcpI/JLeX4rUVPzha4nsv
 f0IiezEg=
X-Gm-Gg: ASbGncuNSC1uRLZpaNhZx+igiRWCVl7VyU2s+SyQdG6zuujxnFqTc+KI/aOPYZ2ynwl
 Vx+qX3KJCrBnlW+QUeqVmPz9oXrdsku/4+Cd1M+iOIscz64brYhG52ZxT25poc6JSRfuzgeAtHc
 hzZBEnKgE6AwtC/qE8FwyS6QGHjrsD3ZjaE5xJ6GSwU5Reyqmm1gFYhmz+LCgyUVZQ4DGqkiaZX
 AtdI3lxbOWFyDtX8QMoarYyuLOXx9wcGpGGopKI9PidwolhBQ7GAiFyOhb2b8y/F4xq2YInt+S4
 dWbcV+HCtlujgKptqv6WrU6rHzlZGpev0x4dBsVek3RLllXB9CkQNeBnFEvWrrkbB6nW/3XvNII
 ZysxdstpwCxGrttUJZTKhITvqSlbzFlvJpA37/9nEDvOlC+YA8/H8BjTs1Trw1r/HBxTRzIdO6J
 w=
X-Google-Smtp-Source: AGHT+IFuCjj3Sr4qspqyZtj58R25IT0SrcE2InM6smpVlXbZv8aHM8depK82wGfLZl/hY/0mhrqK8A==
X-Received: by 2002:a05:6a00:b85:b0:781:32e:53cb with SMTP id
 d2e1a72fcca58-79384f48ca9mr11201413b3a.2.1760046396398; 
 Thu, 09 Oct 2025 14:46:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992dd851c2sm708148b3a.81.2025.10.09.14.46.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 14:46:36 -0700 (PDT)
Message-ID: <c79f48b7-408a-4b02-916a-fe9638b03136@linaro.org>
Date: Thu, 9 Oct 2025 14:46:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/loongarch: Remove target_ulong use in
 gen_goto_tb()
To: qemu-devel@nongnu.org
References: <20251009201947.34643-1-philmd@linaro.org>
 <20251009201947.34643-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009201947.34643-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 10/9/25 13:19, Philippe Mathieu-Daudé wrote:
> translator_use_goto_tb() expects a vaddr type since commit
> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
> translator*()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
> index 53a0b4c3ce9..e30b64c0e05 100644
> --- a/target/loongarch/tcg/translate.c
> +++ b/target/loongarch/tcg/translate.c
> @@ -99,7 +99,7 @@ void generate_exception(DisasContext *ctx, int excp)
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> -static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static inline void gen_goto_tb(DisasContext *ctx, int n, vaddr dest)
>   {
>       if (ctx->va32) {
>           dest = (uint32_t) dest;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

