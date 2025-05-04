Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD9FC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc4X-0006eO-TR; Sun, 04 May 2025 12:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc4T-0006dt-KQ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:20:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc4R-0007KQ-97
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:20:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso3539285b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375601; x=1746980401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d2Hc1aYlN3sH+w/KQ6W1vC/R4sisfIS2DRgT7jxOlPs=;
 b=rpnbYqNpKUAhX2u8THpI5sgxSNOonTiO7vyF6TJuiEpz+Zc0q/QGfIE3Kg9+R8rrOD
 7xGU0YSgq6PGcUYSSfc60vY9FnXC0c/VOcTN4+r4/FBBNRX6FBDe1PSXSIOHX21zi0r+
 0+oPuEYaPEW9vWWqKpHwplrhtVLTvfRByEZBbUg4scHpsUtrHZ+/3V7pKUaocp0r4MAy
 i8/aPMGfmkiDGov1bcuEQGBJjpdlVNM17E5vAvncuRFRb24QvUi6+FqOqR0UEe/sjA1L
 SkEoOJFGsgDPCRmoBEebaGdIsevWdJoHGDFDtcHvW0LzinllJ8p+FFhnPy7ONAvCZXns
 h8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375601; x=1746980401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d2Hc1aYlN3sH+w/KQ6W1vC/R4sisfIS2DRgT7jxOlPs=;
 b=SsbMVAyO07bxlCNstrfRKfamPaICkavBUsjNEaI31CScYt7kZw7bj1M9sAeyp48/3S
 SEYZr6dFOjF6tMo8DKMLPFlAXmGgOmfYyC+yYgDpD7oS0TftBCDelkeKuMT6AILGOj+C
 egvNr5jFmC+8QyY7g5hlhOC9m6GPWRBhmdV7HCZdIIOkX1pZ8BzyYlmq/uG4sqesuQve
 fwDWQ5ZDPupRkSj+MoIBVRggRk/hNCDV8r51rBBUmPKT8ywCzwiH3dK7I6xzE2Y8LpaL
 1Uy+CKHREwJnu66a0evuLQVmOWv+KWtOKksQLT5LWKrlEVrQG1dqLXhHVk4V/t2qeJYa
 9sZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7E3TgQjqhgD/W5fgWxmSrvS8b5eW7WNZJBf6kuaR3KhyTF7T8jU9/7weuDCBzpt05aaA9eX09xOhb@nongnu.org
X-Gm-Message-State: AOJu0YyP+IS60Ib4QMsn/ZlgYznTGnlDnIr5e6J5U6zNaQUUtqtSm9z+
 1hwTe+eSpbgqdCxusXFoA1CC3UpVd3S/Xwmzt1H28q5ceLoCg7RzMbdipDACiLo=
X-Gm-Gg: ASbGncsTFcJfQxDQUYISv5P84j2dNpdfDjCW/QyHje6uNBo+suKfop21puovEuYnQx7
 ZYacy8jWYzwB+/6g89Ym9QpDLEhDNVmXT9OVQGG1kSSYqe3yfnZ0t1+FX1oeKmg5xJ/Eb54Rcwo
 p/1vmrAg5lJihUhtteYGxwvrvwqv0EpE6ddPi7t1BEfzdVv7cs9WEAT0EykfJizz2tLiUNvhnAi
 IUeJ+WbJE1gNaR4YeBhpvGLfB8gqAaBGsrC9DOIC0z8oO4Jc7iLgwX0OUSi+4R9dnaGedjSMLfX
 DxV1RMMM0Q21ejRI1Pn6vAJXzaWYYpb9QCoOSJFn9GKXiISxIRxD+U20R8RtFUkx2KyD/Hnytac
 t7YKal+Y=
X-Google-Smtp-Source: AGHT+IHIBLfV45U1Fxt55q+aN+vYiuzFSgze79vYczsauOFmX5DbM62CozFoJkq+QpGbV7cyZ3DwKQ==
X-Received: by 2002:a05:6a20:9f4d:b0:1f5:7eb5:72dc with SMTP id
 adf61e73a8af0-20e96205abbmr6336314637.3.1746375601253; 
 Sun, 04 May 2025 09:20:01 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3924dd2sm4005686a12.14.2025.05.04.09.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:20:00 -0700 (PDT)
Message-ID: <a1555cc8-901b-425d-bf02-030a86aedb83@linaro.org>
Date: Sun, 4 May 2025 09:19:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 36/40] target/arm/machine: reduce migration include to
 avoid target specific definitions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-37-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-37-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/3/25 22:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 978249fb71b..f7956898fa1 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -6,7 +6,8 @@
>   #include "kvm_arm.h"
>   #include "internals.h"
>   #include "cpu-features.h"
> -#include "migration/cpu.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/vmstate.h"
>   #include "target/arm/gtimer.h"
>   
>   static bool vfp_needed(void *opaque)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

