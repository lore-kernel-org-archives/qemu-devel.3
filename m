Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F81E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpOB-0007hm-4I; Thu, 12 Dec 2024 15:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpO6-0007hM-MK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:02:19 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpO3-0005z6-Lq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:02:18 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71decc7de4eso256058a34.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734033732; x=1734638532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XA2DLsAjgmH4v7xhk4FVYR0NtZOo+ApN20Lk6do5YwA=;
 b=RhSMDECDXtHUow1jg3mbutP7UO6Rjw6Fm7O3GfTpD1VP937cpu+OErE3UOLddo01AY
 0zaBqIBlVbvy0yzLfkPrJOzEEJzDk8nNO8+jIIHkh4WVmEFcBWa+A+n7zhfGiAvSTKGF
 pWWIP/HZlWoDF3Zo5cZB7Lk16D4WW+cuZbq+CO7qd7zJqIkZxjEvYNanWavt+S5vKWGO
 ZakcBsMnBoZYNFaZSKdmJkHtOwEM7LJYHA9sg4WCIQMrmLvkd+8OyeqULUOj1RrL3188
 2gf8KwQY++U+Nd6noWNkwh5be1ld477WIZC4+5AB+J1tjxbNx7wF9kK8je8s/g3W5IVL
 2vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734033732; x=1734638532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XA2DLsAjgmH4v7xhk4FVYR0NtZOo+ApN20Lk6do5YwA=;
 b=PU6eG6rs0go51HqVljIxPu1BTEWvI8tC72ct5lxVtzqptoJugNwVrH8+rNZTLJR/K/
 Gjy3ff/HTqtMVyC67Fge40xISFc7jPDaiimMAck4aHPdyCvFyNcY5XhyslIgvAe5LLQY
 1wP6hkOTTYH04MUqGgJaHepyLP6jeU0F1QXk9K7mj1vyzgvR7Az2iDm8tytMorrHjOnb
 9vMuMXQBF12EzvJBOR4/WaP8OCgwnxBdrel1vPChszJyDw/kM1o+HT961/UcxRzt++p5
 8t9as22QqMQnqpMzlb4k13u5bxa/t8krtNFP5P+BDz02FZLbdO0YO8N6rXDSAzqJ9Zg1
 aKDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXODok1RfwiWFIr+/bbLyJL2rmVaSKfyM1WDvsQ9gSvBCDCboUInt4SGqP3FrM+HaG1x0VpGWBq0LgL@nongnu.org
X-Gm-Message-State: AOJu0YwP0wKA/6f/wNXlMa55TAb32fnE4POrtIw5OWDlK8GD/2l3c2NO
 cTLtMJhL7nyv4EsTnP2TwwpHge6fFG6JPNar/xpR8Oqtedv3r1gYYJWCzQD82b0=
X-Gm-Gg: ASbGncuvZFXJvl8fK0oB0J/iIBLDfEuO2XP2zqS8LxGaqPq2uFljIgbMK5Ff8/qtnNX
 /B5UPpAp1qze/rfuc5Shu0BnBUWKchrO5FXf/wpNOhFdpn6qaAsgQXYBGBuwkFXZptC2ALOceoc
 lEt8jzW0hw5UJQjgzuX5rRyFLhPTZlE6Mwj7SM77u12dX5zvibdb9J9pNs29l/U4L2jCW+EGV7L
 b77KXpLhBPRaNK5w7URf7nGFvYDKZDh4dS0ofMzkuoG4uqXIt0PI0vSsPpyvCQM9dyJOGe29w==
X-Google-Smtp-Source: AGHT+IHdo+XIOGXD2SI8FHC/ZJpg9Q29fXBVoJp8ATsmf3TNumaMNVpDphXt5D/yOiKe7Te4i3PV+A==
X-Received: by 2002:a05:6830:2107:b0:71d:415a:5d30 with SMTP id
 46e09a7af769-71e36c191c3mr1428033a34.0.1734033732564; 
 Thu, 12 Dec 2024 12:02:12 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f29cce7108sm2744376eaf.32.2024.12.12.12.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 12:02:12 -0800 (PST)
Message-ID: <0478e44a-c087-4665-ade3-41b0050d89bb@linaro.org>
Date: Thu, 12 Dec 2024 14:02:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] accel/tcg: Extract user APIs out of
 'exec/[cpu,exec]-all.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/12/24 12:53, Philippe Mathieu-Daudé wrote:
> The goal of this series is to clarify user emulation APIs,
> and clean the mixed bag of exec/foo-all.h headers.
> 
> Move user specific declarations out of the generic
> - "exec/cpu-all.h",
> - "exec/cpu_ldst.h",
> - "exec/exec-all.h" and
> - "exec/translate-all.h"
> to the generic:
> - "accel/tcg/tb-internal.h" and
> - "exec/page-protection.h"
> and the user specific:
> - "user/cpu_loop.h",
> - "user/guest-host.h" and
> - "user/page-protection.h"
> 
> Philippe Mathieu-Daudé (18):
>    exec: Introduce 'user/guest-host.h' header
>    linux-user/aarch64: Include missing 'user/abitypes.h' header
>    include: Include missing 'qemu/clang-tsa.h' header
>    accel/tcg: Declare mmap_[un]lock() in 'exec/page-protection.h'
>    accel/tcg: Use tb_page_addr_t type in page_unprotect()
>    accel/tcg: Move page_[un]protect() to 'user/page-protection.h'
>    system: Remove unnecessary 'exec/translate-all.h' include
>    accel/tcg: Move 'exec/translate-all.h' -> 'tb-internal.h'
>    accel/tcg: Un-inline log_pc()
>    accel/tcg: Move TranslationBlock declarations to 'tb-internal.h'
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (1/4)
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (2/4)
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (3/4)
>    accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
>      (4/4)
>    user: Forward declare target_cpu_copy_regs structure
>    user: Move 'linux-user/cpu_loop-common.h' -> 'user/cpu_loop.h'
>    user: Declare cpu_loop() once in 'user/cpu_loop.h'
>    user: Move various declarations out of 'exec/exec-all.h'

Series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

