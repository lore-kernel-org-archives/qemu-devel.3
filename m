Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4769CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1Kg-0005vW-SQ; Mon, 17 Nov 2025 10:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL1KM-0005n6-HN
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:39:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL1KI-0005iZ-BP
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:39:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so20344955e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763393971; x=1763998771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4z1jh/Ha3QCCNXYfp7y5UhFkZykJVLI4/OdNGSZZcuU=;
 b=vuXrAK8PwRAUYr+MbpHbgXRkmg0TPfv4D7FNG8It3Pm5by1RI3LbCArP6mft7aIod3
 67g3GyF7NOOry8BMTD+nR8REc+f6X8N2JYUxYBs/5BPAgarc+JD+vGSFMf2uvgew9mL5
 Qo5Ua0F6K+8EFOgW0Si020+6JasrYbeT7YEHmLZpEz3NVz8K4Qax5+pjcJXk8jl26f3D
 gsJ2uoHy7nimQE+5PINbJKsyWtJBTmGv94dGkZKGGXoW+zhU7mF2d4+C6Xd83Tgn7+pP
 L6nT9kVDEC47V9J2H0JvTrVM2eHDVapVOAWVU6hmAbtArgnp+uVAWNj7ontGvG7TFSCO
 nKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763393971; x=1763998771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4z1jh/Ha3QCCNXYfp7y5UhFkZykJVLI4/OdNGSZZcuU=;
 b=Q6IFhqppwa8I0jKqeC46UimoWUN1AUK5utJ6otjtCDaTKyebUrMe8bq8hC9gpu1qpi
 jvVAzv686z3F40MguHCRVIxkxrAYAFhrJ/3T75F2jSFOlok1OeioMitOs+BkYLZ6+Htn
 cyrdacGc/5JdZcNIdRO27+PYWySTpl2o8hguCG25+E5vKW6wPsJL3G0OVvfPT3/azSS7
 rBeH4CBbKMfN6W+4HQFhE76OMDF8LtkbRHgJT++awcdVMgNyTXMj0tPZfbk3j3diuugc
 T4czp7KTuNxCbNudLADLPtvQG7lmsL0kBSzzgDKPF45V2Wo3zqLX5yJ2FWLmUEt3JFne
 Zoqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgaR8LQOZM5m9i6pHiqKQq4FvRhkKiBBkNW0iEGIkBpoveJTenvpIrCJSxl3vCVya17CAqAHuL0+Wq@nongnu.org
X-Gm-Message-State: AOJu0YzGpjKBcamtoJv2J6cFSGk9R7jidNN++xylotOVg9Mq5ItH6sZk
 sbr/q3M20vNwNm3kGeh1aWj9U87C1THUSRyw0S3Pysyi6Smbs1GF/lPUOA5lPSmORrQ=
X-Gm-Gg: ASbGnctMrmKcr1VcmOwK1aCPOrLZ7hyjFzQMoAn61kkJwfjZMo6d9Msy2BC6CG8gcDh
 EZODjmEBI4O/a7Dy0Y90F6K9TgJzkFoxRhVtnaPp1nfvolf5IBhag7ynWvdzwO+u4n88JL10Wi7
 4xofSv9IiJDMqCkZo+uuEvwts9D1OxxpchN9jrFHq8WRigU3ALTScM14rbd+qdex/MXslngHlwD
 zrGjI46n8V+UvkxJIJVrtU15KptQ2i1ZZ4nG9aLVT3LY38qNhIZbrgFkeynQtb2XzjKYFI1AVpu
 3KN/37vcuqDEL+63uZv0FdVSXoVFQRgCF/j48hR50dJGs5UVgPl793OzfqVN6y1c2LS8nIDGAch
 GmVfZTLoMdANDKkU0iYtrjzWCo8j8Jq60jLwG3HUWJL37s/sTreZSPIxngM1lN+V9WcFLhdtsEv
 f/5/XtRI1cZAJPHO50Q5LU5NRugPcgVZk7XsUq+k7a4IblH5l2JvqIQb+ll0AQT9sU9AXMIYo=
X-Google-Smtp-Source: AGHT+IHOQf2Nme0A5MkSLy70RjfLQDNh69L8xkTQCcbQ0oQdMUBrOe1V+OZ9HnXjAKsvbAkdmV7oow==
X-Received: by 2002:a05:600c:c177:b0:477:429b:3b93 with SMTP id
 5b1f17b1804b1-4778fe63008mr131753845e9.18.1763393971443; 
 Mon, 17 Nov 2025 07:39:31 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779b509a5esm135298885e9.2.2025.11.17.07.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 07:39:31 -0800 (PST)
Message-ID: <22652ca4-0650-4ff4-ad55-4ad10e668bfb@linaro.org>
Date: Mon, 17 Nov 2025 16:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/10] tests/tcg: added test for MTE write-only
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-5-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-5-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> This test cannot be run in user-mode because the control bit that
> enables this feature is only writable at EL1.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   tests/tcg/aarch64/Makefile.target |  2 +-
>   tests/tcg/aarch64/mte-10.c        | 55 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index b491cfb5e1..6203ac9b51 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -64,7 +64,7 @@ AARCH64_TESTS += bti-2
>   
>   # MTE Tests
>   ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
> -AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9
> +AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9 mte-10
>   mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
>   endif
>   
> diff --git a/tests/tcg/aarch64/mte-10.c b/tests/tcg/aarch64/mte-10.c
> new file mode 100644
> index 0000000000..0fa3f97e1d
> --- /dev/null
> +++ b/tests/tcg/aarch64/mte-10.c
> @@ -0,0 +1,55 @@
> +/*
> + * Memory tagging, write-only tag checking
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "mte.h"
> +
> +void pass(int sig, siginfo_t *info, void *uc)
> +{
> +    exit(0);
> +}
> +
> +int main(int ac, char **av)
> +{
> +    struct sigaction sa;
> +    int *p0, *p1, *p2;
> +    long excl = 1;
> +
> +    /*
> +     * NOTE FOR REVIEWERS: to run this test locally, I modified
> +     * enable_mte to also activate write-only tag checking by writing
> +     * to ID_AA64PFR2_EL1. I am not sure how to modify the test so that
> +     * it works without that modification. Input appreciated.
> +     */
> +    enable_mte(PR_MTE_TCF_SYNC);

You must

(1) Delay the patch adding the test case until after FEAT_MTE_STORE_ONLY is enabled 
(currently patch 10)

(2) Implement support for PR_MTE_STORE_ONLY in linux-user/.


r~

