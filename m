Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8175F30262
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 13:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1llV-0005wZ-DH; Sun, 15 Mar 2026 09:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1llU-0005vx-17
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 09:44:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1llS-0000Av-El
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 09:44:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-485409ab264so25517035e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773582255; x=1774187055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uw6TSFyoxLDSmiJlSd/IKQxj5BBuaxKSp706RK0L3hY=;
 b=Phl9hvMr3QSooYJY/cHtv2ew5webcJ9wZyfMFGpP3h6JWtupFutL1IxtmQqhUoAxUI
 6NmS6SarFiA4en+RvQW3vJVhuiX2u/2M5hwfVMnK3IKn0ImXWt6Z1K6dBxRus6g5MqK0
 X1rmHnHJy4LVL6WdfKESckl6YAX3lmZGzt2H+vVggLLViWiHC6D1g5zLGG1QBagf0E0X
 tAGWWU4/xyFoWJl8nmfJZQ3eKsi3PLzgJcL1tldGXa76twfESxZifQIt5zhY3rdKeZLc
 GgOnTq82oduL5HfddmjyX2zob1MnDxCsP4HqdVQC0bBVhnBeXFX2HdQqIawcg71dsX8h
 ioWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773582255; x=1774187055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uw6TSFyoxLDSmiJlSd/IKQxj5BBuaxKSp706RK0L3hY=;
 b=OwPCH2bwtbdytp898vyZiucQA/WCZ6O0ZcKb1POujJLhJ9tgdwckWyz7kl9Mcz3HGp
 +jxLdtfEQSNLKYGJtYI0es8ixF3BopqlGQ9yNuTIFrO9VmaPS4iserR2Nj1zXHEMIro0
 AjWsXGh+5432I7FzEfm+3Und55dCRtG188RqtsajOos1hU3JfgJ3ykq5wBTy8lmg5w7K
 nrGlOZRbTgr6N6jTejn00xysBcrip0Z84QReH4WKtmJ0J8yGD3x6/RMzSG3zcxzkRRWt
 JMckQBenUZiu6+5xZYZJEpTQmsmoeAXi/nKBetcpujCnvxn5q1zVID+Jc30WTolluOgO
 mb8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8A8a9R5acl4vSruXOufAf7w2F63dZx+yrYuojs7eKuZ4ZSwxifaiMuYE2qL4l17CORAfhrqJzOICe@nongnu.org
X-Gm-Message-State: AOJu0YyrzT3PDc2H2prSVFeJ7GiBFyBYJbiSaFoJzWhIUt3E+xfbPfN/
 664CTq7DFhiGVqhb1G8dKdTvlVAOen9+RInUxPIxBpErfvhpj2dRNjv12uHA07uH7Iw=
X-Gm-Gg: ATEYQzwFdOItTCGtefoB1rGgBTxIywHHGVfH7FM/PRQ4oLtoRCqNflmnQIFlbbevFgu
 Gkfb5FHrGSGdBBV0R1G9H2iHhbaFxsM6yPY0KP1wQ6BnZ2GKdWArq3RdWOc9t9u78KIYdvfl+6L
 QsYSm3MOgOydPlUQXfOM4wDQtdAbFzg97PaWvuE1XUJP3A1bHyvr6vY+DQp6JixaJSlsKGfa0Bt
 aUvwQs+fbcGGxVwyB0d1yBmwrPwIGd7/jnHaInzQWo3hID+GWaW+UgtUVWYzkVBgBfeZcfHu+XA
 vMo0zJjW3IhaSzfRPRCGgYkh/3HbeJwMHQpdL2cpL2o+RKZ6Jo8x3tY4xMdk5TjFYb1eREBGn50
 /42hWC8xCmg8qsi1rysiB24yvIle4BulqGsz6Dgl76H6Kkq3TiaqC5ONbrk76wEy1i8XLKZoj6h
 tLDfS3dQEHgDhQ54Kd1YHTBms7u0P7AbfqnENyXb6U8EyQJS6NsvV42DX7LQQcucEMhA==
X-Received: by 2002:a05:600c:3b07:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-48555ac5e34mr156143115e9.6.1773582254549; 
 Sun, 15 Mar 2026 06:44:14 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b3b0e9b99sm11313344f8f.18.2026.03.15.06.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 06:44:14 -0700 (PDT)
Message-ID: <4b6823e3-4af6-4434-9982-4c47ef62ab32@linaro.org>
Date: Sun, 15 Mar 2026 14:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] whpx: arm: fix ID_AA64MMFR3_EL1 host feature
 register index
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Osama Abdelkader <osama.abdelkader@gmail.com>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
 <20260314221529.47841-7-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260314221529.47841-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/3/26 23:15, Mohamed Mediouni wrote:
> From: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> IdAa64Mmfr3El1 was stored in idregs[ID_AA64MMFR2_EL1_IDX], overwriting
> MMFR2 and leaving MMFR3 never set. Use ID_AA64MMFR3_EL1_IDX so the host
> MMFR3 value is stored in the correct slot.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/whpx/whpx-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 8aa24f2adc..bbf0f6be96 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -684,7 +684,7 @@ static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>           { WHvArm64RegisterIdAa64Mmfr0El1, &ahcf->isar.idregs[ID_AA64MMFR0_EL1_IDX] },
>           { WHvArm64RegisterIdAa64Mmfr1El1, &ahcf->isar.idregs[ID_AA64MMFR1_EL1_IDX] },
>           { WHvArm64RegisterIdAa64Mmfr2El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] },
> -        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] }
> +        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR3_EL1_IDX] }
>       };
>   
>       int i;


