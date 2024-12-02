Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC723D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI78t-0006XJ-TC; Mon, 02 Dec 2024 09:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI78r-0006WS-SM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:11:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI78p-0005e9-27
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:11:12 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a9f2da82so37205665e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733148668; x=1733753468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WvPsm0TjW8fJC6DAO1OLRtlZ7O9pZZ61/u+lKnGOvtY=;
 b=wjPV+Q1cpAIkqYqNXsD8x1jIA1f2c/JqLhDVvGpjdSH7ZydE/Nd+tea8esWIdvYbsa
 y5iIfsUj2p/Iox0P9iqBsXmm7rO//cBITb9IHClKNYa1UN9xvfn0sHoqCHeUT5jqDE/8
 kf80gjcfteYe7EuJwADWdThKSOIky4zTJZKa5GHwckAPtLx+Iq2IjLWaWYoV1GYDEl5A
 NRnUGDeqnLY6YEo2yfhDSHNO5hVPvwnmfg67LWnD7nRUCfSYbHvn/XhUV9x3ZQxmu4DB
 DcrWUkn0GIUjg6RBljFbzJ0BMcmi4GTNiXtC/gVRoSPBnVCRvE+PrEl3TQy2Xgz2gTCl
 synw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733148668; x=1733753468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WvPsm0TjW8fJC6DAO1OLRtlZ7O9pZZ61/u+lKnGOvtY=;
 b=aAz7/KpRCtvWRn4ibz37dbeOITYbOhDRVaX45WIkjeyUCTK9Qzq9IQQttjrr/6BZuF
 pxEfAUrQlnDjukSIxRcIjJa6ccOeh75z22I3SyMD9/xCP/y5TfMhel4+TB74oFT1sw+i
 D2dQtGbg5Z9xTf2z8JIOv89uEznsMXCCBoaC1ACk5z075xskdtWsGfqoJZ2KN5V5Y8ie
 cUKARdrJxLBoQsLpfKLtrqsrs3sV7vPRvE4H6B6ej7q7FBzfTm+MkYWtb7Q4ul63tmzC
 AKJMPl88Sr74E4HrJVUL8mCZD9rxyrUw2g6daVoBxUMvARfnaXgDW63z/+D+aVFNDRgs
 FX6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgAu9fyseC5uhrCEXZ5jcviplFKy+ZZmubcCdbZrxWayVXJUOeDXiC/Aewb67bcjgpC8PGnqDy6LMt@nongnu.org
X-Gm-Message-State: AOJu0YxTOADjdMaDSNXK+l+LOb/XgOu213iCPAQVCROENL5aF6hMuQqO
 ytNDAa442aQW7OryxRRjSJ/bi8VbWXZyVX0L0pneIN/PdyaB888jPOVqrY/I+/A=
X-Gm-Gg: ASbGnctI8K+jtMR8L8Y7dLvX8ZTcnjEXpnFpc5NSxSlK3I6mqGHyekJMmf+r/aO+DbI
 TBYVSjAxOXHPNozWmZi923tZJNoQ7SmyhoqsuBSgCs7bPjyul0ZcCFBMaQYGIGo+uAEt8TFKCcY
 QXn5ymS04cs5+dwcH4rJNtYwEFGuLhEjoSNcUviGKbkt2gZlQO5Y4JaAqE99T/KO3ORQ8goN1Vt
 32C5ab/JW3IuE/R2TF865yYEEKwE6O+GJgnDIffvjWZOeq5ocrMpdgtPjEIjtXqZhkwMpSiSIcr
 NhHuy+l/6jVNKazcuBetPLL0FPDQwA==
X-Google-Smtp-Source: AGHT+IHIfGi0pqqf5mKJaV5EA8wy9gHojZXhMelpAYtHFf/jEehpXAMD5im1n0gSdjPp3TvHzkPOIQ==
X-Received: by 2002:a05:600c:4fd6:b0:434:a781:f5d2 with SMTP id
 5b1f17b1804b1-434a9db8483mr200592955e9.5.1733148668144; 
 Mon, 02 Dec 2024 06:11:08 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e429ebccsm6899146f8f.10.2024.12.02.06.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 06:11:07 -0800 (PST)
Message-ID: <232353ed-77ee-4a37-81ff-88b89840be1c@linaro.org>
Date: Mon, 2 Dec 2024 15:11:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/67] target/arm: Convert XPAC[ID] to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Remove disas_data_proc_1src, as these were the last insns
> decoded by that function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 99 +++++-----------------------------
>   target/arm/tcg/a64.decode      |  3 ++
>   2 files changed, 16 insertions(+), 86 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


