Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0E7FB44BB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAR2-0004PO-Cr; Fri, 24 Apr 2026 02:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAQr-0004NK-Ki
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:54:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAQp-0007ep-VH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:54:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so5055741f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777013670; x=1777618470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZOi/iuMpDT55EgSIhKuNUkRE1NCDngJ5z6gtpcACVYg=;
 b=RT9W5zQCujF1iNiLjFXE2DzDSRucx0NpSBUePmkn9ixRL7G/QgZ5CRtK2WraOC37XU
 6KW/6bCnUfBIW0ghgnboJKJxvK5u3v2q+Ml22c9NlF5dHl5yaW03L/5mWOiSDJYBIKtJ
 d6XlGNBeFSl8x5znGgcEp7ptg0/DWcm0u35G1M7h106YO3EDKh2+Xh2RmS2glM133+BE
 N/xgs3OXHEssBAb9UbAnFkCOqQHpN0OTlPfJgSqBinfx8mVRIvDuVXaT0C8JapIOLZMo
 0mUUNB2yVaR6vnzx+ZUYrXg+lBiZ/VdETgCl7jrzauZbAdX4wrEQuJTY1XrzetV7sC2A
 eSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777013670; x=1777618470;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZOi/iuMpDT55EgSIhKuNUkRE1NCDngJ5z6gtpcACVYg=;
 b=IfjL+7IsubzlJpG5sEzxmTAeCHUJdCdtf1IZWJjPDDSyf8z2z8t8Eg0Xw5faOeu30x
 OUpvVA+1hgUtt+DHp6J4p7zy8QuXmj2J5FkcVMSBcUjVEJ8gPpBphtCzcjP0Wipdpnjc
 aBdXsW52cTkDyiXYWpPotSBevDiT5cWIyheAMDHQLCF+jhj/2aLOmG0huHOd/WsSP2yr
 536Ukb2/VPKE/FxRPctvm03hq0N3NbuY6jLyeub+qcDipYYxiMKGs6fM6Mg+tJ5FQUdB
 OPOY7V+xdFzy/R3BB3lv+EY317XhLBc8/bZITPoD+KlXXxwPZZGfqciMk+DaTXDdUyPD
 YZxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lf4TRus/Eb46do/gb/pnE6kKFFPeM1pjnVsMIHuJsEBhNbfY+RKgXOhfdxkbnt70V98mAA99/FFfI@nongnu.org
X-Gm-Message-State: AOJu0Ywxs4tWdkD2tAw8ALbhKSXldX+Se/jP9PTrx/f6/SqBRM4MItBN
 8XHXAW8LRVZUR4h2ET+/ddhRKt08Xw/n+oZsQ6pmDvhUfayMOlmy0x8XQ+q1IG4vN/vvbQxJxYW
 W3gjWS48=
X-Gm-Gg: AeBDieu1mCsv73HaWN/xLG6A/WU96lVs6YNVBj3f597OIfiCJtgGhMEbSFLz50GUz2f
 x0nS5uiqRH5rmskzv09dD0Y6uZ3ZxvVWU+5AkuZ2qLrBFBAhmcwu0P7L9M7mgO/tEo5xhY3LHmh
 QNGy+iNKtsz7O/41ArJimPCpLCu/c9cpbxgnhUTHTHZ7qdATVRcGmNlkcKp/KSW0SkSFGpoXbRu
 SE3oDjmWAS++W2qcT4u/FZCdQ1MyhjEDalaJ6RgagQmG3/BFPl4hFigDw+5pyE2Y/KmK6q4KUp7
 y3MyG9z8z4aa/QxA42xOAHBGKmqEjAVWJN3/fOK22TalkvGm100I0kivil0lFOa//HZ3iciQ23f
 aMZbNCfiAVZ0RsjRizSoL05rH3BDy/i+QMUblZhXn+CuIawIs3PhPzj2JUYTd2wWxoFA+FhvVVO
 xmsRY8E8GinhgR4tOM40yByQ4RdXt5bNF21zmUEqXv4klunhh54vvt045nP4PKc5ebMzeaGQjnD
 d8x
X-Received: by 2002:a05:6000:25ca:b0:43d:75a2:44aa with SMTP id
 ffacd0b85a97d-43fe3e125e1mr48157756f8f.43.1777013670184; 
 Thu, 23 Apr 2026 23:54:30 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm52240778f8f.14.2026.04.23.23.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 23:54:29 -0700 (PDT)
Message-ID: <3ba72d44-91bf-417b-9a8f-4fd7ce796359@linaro.org>
Date: Fri, 24 Apr 2026 08:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] raspi4b: Disable L2 cache
Content-Language: en-US
To: Alec Ari <neotheuser@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>
References: <CAM5Ud7OgnsygAHxjGEO-qo5+3zYiAQFN85D2bx1Wb62vK2hzRw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAM5Ud7OgnsygAHxjGEO-qo5+3zYiAQFN85D2bx1Wb62vK2hzRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Alec,

On 24/4/26 00:00, Alec Ari wrote:
>  From c5eabff997cf2231326c532c2cbc51fa1334fb9b Mon Sep 17 00:00:00 2001
> From: Alec Ari <neotheuser@ymail.com>
> Date: Thu, 23 Apr 2026 16:42:06 -0500
> Subject: raspi4b: Disable L2 cache
> 
> L2 cache is not implemented yet, this patch requires
> `clk_ignore_unused` to be set in the kernel cli.

I suppose you mean '-append "clk_ignore_unused ..."'.

Could you add another test in the following file with the
kernel you are testing:

   tests/functional/aarch64/test_raspi4.py

Can be done as another patch on top, but having the test AND
the fix in the same patch is good practice.

> 
> Now able to boot a 7.0 mainline kernel.
> 

Per IRC:
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Alec Ari <neotheuser@ymail.com>
> ---
>   hw/arm/raspi4b.c | 1 +
>   1 file changed, 1 insertion(+)

Regards,

Phil.

