Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F40C88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5rvi-00082c-Mm; Sun, 13 Sep 2026 17:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5rvg-00081p-W4
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 17:40:05 -0400
Received: from mail-pz2-x15.google.com ([2607:f8b0:4864:3b::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5rvf-0005sj-AM
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 17:40:04 -0400
Received: by mail-pz2-x15.google.com with SMTP id
 41be03b00d2f7-cc4c3304784so1334108a12.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789335601; x=1789940401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UDb4cBkkxfSiI8aGBG86ZSRc4iaYRRuP9BjS/FbDmVY=;
 b=synhG6muDjI65mO/oqSuNDKkYr9g4d/MrdPiZSUX1L9TUfIb8Ht2P9I5WpDoxaGP5O
 N4sxaKfoNZ4MP3PpFYAl000WViRPfZgf8fyKAkh9E6EsL1EdprN+6TlO7TdxiR+SMSjZ
 ce7s3TQ85bbPJL5ADGz23WOApRk31J2wjZ7pZUTXe3YBKCWwAmdVTI60MDJhuaGKoVI8
 sttzWLAlUKmpqKV2wa+HvGw7L5CnltvY4K42FyShM7PEpVPisilhW3IC2P6lK6ZrY4Xe
 o9Odp/7vaAC8LKNNpayQpk7vZQEynr8QausPbOcBUukQClhoEJV1tsiWin4SWxSBAZfB
 R7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789335601; x=1789940401;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDb4cBkkxfSiI8aGBG86ZSRc4iaYRRuP9BjS/FbDmVY=;
 b=g46R5tLhMkRg9OqXx3w5uJDYUmlUNj5+ls6swbEWQzpNlmj9OSL9LVTw/iQwWHC/SH
 8QHRaZD1xVi/janIwBOTeUOsGEWcSM/XN+G5QOuKy0ZiifYpJV60y9ZS0j8z5XUcg2f/
 LSXrvPIYDEpbE+FbiRx7ATltt+ozY5YIYUmfviN0sr28fF5osyt/1GmapFFnuQa0NQ0S
 J2YMkan6J3/ms+7egorTrJVFECBzS0MXf76lR5noqtD6nCwTpBWKVvz1vMu5PUgAGYw9
 h4htkWljE8YO35B0ZcT0AWgd8BpnoOX8mHbfZr+r0/InA5FFto+rKl5agYkdMcaa1rDr
 PERQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQxBuK6/1oHWrjjygYXCG5J+pU2agWIFmVHTpd32yWnw3MzJ3CJ5II3j9RG+z468i4F1r6e2bIBPce@nongnu.org
X-Gm-Message-State: AFuF++mgganiLjNc/3tf6VbVb8XO2Xz9rlLpjpEp6Vx8k5rw4FTYOQh8
 48ZJbC016wd8/cGACE6gzX/EH9znGgpgtYApmeR6H1IKmsDx/8psgaPQRnFzBpk90KQ=
X-Gm-Gg: AYBFou2LSTGNWwrsM0zX5XUkmU/Bi+xm9A87VcxivfwI3OV8MGYe3qMoWURJhZeCyj2
 +A8iHaDLK/UrzTcCWI/p3XGj8qEv/8bw1aBB6cm9svMkDIDkXAzFnAPgee7KSXNBVRawlNSpYoI
 v9mP0MBys00sreFZLkIKpe5g6/jYoOhk92jGFqdVU4ZKXM6rrHVBX1nVZp3rXdZs9pWEVtsTckl
 p54O/cRCxb3Cbr9be1HRVWOLuNAbA4f5nz41TIMqIYTfDfw3HFhGJYC/4WEmjfFqj+YytVqXUFu
 UQIhEU7VEneXVRYBx50lE7ytqhaEwVhhY//S5vE3XekTQJuA7VCbLu7quOty/ubMfmlz0rmz25H
 mX8Tvu9ec6J/TgL+5mRxdvnk00w6p6yN2P3Pq6QwNWp6UWK33uXltnsCis1mXo85KVtxgvz5LPE
 H6Qsn1xeKM9GLGY0WScl92mhtNokynPm6g7U6UmGipPpOCqw8IG1116Gifd136w8CyaDlOqjH8C
 jUNydcBXKreYrjJ5q1kiqimMHhpb/ApNQARMXLXy7oeSjd9rwjDYpRiEhdxeQ==
X-Received: by 2002:a05:6a20:7f8a:b0:3d1:be60:2816 with SMTP id
 adf61e73a8af0-3daed167aaamr27313412637.10.1789335601201; 
 Sun, 13 Sep 2026 14:40:01 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e52a60sm21717956eec.6.2026.09.13.14.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 14:40:00 -0700 (PDT)
Message-ID: <7e3a07b7-9ebe-42a2-8561-650ddcfe9026@linaro.org>
Date: Sun, 13 Sep 2026 11:39:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/rx: add RXv2/RXv3 CPU support
To: Sayyad Mahammad Umar <contact@sayyadumar.com>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org
References: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::15;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x15.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/13/26 08:21, Sayyad Mahammad Umar wrote:
> This series extends the RX target with RXv2 and RXv3 CPU support,
> forming the foundation for the RX65N, RX651, and RX72M machine models.
> 
> The first patch adds the CPU definitions, instruction support, and
> translator changes required by the newer RX cores.
> 
> The second patch adds the initial RX machine and peripheral support.
> 
> Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
> ---
> Sayyad Mahammad Umar (2):
>        target/rx: add RXv2 and RXv3 CPU support
>        hw/rx: add common RX peripherals
> 
>   MAINTAINERS                           |   20 +
>   hw/adc/renesas_s12ad.c                |  324 +++++++++
>   hw/dma/renesas_rx_dmac.c              |  317 +++++++++
>   hw/dma/renesas_rx_dtc.c               |  169 +++++
>   hw/gpio/renesas_rx_gpio.c             |  256 +++++++
>   hw/misc/renesas_rx_crc.c              |  219 ++++++
>   hw/misc/renesas_rx_fcu.c              |  985 ++++++++++++++++++++++++++
>   hw/misc/renesas_rx_romcache.c         |  139 ++++
>   hw/misc/rx65n_sysclk.c                |  190 +++++
>   hw/net/renesas_etherc.c               |  955 +++++++++++++++++++++++++
>   hw/rtc/renesas_rx_rtc.c               |  330 +++++++++
>   hw/ssi/renesas_rspi.c                 |  319 +++++++++
>   hw/timer/renesas_mtu3.c               |  509 ++++++++++++++
>   hw/watchdog/renesas_rx_wdt.c          |  193 ++++++
>   include/hw/adc/renesas_s12ad.h        |   61 ++
>   include/hw/dma/renesas_rx_dmac.h      |   57 ++
>   include/hw/dma/renesas_rx_dtc.h       |   42 ++
>   include/hw/gpio/renesas_rx_gpio.h     |   64 ++
>   include/hw/misc/renesas_rx_crc.h      |   30 +
>   include/hw/misc/renesas_rx_fcu.h      |  191 +++++
>   include/hw/misc/renesas_rx_romcache.h |   30 +
>   include/hw/misc/rx65n_sysclk.h        |   37 +
>   include/hw/net/renesas_etherc.h       |  109 +++
>   include/hw/rtc/renesas_rx_rtc.h       |   52 ++
>   include/hw/ssi/renesas_rspi.h         |   61 ++
>   include/hw/timer/renesas_mtu3.h       |   73 ++
>   include/hw/watchdog/renesas_rx_wdt.h  |   48 ++
>   target/rx/cpu-param.h                 |    3 +
>   target/rx/cpu-qom.h                   |    2 +
>   target/rx/cpu.c                       |   57 +-
>   target/rx/cpu.h                       |  124 ++++
>   target/rx/disas.c                     |  383 ++++++++++-
>   target/rx/gdbstub.c                   |   44 +-
>   target/rx/helper.c                    |   56 +-
>   target/rx/helper.h                    |   22 +
>   target/rx/insns.decode                |  125 +++-
>   target/rx/meson.build                 |    6 +-
>   target/rx/op_helper.c                 |  357 ++++++++++
>   target/rx/translate.c                 | 1225 ++++++++++++++++++++++++++-------
>   39 files changed, 7873 insertions(+), 311 deletions(-)
With 7500+ new lines in two patches, no one is going to look at this. 
This patch set must be split into many many more patches.  For example, 
one per new instruction, one per new device, one per logical change to 
existing code.


r~

