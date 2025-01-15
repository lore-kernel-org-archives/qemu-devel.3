Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A21BC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXviY-0001mm-1T; Wed, 15 Jan 2025 00:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXviT-0001mQ-7E
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:13:21 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXviR-0006D4-H5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:13:20 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so8278645a91.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736917991; x=1737522791; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kldaTQRtUfqSFxUZ6S7kQdyP52Kck7f4pCYFIh5LIU0=;
 b=Q8zIc6hl1pSj/qHCo7Na1AqkxwbhawITRgohXeEmXpaENBbrHFSVWpCIGeGpdYhpgv
 Rv205pbMQ2WRab2nMaOt4g2tx3uZb1nBnu6GgxQqg5gegJndIrhEcF7QnEAaNkbFiL7A
 sFpXwk8Nqfuk1AHaBPiXGFKbR+bP9L60VSWKwP/AxcpZPkHjq/lgnQCciACZk35S2xoD
 w+lWmDVICkaYyj5/2fSEAMD4oZxrpWGcQaTBmH/8OQGRdw+LLn9qSSkDZ636pR7MTooZ
 b1sRdyF2+uBAj4YNczfcrl1/iNx8VpU6ySRjti7QhHr14RXPoWtvD/kveh5CKG4KYp9E
 Twug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736917991; x=1737522791;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kldaTQRtUfqSFxUZ6S7kQdyP52Kck7f4pCYFIh5LIU0=;
 b=ioDSgLcob6s7hC1tSbNsyoa089YoFRvRHyjk4T5vYnjIpZgIjb9Fg/5cCtIX/bmEPv
 SCpuJgRCz0X8Fy5VzrNXTo+3/q6ZyTf6Uts5OqKwp2p1OeRARZDYiozZ+CLjfnUZ9EP/
 ZBJ8doX3fHpqXQXoj0x5SK/SnA5deZ0WC09yZCxzrnbiErgsZjUrbhefjIBtif3ZVR9B
 xppWjyX79r0niWHoXksaMaDHVdbRAuEXjKvh/6FbWiW15hiTLtK7PkXUvR5fMVR96oXe
 7w3iG9cL5Z9yqAsGa9fiDilfqq5ZbtXldtIAP5fVwM3mQ7IkXll0Hqh81KPRfAw8JbC6
 3aNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAEpvH8NN/SqFJ7RSIPLQc7bkto2RUJvHhrrYRl43ZZDf6nOxZVMNCPs1bYtcddHTZrHwRmyXrQFdB@nongnu.org
X-Gm-Message-State: AOJu0YwdEhhcq+H5cfYcSpihGMv4sUsO9Vdk0Icl7p7ClyEtRZ2T0l/N
 kYps8t0Vz6YvVaN8U3Q6y+kbvcQKGDtlSxvpVwiGseWdRR1uTviaVgZNe5EX3oGrVI6L5fnQqji
 P
X-Gm-Gg: ASbGncssJBaYcviFDtihdMKfRmKaPFCK4KWnAblJIZpeFTRnkZTLkX+tl6oE+AhV8uZ
 R+1pQA4vjdOyqCheDilOVZS1PJiXiJSAaaLvR3AUwcdQqHcXyVhJwYsl5RxjnnFz7Y+DyxMtk9V
 26Ay00FRGdrzYJqO7mLP9IpTn2zPkpzhbPuFh4kiG2z0JSaLRNezoJ3JrV7sgatrqOBM/bWaYDB
 1VfcO3O04VSJNTuspkP+Iw1IFsgJQ43zbBz4UQU1WzWFGl3T06tkiK0quTIiQPBqIeldcICEnW8
 fvQvPCanjQbs9CVUC53mkx0=
X-Google-Smtp-Source: AGHT+IFocYKOb7CegdHIX2tBwK9kOmcmlfvt65bgyiKv9d2GxnWP+AKjZB8MpkE8zSP8WWyXLj2afw==
X-Received: by 2002:a17:90b:6d0:b0:2ee:889b:b11e with SMTP id
 98e67ed59e1d1-2f5490bd257mr39550151a91.30.1736917991105; 
 Tue, 14 Jan 2025 21:13:11 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c22b8fcsm502014a91.47.2025.01.14.21.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:13:10 -0800 (PST)
Message-ID: <b1d19cf0-a861-404e-9da9-ba9abc86b4fe@linaro.org>
Date: Tue, 14 Jan 2025 21:13:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] hw/mips/loongson3: Propagate cpu_count to
 init_loongson_params()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> Propagate the %cpu_count from the machine file, allowing
> to remove the "hw/boards.h" dependency (which is machine
> specific) from loongson3_bootp.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_bootp.h |  1 +
>   hw/mips/loongson3_bootp.c | 11 ++++++-----
>   hw/mips/loongson3_virt.c  |  1 +
>   3 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

