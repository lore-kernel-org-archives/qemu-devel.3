Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3027EBFD0F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCOx-0001WO-NB; Mon, 13 Apr 2026 04:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCOo-0001Tg-98
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:12:04 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCOm-0008Op-LV
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:12:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c76af79f029so1524749a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776067919; x=1776672719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEW7PdgTOO1NaZPhOLA6n9gy2xIVpIHD1uyDHA5JILc=;
 b=dOOop02vIzVSDW+ofmmyn/qL6VByv30B7rotKRD4fcGViIOs4H99WyhpGH7i0tq7Nh
 gGamZjNMGV4SeZpPOgekq+QSD/6jqZnpuWsKV28MGUu8jIdeYO6QeTByLfBqVlOSSz7p
 fVBLtVN+UiWD0V6TpwJiuPc86nWUbIiWMF2iZKoCngw0ZFEZ0JNRWcmPgIz7sU5gB1aX
 x4alWtJqWTL65TmixSMX2Jrn1lB3KR/WWRtyuvMQQyZEg/GmzcxV5fGQc7Mwhld81Yae
 OSPHjYpkjEkmWIjOvrt9Gq4EH0Mjegk/5he3fhY2EYhFrfvnMfRzR/6b73fxP+RwjX7F
 mrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776067919; x=1776672719;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LEW7PdgTOO1NaZPhOLA6n9gy2xIVpIHD1uyDHA5JILc=;
 b=tZY9j96t6UgOkP0mdBk4Cgj78WXf7TY4Az1sw1ElzRafRbsjZdj2+FkkmrjE41sYkr
 LPT2AglpDXIg+gfXG5R3p4L9g0zrbsm4jk/Bh6DT1JiZ7WJHuBbTZTk+zPofW3jnH/T9
 1FlJprhTZ9SqncO51Li1GJy+C4MyNGpjMhKnsuOGxPPuw9qRf4gSy5ZOXZGkKp1H7uf6
 hoKrldJx+6QQ/iOyKonhunRKEc93ifkuu7evWlG4CFEjQne3rByZueeczxC8qEMkEqJY
 B8WG96yaoXjrjjjPj9wUVG/tJK4igC70SgDBlwWQ8xH9eplyGeX51R2/8Xn8Yaa8JzmR
 91sA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xMQBRZ9eojkj/+RtxLjrURKom0MZIiJdYvIY1mT6+OVu9/LWeOoGLuH4jociWPfG3qbP6CWE/lA2b@nongnu.org
X-Gm-Message-State: AOJu0YyGA4Geer7531CLu7W7DjCoBuPvBQRIStzRx5RQqNvINMTdeYet
 2eBa17RIJTRYId/jt4ra5aJsV/umlCRyabtflUDA4U8e/O6UaubrMrXkpooyUxWsrAU=
X-Gm-Gg: AeBDiestXDX8f8If4Hgbh2K/J64Iy3nyYu84IJCnShMCAOh7NuzhUAasUzXDjqsCCHL
 7qVwQOKn39V1lfbpWSa8UUt9Tt+qqLzYKo5r+PwlqkBnDm4XFcdlnxv+28nEXAURpBPhfH3GRrv
 S/CKph0aiw8h+ZEKX4gqXxrnwK5Df1mqk9gcDooiUUGw05swgrhd6pVtF7iYajW8VMPrDjQQKeg
 6EvF/qwsyzjxNzkdBZj2LlVlL7RsQom/wMb7VIVN7jTatJvHwGejwqgrLupFcjN1MXhBjvPetPq
 rKKJdHcZSr20pRtfqYndmmVelKH0Xdqf7YZyz9Vaok5o5AS5hFuWPd0mLnp7vBmyl7ooxhi/myG
 fUgwGAYPUi+cby7Pz8NPr9blKDWHejTbE5yXkkf0OX42eXz88BtV4rpsY00KHR9pelRz5CgcxtB
 3/Hyj/AH1z5yDjXjgVOTHtHGv2xNi16s4WERS5ZCO3hq0lc72W4QxrqSTG7Pxf7jyZG0lskVxRF
 gTUb3LjicUSJ4ZhvfYtdVVB1iA5Zz5Bp5eMhPAOKcNe9NP9vHRZUp4=
X-Received: by 2002:a17:903:3dce:b0:2ae:57e6:616c with SMTP id
 d9443c01a7336-2b2d591af89mr98255715ad.3.1776067918816; 
 Mon, 13 Apr 2026 01:11:58 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4625dbf65sm15654215ad.4.2026.04.13.01.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:11:57 -0700 (PDT)
Message-ID: <8b430651-55e1-4a8b-b76f-d846a11b1f2b@linaro.org>
Date: Mon, 13 Apr 2026 18:11:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/27] monitor: Do not check multiple TARGET_* to build
 'info tlb' command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-27-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-27-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
> This command is filtered at build-time for a selection of binaries.
> By using the recently introducedHMPCommand::arch_bitmask flag we
> can filter them at runtime, making it possible to compile
> hmp-commands-info.hx once.
> 
> Since the method depends on a pair of distinct targets,
> define it in its own stub file.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   stubs/hmp-cmd-info_tlb.c | 12 ++++++++++++
>   hmp-commands-info.hx     |  5 ++---
>   stubs/meson.build        |  1 +
>   3 files changed, 15 insertions(+), 3 deletions(-)
>   create mode 100644 stubs/hmp-cmd-info_tlb.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

