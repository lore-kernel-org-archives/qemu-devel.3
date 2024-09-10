Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C601ECE58B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuoT-0004oD-RM; Tue, 10 Sep 2024 02:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuoR-0004ku-PL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:57:19 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuoQ-0007cQ-71
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:57:19 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso209542866b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725951436; x=1726556236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uCLdtHa7EJnUKKDInoFEdYxlw+L0t74xL1lonZmPveg=;
 b=QVJg2pkoiy0K1ls7I2X/F4EH8w/ERK/3ZDgMBJmCjiSs/zPoui5Enqsq9yiqE7xZB8
 9g3a295bpmcDY70Z69CM4XatVFCdwJm3MYRK3Ib6VBRGpDvAb1I7Cu4lq8LSOZ7wmJoZ
 ip5QeFgFof3Jhd7JHC0D0ssRe3/3iHvjoEpW2503huZHRHa+SBG0DaLYK0/mjsJGABlE
 y2QfMW7W6tol3/TC4dtCbpBMGJBp7OqvhP6PXAQgNo1PUpDT7bVvbAWcw6vzAC1WfAZD
 oKlTkz4+sIvrB8ugwyuEViQacGf5ovBOuCHpE26cn3ahb4S208GZKmjHBKmdd5KRk5VE
 Lqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725951436; x=1726556236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uCLdtHa7EJnUKKDInoFEdYxlw+L0t74xL1lonZmPveg=;
 b=Gusf/S9ZoLKVYLmNhc3ZcUzmhDN8gDQW9eMFyejPtEGWANsKlDTo8wvHj7mRS0ah+e
 XWS70Xg90E9dYOLQW62dHMSf9RaNoWYW09+8LG61zS7kvi9raROlJLaQpPyehQASQ9++
 Uhuod0z2GD2TQEf9AJymwsxCC2ebbgWtta740E1RyuHV/nchxbCyqdtcBEoV7fFxUshO
 jtQ5AO4/8x97vCzbiGxUFsyntvQ+uex6vKVI/74/5YA97UoF79wne6IlEHiqwMsen2ta
 Z9NWXeAMPTKTilyvWdWJyTQCJxLfr2ehEVxw3NjVvKQL8JAvuXebXjVDy/BPhsGyqrvu
 A1UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOHtrL6erz1ySG2tAhwkdahg8RsnsHEwMLvdqUg5shA+RoHg6yEnLmj1fCZZbeLPBbEk7GTepPjQFD@nongnu.org
X-Gm-Message-State: AOJu0Yy8+WiTnNCVuyXdBy7jSzWqW42MS/L/fZ7m+2EpNPubVyudsUT2
 6XRbreEDUNAtSOgdm9OU0cualG22yeYgK5Fgg+Q0vm81ANRnBPr/0GB5TUB3nYE=
X-Google-Smtp-Source: AGHT+IHHwmbYALkkSPZVuFHVYQ6IHzqJZFd++EMABNlbo5IPumPuuQKXUlr5pblfCLI5Bc9CLdIPOA==
X-Received: by 2002:a17:907:3dac:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a8d72ff0309mr155514266b.28.1725951435577; 
 Mon, 09 Sep 2024 23:57:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d66d7csm433321166b.224.2024.09.09.23.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 23:57:15 -0700 (PDT)
Message-ID: <a831998e-0845-4270-8f76-811c8eec2c4c@linaro.org>
Date: Tue, 10 Sep 2024 08:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] tcg: Fix iteration step in 32-bit gvec operation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com, qemu-stable@nongnu.org
References: <20240908022632.459477-1-richard.henderson@linaro.org>
 <20240908022632.459477-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240908022632.459477-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/9/24 04:26, Richard Henderson wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> The loop in the 32-bit case of the vector compare operation
> was incorrectly incrementing by 8 bytes per iteration instead
> of 4 bytes. This caused the function to process only half of
> the intended elements.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9622c697d1 (tcg: Add gvec compare with immediate and scalar operand)
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240904142739.854-2-zhiwei_liu@linux.alibaba.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-gvec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 0308732d9b..78ee1ced80 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -3939,7 +3939,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
>           uint32_t i;
>   
>           tcg_gen_extrl_i64_i32(t1, c);
> -        for (i = 0; i < oprsz; i += 8) {
> +        for (i = 0; i < oprsz; i += 4) {

Maybe using memop_size(vece) would have been safer to avoid copy/paste bugs?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>               tcg_gen_ld_i32(t0, tcg_env, aofs + i);
>               tcg_gen_negsetcond_i32(cond, t0, t0, t1);
>               tcg_gen_st_i32(t0, tcg_env, dofs + i);


