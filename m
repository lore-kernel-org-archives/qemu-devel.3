Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6246CC369C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5iSA-0003HG-SC; Fri, 18 Apr 2025 05:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iS8-0003FX-TK
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:56:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iS7-0005Lk-7e
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:56:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so12267005e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744970165; x=1745574965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPgVqdcMJRMloJUAreVlS7QsL8G7B4bUuECnpwsmztU=;
 b=ufk/hL9LuOZIPtdKY++7GXqbg/m/OZ7um5eu1h604IIvH4z87AStWYwEaI5EZV/d64
 ZowXcrgYgsPwV7BtQlsEoQvZ6j/1l6AYQ+N7n0JREj+SFlfLeu4S5C+KQL8tQRZj9ceR
 Xv54UM1QN7Aga6K2y0Uan8fWF5ZFPT09Y2DLdhwp7mkMaxJ6Jkv5Nl8qbIIJ5I6NpF7Z
 13SriLnbAywK43fOCr6cn4krb3sZVDBJbX1gPfDkz4v7vSuqpbI6cRmaj412pbzH16EZ
 NQf77JACjo6SQVZHibiLJBzAY3k/dDkttP06JoIUzRDHBJtgu455m0r6rifT8twhixrl
 /VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744970165; x=1745574965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPgVqdcMJRMloJUAreVlS7QsL8G7B4bUuECnpwsmztU=;
 b=D5fuSTgP2pchT8J2W/VbtvyVA+s7BOvb7mOMPe1YCjLXKeco5rYZnRuFS+dOiOzJ+W
 185sqJ/wBVjDd4P0lAE9lNJoggUiUDtj1Mbb1c9DDV09IdlCLkFLk3xWPBkiUU4eEfDs
 RG6MXUlQHR7S0ZIKsB2v0Hj2QJcomRN3Wa2xWwNjWtpk2JpnH+3aCy0Stv+Ov6XZmC/y
 ouDdrPJ3RwsolmcyWqIfvLVrBHNCUlU0sLu37AAkiE7U5IfZQdo81k3PyJHGghCdxAUH
 dlw9OzRSbZZLxFhEerLUKFCfas3M8VJBOY5od5iuwLesjvLfNihhdbGgtx0TcEn56Cl/
 MJTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjF+ZmRmRLLOvHrgvy32iZsES8OSUPc635zapjOIxrjTbEuWRh+Dy8//sO/V1y1xI/xCPxpINwQBML@nongnu.org
X-Gm-Message-State: AOJu0YxXyp+amIeKEjWi081+AhOGCqK4XuiMA/Et6XzXqy6KVIE1werS
 kuJ5ZoU6fyBwuiEay1i6htCki+NyCrV1P/xIWPiZa4vDAtixmWWsJ9NbvVT++gU=
X-Gm-Gg: ASbGnctM77bCNeiINlFCbbEnPJfr3cX1S/RNjHWdJxx3vxNUzUdL2DaIWbGEB5q7z6C
 hX3nIYu+llNYwiM4FVWi1ZVwr98bE21K+DqK0WIRjdaBfD0sij7vuUnHZvwssd/x4jBw7ho+DVh
 xgSQvLSeIYq98Vj58c8dar/5Cq5gUNbvMSuQRF3i2xYarwxqffkA/wbk4EjZz6KLVq3eDVKPrAS
 2SSLZOZ6D03fWXnsfcH1Q/31xHp7Pc53JlwcL2DIptPRtMYcoRluhRcXpBetMsUxr11oN+W3tBG
 6B+Z0EeJHLcFoVyRIrwjLK0RYyoR/PMAxvJSEY2Lqff6YC+P4Dc6jMTG0gUABeBE3sOEDPhe0hY
 px5uQuCreYwC54Wquc44=
X-Google-Smtp-Source: AGHT+IFYT2kEbEGknynAwWQx4iAXKIZMKHAJ+26pvK76nlBXYMd7/N5QzwchykSjzDnvjdFhz4ih2Q==
X-Received: by 2002:a05:600c:3c9d:b0:43c:f8fc:f69a with SMTP id
 5b1f17b1804b1-4406ab676fdmr16943715e9.4.1744970164774; 
 Fri, 18 Apr 2025 02:56:04 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5d7aaasm15675235e9.39.2025.04.18.02.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 02:56:04 -0700 (PDT)
Message-ID: <f2fb020f-bff4-41d1-8f31-fde1ecb52529@linaro.org>
Date: Fri, 18 Apr 2025 11:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-xhci: Unmap canceled packet
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, devel@daynix.com
References: <20250418-xhc-v1-1-bb32dab6a67e@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250418-xhc-v1-1-bb32dab6a67e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 18/4/25 07:51, Akihiko Odaki wrote:
> When the Stop Endpoint Command is received, packets running
> asynchronously are canceled and then all packets are cleaned up. Packets
> running asynchronously hold the DMA mapping so cleaning the packets leak
> the mapping. Remove the mapping after canceling packets to fix the leak.
> 

Cc: qemu-stable@nongnu.org

> Fixes: 62c6ae04cf43 ("xhci: Initial xHCI implementation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/usb/hcd-xhci.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


