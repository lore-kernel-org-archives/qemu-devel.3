Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C332DEB28C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voEcO-0001RW-BB; Fri, 06 Feb 2026 00:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voEcM-0001Qv-8I
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 00:42:58 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voEcI-0000Ok-D1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 00:42:57 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a78e381fc1so8713025ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 21:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770356572; x=1770961372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hB57Gt7m82iH9wP0OXzPQalr3BNm8uSy4LXaMTnazo4=;
 b=D4DU5Wj3myGSOzaXo8cOLxdOPXHKg9ib0jj51NBQCfOAXs13A9TbuX8GmpmQxLU0G+
 HCxelwhRdf+FrjomFk4xfZib5DiovziPNwqdacK4LQQQOMp2ECnQv/TXUowQjmOhJblI
 UlVA4X9Sl5hdgpsZoRUxfYVi6uZtN5TrWSe4rCKLyP4ZKEvYvHUNZRuPt8MsRYsCzjx8
 2aficdzV5Sin1ESEEhaP498fC24qUOXQvabASnXDfhf/JxHqOw5/LYhyxfPOmSbtF+p4
 Xv6D5QFyvDokbXmRHSX2Vh+FEkDoEL35errYlaWpoPER36m4y9jdBzeBedOqukrlcjUN
 NsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770356572; x=1770961372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hB57Gt7m82iH9wP0OXzPQalr3BNm8uSy4LXaMTnazo4=;
 b=HC/Rf2H/b4YXufguz4WhA7/Y0DKqIQKNTVGw4x8v5QFAdgz82YIIqtnpP3bv5ciwlz
 MKxWPTVSi1axXKTP8Emzwr0YzgGoGhKhnADieAPi5WyJj31zW7dKodGIypw0OIAuHA6q
 dwRgRIlaVBLCJQA1ZS9AJbtRxyl35XUkbm8QY8LBgTyy+D2uXZ29ZEt+9C0BVOaUnRQC
 Whr29un9rSm9FgJhmZUDNE33LSt1YegHBQqbOyRXMd5zHszqDLxVlBwYMVBlWmblyhES
 g/wM47KxUBAIXwWrGU1cSavVP4AWLBSiIedfxp+uBU5JUjG84pyhXpVuPlX8Ap2v0OfK
 bvuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPbzqhS2mkdohd7qy6PtgHfKs1t0lbBstlPqEeD+iG96N1IC00/fLSfQt9ab8tmu87g9rlh6U1E/zj@nongnu.org
X-Gm-Message-State: AOJu0YyKxRZ2GDhdWtdBBGz8B5pwrDOzq14aIip8T7kQ8KWSFZ2JAduV
 XWhp/hVTzZgop5JgD9ydKBvDwjaBAbj5HaB6LtFHesm4qQzCeq7/RplqfrInI7j8BcI=
X-Gm-Gg: AZuq6aI3ZEqs5Mv2XU5fXmtbIlGekgo86I4cRbfrGZ9cQsyFxBfinylLyQJyJDUSQoI
 /u9FQB3BV75aKLrUtED3VyUUb29Quc3nRRapzW8skSu48WJ+zxEcQLVGasUC1gDv7iLpHxNUNTy
 d0Rqmd+L443cGCewFUj3W4PAaXNxTqbcu5WTpxXgOqTeflYCTykJR4g2z3D7XViEddbx4Fhlrpq
 69Daf5xrhNA4e7XvesWnq0DAlr9f8hr2KufXbihsYSXr7RxmjVYO+aCiHFFlGaicvwdXH2v13m1
 BgC07+l29ud3hHsnikMapIQ+H6I8xN77/TprSMjhlOXkrpYlC56kAF1eqmwMgLl0d340NrsHiZH
 otD57e3AsFCYb+S0fjstMnVYXFDxfoQGny4FoOVWMGDbsFbD0cF7Vf4l3mxkEw4Mavh9VPs8kg+
 mznhDb52IbIvQaXWoM0BVVfEtpw5bFaA8W8uyHsl5mbGK6cc2D8PJd1OwJC1vUpbRsuyiqMl3e8
 P0bDFBZSScCkecX7KIcB6sj4XzY/ODbZf2UIF68puM=
X-Received: by 2002:a17:903:90f:b0:2a8:7814:47c9 with SMTP id
 d9443c01a7336-2a9521f3ccemr19841915ad.36.1770356572323; 
 Thu, 05 Feb 2026 21:42:52 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a952217a43sm11198975ad.87.2026.02.05.21.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 21:42:51 -0800 (PST)
Message-ID: <73405a0b-a12f-4a95-91be-627a44115323@linaro.org>
Date: Fri, 6 Feb 2026 15:42:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] target/arm/tcg: Correct SVE/SME I8MM checks
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202133353.2231685-12-peter.maydell@linaro.org>
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

On 2/2/26 23:33, Peter Maydell wrote:
> The I8MM field of ID_AA64ZFR0_EL1 is set when the CPU implements
> FEAT_I8MM and either FEAT_SVE or FEAT_SME. Currently we assume
> that it is only set for FEAT_SVE. Update the feature checks:
>   * we rename the existing feature check function to sve_sme_i8mm
>     to indicate that it is true for either SVE or SME I8MM
>   * we add a new check function for FEAT_SVE && FEAT_I8MM (giving
>     it the sve_i8mm name that the old function used to have)
>   * the instructions which are (SVE || SME) && I8MM need their
>     checks updating to sve_sme_i8mm: these are SUDOT, USDOT
>   * instructions which are SVE && I8MM (i.e. really SVE-only) stay
>     unchanged with sve_i8mm: these are SMMLA, USMMLA, UMMLA
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h      | 8 +++++++-
>   target/arm/tcg/translate-sve.c | 6 +++---
>   2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

