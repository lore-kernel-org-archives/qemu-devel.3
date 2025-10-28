Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44341CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiq1-0006c3-8H; Tue, 28 Oct 2025 08:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDipm-0006aV-Od
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:29:56 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDipi-0004LI-15
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:29:54 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63c4c346bd9so11491969a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761654587; x=1762259387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=shY+r7q7N190HsRKbpo9f/F3d3G0b41F40oQ0Qi1PGU=;
 b=VjO1y819uBsGnfNFF8GVod00HwxA49C11AbAPkf9YbqdQbmtgK9ZGj5C/vK19WLpWE
 7ySRGzWDBnXpoBPyFViY4UMpU02i2PDuszs2/D8B2fqeaQMNBfOYcXWd/FZu2aMzN2uK
 xLL1nLQAxVGHHcsf2LwO6n16SanftjdXd9aDjJYbEebYN1P2vAvc3pE7lQXuv3HAcUpz
 e9el2MKQzt62DHXQpCoFiBAaUVBecxRsv/094tdoE95zgoAauqNdFLaeOY8DSmeqgj56
 soBS/ywnMDnYouq/HWj6DKiIbDILHilSL4NbRycwhvVDrV2hbftiLNanoW4bWbDd+qRW
 4g7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761654587; x=1762259387;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=shY+r7q7N190HsRKbpo9f/F3d3G0b41F40oQ0Qi1PGU=;
 b=DdrhqCxnXTzCeQPJRKSTkL5tAOvc2IwzkavOj6iVrq0qat0D7WjKoAqsIOqvTGEWQv
 jmftm0Q3jHgILGb4xaUny1drct1Y1FQvL2X+A+OTpgBzeIw9Cdjzo4Ug3cY26Bm3zYs6
 twTiL+Alrgwo0EZK5XMNlVKuJ4auku38wRZk3Z2eAr8U2KXUabNS0IkDyI3DRHAioQX3
 8jhY1MayLXfsa6SProfymC+qOJHJ5gByA1FWR/0xJcOZBc58NtPOPtgdXjrJtToRHQZA
 B+UstjjnyFQ0ktVadelkr3DdwdNzprSMXv/vqCYizoFbE5tBAnq8jw+lRZfxyz/2L9xZ
 b7aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZCmOYx2K1nMHV9WVmVcscictZAmQymeVsb1fjeSMM0oCr3wFrMZsduYBXukeCs59ItQ4M0LPksE98@nongnu.org
X-Gm-Message-State: AOJu0YyQHcZPLsPd65J6vDlMffy8t72KT1LxG2kVIzo1obAYV5FTomI1
 TrvyvlvsJbDUZBvgyg1oiM7gxeKDlvVdOcyOMhvFdFY2z8+xyQaHdo4xyhetx/5XZA8=
X-Gm-Gg: ASbGncsu1qBf7xJLC+1q6P8jKQJRolcHrukHIq/mgKT+zyfpGg+bmFdrua3jzWKcCRg
 CzhBFakk1JlHbpjx3qnD38VhzO/CqBwWyf4DAFq0Axa2Uc6H2wrbdFN/Hti5642AOGQj8dyVQp1
 a/cV0RiUhSJeU0oIZGTQV59Wh839Zn3qDaeCe3P+ZzL2mb6hepg7nyFrMAK2BmMC+BNvCcv8dwT
 NgmREbpC0/r5sGdMNg6Q1gY1H/rd8+2EmqsX+8hnm66lolx7HVJcu9DLvTBRlSdQ5D5z3J1cMOv
 pkB0QFIIEmgXSNyYyl4UpJc1zWthC7jNXCl0pEoya0EByYNxjcJStDmWnN5t3jajLgPGRjkeRN9
 l4HDdfnw1agABV9ZVd83O3ccKUWWXw9SFbfh47sWgvuHceWjlILqySuM1J9heIQiN4t+QHMOtki
 HDpW7dwvY5bnhu7h92
X-Google-Smtp-Source: AGHT+IGoVBZklc6F6iyptSYqlpSLXzCQ4026vOj0CaX5ZFNFQncvCr0mS3sXntbqUMu5zX8Q/TxgBA==
X-Received: by 2002:a05:6402:358f:b0:63e:17ef:a62d with SMTP id
 4fb4d7f45d1cf-63ed8131597mr2586046a12.15.1761654587349; 
 Tue, 28 Oct 2025 05:29:47 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef82f2esm8878114a12.14.2025.10.28.05.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:29:46 -0700 (PDT)
Message-ID: <33a01955-2caa-4818-b4c2-65ff9b634d2e@linaro.org>
Date: Tue, 28 Oct 2025 13:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 56/59] target/arm: Better describe PMU depends on TCG
 or HVF
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-57-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-57-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52e.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> Simplify PMU logic by rewriting '!KVM' as 'TCG || HVF'
> (ignoring QTest, because vCPUs are not available there).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.c     |  2 +-
>   target/arm/machine.c | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

