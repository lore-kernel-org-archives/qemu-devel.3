Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C269C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjE4-00068c-OJ; Tue, 30 Jan 2024 03:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjDw-00068H-0p
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:12:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjDt-000150-9W
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:12:03 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40ef6bbb61fso15488105e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706602320; x=1707207120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qay1U2fKNw0FV5V9Q22Q21X9XdGnsoOE2/qXCphsTgM=;
 b=Op20xv5nYK4fOGj7ee1spwMMvqCsMo02y3sVoDdP3NFp8P/IS1lLbWEKOlYGAoCGBU
 WJ08OYANah50DihsfNNOYIXwiHBPLDhS4h5Zd8VE5+r98BO939ZF+zX1s+z7WqmYqBSL
 NGYPC/VPLynSIlaK1E5h2VZi8KPqAdnkvhlcIGeKOuDIZ+gXGlL94FTmzjqqhoMW048d
 hYIqak+Ax1K2g2vjFORoyROuPRtsHQzlVWaNobsNvZYU215Zk/2eJ7qePbsD2E5oeSZG
 d0mnmGfVgR1Sr1xlDZmUzF9yDmreU8JnTqOHwA3uQqz0jOg1y5P76Go7qa/Edvq6AzoN
 Q6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706602320; x=1707207120;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qay1U2fKNw0FV5V9Q22Q21X9XdGnsoOE2/qXCphsTgM=;
 b=SQkZ35ovjX0etn/bo3hIpVdGyep/uLKmV3NP12VFUhm6qg1WDbeLVFIP61omBzEq8Z
 RWNQHEYKLS2l96yTbuooYZj8k0s5kTMDCxQxXhg8ko8+U0VrzPQqhVyAZAmBSjIEXGOr
 snv27thr64sDXM+fHXDWlH3bfEWlfZBfZ0RgZkSRu4deDtVX187QDQPWg1dIYhcfIXLV
 0h+KrgIzbOKgvWlIXmVDzI6T4kPgy73yE0HliDMBlpLRqhOv7FErTW9uJu0wqAemIY3j
 lSgn0ki9abQa8jsTVFN6NWx27zqeOymiqrKERQfJXlGSIgWEXpQpMg82IaSKiebkdU0e
 6O3w==
X-Gm-Message-State: AOJu0YyhaunwxcpCX9goxMCnFIKvfbBkwP5X53Dm+3Qtp+zdl64nH/3S
 JKUQr/yYHbfKj9J0zpiV0KNwHnkjWdd0aC9EPk9CcqAYh+rx8ygm3LscZJulaVk=
X-Google-Smtp-Source: AGHT+IEiGP+qCMo7tS00fnCBlsOkBchiFqBlAY14NPbpDeLleajNBhDdt+lHC2TnCljxTRmYMdpieQ==
X-Received: by 2002:a05:600c:4f08:b0:40f:993e:3591 with SMTP id
 l8-20020a05600c4f0800b0040f993e3591mr181304wmq.3.1706602319904; 
 Tue, 30 Jan 2024 00:11:59 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c4ece00b0040d5ae2906esm16186462wmq.30.2024.01.30.00.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:11:59 -0800 (PST)
Message-ID: <fd01306a-4c81-4f49-8dc4-74080330653d@linaro.org>
Date: Tue, 30 Jan 2024 09:11:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] target/split: Split ver from env->fsr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <20231103173841.33651-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103173841.33651-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/11/23 18:38, Richard Henderson wrote:
> This field is read-only.  It is easier to store it separately
> and merge it only upon read.
> 
> While we're at it, use FSR_VER_SHIFT to initialize fpu_version.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.h        |  3 +++
>   target/sparc/cpu.c        | 27 +++++++++++++--------------
>   target/sparc/fop_helper.c |  9 +++++++--
>   3 files changed, 23 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


