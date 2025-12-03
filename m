Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957D5D12D55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQlqP-0001vk-RQ; Wed, 03 Dec 2025 07:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQlqM-0001th-H6
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:20:26 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQlqK-0003Oq-Pv
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:20:26 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4507605e19aso3447859b6e.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 04:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764764422; x=1765369222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGkTPdKIyyiYeobjZc1lnFF0gddFnBlSXgF82GcrW4I=;
 b=Z/Gu22/3sw9PWotVMu680oup+ETv/A1vtOu2rDHdhPurNE9JGng/gAPiGFbTOB4VCG
 fNt2NH+za+XwC7eFHxCw/GYdFkmDJiji4QFFW2WIqYKzNQk1lgBKnHnFq1q7CFl6Q85D
 FzaRov9aynLzk4/qakaWruOdjxqDlOdrZch06/rm3jAPtINMw1ZnTGhwZh6srggFdYkD
 Gw0rbcoSJd56BRrPi/iVgsRc75PGUZfD5Q0uT5dmDjmnWLG8VyiysoW+oMjO06gKBPkT
 FHwznjYr2hPA9HCVeXUO1SRj97Iq04QXm7xKMioymWPkZsGgBNXyotbojOgjEQaGP27c
 tinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764764422; x=1765369222;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGkTPdKIyyiYeobjZc1lnFF0gddFnBlSXgF82GcrW4I=;
 b=QQ7jGLLha3ODyWPljDq2LaaMGN7JHdO2FCSNQWRiLfhRFrO3g3SUVvjWFpjN2KZ84+
 pj0yoq1UDdy2IWm42brXZD5Hvx/a6zEuABxHMb/kj+iBFIlc5B3t7EZ3O37ZVTjqmWHw
 tA1bjr+DvdjuZJjhg5oGS2l4+HlWgI3AnnD/WzzYMlIkmIiwDmlkDrMAtuXwqtZpQ0Wo
 UFSD1U5OxKEpylRLvR2bdMeUHcv3ZCJLiwUgmVx8nV0T7VUbZ5se9rHuylP/ffomhUzl
 7Hr/4dI/gV2a7ZLq3v2acyR1An2p0DVnbZNi/tz/dRO/1FfNQCu0INQ5O8MGqtuxAU8X
 fjvw==
X-Gm-Message-State: AOJu0Yx0/cryQKV+hBfTKoeu0pzE0cExxnulzZCnLpsMh2m9k7meyeE7
 DYZ90b6kMiKol5I7I4AMO0oosw8c+mn/gP+N+KGtcR2Vre2DexdVx/SMhTkdIrRH9d2xhznvAq4
 bEdR+6Mg=
X-Gm-Gg: ASbGncsVuVr4pWDxVxuse9QsycdNCfrlV/qmTUb67kwn2OPlXXZx57YIHLNKpsNzVkg
 kEolEXWjyC/klkEHkDCmdJaF4pNDoOuG9tKuSLkJdLJOTvWNfH9YXQwvnl6VxUao8BpfswfPuaw
 rINZYLmNjPYhoMp7dJNyPrAjmZA9Ky67nQRrjL45WJF9vZviEq9Y/GIHxMMo2wz5BAx5p46fqPb
 5mPqWzhwtJqlITFz3utJjqW6dEArEyvrhVXPPFzlblgkxz99/pOqcZ8Sf7bs0Uf118T4MGknIeK
 y/+DSTg3lL/NqzGOkObhcJ0q7lCXJHAkp/3AJz566AvGPsVfGSxvZ6a/XlmhmAQz2y377U+hNkP
 p8mxXvvt/nG9REo8G4919+sCzTHffeWVyVpCN9cLc9hjOI/FLhPVHGJKusGbm4cBLsi9S7sY+yG
 k5158wOL08KfzRKoIkOAd5ItrwbQ==
X-Google-Smtp-Source: AGHT+IEN1Qz7KbURxhtm8rIXHuAG9PraSberxx4TUTaaB2nUPUQvlU7wnWEJyBhFpCJshKyzKMVmyg==
X-Received: by 2002:a05:6808:11c4:b0:450:b3ec:c154 with SMTP id
 5614622812f47-4536e3de299mr962771b6e.25.1764764421923; 
 Wed, 03 Dec 2025 04:20:21 -0800 (PST)
Received: from [10.27.7.193] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45317113578sm7117129b6e.22.2025.12.03.04.20.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 04:20:21 -0800 (PST)
Message-ID: <e43cc268-63ee-4572-9db0-89c980576368@linaro.org>
Date: Wed, 3 Dec 2025 04:20:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Accelerators patches for 2025-12-01
To: qemu-devel@nongnu.org
References: <20251201202634.98188-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251201202634.98188-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 12/1/25 12:26, Philippe Mathieu-Daudé wrote:
> The following changes since commit 9ef49528b5286f078061b52ac41e0ca19fa10e36:
> 
>    Merge tag 'hw-misc-20251125' of https://github.com/philmd/qemu into staging (2025-11-25 14:22:39 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/accel-20251201
> 
> for you to fetch changes up to 3bee93b9abf5509f1ac25909478dd52a724bf0c3:
> 
>    accel/hvf: Fix i386 HVF compilation failures (2025-12-01 21:21:16 +0100)
> 
> Spurious checkpatch.pl warning:
> 
>    WARNING: architecture specific defines should be avoided
>    #49: FILE: accel/hvf/hvf-accel-ops.c:151:
>    +#ifdef __aarch64__
> 
> ----------------------------------------------------------------
> Accelerators patches queue
> 
> - Fix HVF/x86 build
> ----------------------------------------------------------------
> 
> Nguyen Dinh Phi (1):
>    accel/hvf: Fix i386 HVF compilation failures
> 
>   accel/hvf/hvf-accel-ops.c | 5 ++---
>   target/i386/hvf/hvf.c     | 6 ++----
>   2 files changed, 4 insertions(+), 7 deletions(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

