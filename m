Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7910BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqwc-0005Kx-1z; Thu, 09 Jan 2025 06:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqwX-0005Jz-4R
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:43:17 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqwV-0000Tl-8I
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:43:16 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so6225615e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736422993; x=1737027793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfseRwZ5794JdH/DshTHXnnjHOjBeCTzJ2B9hb56hHo=;
 b=VdkFuklqZ3n+q12Qxcpyzztzfem2x23woOPB/Vk40adPKjlcToRpVM7lZJCppAx6y+
 uG5cPfpl0S0j6OKu4R1xLDFXilKMgJYq0yooJOhkixSNG9tkgYpiMX81y9kz48nm88mt
 FbcR5eCZMDN4XtuuU+r0IpXZsjS6DcdTXfo55p+3SUC/UmiYlnoQRWoIMwVlOGLnLris
 O8HiW98/I7AOUM1K+SuyaYka1OFJSxwZIu5tlLqisXM7EWKOglE0B36GWd9wExTw3HLA
 KP/eMIMim+cMSU7vrgjc4EeRMZMNQV5haa5D4oFGU4bh1RGDZIaN/gf545RLvg6TbGHT
 44Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736422993; x=1737027793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfseRwZ5794JdH/DshTHXnnjHOjBeCTzJ2B9hb56hHo=;
 b=S5IxVJ2mTUWWnGRCYFg+wwFg9RXpfe0iI1n6AuUj3CgAYrjhabmpA901iqKluIOlFb
 x8GUh0jI/VDzg0mMZGVJjxZlHSBIvF+GbpEUjTQKkdLQGp3Eq6SujBy0F9kF7rSbEbxv
 CUi4sRXJkdPzU+iYPSPzMGX1kP3RzG/kVkvEtYw19C3oAWhF7wGfJVTOYBbZkjkpeNBe
 wUJYnzKGZio+6DyBj7K2+65kmNp5t44qQwYZyDQuf4N+j1OpWLDNOxKdisNHYbZIKRUC
 dwRKnICD+CcNlikyVHMXjuZAuvD/oFKzEXpiKhBgOIRju+wbMCo31LodDrrR+qcvNDen
 gfPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHVRwgPBtPgNmpdoQpDSXrmXQJUP84YgAHtT768WDTQwSwMXuoafYh0fMAnc0/RULEJl2kSySgxcT0@nongnu.org
X-Gm-Message-State: AOJu0YyZ2SyAlqtmJMQNR1/Vv5qFbLI4Z/UeEaMRlZDsukF/e4eWXlZc
 5BnCIAGUYG36KuaLkhzZuwy7AFggYRWGGRQ4zWuSu5clbUOcepgqbPK93zARy+A=
X-Gm-Gg: ASbGncshsCe+wt3OEOg71EIzvNxrwPsiuGfJx30ZQzfeGrblvSdyTIWDMhnAswM4qtG
 qFmFPT4WJtkjLApRfEYAiUQ1hDoPWtvdGjjP1rbH9jsAyRN1vVghoANXbbiLCozIOQpJz/2MuW3
 wt9wIyMOZl67eJJFZUTne/yBiJSrucANrqzqedbDuYZsaeR0DT1hqQkITd8meIh144W6qp2qoRM
 ps/8Qqg3PHJwVUgfMXEa076BVDcIg42N7CEcGuC9hpBzF3GjKtucKO+ZRNvTSMOzzBggZByn3qr
 7nLdgnn1zn9OqVmT43UEBF+G
X-Google-Smtp-Source: AGHT+IFhJo3QvF1788UYDnHfeKLjwXvqCR5j+EJq116MBpoQtbXSIHNmU3lr9VdzReavEbyGiOKM/Q==
X-Received: by 2002:a05:600c:4586:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-436e26f4b91mr48921345e9.25.1736422993456; 
 Thu, 09 Jan 2025 03:43:13 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da6336sm52590995e9.8.2025.01.09.03.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:43:12 -0800 (PST)
Message-ID: <696c9a80-7311-4a95-ab3c-f85bc0b38e6e@linaro.org>
Date: Thu, 9 Jan 2025 12:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/i2c/imx_i2c: Convert DPRINTF() to trace events
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-13-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-13-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 8/1/25 10:25, Bernhard Beschow wrote:
> Also print the MMIO address when tracing. This allows to distinguishing the
> many instances a typical i.MX SoC has.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i2c/imx_i2c.c    | 21 +++++----------------
>   hw/i2c/trace-events |  5 +++++
>   2 files changed, 10 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

