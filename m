Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFD3C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 11:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueY2J-0005VB-0V; Wed, 23 Jul 2025 07:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueY2H-0005Ne-HV
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:53:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueY2D-0003lR-9R
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:53:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45622a1829eso21443865e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753271596; x=1753876396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rfPXPK+dspT492ooD9gL2ktzyRKmsEWC1OvkOILQ3tU=;
 b=Ge9GRO2qafHLxvpyV4ybDzy4gIee3qK9thozQeWm8tj0QOPyU8+7QX1l5MLREWTT9w
 rSAV1Z5RjmsrAlIPExwjolKZ6mObN6tnnLhMhbeTEusWcoKq9KQwjNjZ7kRYp+x8Xf3i
 pdpQGpe0Y3kjZPnGZ/imiiIGsarbFpOxU+2n5n3bt4yxNaqaqzKXi2vTcLFKnJqoWHLB
 6qBLUnt3EKdBtEG9iwnABebsyoO2yOQ6ZLTZFSPZ6wiahNXYICjDLTEWEWdIosGiHw9+
 g0G+otFv988gGQL+w++ef8qVC3iQzU0zeYzdkmAo8oQTmtkiDXa46uYaw6GLff195Bgw
 kZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753271596; x=1753876396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rfPXPK+dspT492ooD9gL2ktzyRKmsEWC1OvkOILQ3tU=;
 b=s60Wfvrc8RMwrP2TVe+v9iKsRhk5l00E1tSyYaXiU1Mrf7Z9PRJUVWf8J7QyJgqupa
 h5y2W/61lMSBrprX2HpnFtnAl2T4Dc2/SG6kDk636gxmMR47XcIOEdyAm+CU0lxFvj7a
 FnR3euTVScSDPsWVoS9ccFs7Nx94yWGvWKsRs3exFe7b8iY2y5CLtMe2az/8ptA8G7E0
 b3gnhrQ8YtQtv4Bcc53nNT6op8EYhT/7LZIZKCGelrfpxZ7ksHqbsE7+jEOatySpD2oF
 wJ0s+iVRFIjziGUQGUYffJTjd2HTeudNS8rdrWPQHx3l6uNDxnVlAZmFohycusicMvNY
 tung==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl7tsdfDRqDVe/Jx9F7yxtD8LFyJd3EcsiIKEtmFbo6Kg0egSXvPCebAhF6VMOodme1+4Zv08v9qLM@nongnu.org
X-Gm-Message-State: AOJu0YwecvxDi8fr+8bzr9HL/Eur79pRV4hs9ugb7Fxp6lDyLyqd823D
 fmeGGrHOB5MFBYECAaTgGuhcpyByN4IFyOawhDFAp+K2jFeI3uBSPYS8eRJH7VwsSSg=
X-Gm-Gg: ASbGncv6MgaZ1cwNY2kW6YrXjCQQyZqql4pRhwffNZh7bDapXlWr1fO2bZ4rorqgNhi
 6GA7/cY5TLTp2bmFNn0nmQ1g7dTeT6r53fQxONE7lcZzOVkZuA46f6ITRctCgEVnI8yN8w8HF/h
 32DSqTyEC48/KW+gXldBG827J+KYAGR9meRX0gyhTPzwv1df5flnSCvc/9Xfx9ivjM9/fbdMvKe
 wM7FXoe6ZR/UP7DMolpaoKVsGiKHGGghxyZ/8OjbeAM+TJr3fT/+B2QYV77sZgAZ1JdvbYx+GVf
 FfcCg9AjM89oWTIzyj29duOPnEJ9GlKvyA5tgyiIfWwCRKh2N7F3r8WR6NXPbshQ7XHt2XLqwqk
 L3ijH8OBkWmkMtDd4JsegAwoEC10hRT3rvTCPo/jrH/NivhVbp9//7U9kur9Fp/ylrS4MJZyUWC
 eECQcFBA==
X-Google-Smtp-Source: AGHT+IGzbr/fy3Mug62W4tAv9c6ICJvtNwV3ugQAvvM5FRQNOWeMBTA1JgZvXBbZKZOYHI1wUctKAg==
X-Received: by 2002:a05:600c:46d2:b0:456:19b2:6aa8 with SMTP id
 5b1f17b1804b1-45868d48911mr23807665e9.19.1753271596249; 
 Wed, 23 Jul 2025 04:53:16 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd0e3sm20568985e9.23.2025.07.23.04.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:53:15 -0700 (PDT)
Message-ID: <2e33ae2c-3804-4307-b109-4e8b34e19f87@linaro.org>
Date: Wed, 23 Jul 2025 13:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] decodetree: Infer argument set before inferring format
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250722183343.273533-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250722183343.273533-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 22/7/25 20:33, Richard Henderson wrote:
> Failure to confirm an argument set first may result in
> the selection of a format which leaves extra arguments
> to be filled in by the pattern.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py           | 7 ++++---
>   tests/decode/meson.build        | 1 +
>   tests/decode/succ_infer1.decode | 4 ++++
>   3 files changed, 9 insertions(+), 3 deletions(-)
>   create mode 100644 tests/decode/succ_infer1.decode

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


