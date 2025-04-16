Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C6BC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 06:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4wgA-0007Yn-TL; Wed, 16 Apr 2025 02:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wgA-0007Yd-72
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:55:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wg8-00060M-C8
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:55:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso50230035e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744786520; x=1745391320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CfuAGdm19c/FvnLa+ntVV/+/Pg/U9tG8njxG9gMl7Ic=;
 b=l/XP2Vo5zq3I9reCwmNWncEpPsvpk/P8KDaavcDVyFkadr0MJFyf01ibcK7/7msXVC
 s8tQInbMiPtPi5SQvj0x+fLd844AmOyNk1d64rM1LrZBK0oVf5LPG0S62l9VNUk+Bg/E
 JRXH7mIbpht5ouks+H/hcxBdPG8/eirvc8bKrstM5B/WB7d5P6JauIp/VOCU6y9UZyC4
 fOBvpCNkXagZchavpXSEIsMy1isy7noZ68ldH5bOKkC3gvW4o6+5PLZPMwAa4wgN9ytx
 nSTbesbv7h4HTP/FYS4ip3Aja2fBEqxM7MQZDAhvZLtv7eYbUyn3/7uuR8ZQlV3eM07+
 Pn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744786520; x=1745391320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CfuAGdm19c/FvnLa+ntVV/+/Pg/U9tG8njxG9gMl7Ic=;
 b=GbZHAto3Atab70EyK3kbgILrYfdIj+nM+lqa62ngeUfjFm3sWZiXABQrUtiOvd17OC
 Tp+8ohETh5KbKDiAyuhidsV/X+qEqbqT1LjCkfWxbGeFPOhBskW91mzpsg0cekSbv1uH
 eXvU92EoiZ/8uaYHFviTLQyPg3DHa/yf/87xjL2E79Twzcxg4rg8ZfmJDnmqV13Y5gN2
 Kdowrsd+hVOCHeIu4Xa+ZrSj2HQtASKqHAI0k/3MpxY3+U2rJWV4ueNaF9Os/VzMIlno
 roLW8/CQMU+MoPAqZgtnMXOGG3cQfiJ6hpOu5wUC4i7NJ+OtooK+LMmWzQAlxh2ez5oC
 ZS5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnaGn9J2xuhNveepgxjA4ADFZCeG3ocSXj1FCMPZ15wyN5Rd9vEDnsc3dS0dIVJxvBjiWylEIr78ku@nongnu.org
X-Gm-Message-State: AOJu0YyZ+zKxjbK2eBy19DT5vvAscZ85qnj8371D06KijwRfImzh6Hm4
 M9cExrAZTsFK2FdZdp3OGRx4wl4miHbxSq0FrGwY68QGTb3tyHwMM6Cv+D6TjZk=
X-Gm-Gg: ASbGncu3sJTCP2hP5jel4x5xZfG30MdI/m/UPIQQVkCVECqrxwAVHr9+ddpKfIezDAz
 9dhjjwIkmYfHUD5I9l2LAtm0tVYZWzKaEmmTZVz/ZWfxxxZVI4GXbcpF38OOwuPaLhHpxvIJwmS
 W9J+VXTHqRhhKJtnY8GDHiYUcSO82rp4TI9diG9MnxLbZogFYYkQZrgDvd38VK6YPmezgb/4spC
 lfL1wbtrUVJkHD0zAyIwsovahlOeCFnONFVBasChyDEwxC2mXSPNXTCByLWQeYQCa/wezsI4h+R
 yKYWC+mQ/utNeAdSZaf381bF5IM9qtg3F6IQU1Oe+hhgJ/g6cLLFOmFvBJXAEW5nve1sxNd1V0n
 0CryO/A==
X-Google-Smtp-Source: AGHT+IHREyPop2b6S8C/tpJzKinlF+VdmCbFSX/WCUpiAe7NqIwcGYYPPdpuNrjX3ewVK7KM8G4ZVQ==
X-Received: by 2002:a05:6000:40dc:b0:397:3900:ef80 with SMTP id
 ffacd0b85a97d-39ee5b16f89mr483054f8f.22.1744786519787; 
 Tue, 15 Apr 2025 23:55:19 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b54224bsm11512135e9.38.2025.04.15.23.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 23:55:19 -0700 (PDT)
Message-ID: <96b3b317-4318-42d4-8185-0de37af1bc93@linaro.org>
Date: Wed, 16 Apr 2025 08:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 158/163] tcg: Stash MemOp size in TCGOP_FLAGS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-159-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-159-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 15/4/25 21:25, Richard Henderson wrote:
> This will enable removing INDEX_op_qemu_st8_*_i32,
> by exposing the operand size to constraint selection.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


