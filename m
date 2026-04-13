Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8190BEBFD14
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCQH-0003BC-Pe; Mon, 13 Apr 2026 04:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCQG-0003AO-9V
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:13:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCQE-0000Ko-H1
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:13:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aae4816912so27344875ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776068009; x=1776672809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QsUeMZ7qPBBmYcExCUOUCnfkqwQbV+/xuy/YDJ0H7Pk=;
 b=iSMd0QrKDFGxhEBDOc5/thF6VWq9aIwgHvfjzD9cuNNYXUrch3zmbhqood1C7SSNa/
 BaRDKLJJu0OCjTPEoCKo2qkOl8OS7OAD+kNp2pNo888ONWHZttbu79tbMC31PjPQbNzO
 K+wzcyt31rDUjv2idFiCuAzzakl0llYohFBgIBpvbR1hlgdDtJKxla4VHn5gxc2jmeHl
 bRiGaXXplzd+rt26n5Z5DJtXKxU2CpdfmMNwoVLmp9PBp+A11EaI6OLln1dmY0JdjooF
 wA+NXVqwuErLyVoAr8mBrPtCl4GhmkwpcnMF8J/u5BidLympU6Hq2KVmTjSk8ESkkLr3
 5zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776068009; x=1776672809;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsUeMZ7qPBBmYcExCUOUCnfkqwQbV+/xuy/YDJ0H7Pk=;
 b=L9Z0T8eeN33fn2BrhkB2A9IPzef3QQpkxNnNwY7MyETulwKGkz/l+H8znhOj546lu8
 QsAHk56EOXow7I0r7LghtU8goRTITGIyAkn2R9RTQaA4hoaFjNbtnsDsrvbZWCQABXBx
 3lSTIMun5ULr0M7Y9G0HokVjtX+8VKo7kAmna0/ff3wnXJGnxe0acw7oUOg4GIOvrOph
 6UwOpkaGwvuFrZa3gMXp57NpUPyZ14L6sNQiob0MSIAPADncOrvBo0b8TRkm/0twbgKs
 spL/VtRHPh3nRNLxw1pHMesPlPW2H5bZzhJsrseEXM+huVReaNbJF+MPwiY9M5vbw12A
 FotQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9NDPmJ8zcI9QvSAKGduUcDajB4Ymii5qXY8XQI6FO3JN+JllPZU5ozO0QSR9A2y5HC9Njw7sYsdjG@nongnu.org
X-Gm-Message-State: AOJu0YxLpwJ+JZ/67E82EjK/ojwIexRFri7HxEPz8MrObZGopbqiMzPz
 kuUfJpWLVFZbDNA78d6q7eur8ak6qHwwSvvFEHhhH4O3WaN4JfJHosRXmxL1zcUK1/Y=
X-Gm-Gg: AeBDievCLR1F+Smw/HbqfuINz/TLca2vNx/vtJ9OcRoq1Gek+yBWYGOWlsoRygjEGpq
 xXUEL/O/NRdNs88gN0mdPHoKIEBBvHyb3zHk9456xoL3ki0Ii24MnU3IeeMwX6neDRVOfg8SsUT
 oPVru4JQ7+GxzcVoHwrvm3XB/5P1p6I0pDAhXFfA6PqxUO3tOte/c5ZwaMyM6h5zJ3/lKMXSc7i
 PIkQfKd/pd3NyKRUabsKdzMCTck0Da1x/Cs+Rpshar5u+9bf5ApF+Sc3rfcUbb7I0XPXvIvO+dw
 LjGX2U3YPZk4jDXArjfivm512m6kjYno2xbgLVj+sdMT4bZwdmOL89RAdBim0vP55qBquNSbQp8
 gxCcZJ95i8JbdaG1DaAkHXRRkoSA7K+6Ae008CNDJaXaRV7mJANupXZjIv81V8v79QtX+Jn+RtZ
 Dxtz35Gt7FnhUGfGBN2yZ8qmbNjURR4XXiOqKf+11eoizrU7Te8vkatpvqx05VY8RYxY//ssSnq
 XW3dRM+yTYtsYnGvx2LZGCl6dYiQ365wH8RxYxVItU/x5snjbFk+yY=
X-Received: by 2002:a17:903:17cb:b0:2b2:4ded:954e with SMTP id
 d9443c01a7336-2b2d5a2945fmr137189975ad.24.1776068008760; 
 Mon, 13 Apr 2026 01:13:28 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f3b66esm109799715ad.75.2026.04.13.01.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:13:28 -0700 (PDT)
Message-ID: <e3c33193-613d-486c-81ab-addf73f75f4d@linaro.org>
Date: Mon, 13 Apr 2026 18:13:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/27] monitor: Merge hmp-target.c code within
 hmp-cmds.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-28-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> hmp-target.c doesn't contain any target-specific code anymore.
> Merge it within hmp-cmds.c (which is already built once).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS          |  1 -
>   monitor/hmp-cmds.c   | 40 ++++++++++++++++++++++++
>   monitor/hmp-target.c | 73 --------------------------------------------
>   monitor/meson.build  |  3 --
>   4 files changed, 40 insertions(+), 77 deletions(-)
>   delete mode 100644 monitor/hmp-target.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

