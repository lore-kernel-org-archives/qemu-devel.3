Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01CBC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEtT-0008Mz-ON; Mon, 30 Jun 2025 09:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEtQ-0008MH-D0
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:49:56 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEtF-0002pw-8T
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:49:56 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73af5dc0066so930392a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751291381; x=1751896181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lao5GrRMCI24tnalPT3OkJ/97mVyN1IN1gEERzn3koM=;
 b=BMPxOpxSkBFmXdqErEIPcRPkbLtaneFdjbpQiBy+hztxcZBLcQLhuFyWDq6dFt0zZa
 2D61+iIQItpVSnD2yd8OCCRxGFLUoBDo+5Bv1y0rO+vqOSSq50dF0129XXSM1thOp87G
 tHD0LTuao3O7MgZpQSOmO0nwfaH8aZEZ3lFtSnKGkzV002cDZd9NOhosoJl37ncDYGYf
 77Yn7i6RtOhEQAMh1HzkOAnktAi246kXH5iRvup6G1SgaYrRnL1ba5NdmDWTWY3zWofI
 jlajV6h7mngRx5e+BCbas2GxfakVOxkuCNiZwBOyWPn2tdAUdMSWrITVjB3jByj8sIwP
 2fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751291381; x=1751896181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lao5GrRMCI24tnalPT3OkJ/97mVyN1IN1gEERzn3koM=;
 b=AlB7NhqTS2OYs4/pmz3PTze1/KShRhD7KSVLTxTRAAHW+XSy8AIlT3BUslizF9WqXm
 Rlj3FIpXhltqPfnQguhm/AzseJYu357BFAqXzwMo7d1x2Y3I7jnaSgd3zycww9hHKXa3
 tnUVPUxFDgMnlYTaA8w6Svwoxr0w7hRTkCwDEc2QrWv12w1CjJxEYDb3bD17Vw5T8FXS
 iGZyUVaRRI9ifQk62pSYjhz9GHdMaqAG/Wgup5cPW7z3dNm0Vy4XBYH0lLAGG5ykuKQR
 CqLzBw72XYe4nMX/BKu7Aheknt1Infad/Iwzy1ZWTraK3X/ZcRyYkfQ+RrCS8Ni/8LJm
 ZwTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxL9wk+RFVKda1opGSmmYva5bENDjcpW97/YPh71C73kUqtH7VhdIQt9NyJWxIpBKOII31e/P5OBB3@nongnu.org
X-Gm-Message-State: AOJu0YxXc+tMKm2ylYwPja1Gf0HsxNAlMsqZb24DB/7hoRvq9Kx5KsHm
 RQahyzOzU6IPBKk2VODcCc72vEih2AUdKHfaj5k6DUHbw5cKUbThSfqbmP+0VV3q+ds=
X-Gm-Gg: ASbGncssUuoWjun2PnR9GXO+U1ewKeK4WoaCc4XHa5bGJlGr1ONs0pcLaesDzRZGXiK
 QMAraWqjAnsV7gFFD3JTr1WHmH0WxZUfasE0rAHHE/RsUSpdAA2XOuD6h2jnC20MzdfGcmld1kF
 PMhOnImxovH+Gw/9w4A+FuK0gzwkQDGMvUgqqizxB3wIJYrMZIlDmmHQ21M4n0Q/l3+ZUnAPl3o
 R9ahkhbBLzu6Pl4d8dhhKLwqNRnDVgqOb8cTxxbzEtyFn0fp5C4DHrlg/XMgXgK5Ff5ro7Ugc12
 cSapA4JN7KU4jMP9ueZ+MBA8ttNUoRtErGfEbTacFT6B5d3AEi/cRmK+q/6MvxuNGzibPsaAZOF
 d
X-Google-Smtp-Source: AGHT+IE1UN9UfEb4LqBuvuMUmlUlGstzbBZ4IANwiUjl02TX+lNyuAG7BGfpi5mDLqLUwzKVqBvFaw==
X-Received: by 2002:a05:6808:ec4:b0:3f4:1c2:874a with SMTP id
 5614622812f47-40b33e0ec93mr9598557b6e.24.1751291381159; 
 Mon, 30 Jun 2025 06:49:41 -0700 (PDT)
Received: from [10.25.7.25] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32420a6bsm1688687b6e.40.2025.06.30.06.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 06:49:40 -0700 (PDT)
Message-ID: <2b2f57fe-5c49-423e-bc2f-647a81bc40b0@linaro.org>
Date: Mon, 30 Jun 2025 07:49:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250630130937.3487-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 6/30/25 07:09, Philippe Mathieu-Daudé wrote:
> Commit 34c45d53026 ("target-arm: kvm - re-inject guest debug
> exceptions") removed CPU_INTERRUPT_EXITTB from KVM, but it
> also appears on HVF. Better to restrict it to TCG.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

