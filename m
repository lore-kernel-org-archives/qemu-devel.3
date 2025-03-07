Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611D7C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd8o-0001P0-BQ; Fri, 07 Mar 2025 14:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8M-0001Cg-EX
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:27 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8K-0006BU-Ec
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:22 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff65d88103so3428428a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374799; x=1741979599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5YwjXcgY6sAym6gPXFANSQnsZqOBmAQhvHkXhjeqaI8=;
 b=Jf21BvTxZXIfiYZgVrwcE5wyMEnek9k0h7PeZuNW86LGCzVJrvqbanGFj9IAmT02A4
 MYBHTDgvZL5SiD4mJGMajNnzFbd06htdd/NKOtXQwg6HhggtnNkRkuqMcfq64F1hKrJ7
 QrHXOw6E47seQrliBK22rSqQH45giR4454ONPBLv/cg4J8GQnOFbWr3ZLpZ2h25HGGNq
 1Dd5rMn1+Ijy1UjfHEi2NsK/mLZJcTOrqOLNUXS4c/xHVGBF/HS2Ts4e/jgrhTlV/3Ij
 a7NxIv3jaWhDqTXCnxGPRLbzM3eIgXec0IqHffiKkrMw9LkJpo2ZGRId9Hq5x9YcBSab
 XV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374799; x=1741979599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5YwjXcgY6sAym6gPXFANSQnsZqOBmAQhvHkXhjeqaI8=;
 b=BeOPuEkFNPjm3BTVUWzVC7EwWfDDuyKhTPY51Z8OprJgxxzBKIYaXQcYpvNSY/rhrM
 Z1+Ymn0FPbDM/RopgnqohjVfDxHF2a56DTaCR16yzdYc66aN2GBEl93/Rtt4oiIpPGxL
 s55QwYB8i9zZNxsymOSr+DeU+owDeAZ7erJakdfIoU3fdpQYZj/48UWAzpLh8/0mL8Qs
 opyG7JB3iNczGzuY8MGTbAQ9err5i9uhG/Nogey0Exc4q1AWNV0htLKaD8Dm3ttadoGn
 6l6dt5bsN75eFSsOIdCDjhghBjHGIWFfYQdAd2jaYyXzPknkBiu+uqN+4Bay6N0qtzAO
 kaeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfpbEnl9mqkcmHwfSJ1fIZ+DtKyOebB6c+61FYvO8mUNZ9IkJaV7J4J1u3WSSviaVLzjzofegL7xzO@nongnu.org
X-Gm-Message-State: AOJu0Yy1FEdabAZ3KKdbuIKGxGLuOJj33A6fC2rE2UQzlO2KeWNQP9KG
 fFCawN6/oqJOD2hPoHPybE0y4hcqlDR1rQ64vnkBqjCY26IcXfsssLlCcoZPcJI=
X-Gm-Gg: ASbGncvlgZvUwyTt3oThGxA6yIA/QQ6070s6mkiThk8Svta/v9lFVRqNKh9S6rzOApM
 Zn/hrJBKhEGo4ioYeZtaYk7g7jSInPJdf21/jLZxa6tuzkG433NCPDrnqIlOgKcUBBj+EcMQpkP
 oWuide5IKNpx+qfodndoo8glEFEkeUPfLb/Mpm0VubMOUrbLkfcguGCgMv36gr/flxFk+ZHRHxa
 njfWEmwQuDH7K3Fw7DWIdBEKD1tKRLj/6nTzXMNiO/BjD3+kVIYj/SCfJSm54xIEg70/bGSJkFd
 JMJLEihbjRiekFKG5+ZUpY1nJR3nSjGDhJ6xOdX/xgLrQCNa4TIy8MBiRA==
X-Google-Smtp-Source: AGHT+IFu7dHHLzndMVyVATE6sby1/k1RtgdVJlgOf/tp+yWA7f3/Ij8nS4QmmYOpX+9mT+Q9x4xFvA==
X-Received: by 2002:a17:90b:164f:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-2ff7cf13a9cmr8289201a91.33.1741374798919; 
 Fri, 07 Mar 2025 11:13:18 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109dd5edsm33923785ad.37.2025.03.07.11.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:13:18 -0800 (PST)
Message-ID: <f4542962-77e4-4f29-bbdd-aad6c95e46b1@linaro.org>
Date: Fri, 7 Mar 2025 11:13:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] accel/tcg: Build tcg-accel-ops-rr.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> All that is required is to use cpu-common.h instead of exec-all.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 2 +-
>   accel/tcg/meson.build        | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 028b385af9..f62cf24e1d 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -31,7 +31,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/notify.h"
>   #include "qemu/guest-random.h"
> -#include "exec/exec-all.h"
> +#include "exec/cpu-common.h"
>   #include "tcg/startup.h"
>   #include "tcg-accel-ops.h"
>   #include "tcg-accel-ops-rr.h"
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 891b724eb6..87c1394b62 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -21,7 +21,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'cputlb.c',
>     'tcg-accel-ops-mttcg.c',
> -  'tcg-accel-ops-rr.c',
>   ))
>   
>   system_ss.add(when: ['CONFIG_TCG'], if_true: files(
> @@ -29,5 +28,6 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>     'monitor.c',
>     'tcg-accel-ops.c',
>     'tcg-accel-ops-icount.c',
> +  'tcg-accel-ops-rr.c',
>     'watchpoint.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


