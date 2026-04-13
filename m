Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F26EF531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPeX-0003x8-1u; Mon, 13 Apr 2026 18:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPeU-0003wh-Jq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:21:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPeQ-0002He-3j
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:21:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso61114475e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776118860; x=1776723660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2VRtE3k1J/gNI88tJ2LxJP5LU9NcvGS0CEtK+4g9nz8=;
 b=Enf4XjX7tqS3Ioz4D1CTcX6kPg/SlddXHaql7bKt5OFpPJN+fzBaUnRKrZN7pu51IX
 ZqXEJmFQXdQIWIfr4DxAgFmikhPdPUHYzehRMpNQY9/keHOevY5GTRE/EcILP7qQi3oY
 dEEZJZXw6EZN+wgMjAgexV71di53+YRdKQ7BYyohHAphUBQ1Df1TTjbnz4pUfbKzHO5x
 +LRrkrlY49c0Br5ORavZs9ys6NveeL767RGsTONhWHnP5J6LsaQbBkyEbdjgYaTd9F8d
 rq3sR1l3kShWW/MG25ANvVyXC4/bc18w4Pp4VFy7OCvdNOgg4s6uXqc5xKtoXy+OW3Jp
 CvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776118860; x=1776723660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2VRtE3k1J/gNI88tJ2LxJP5LU9NcvGS0CEtK+4g9nz8=;
 b=TsVwETxP1vuH7czfuvGjlhXLS05QMcxAYjYOJiEVzlIJKPzauIOx9Q/ju++EgEbjY9
 iwNRX5S/m3jIzg2YKDHJnZcYEUBC5tT5RaqSrRT4htuyT4niO61kK4bnSHSc14Z7TLFX
 uJYc8enQ5QVXW3i2/iiBAX6sslS/EmQhmUr0H4YM06oLQOlQnljESywfIBX1MUfaYLzz
 JzOTjgJXt8hAHG6qEMYV0tgn46JQgSDPTl1V4zwE+0mBIeSqWv+E6bIbo+Briw4mMv4b
 dGDPsYEX3Zv6t3RiVT+yxt/O3GtuQOZMal7cj0I13JWb5sJ9vnkwIwzlxWdgvN0Qwje/
 PQDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wL7MrzUq827Dd4+W5Zo3bnnxkT3VXp54mip+hiaSDpaW5wotE4frvPLE1uIaZRcxkOnelM8Sy8uXo@nongnu.org
X-Gm-Message-State: AOJu0YwVvP7X6BuEJlJ607LL5ukt80bbYWrHUQfPE+NRZOpIIu2Yo4Tr
 LZBfZ0+ZmlryxxmiYCngd2/cisGSt8sgKIEBjYRXR8Mx/X6jDi4oZLQornQtHxa8N2k=
X-Gm-Gg: AeBDieuAu1+bXrQPThqXCBoCt06j4ZBa55hxSSyB0yLEaEQHCUniQSKL6d4pwrfDEaa
 Kemku2eF95L0pzyF4Ae1ngsZOUyUbCRaS+km51GsMIiltBrowsqruokE2pQiCWNN/oRD/Ct4qPG
 3Qp/3uJW7RlSfOG4bdJL3ivfWoQgdU9VNw+v/ofwgayWedhg5kVbN4BKeOFeDUgGKwQMShdTNXE
 6fVIRffgYdVIv5n/+r3OXrRuOYL8/60R7xzBIrMj3PzAOPg2a8ueASl/vYCIoiFzcAwBRaIi5cM
 zQ4oetJfWmk2MMpvwjS1jc//VyqowSyGGADG1LzBDios4+lPsF2lz1iCPCi5pY3ThQUnsUDptex
 5FAHjnww6pSzVysfU6ry19ptSdmCBLKiRcoG3VlWdmk0dBnvKr6P5BTOK9wxVMXC4CamVpKiUJL
 6QWdCAfaTg92RMYD65Dfn3/iCb29aOreqyQ8LD4RwcxyU3eN4reHeHXsGC+ApzW8Axmw==
X-Received: by 2002:a05:600c:a311:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-488d68607fbmr150220895e9.20.1776118859982; 
 Mon, 13 Apr 2026 15:20:59 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5df260bsm108834325e9.13.2026.04.13.15.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:20:59 -0700 (PDT)
Message-ID: <934e73a1-0dcc-499c-b0c4-bbcc3cfe26f2@linaro.org>
Date: Tue, 14 Apr 2026 00:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] bsd-user: Add syscall header generator for FreeBSD
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
 <20260413-syscall-nr-v1-1-f70408d042ea@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260413-syscall-nr-v1-1-f70408d042ea@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 13/4/26 17:31, Warner Losh wrote:
> Generate the syscall numbers from the installed header that has them.
> Ideally, we'd use FreeBSD's lua infra for this, but that requires that
> we have those files installed, and they aren't quite the same across
> supported versions yet, so use this simple, but effective hack.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/syscallhdr.sh | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/bsd-user/freebsd/syscallhdr.sh b/bsd-user/freebsd/syscallhdr.sh
> new file mode 100644
> index 0000000000..fa38500775
> --- /dev/null
> +++ b/bsd-user/freebsd/syscallhdr.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +# Copyright (c) 2026 Warner Losh <imp@bsdimp.com>
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +in="$1"
> +out="$2"
> +bsd="$3"
> +

echo '/* This file is autogenerated by syscallhdr.sh, do not edit. */' > 
$out
echo '/* SPDX-License-Identifier: GPL-2.0-or-later */' >> $out

> +awk -v bsd="$3" '{sub("SYS_", "TARGET_" bsd "_NR_", $0); print;}' < $in > $out

   ... >> $out

With the header changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


