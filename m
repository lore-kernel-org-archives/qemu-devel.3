Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9DD46C0F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlFDl-0003wD-L5; Wed, 28 Jan 2026 18:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlFDj-0003uG-Ls
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:45:11 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlFDh-0003TN-Ez
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:45:11 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso2070035ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769643907; x=1770248707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tbBBnoSakDeJ8pbz5bFCwaZZqQQR8SUKhGzH9AjnICU=;
 b=GEp90okActSRTtcskmMjN7WiMvrVkfr3XNyb4ezuuVZcLqhMC12kAWwPv2Q73mD9+h
 3MgLOMZlrQ9pIuspj/C6z5yvLyxvFnXhZlRfyRty3ckIg5hO/GotNf5efGy4EeUTg8Rj
 U2RLGW5gbmRzeUw2TiXCKLB+A3QqDEHO6g1b3F7Oh1cyFZ7X46JsKydTyz5pOw+ui2Ca
 wqeJx9q133X9RrxncVdwMkqPeR89wbIqd45ARnIT4mtWRvgErePc3YUvVi+J++Cry+bw
 5mTMiCo8hRk/e16xkj4zRigjxPj4W/gJyz1uWTh+/bi4+tXsnYkZH43zMD3u0uKrguhj
 RYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769643907; x=1770248707;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tbBBnoSakDeJ8pbz5bFCwaZZqQQR8SUKhGzH9AjnICU=;
 b=Orh2W4kaVKoxp3+ds/qyUDR7JGBtEBpvbCM589MHl6Th/zK4yyd8McaIzjMbo0uujn
 ecqPFnVzIgu158+6yZFvhu+gzZkrzsF328OybftdZDM70STLvDOZK0jWlI/8hv7+xeux
 +sFoV4QyJw6oJGhV/OugVWJS1XP+tNh6+rk2OLxcrVqTA3A8267YEphAlVeu5ff80tty
 a0LrC6fWDeEKtKT60Q4eWpdpW8l3Kw/sAeNED/NROCNYO0qPwA3NDQiIfiBs7tVEO6Kx
 y9gp3B0QfxnPO0WInyklerTGJVoLRkk65Eo0uz1DgNc1X0eNv3H7RYYks5HKnnfp1b1k
 4E2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNVLzrDmtTUjW0A0lgCIpNOng5NlkgQdPI1OVfXJZ9JutYv6GYmxUQSEBxIFlMRrM38ZFzAzBdhw1y@nongnu.org
X-Gm-Message-State: AOJu0YwBrOnN5JRisq93C9URp2tieGE7KbQp2Pd+yC0Qx1SC+dmmMgQ9
 NbyyiKpNw6io+SlZKzOR2tRWkG/eFA8vNZeWmSCP+jcQf4Saq+VvtE+ZnEUvM4U80sc=
X-Gm-Gg: AZuq6aJwNhMVhOaM7iizwmHma7QsreX1xepy2eDRBfDDbdTb5NL9RwAjPGaaSPfeXxQ
 U8QmE2KaBKoV+eIZfZDcFr/5/mYVR7OImXc6GzPv/VsZ0ikx6pFfSvRaVGnD6ZzC3t7Ct3381io
 zeLEp7uwRu38bYsCUZFFJFpfo3s6wJ9T8Vx6J2o5BawTPZn1BaA4REnPUfJhWokt+kG0zoYYQ9g
 vn9sD7NzY/AVkDNJT3CW63LJvjpKn4630aLrdYPrk4O8waEq5m4G5EfJ9d/pd12XvMXd0ujjCvu
 nMOREBxfp44P02XVrEZdzOOEJJEydsP7Kwi7YvQJMWOEsN9+xrY0f5BtvE+fdiVfFuj4YIiMk7Z
 LNHrIARuHUAfmLdx6rGuVI6G+SD5RJTxhOtHG6M8Y7h6TlyeqqwnlZDWOPnMJM5Wzdo/T+Dr/6w
 7TPZT14z72Tz5crgE1ptd1PrOeCt6RMw==
X-Received: by 2002:a17:903:40d1:b0:2a0:dabc:1388 with SMTP id
 d9443c01a7336-2a870db46camr72309685ad.28.1769643907237; 
 Wed, 28 Jan 2026 15:45:07 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b6e5c93sm31846835ad.88.2026.01.28.15.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 15:45:06 -0800 (PST)
Message-ID: <716a2c68-9905-4f3f-84da-d07f50e9722c@linaro.org>
Date: Thu, 29 Jan 2026 10:45:00 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/15/26 22:20, Manos Pitsidianakis wrote:
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index bf303813701972648fa6751ffe352ba074ca6442..8dd9eb46c783a799a53891a6ddad40b930e95eb4 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -329,9 +329,20 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
>   {
>       uint32_t vq_map = cpu->sme_vq.map;
>       uint32_t vq_init = cpu->sme_vq.init;
> -    uint32_t vq_supported = cpu->sme_vq.supported;
> +    uint32_t vq_supported;
>       uint32_t vq;
>   
> +    if (hvf_enabled()) {
> +        if (hvf_arm_sme2_supported()) {
> +            vq_supported = hvf_arm_sme2_get_svl();
> +        } else {
> +            assert(!cpu_isar_feature(aa64_sme, cpu));
> +            vq_supported = 0;
> +        }
> +    } else {
> +        vq_supported = cpu->sme_vq.supported;
> +    }

While this mirrors what we do for kvm and sve, I don't think this is sustainable.  I think 
cpu->sme_vq should be initialized in hvf_arm_set_cpu_features_from_host.


r~

