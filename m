Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658B5E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSGk-0001yd-Cn; Sat, 14 Dec 2024 08:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSGb-0001yL-Mm
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:33:12 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSGZ-0007Mp-Iu
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:33:09 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3862a921123so2007318f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734183178; x=1734787978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+dUBjSDpy8x8yriedxQMh9kleMTq4AUlorMEQBHK1vM=;
 b=cipH43hESKLmv38Rwt4NxycfcRmMNTKdfuR/5gnKXGEKFnkZ7grOmgcAB0W3qTmwza
 aIDuL3ptPGT+LO7anzxgOiwEX9PbIYZG2d1rXR70ORSRByemwyY3bBM2WyS2edC8kJ2N
 wsu71TS7OIKHEHllEIhRDkPO9RChiwOGsgjLcRzLrRFIUA/Cg6ceMtINn0o0kev2QZGJ
 TnA4i2cyRpIietu52juHpJIMZtH2fyK8fcd9oJB1SS/aravo35edhSDWgzrGCygcq0UP
 bDKINx3/VM26zw3WMNN9papBWd4WLssC36JBFR9JpyeEJsDjWFBfqRgcjs6XTRuWRmT+
 dSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734183178; x=1734787978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+dUBjSDpy8x8yriedxQMh9kleMTq4AUlorMEQBHK1vM=;
 b=OMZtjU5J8lwuKlycHXAs1xYCZVw2kXpKmzkh8eGQYwUDFAuUVPws2Ud9BMBxwysFil
 X8q7Dv7q6wYhjNlRIw+An4uwxhxCZsWAXCXndyLBu0r963tdcjLcCIFIa9pmRnkXR/mu
 kq+nWb3+SCtePULYddchcxY+BqCenMiXJ/68yL8Qg9/GMcGR5XvhT9INxuXS+lZE0O6y
 U3vRLk5ishwLnxRe4KrmSoywrPXIZj9GJ8n2bYDiJnq4ihzShUn+ePkMO+Xgt2Y0SMC2
 yKfhLdn09zl283zeBXNjZS8BVnQ+KcVbLO+AbZmUfUrwRb8FACZJGaNfbzfScAHrHKYi
 2kKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi821+Nzb+OMP7JjBRkcrNcZxrAgmIT4MjVdPzDYUsupZKWGrK5sYw9Vh8cDUqP1PL/gqKGvBjDhYd@nongnu.org
X-Gm-Message-State: AOJu0YxyykKQz/yGCfMITERl6YAzuej9b4jQFyhEQYVhGUszOpUNQ37p
 BQouC3iZxkH3VoORAb8Md7VjGSAuwwWwTMPmjsT2LdeZqM1n77C5K7WIVbePxFQ=
X-Gm-Gg: ASbGnctTjcZ9GNAIE1UdwI66vsPYZAS8+yWxwWMmHLXORrNnyszUEKiMK69UBQXYYUE
 lCTWI++UtwHAFdqOOk5hob8ruP8Ra6TnrDXHAxhkYH9EHjhApBoUc60lRxfOZEkfMHOTlBHw7BX
 VO7lcs6aqgl5iPRzZ4GIrFAmMhMHEbAfzWkgUZSbWqpU1va65B/GI3DKgvgJ18W3lQSf6p2qtht
 EeYfMSI1SmamaNiQFEfvWRLvS4KzlBzkos9vFLQo4eXR9wPy95xX52LKVB8SHqzgjSLjsQkcr2A
 Ytk7YvApWlCRxckfUtZtGkOttg==
X-Google-Smtp-Source: AGHT+IGgAkBcmILJ7kFwe0VgzPPHyi1AA3dHV8bfkvtWCC8usUae8c+mH1mS133MwlSS/du7gBlK6A==
X-Received: by 2002:a05:6000:4029:b0:386:416b:9c69 with SMTP id
 ffacd0b85a97d-38880acd4b3mr4796966f8f.16.1734183178549; 
 Sat, 14 Dec 2024 05:32:58 -0800 (PST)
Received: from [192.168.224.213] (201.19.205.77.rev.sfr.net. [77.205.19.201])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016427sm2554680f8f.30.2024.12.14.05.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 05:32:57 -0800 (PST)
Message-ID: <df9030cb-cc19-4d2b-8d6a-0acb7b8b32ca@linaro.org>
Date: Sat, 14 Dec 2024 14:32:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/34] next-cube: add empty slots for unknown accesses
 to next.scr memory region
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-15-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 12/12/24 12:46, Mark Cave-Ayland wrote:
> The next.scr memory is now effectively unused, however there are 3 separate region
> accesses still logged that occur when booting a NeXTStep disk image. Use the
> empty_slot device to capture and ignore memory accesses to these 3 memory regions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/Kconfig     | 1 +
>   hw/m68k/next-cube.c | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index 0092cda4e9..aff769b30f 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -18,6 +18,7 @@ config NEXTCUBE
>       depends on M68K
>       select FRAMEBUFFER
>       select ESCC
> +    select EMPTY_SLOT
>   
>   config Q800
>       bool
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 76ecf86ed0..95d01030cd 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -22,6 +22,7 @@
>   #include "qom/object.h"
>   #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
>   #include "hw/block/fdc.h"
> +#include "hw/misc/empty_slot.h"
>   #include "hw/qdev-properties.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> @@ -1239,6 +1240,13 @@ static void next_cube_init(MachineState *machine)
>       /* BMAP IO - acts as a catch-all for now */
>       sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
>   
> +    /* unknown: Brightness control register? */
> +    empty_slot_init("next.unknown", 0x02110000, 0x10);
> +    /* unknown: Magneto-Optical drive controller? */
> +    empty_slot_init("next.unknown", 0x02112000, 0x10);
> +    /* unknown: Serial clock configuration register? */
> +    empty_slot_init("next.unknown", 0x02118004, 0x10);

IIRC the 'name' argument of empty_slot_init() was to log accesses,
but apparently the patch has never been merged.

Maybe use "next.unknown0/1/2" in preparation?

> +
>       /* BMAP memory */
>       memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
>                                              64, RAM_SHARED, &error_fatal);


