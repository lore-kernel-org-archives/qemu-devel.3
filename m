Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994ADC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8KW-0004nL-DR; Sat, 21 Jun 2025 20:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8KR-0004mU-0w
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:13:02 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8KP-00015o-7E
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:12:58 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-31332cff2d5so2088230a91.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551175; x=1751155975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uqjVeEuyJkOet9IDIqrGC3I5TxTmuqJPg+2ced0I1G4=;
 b=S9+9tOI62P8+C7m023hHvoxrmLpJ8REY47WI5qQb79g6a4jm8qfOMvY9/u9GhjCu7B
 Im3Lkggfb5YzbOrluDAhWsAYUZnOus3rCjN8JmEhkPwdqXi7+dmczKFW0BSDBmJAH5QR
 t///MSbMXsQn5CYJP4xicWxl8D36mw1g0h+FF6v0JI2YoRSljDsAP46iHse+Qp7YfAyL
 eGc7A776eo+K0Q7HNP52imRPUJWCc9vBjm4sczSRWL348U+F7Vt1IuaY+rqmuCUxGlp1
 jCwp/KIu61Q7PPsQ8N86VtjGUvhHOiGDaQyF7YVsf9Mhy+gkQbQOU6leAlk1vIQz88y6
 HTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551175; x=1751155975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uqjVeEuyJkOet9IDIqrGC3I5TxTmuqJPg+2ced0I1G4=;
 b=h2X8FjtQC5XcWMxx95LzBbUcsi5g7pV6eLyqev7T8V3GXOtmN/5Cst4Qw1yBO2NakA
 4NPba0zCgrlgFWPJaLjjOsWpOc6zecS3Gv9wnrdF8E/gjYN51gEqLEWsR0mQs4a6an5+
 QwwUyF8ijz7w/sEB2enma9wpRwA5uNQcc6pzRH9VQcCVo5/KqrcccoPDGXlB1vdy7Z5U
 tqkuT7+nmSxlkunHKSpxjffNKoNm0NRVziU6GRtmPly+AVtE3tWZPDaxkDuSwO09Ldh/
 CiIkgXcbr6ltiZdZnrnZrtdklYQWiuP346hwkaOdhKw08ifS/m061M10kB5cbGqIFQOY
 UzXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp9ZflE7cTzJZXsVFpp0J5MO+RwMcxyGg85wdARBVzlDljRc/0Yo00Dz87PbpfNbUAKtP6zv8qvCV7@nongnu.org
X-Gm-Message-State: AOJu0YwUUOF0oXFLQCgXafKinJrS12agTso0bV1multb8k1yIz8BDzAw
 k0eYVIssbvijutMFvWEKpvnFUZTk3LCnizIB0CQW2YhtlQxQhSZ50EImp+h7mkfyf94=
X-Gm-Gg: ASbGncsecjyNsY89/VUsUdLdfYhtjOABM8ZRVIMOrRmfBfG1YlfQmTae6IGetlGCBYb
 U9ijE1jksEIRj3t633ZR/q3LYOw6bgnVM+YqrlTF2+uicC6PJK2/IlGjnM0F8EVo+MtP03qNITW
 mYLXe0gnHGDfu15yi2TWutZB/hBblh4DHgs+AU7Bf7VeBTJb9EgyA2riG52tMYrknFw89fkNEtC
 5srswGC5muyKARW52z98krTSOo/NTLhaCesvRZ7qFywX70Yl2D+nftOzKaBaafefWr2VrY9gOz4
 p515b8fC6OCm5fp24EASHoKz5nBu0fDP4rOAXz70yExNsHfwu8uuvF4YJActyytidNArQpvLgpS
 sfjwwoYP0IyyAdJfvGuzmoNcGKBA8v8SPQdlWYew=
X-Google-Smtp-Source: AGHT+IF5QPOYK/2PE3n+TQtjJUFmiCT+A+5zkLN96Bymb4e5SGBv7IsEms/SnEwwF9QGiTJnAxAtbg==
X-Received: by 2002:a17:90b:4b42:b0:311:d670:a0e9 with SMTP id
 98e67ed59e1d1-3159d8c603bmr10992850a91.21.1750551175485; 
 Sat, 21 Jun 2025 17:12:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a318749sm7148152a91.39.2025.06.21.17.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:12:55 -0700 (PDT)
Message-ID: <09ac62fc-64a8-468e-8779-193b8bd51435@linaro.org>
Date: Sat, 21 Jun 2025 17:12:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/26] accel/hvf: Trace VM memory mapping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Trace memory mapped / unmapped in the guest.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build               | 1 +
>   accel/hvf/trace.h         | 2 ++
>   accel/hvf/hvf-accel-ops.c | 6 ++++++
>   accel/hvf/trace-events    | 7 +++++++
>   4 files changed, 16 insertions(+)
>   create mode 100644 accel/hvf/trace.h
>   create mode 100644 accel/hvf/trace-events

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

