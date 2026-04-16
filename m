Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C489F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDKeB-0005mP-2N; Thu, 16 Apr 2026 07:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDKe6-0005mC-Nq
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:12:30 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDKe5-0003z4-5N
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:12:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d75312379so363244f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776337946; x=1776942746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DpoupK5sFkNMW5ehWsERuQXNUSrKBYM30ysyhw6HGt8=;
 b=KjbmTVNlwNGys7NoIHA0D+wZ/Q+roh9Z9AXbMZqmqU1m1edbSi3ohKbOwkkTLFRXlc
 zOWwpad4l3en5akJK9aAuVhmlCeCHyhZ1bcSHuAVCdhjDONw4uYf9yk2d7PABYlecsTW
 cwMAREjS6/V9trqvNXDHZvDrm3bFvL1wnEvoq7zbEp66LkuaWFCthVyiyn0hmAgji8UN
 XfiPHTl51sPxsX/qb5Z1mcLlmTjoAItTjAaFgwed2nwHgNb+JNkDwKrCelNRdBrjvlJB
 tYiwjR0yWROC8f83i5YF2bhOojsqeqZyujyyEIxMlDvovGxlGzzppkGA+HY9MrwAI+L4
 DC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776337946; x=1776942746;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DpoupK5sFkNMW5ehWsERuQXNUSrKBYM30ysyhw6HGt8=;
 b=aHMyX8QqEu/q3VvX2BMRgKTRnLFoMpxUuG+Uq7a80+j37eZO88LGADFRdjbpj+/ODT
 oWJNhsnmgMFiTdIAv4IliRrx0Bn1kEg5tHpNE/BrioF8eRfCmFJzheCQGJ+82U7y8P5c
 N6J0k1Zwj1FFtcGHlYL9icO+7V00LHkB2GLGtWPJYmxA36I5GjGS66KafrCvF2hY2HZx
 t6IDkWLR4vhG1928k87bIV/zJtNC+yv46SN74CsyzotMl2Swdhlt55R0Sd75cJ8mlWrT
 cdEBgjx7uPceZuDba7zG+D42Pb83PiieNIC2swVqRpTupKl2TpKl1F2jG+yV5Mb3aywY
 Z07Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9euByD9Yc/UZIBzzjrwQJcQ+6wyH4BZjOhFE4C7CKH9Wnp9IJatu1Aben+iQ5HPWEhp+G4EUWRI7em@nongnu.org
X-Gm-Message-State: AOJu0Yye2SN7Y6ZAYJ6AkUnrB4i10BaIdCyZG7a1aLITND7vso0gGuKB
 JvGWv6TKjIVAScCSEln2cYXuxOFsBfUR7rAPO5hWc8DfnjZywpLXHaOMyk+P5jU8QNE=
X-Gm-Gg: AeBDietfpHYbm3DNVMHfoY7KK64wF9wCK/niGrzfdDrTrWcy1UQjjBGkT5MVMIW5zXy
 3CLaTVT1ZCwgYiXRKtW5VbSaQWcvsL5oe+nB29TMGg/5daoYEYur1/Q3qZk6JLTiMo18HTTdmVS
 edUseez5IrKu530qipgCeN/7sgyRc61vrcQ9X9VeqtGtOJ7b3epeCLSTggMdsJd2eB92BAGSmLe
 Ybl04ZNSj8yQJAxdNQsXNHKbFAaCqEcXh2qUN5eBMVGbwZo73CaQcURFJqmkQM39MnlZanrr2uN
 WlarpQRZ8FucVXbP3F+XDd+/7/S8WLrWc/CZ47DRIozn7miotKq8EGChC+AZ6FI00As/IvzBC2G
 Lkhr07mrMgZxqO+/Td5f4CBO7TjpIFZNXeb1GgwSFyIfa50a/b9qjNx6q5JgJs0fJttXAVbroFg
 wvRfT11L/1xE4UvpKiZOJAZeT/fj6AJOReBn3epg3jn/izKb29lfbQcmqvg3vUj6cQUA==
X-Received: by 2002:a05:6000:3cd:b0:43d:788c:de83 with SMTP id
 ffacd0b85a97d-43eb107fc6cmr4005920f8f.6.1776337946057; 
 Thu, 16 Apr 2026 04:12:26 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d518sm13166914f8f.6.2026.04.16.04.12.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 04:12:25 -0700 (PDT)
Message-ID: <2cedb580-c483-4c8a-a3ff-297ad5d4ba77@linaro.org>
Date: Thu, 16 Apr 2026 13:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/28] MAINTAINERS: Remove Su Hang
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-24-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>
In-Reply-To: <20260416091654.316158-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

+Alistair

On 16/4/26 11:16, Peter Maydell wrote:
> Su Hang has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
> 
> This makes the Intel Hexadecimal Object File Loader orphan.

$ git grep -wl load_targphys_hex_as
hw/core/generic-loader.c
hw/core/loader.c
include/hw/core/loader.h

We should cover these under "Generic Loader" now.

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f50575083..9ef51955e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2716,8 +2716,7 @@ F: docs/system/guest-loader.rst
>   F: tests/functional/aarch64/test_xen.py
>   
>   Intel Hexadecimal Object File Loader
> -M: Su Hang <suhang16@mails.ucas.ac.cn>
> -S: Maintained
> +S: Orphan
>   F: tests/qtest/hexloader-test.c
>   F: tests/data/hex-loader/test.hex
>   


