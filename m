Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D19C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiH3g-00007Q-9U; Wed, 12 Feb 2025 13:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiH3f-00006L-Af
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:01:59 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiH3d-0001Pc-Pa
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:01:59 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso68748945ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383316; x=1739988116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cnAIM8M4ZHFa08ginikPfA8HToY74UJTSpKoj+aQ/Do=;
 b=aroVL96LXTqySYVsA2cM18COBY2uoql0UGUH12iB/P9aX+/g9GkLhZLBKDX2/N/dE8
 UhI/NIvn1ZE5aU0sSHYliFdlQoLlh/RlBxZiWudGaLO5FdPBuSeLxk+w1qPQH0DCi6qZ
 /DZHy16E75U3LB8xXmRA3lny4MtBFBvLlIRsvNucdFr+tkCepPkGFuRSXqsRbj3IxEET
 /t/0iGj2C+A+voO9g0YfJ9rB/PHYRa1Y7lcvdnIiPg/PUx8xjkIqRQ/Gx3LMjkXPGkFJ
 6WccQfhWpbZmjR2EhGAEWZ40LEBR8KGf1bkreAHm4XqpxriYXGmRvQss6KwsK6Zr0CNa
 v1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383316; x=1739988116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cnAIM8M4ZHFa08ginikPfA8HToY74UJTSpKoj+aQ/Do=;
 b=sqGsJlNsDZqD+TBTVwqE43tZc36wfY6LdrfMEBaC18g9iP9kJKjsneRn1iopZFkmLT
 vAznzXRiZLkIxF2QfFpiADyl+3OQkvge/V/bzmXZyQbdkEU13bLg8THY9XVfVKUAi7XB
 VA0xcCPNz0ar2h7/pnGUn9+pllFoC4UkAzK3xftW2DUZI5ThAFjTyjfqpZscELJ8BT3M
 1xODWbs1oGnJ7M/9Byaswv/dGjvrndkW/JseFUeE6/qFCXLmnud82qgtJMja/1LHvGRk
 xrGzOLRI6QdH7q0KJBnp7/0YJDbDQBy7nrCxPoS1voWAQjYMM7YPIfc6WJQ1l5Nk1teq
 iuBA==
X-Gm-Message-State: AOJu0YyI/VST6bTjdmV/J3F13sG2s56dBvX+1+vrdQ/wKZLzHv3qF/6p
 Y4Y8zGjN9nP77X72OKhQeIeuqomP5BMp6UD0wTmdQpnhwgi77OjpXdKvWodeAQrgDeanZUWkaYR
 +
X-Gm-Gg: ASbGncsLEEJ5SPhGiOWBZyZpvUuT3NfdiafErSRrHwMjoxw82U4AaZT0R+NGPqft1Dt
 e2kPVD6d1anb0Q0cTM3QECQ5fqcKIL5cK+UggKBimoKgrsyAF7RvC9nppnIxZ5hZgaMuDjR1wwI
 lVNqF2OQK/iPwSMv9usfnUAiAYmXDUJhIsQgQSTPZzG38bRkEuGgBtccpplc6ykT53rORpnuIBW
 cU3j5VP3KftNTtqwhPHxtRnmBPRXXtZ34aHI0zo5I2VSIZ8Ru8Wxi/CDi/uvXQmgxplNocorfnt
 YQ6ocNgGhlalRforg4shUu+MCxzfkgsixNx/uihT2aMEIBufhBByIJk=
X-Google-Smtp-Source: AGHT+IFkbrtNRGq9zQqzX5SqLXX+UP+1XrdVSPJbb0PrGI5+9V6lJHH3mULJzaorfw4RDRgna3cX8Q==
X-Received: by 2002:a05:6a20:2585:b0:1ea:e81c:60fa with SMTP id
 adf61e73a8af0-1ee5c78b20bmr6441664637.20.1739383315930; 
 Wed, 12 Feb 2025 10:01:55 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad54fb0dc62sm6034265a12.14.2025.02.12.10.01.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:01:55 -0800 (PST)
Message-ID: <980e2dc8-6a6e-4ae6-b7b6-791098a5af9a@linaro.org>
Date: Wed, 12 Feb 2025 10:01:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/arm/realview: Specify explicitly the GIC has 64
 external IRQs
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> When not specified, Cortex-A9MP configures its GIC with 64 external
> IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
> configurable"). Add the GIC_EXT_IRQS definition (with a comment)
> to make that explicit.
> 
> Except explicitly setting a property value to its same implicit
> value, there is no logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

