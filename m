Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D011FC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT36h-0006PW-SZ; Thu, 25 Jan 2024 12:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT36V-0005vy-4m
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:01:28 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT36T-0003As-8Y
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:01:26 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cf1b770833so32393401fa.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706202083; x=1706806883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9CK4t70doxfJPBUBKGbJxqyjDutJr+2UWcMQoXHlIjo=;
 b=SiMUXxrUgQ6rnGU5iq0LAEYC+c39hM5wra9sJvoqKMkvQDYNu+D8W0/p2SAjUcIEzj
 8mwhW4Ppq/MnKH/YsDbDt5Rw32p+1K/FOvmiYjibbJ7NPZyx/s9IpIa/ccj2qVmZBbW7
 G3vagRnnoq0GOcVSXoYIeVksXKydBIXhXkA/hI3nnGuilpgkSnbKTLw40ytW4p9NUQ/Y
 O7CJ8ruDJoHpgTsQhBTV7Sm5GxEoXZiBgU7djZJUsAV/vbGHfnpdOZE2UWQew4Jb+vpR
 TNM/AV2DGmAbPrtTdDE412JGHoUlej6fgcMZTiW86XIA31uVcrmfePT5Mh0Uw2iamMAA
 fBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706202083; x=1706806883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9CK4t70doxfJPBUBKGbJxqyjDutJr+2UWcMQoXHlIjo=;
 b=pNplHeCIIkx3KiBjtGeNEHTrdj2xZen86omuDz0IWw1rqCEibG46Pd+gNOzP4WUVSv
 IO9HsjQ8+/7FrSSX4aK7hhotRzCdcz8ZJwtC2VuMtzxgPKbLighucV0QPMMON7jPRZ6E
 xla4oyuJOD9HLH7Z4u7Ghhlj4seWVJ/MWvKxnSKaviVogDfJdT6eK+B98daK79xXmiJ8
 lyiBbX61aaW6lB9QsiWck9vuGCaSVjVneSDP1GNwVKW6lJ4LPMEJv2vOBUnVOVpd6Ovn
 Zocw7agoDoUVyaCUpPpOM3B5DDH4YQQ77iOr7GTr1z3ANqQ3UFEsTtIXzVIT2wZua61x
 HRnw==
X-Gm-Message-State: AOJu0YzXiEgSiFhwkNUdBA+laBmHSBk5Em4LrHaRnjMRFZLAX7pASB9j
 LXyzCDqHuJiwP8qjSmEaeue9fIcNx3ut/cFIsyNWNGxbBgebmBqHHKyEbYMyhmc=
X-Google-Smtp-Source: AGHT+IECyn34TCA5175CZoHRV6hNP1aWMo1z67LcJ2kUM6yGfipnnX++RPGPVjfP7SK7WEfktbpRSQ==
X-Received: by 2002:a2e:8858:0:b0:2cc:de09:ee92 with SMTP id
 z24-20020a2e8858000000b002ccde09ee92mr700759ljj.27.1706202080552; 
 Thu, 25 Jan 2024 09:01:20 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d5608000000b003392bcd6c48sm12913879wrv.79.2024.01.25.09.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 09:01:20 -0800 (PST)
Message-ID: <9b55e2aa-69c7-4d4e-908a-94c0488f2716@linaro.org>
Date: Thu, 25 Jan 2024 18:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] acpi: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125163408.1595135-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 25/1/24 17:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git acpi include/hw/*/*acpi.h hw/*/*acpi.c
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/nvram/fw_cfg_acpi.h  | 1 -
>   include/hw/virtio/virtio-acpi.h | 1 -
>   hw/nvram/fw_cfg-acpi.c          | 1 +
>   hw/virtio/virtio-acpi.c         | 1 +
>   4 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


