Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C9DC19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnPGE-0001NI-Bh; Wed, 26 Feb 2025 16:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPGC-0001Ms-Uz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:48:08 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPGB-0000Iy-3G
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:48:08 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso154200f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 13:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740606485; x=1741211285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26os/+7vWSCnqeHXv+LK4Vp+8ZR8r33RGwy0/O8Fh9Q=;
 b=d0d/6LLDbbyB/5CzK+YxHh1Hggxmts+9i3PYgflEvjsH3bDnicPMItbYUmuPOE+FMk
 LBN4Xs0vajl4/tgfQrwbtH+cMealsNOl5bYcIn7s2ewk5eYht5dO57Zfh2ip0gpaXv2V
 Q4hsCrEmcYMfjiSSvx4uTd03A1ibD79o56yTqu3BMwPGPkpvYbw8Elxspab997wMbKGG
 sKlX9flhuglEpymkAq9tUpGo8XYiiMMOyXBDR+w1u4ayi70ECDF6bkXp1bAeueuvN6AI
 fUbCpW6g3g3FGoqNVx/jeJWfQK4l7H2zGukhx2EFS47Em7WSZzGjbuE6k3rgEp+y4j3e
 1WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740606485; x=1741211285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=26os/+7vWSCnqeHXv+LK4Vp+8ZR8r33RGwy0/O8Fh9Q=;
 b=RX3tY1Ff0UnoUE0NRT/buqB4rnFTh09eSDjEVgG5t71Gz7v9PlQ3NOnFUezjdC5FOW
 OjlvELnTSmxFQzv4BAlHBrFgrQuyW0dbleZNobX/br4bcH+52TlP5d585pdIZILzNlW7
 AD73iYRX9K6mi+LhZvvHIg983Pl35+kX3AT+Qf8+0tRSsspd9NfXDauOALkxTrg/oDLo
 1dwHCzasqZ6wope9KtjTvs0Hoib/gssCg0poXYUcwouCxU7pQs6RQl2XKdWzY8hkYkxh
 +/sgtZJrwUuJ4Et6y7fiwFylZoMU9DtuF7aGTPePdZCcxAqQygnw4Bz/kazyIiiSUYXi
 7wTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3xDtZd12FsUZviqb8SYH7n7U03CykYag+ZQCHFh8xoym9HW31dBESaA1FlZKQcMCIAppuquWl2RVp@nongnu.org
X-Gm-Message-State: AOJu0Yyl8H3dZtVZA2KS7qK9gsx/kWXtutDx/LSeFiqzne1tz3L44cqm
 w9ssfdU8lDNL1Sf3WntRLtjAJw8SnkTLts5NdkmNK8KI5aD/reEWHcfHWg5Y9SU=
X-Gm-Gg: ASbGncur92El5fLGWGUTruCfApyZDU9wMX9XKI9gHfKFHPLnSo79+/NmHlocr1RsC7M
 k0QMjvuaMWcL+UA0X33wB4ucU+fRbmmGTFNKX8hOSaMS0XE/YhJnNuCNyG1F/lVE25PH+IWqtIy
 REs5BCBC8JApxlHjvlk3tlNoCThVLXYIkFSLXJ9i7T3NFi167S+tVN1Q0Qcx5+lBfLwfYyCZjXS
 Hvojldg1JwjyU19kqdlvXHgUhjtAOAKtNhNvlNYabvD9oEFLGWA7KFDhyYCf1AEBF2ZOplHgNzo
 ONKBcZVor6jVfu5zzXIfgPts63TlBIYF1/m3jd2+AhhF2yj2MTai2gBWpRUOtPgVFh1IlQ==
X-Google-Smtp-Source: AGHT+IFXaSGNuI2rz9hpMoNzF032TubVZ2uiafuRA0q1qIli8A128fh4411HHbVZLCQ8tfOaPqKDiA==
X-Received: by 2002:a05:6000:2a7:b0:38d:bccf:f342 with SMTP id
 ffacd0b85a97d-390d4f8b6bbmr4716596f8f.43.1740606484978; 
 Wed, 26 Feb 2025 13:48:04 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e03asm57408f8f.95.2025.02.26.13.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 13:48:04 -0800 (PST)
Message-ID: <375cb768-ba11-4a4e-98fe-1a0b6f3b21d6@linaro.org>
Date: Wed, 26 Feb 2025 22:48:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 010/162] tcg: Convert andc to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> At the same time, drop all backend support for immediate
> operands, as we now transform andc to and during optimize.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h         |  2 --
>   tcg/arm/tcg-target-has.h             |  1 -
>   tcg/i386/tcg-target-con-set.h        |  2 +-
>   tcg/i386/tcg-target-has.h            |  2 --
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target-has.h     |  2 --
>   tcg/mips/tcg-target-has.h            |  2 --
>   tcg/ppc/tcg-target-has.h             |  2 --
>   tcg/riscv/tcg-target-con-set.h       |  1 +
>   tcg/riscv/tcg-target-has.h           |  2 --
>   tcg/s390x/tcg-target-con-set.h       |  1 -
>   tcg/s390x/tcg-target-has.h           |  2 --
>   tcg/sparc64/tcg-target-has.h         |  2 --
>   tcg/tcg-has.h                        |  1 -
>   tcg/tci/tcg-target-has.h             |  2 --
>   tcg/tcg-op.c                         |  4 +--
>   tcg/tcg.c                            |  8 +++---
>   tcg/tci.c                            |  2 --
>   tcg/aarch64/tcg-target.c.inc         | 24 ++++++++--------
>   tcg/arm/tcg-target.c.inc             | 16 +++++++----
>   tcg/i386/tcg-target.c.inc            | 31 +++++++++++---------
>   tcg/loongarch64/tcg-target.c.inc     | 23 ++++++++-------
>   tcg/mips/tcg-target.c.inc            |  4 +++
>   tcg/ppc/tcg-target.c.inc             | 29 ++++++++-----------
>   tcg/riscv/tcg-target.c.inc           | 27 +++++++++++-------
>   tcg/s390x/tcg-target.c.inc           | 42 ++++++++++++++--------------
>   tcg/sparc64/tcg-target.c.inc         | 16 +++++++----
>   tcg/tci/tcg-target.c.inc             | 14 ++++++++--
>   28 files changed, 135 insertions(+), 130 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


