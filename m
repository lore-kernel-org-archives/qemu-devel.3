Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB907C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9hS-0005If-AW; Wed, 15 Jan 2025 15:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9hO-0005I7-0Y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:09:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9hL-0006Bm-MO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:09:08 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so165619f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971745; x=1737576545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBYbslArrsLcx3/tIlqbcI/xqlQFQbo/tITgraAUSrU=;
 b=I8CkNgAzQFkaMpabpPhRrI9L4+xYhlQ8Dwty9xkDfpn2q4LHX78uxESxeO7SStlp0W
 FlBKG2FwuokLBLoLbEqjGVm0KViGQxUbxL0q4Ic/iOOZHElBDTQP0cpk0z4MvmhajVC2
 DiPbQoQ7fcKzklVIKCf/k2eWVTQxwJihryNCp+IT0FRyuNgh11RkdlFLvyZBBwDHBKRG
 2vPa4Z8SwBTpv1/dcrJGTPMZWOUWwmc0j1i3gmLkBlGcV+lnzUbNwYDLRa60n0vsut8p
 Ssnd5a88h3G5PmcKcUUZDCRUY8kwpeiDBomHjhiH206kSaQYjXMllgLcsgwJXzEPHeDs
 yWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971745; x=1737576545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NBYbslArrsLcx3/tIlqbcI/xqlQFQbo/tITgraAUSrU=;
 b=AgtFfxDkSMZG0SAwf+5fV+SEdM/mkM4FrIDygqHv6lWtg4uFc8eeKbfrY+qFAWT6t2
 xa+Esni+17ni3ZtstRgyZZI47ZaQC6bJ3WZvdLMXMSxneIyJXrJPLGlvj+rY7acXPLHw
 gakpY+/AD4R5B1///zLOJHY3KmSeaym/ISfXkkiSTmVBb/2hy0oSntPov0Fdqog/9gTA
 FJWiUQycKHhmId52PmRF2wESGN73+d+w0XgkH4jDBjIjlC11JQy0kd3fmC2kyA8Lu3uE
 yd2ZctrbgJyqcRhoMfluJhN7AseI8dc8OGwiK2vbnE65lx2GOVIcJ68fR7r5ZZb8o+nT
 MlFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWawupya1pKHlo3YeVGYSXiLg65xAxUbTvcRmNztrCg+g2SZ4Z0ok7XrdFPvFObPn13odC9W0uCpFiQ@nongnu.org
X-Gm-Message-State: AOJu0Yw4a8YOLwLvjTzcPbbeUg9xqAtEdnEvisrQ2GObJf7W1ZhTcpV+
 stpwifuYBwiaHRwLaDiTO9l7i3lI3ssskt8Bi5elYIMsm95e21YuTYv6ewvuiKWvih8YolTYtpR
 a2V0=
X-Gm-Gg: ASbGncs3zMacYxjjP16+t3iCmr9xi2zYljaby/cAOthHqAZpg6vCHOIo7JND0WAoR0F
 WPOScU9VMJOYbk49YnO2rly9bO6E6MF+xXr1zrSxJSRK2HqhQy2vp/Nyc4QfF9sFcC7PYqYFE2E
 izrxRfUfhO2CrSEedc3kvK3JBiVWKNMQBv234sgye5i+hn7qP2hhlXLCceLxytnCiReT+7YHlix
 4ahtOMgcoYOUEaDFboDispXPTHeY/Fraray4TEZ4WnK1040kanzdFJg4ls7ZdsDkcnE2KGqGBH7
 EmJCERW95C1uoXwaQwLOqtUG
X-Google-Smtp-Source: AGHT+IGey+qNuopkCYqNBtq92ad0/asma6zcWeQv3kBL4l32O9uDE8Bs0gLBaz4I/hEG2mXSmgef+w==
X-Received: by 2002:a05:6000:156f:b0:38a:9c1b:df5c with SMTP id
 ffacd0b85a97d-38a9c1be171mr16634723f8f.50.1736971745522; 
 Wed, 15 Jan 2025 12:09:05 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d007sm18343646f8f.20.2025.01.15.12.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:09:05 -0800 (PST)
Message-ID: <f5cb3120-2575-4b53-8241-ab3e046853b8@linaro.org>
Date: Wed, 15 Jan 2025 21:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/81] tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-43-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Extracts which abut bit 32 may use 32-bit shifts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target-has.h | 24 +++++++-----------------
>   tcg/riscv/tcg-target.c.inc | 16 ++++++++++++----
>   2 files changed, 19 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


