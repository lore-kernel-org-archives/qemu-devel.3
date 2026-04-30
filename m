Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7FCFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJsA-0007hn-EK; Thu, 30 Apr 2026 01:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJrt-0007V8-PJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:23:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJrr-0006ig-Cw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:23:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-446fea16729so428070f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777526598; x=1778131398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S5ipUb9fhcMaNS7STVktzlTs5CkE25eAfPlDrl8sR2Y=;
 b=hTQxqoIUjTMicHkPVT7XwpbuHW1c0Wk6pRQTvYzoaaKd/DwZR8oClRfTHC06ydUGsq
 YeYgWP1SPSbceJJV7iWWcWyeK3U+/SaSqpyeaRPdYg/MdbZUwv1YAQm93gfxdpAzb4FW
 3rC5EymCIvulvMyNRGuvR2J0oh5yEFsEuXj6HaG6tKXNOpqcfs8NkUL77RbWuI1O3q4J
 IiTyhsUWPS4/cRhaLssrwsiey/AfYMw6R8WRYEPo/S16Ett1t5rBUesYBi3xacXyX5iR
 G3zbfk4CpU9lqgVnUpETHoSu57IsfVn2NWgDzjb+fQ+YN3xWqCTebNNHqHGLMoytLDHR
 fTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526598; x=1778131398;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S5ipUb9fhcMaNS7STVktzlTs5CkE25eAfPlDrl8sR2Y=;
 b=N4lx2HPPmjsZZCIHzQcfotQgKnjb2hTPbezMBvzdePgg7FUtPbNEt4RB1rc5d9CrTj
 lC7MWQZr4vBFrcDceGtsgqpOS/KLtJHjhPPWo2JnS/BxUhxPeNGXNuerRT9bu8QJ0/tu
 YQDB91c5IJCtbNkQTOVJhrZYe9DZHWkyvc3F4PRXarF0xU5edt/4a4jOCDjuaAEaL0li
 /RPcB2B5jSVKHKu0kxUa6WO0IUse28P0TriAeuV2k5PfdUqzXWrfLrkz8gkV1di6dv6k
 vSne3rNV4ZGd6Ec5FOf2gG1rPvxzOU1KmaEhioZ/+aZdNCFf8AGOjNwa8T++A9Sf5suI
 Ar5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a5I9j4I174mNWmBADtPv+fuQJUDWsuDABHlRMDoBUu/M5XgFunor1f0Cn4oaszQQfPzoWmiD5Dcmi@nongnu.org
X-Gm-Message-State: AOJu0YxaX8fKf0bU74N5rqB3PtYidGl8QiRqaDK84SSZMdEBScQrlT+r
 squKbHaxENfvYHvgP894+vCe9HlCH171qHcBoO6aN6YYePYdxbWCVtSvEtBnzw4TyyQ=
X-Gm-Gg: AeBDietTzlksMCJwWqHWVejqt4EJUIVWKhSd7S+QzdBLRg4BUQYd39S7fiz1O3m+8o7
 g/+cnGYBol8bgcDu9NIOkORjS/R+bMuFaEsKBh+64cnoSK3QGWaQmsVCFO4pCaKfs9300FGRh2v
 Lj0Q6Fxsahm1K1fIlJ0nBR/Ac1ex6DE3f3sAJb0THrGmVnRsic/w+ke9coXXPt5FWRA39hiipfl
 UU+JkHOBI+HKW00/oAMDL0pJnLDMjg6Qz5wyB0pf2CkI52xQ9H5t6krP5NMrLtMSlI4tr1hKust
 0o5JbP3L9ivh9HX4SCYXQjtGTqGmKCrP0wDZ+FAKLRMwJvlJkXLQTjjQkRliUUozeLuZM3c/aTg
 /ljWZTEvjoyXBjfUm1xXhU6MQIChBGjUXNTGd6nKXzkQ7hrt2suYDOnhmQuaG+2/f1JyZwvbHqv
 bHkcsF/JkXocnS1dAZ0ozCjpSlk/WsjEQ2ua1gFSGcm7ua4A3gRZJWYN5vFGjl5CbZ28+CO0CeI
 QaS
X-Received: by 2002:a05:6000:24c9:b0:43d:73de:abd2 with SMTP id
 ffacd0b85a97d-4493e1c1524mr1979558f8f.26.1777526597587; 
 Wed, 29 Apr 2026 22:23:17 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c00sm10501886f8f.25.2026.04.29.22.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:23:16 -0700 (PDT)
Message-ID: <b734724e-159e-4e0f-84c1-e64348e7210a@linaro.org>
Date: Thu, 30 Apr 2026 07:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/40] host-utils: Introduce signed saturation
 primitives
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-39-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 30/4/26 02:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/host-utils.h    | 60 ++++++++++++++++++++++++++++++++++++
>   accel/tcg/tcg-runtime-gvec.c | 20 +++---------
>   2 files changed, 64 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

