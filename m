Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9F8C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9VC-0003SN-7h; Sat, 21 Jun 2025 21:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9VA-0003S2-Ln
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:28:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9V7-0008Kb-Fc
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:28:07 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7490cb9a892so1142878b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555684; x=1751160484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KTj313XChcOAY60LToQ7PVmx2PwYrejMHMCrlVd+OxI=;
 b=O/4UwBrjfsZqyWiKmNeCnqwQ8TT+hWNB9oRBUVqlvtjJ4vdUupu0H2AmL2u37+Z3Hf
 vyR/R9ahw0I7KOOb6CMQwm8Aw2yOJuSkmwYmZ+E5hFBaJ+jf32xkZJQMH8I75xjaAFmU
 5rF0Tsjf2s6hLeqYGhwFCI3O7v6m7wVyl2++KLrY04dz5kJN32kM9bsBqmPuy8FUm2h7
 p6MLXKhz1QgsQDt9y38Frmbsy0V7yq0g0P7cFsA/Fb4bJdgphMxCDQ8Ci3gzlsF1i2zo
 oCH69LFRukSQXpxKJEL/z+zXV1GJ1TnjeSfwwVth2qw8x+si4qd0fTZ3cdNFtKwazIsK
 LYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555684; x=1751160484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KTj313XChcOAY60LToQ7PVmx2PwYrejMHMCrlVd+OxI=;
 b=q8ReaJMu1q+GccfM07F2pODcjeJ36Dx8oSdAYamLLSBk6K/ietbjF/9iyhbHZysi/Q
 TFksDkQolT/qe/KdObceAQhFn0TF2o4Xa7XxjiAXGB11WL7F2RqvkKsKf+Go00C/ocrI
 CCNB9wapNKgvCep/GKwQvojDbLVAiEUxJlfaNQsZkyZiWlpEd9RXKUDr85hXysRyakIZ
 dU3TkrLvpmf0zjqO8z4DQOxSYrCxfd/FVSm2kAPcdFUpWqV06Jt8IkuEZU7bxWf62vJQ
 ro5uRcY9e3CpHzdtvytnR+DsZ2dXduvP3QiJJrdynmkGuUhuEOwn7iDsy72R/PZ8jWg4
 TlEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc+mrLUDjrCodF+xJoeNocQ7S/+XivMdSpJ1R2ifdfhpm2i97R1VfFYyFI44tzNwEjHLIvzeH/iM4r@nongnu.org
X-Gm-Message-State: AOJu0YyAOA7d6JHPk15yZfjXtz2cCNC2fHd/l6YDlb56RMCqxpVBBEGN
 JuZYDmJ4C561C6lkXE/pabpFX79P6CphxZHe/LXwGI5WdJj4eAzWSNeZwWvvwPL4l+TynKHF1n9
 RpuF3AN0=
X-Gm-Gg: ASbGnctGZi57dvhr7e+I6oPZVT3g3jrgKKqG0bjIddP9zElya8V9wrnNUY6WrOUcdDp
 5xkyQjX7+uf1viFKQJz3wIaVL/9tUBwzwiyHsbDOZPjlVnrs5TQFt/JlUi9oLjmQVKmp4/pshV9
 IW5RRazybdNSDcy0kGqEme/dRaRMmClVreqgPapDFl2aY5qq8LEmRDpHOHL7e9dCVeoDqYYpYvK
 loLDK+fQSerZREtikofrrHNaOGNnsU5eQu/SE8NqTbVuNrVJO7mA+ZIIpnj85OqkiXyYq56XK9q
 aJ5hM8gc7ObicJ5SDmIpwLPlm4tYCltsjIVC1iUnTrDNZNLRqAW9+tgcR/op7F+fOuyqhQ313Uw
 4BzqCRpejEPg+hIpeww8ccCmaZLEF
X-Google-Smtp-Source: AGHT+IE5+B+YLG28T7FFjT5MjkZQqHuvmda0pm8NBO5xX3gUXXl8CqIQ2gc0ukshkGRVI2GM1vu9pw==
X-Received: by 2002:a05:6a00:398f:b0:748:e4af:9c54 with SMTP id
 d2e1a72fcca58-7490d780fbemr11311262b3a.6.1750555684059; 
 Sat, 21 Jun 2025 18:28:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a62874csm5277124b3a.94.2025.06.21.18.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:28:03 -0700 (PDT)
Message-ID: <bd6881ae-950f-45b2-92d0-bcb2fc4d7362@linaro.org>
Date: Sat, 21 Jun 2025 18:28:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 16/48] accel/tcg: Factor tcg_dump_flush_info() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h |  2 ++
>   accel/tcg/monitor.c         | 27 +++++++++++++++++----------
>   2 files changed, 19 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

