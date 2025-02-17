Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D506C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwF1-0007hF-NE; Mon, 17 Feb 2025 03:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwEx-0007gx-6X
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:12:32 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwEu-0000TI-4B
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:12:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so42299855e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779946; x=1740384746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhwWdOx738NwmoAylR5ClxsL6rvnAaiRAYMU9qmFMX8=;
 b=R3ypl4W+gV/m0Kxsw+j4294wlWhMintqlpzDLs4B8dImdGOGYych/A3LbiqPbTfrFY
 yMATpqD1FAPDFVpaR+9eopKO4Ew4FZSVpKTSLuuI4P9GgT7Zhen1i2x/fYp02nWdrTc7
 +ZR182ocEqey9bWpCxK4ihQ1OlbRYkTm4TNKrKsk0DAqWfPyQ8/6R5HYuWKjaTjVZOEp
 ZRhYWwXsE5See6Fwz/38c/yRKUWio1TWEcglvqa4VS9USTvf3XCQxzBGHJoU1DGBYTo6
 JP7WfgTDam0ca4/7KUEGFfDNBmo+eBiyez6wvKnGq1tVP1BRngOeuJfPVUPhk8Kvxoxx
 78Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779946; x=1740384746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PhwWdOx738NwmoAylR5ClxsL6rvnAaiRAYMU9qmFMX8=;
 b=XgmH4nLOugq/3X5XV0W+OXakxT1xMGPNEETKc6LLeg5dSud48l307oso/j019GKgUa
 02pADw/7qUS7TKxIYopDTr/XfaXzPBt6/NxDBq0UBXWEK1Tmgba3aVB01XwnCkhCb0mZ
 fZoCbnywLYS9eGKdGCyJOPG1mfLz+YDIPj1m9b50AkVDnMC6ULPVmTj3XZPbb0nMUMWC
 qGqqO99kOG3gDWu7hAnTM1TV5wKvXIKAKLGu25gl/X/Nc6E5xxKjVNonvI0hV4+KJPmT
 oVnbUzttIJYJyPDnWem0AfaMG8k+s8scynirW6ftZZ5LcONh0nctNF+BbqJHQCg6amZi
 oJ4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUubppx56+FNhIv7oD0mNqmVof0sWT5uZnKGWJ0gpc+kCU8hEyNKP/f7GnTGYkzEAU6mD1A23F5gfBH@nongnu.org
X-Gm-Message-State: AOJu0Yz0xaxi7TARVs7zP5H5b6N4zpWG4rt0qe3Q7T0pY6EVwtxF1a57
 HmqXPJgrk/r3Y7SFE3ptjUACKKWjcJ6R5KLmDZbGX/F6abYwLgc1wMPkxQWTjQwi9rQDBvNp9a2
 h
X-Gm-Gg: ASbGncud4POby8B9+BxV3pzqtSnFgQOTfNrJcUanpulg86PnRmNhB5alTkIlaJCAYIg
 RpqkgeOrHsxVjiDLv7pO/H8NJ42OsOYXvwQBQvKHxb7bEqYiltjHtb/ciTw5Bs3u2mPs1RrHgi+
 JHDsnrwotvMc7a9GyKjbscv/ZU0YNB9djA+eKcopjTZ/JcQEy0CfeA9YRiK+4DMbncyPJ2j9rqJ
 ApcaMse6eyMvbqfgm3LWdGwFoRb7FA1esxRPLeyDxJ+uTJN+TyS2j1tSyVNvbCu/jcHYcsUUl5M
 bfjTS2bPRT3RIDkhZE8TQ3k71y3Y7A==
X-Google-Smtp-Source: AGHT+IFolqInw0XXFtH/SAzqbdWYuueGIf+KErbtxkIb2gk+kakGn4zUP9bhAQjIRKtVVeDwBsMrIA==
X-Received: by 2002:a05:600c:a386:b0:439:84ba:5760 with SMTP id
 5b1f17b1804b1-43984ba58ecmr21541705e9.5.1739779945600; 
 Mon, 17 Feb 2025 00:12:25 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa2dsm11402153f8f.101.2025.02.17.00.12.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:12:24 -0800 (PST)
Message-ID: <37086221-d674-4a73-b8a4-b9c01366b298@linaro.org>
Date: Mon, 17 Feb 2025 09:12:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 093/162] tcg: Merge INDEX_op_extract_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-94-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-94-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/2/25 00:09, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 14 ++++----------
>   tcg/tcg-op.c             |  8 ++++----
>   tcg/tcg.c                |  9 +++------
>   tcg/tci.c                | 12 ++++--------
>   docs/devel/tcg-ops.rst   |  6 +++---
>   tcg/tci/tcg-target.c.inc |  5 +----
>   7 files changed, 20 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


