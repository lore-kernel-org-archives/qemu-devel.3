Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0870DC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3qB-0008Ai-8I; Mon, 03 Mar 2025 06:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3q9-00088J-Ju
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:20:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3q7-0006JF-Vm
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:20:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso3577015e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741000801; x=1741605601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LBUoJBSZnbbEmEvXE/hYOYl726+G0RGb1hwITSUspqc=;
 b=ODbQ5HLU7FQPRjPDzA7yTaaEOOozsHEduxYL8wiB/gXvz1eTp4Nu9+3f1VqpOKEgsG
 1qYVw7keoscF4E/50/YwNIQXHk/mj6nTqwiT7BC8g7mxZTmbSXQnBxYbI+TWag7jY8y1
 ZCphWHRIyTMFVYhu3r+JrqFcSED6g6lzt078mg2YLZqqd0Bdt/W0n776Rw5Z98CqqHSB
 TihwlpGdn9NGTTtVej9rMpVhJCYvwKqkQP0goIW2LqJmlhf+ZfJc4k6NE4UUhBrfa3qo
 pjUA8UXewUk6sKdm9ys9M2MS9x22Ltjlv5/sY9MvIpKJ2Z1I28fguCEwmG+g2v2hRGhA
 /AQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741000801; x=1741605601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBUoJBSZnbbEmEvXE/hYOYl726+G0RGb1hwITSUspqc=;
 b=bUcdY+BM8r9WK9rGJu1XH98OEIwSGtQIUD6mXOVhMSaZ9UbRz8AkG0QQCRtIGRT/Y3
 9ipFkHWHs6A5VM/Flv3F2JiYBCS0QDw/r1yArklSQhXghjIyXqN93FuLwAZ2cqr7vAV7
 EzqT4OjveCdHkvqUr64ZmdTD+Z0OTxvYIV+zB2mW5PeVdebeHoKlw4u8dYpN1LUCM0d4
 eBL/bUmLs+SRiz9sSMyBS63ijGVFvyVgFo2ImyIbYS2VbMR/8IImrAY8eLKzltyHzWIY
 2zouh7Kfb5khQW3VRs4kct+VIPqyfUeDCyePYIW82mUv9x2q/RwpSMqisT9Wrl0bub+u
 YBrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5eJ1NK0zwo0eTK6SrBrv4yRzClTNMcCEIXLNqgvATN86H+jAJwAFAjmryTEraEwNsUIkSuYgEU9FP@nongnu.org
X-Gm-Message-State: AOJu0YyNA04OQveBjq3MkfC066VmTXz9UW1saIEOaXTSj9a5ZBGemsdz
 9o8YqV9xPmZjhsupo61czHY24hmH3zq0jJ5WR5qYTDGT+dK1I8WnHYDXNByGcnQBFExJetY3ico
 OaBzmuQ==
X-Gm-Gg: ASbGnct7tScF5IfitXhIAFDY8O9PSoKBUdIVeK0UD5UhnUKloCXWt5vX720Ax+96HZL
 Mrpr3DJ1l7nK5RJUHOwc3H4wkdhKbwJWevKbKj1Tc8fKHYsW8/m/8wJ4caYac1Q9UJpHmy4eQ7o
 /oC4xtxlQ9rSerwA8Pi6dmu6nlH0oTCPJy4tWQPREyNzeiT87Ib3lL4Y7VxFUluuRLGx1pHRQuA
 2bHCC1UQOHXjPx38z8mdnHu86+fnsKao5+LoD+kc4HlWJ8ruiJfY2WYux1VraojkY18U/4Hw0PA
 1aVkBdm4howZAZS8hFzgXTNx+BKU7UZBuVZ1KJzIRvTxHvv0wS6CuBEAIq18MMIU6Hdn6bnJOs8
 XTutQocITyMGk
X-Google-Smtp-Source: AGHT+IEd5sTJ4uKbbmDrRGQy5sV9zXhrkEBlIDSq3/aA7Zb7dXGocXx6toDV7yymYdG53mmjD4398Q==
X-Received: by 2002:a05:600c:190a:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-43ba675830emr84092625e9.24.1741000800717; 
 Mon, 03 Mar 2025 03:20:00 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5711fcsm192388125e9.28.2025.03.03.03.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:19:59 -0800 (PST)
Message-ID: <a7bd33be-c492-42b2-ae38-380a36115611@linaro.org>
Date: Mon, 3 Mar 2025 12:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/nvram/eeprom_at24c: Use OBJECT_DECLARE_SIMPLE_TYPE
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1740839457.git.balaton@eik.bme.hu>
 <08d9900af04789ede485942c8072eaa58bf52f80.1740839457.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <08d9900af04789ede485942c8072eaa58bf52f80.1740839457.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 1/3/25 15:35, BALATON Zoltan wrote:
> No need to open code it so use the simple object type declaration.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/nvram/eeprom_at24c.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


