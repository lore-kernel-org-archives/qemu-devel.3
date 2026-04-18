Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC29F99C63
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDtGq-0000s1-EF; Fri, 17 Apr 2026 20:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtGo-0000rM-AP
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:10:46 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtGm-0006UL-T7
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:10:46 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so1299130a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776471043; x=1777075843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EVpSqqubsVXSRRzeOpPlJKLYWdiJNnOqvaVFXBoOq4Q=;
 b=ngBEoYTRgJlgiuIHg7Ntal2hmPSQAj9nJqCJA7cq7X5GrULXP67i4e4BYL/NVpTSFp
 t37MLHHElmo3Aexd1DdolMfvdAxUgJMiQvKSZlGTn+Tm/YIlqecCSJFcFlJQmidm/iHx
 haAtAo5BXSqcH2tu3bbB+6ww8mmqgeqr5pBvqQ2Ib+FkQBC6/uRVTOWz1iEfryXAHzhv
 lyXiq4n01Ytd+ITEFxNqb2pOIrV0FxxnnR8rbqWY0hyL4c/arsj13BExmRvih0XYNICq
 wcTHpCSLK4BGzfoyQfiOkwnFz5sXmv0HrBRZVSMcip2sSMlIt6y0Wfcct0FT3fLmblaK
 GRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776471043; x=1777075843;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EVpSqqubsVXSRRzeOpPlJKLYWdiJNnOqvaVFXBoOq4Q=;
 b=h1JGeDnrDVKPAtbsiz/d8WXsOTFUP8HqMAuWFa9BkH6mHNbXZ7Ofc0Y5WAcxlViDkV
 J0T2bse6nA6q3YmRvb2FiBIBS9LvM36bsXkEWxGBo671Gb2f934iIMtuL+efpXdSEQnq
 cdsMpdw0r2NQg1RhOHenX485/mQfBCSS4SwbQZepsFo218z/4GPV088MtX/jdSYsJtOh
 DjUd5WuJ0PpmLJM9JnBR2sSHI2v74/g1u+Ofu7fhEDPQHYPc8SgIxm4XeRQmvW0k0rdn
 Fl/3uBJtYtHaAJ/1MA2Pily2OMgyYZGQHSGimYj/tdcN6LoNJjMCpET36xyrz94LB4Yd
 secw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R7akKjpaOQU2ZQV6CkkSE9CtHUtcSe/a5IZoEj/G4zE16U4jQHuAABwoaTJ8nTrsE7ZlFkGpkbAJQ@nongnu.org
X-Gm-Message-State: AOJu0Yzf0AjPu2W1qQ955tJB8XQZ3aYGuv7BA+fr9YAMluiFmvyGLIhG
 9m7m0xORHIOzchPgYYEismpeelR17yAD4QlzEOSso9qSUszrsrB0lYWNRJbxmwcMgsw=
X-Gm-Gg: AeBDiesnd6w7kEiW5ZHbQTJBpo3fo2nvGiokeoBVWeHO9DG8qD23ZlLxm5q3Gqb7E05
 3AhevzdHlw/iqQIPzvTwpug/quPHsZVMM5kr8DrUMLCa8Mslt5uyzUG25KDmlk09q7YYOcbIBXR
 19/zsXgJdiIbvQgdy30UpHwfF/1SSpjyNHNByq4Nw0OxaK4Uzyse5zWIBPzVT1A6wy6M7/ruZ3n
 cd6dzsPfs4lK6YNILziJYzU6mLkgZABfZkgVqVfARkdN971q/J9ZrCyt1Kw4srXVFBql0bzxDwe
 WNQLuatx68EFgd0HMXHwhc9feS4P8MHreWlKYi20iwumaGUNlJLsaPxbE6BtQ6ppSRF5XAwLi8M
 Xub0o51OFzNkILevXYFCNMiPsNjXRI9lHeQsbHqpCqW8L75C0Enm4ILmMgR4t9GoTDVNtX7i/R/
 J2VjqgcIUvpU45Bc6P+GSLvqqq9k/NnauJHilN9Pq9BJVrfQfmpWhDOESy/wogovYrC3PUXJ+R5
 n3srMPp1r08h/0zZK7HJl09D/vdsRMAolNZt/+oD7IFevv6XrRThUFHOcKdRqzZAQ==
X-Received: by 2002:a17:90b:5203:b0:35f:b9ea:8f9f with SMTP id
 98e67ed59e1d1-36140464842mr4435573a91.16.1776471042858; 
 Fri, 17 Apr 2026 17:10:42 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 (bg30dhzyct7sk57q2zln.ip6.superloop.au.
 [2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab4cc47sm32729265ad.82.2026.04.17.17.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:10:42 -0700 (PDT)
Message-ID: <aba8b166-ba1e-4906-b648-34950bd4b674@linaro.org>
Date: Sat, 18 Apr 2026 10:10:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/arm/cpu.h: New GPCCR fields
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
 <20260417-jmac-feat_rme_gdi-v2-2-7cf5131aeb60@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417-jmac-feat_rme_gdi-v2-2-7cf5131aeb60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 4/17/26 21:02, Jim MacArthur wrote:
> Add SA, NSP, NA6, NA7 for GDI and GPCBW for good measure.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu.h | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 657ff4ab20..1cfef02dc0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2089,6 +2089,11 @@ FIELD(GPCCR, TBGPCD, 18, 1)
>   FIELD(GPCCR, NSO, 19, 1)
>   FIELD(GPCCR, L0GPTSZ, 20, 4)
>   FIELD(GPCCR, APPSAA, 24, 1)
> +FIELD(GPCCR, SA, 25, 1)
> +FIELD(GPCCR, NSP, 26, 1)
> +FIELD(GPCCR, NA6, 27, 1)
> +FIELD(GPCCR, NA7, 28, 1)
> +FIELD(GPCCR, GPCBW, 29, 1)
>   
>   FIELD(MFAR, FPA, 12, 40)
>   FIELD(MFAR, NSE, 62, 1)
> 


