Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D0EC36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpxD-0000Bh-Jw; Thu, 27 Mar 2025 12:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txpxB-0000B9-G5
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:19:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txpx9-0003Pl-N5
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:19:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso9685555e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743092373; x=1743697173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=37UGgZRLaje1C1bfuPmce5xftJXysUTQzfk1dmd5uEA=;
 b=eQ6mrWqFDFgH1STHx4XPVfv9v37epiKNDRDMbIMsC3uHIFmsr/+Ee+TZHXczwxghFM
 TmXIGS6Ag6iQ7w8ReTjxCn2H+/Kxcqa5JnGBTm5RMbX8jUepJ6EAiWiA7FobidzoRq7l
 cfBaj+luH2kzvF5Vqn8hOHl6hz5U2P7ijHAL2DL8fYbb++RCgAsYHTli9suc5Bp6CDb4
 bHh8qMovAjeAHn+Urrvs90qk7yzHHNM88Q2xJwR/ZjLCKWmPimVXNI8ujhN8h1CKp882
 TbB7bVnxOtx+r7D/j+794h8oqNlzIVd3jPIOlW4y1e3qRXBiZWy3jwuwYSWuw30/jz3F
 xZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743092373; x=1743697173;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=37UGgZRLaje1C1bfuPmce5xftJXysUTQzfk1dmd5uEA=;
 b=uJZUjS4d6sFNYQzNPNE8kMPEAnZb6DYXqY5/9RxTWi7ISgpS7qO9XP/rRxGSmlZBUu
 Qm9MEbcGrCVGAySK2VQWEu0FI64mXzGlZ/FVIDWyZRV/IdFJV5YNGoKlsjRLEVL2tNpm
 TCeox/f8VDO+J08VJ0fbGRwCuNQ8AWBVYnisXpmY6/S7sSi4I1k8jF0KARczLbMbQTGC
 WxMMPBIIoG9RMowoZW9HdG+UKrRZ+kY6i4l0FpZ5aXl6csnlv+g//nt5Kj+99sm8vPZO
 ktNELlhsDCVmbHrNzbW3FIKwhkTyY9d0Umk5Iem4wLnTda5dE96dZH59EFcEc8hIRVQz
 AnmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCtNdOFL6GEA2tRpkVaQIACXLjBMyBZ3BAYuDAq76yGiM+7yJigEcmc/1quOfg+PfoMz++lDy3+PPK@nongnu.org
X-Gm-Message-State: AOJu0YyMbzrvOXgfB1YR5tWwu+4nJIWCixQOlkyJbhp3n6XWNB/W6s4E
 LogFSynI5/tj4erEEpKcK1OGSyrYbny5gMGJrF3KgYE6keKRchHOfc+tAKGrNYg=
X-Gm-Gg: ASbGnctiuuGzxtLoRyIjYrBovr39ClUNKlUacy6JFKxp6Yg2xyZknfTv1UPnknLlhSJ
 JkEftGP/v17HxnKnVWzVO7SOZaWkqx7QwCEgX9SWwzUtmYc6/O3FnhxKX8KzQZHCGiRMCOTZ5ED
 cL6gMTe01L2fZ7QNdhGJ3jSlkmdBBmNNira+XSZ6KFghkkePouavB0Ux1wbDPCWwNH185qKvcZf
 BVzr4QoOnF96OSnjXJzTvd4WMLT+v4NKL1gH4RGC2PRowM1QPmNzp7cd+hZIxgYmDwGCQuYCmIB
 brnVKjfqD8SBZ47O5wj7oIvDJ6Aen00kfr2Lo9Vmd6uFLc5BH7Hq7JtwUzDdBl3XCTIu6Rh8off
 jnwqTuh0AiIl9
X-Google-Smtp-Source: AGHT+IHYsobm4yQjGpCDSd68WFhQYl5W8ZfyfyapZ+32gAsBtOwm5A7vZH7ADRUCeEWGg63bspkClw==
X-Received: by 2002:a5d:59a8:0:b0:391:22a9:4408 with SMTP id
 ffacd0b85a97d-39ad1749fdfmr4514037f8f.16.1743092373409; 
 Thu, 27 Mar 2025 09:19:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dedc88sm42627815e9.1.2025.03.27.09.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:19:32 -0700 (PDT)
Message-ID: <c794ca2f-43f7-4abd-86d0-650eb53602d4@linaro.org>
Date: Thu, 27 Mar 2025 17:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] i.MX 8M Plus EVK Fixes
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250318205709.28862-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318205709.28862-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


> Bernhard Beschow (3):
>    hw/arm/imx8mp-evk: Fix reference count of SoC object
>    hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from
>      TYPE_SYS_BUS_DEVICE
>    hw/arm/fsl-imx8mp: Remove unused define

Series queued to hw-misc, thanks!

