Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261DACD1297
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 10:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI2nu-0002ma-SE; Sun, 09 Nov 2025 05:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI2ns-0002lP-NU
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 05:37:48 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI2nr-0006qB-1Z
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 05:37:48 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b7155207964so364466366b.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 02:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762684665; x=1763289465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B6NzZ3BuJVpXC8eyjQfuMUstoZOeqlMms2pN0F9K+4M=;
 b=ao24f0/xgQIMYUvf/CAeDp/Xf7j63/cz8xJTnzdjeKQDell40HmlgsrutkSvImh9gC
 7h6OL03/5kgCK8kIInKeNzmraQQ6ZxO7iWOgtta4EH+LmvhARZ9hFOXtp9h6fZJui2l7
 RNi2elh+7QhvP3IQmxWRLnbIeTv6WM7T0M5jq0JGTAM2G5qk0h7MFRX7fCL+jSlHhl6o
 6nv/3hD0lzefTYx2vbT0cePKRs7Ux6SwgD0T2S7EokI9D7fs/snkkqowlS+vAJ+j+19s
 HaFpyttto00Pf3KHo47UwF1cuGuegY3X2GBgbn8DTT9cfegz92mIEA+t+OITRhZzq4yw
 96GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762684665; x=1763289465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6NzZ3BuJVpXC8eyjQfuMUstoZOeqlMms2pN0F9K+4M=;
 b=xBrC+Xd43gkpRsmZETfjgchFOcw9L6gngVYp78Tea+eHc2rapIw+ZmBPtpTixyn+65
 7nQBVfcMwgYF+vvEqtX80Gp9irZKWILCJ8yt4GYVaRf+K4T8fGqmZTa8jTBl9N9GFiyR
 VVa9oFn4MiOh8PzTyjniYT2XZyC5Z/MguTfg8Si2LtAYvpA2ZBJ+ANBbXNB8C1XSOQw0
 hFWx7MJCOcCGuSjZtzhjo/tyevWAwYHQR1RzA4iw/xDB09GDjCocED9U+T3D66lAAEWG
 TuvRl6C7pw12etVsC46Z83K+7ErBbY+B+Et6Rbjy0gBI4FQ7rU0Hwry+51alJ/lH4MDS
 gLZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJxhaLh75G+mbMnCRPkxAX3OS/sjL/0nGNiHg/bCPp8UG8ix7moyRO7AU3nONrhOtt3wZunxkhygXY@nongnu.org
X-Gm-Message-State: AOJu0Yz/fPw0k1IqKJucrk/UFVrKmTfsCUJg/ficbygijCG7wYZejg1r
 TLiPxQrktWEuAttX3Cgs/kHLFGsEDMFyU43nUVe1TmgftnFxW4Y/Yzmr1yAKFYsKg5E=
X-Gm-Gg: ASbGncvM0pkKoyFgEPnjd4rzrrd1xpESyN4jE3mG6wYB2zGCxXP5HboukdbDZZRX7hj
 Q5wdNRwl58VnjC54rrBfoFT5AyTJ9I3Y8cBNt1Oblj2kSysaOUqZ3oM9t2TXVxD09h0S3nptNkD
 dIIE4CcubGzsK/E1nb+as6w7/M1KuUMbkPmKYrK5J111cYpMN37ybLRDGpr2mBlHtaw2YppgOuL
 k7Ppr2aNWeV5MY/T6vvj+dGUXSim02/t4kVCt11JtwW/hzWj/NakTQjEg86/Bw81MCqS1ugcJVa
 1EPXjvEC8HTjIsE3/j9oYBpZlH2dhMTcUXHuz+wEFdZpbP2N5T7q0YxwE7bwhdLDJsPE+nvnbia
 7QjeSZh1+wdcyYAuqNuyo789SB0O0sMxgKWp/JmH8hMM1faUAUeu6a6BCuZDgoEkfdL61cvvztO
 uXeMZh2d8TBLBLFBzH6tn7Yu1G9bD8Pz1VDNu30W99cB8mKgWXmtuEmP7wIw==
X-Google-Smtp-Source: AGHT+IEVe1Tahd+5nAHgUS41uHc/zY8r6PoCJerZJcOqHj1UmBhdfiqL15V3Ll4KLgKrdsfD5TWGVg==
X-Received: by 2002:a17:907:841:b0:b49:5103:c0b4 with SMTP id
 a640c23a62f3a-b72e04e4893mr571125266b.56.1762684664561; 
 Sun, 09 Nov 2025 02:37:44 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bcd59sm760049666b.53.2025.11.09.02.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 02:37:44 -0800 (PST)
Message-ID: <71950c1c-f3d4-4395-ab43-4bf1178a8acc@linaro.org>
Date: Sun, 9 Nov 2025 11:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/npcm_clk: Don't divide by zero when calculating
 frequency
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>
References: <20251107150137.1353532-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107150137.1353532-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 7/11/25 16:01, Peter Maydell wrote:
> If the guest misprograms the PLL registers to request a zero
> divisor, we currently fall over with a division by zero:
> 
> ../../hw/misc/npcm_clk.c:221:14: runtime error: division by zero
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/misc/npcm_clk.c:221:14
> 
> Thread 1 "qemu-system-aar" received signal SIGFPE, Arithmetic exception.
> 0x00005555584d8f6d in npcm7xx_clk_update_pll (opaque=0x7fffed159a20) at ../../hw/misc/npcm_clk.c:221
> 221             freq /= PLLCON_INDV(con) * PLLCON_OTDV1(con) * PLLCON_OTDV2(con);
> 
> Avoid this by treating this invalid setting like a stopped clock
> (setting freq to 0).
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/549
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/npcm_clk.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


