Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BF5C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pmX-0006kI-EG; Fri, 18 Apr 2025 13:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pln-0006e9-Kt
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:44:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5plm-00020Y-1m
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:44:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso20082245ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744998292; x=1745603092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FBs0kLucWAI7iTiLkgSuYdevjRhDhY7bw9HTmA5X1nw=;
 b=Zo1e02VssJR7Tvp0ONiOzHZmZcaKdxSf133jmTpqR7etcoXIHp6KNpJBZom+vAsxbH
 AoaYaGrhe7h2o7PVVxIY3ualvQ08oSBODKsJV9riERGlBcyUqnylix40Z33VDwQr6rkX
 TexjuQMqMvIhlHnq6Fj9Q0H2mwqXhZvliI99zvoX5jI0KjzDIubpbFnowGgONpFgGz63
 NiKp0I7mJk3VxxcZOVtsmkF0fqy4AbRhIhLzsTG2/icRd5HfenGXLN436BOwj3MuWokw
 t9lo0XvSXzdKZMITdiXADCpFAxphcd7xFSSif977pSi2Ir92nXy6xDOgtxl4TIxDQthb
 u1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744998292; x=1745603092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FBs0kLucWAI7iTiLkgSuYdevjRhDhY7bw9HTmA5X1nw=;
 b=Fp+fMoR+M1DJNcTappsF1P1uodixcjoTpdu3SZZns0p1WKXFe/zKtrzcnRC//GADG2
 9jCZvYh1UmRAEKJ6XQKW13HwhdLtVXZEQ8fTmGuIk0jJ48/EG5UbS+RKy0LQddnn254c
 9HTme7dzNZxdLD2YuIko6NRMtCGjtAv5jVmPOTx8vxG2NVyG7M+FQ187FEZVBy+Ww6Dz
 2BZiaBQm3TMWumvfibH94yKCbJ+HyRRwoW+sDbcut95E+YClkLHoLUWQMVoZOMP0nJvJ
 M1ghRJj+RFXbTrAbQR5gepu+bVRBUy0BJCZNYgv1oHmP8mouAF7KztGA7b6/9teOjj1V
 zUXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdNLkzpzvt4UtbE7OXRewAq/wZhE3f3jbBjZ8N11xEqfk0FTC8viKy2YnMO7i/rOIzZC5TqI3DqN8V@nongnu.org
X-Gm-Message-State: AOJu0YzEsPHwf34qR9bjkoSOs1cFE7Jj2Y7Cdc6zWSVCxze97yHRrrv3
 GdyP9zjSV45Y3cd8u8drLOsFlZREryTE4p34TjDeG1eooVuGT3nhaxj5sbaR7iw=
X-Gm-Gg: ASbGncsdtAbai+5wDJHDzy5FeSdn3pYZM1Tmng6xLlBVSjc9le+2ohn8QRwQQ4HnSrd
 B+Md1m3Y8PY7AIRb6lWIL3Lrw8OKVDY8PYp35BjMZ/THQG578VaJMDeuScD+rMrve0kcUX31OXD
 Wl3rylkhyDkZGAfUCF/xjHYeZ0Au3yUIGyDaaY39/VunHRC9YKM/auGX+P3NoD/nXAcLCZ2jtMV
 M6oMgrAJ+xY1lRD2yTnkDUu4/YIL0a2yEuMdeqLXs5lcNpvm7mL/FBfG0v/wUEx1DzRMSfcxB1o
 v/APeaWvjxZlDjndf3f5Vyk/JyIf8DTo9YoWReNjQkmJPMKb5C50Ln6+m8/A036JFEBSpCqlSVc
 ZWiGgqOQ7TbuqHdQJGA==
X-Google-Smtp-Source: AGHT+IHLB47Xcxs/NZACBKQWKpnC84YIgfHGLbPrpZ1RajWMqDr7lgtp8J4EIFKf98rjJ3VNPwjwCg==
X-Received: by 2002:a17:902:cf05:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-22c50d8c10fmr63442355ad.26.1744998292195; 
 Fri, 18 Apr 2025 10:44:52 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf55fcsm19523245ad.80.2025.04.18.10.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:44:51 -0700 (PDT)
Message-ID: <d07ac10c-a685-4c47-ae43-d88db17089eb@linaro.org>
Date: Fri, 18 Apr 2025 10:44:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] linux-user/elfload: Use target_needs_bswap()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/17/25 06:09, Philippe Mathieu-Daudé wrote:
> Check whether we need to swap at runtime using
> target_needs_bswap().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/elfload.c | 63 +++++++++++++++++++++++++++-----------------
>   1 file changed, 39 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

