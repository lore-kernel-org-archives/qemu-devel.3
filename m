Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E160FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbZf-0007cJ-1w; Tue, 28 Apr 2026 02:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbZa-0007Wz-On
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:05:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbZZ-0006hx-8G
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:05:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so75468825e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356327; x=1777961127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6dtYK/6yKO/129p9+Qv/iJGnnfRj+4f5l+VOq2cO9PA=;
 b=ojNVs06hp2AWefcfuwDgE8dNAo8BZzeVOwvSnRE89Rqlki4C1BZ5Z7sRjZ1Xj2So/U
 qrgMykgc4/JacfnuieJ3ZPHRCiHwC0lLU401REzwztJ3Mx+3p2dWaD0pcNj8y3zj6WNO
 kk03QyufdAWDUlmw7x05krCZk28F7zaRcVMunIsStz6xxdhKsSGazGf2HTaihNYZeW/u
 WLu0fZpgMMO0WdVFKquY1sFe7ynDXqo6gP6ZBboXcjJUxOqk8XAiMGM09DRCMhZDzCb+
 7aIhZXmUZub05rf2JYDR5roFzautWfkaINN5ex6b99nmgO5iaf/Yzr6WWH/l5H+A9X3U
 dowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356327; x=1777961127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6dtYK/6yKO/129p9+Qv/iJGnnfRj+4f5l+VOq2cO9PA=;
 b=EzJ2s6H6ORkNpO/xZTxmdFqeeT4iTUKeW3C0Bfd7DBDXOktElvvejISbGLkdYcXO0Z
 oUFYg2p6+60gldpQbgVZP5D3/htcE4biutgA7BTGR9Sv4QjRXp7Bdcysc74+V1Vv5Yah
 lK4pGOjPkBpcq9opd+aOzzHHslonyRlO2xEAqnpbbKLKB6IATvZ/zl8/Mv3Zydwc1s/2
 B3opnCh8C8Zeiz3V2huN77QpnYwKFBzxHyZGa19DV/ZK8tiwiQY5hz8VVNSHJKXFyGrX
 eC3/cITCAsU3r7qjB60VCQKgcGEyg28wiyJH/n171ScsTOGE3RoOrToVneqB9m5seo1/
 pLTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TY0Z0FGiGYcCW3itwvOBImkOGG00LhyNSa1f2ZCSLGVe05nwqGRLjCjgkKpsBzsGctvVyO5uZjB+y@nongnu.org
X-Gm-Message-State: AOJu0YzGTaDTP0xDhK4fAxuN5HegVcgCnGzlcYnxHQ/nVIcXSx0xh436
 i1TotW1YlJ8qMR1UAXWVpfWh1lQdnDD0GX+eZbBTDfZDDSzZm/SaqKHvz03/yhBBMAo=
X-Gm-Gg: AeBDietYVqcSv1dJDkc6BQP+f2yDLy/CEGo7YeWrl5KF+ON2Bi5nOnqg+SjKaQxb/uP
 gSMyGfsMHL5EYjR5ko8C8aZpD751QbEp/hzYghPytqBeAKo7zjO1GSOiiUVUBQn5TGO9VDarJr0
 AYKy3DJtHEPXGKSsZXUQksi8HkToof2ouS6Qz8Bc2ovQlZACjzPp9+aUe/t4IRFyu0/qRl0/Xko
 iwhfjEIQYPGezv2To9wrBU9tml8LAJB10q6EoJ4cRHO/CUlVspz+P+QHfvBGSAnojiqu0nxAnuz
 XnR05AQE/Q7iwnb+dxSkBzInVXvdi3p281OXnBCtZ3XmDxG9SbsTq3ntuY69VQaqrEUmDQkpv4s
 bOdrL5X0RYtT00NOPbheof3d/jahq1NkNYu69HM6MUCdbnFWcpq611CxIWpgN/IlFcraCvuTIwf
 L+fyuslgtEr/bztYBYbxbXByMeXx/dHOP8FfD8sxsZMK2dMAmDe7ObgZvrTmvKcC4XwUi3z3O7R
 ecf
X-Received: by 2002:a05:600c:4593:b0:48a:599a:36fe with SMTP id
 5b1f17b1804b1-48a77b1d78cmr24260765e9.24.1777356327039; 
 Mon, 27 Apr 2026 23:05:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77af1bacsm27777695e9.4.2026.04.27.23.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:05:26 -0700 (PDT)
Message-ID: <2912ab24-2c53-4c52-ae17-9bca6433462e@linaro.org>
Date: Tue, 28 Apr 2026 08:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 76/84] fpu: Export parts{64,128}_compare
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-77-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-77-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> At the same time, constify the inputs.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h | 5 +++++
>   fpu/softfloat-parts.c.inc     | 4 ++--
>   2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

