Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFBBC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmiP-0000FT-TB; Wed, 19 Aug 2026 16:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmiN-0000F5-L2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:16:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmiM-000685-5D
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:16:47 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so1275336a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787170604; x=1787775404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uciunG2uk4wn2zee2+yO10Jf8IpULjB1MXFqUIoeNLA=;
 b=nc65D4plBHGXdVoK6Xv+QVh+OrhXHqsVlaFgROCX9wwUyne5KVCi3n27VdHq9olTvz
 A6xH9mYYkb9J5uH2n+nQsUdsZPKuMiI6SFv/86MbPxI2mrhg1Tcoh8Hkaeq/zrbPzmSz
 GaiPHiW3i1Gb+s7lONK+2jZXQp5rpZ4gZosoxrC25qYEAc5m0yc08HXfYhPshx9mK87R
 FBKhCrzr3czNML6n20bePfGw3WOItglIvVbFgGrI3hpLrzVBf2ycRNCDkFY2Im5JYc+M
 OxY6OS9ISLnb7eq/52os3Lu5Cwvh2r99i1G+QjDOE+jjFBBpdUSkdqmWnnABVkZd9vtm
 15HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170604; x=1787775404;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uciunG2uk4wn2zee2+yO10Jf8IpULjB1MXFqUIoeNLA=;
 b=PWniYelvS5d0megCak4cwgOG3wn4rj+81Y3PaI8SvVPa5LiTnV0FKg8AGxxOTtXytf
 uDZ9To9/8GWSlScbU/kNWNbFTgyTk2Z1ZgG/egVCD4EQ9tvKHrlsYidkpytqdb7ZqbCY
 t2siMpR3u2HzTpMn8vAPYHLWMgZTFJik2I/4u4qH2wnzVwrdezVkG6IL8my65ZRHB81Q
 uwVY8PjxUW1Yaoqc9woKC7gpboGMAAZaRECbnfNfrJeE7LVlSwIgGQASZSIb746SVW/L
 Ig7Cju/5IK5hJXKk515GaQh117x0Vq7GLfai6mlW7FvITGR9/wIjpLDDAQvbB+yXW0nP
 Os6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsNH4GJ/CPnNHK28jjQZxK1jVPiJkRdlZTNjJIpq0fRhF272pYw2ViX+LaJ4u6wvN4NAFdc/G5qr5n@nongnu.org
X-Gm-Message-State: AFuF++nPCBFhXvZuDY1Oe42r2AOwXVUdUz6y9OEKBGlvspIfzwOv8uRt
 +KKRuQZy8ixcfDuQLhBiUMV7YFF3qGfSwVUd7spTt2cRheh+5M2v0f5iRY75Rfss4yQ=
X-Gm-Gg: AR+sD12Wbp349e3kvhbNyOVJ1IZIVVXm+MNHVAogtekzyHKLkK8EX+TstERB1g6JSH2
 CmeCusdcPEUwsig9yHb91IeOgRs37uSzW8DhozlX1UuAhv9jfQbF9ZxAIY5srrrNSIE2j9i2oOk
 EIkXqZ0Qd/WdCCTUa884cnpySw6mik2dExdFq/wgEa9xaVH0KJYXrL3BYtw8q6VlcN6y5fl/vya
 XStgUdrJVU+e7RNoJ9d5MveTph4PqjnLJWj8yiPuDeVeD0XOsPmyBNH6t7/I3lbH4If9MgQwXJq
 +QOhJXY8+uTw8Ltbm8fhJh/6D6hzWTj94iQaxVirdmT+Cg0d6LQHQD+QX+1j+htNHNJ7pdaI6VK
 EtbaGYyeLqjU3/sW0E2KrC1V+W9e9mNHE/q8F7W9CxixOk+s9TiA4INWM0x3Mms2MNeaocne0P7
 +Xqr02xOGexcC4wZstsXE2iE/64r2owR++fnjuuIBfBjNw6UloBImsDSE0NeQLVz838ER5xjvyH
 9H/cFKg
X-Received: by 2002:a17:90a:da90:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-39580a91ae0mr14280234a91.1.1787170604223; 
 Wed, 19 Aug 2026 13:16:44 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f9ab4b4sm3735705a91.8.2026.08.19.13.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:16:43 -0700 (PDT)
Message-ID: <bcd6a816-2038-49ea-bd92-59f285fb3852@linaro.org>
Date: Wed, 19 Aug 2026 13:16:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/i386: Extract async event processing out of
 x86_cpu_exec_halt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-9-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> Refactor the target-specific async event processing logic (APIC
> polling) into a separate x86_cpu_process_async_events() function.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/i386/tcg/helper-tcg.h        |  1 +
>   target/i386/tcg/system/seg_helper.c | 11 +++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

