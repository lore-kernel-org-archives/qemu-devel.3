Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A25C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfOZ-0002Wd-Qo; Fri, 21 Mar 2025 12:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfO8-0002Os-PK
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:38:32 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfO6-0005Dr-Sp
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:38:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301493f45aeso3707113a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742575105; x=1743179905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Po+8A7oIRxr9NXsNwzfrLWOQZJ6V+4VHyvpZcXsIsSY=;
 b=jVknu30/EP9/uRGPQ8aluZ6ChzMVlw6Xga0S0g24ZpwRCXHXjwGxhq6xiN6lRKpC0H
 tGKk9/5+7mHCrvT9A0U7+7l5ul7/wW3VRjwGCsztNr3mNZswaE0FgwLg4aDlshfO95fj
 BS/Pnvlkfq+J8HSis8ROXDpeFeudkczI9zT0xpitAgEHQUJ5b0lJY1VGtWfOl/tA+DaJ
 8jTQe+r4XqNaZCmbiYimws6zOYgotL/Jg2YPmWLkgY0AgOhgFrWT6FV0JS+Xr++hVlXz
 vv70UNC178eul/g06yhvTmq0zojP7gFGQUI7EZtGIQfYSc99gHUbDA9IyRTnxnIl0waq
 4N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742575105; x=1743179905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Po+8A7oIRxr9NXsNwzfrLWOQZJ6V+4VHyvpZcXsIsSY=;
 b=EWzDJ8/whhp1wDXyAcoVxV+TRLjNFl3Uz8RJaCeXSX6sy4BhU635mNsz19nuhnRraO
 WrmRes+L6ZUclDp9lfFH+Kf+WOMH5PHN+SMgmzah05Y0jd84e+quIIKh0875TbLJagh3
 Sq8K4FiZ0JCO+0pHLJJPxMqSIk99ELZ71fZnwWjoEkWxTUgQkDJt4iR6c6VJH2netxhf
 /tT88FgFiEjOwAR7IxKpP7jda/46chsfoM5n/wETRROmLTrQwCN3vAmsvr+jWZrEdnGe
 NRHk+oGeoyMI36oLU8Ye0NpP73+S+hCptRfo0v4juuPymmxxCIIsG8U2SJBHHyTSMV3H
 vgCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd5mVY7DHo1bFMJaJaHmMh1jZXdj+TD05m2HbiSjTSk/ZLBLqU9K+ciaVOnj0Hc14u4WEGqzfOWEi4@nongnu.org
X-Gm-Message-State: AOJu0YwxhXTmEJNdt1fH7LttmFIgcoPdxhJG+sljZd0YWZe+5SqI6UkM
 5GawT+yyO8jeJ3wpmuA9O0+eTQ51XxR66suPg7uUwAdpC+XGn+3TzSVGBcICaTw=
X-Gm-Gg: ASbGncunvcT4T0aII2ZqjAi/tfrNi6fuJWTAedYwkQpHIAKcSh7loH9/DfAq8ktda4v
 1rGuMBNE7DHGWWv+i0+EP2rPiHBWRrzQfgKkO3wXQgpUzpvHlmoAaS6tRp4D+Fxe5OQwqDxSP3x
 twM9079STQuIPV4bpqxabosrPQiVJG+Ya2jYSOaQsP5OkvL7KXactFq9J54bck6+wIIgsIbSU+N
 dh3HEGgB3wnJ4Zp4t0GQhZNZpDp1j7iAKazA/asDGcr67T4u7VBfKSrhhTBeK9rzAHY3dvTtJhB
 +99tq0MYUVmWW+JWBCnIe/AVu3TVMDxoHQwTW8ber76wE+wndDK82/uAWN2CUXp6dZMDUCiPtAA
 O9rNUbXV4eDaj38UXZOc=
X-Google-Smtp-Source: AGHT+IHD+Sw1ed5DoL405gur8EOIIjes7eESLfyzMPwXXFmmPARwBWAqgfR5qqpOR1G7ogBZyIjHAg==
X-Received: by 2002:a17:90b:4c4a:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-3030ff21efdmr7057846a91.33.1742575105064; 
 Fri, 21 Mar 2025 09:38:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf61a44csm6295878a91.37.2025.03.21.09.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:38:24 -0700 (PDT)
Message-ID: <be360a66-fcb6-401b-911c-871601e7c726@linaro.org>
Date: Fri, 21 Mar 2025 09:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/30] exec/cpu-all: remove exec/cpu-interrupt include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h  | 1 -
>   target/alpha/cpu.h      | 1 +
>   target/arm/cpu.h        | 1 +
>   target/avr/cpu.h        | 1 +
>   target/hppa/cpu.h       | 1 +
>   target/i386/cpu.h       | 1 +
>   target/loongarch/cpu.h  | 1 +
>   target/m68k/cpu.h       | 1 +
>   target/microblaze/cpu.h | 1 +
>   target/mips/cpu.h       | 1 +
>   target/openrisc/cpu.h   | 1 +
>   target/ppc/cpu.h        | 1 +
>   target/riscv/cpu.h      | 1 +
>   target/rx/cpu.h         | 1 +
>   target/s390x/cpu.h      | 1 +
>   target/sh4/cpu.h        | 1 +
>   target/sparc/cpu.h      | 1 +
>   target/xtensa/cpu.h     | 1 +
>   accel/tcg/cpu-exec.c    | 1 +
>   hw/alpha/typhoon.c      | 1 +
>   hw/m68k/next-cube.c     | 1 +
>   hw/ppc/ppc.c            | 1 +
>   hw/xtensa/pic_cpu.c     | 1 +
>   23 files changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

