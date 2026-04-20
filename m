Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16688F5A8C5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEw1F-000372-S9; Mon, 20 Apr 2026 17:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEw1C-00036g-KR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:18:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEw1B-0006oP-4J
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:18:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b458ca2296so24225565ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776719935; x=1777324735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvEnfNqLyAHB16KxO3uiO/XNfMNLhXNtEc+pzVjik8M=;
 b=ZBdmfvNZJlR7NqLfVpaTlslkaYV3e8Ck3rA5/CvhGawdkcrJuBrZtHPyiP9KscabAm
 mpyyWehfYtvAnHaD8EXiI9Krx3Sdqtmq4UUyRwB/QieB271cifmZJ35cxczfDJ52H7R3
 1csih3c+SM1VZ+H4BmSMh3IahW2nDYLsecu+ZvbqonBRDVAScmxhIMpOzusfKD0j2st8
 7gVg+wQ4tlGu8c6Qb3/tbK+F0ZQOO5PDzpki2TifgIsWt5lgJ5jX7mJOwySi+LcSst2o
 yfirJwGqoZa75KRIGHQ1HiLADAq8eFmYCPANWje/u2p19cEUv6GceuzkprDBU51G+snB
 iAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776719935; x=1777324735;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvEnfNqLyAHB16KxO3uiO/XNfMNLhXNtEc+pzVjik8M=;
 b=pYLJF/LosnTRWy379tlBFXXXbZEAjrI7WzW6aaZOCH7nYMBYb3a4N5SZcdjGPjyyNV
 pmwCB//xzfMzuYomyDd3NYpF8O6NUEysJyHEITPWhBC+PwZdkgX6Hdy3xhd+isAoNlc6
 Usp9FkbP/rpvNKurGD0bIm3f1ntC+3Xz9Q2EqRxCLuOgSsNcGXZ/a4IG3L1TNTAi+JVO
 XFWDLCeAygObzerW360W17m2GPf6tjRO0oqWo1+Yw3HstGRbBfiAgcNxUzqVvXLLbGex
 xT0ahy4QaZlg6Nld+hIG9G4X4ahPrvBSDZv5xPl0onynQRUMYiXNkwMnMgqIbZdq1B1P
 WtcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v1J/HXAL0+8aIDBut5qak8a6RdzLnW8w7Msj7l2lyvOxrtP7FzmKrDY69kmE5fpZkTuMxWS2RIrYy@nongnu.org
X-Gm-Message-State: AOJu0YztwRki60hIW2L3miA7ZdSc2fnPeNK8hCcM2YowlwrUIGm6FmZG
 xegxcOtFY6iaY5i+N+s3W7ZdVxJB6/bFXkYrPyGFqey2j4z8aVI9zWu04fUWSrsAZ9M=
X-Gm-Gg: AeBDietZhJxchWxMsy1RDa/mfuFrQzYXoQqWE//rsHLO9+772KOBRuLPXPxfQQZNL+3
 oqvEZh/zffvNjo6cIcsrrFIYaQh1BxX/z15YCGKyayf9vGF2+4sSbj+K4203nG+gYb4RM7o9WWO
 qcagHt7bDl01F6vvH0qk0ONtRnAthxIBvoc9WupQT/WSoIA+zrAzsxuAfUihmFmOUzNVkAZZ5FU
 0ejvCFsJbgbOq7FfYnjB/AZ7vi5wmwzHPOhEVzEpcL20qHSMTWCCSIPD9Gm93NMzkGGOfj4KaC2
 +khED+g6UJRD0rvhVHfY6HJV75dugdRXzViWGkmgmW08sgLR7foJWLXolSztu9+y6Fjz+5NV8YE
 n9f9mREfrYmZdtBzLDrBwvoWFh54fV8AVN2gkJ/8YdzS9jcbQbv+ZO+B9EXcPpOuhvo6CFjUMHk
 S5oLCVIm0642ESIBYArVjXVlMtywe9pl8HdqYCCuc9mkdKhmWjTr+y
X-Received: by 2002:a17:902:ea12:b0:2b0:6e4a:32d0 with SMTP id
 d9443c01a7336-2b5f9fbbdacmr156229635ad.35.1776719935472; 
 Mon, 20 Apr 2026 14:18:55 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cf3bsm131740865ad.44.2026.04.20.14.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 14:18:55 -0700 (PDT)
Message-ID: <9cb892a4-1be2-40ac-9893-94e892d7a14c@linaro.org>
Date: Tue, 21 Apr 2026 07:18:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] target/mips: Inline translator_ld[uw,l,q]() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260417042620.35329-1-philmd@linaro.org>
 <20260417042620.35329-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417042620.35329-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/17/26 14:26, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the MIPS target, expanding MO_TE by a runtime
> check on mo_endian(ctx).
> 
> Mechanical change using the following Coccinelle 'spatch' script:
> 
>    @@
>    expression env, db, pc;
>    @@
>    (
>    - translator_lduw(env, db, pc)
>    + translator_lduw_end(env, db, pc, mo_endian(ctx))
>    |
>    - translator_ldl(env, db, pc)
>    + translator_ldl_end(env, db, pc, mo_endian(ctx))
>    |
>    - translator_ldq(env, db, pc)
>    + translator_ldq_end(env, db, pc, mo_endian(ctx))
>    )
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c               | 12 ++++++++----
>   target/mips/tcg/micromips_translate.c.inc |  2 +-
>   target/mips/tcg/mips16e_translate.c.inc   |  6 ++++--
>   target/mips/tcg/nanomips_translate.c.inc  |  5 +++--
>   4 files changed, 16 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

