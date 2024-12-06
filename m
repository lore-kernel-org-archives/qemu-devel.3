Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7752DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTru-00051Y-LV; Fri, 06 Dec 2024 03:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTrt-0004yR-ET
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:39:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTrr-0000mm-PO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:39:20 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a752140eso11860705e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474358; x=1734079158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1xEXKiHA8dY3YNYsbhWgjgOAK8lHDEMFtM4ydnXVsE=;
 b=UoBN0P3OupwFND21v/6YpvweIN66XHFFHg+EMrMOWvr5LLyOfzpm3t5zNQAkRcgwHK
 8UEwtaopzcFUprqJrWD3LO6vHFI7eD/HXS0/+qgV/ZqxKchZxsPS4eJMCOrPulnU7zRu
 Qnld9UxQVdlN/NFzFsPA1ZDbVH8eCbDLO5v2pRW1AugRfJPxhAcuqsgSvUkLyfx4f+5z
 1GJ0jyum+F3cTPVzNQMo6HngEkTcM/xejhLLMFWceiGix+zSxKAIjKpobid8Wabw39Tf
 KqU0CkEQR3k+1Q0avaVFf0DueIequwObSNoztzTMTeovBgl3auPLHwwVMkR/VYSyC+rU
 d8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474358; x=1734079158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v1xEXKiHA8dY3YNYsbhWgjgOAK8lHDEMFtM4ydnXVsE=;
 b=VhmkZG8h4UAfUxZ8ByeMhUvn75juuld5iEPCcWTK9t5EJst0wxFxegS4C6mcGiIiYG
 gdP38D9YW40P1zEzQ3AcqsDoh0OUUzqBffakRcerrp4+AZRZ+T0xyHrOwDGZ6pkP3yL4
 0tHvFCacdxLmHcV/afMU2b9rswoWnIoqSKvN+P6I+ERDkCMxL/dXNTzmgXV+C/umo0Ic
 yopnmrYx7WzpbJtSUksH12CzyHKwCaa3tyzO9q/9hmu8X1eNq6eRQILl+2YVDQLJ7XNO
 eBPKlSixHMzngJDTbPwU3g8fQwTr+msyAdGXQGNp46sn/eb/yL94xVUXMaCMT3orA6qz
 UJzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo/RzlKM/JW/zGbLX+tsgjz8HIBIwiCTwTHPWbg9ess/S6tA34+trFDLHyT2go3p2vL/G4VsEUfv7H@nongnu.org
X-Gm-Message-State: AOJu0YxQxToUL/5wM+baQDgvpJ8vvpyEYklphv1H22INYkLO7ouFrlQz
 rTCFREgNh5nbZzYBXHhHe64sAW3UujL8/FRsE1WJsVHBa/NWVFXXb7pShqHoZ7fvB7/yaIVS4UL
 o
X-Gm-Gg: ASbGncs4Tq27dZVC8rRP81oiu5z1BjDHhZEGbMCGuR2s0oJLI8X95L09ganKz6hCzGI
 8smtjJWzSLyiTE2ptAm4JU+zjj6rzv5qftjSfgudbDJseitnqNBmw+u9q+dc/lPKLh8SEmiPH6J
 mO1B/xEJc42vix3r3SgDXjwGzzAwfCAg2qE5GHVNdBLOjZ88PylAON6LNYvd8zd5RQGp11baGk3
 DjX8aWlIdyNJ53ax51saN6cu+wiuD9Occ2P8SmCi2zH1fb9+SaZhFySfMDK89SsbcG3SomVu9x2
 Kg6l8Ci4SkYqL0A6kw==
X-Google-Smtp-Source: AGHT+IHof4YAHEcKdM7zVZuMg5n0ovxv+NBjtf/IZ0CoUqC8qhX5vYDeGMIvBmb1SkeUNIeEkpB94A==
X-Received: by 2002:a5d:5f8c:0:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-3862b379d16mr1517563f8f.32.1733474358386; 
 Fri, 06 Dec 2024 00:39:18 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862d7158c4sm871665f8f.54.2024.12.06.00.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:39:17 -0800 (PST)
Message-ID: <5b52cf73-fbf1-499a-bb22-ddd742a57512@linaro.org>
Date: Fri, 6 Dec 2024 09:39:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/arm: Convert vec_helper.c to use env alias
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 6/12/24 04:12, Richard Henderson wrote:
> Allow the helpers to receive CPUARMState* directly
> instead of via void*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h         | 12 ++++++------
>   target/arm/tcg/helper-a64.h |  2 +-
>   target/arm/tcg/vec_helper.c | 21 +++++++--------------
>   3 files changed, 14 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


