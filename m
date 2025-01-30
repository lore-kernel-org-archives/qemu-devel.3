Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B795C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 21:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcQ9-0003In-5u; Thu, 30 Jan 2025 16:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcQ5-0003IS-Vi
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:49:54 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcPt-0000n4-OV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:49:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436249df846so9328165e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738273776; x=1738878576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VF8M5RXxuuslbK4Gy/9lMrwDJqWefSUNRkmH178FWhY=;
 b=G7Dw3qYXeK+1vF3q20QLYdBQgN7JNFfVdUSEHD+0v8LbP3Fl3SgETUY0+pCNAFnlQz
 rWDnrnQ05bGGiosAidWkXAwMmbx6dOBX3KMXYPjIQf6fppAbvvUQU5U8rm/0VXkX9cmw
 IJwsVJz6u3mffQHZheg7DsYynFmz0igCqHu1rrzeofojbFLekDfv+mPySuDRdbCs14BB
 ttT41T/rKxnzu5TzhRySDoJ0ziwjsvcrzVg3j0IYhGWkMzzhQA5RXY8zjxHbpG8fxj2k
 wbaptxWTr4OhNPbM7wxec2n/oOdsJDusgsxPAtHVb7i/U96cE/IfnkpsvXtuhwvrmFwd
 PUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738273776; x=1738878576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VF8M5RXxuuslbK4Gy/9lMrwDJqWefSUNRkmH178FWhY=;
 b=EBn7jM4GYYdloqjuqiq+1afc+1pqwA6MHcq16nVb2heyM+s27ynUbigLg9BtGkjYK3
 Lt8k4YgCOxF6atpsI63jbV0ei9btSKvbuXjLK7H5lJXJgYXvSQDXhcEwOdNGZGRaXmrw
 K5LgrrbMqVHbThqxOTbRzYjGLceg5w3BI2UfDZ4nLI9VE19VWTCln91bU+Ed+kS8unH0
 loPAttPBjE9JctFHqQ2iezTSDYEczO0Nf8s2hp4To4C5MzuxvSQuTCqVXgfyyyVkJo2e
 Gnwl62bGERyXbRdKaOhYWnFjB36g9TFLW+F0u5QGlwz0x6YQ+khPEe/fXBr9HW8Pm9M8
 YUsw==
X-Gm-Message-State: AOJu0YyJkeM4OEOppNkL40h/Im/jndRhaK17WHV8iVTv6GxffkI7zce0
 4/EGflY/Bl5U80ZMrFMdOjQl9f+1lHPtNi0yFL11QoCFd2Lp9J/lJEiKJbZXmmsFZUhYQLipsSi
 YoEQ=
X-Gm-Gg: ASbGncvggAbR9V7Maix8KqdgHQ076oWSpOzrI8xypw7ifYX0O6u2J/qDNiiWRViQ7wd
 fwoipqfVotK00Sme398iHd88R/eg3g4EIRgNZYoeNSlbeNU+FHbWU0Edriutdu57eIhIlaGQikN
 RjRGklE1DoEGI0ICp3pYbZX2AVWkIAjBBHux+RrjWwooyQXjF88+PvbvfSnEcRGr3skD9IK/7FM
 1pHcKUy9WuFancsIPR64kpm9xSXws17Q9z+zkKmyJK+ZBjdzHKI8Ra8nnMOfvzH22AQD6cf3QOG
 shhCaYccEA9e94l0Lu5MRt9YR6Wgt6a3B46s3IyTLswGfRlpm5N1vQLGSLw=
X-Google-Smtp-Source: AGHT+IH82hLjDujqdgqa/RmOfl3PhPCAepGZQ0i4WYthxYPHlQnfBy6OcB1Bt2FwY8Zsc8sR+sxzIw==
X-Received: by 2002:a5d:4d47:0:b0:38b:f44b:8663 with SMTP id
 ffacd0b85a97d-38c520bb322mr6225236f8f.55.1738273776542; 
 Thu, 30 Jan 2025 13:49:36 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c11fadbsm2999098f8f.44.2025.01.30.13.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 13:49:36 -0800 (PST)
Message-ID: <131cce7a-8697-4df1-8cf5-45b2ed0c8e31@linaro.org>
Date: Thu, 30 Jan 2025 22:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sh4/r2d: Convert legacy qemu_allocate_irqs() to
 qemu_init_irqs()
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20250121182445.35309-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121182445.35309-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 21/1/25 19:24, Philippe Mathieu-Daudé wrote:
> The FPGA exposes a fixed set of IRQs. Hold them in the FPGA
> state and initialize them in place calling qemu_init_irqs().
> 
> Move r2d_fpga_irq enums earlier so we can use NR_IRQS within
> the r2d_fpga_t structure. r2d_fpga_init() returns r2d_fpga_t,
> and we dereference irq from it in r2d_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250121155526.29982-2-philmd@linaro.org>
>            "hw/irq: Introduce qemu_init_irqs() helper"
> ---
>   hw/sh4/r2d.c | 38 +++++++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 17 deletions(-)

Patch queued.

