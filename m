Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D51BCD342E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 13:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slTQu-0002VZ-H3; Tue, 03 Sep 2024 09:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slTQq-0002Sw-Bd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:18:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slTQk-0003Iq-Lo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:18:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42c828c8863so18811775e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725369523; x=1725974323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NKCLUNEmRz23/+dRcGIxS6GdAtfM6ay5Pf5/UaZssMo=;
 b=Xo5zBXuoynDYVmy9AFUpkH4pyMRrUj+vpN1upR/+OfL2d6DInfw4X7obp7I4k+9Ax2
 3V1IFWmAVkjxmcbqbuH6B03XDocZFZjqrW8Kg7OzZXVsMjg0vsm5vJ/NwnI3OsUbjHlt
 yvDB5DebNsiAnAS7McdoxkLvaZpcsz/xx9ULn9Gf43ePOVWWIi/d88zfhZRGTJyQa404
 H1Enu/UPSIhlraf5W/4I0T8x1OIqZErtxFC9H4e3IQmBKUa4GL0ZsbBPETieKnLwScrl
 b1RrZY2uc152EevqDDw3UiGe5M4jaJgXVNKGUK1gjXl4KJyqCnR/49bev97P1vJKO68F
 1tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725369523; x=1725974323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NKCLUNEmRz23/+dRcGIxS6GdAtfM6ay5Pf5/UaZssMo=;
 b=qNa31X7JEA3g/HgOwU2pbC7k/ougiJG7QwjY1OSTSCQq7C2HRHbX5hIK0TBaj6ttr4
 rjWHT3wsTyugOQlcFkzHrqGWiHMQJIBasx1dVmYJ055337G/+tsRKMIr8xna4bZE7Ohd
 VQkZhbTJ7pBauMYum2ZXbSP9E0owNobn0HEVfuC9uI7XW6gx/teV1AEuOsiPHDdGd6zS
 phZbF//FupNcX8ELRdAK4nlkBq7ZYJvzK8s9sXRhYSFVMWNnZsHsJOin+w4NqOUigO2P
 z78dTu6G6PuV4QBXp7jiRmU4V/kseeDgDIVnQNtcQPt/KKKFaJ1xDRXBO7fs+dd26oF1
 LQ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZyz13NTb2VoU0RpByP3GgOg+lYz7aZU93xDhOn+enlz1A3CG2vdyaoufPDjACeZ/ZI4PJP5kkto6s@nongnu.org
X-Gm-Message-State: AOJu0YwlcSZ+G5OeeBIxaajeNJHRUqzAcVnHWqCXWL3Z12Ym9CoH13W7
 41ZRMORJvBLT8KQTT83vV5nfLa4opRXQ1I8MyTTnjAolmBspGQVUOPLw9fw+ASk=
X-Google-Smtp-Source: AGHT+IGILYaDUbIE03G7aTho502+vRVy2GX2F5LCnL6nHSHaX4rsDujyzv//R6HTG/DFgVv1xaXPgA==
X-Received: by 2002:a05:600c:3c8b:b0:426:5e91:391e with SMTP id
 5b1f17b1804b1-42bdc64e46dmr68489655e9.26.1725369522570; 
 Tue, 03 Sep 2024 06:18:42 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df936dsm170731555e9.28.2024.09.03.06.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:18:41 -0700 (PDT)
Message-ID: <7fda2f7c-091f-4b8b-bd61-5f8fcbbcf8ba@linaro.org>
Date: Tue, 3 Sep 2024 15:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] target/arm/tcg: refine cache descriptions with a
 wrapper
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: linuxarm@huawei.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 Jonathan.Cameron@Huawei.com, alex.bennee@linaro.org, jiangkunkun@huawei.com
References: <20240903083520.209-1-alireza.sanaee@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903083520.209-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 3/9/24 10:35, Alireza Sanaee wrote:
> This patch allows for easier manipulation of the cache description
> register, CCSIDR. Which is helpful for testing as well. Currently,
> numbers get hard-coded and might be prone to errors.
> 
> Therefore, this patch adds a wrapper for different types of CPUs
> available in tcg to decribe caches. One function `make_ccsidr` supports
> two cases by carrying a parameter as FORMAT that can be LEGACY and
> CCIDX which determines the specification of the register.
> 
> For CCSIDR register, 32 bit version follows specification [1].
> Conversely, 64 bit version follows specification [2].

This is the commit description,

---

this part is not relevant in the git history and can go
(hopefully the maintainer can do that for you),

> 
> Changes from v2 [3] -> v3:
> 
> 1) add only one function instead of ccsidr32 and ccsidr64
> 2) use deposit32 and deposit64 in ccsidr function
> 
> Chnages from v3 [4] -> v4:
> 1) Use only one variable in the make_ccsidr function.
> 2) Include qemu/host-utils.h to get is_power_of_2() declaration.
> 
---

keeping these references,

> [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> edition, https://developer.arm.com/documentation/ddi0406
> [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
> https://developer.arm.com/documentation/ddi0487/latest/

---

and dropping these ones.

> [3] https://lore.kernel.org/qemu-devel/20240830184713.224-1-alireza.sanaee@huawei.com/
> [4] https://lore.kernel.org/qemu-devel/20240902203211.270-1-alireza.sanaee@huawei.com/
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   target/arm/cpu-features.h |  50 ++++++++++++++++++
>   target/arm/cpu64.c        |  19 ++++---
>   target/arm/tcg/cpu64.c    | 108 +++++++++++++++++++-------------------
>   3 files changed, 117 insertions(+), 60 deletions(-)

Thanks for the iterations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


