Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6B7C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WMM-0005Mg-LE; Mon, 28 Apr 2025 17:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WMB-0005Gt-NZ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:49:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WM8-0005V9-4f
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:49:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736c277331eso6024902b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876978; x=1746481778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J3pmFmk3j8PHRPftnP17OcPD4IwAOchVEKEZwehkyGw=;
 b=GKELGHAOmp780E7fxpIL7zdTe5D2XdSLLbjBYJOsqw01ii/2fZ88ZK+SajvTOrh2ud
 NOE9i9vE0iIu8ie8M/vRC/S+U8jSZr6/TISHT4bVl9BLpFxm2U+SYx2dtaLwOSwWCvh3
 Aq2i2RBRWKFSLHZF+l3jJQ/SAe5rHnCP7cICjhkE9pimms8YZwH69s5Vmvs0dfJNP1bb
 fDEN4O9UNDsOtCrW036yKmcLHK/H4rUPCX/Xt2KlC+2kZZF6NbsUB93r+SojnR13OREl
 hi32hqrfgFAgy1RmowNt8lGuH2lfM7fYmX3NsxR5YthDmcPFA5W+/dAqFScODSBdzYfG
 2JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876978; x=1746481778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J3pmFmk3j8PHRPftnP17OcPD4IwAOchVEKEZwehkyGw=;
 b=wrLJPbZD818zRPs4FKzpyjTl3yaYG4lskHf8rmMJ3ZQkrmVQa6ZWwi8BSJONodIj5+
 fQLgTqoB3hJ1Q+jzbyxROXrQpw6XJjHnViD0IfUwewfrz8tBWO2++Ou4J4mVw1u1z6qv
 4ZN49PC3fBjWK36Ah1+FM8tWgMhEsGS1rQ7ehhtiF3ZKJ7CMomSOVo6Ma4eqjChnFuth
 sqXX3KfFhmw1bI5HtCP1DHTvh+BvouYYGmXoKzawdBJSN5XjhyU8uzwz4+r4+LZUa3sO
 xdNhxWNLkDplgDOH7QCGb3k3Y1XRmmwJRaF7SoJXyy+QOdt0gjQz6HqHnISVWiC1K+Io
 8mRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeB/e3yemv8HyxGcQXBLNGU/hkfKYoTQxn6c/0b6tgq9G3n6y6PIy+omH+IGOSoBouvYhPpO2mVJwr@nongnu.org
X-Gm-Message-State: AOJu0Yxy6pWgCsusY3q6sLG3VabqN3hEOLWbcG4M6rx28FO3r03H7OnQ
 17tI/QlqbfIfKhoVg2JD+dyt6WECyxNW2Kyi1b5P2i7+/skQ9rsHqTH10nymvHY=
X-Gm-Gg: ASbGncsy/NVMssy/UeNVEa9/B3tfwuNvcs8Z+wb0kRSdjWkPUpTNPSS8UUiNsTUzo1p
 /cXMj6n+Nh/1T0aiwbG4Yq5yhHQy5pz7MKEoydEKw4ajxyrq/ueaIf9E2x4nPdJRD0KepzZTqJb
 ry6X0tMzjm585+a2+S9LRrp8VUCZc82yLfBfCpxZkBsuxRm58hWlP+8zvhGTYdeIDv7TIH3i3Df
 U5LsWRM5G6RX17m4D6KLl+z17K39Wlu9YTgNVLNSEZC+GymXas/a4Z5ALw1ua1EZHC2IoTHHJ4R
 qDCqF3oeygOBB4wY9KWJcfv7KQ2FFA6Y9n5pyDnT4IhvTrt0IurlMw==
X-Google-Smtp-Source: AGHT+IEOIKI62l7LTNv/DSMF6/w3zxfKBryaVwX8tJsjXz+3KZaJaFw2hLkNkQLxObO44e02DCjNVg==
X-Received: by 2002:a05:6a21:998a:b0:1f3:1ebc:ea4a with SMTP id
 adf61e73a8af0-20950f40497mr1105235637.20.1745876978556; 
 Mon, 28 Apr 2025 14:49:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a880sm8518063b3a.113.2025.04.28.14.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:49:38 -0700 (PDT)
Message-ID: <92179915-2f43-4a6c-b9dc-46f7254635a8@linaro.org>
Date: Mon, 28 Apr 2025 14:49:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] accel/tcg: Move cpu_get_tb_cpu_state to TCGCPUOps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> Move the global function name to a hook on TCGCPUOps.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 2 +-
>   include/accel/tcg/cpu-ops.h | 8 ++++++--
>   target/arm/internals.h      | 1 +
>   target/ppc/internal.h       | 2 ++
>   accel/tcg/cpu-exec.c        | 1 +
>   target/alpha/cpu.c          | 3 ++-
>   target/arm/cpu.c            | 1 +
>   target/arm/helper.c         | 2 +-
>   target/arm/tcg/cpu-v7m.c    | 1 +
>   target/avr/cpu.c            | 3 ++-
>   target/hexagon/cpu.c        | 3 ++-
>   target/hppa/cpu.c           | 3 ++-
>   target/i386/tcg/tcg-cpu.c   | 3 ++-
>   target/loongarch/cpu.c      | 3 ++-
>   target/m68k/cpu.c           | 3 ++-
>   target/microblaze/cpu.c     | 3 ++-
>   target/mips/cpu.c           | 3 ++-
>   target/openrisc/cpu.c       | 3 ++-
>   target/ppc/cpu_init.c       | 2 +-
>   target/ppc/helper_regs.c    | 3 ++-
>   target/riscv/tcg/tcg-cpu.c  | 3 ++-
>   target/rx/cpu.c             | 3 ++-
>   target/s390x/cpu.c          | 3 ++-
>   target/sh4/cpu.c            | 3 ++-
>   target/sparc/cpu.c          | 3 ++-
>   target/tricore/cpu.c        | 3 ++-
>   target/xtensa/cpu.c         | 3 ++-
>   27 files changed, 51 insertions(+), 23 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


