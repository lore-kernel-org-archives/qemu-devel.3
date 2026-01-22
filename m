Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BD9C44508
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 00:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viiqX-0000s1-7f; Wed, 21 Jan 2026 19:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1viiqT-0000pd-Qv
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 19:46:45 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1viiqS-0007yG-6P
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 19:46:45 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-89478e429afso4267116d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 16:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769042803; x=1769647603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VqQ/xZFoDNA9FieRufJr3k/e+n1fRTWfDWxGQ300gG4=;
 b=gk377BRGERYaDPTaja4Y+i74FVjIm0FrFXrIBpP2aH0dt1KgYS+ReLiCI9qg2eD47N
 E5i3wSy0AqcAYsV1S1szFZlf8MG7Lol03wsuSTpRilKxFioQCSCiwpb6NPhBdmyVZq6U
 vxSK+7AaDjqo8xT6NSO0BUUB1VfC3lU28boElNUpYnJEfHOcbr+pV4u+Ew7R2SEYHzxY
 Ld4ChkCiEUO+Qd8EDr1ap/7RePehoq/m3YLxnvyekklvPN1B4NQi/tA2ZHSTdXaF6Khx
 UumB08A9JUxpp4vQk5Nj30bscxWgW/EZUwY15mTU0Q2s7/J5mUTWf8yPGJ8P2p5f5MFz
 572A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769042803; x=1769647603;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VqQ/xZFoDNA9FieRufJr3k/e+n1fRTWfDWxGQ300gG4=;
 b=isHpKac5egGya4an5e0gSI2j/a8vUL9zIbqzW1hFnn0DBvGQChganhCcQAkyW65ynq
 Rua7uSo1ckHCxwDy9ztEiwhlxNH/NN2m5eH5oKg2mG2qrCW+3M2zbBDQ64JPVlffw57K
 YZA+b55j3efnAPdyeYMr+x10/4woYyhA/q8BkDyTedeQJdl+dUHo3A4gHi01n+mnLb/f
 dl1p4kR3ECYESguzMq0qVktffsdqncRMFE1C045nkHwsDpxPWzF3AfhKfoB7D3CST80j
 miRdgozgdq58Hyk13fUKWc+2CxNVthmtWdxKgsK61s7zSdA/scz4zGuO6epPRzJ/S2P8
 Os1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUD4Ul5VM/BvbToWoIbmMLhRkPDFTrQrITgDfSyDZZiRLQkGWdxwStkpAwgBuyeCWEdLj/O4c5v5/Z@nongnu.org
X-Gm-Message-State: AOJu0Yw3iBg422GYn+Wg4lftDkpN5a1W0Emo4HnvkdJTm2/eiWxmt/2g
 d2H9660txWuJq96Mqz1QS8z/FbGCNIwO/gPVDJgV1QDpiJmKgRQj0KD+qgLRiv8gDNY=
X-Gm-Gg: AZuq6aIAsdtdDJ2zM/alQFAJQCNi7wHxvS7Gca7VGdWkAQfQDso+dSumo/Bt6PZa8ER
 eEX/S87DIX2B0wpqLfmVRcsHoDm6nTUr1DiQCHDzCKFIzdorcngivcIaB1XH8zgWcI7HmlJ/1tp
 R72tvGO/k5BteXDPaA+F5kINbED2aDQzDynvZM2OajKV1FpysZtuFVNdPadppgmBuuM3zpt0b57
 +VqVHqx+rT7zbIG62JZHMMfO87vR7jhTrDOfXhoq4T7QxUe/aT8eTeQjjFbH12NXYNLaYhsVjn1
 53lkWXEMFtxPaE4be+pBRhZ8UO4l6qYpz1Vqcf8tAEQ2zP5itI2uUyBuhxBSm8SuPRXjCjk3dmV
 gZjh6JBUfeSzRxHDu34jyS5gcEZpxU18a2QjnlTHeQlN60h+ocdogUzJtqagL96+PF/KuwIId7R
 OYig4kfVXShqJW5SnQj4/MXWTzSUAYAcCLtXx62kcUZcZo2R1g+yA=
X-Received: by 2002:ad4:5ce8:0:b0:894:2f28:54b9 with SMTP id
 6a1803df08f44-894638a19c3mr101092756d6.27.1769042802419; 
 Wed, 21 Jan 2026 16:46:42 -0800 (PST)
Received: from [10.244.221.227] ([172.59.190.48])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71c0759sm1306803985a.14.2026.01.21.16.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 16:46:42 -0800 (PST)
Message-ID: <5f2a4c6c-6434-4e4c-8cc3-42994521c0e4@linaro.org>
Date: Thu, 22 Jan 2026 11:46:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] dump/win_dump: Build almost once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260121215622.92966-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260121215622.92966-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/22/26 08:56, Philippe Mathieu-Daudé wrote:
> v3:
> - Dropped Nikolai patches, rebased again
> 
> v2:
> - Rebase on Nikolai patches (included) to avoid rebase
> - Add Kconfig symbol to only build for x86 targets
> 
> Philippe Mathieu-Daudé (2):
>    dump: Abort in create_win_dump() on non-x86 guests
>    dump: Build stubs once for non-x86 targets
> 
>   dump/win_dump-stubs.c               | 21 +++++++++++++++++++++
>   dump/{win_dump.c => win_dump-x86.c} | 20 +-------------------
>   Kconfig                             |  1 +
>   dump/Kconfig                        |  4 ++++
>   dump/meson.build                    |  3 ++-
>   5 files changed, 29 insertions(+), 20 deletions(-)
>   create mode 100644 dump/win_dump-stubs.c
>   rename dump/{win_dump.c => win_dump-x86.c} (97%)
>   create mode 100644 dump/Kconfig
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

