Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BEEC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwyz-0004tv-ME; Thu, 25 Jul 2024 07:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWwyv-0004qR-Ts
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:50:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWwyu-00037j-4x
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:50:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3684bea9728so472424f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721908198; x=1722512998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+NxrlB5rX7BGR0AltB7CeIZMcUIPzmHDSdUAkb1Sgk=;
 b=oMOz7FIbBlVuZYPGoxnM2Y82h1MDdG+/OJfECDp0a2Ikeps8UOlHknBjj9VmfFgrAJ
 QAA1df/GsmcaoWMR59/7NaWhCJYt8C+voNwZF7szF60a4Kq7p6N8Jn5REq8ef8Zr08+J
 wMvr2mrCnOCb41tDtDShQe366QJ+ALrMm3tSVLGHxfjHK/H28JOvnhm1ubD2Gg57H67e
 XgHSkBOcAKe6JwPTISv1J+NbU4se117wOGQfVkZWMMB0T6kf5Q0rIT0sPVc2ovi3ICpE
 3mK/lUzo8pQfbeJrgL5Hw+z+e33GOPY4cocWtThy9AWWs5RHmSDY1Xn+vTAga2eXnrUt
 Cq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721908198; x=1722512998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+NxrlB5rX7BGR0AltB7CeIZMcUIPzmHDSdUAkb1Sgk=;
 b=TtpDfkp8mIELA4IIwVKZrAXfai/j4y+x6A1AyubJ3BRQmxOwbe40HTZyNW8qVo8E3u
 hhchYj7vPKSEvkeecZhX2x8COKeLU7vnWp3hDJuzg5f1Ci68UFKZiVzn1e+BxvDwLsoN
 A8/72kCzCsV/xJbMtIJwBxJAbG+CuwXduRpfQwSpeiBFvLAqzW/7hjBPI38jx93x8QZ6
 uy1E7Oul2y8tJxQcG6wyxFslKRRkuIBJEI4tAbqgoAK8bPnae++ZeY+hpQvHX/oSxzWf
 ZXflPMWztGfOH4D8Ocpe5gkphX9HL4/gNcXPuqsS0KeZitAzjLFFp1XkhZAOFcDntPiT
 gFKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz76qKLxE/J+o9eaMupsftTSwFEL01ZK7mZ/GIX3AF0fBLEbGjyWBZO+uYxQ5z4IirMYn8bno2yg6n/Z7NtRNUA2PDm30=
X-Gm-Message-State: AOJu0YwHPY8i/6XGjCMJLFBZfleIX6hw5CD3xvEe3YvoHpi9OQIm4UrM
 IMgyOOhDwCDdjYsPpTGUJnb1TY1M9ketqYUbH2aJM/4vFHFGLsOXssvFsYJyu/Q=
X-Google-Smtp-Source: AGHT+IGLGddsWNNoWsqNTgg6oKh8n0W1xeWGkShIcqrj8gbsRSiHw9dHLXX5BTQbNdIdQU51BHcGZw==
X-Received: by 2002:adf:f38c:0:b0:367:9803:bfe7 with SMTP id
 ffacd0b85a97d-36b367b1d98mr1381217f8f.53.1721908197912; 
 Thu, 25 Jul 2024 04:49:57 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862271sm1904114f8f.98.2024.07.25.04.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:49:56 -0700 (PDT)
Message-ID: <916e3941-5dd6-48bd-804f-ec8f1f925843@linaro.org>
Date: Thu, 25 Jul 2024 13:49:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/misc/bcm2835_property: Fix handling of
 FRAMEBUFFER_SET_PALETTE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
 <20240723131029.1159908-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723131029.1159908-2-peter.maydell@linaro.org>
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

On 23/7/24 15:10, Peter Maydell wrote:
> The documentation of the "Set palette" mailbox property at
> https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface#set-palette
> says it has the form:
> 
>      Length: 24..1032
>      Value:
>          u32: offset: first palette index to set (0-255)
>          u32: length: number of palette entries to set (1-256)
>          u32...: RGBA palette values (offset to offset+length-1)
> 
> We get this wrong in a couple of ways:
>   * we aren't checking the offset and length are in range, so the guest
>     can make us spin for a long time by providing a large length
>   * the bounds check on our loop is wrong: we should iterate through
>     'length' palette entries, not 'length - offset' entries
> 
> Fix the loop to implement the bounds checks and get the loop
> condition right. In the process, make the variables local to
> this switch case, rather than function-global, so it's clearer
> what type they are when reading the code.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/bcm2835_property.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


