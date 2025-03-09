Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B2C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 19:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trLuZ-0003yK-M8; Sun, 09 Mar 2025 15:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLuC-0003ii-7T
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:01:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLuA-0004Dv-MK
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:01:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so2691103f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741546900; x=1742151700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y+8UUz7WZSetrlJwzo1N7675l59e6jcgk59FlH/9Iqg=;
 b=qhqbhgV3UodcZ2YyJtjEvDjpCnAuhCtNBLvEDmBPPmptByqgMKsk9rW2qyOg8McDJR
 TPLUIIXtswx1Dka/lD3pT43gLlIFeB6Q03FkT2whU3TKA0dTEHLtFITRDJVgcDGT50mM
 H3UdaEMojTzrYCmZdUMvZPqSQkv3f+hDqLrwkNuPDciLKQ9LRXexGRPOIART7fdXtjUQ
 JErzGv52xojxkZBT3NCBdM+HQzb5V624JRr6BlYmEUpghGT+72NB/uBWmZWk9854UUCD
 MMRnxAzHVLt/Pup/NOxHZO2OpZtzaxUOQV6BTLeQHhdAuqFxK/dLcJaNwOd9UZYUI/NO
 wR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741546900; x=1742151700;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+8UUz7WZSetrlJwzo1N7675l59e6jcgk59FlH/9Iqg=;
 b=GQ0DkEayge6TseIT0HA8GVXaWxbp6uOsZgQHMjPGmQpxy1PLTa32lVzpwQ4QDJi0l8
 rKtk4BO5YcrBGcRKnbu5PI41KuggFTcO+cFVGij/LPitsw2ZsvALPC3jVz2q9Y5fV7ws
 shtnNPqAND6+LzxwD8cCHfZrtjiP69ffHtwm8XV8CVeBPT0UsbQW6pzNpV34WKF8HoSy
 KET04ejoiMG79xtIOeGEuNrqQ5mCGe6EO1RN6VJtPziZE89ZlJdf60X5R3OZUnMXtUr3
 /NGHTaROCHPfK+mOyiBKP3AsUQilpSNOCWSeZjiAHoQoGeGP+k+81ytYlZtaEJoJhR9H
 cvYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2l39bknP4hhRezf/Z5nwupO+S0bnSDuYIp0yHWDlFCZWKCBTIGio3bVEJRpnhGhkMB2g5Y/CcNBPF@nongnu.org
X-Gm-Message-State: AOJu0Yw2QnI2/LLt2E56ytgoIb8q2ARSzs/ZftlPri9m9Iz6nB7Ilgyj
 sKl+XQODs5zLfM9rL/KUEe/kaCeqFyVfATp1E14csnPPiqLGAJU/lTPaKbS22RtTOEwMOagCpBY
 1ugo=
X-Gm-Gg: ASbGnctuO+YsJiRpgF++MaZz7idPjtzC66GG5LIrtgtw67KHRtcgSK3yFmIzC4Xqa2x
 F6x4cFY5najqkJRj/NwQQfQcJ4aeyklRR3iqxxjil5O2rTcKRVqqrI7NJB4MNnVbW0K8npGqq18
 4VTgvBfyatxB9F3C32dCUqCDk+KdNcUZULZAYU/tbAjxAWR8K22P2BcaV+y2BtTBi1/d7T+dqrN
 u8yv4QzFKEL9dbIcf9mLs37EJFytbO56CBX3bVjKTVvJ+hLHKaugHMeXZ4F8U1mHvB/apXOaBft
 Ehm1pMrlJCwucBNT0to2BbPEuk1s41ehE6Eie1ASIl9VZThDpwoGl5sWgJ2haHZp1l5sxmsT44V
 eBH+pUBgBeIPz
X-Google-Smtp-Source: AGHT+IHPuBv4WJ8glg+8x1cLtOGG5qnB84Qkixz68e/B71Vmz1a9ow5lQgKxzXPEMBxJg0O34sfmNA==
X-Received: by 2002:a5d:64c7:0:b0:391:11b:c7e9 with SMTP id
 ffacd0b85a97d-39132d6011emr8085889f8f.28.1741546900590; 
 Sun, 09 Mar 2025 12:01:40 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba686sm12821876f8f.19.2025.03.09.12.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 12:01:39 -0700 (PDT)
Message-ID: <709cc2da-22ab-4b49-b819-177901c3a444@linaro.org>
Date: Sun, 9 Mar 2025 20:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/net/smc91c111: Use MAX_PACKET_SIZE instead of
 magic numbers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
 <20250228174802.1945417-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250228174802.1945417-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 28/2/25 18:48, Peter Maydell wrote:
> Now we have a constant for the maximum packet size, we can use it
> to replace various hardcoded 2048 values.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/smc91c111.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


