Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E17AC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT34Q-0003ea-UN; Thu, 25 Jan 2024 11:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT34M-0003ca-UE
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:59:16 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT34L-0001aS-EM
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:59:14 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3392d417a9fso3229536f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706201952; x=1706806752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vka6V+I0jujOnJ86XivQ3Lv7IXgrTpTt635vd9F7zmk=;
 b=bls5+cTXjecLobYStxOu/s3B8ilFy5UgBVxwMQPUO2mYiYLZVOasRv99xXEG9bQ/a0
 E83q+dt4mpcvLP7EhKoaq9+rdmW+HgE1gcuwwin3gfFjM+CP/FDh6Z8Ac9y+FkWN0L4U
 FHCCaRKytDnGpSrCP124TazOXd0nsGERBws6VsqNy3jKL7UJGxVrsEoQsoitQKNqO0zN
 IwaARrpjRQYqDa7XZpJBM8ccuTtVBn0PO280hFI4k6BgQ3O9OT/W/Uipvu/AfsZMz1Zu
 fYxS4ssebtIzV4hR6uBRMu5vzkKs297n1mT0n6qb63MTccPP/5vNYr/1gOIPRdnYfNU/
 OBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706201952; x=1706806752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vka6V+I0jujOnJ86XivQ3Lv7IXgrTpTt635vd9F7zmk=;
 b=hDzCaE97LMjUxqacR0COW48rWJIujDKjvJhem6S+cJxKpgtARQG7veB04eJqkvr6Ew
 08NOIsTLP598zHbw+qgetBMNZNckTtaLEXeaufFsmI3Qk//jNBpusdGkWKoiwR9O1Cl1
 oGzUYZTYYUk2gHzHV+QJsk50dvEuHv2cka23JI5LxLrRqJ+QWSoWhm7VWbxKGxxSLqxC
 7vvpk3V/Lhss6hAJ3bK7HnFYbqRZUTZLq+4idYlnmY6gD5dfsiGVL8P9vw2699kO8GOD
 U3Oas5ckwQ2wgMwBR10Dhr4JyRQ9mSldJ5zS5iONcDP6CVV/JJ8Msz8KtPrdVDCMktEM
 mkJw==
X-Gm-Message-State: AOJu0Yz/tuDYLC8bbXdhb9dX4aQ4Ni9QnDk7eWV8RzkVMgiEy7c0k8Wf
 eC2Rtn4fDuEdWgKBINKVZbcxSZg4GaVgoi8uvy3c17Dbyqqwr98ijqPvNSKjR7o=
X-Google-Smtp-Source: AGHT+IFOfjqRe2HR8tebvt/OWu6NtB/MGiG/udzy5HeaqpTU+dihYvEOT97Avnnk3RAMF2VhKA9Y9w==
X-Received: by 2002:a5d:624b:0:b0:337:c595:88f5 with SMTP id
 m11-20020a5d624b000000b00337c59588f5mr1231784wrv.16.1706201951847; 
 Thu, 25 Jan 2024 08:59:11 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d5608000000b003392bcd6c48sm12913879wrv.79.2024.01.25.08.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 08:59:11 -0800 (PST)
Message-ID: <7ef0c6d5-195b-4ced-bceb-73e3965e4374@linaro.org>
Date: Thu, 25 Jan 2024 17:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] disas/riscv: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125163408.1595135-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25/1/24 17:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git disas/riscv disas/riscv*[ch]
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   disas/riscv.h          | 1 -
>   disas/riscv-xthead.c   | 1 +
>   disas/riscv-xventana.c | 1 +
>   3 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


