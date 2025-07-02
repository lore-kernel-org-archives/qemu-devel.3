Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658D0C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz3R-0003Sy-1r; Wed, 02 Jul 2025 11:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz3L-0003Qb-6z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:07:16 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz3J-0001FT-CN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:07:14 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73a5c3e1b7aso2318584a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468832; x=1752073632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJ4EZMcxMrSHWQq254t+XafXoOWq75kMKLzPBAZxxfQ=;
 b=DeSSPI3V3TcpsZ1CeHYPfkLOhjcCqLwxBKT0SeDy7bi9jYtWSl3MppYWJp7ydGuq8g
 OmORXS3Eq+KZgFmcKrau5Uc7h8Gh/zInew7vcKlzM+CRFn70MaISJsNn7GQVWMbDYmKH
 Nb2AL0DpV+3z/CdVaia5e8uGeguX/5+KS+quQ1hTWG1AS+PgldrNvsmsO4KlfWOWx0su
 fyzk6X0QrJyN+KrGiLv3eZvGcxbZdOUGYEqFmjPPjwzb2dUkV7IDJKKZUfL+QkKio+Fl
 01LWZ2QG/mHCnun7UiRdLmnHHJkPOf8uvFMFUHyrUCNcCVquiEXLCiBDAbGdIbjOsRIx
 OG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468832; x=1752073632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJ4EZMcxMrSHWQq254t+XafXoOWq75kMKLzPBAZxxfQ=;
 b=JI132xQQp/KRuU4nvq1itTpb5xTBMNOE6Ztyea7dyf6SNBW8i70zvw+iARa4kDncMS
 OkPy5wmo/9elDOSaw9jUeci6ZQMgP6BllVxvynBYN8PhfZeImujNgL6VjrXSZBW9XtYG
 hXFUy45cWAr2SvywuSJCZbf55mmr8+Gk3Z1nMhuIA7izD/2q3bPd9GF4H2pcAsDdnMHC
 VY32XEzUvFIyVieKXBhO9WbymcmhysxbjS5LqoGAT+2xx1dMPHmyTYu4L0fv8InW+XbE
 OT1Zbi+tCU+ca70mK6K8EL8ti5Edtf1U1xSY8HyQhpvjJFNPxO9z2aMqJZCtGI4J7ay+
 TYKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJDq1u2ok8UXvgPaQyRGirZjg7k3u5DOSm+FVFmO1QGMMuT4CGlEubfXxGX+0rh7HZeOzIJCA2Lezv@nongnu.org
X-Gm-Message-State: AOJu0Yw1+jrm2DopWU5G0Vn8wqyuucVSC41yhjHTY5KjwfMwUYM9PGdC
 Kj5AuhtAMMgJTKcLb7tgh5I4Zy2lWdxeM7HsUWpE8tebGt7yQmwc8ysgw/HozPce9DA=
X-Gm-Gg: ASbGncspWwiklLi9wCZcKmwwcSdaEdPLNGCw8EknLH6BX8WLsCR7p4g2duAEk4jiqwC
 nBJXKnQjjQgbJnhE/hxEHAd5cTuJ3i9gC3/ADfmr6LPPbs0MCcTOUxcG62oRh4DqY04NDWFU8cr
 Sfd0x8MEd513Kl3FlFsC3xVd7MgHV/8vFj1LXxpnlthxSyDVhHHmT3FFJWdXkZ5UdSDJjvNQ2m2
 hp2h/AYFhVAbDwzPEb9XAw4qvCrzbwa7Ml6xe/ioQwv85fGs2G0kxmMCYQJWXW7wUzaMPBYQUOV
 g0JwS4hgUs2pHNgVZWZOwt0dBRwHahUX4KmEZcUs/xyrX88CGKYE+FtB0Tuw+rE5SjUnNgKg5tY
 t
X-Google-Smtp-Source: AGHT+IHw5+LsECLiHwlCGqBZmpG84gKw5xz0fUN8ZN/kKCoc/cLT/GC2mv+7/uAqJc0waX0M6dBMGA==
X-Received: by 2002:a05:6830:6313:b0:73b:f60:fc9e with SMTP id
 46e09a7af769-73b4d0daa31mr2117085a34.17.1751468831687; 
 Wed, 02 Jul 2025 08:07:11 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb103ff4sm2540825a34.55.2025.07.02.08.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:07:11 -0700 (PDT)
Message-ID: <23e6dca9-e34e-4a2f-81f9-b764dfb4ba34@linaro.org>
Date: Wed, 2 Jul 2025 09:07:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/68] accel/hvf: Restrict internal declarations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-30-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-30-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> Common code only needs to know whether HVF is enabled and
> the QOM type. Move the rest to "hvf_int.h", removing the
> need for COMPILING_PER_TARGET #ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/hvf.h     | 41 ----------------------------------------
>   include/system/hvf_int.h | 36 +++++++++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+), 41 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

