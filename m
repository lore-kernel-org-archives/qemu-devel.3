Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7CC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw8x-00050p-EM; Mon, 17 Feb 2025 03:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw8t-0004vz-4E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:06:16 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw8o-0008N7-JR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:06:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-221057b6ac4so24329785ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779568; x=1740384368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hOdEpt4KdSC8RUruEGebbtbS8AOhMXoksgi0SocakCU=;
 b=xSzNKFaEJMB+OA4BwAE/Xp7jtqeRTRuvFTaMkeBiBCc6Z9qwhQ1AI1Q7BJXJOJTkIe
 Q5W3crEQcv7DS9wvywlren+6WoffF4BkDofZl5sv/0Z2b+fOt2tbmWzVVi+wEhg+O9Ce
 W6vVHs1zl2bORq+W/5UM3h9iLG0uJW4Bc8EI2xxs3fbIj8mIu06y9BIx/D/vZjw+atzG
 j64H/LoXAWRvl7LBObrKCTbqTANWnQnDUJC++vmUZRXZ4YIZtdQmpLIo9nyiIo6rvAYT
 pQCUIoYtbILrSEtDmOBMx1sa5p67yAxIp0xSN55plGwegJ7yd4DWacCOwtwrT8pbqhMO
 mx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779568; x=1740384368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hOdEpt4KdSC8RUruEGebbtbS8AOhMXoksgi0SocakCU=;
 b=Z/LdhuHi4xRzvMoGwEH6yGsrJReBaJTPmCiEVgiKvmCDekNEoBMzJty9IAvybuVwXn
 6WloiGsDZKJNajXiiTvuA+PTjhG3VfgxHjf4cSz8sq8hpdnQ1UfD3n4pXeN8sHnhXU//
 hmgg8EsW+7aOJUPUwKhLoMeD2oTdKzGKyq3VeNoalOb8pVGeQvj6CDuyCDxzIL1mZFA6
 1fPP9frrpOlP9OnqaJh8RyVZGElv5v3BlrQwak0DeSn2pJuDM5q7jZtMSRfZYmvDFRE7
 /OvVKwoUB4ozUjv9MCKoUx+HyNp5+sXQeewRxSyMet2padyzNylyUY3OoCyzS3VJDNua
 VF7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbIT9+EDZX8UWDpKBIOpYD3fu51YvJXrnOp+IoTaRSChlQ7o8rI7p9XOFm0+56D3gfLQcYzEU/3M8X@nongnu.org
X-Gm-Message-State: AOJu0YzJKeKBkowm6MVTDjK7rI+S6WsPEuOYz7aveRxFy3PvSPpQbyoO
 fXZguViEmoW3zxnBc5UJP1/RbzKhSUWBfExZmDgYTyuYBrhtvvlBElMdO4dVXi7xCRR/nNNVVSl
 L
X-Gm-Gg: ASbGncstF9giDTLW8Ka3GdcKJb/PvNE6F4txwDPCPfCZEYSXf49dwFXUst1aeiulOxX
 E2jVA8mVR1OMxIZXbIgs6v7vNbevEDddcOs/+t2tYOf8i/bG4MQ/8BQTciFoxJjB0OrwaZDjx3y
 o6hNea0LnwJse1ASzYyuR7JKnOqi3uaig+dWS9Za1lMnOZwrUzkz2qziPOlzVrupBwPJFd2SB5I
 jTO5zMvjTzwueG2fgsowU8DNW7Ru1vpnE0muf7KGr8IxwKQHcTypNqk9xWeTib4VG4tCMRfpslB
 hll8F9H6DMN78EmwtFAzgEbGv3E0MA==
X-Google-Smtp-Source: AGHT+IEZ6rX9VsiS8nAwGOoKt1YUctxpgZqsg77gyEntkCokpQGbxIUFB/vezJX2qCHUWnfk9Pqq6A==
X-Received: by 2002:a17:902:f612:b0:21f:9c7:2d2e with SMTP id
 d9443c01a7336-221040bdb68mr154135855ad.40.1739779568020; 
 Mon, 17 Feb 2025 00:06:08 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53668d1sm66227215ad.75.2025.02.17.00.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:06:07 -0800 (PST)
Message-ID: <b7beec0a-f918-47fc-a1bb-16fc54885c97@linaro.org>
Date: Mon, 17 Feb 2025 09:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 078/162] tcg: Merge INDEX_op_brcond_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-79-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-79-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  4 +---
>   tcg/optimize.c           |  6 +++---
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                | 24 ++++++++----------------
>   tcg/tci.c                |  6 ++----
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  4 ++--
>   7 files changed, 19 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


