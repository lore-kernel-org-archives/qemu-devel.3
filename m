Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4657C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnPPP-0004OS-7x; Wed, 26 Feb 2025 16:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPPN-0004OD-Mu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:57:37 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPPL-0001CI-N1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:57:37 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390df942558so208291f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 13:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740607054; x=1741211854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oxwwO/ImKbGxaRLWKnsH/XsXIeHVgRG0GFpjRYm1uvU=;
 b=LcbjJc98ZeN6AgkIvNqsotvySqzejmZe4ZrF4YoIiOIVRh/0J47GoVSmPgVjP+dgOm
 D/RA/7KRMiPPlCFStUqSWJL+LUEfrH701XYI1JdlByJoQA3ZK2zSaMXaM+zviGuOGMk6
 jtGnugFqZSSVYZcf1B5daHoRMuevoz1umso0ri1we5z5ZTqEME4KHDnNC/o7U9d9Z2gJ
 6Xfugp5WaaAjC2OlOmYOpwxuv+Pkcwd5U96ATqQKn5tCBv0bNEBC9iaHXK41I4/jQK/F
 S4zhXlPdj9Tog4FT4RzhhfdPgCOLF5V6NFojyeSX/30YqcN1f7sWWW9kwCEWkpvTdUrI
 xT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740607054; x=1741211854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oxwwO/ImKbGxaRLWKnsH/XsXIeHVgRG0GFpjRYm1uvU=;
 b=MREzx2js3q5q1Bg0V2QDqnBNDhcnAQRkf8xI6eqrKW3Qh3IN6m6O5A/bsbWbdGbmk7
 XeHj9fb8I5jITtp66J2JFcukD5+tpx2qJP8BeZ+MBXCawu5FyHQk8HKONdlcDLOhRSxv
 6Nzgd4La/srv3mefo6R6bH8AbMQYiMWARCI1HUfxr3h6RakvQUeeUZ8Hhe8KtJGuD0GY
 mjvdkZILInw/kzpeL2v9XV41BL+7alzkOneRqPxC6jJxNEAOvgx40wrCh8wM+oWKv+r8
 jkxQ8w7r6RJlPV/Fkj8XyLXr42T82f0wA2UfkkQQE54p2DFtV1LNWOREcEKytmTFwo1r
 K+RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSGM4joB2O/P5yw5coSo2Dw7bbYc0QCo0ex/1I+2V98fqhccEMDS2+5o3NbzlTGR9xn7Er6C/AbCc+@nongnu.org
X-Gm-Message-State: AOJu0YwOdzu+OSlaW2bNpbFQPwtf5W9A1+LtlrqnigOzL35lO5VsvuIa
 r/HHieTVfmBa7QDh+a+/hL+2UDn/IxOxWl2W6VqC6/9EvcWCDjcCriyYDOJHxzE=
X-Gm-Gg: ASbGnctoS3LvCCk2Sovald4sGQce5daJHBw3fUOJa+DYmmadfvkaqTj81AxrU8JOeI1
 4TMR1zlccw3HeSpT2MYgMENMWsUF44MfMg5RXlaUP8WPcLsp2L6mBAJHaMngSj5xQNX4ouNcYno
 m5LND7qq3EIlXOo/XM2HXIdmMycEymZ4vEg0PjhCAn3Peh3fn+xxV7dgqIeX3wC4xOIiKJ6+CAr
 7KZW5FwVgrqKDe+tff2C4y/mvxbjt3bsM2XmATuCQiIPOjW/cF4fOjYFsPyw/QHN3a8VxTNAmIS
 /vmgn27cug473hnkwHwMuBNVkQqt/+KsNMrW7OLP8s+aeAZFEsnbcJ0TED6mcMXUOLAG7A==
X-Google-Smtp-Source: AGHT+IH7HISNdWsQG7mHDIvHv2omOOnVMm9SC9G4M6V6WF8QqSXhg1zTeLB4hQ0P+/RgOCDyqJlZ5w==
X-Received: by 2002:adf:e38c:0:b0:38f:64f2:1a87 with SMTP id
 ffacd0b85a97d-390d4f42fc5mr3768488f8f.27.1740607053878; 
 Wed, 26 Feb 2025 13:57:33 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b70b1sm91555f8f.48.2025.02.26.13.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 13:57:33 -0800 (PST)
Message-ID: <0be5139d-432a-43a1-a9bc-50c08d9d72c3@linaro.org>
Date: Wed, 26 Feb 2025 22:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 015/162] tcg: Convert orc to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
> operands, as we now transform orc to or during optimize.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h         |  2 --
>   tcg/arm/tcg-target-has.h             |  1 -
>   tcg/i386/tcg-target-has.h            |  2 --
>   tcg/loongarch64/tcg-target-con-set.h |  1 -
>   tcg/loongarch64/tcg-target-con-str.h |  1 -
>   tcg/loongarch64/tcg-target-has.h     |  2 --
>   tcg/mips/tcg-target-has.h            |  2 --
>   tcg/ppc/tcg-target-has.h             |  2 --
>   tcg/riscv/tcg-target-has.h           |  2 --
>   tcg/s390x/tcg-target-has.h           |  2 --
>   tcg/sparc64/tcg-target-has.h         |  2 --
>   tcg/tcg-has.h                        |  1 -
>   tcg/tci/tcg-target-has.h             |  2 --
>   tcg/tcg-op.c                         |  4 +--
>   tcg/tcg.c                            |  8 +++---
>   tcg/tci.c                            |  2 --
>   tcg/aarch64/tcg-target.c.inc         | 24 ++++++++---------
>   tcg/arm/tcg-target.c.inc             |  4 +++
>   tcg/i386/tcg-target.c.inc            |  4 +++
>   tcg/loongarch64/tcg-target.c.inc     | 40 ++++++++++------------------
>   tcg/mips/tcg-target.c.inc            |  4 +++
>   tcg/ppc/tcg-target.c.inc             | 22 +++++++--------
>   tcg/riscv/tcg-target.c.inc           | 22 ++++++++-------
>   tcg/s390x/tcg-target.c.inc           | 36 +++++++++++--------------
>   tcg/sparc64/tcg-target.c.inc         | 16 +++++++----
>   tcg/tci/tcg-target.c.inc             | 14 +++++++---
>   26 files changed, 104 insertions(+), 118 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


