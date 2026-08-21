Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E0AC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQ86-0000dO-8c; Fri, 21 Aug 2026 10:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQ85-0000aj-2k
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:21:57 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQ83-0003fX-FL
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:21:56 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so679468a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787322113; x=1787926913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m1bkL84FGzAR6EBEhfalzooCYukr/6Fp21OgZ80HLDM=;
 b=Zfqb1GpOTy+VJEAd6KkLppowFVnEAE73lfjR5Q+Xb8jFR1ONSjBjqfRzX4M3Z0SLpl
 LovAs1EH/CItIOhM+y5IlJYQtl1duuCBFirM2jLAJDFYo+uOc365KbzCLY2RsfonMxCO
 JUqlhDKVASx6NFpxHQiNzTRE1rfzXdrYO2JJjQLkxG/UpZq+qFrK/kXdHt7wMV/5LYxw
 U/ahQVCMIqJUipapVKgo55JcNib2qcGIXWDDjd4ZLbLKP+paGhultLHPem0G1E4g0tJG
 kmn2Ilj9sSvkiAYcHtBRZl4T5AAIjyjHAx+zLCPOs2ANdM/FB4O2kfp6AgMahWSHgwPN
 NqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787322113; x=1787926913;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m1bkL84FGzAR6EBEhfalzooCYukr/6Fp21OgZ80HLDM=;
 b=Zad3qr4I1Mq1YLnzJaRsnAMJPbR1WlaLnjvGH3iJXcjKdfopXCMFVLYEecO5ZVRMUB
 2yHCunC3QzDrWNlYo5fwHQ5iQ9klGYGbrYWSzQcx6g8CrMsmCRzJ61lgv/CakMfEkfPL
 1v6A8lvxMkfqrnv5TlGG86IHTa84LZ6sZpe9ARjv1AR0nOI+cI+7R2eO6NiBcM2/cnP5
 Z/0CPvJq5iO8KfpYLF/HENv2g/CPP3RCAL8pOkHlzCFL3PAUaf8OOcpbSXmk6Mnp2RHx
 JvPvZUax7ygmB78v7zKrjAnTw2LTLNcfXv9P/j6a3HuKtbiN/MhV9I5Th6O+Icx82Y/E
 6LEA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7Kl5VbZqKLW7pdpOgNpEV8p9FQXDU81IaVfcvzHtUCcq+D4fiRhegn3GyJ+1AY512ZZ215AI6oPSC@nongnu.org
X-Gm-Message-State: AFuF++m/D8zWPGgb6DFX3iHa84tM7KiOZvGDJ0RJ+FPRkiztqqGKjUN9
 K9g9pKRFl4iNcni9xsWgA5yCJdqVHaTAwKxT01tzJN37ibzMs601+tkVULxFNVH68XE=
X-Gm-Gg: AR+sD12eWb+xyPy0h9tY/efzIcAsBwpUnHOgi19R6Livj4Y8L9CAPJfGt/TRYZTcRR3
 d5Co8BfB8zv0AkaI2SBbtpkC51Tsy1O/cVMfbob263LHk/8TyLNaUzaKIjceZwNQblbADYwC3hH
 5DHCZNlMyr6QY0p5iOj3pLvYbzBEXE1yUt/xmfH8X43BxTLwRJNqCsWITQVH30CiC3UQu5AzlgQ
 fMSiw47gICqcdAtDq1j3Lp9pruXqP8Q/QYvSQx8RERj09QE81u1Z4lSvcWBCqouxKOed2HXIJ1x
 C6vssPgSjuAXOf54g00dvytZHWFHJTij2pHshvue3NLddYDQjHtr2Pgh/gDQ27Q0v4QhL1lhq3b
 N8kp4UZ2/4QlKdFGNLqHoALN60i2DHolkSXlm5PUlPHGtXm66yTVEzFGpSO1vybuZCzn+72uP9F
 GhMHKV4sYB9tDqBWwdqPRNLS89DR+NoqIcRsLlEDsRbSyHMzqUlv107+ELGz2Gye0qXOW8t+U7j
 9Da
X-Received: by 2002:a17:90b:4acd:b0:38f:1a2e:6e56 with SMTP id
 98e67ed59e1d1-395c387407cmr11281083a91.9.1787322113081; 
 Fri, 21 Aug 2026 07:21:53 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4b635d4sm3447017a91.15.2026.08.21.07.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 07:21:52 -0700 (PDT)
Message-ID: <0a7ca30b-e623-48dd-8db9-c53c76f9407e@linaro.org>
Date: Fri, 21 Aug 2026 07:21:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Make IT insn undef when not present
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260821132550.168896-1-peter.maydell@linaro.org>
 <20260821132550.168896-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821132550.168896-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 8/21/26 06:25, Peter Maydell wrote:
> The IT insn is introduced for A-profile starting in v6T2; for
> M-profile it is present when the Main Extension is implemented (which
> includes v7M and excludes v6M).  We were missing the feature-check,
> so fail to UNDEF on earlier cores.
> 
> Add the missing check.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9ee6e8bb853bde ("ARMv7 support.")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index df98dc2e34d..103e2fe7c73 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6038,6 +6038,16 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
>   {
>       int cond_mask = a->cond_mask;
>   
> +    /*
> +     * IT insn introduced in v6T2 for A-profile; it is only present
> +     * on M-profile if the Main Extension is implemented.
> +     */
> +    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2) ||
> +        (arm_dc_feature(s, ARM_FEATURE_M) &&
> +         !arm_dc_feature(s, ARM_FEATURE_M_MAIN))) {
> +        return false;
> +    }
In practice this is going to be the same as just thumb2, because v7M has v7 which implies 
thumb2, and all v7M have m_main.

Is it clearer as

	!(arm_dc_feature(s, ARM_FEATURE_M)
           ? arm_dc_feature(s, ARM_FEATURE_M_MAIN)
           : arm_dc_feature(s, ARM_FEATURE_THUMB2))

?

r~

