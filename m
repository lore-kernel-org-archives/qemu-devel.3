Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD6610F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXoY-0006o6-2X; Wed, 08 Apr 2026 14:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXoV-0006J4-Cq
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:39:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADde-0002rn-S9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:07:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so19404605e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775596029; x=1776200829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=To1wsQYa7oLh+wmEwOgnUuZiDPGmaSipqak66Gx34i0=;
 b=QDI+lu+c4ctQBk2PrY6a5tlHFEQVOZCs1VKrEgKW4E6r0etNyGoWykOLD6oWo2JnaP
 ro3hd+MVAVKStcZJqOd56j3n978avSKqiEjxQqjyKsosjirCOn51jz9nSr74Ton+6W0d
 x6zSfKYGWpG+CX7mrZlaP58BfaOPSYznZoialD67Pf6r188+f0HMXuVhsfQfq5EVphDu
 /++BJcpedneHmDpvR9Yt0+9TeoNPaxhNznrHgPJB8VoeffdjYHwSQSS2pRir5H7tR9Q/
 qjJUi3mh6vi8Xt6PSo2UPdkxMbV4fYle/nSZNe4gOChyMFfjKIeTxBKvDvZY2nS4/sF9
 pf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775596029; x=1776200829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=To1wsQYa7oLh+wmEwOgnUuZiDPGmaSipqak66Gx34i0=;
 b=QZT2LCpFIIkElJqEZK3LXnYJG0YxyMrqd84Q/mSeMoIhS8GH5jCba7oGwIXqUt6qGl
 dfloHpWCRMQVC1aKA7bMNrXqxmOtstpBlaCybVo1LQugWPVfZWKb8ZiX3J0kMpyaCufr
 gL1gNUDs3YUfJtyht2oN0RxT203b4N+C851uMT4qDbAULbuMs8b3LL5yXJHrbvyeZRme
 J512AtsLL6ZPyAyPUtwE3NsBPJ+xtCMxAMBbHximTu63fhgz6Jq7kgRj6lzv0LjYbUiI
 mPGvCSf8zCvm6AL/NKLnlk1Te9h2w/BfLlJSZQ7BFmI2IBKBjQewF3kg9B4rgJ9+vdiM
 CeKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXodPPlOPbd3X6y0LP2C1z2MsxUIZCGSTaQicNA8FzOM9+vxh5LW6tjO3r+JMEF7kqzXKnYQs6acs1w@nongnu.org
X-Gm-Message-State: AOJu0YyE2gE3CMYxB6oDmLEnZ3fG5IeAxYoYXO6Ho/KC/tkPWwsxqUBu
 cgoLzqI9COogoBy2QEW0/W3J8vbULeUvbhaZingoR684zVr2F0BxLb2CiOftk2Ra1Ig=
X-Gm-Gg: AeBDieuX6HqD0dovA5EXITaVq1Xtj6xBei1j5CnrYzO5TGIySfKgZir/aZzQXhOpZCM
 SDBSKOg8Z+9qIHMNTl/A7C5ddPt/eVu43zVooj51JA719OiCMaUi8fWkivjNngLGuBVc3mX9Gdu
 oXd2Csc6mAYO1f99mQyx8YN+YSb4HQDJHLdrekfJhVs2UrYABLM7B+nQyER0S3Q+Zj2vjgLPfTf
 5zFh4iJ9iHuS81Bt8ErREbgsOw0wYQUkwqL1FfBipEnhWSYBUHfEqhjtWlpgGhY3vgPqS535gn+
 5xXRwOLsOvT+tqNP4qT0F4BgimlJMWv84y9TzdZwKuSaBkRSnNuUj6nOR3KSkIegOq0hR64Gx6P
 rWskIwVhEbH+d+ofpDrV5RtQLX4d/LBtAN21VuHO7bCr3cfZS4tPvJnuhowE5wnpT+KIh6GX2o1
 LvnAl7Mw5DWVd957HCffu4jS5Y6jCE68749hitZP9plmbyGeFeeQSBLPIAxrVEODPOJA==
X-Received: by 2002:a05:600c:621a:b0:488:b675:360f with SMTP id
 5b1f17b1804b1-488b6753785mr94597975e9.27.1775596029282; 
 Tue, 07 Apr 2026 14:07:09 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488be75215dsm80800575e9.6.2026.04.07.14.07.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:07:08 -0700 (PDT)
Message-ID: <0c72fdf4-bdb4-472f-aa79-3142c89b1e8e@linaro.org>
Date: Tue, 7 Apr 2026 23:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/21] target/arm/tcg/arm_ldst.h: merge in translate.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-18-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407195922.196410-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 7/4/26 21:59, Pierrick Bouvier wrote:
> Only translate.c uses those functions, thus move them back to this file.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/arm_ldst.h  | 47 --------------------------------------
>   target/arm/tcg/translate.c | 22 +++++++++++++++++-
>   2 files changed, 21 insertions(+), 48 deletions(-)


> +/* Ditto, for a halfword (Thumb) instruction */
> +static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
> +                              target_ulong addr, bool sctlr_b)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
> +       within each word.  Undo that now.  */

Pre-existing and removed in the next patch, but in case you have to respin:

WARNING: Block comments use * on subsequent lines
#91: FILE: target/arm/tcg/translate.c:6289:
+    /* In big-endian (BE32) mode, adjacent Thumb instructions have been 
swapped
+       within each word.  Undo that now.  */

> +    if (sctlr_b) {
> +        addr ^= 2;
> +    }
> +#endif
> +    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
> +}

