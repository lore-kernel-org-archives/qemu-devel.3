Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3488E93812
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8b0-00057v-Gu; Mon, 13 Apr 2026 00:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8ay-00057h-UM
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:08:20 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8ax-00047O-9w
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:08:20 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso2076718a91.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776053297; x=1776658097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pMWuXaOCDgaktubQ/BjKCHRzFkRI/VFOrGVtOg2sgUM=;
 b=HGAmWlCbXiB1ehKZGr827GXxbAd+M24BjsCIKikoii6i8mBG8Hm4XwIfPngm3vTM9D
 qNx+2jBVL3pBwLgs6LrcXbc+0/LggSdAM2yzOAykUMUGzGLaDMyWcWg6CZfT80bylDNN
 YqGSIoruoxfevtV0FlkrXQvakVxC3we3VkTYgEqSBeBFufyP7pCrW5Y3Uu2ffFJPMfJo
 3GMzeJy60mrmfiprM3BrF/tXJr65ZtHqVNeYm4dmJ4Ne1xUNDOazQAe6odCF0/2Rx1q+
 J885YZZN84A3fI44rpw8zT3JHRfbn2mm8fYYCe96DYRCF6MXB0OrVKReDA4lSonFCgxd
 24xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776053297; x=1776658097;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pMWuXaOCDgaktubQ/BjKCHRzFkRI/VFOrGVtOg2sgUM=;
 b=VfuHI0typ7ZFhgiSToCNFOo3warkCnW54lLJlIo9Lg1gssMpjs14spxSblcBTcOrHK
 VGXHyxf3pMnpMH5rJGWbdav2qR87abLKSkrjz0nH5CO0B/lKENYdDWvmdYbrcHn0niIA
 7tk/oE4y14qh9NtP9FpcAyGiYwoWRS5dA6TRu0Zi69Zuu8aEA3NvlIrrgeIy8xFrzTAi
 qOtecnn/74CNiGBGWip68PTgmT9vzwJ4STKTIPPaEr5DmTxguJ3dXN/w7pjXQsYJLsfZ
 v7hPO70ZK1fSnPvFCz5weUJwQxJpaPcCi53OaLfUMhwNw+9yAIG+dzbLX6yN/pxS1Zd9
 Xh9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zdzaHiw1XOvHipPOP8SV9YTBX5v8TOlgWg6O0/BV/TC3oPQQGMpZRe5Y1wFLrJt3Wy1CyItsKDAgh@nongnu.org
X-Gm-Message-State: AOJu0YwS21gpEn08zcxroKQy6JzIccoWDh32VFtnCeRSJhELwgYZ/2Qd
 u+6kwFz17JP4HRbAggBpvFoMwrLn+CCRfEWgQK1a3uSYUi0TijtpnYI5k9Xc6SOEBF8=
X-Gm-Gg: AeBDietBcSucFStFpSNZBnOq9gUsqeQo2O91tFA4Fg3YhjNjYxblupLWf+pVY3GGq3U
 DXC/OMRijEcdukS6WYKEmjVMRpxD5HYaxeulwpPek25SQdlOLAqCnDfeK6L48KaEGef8BrF7DdY
 hqppwUm/YdJ25jnu1+/fx5NTiQbPhGchqwUF0AcjuEEmApQ9BSAHNPuNwXWOybpqET8GUx4WmfH
 IWp7lewc/5QcqpoaLLl75QeqIAwrj7YJfy/2fppY9ClmzWaXwnea7px9MZtpeudH8uJ83LB5dok
 c5CvWK0wDv2VwbkFtlS6GhhNOa493AEIrTRHAiJH70KzU7m1AMGKfzRixBJe9tM5Nak7m36OZZv
 Zmk7r+tnW29kXrIOAyzJiI0OQHgvcY2c/97hzJhjNXRg9x6SOIF7TFB3vrMh4ISYcMjD5tYrIpT
 neb+bGXK7ieyYGqtqfmFL7U0fsfJrVsbFxahrvh+L4ekNB6JZs9xn+Xjy7Eq637qVEAx8uz4w87
 iML1UNiR8zvJMNomdRQMFKsQNU71QUy/dr3UXnfI0RN+2YcD+FP8Bs=
X-Received: by 2002:a17:90b:48cf:b0:35b:91e1:e110 with SMTP id
 98e67ed59e1d1-35e4285b82cmr10040804a91.20.1776053297266; 
 Sun, 12 Apr 2026 21:08:17 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm10700270a91.8.2026.04.12.21.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:08:16 -0700 (PDT)
Message-ID: <26f04bff-0e23-4ff7-b68a-531850e4861f@linaro.org>
Date: Mon, 13 Apr 2026 14:08:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/27] monitor: Remove target_monitor_defs()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> target_monitor_defs() is now only a dead stub. Remove as pointless.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/monitor/hmp.h       | 1 -
>   monitor/hmp.c               | 2 +-
>   stubs/target-monitor-defs.c | 7 -------
>   stubs/meson.build           | 1 -
>   4 files changed, 1 insertion(+), 10 deletions(-)
>   delete mode 100644 stubs/target-monitor-defs.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

