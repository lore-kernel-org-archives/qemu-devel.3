Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AE0C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcAZX-00075E-6W; Sun, 26 Jan 2025 16:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAZU-00074N-9q
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:53:36 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAZS-0005v4-Mc
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:53:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21619108a6bso62708015ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737928413; x=1738533213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4T0jTMH0OI8dm7SaZr8qtK3z3SvV4uGh2R1/ll9Xz+I=;
 b=UB6SfnpW4tU61+h8LgJcSVaNa2ZLCLp9reM4lqozMfDzQh/0GwI5chIRht79JTqzwI
 tY/3+4JIv7Zt8KLFQluipwMOuCAACbKyVhChCyl8p8q4p7zGsS0OS27eSQhAd44kUIFI
 LgDtxEtFbhciIMS8EObtz4gmnBzT4YxwbbAsdnLAXjlIbJmUVJLLeRhm+Sx+ciVtAfJD
 Xv7c1cZBku6vs37v68FpRs6Zc7AAiuK8gAa8PVJAwMMw0+ffwSmxrzriAahQXHd6Tnka
 WEdh9T9BwX+Pryu4tPDMptHTg+Qy0H5H501sGlo2ioNtb8XI+V9Svemi1VZCD681SI0Y
 TMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737928413; x=1738533213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4T0jTMH0OI8dm7SaZr8qtK3z3SvV4uGh2R1/ll9Xz+I=;
 b=Dtd20oudPxycl80Hm7WLWYRTDNZAidm97pCBM1ysYNrtsSqAnLfnAqKP0xQtKVr2RO
 Q/WYD7KODZj/+r0ClYfraq4tQ8pyAshwAj4h83xoauqsKkEUzjTJXijVrMzSi2fKeadp
 6c635fcEG4OJsnG2CJzBBt5KwhlmOpE2jitNxcYoSzkfdpPkLUj16uvhCLDHxGOFtM3Z
 ZayRJeukGSxN2CYA6JKdg6cGIpUqJitvR9Xxi17aPucBdn2bIbrjy+8OFv3PfYl6dzta
 r7MjhkRfiamRWv1YDdvy+avZrR9IaMBtUtsMwDDg8VqupZJIFf/UNsXIqrmpKEDHOY+L
 aqHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP2tweb792x0HK8EPXiDFdK1NiX201HfU5vLbkXoFNxVsuXxUWLRrEP7KqObFt2jl2dUeyOyIPs7Z9@nongnu.org
X-Gm-Message-State: AOJu0Yyk3gpHTmMptNHKv8uJkeTCGatZ/YJ4u6WbvWNL9NxtZNyfU09V
 IiYnRFglJIDitXzX+5H0TZC5wTWtzKarfm5hJpJzDAopg9jORoUw9+hppDfmEbM=
X-Gm-Gg: ASbGncunwl3YY9Xni7Xd58cZgBMSLfShwMlqLpRpSp0qAjQnkbj7m3pbbd2aQjwL7Be
 hH56Xynh4HtycF4cdsjf+LaMrSfNLe733xYf7yoSxevT88OossUgAmP+GoyWDuEtsFBAjgQoXf9
 vlkk0To3ZXgnmgj66SdPY6l/hLUvzhAoKlusu9UwcOE+vgCFGt1TXq16dAKOpw67ITPwlV6iVPA
 MLjIHsLWd+pNKVOuLJHrWG2B3rPhQwvfc/i62SX4yY34iVtxavenNju72r8Tt5BF7EKpWHGstAO
 DoYuBrurBPkwUYpKWUE0MTns0WOh93X8ssmnseuwUy05ksI=
X-Google-Smtp-Source: AGHT+IHpv7VyeVjYrrhIhXP74reZteDI94/aYPPt76i+qd7hs80OK+r7k0daLRtWioMVt8sKZ6hXkg==
X-Received: by 2002:a05:6a00:6c99:b0:725:f097:ed21 with SMTP id
 d2e1a72fcca58-72dafb55a4dmr49642868b3a.15.1737928412687; 
 Sun, 26 Jan 2025 13:53:32 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78ee7bsm5849981b3a.170.2025.01.26.13.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:53:32 -0800 (PST)
Message-ID: <b50f0877-e626-4757-90cb-682111a17678@linaro.org>
Date: Sun, 26 Jan 2025 13:53:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] hw/display: Have RAMFB device inherit from
 DYNAMIC_SYS_BUS_DEVICE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> Because the RAM FB device can be optionally plugged on the
> TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/display/ramfb-standalone.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

