Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9158E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqvl-0004kZ-2L; Thu, 09 Jan 2025 06:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqvb-0004jx-Ev
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:42:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqvY-0000Pt-6u
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:42:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso9095455e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736422934; x=1737027734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXf7IS/afLeHFGkC0UTrCG3iLIpudW2/Rye2ONP/Go4=;
 b=bI+msno/NlqPVBZ+1I6hY/ZKdCCR5UAtwOzl4+HJT8DK98Hz4Bc6vwFEzQSTNIB4dk
 J/omMZwCBvq64YBQfCtCDRlUfUemyDpFkY0ThFg5CCfFzGW3YmUaEaalCSfik7KL+OH6
 Bm3EkFCEmbetwt7kAZIGRwFHZ/LCrYWX0/72fjACyIaH1RQrn/jjRWhh3SsnS7t6WvcA
 EOovbsglpyZS3Cy80wKA6T4IBBINfSlPAZJUL5JmzAqsnZJh8t5H+Wc54QZ1pxhGxXUU
 zEIn89ChqCT+Z4a/AwRKlHX7uwEkocsSNhNg2CyZiXsmzs188y/NPcfOl51gdLngDveK
 MwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736422934; x=1737027734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXf7IS/afLeHFGkC0UTrCG3iLIpudW2/Rye2ONP/Go4=;
 b=D/DniJakwNxicEJ1TJhbocvBw9wq5J8n3nazEG25eYAmdb5fzcsdMHanIVYeMsEZLp
 8PVJR/MKgtTgJW72hSJ8//evSKitPynTndSUNlT2Z04YJcm4EQFhu79gvfDpjblwb5hL
 f1I79fOqqMRMhAFcR7i2KAW0h8pbw2vSbYV4XAs2YqMtmnAq46iR2gHTDBBzzNuBQOdL
 ZFonVfjChysTRP8CBfFL5eum+jsvssrX9k3bM6mjgla9/a4XHw+psudoApoueYTrfoE6
 hVCE6auG4x4dOinaprprjl86fxLqCGNvtyJ2lCgyP6bz9ebYtbmOmrYo6R0i0CL4NeO6
 ycIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsCsPdHHHjsGz+cxCqaA2Wra7JWqoEMomtjGgrqAhvtKYMwxYgkDZlr4ZpbEdYC6LhpqVOrwvv4CLJ@nongnu.org
X-Gm-Message-State: AOJu0Yz/W97xurep7I5+FLwAkzqKECNjLSwMOnxS1vC0TKXUebAODi8Y
 t2GFKgrbyMkK9D5XtGGkQOWldWQ+W7LFlmQrAtw1DqU0VsQ1+fgXpEA8CqAwMT8=
X-Gm-Gg: ASbGncvKODtNCs8U7w9o3D3UTZ+6Udrd0HtzyEzs2T0M5EYmrYKY9OtQYuc6d4jOy9e
 yb0xmFfkovtVmZhsN/ntmMogrNWg1AjpufPKNC93FTkRBrU3Lwgv7g3Gak2SJ1UJUqf/18OLzux
 Fm0ijoPQQsbOA8g6qKPHSL6EFr4yLLr7WALTsCw36fwDc11DEzKkg3T0K5L6DZSQk5ys2BgECZW
 j/fOIpvoAb1ImE4BY3TVawZFVhVcT8/W9xLdgIFkq8GdVDVZtwWF14gv0a50MVBxN1dKmt9Vyaq
 gr+M8IQqUWihXC26vBU6FltA
X-Google-Smtp-Source: AGHT+IEm5hcEJaZ4oNASazGimuIt6AzdewwPFI85hP5JULAHmEP7KMLCrcI+PLXYUApl+oXAIxPUAA==
X-Received: by 2002:a05:600c:3ca4:b0:434:a10f:9b with SMTP id
 5b1f17b1804b1-436e26ab2a2mr61886355e9.14.1736422934573; 
 Thu, 09 Jan 2025 03:42:14 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8116sm1586982f8f.79.2025.01.09.03.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:42:14 -0800 (PST)
Message-ID: <136927b1-76f4-40ca-8ecd-a2c5d8576160@linaro.org>
Date: Thu, 9 Jan 2025 12:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] hw/char/imx_serial: Turn some DPRINTF() statements
 into trace events
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-10-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-10-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/1/25 10:25, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/char/imx_serial.c | 58 +++++++++++++++++++++++++++++---------------
>   hw/char/trace-events |  5 ++++
>   2 files changed, 44 insertions(+), 19 deletions(-)


> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 59e1f734a7..4c6d401b4b 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -52,6 +52,11 @@ escc_sunkbd_event_out(int ch) "Translated keycode 0x%2.2x"
>   escc_kbd_command(int val) "Command %d"
>   escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%01x"
>   
> +# imx_serial.c
> +imx_serial_read(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03" PRIu64 "] -> 0x%08" PRIu64
> +imx_serial_write(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03" PRIu64 "] <- 0x%08" PRIu64
> +imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIu32

0x%08" PRIx64 and 0x%" PRIx32.

With that changed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


