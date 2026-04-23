Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10F3F9937D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsgQ-0004jC-0I; Thu, 23 Apr 2026 07:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsgG-0004iw-RN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:57:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsgF-0005bg-4L
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:57:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso24512495ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776945433; x=1777550233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BItlYy4eiKi0sXPc6O/2gVgCVAt5dzwDIo9XmRZFQi8=;
 b=u9eVSztF25A9GPZwhpLNww4bFSWDv91SoSGmeUqtCACSkNIvHFeC5fUZL6yjAJ1LY8
 kFtZscSbGHDQ973MRXWgSpbMu8CtClwTQGBq5tDyfSxpwEf74mRzPzESTEJbYnMUsDcm
 Mql957hJFr3ay1hEXEEsq1oWcIDdQ7nparzd6vGLTJFOpTSAkMHSv/h7OTWpobFmAV2s
 wKzFJ+SKFFlpjXNmS8bXuTq+GYRLXOR58b+dDblWqerA/J9MyjUtZ34FujlOukstY2c6
 Ct1FZFk2lmFp/H+oDKjBgRMGrUPlp6omFKLzS4rVnQ6P1cdAFeDTM5xnI8sFUgv6a9Q8
 KWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776945433; x=1777550233;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BItlYy4eiKi0sXPc6O/2gVgCVAt5dzwDIo9XmRZFQi8=;
 b=Og3+2w3MOVUtvo3Sbw5Kqq8WvHl+dLf52yi9ZGvzbtoCn0HGELu4PRs7u50dtpL74V
 OC02FRtwnwqze1CTCmUdUqfRK3IE+1qflLTL3Q5Pkla0OAbt3TKNJRkhlDRQP0d6rdTv
 hvbffMaV1c5hqou+1YKsMLP4ScRuzNJ6pp/QwgriVDQ+s6YM6NzCp34qx0FpUfmxn0S4
 wqK9zduuRv6i1v/6HQfa5222uyg4WVq7rFOTTfkYx5dGW8IL8deNSO+gHlmE9hSBH8Tt
 8E3D0ffeJJn+1WHEp2y4UlcAEiA6mXRqqLFYOLLGWyleBG9sHbkWp8a4w2itJwB6cs9C
 PZdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cC+c0mswhDssTLJIyY3xQKZKzG9ORBJ5/ROADTWlMq6zwlX9qSbH0UxrFWbmR78vKpDQ7pSVA2tGz@nongnu.org
X-Gm-Message-State: AOJu0YwozsS/gJRnJeXosz3wgoX0Mk+tipCf26fWRPdBygp2IG8iRaSR
 fwLku/ipSTvr4Jz6k4RmvwUK9aN8ztxNPV6NTbjSv8mJ6XGZAL0U1ui73FwiU3k/feY=
X-Gm-Gg: AeBDievjuT2ufs6HSwLyWd6i9ihXPxAXIT1Ut7Wsk+XgIIbXsnJHF2RdFhgeRJcFtH1
 N98OV2KEZdxINTmHlLQ37t/Ebiwf7g5Q4x5Til9qHxfEPLFbJJD4rGFmqlZJ9V7VKcTGsBE6GzQ
 TZZ1H1JCr2ep5HAFX+uFHz7PZn1dJD389cSmMjOnww+BLSOqFJ8E4UuJSJY5dWlpbxBiWruGO4Q
 WQKPO7I6xz8qQHqsuxKfMcauBwbfCu/g6d7QteGQICR+a62uujZ7hzXLONxLYRK9QIaA35Kt4AG
 A2Z3V7Hj6VxRHNUshsFaVHV7aM9EF8L5NLhr3sUbpixNPAT85QTSrGLBH8jgXcEftq3zuFwZz4c
 xcJ6WsdnAaKuHrU+FaG4bszD6ym2RmXBQGUCEUW50dcNuz0uxgVe6wfeelRAXoUHPjRtzwwEzGj
 wyFL1MUaBA6eNiQyeA+LpvL0GJGaUSFhME8AhFI+bw/klyQtydVw==
X-Received: by 2002:a17:903:1446:b0:2b2:42b1:ad95 with SMTP id
 d9443c01a7336-2b5f9ee2835mr314616295ad.16.1776945433047; 
 Thu, 23 Apr 2026 04:57:13 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff71esm200501255ad.8.2026.04.23.04.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:57:12 -0700 (PDT)
Message-ID: <580b84b4-7ec9-4029-a9e1-8e94e4770a06@linaro.org>
Date: Thu, 23 Apr 2026 21:56:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/microblaze: Compile translate.c as common unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> In order do build translate.c as a common unit we need to
> replace:
> 
>    "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"
> 
> and:
> 
>    #include "tcg/tcg-op.h" -> #include "tcg/tcg-op-common.h"
>                            -> #include "tcg/tcg-op-mem.h"
> 
> taking care to define TCG_ADDRESS_BITS, which is fixed
> for these 32-bit targets.
> 
> Remove the now empty microblaze_ss[] source set.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 6 ++++--
>   target/microblaze/meson.build | 7 +------
>   2 files changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

