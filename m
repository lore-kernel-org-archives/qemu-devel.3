Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7F3D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1wh-0005x4-7R; Sun, 28 Dec 2025 20:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1wb-0005tn-Mx
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:21:10 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1wa-0001yc-AQ
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:21:09 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0eaf55d58so55907555ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766971265; x=1767576065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+fxO5/XW7dS4LIWLCSkyJ2B8Z7xKSKm4MqH012JIrHE=;
 b=MG1xfpkflo5iyPaMulwFSgjr1hR1oaG0KK7pgfALYT8D8BlzWvne6XxPvFtqD9gYmG
 GZVoMJ7DZF622jV5K5OjWLCgMxz5d06KBuyWmHvMbApU2fefOPl4mF57u+OoM7Bi8bO0
 SWioOpQcIdzbpmxdh5cl3W7RBT0Y2V9hCQxHq+ffrPtTYTFkL0SnLCnwN9t0DEE11VnK
 LJi1JhdnITsNElJOUkBoNBdez6flnhWPIOKxRCsblef0A1+qoH3n8cTGEOZF298VuAHS
 EPN4q3KQTbfAPlFmGhhOMPqLym0gOrQrusLkKTExOJbogOL9RWOQZPgz4Wx4hJu6zOHC
 tM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766971265; x=1767576065;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+fxO5/XW7dS4LIWLCSkyJ2B8Z7xKSKm4MqH012JIrHE=;
 b=v1eQqTuQZVjAyAf2CFTXvqFMEx8NM1y8WL/B7py+b6TLAE2gReBXF9hIflbvM1f5i8
 caupClfsvit5qckH1NYWUsS2QnhsNUrdOaaWWS6yIYh+iyJ6BuM02vDHvZtkC2GxRmAq
 GUKHnWbntdnPrh/K5Z1spcYU/COgwksdHu0uFEspnaeGFb+3jdw3UiHEj8/9FLNH+lvY
 XUPLeFBs6E7kKmylrSzsAbUCP7K7VPJKfl3CA44Ik6GC3/tVqR7/Z8BecqygpgM1Wpz7
 hMSx6z6F/VpiYeZAHVGXkZN7Z/6rp+NiW27SdNmLDO1EbvJEy/z2FmTl/KWOn2KrBU98
 fnLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdq6Fe0YNCwbVdAMtnQ0vRQjvFiAZJbIp4Vo30qcImjP6J9jEhRoXHyl1h3OfntcE2yZOGFU8ZGv3s@nongnu.org
X-Gm-Message-State: AOJu0YydgT9sA1nwqM4CU91pLDxbtHaOri9U5tkQCqD8a9zYy9W8EzN/
 m+GtUvFZxNhCwERQQ9OFfGF7RzhFboNnJkRvTurcONh43c6JTMranLFmdtSPnE06qc4=
X-Gm-Gg: AY/fxX7f9b+6vHw7Panf4mQqrteYE3GdwCizJPTZFmFhlMWTMjBT6UGcv953RdIXbVg
 D3fyJ0lH80EkkxyqCOqInnS5tSFZUEh3CHUs4RrQj6dhS5Se20mPREdz2WjA9czkpD2aVO8wpkP
 DjA44zRTx/y1K88E8MQnTHg0hfEckW3IjdpXo3PkTmt3zvam+/FXmVzvYBg5sFMnMIO/zSE9KqZ
 psoeQYoZriZvRgSYpNBJ7UfzFCZ1XJQcoZyLvsc5fsNS86Ryt+cHrcsysg7Buq5Ws0w7AUya5uX
 M8pOcHogK4mtL5ZrGTVgB/0uf4RDuCMye0gO6cC3EFf4f0mUurO6vJGzdi0WrtHUhkXFJeD0DbI
 Zfv8MPT+5yQc3fh8w4btN0h7PyQsUZi/5sts9EQSVK0jMqlKGoRM+aOyhIe02SVCtIfuOEqEhGw
 aIvzxY2TLLRYvmlg/jEAjWsjujR1o6+opbqjwq
X-Google-Smtp-Source: AGHT+IF2JOBrUIf+UCLWUrYk5ljXAFUI3X+YXTf8WHrBoeBI3O/lOjQZOL0r4ttoBeLM9TTx2Bqagg==
X-Received: by 2002:a17:903:3508:b0:2a0:9047:a738 with SMTP id
 d9443c01a7336-2a2cab1635dmr268540075ad.19.1766971264938; 
 Sun, 28 Dec 2025 17:21:04 -0800 (PST)
Received: from [192.168.1.105] ([206.83.118.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c8286esm258215635ad.33.2025.12.28.17.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:21:04 -0800 (PST)
Message-ID: <9f1fc42b-1321-471a-a0d5-a5d7f3e2af2f@linaro.org>
Date: Mon, 29 Dec 2025 12:19:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/arm/Kconfig: Have FSL_IMX6UL SoC select
 IMX_USBPHY
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20251224134644.85582-1-philmd@linaro.org>
 <20251224134644.85582-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224134644.85582-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/25/25 00:46, Philippe Mathieu-Daudé wrote:
> Since commit 17372bd812d, the SoC used by the mcimx6ul-evk
> machine requires the IMX USB PHY component.
> As this component is only used by 2 machines, do not select
> it by default (it will be automatically  selected when
> necessary).
> 
> Fixes: 17372bd812d ("hw/arm/fsl-imx6ul: Wire up USB controllers")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   hw/arm/Kconfig | 1 +
>   hw/usb/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

