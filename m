Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C91D0D17D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 23:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdd47-0001TL-0R; Wed, 07 Jan 2026 18:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdd44-0001Sb-UF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:35:44 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdd43-0006Ai-Ci
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:35:44 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso11587625ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767828942; x=1768433742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X1qaQcjWL2FbDLkZT6AfsCPWIpiqgsUWirQIvVNBFqg=;
 b=N8/ALyRu+Z6pS8Yj8wstITBg/RWB5LSJSYI31dGLP/XX/gufik8xX92RWRz8TqqEg7
 l38LrQxmlUi1OdoD1TlEedbGvOnLgyji26QrgtCCmHT1DFCsvVdfAjXdYSBu3jC5TN6v
 1eESAutyHrj06zIHU/Xt6xOTo2S+C7hUjcaqpjodmEZsiWlW2Dtu2AvPeBFpDV3e4TIc
 23lGZniCaRp0j39jVIek2Ow0QeqN/KnTt2RiGwISUcOA/PvbGo9VpsUOKa5Xr8AyjU4H
 dlaNLDszQHOcUCm9M6OUY7k6wHz/hHokBvc1MENhFkKvt5NdPJrwdXQYZIufo6zJ4Ov5
 QGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767828942; x=1768433742;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X1qaQcjWL2FbDLkZT6AfsCPWIpiqgsUWirQIvVNBFqg=;
 b=Y8k0KvX35OgTNj7uJL+eCpwEz+WG7E6yTJXJ2/zLq3IBVfygjeL2pI0zzHA2m4y5BG
 AR1Yte82Y94tpCyNFqhlp45Xp4quRDc3x1QtaegMAeZqwDxZIaIBdLcxcCjwQjD1PdOH
 ZnMXD+GoQyKL2uOI9Avlvo1Tv8ZfKMjbt0UEE0ZFAMMmcfPmcgSLa05b4H37/rVTNvga
 kyvrbcabLoYuDwBW//ikvRHI6J3i7s1/otFBqoGdiuh6prLRiKcLYLE5N6jgHGxYdCQf
 GcL+UwEtkZlVweaATJlqhc7b+Lo17KuRt2xzP4newRnZZUATl3lFlo8DuUCvzfGFjbEr
 wmUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfqY2j+46g1uOAR1FZ16G5uI5AJDSJ4kO//MoHhEfvIQdRpddrtl/4cTN2bHK4ADf9PccqQfLkvbUh@nongnu.org
X-Gm-Message-State: AOJu0YxRe3ov4fTOaYytXn25R+B0veiMdO0Fqdb7VDH/nFc2OCUNO38X
 YlmTGdHkBm/sDwkaRCKlyFCRezY6rQaL0ASTct/AgmYvvGDcTfUR4a0+qZmr3hsNdDM=
X-Gm-Gg: AY/fxX5cLOJCYFxstXnEu0/mCNiBuDLPlb96+gR9Vfol9d2BvTfV5e2GZVKDa2M1dXG
 cLdg3292oPfJpx7ikfZdr1kI95qMW7BqaSfpdKNmh+1ztekAeWf0yOVGYPH4IHWqiD2ojWM0+Ec
 mdxQzjZ66R42w01ql16+Gd+gUIo1DniE9gjDIJSke0tdcV6L7mhNWA0R3DUyT5xphD+v0xZ+7KE
 ADRAVT0LnSGLX0StidlLKFKaxJGAgPoWt9pKAnzcjd3b7yklfk0oFXUHvJgcdLGhmqY5Smb0qes
 21jodOlM1erNelr0/Ph5vTQCRsXnxbn+9nzmeaLcZKiJf5L0OVErBV14pkzTKOgBi+n41mqT/tI
 0+5+dMVVeSP7g3ifAk+A7Ib6I+Q0QNsNKcItueL2KwbabJMMqVhcdMKQST3SWmapYHyTOgwhqYq
 fjzTCc0v3BNxJV9LU1RAMKv9T1sgZiEw==
X-Google-Smtp-Source: AGHT+IHKr0yx+S2zsrxxulFt4z1yBMyGztvUDkqPecmCsv3uBtA7il1qCs8k9VjpId01jy+5pFrUuw==
X-Received: by 2002:a17:903:124b:b0:294:8c99:f318 with SMTP id
 d9443c01a7336-2a3edb0d9d6mr46701775ad.3.1767828941724; 
 Wed, 07 Jan 2026 15:35:41 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd4401sm60538725ad.92.2026.01.07.15.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 15:35:41 -0800 (PST)
Message-ID: <a8683e8b-faad-4600-842e-c486c2876257@linaro.org>
Date: Thu, 8 Jan 2026 10:35:37 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/i386/tcg: allow VEX in 16-bit protected mode
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107151400.273916-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/8/26 02:13, Paolo Bonzini wrote:
> VEX is only forbidden in real and vm86 mode; 16-bit protected mode supports
> it for some unfathomable reason.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index f662364c600..243df7e3735 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -2875,7 +2875,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
>            * VEX prefixes cannot be used except in 32-bit mode.
>            * Otherwise the instruction is LES or LDS.
>            */
> -        if (CODE32(s) && !VM86(s)) {
> +        if (PE(s) && !VM86(s)) {
>               static const int pp_prefix[4] = {
>                   0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
>               };

With the comment updated as you say,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

