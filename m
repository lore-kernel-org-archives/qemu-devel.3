Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35E6CD343F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 21:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slb3Z-00019O-Lh; Tue, 03 Sep 2024 17:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb3X-00015h-AW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:27:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb3U-0007H7-G3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:27:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42bbd0a40faso38756305e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725398834; x=1726003634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZPFZREp4XuyHs/dUTvnynF7PvffAISud2Kxq5p2U0EY=;
 b=tkK3E4DOBWj3w4gMQPhdOIAI+wXFo5hZ8UHC1u6G2bWE/46jiPBxxMA7AufZTimZ7A
 Rzvefa6xVSjWeYhuQ5tGSnIF+XHe3PBWEpKLHvO+f1bfv6lBY1qfyFx55yPaS1NGOBR/
 yeuIUuv5/NcdjChuprjYq8X1NYAkcNh3ytuiyy8EDm4PUcUdhvTf22Vix7CoXx3HH7i1
 jKCUvZ5jwYIANqUyyxldXXVU7BE7P0/tZbtqAxvNVEBm1a5o3isBPFgjCkHIW1EuqNQU
 dliswUipKJbSFFAU3wXKSNk8vq4NdEZ64+ajEfCru6TVJPKSt+sneQaNJReezOtwl5mk
 3v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725398834; x=1726003634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPFZREp4XuyHs/dUTvnynF7PvffAISud2Kxq5p2U0EY=;
 b=ByETOpX/ePzEX2yC8Z0ta8UNUiawXLyj9P3aSR3pTwFvPwhZMkqQKWdkeJa3A0JF/W
 D6WZ6aZOaKaeKd+6BMdWZBbVQ8LFk1P4hUup9Qb5jiOCeTI/I1R4yjJkX278ZvZq6qBk
 tIxNSHwc8FfhwTu/5Tpi0uzrW+Oxajl1MLSGNxXH9V1xHQ9rhu8YP9WSR4s2SCFmWazU
 /i0+NLsK4eqmQv+r3iDmsIuR335PLpzQMXBEa21q1Hc3NLuYzZ1e36YYRCIRcUiNGVOs
 8Zrr7vHQNFm1te3ssG3WN8hPuXgUR8sDcQL4/yowWLYYRCaCUTlLF1+4kJXYaCwROrEv
 ZRZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7p15Aj/h6Aypkm1H4159sfQoPgONwpXdiL2ulZI5YGYk41H/XNzIQjBQy7T8ywVXK/06yTTwuTvod@nongnu.org
X-Gm-Message-State: AOJu0Yw+nFELOP8OYaYZHtZKIwIduULeM4OqfX7KCAV0fvTDUmzupL3u
 JkfLdBLWMxdEOONr33qBPbUj9L6SI+M0zbWeTqbQ0HoaW713lVPlifFTzurbofg=
X-Google-Smtp-Source: AGHT+IEtyYGqblMTtRzLtEQbkqKUTemoF+HSZ9zuRQPGY/Ok1OapbcNpBkGu9Q2HkcjiEgnjLS0dkw==
X-Received: by 2002:a05:600c:1c06:b0:42b:b594:4a8c with SMTP id
 5b1f17b1804b1-42c881030dcmr36889475e9.27.1725398833870; 
 Tue, 03 Sep 2024 14:27:13 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb303sm186119555e9.9.2024.09.03.14.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 14:27:13 -0700 (PDT)
Message-ID: <de5f691f-ef22-47eb-a6d3-7342c0b4e008@linaro.org>
Date: Tue, 3 Sep 2024 23:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 09/53] hw/arm: Remove 'connex' and 'verdex'
 machines
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-10-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/9/24 18:07, Peter Maydell wrote:
> The connex and verdex machines have been deprecated since
> 9.0 and so can be removed for the 9.2 release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |   8 --
>   docs/system/arm/gumstix.rst             |  21 ----
>   docs/system/target-arm.rst              |   1 -
>   configs/devices/arm-softmmu/default.mak |   1 -
>   hw/arm/gumstix.c                        | 141 ------------------------
>   hw/arm/Kconfig                          |   8 --
>   hw/arm/meson.build                      |   1 -
>   7 files changed, 181 deletions(-)
>   delete mode 100644 docs/system/arm/gumstix.rst
>   delete mode 100644 hw/arm/gumstix.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


