Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7587BC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5M1c-0002Ti-M4; Thu, 17 Apr 2025 05:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M1b-0002RR-1d
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:59:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M1Z-0002Hs-8h
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:59:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso5016005e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744883951; x=1745488751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E17VfZyb8qLY4zedxJspW5pqewiK+6QS0Fu7hOdhK3g=;
 b=UdtlfeXHFYKuvFL+mFCQ52FVV2G1NL8oUTXO9NXal6wxdkM6myMu80Hr+Ckt529eNg
 w7Xtiv8YodrWtg0+XfV73qVlkR2uMZiRf6v2YrNcu01eOiP0M4Hp9YAgvySaB626qJsv
 1Dsz5Eph2jbK1IIn3T73n41T01OKcWq18SIfjNMZFIlkQFbsBIOdoDsUs+PMosYMrsPl
 9orTimhdPTRGhRfC4mNhYB8FwRl9xJmxnb2+WRvpoIRyaZ41EYI3uNZ0+3DK4fiBQhQj
 08FDwPqHq3ZJrlm2cb7ttOrDAJtKVOjb1km4bZY8BXb+n4dhQPvZ2kiQKbxLVfRMIjcG
 wG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883951; x=1745488751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E17VfZyb8qLY4zedxJspW5pqewiK+6QS0Fu7hOdhK3g=;
 b=uRQfccOeovstCoAmHzptfqzEm8GCj8AL7HQmr//2SjeJKqKCO5hB0D6y8M3PT/gUXV
 9aCDFm02Y1lOaGLG47SXad3dcJDDmuJk4l4wz1MUkbVdsV+RXXaR5r9EQ3pN3idxOXNw
 D1UjNKLq4/MRXwB0U9if6ocrIfOWjSj9DldF0q8yJW1kVjCSwpTsb/Z0hVOaDJj2Fa5Y
 +oymPvuQ0nLf4VtEP1A8QNzRJMEvEo48nzpHQS1588NGHfluoqzbsbohXqVW8mgT+9HL
 +fK65DxxIooSNscXzNLNuNLQJnV8V9yu+Pz9BJNLwYk/x4JdO78d7pw/+XIl8Jdh6rTw
 +1gQ==
X-Gm-Message-State: AOJu0Yya41z+XNlnPHF+yUemv2ytZNAzei0ubPzy4Q7e0yLJ3z6FwYXv
 S0lSyfrOhQ1aFvOP3UrJ8p/Lagu84Ew12vnwaEfF54eb7aB81fQCYX8o4LwQrSM=
X-Gm-Gg: ASbGnctVS5nKS9DC/YLMO/W1cqcGbhOoUEl1IaXRo3phwMZE3aAZls92iY+CVzh4376
 a/KunGB+9QbqqXRsCeku3rwYpscehOYJE0Fx3bRbTvt4sbXK+UFwPTpghmV9raQhfuFMXT+TBo5
 sMZGs1+wNrCx8WRqKsSaZRvuKLYFtyynOHdtgYydILdnC9Pu9QTAiy+QWcgB6To3RgcI6Y69B9R
 Lr6zoHSVaUkgWrmm4K9+aa4JpvQ2czm83r2+GhKZ44p+mv3T+jhDpd01CUUV2bg064krOLoZrFS
 U8d+LozEGs1xwGtjMCJwTAakpwm2ziYMuI8JJx1HiyxXyHAOvfjc/87m5EWR+6pc2Uh7fE7wb2f
 9FXb9k2M8
X-Google-Smtp-Source: AGHT+IE3BS3f9ZlWSGKpcl/1N4L223TB5CrBJycMsLvVMBjFxEfVrRIxxnNykl7mQRwscj050nUidQ==
X-Received: by 2002:a05:600c:1c07:b0:43d:4e9:27fe with SMTP id
 5b1f17b1804b1-4405d61cb53mr44934755e9.8.1744883951172; 
 Thu, 17 Apr 2025 02:59:11 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f3df8sm47480015e9.24.2025.04.17.02.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:59:10 -0700 (PDT)
Message-ID: <c2372ba0-e328-4443-85f5-8edcdca95613@linaro.org>
Date: Thu, 17 Apr 2025 11:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/loongarch: Add stub function
 loongarch_get_addr_from_tlb
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250417035143.268248-1-maobibo@loongson.cn>
 <20250417035143.268248-5-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250417035143.268248-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17/4/25 05:51, Bibo Mao wrote:
> Stub function loongarch_get_addr_from_tlb() is added if option
> CONFIG_TCG is not enabled, so this function can be called in KVM
> only mode.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


