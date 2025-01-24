Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34734C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNFi-0001Bw-5a; Fri, 24 Jan 2025 12:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNFY-000114-Qh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:13:45 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNFV-0006K2-ON
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:13:44 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2161eb95317so43120015ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738818; x=1738343618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RAGetrQXd5TI6vEj4fo4gqVGkT6q9EYVtyevmM3r/N0=;
 b=B5hU/x5DACSv4k5PVXYhooNxajxn5t7nlLmUswEnYtUVIHwaKFZWbAfG/9uViQSHR6
 7NIkoBX/iUVBkQ0OXJF6ZCfXe5Ll1Uh2EcKTPqzDL7+38bsFdG74SwjLupsC9FRr+118
 ipkQGjFqWcbHelJvMvTG4r526QBKZOfysl0pAN9UE9AyWLWaBbaz6ezPgcCa9UsUU9Rt
 gSryEzGSCO8v2n36V/2HEZVhg+VggIG/3R2gPfXH5t7scxMQD6JnZ/HlYDq7luHpXEIG
 80bckihUo4Y5IpAk2NJZBjlRHuzQ6jXfq8/LYYLNTU9C0E0C5D8cV8oIy/Eim8v/ohVJ
 qVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738818; x=1738343618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RAGetrQXd5TI6vEj4fo4gqVGkT6q9EYVtyevmM3r/N0=;
 b=XdBBL2dg7WEibTrgx92Mneh0V+XgnoblAz5hS91F7di1weYEGhWuiirox25DrBEZ1w
 Qo3vf6D0RNL1m5LoTZ/HICejLVqmDEzL4m6/wENF4Pp9H5Oi2sNhuJfnaor1eLM4e/L3
 cFfjV9W3rdLO1LPzMEIJ18NSUkl73xHehvpXtzSYm6E8mBgHltfrl4VYMXACbK6KQQmv
 1nvI7hH1DSmPlycZwVGaGoWS2U3q3oQIX8s8JaFLCcIv0rXNIKg7VzQy48n9OHtQbq3k
 wVXE/EwF+gvQtRwNHIFhcUY80D8vrJnP0hxHHWxtWubJ6LNUFGGKuDxcFg4lLhaOQeJd
 Dsyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIWbZXXDupvN2V4JUVHJhdDI0rSkPrfmwHgvXpT0qfe0k5q8FSCpsD9jO29bL6moWPUy/6kcGEcvXF@nongnu.org
X-Gm-Message-State: AOJu0YxcOR4jdgLqkUIJJ0NJpg1x/Byd0rAfQuP4229EYp4/lsloxIIn
 OLZaWn4wWMGmHcTUB76vxQoDt0475WqDkim+LqezvGGa+sbyF9OfpzFck1RYt60RlujlZi4qyZE
 Z
X-Gm-Gg: ASbGnctM0ImMNls8Hhm3Qgq+uy8UxW5bjLfjm4+/+Ijk7y7rSxC8LUVxwyfuWacT7wX
 Zrk0vzdr7xyrxiUwqWfnPKJMz3fpsvEq09gqguy/2zw5/6PGlX2EdW13zwAD6zaD7lKGylcz+qx
 E1PnwY298e7w1usYy9f7Bk9yW2Ew//2JPLkCkQtgomndkKbG41XSh6JFmPd9Ba7I9hk9/XMzFtJ
 gtV4zlxubjxFMGlUlcgnifnWNxCOdIxEB8ZH+8CUZJLBpCOLvnRRJ7zuGQd4EbPGVhTFUBdupJq
 2hgx//mEGyuWM44Pw3C1gKwGBubD
X-Google-Smtp-Source: AGHT+IGnWLkt7PJLpJAoQwSWsoVrsHUK8KbBypgbOnoEXf4AvkxMqq5o7So/myue36JTeVohskK1lw==
X-Received: by 2002:a05:6a21:78a5:b0:1e1:9fef:e96a with SMTP id
 adf61e73a8af0-1eb2145dc72mr47003917637.6.1737738818646; 
 Fri, 24 Jan 2025 09:13:38 -0800 (PST)
Received: from [192.168.163.227] ([172.56.200.253])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69f411sm2099365b3a.6.2025.01.24.09.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:13:38 -0800 (PST)
Message-ID: <ee99afc8-9ab9-49de-938b-c76e5442393e@linaro.org>
Date: Fri, 24 Jan 2025 09:13:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/28] target/openrisc: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

