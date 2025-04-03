Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694E1C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MrA-0002lU-7R; Thu, 03 Apr 2025 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Mr6-0002WK-GU
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:51:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Mr3-0008Vm-UN
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:51:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c14016868so970128f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743695503; x=1744300303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SkY5UM/4CCkGhRyJxu98u2QWX+GTGQqT2AnuFmve6/8=;
 b=dYriH6NQ/YRfRlByeBGadglnUEj0/iO4qriJB6i7HWKKfKg6blCpXtvLQDZ4R+eQhG
 goDtXkJNFzx/ltAAkds4BdgY0iehaE9NhmSj20NkAECiYtk2uIk5HyIYQ28EvlfCstgL
 YgRVSsfYCP6xgHHmv+Wu19NJ7uQFmR/60LXBQykMIeIK2focGgIxcXD/ts250Et/LeTt
 ESqIZPNSQ819yLts3bsmpd2t9g5T/4dje9ZwjfBg8iHJyGY8UWfm7TK+/3g9pR7HflUP
 NT1U8aq7vCm5z/NOl/GaycUBaL9cirKN83o0kw7ZLi5pg9RfWD3plT5vbFW0/DXOijVK
 s7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743695503; x=1744300303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkY5UM/4CCkGhRyJxu98u2QWX+GTGQqT2AnuFmve6/8=;
 b=qbdz6TN8zZafpPx6OJAX9dz/JfKyr66RpPHV8nbPerhw38OObZz2oUhJMPFerESi4I
 lHy+Edu9k0TiupjcLKcBOcgmdMag7GM+3kK4t/iZPrWCtGwThBB3bNd5SpvdsOy0gXPe
 TT434UC9NjeyeAhinDe0Glrg+r68lHxIZXiZdwjiDKsXuIDC9BikmX0BlF9pEmySQ4KS
 G6Fc9RUesWA1MHihovWY2xJYHnxizTsUbMltIUQEl+EHAUKBPpISJ6+JYJnmV7N8Qfba
 I1ggoOdu82Is/ougQIayezuabMJbiBTqav5Aaemo7TMZJ5lbXAPC+5TJSyIpPXLZ6OdJ
 eLXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUENakJngIfMjcy4cPvYP/1jZ6TGcu0lKMGXMDED2r8Mzq+DaPP63UYkDr0XiqDfuo/OtbZzirODERD@nongnu.org
X-Gm-Message-State: AOJu0YwofFfN+SQQ+nSgmfe504UAPWp67seTxFeztGD0th40/l3pDb1W
 +gz3Sy7488Ejw1QMsORxWAAET9tvSVA/MTXMDqHR+iZzpkLzfSY+33kGRN/0WZQ=
X-Gm-Gg: ASbGnctK1ZXL7HI3v/Do8L77pjyAQepFPqbOHU4Hxu/qPd2+zr+G/tMY247DhrB5FlK
 DpyyerRO/xKkETjx0GsAiHj1pr5hSLkKmQ88L1TyLizcgKTZnXxwfBe4vH2hFljvY5XI3W62ZXc
 NYz9edhyrnb7Z8gcPX3ytHgGtYtIGP1kR/4BOOCHEZAUN8ogwe+Lsw9MfJh0jy8Y82r/89d2ORs
 tgDRiKTusDDvXF1TySpk/L980Y2yZmFoY5KG0ttZ39ZqKFTn57wH7NyVILD3vW4Uo8QV8b8F37S
 9JDs+iZ79Ma9b4EcYwlzsQBV0tTFfPaiPvN6oYPh8t2relxUauBr8Uj1pkJnGkVptNeuheNRX8X
 Gzu//TEnYkiQbVoEdy9yjnVcPIzpHl1p51bo=
X-Google-Smtp-Source: AGHT+IHmdMM+6V0Hjl8VTTp5Yf/0mClFSjscjN80exbrqvKPsHUJekSJVaFGzwhv55ipv9iLPKuWSA==
X-Received: by 2002:a05:6000:2907:b0:39c:30d9:2ad9 with SMTP id
 ffacd0b85a97d-39c30d92c1amr2426460f8f.10.1743695503005; 
 Thu, 03 Apr 2025 08:51:43 -0700 (PDT)
Received: from [192.168.1.17] (lputeaux-658-1-173-28.w92-154.abo.wanadoo.fr.
 [92.154.108.28]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d980sm2157550f8f.61.2025.04.03.08.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 08:51:42 -0700 (PDT)
Message-ID: <64bed460-8b81-4b42-958b-d8947d1541d5@linaro.org>
Date: Thu, 3 Apr 2025 17:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: Implement CPUState.mmu_index
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@nongnu.org
References: <20250403154956.791976-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250403154956.791976-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 3/4/25 17:49, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 766b678651..59fc9ed698 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -313,6 +313,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>       mcc->parent_realize(dev, errp);
>   }
>   
> +static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
> +{
> +    return MMU_USER_IDX;

Easy ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +}
> +
>   static void hexagon_cpu_init(Object *obj)
>   {
>   }
> @@ -341,6 +346,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = hexagon_cpu_class_by_name;
> +    cc->mmu_index = hexagon_cpu_mmu_index;
>       cc->dump_state = hexagon_dump_state;
>       cc->set_pc = hexagon_cpu_set_pc;
>       cc->get_pc = hexagon_cpu_get_pc;


