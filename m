Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBE8C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDqr-0008Df-L6; Wed, 30 Jul 2025 16:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDiM-0007KN-Pv
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:47:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDiK-00017H-II
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:47:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so2790825ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908471; x=1754513271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xDcHaXRDHxuv8RcTViw5pgusysHDdhneyUp+Yjz2rdI=;
 b=xK3cuzqohpPzj2qqr2F+JOY9FvQs1pyMFFl3CouBYGvcM29ENWybkj/GhneCgHiP1u
 BMyDMu12aZO6xo18UD1lNh9tc44D0czk51LF0J7Y7mnynig0CawgKvWaDdaE+AQYhLNG
 2MaRY/V17usRR959jyWCdn9jXGxaoejZ9dK1vhcczU7GWzERWNbmzOjjzTDibUV3rKse
 bM/Na2I+scQ1HKLIEY1Zf7TRBaheEYKogc9mcO67A43AUTUpYsHmb5iX96kV3J6OXLjq
 UXfxl0DXzDaby7xGERc9wzy45N9c6vOQD+uNdPgqdoeY0zhaIGirukK2ByWysiQYZmnl
 D5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908471; x=1754513271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xDcHaXRDHxuv8RcTViw5pgusysHDdhneyUp+Yjz2rdI=;
 b=ro6VkEMLP+P6FnE6aY4N6k3+wCi6irOZV4srNAKUbAVIYai46J/Sq6upPGNtpeImKJ
 rqo0/TrsZceBfwei6ZhZFrDJcEBgFqMzgUUQOuuGJFnxHg5Nos7fGg/hOMUFDWG5ibCx
 qiEBgY3GenQ08mPXnfuf19C26/reJiQxmznwQ8ivN0GzeroiQMUQKZBKE9ii5/Mykaml
 +/32nzxI2VfAB2SY1X14+JQjt/Mka/KTpeHbU3tmq525t2EwhOBsuWwVpChzeLwe/8FY
 nJmo9JCc4XgVU0dXKgeuvcLBx9taqtPr5B6p6abW/xIns5eHtIeuuxd7Vur9ezfCWOio
 d8Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnNXjn8adTDhRUhxMFZ6Bqr/G+ufCn8RvII4m3AkbszhfQ2Icuwxo1MTcOZyHNB77VWh9E0/3quQ8O@nongnu.org
X-Gm-Message-State: AOJu0YwSALdIsNWCwWJEEQzsnymIlnXmTIblYU91LSvaFI9sjKkGg4cu
 TfvD/5LEW2H96ygpmDl92MjFvssUAzSSk1TnDl9R/YVQu8jAG/y8DBHqwTuLqqURw1dhu9i8xDd
 5Vipt
X-Gm-Gg: ASbGncs/0yRsiLy7RFczuBbSUCx2p/tRyhE756a85gL6sEjZiFpicrlo2hmTvdwSvGQ
 4wTG6eptm5tYWDZxwtCNPOlURPAtIcRyxC5KS/hHnDV6NXDY2OMjXu0wtrrYIVuqjSAifA/NdRI
 5hE1QhheHpVRE/H20a9dKfl09/vgNUi+fgSwRNq7AJSIK2czr8fEy0QewhpF20xhgNyI7VHj8Y0
 gfZG3IBNUmW1yYoe6j4RdP3EkDGXtAOlAoEwQLjoqQfKOZ2Zra5YVlDO/rqXWyHp547oO29cC86
 c0e5F08TjLmjDmcpEjo3opJ0rPB3KqeZAMzdRkDgNGVn+lzxI7YhGv6BK4JOzkiwmI3uoz/OtVF
 HvlGZNceU8Psku0/G79z2Sw3rRWAXFE+oCbg=
X-Google-Smtp-Source: AGHT+IFq6nqm4Ma7XDB4v1EKiDkqAGvDIghVGeAfT6tGurzVV+5uITvjSqyZdpXgUHvAwcnRMt/fxA==
X-Received: by 2002:a17:902:b489:b0:235:15f3:ef16 with SMTP id
 d9443c01a7336-24096aa37b2mr55787335ad.13.1753908471226; 
 Wed, 30 Jul 2025 13:47:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976f08sm119075ad.103.2025.07.30.13.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:47:50 -0700 (PDT)
Message-ID: <5ea42392-4cc8-4c4e-9de9-9ed3a165d173@linaro.org>
Date: Wed, 30 Jul 2025 13:47:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/82] target/arm: Expand syndrome parameter to
 raise_exception*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Prepare for raising exceptions with 64-bit syndromes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h     | 6 +++---
>   target/arm/tcg-stubs.c     | 2 +-
>   target/arm/tcg/op_helper.c | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


