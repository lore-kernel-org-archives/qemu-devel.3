Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B553CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnkl-0007s4-Qa; Sun, 31 May 2026 17:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnkk-0007rY-3R
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:31:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnki-0002UZ-He
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:31:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490a7627033so5749925e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780263083; x=1780867883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=52YR4vIwH5uaicviTHCbMKXYNptwD2H6O2cWTaClfiE=;
 b=rvckZLmbDRMIenGgUUoBY9uBCFE3qSfNAQL9d2U78lRNEFdtJTe7GQYdIUwDskfXCZ
 1o5emfPb69vg119eK95geCUYZe3aDgJzpaiihLm6U8Cc7q69v27Ob+GsYAHmsNhafS0l
 I9wsC+uXDyRQ2ZedwhS5uGm8nzzINr9ZYQyCq+u8Ute0f6QRC5IKrHv5oQLgIIOW1mai
 js77p651H/hvWg3Izx/fb/chyG8tgy+wwch57B4COxwMVA01X8cejCwdnJmEqLJfV2M8
 gh6eKKkfzgWhw2bgbcglzHqgBFJJkOjCk34Qaq0CDaN671y//scdkUKqi/emqpKGiLnj
 as0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780263083; x=1780867883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52YR4vIwH5uaicviTHCbMKXYNptwD2H6O2cWTaClfiE=;
 b=aWg0KUlHWUlq69d7OsVJbcXqnCnAM4/qYMJG0YEbaXWa/wT4K/f7sdKt5ab9XZELy5
 HXHu8VCN8rwbz9CQM1kPq+kdKuoG76nIHtd02Sf9YDNn+FW834hvD/I7qQkGRNaloHkE
 pD1FMozs2cOO+rnpAN8QR+Kf5YgI+LiuxAT6i86wu9alwg3PCNWVbYeGPLtEVaSOkN1r
 lQbqVxPggDXXSbNoAoqqxVpeBN0+VLaffLtcoX2P0fJbWltCcereOC9zF4w/iUbE1Vp0
 IWDPXbfeUjCNc/jsXLiKI+PYivNdjgfczqDtyWw4LMzpjVEKHFyv6tqnpZTLWQ0HGW6T
 aekA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kM32eJzDEBzDbNQYhDIdiIxyxn7HMn/3Nim/eIH4b3/524yGnMe5UBBZ0lEJ/BFi6YPdYSh/WAveh@nongnu.org
X-Gm-Message-State: AOJu0YzCdk7SgrEJHgSB33CIwLlJTGI9ASzoMSETXdmLQwOEpXHOZvsa
 M/kQgcHM0ScFYWyg+zykWkUtYcdetLNlcDSne9u6hLxaY1gRcygEHYBGJeLtX4wBA8E=
X-Gm-Gg: Acq92OE6QJAUfH1hp6D37C2BeuXKroYKBITHcqyISoYx9BMk3ShhCcvW09GtGf1BGIs
 dm7TKb6A55paQ0W/A9tZZlzq3bBSaun9H0JwI0mBVGeLHnDilO8gHcsXgoRG1KxbHCdGTrrf7Qf
 b01eolaYb2aMfaj+WoS2j3k3+IcySFzSXBp9uo8tFy7ufQz9gBvR9KWbvsaI3PAYwIIU6zEhkyr
 tHqM/OqUFZdgt+7vTxr9JqxJmPqrA4Cll670+PsZJOusKLPTGJB+lS/fo8DFNH8ezTCBN/5MHQS
 c+x7lzQbYEb6EJciKRDh6fEUdVEWMC4Dv/XTsEu5tTvlO2N2zzGCHgPcPclKZeawGV/OnF1qMP3
 RmyoZqYMsowslUs3MEC1mSV7xAk/sGD9VbHEA+Jv7iurd4kcy4bzREzszuKFkEqTqCRJF5sl4rv
 P1gPe0+u2MOQKRaBW1UgYa5sy5PwCjanPdOvvh1n3pxeAjFbQ4ElhPZYVggTZ6mnxyT/S7Nijjm
 hxX
X-Received: by 2002:a05:600c:4f08:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-490a290da24mr128772265e9.10.1780263082642; 
 Sun, 31 May 2026 14:31:22 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0498e0sm85683455e9.0.2026.05.31.14.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:31:21 -0700 (PDT)
Message-ID: <c71f8159-5c3d-4e02-aa08-7d979f5454ab@linaro.org>
Date: Sun, 31 May 2026 23:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 38/38] target/hexagon: Add hex_interrupts support
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-39-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529215554.606133-39-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 29/5/26 23:55, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h            |   2 +
>   target/hexagon/hex_interrupts.h |  15 ++
>   target/hexagon/cpu.c            |   4 +
>   target/hexagon/hex_interrupts.c | 371 ++++++++++++++++++++++++++++++++
>   4 files changed, 392 insertions(+)
>   create mode 100644 target/hexagon/hex_interrupts.h
>   create mode 100644 target/hexagon/hex_interrupts.c

Patch #28 mentions NMI, how is it handled?

