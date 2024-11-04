Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCC4D132A6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uAX-0008Iz-7m; Mon, 04 Nov 2024 05:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uAT-0008GK-JM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:18:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uAR-0007Dy-N5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:18:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso49377565e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730715518; x=1731320318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGv//PzjHkQ7LKwoyx7XOEi7VsKrmG3iVK86N7xLLpw=;
 b=zUOumPw8Vm/8mxoZ7kB4QqMUT3dr5e0rGqWgcBwf64AwsYykM1PJjetWcvG7+OLfoq
 YE7RUpxCOL3toq8qvuKF1zWU7THPxKnn5h/szb8bEIwZH2C0vwIdlK1pH+OmTYHS3lrL
 JwJfqjf5eMeSbMpQ4FnRvxwxSDG9qXaYQyeDrlDfDoEnAozItsaTPqLJv/2XtL7yIeV3
 nd+IJZCPtHB1L4Xv4jmwOVd2Ej9VdX6/de0mF41zkeJWa7OjO1eubZTjY9BJ3Zg1bxU9
 pZsDMPP83bY1kdFaUbnX8VIc66V4WVHB/MoKrtbSdGM69JFCMvizkEwadSxf8TQf+Dky
 yoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730715518; x=1731320318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iGv//PzjHkQ7LKwoyx7XOEi7VsKrmG3iVK86N7xLLpw=;
 b=J4HHR1q3vGjmFZ8HnGznFOdkzEm0WQaEpiLGZDp6bTM+zYPadctAdr5iuVU+miYLN2
 6WfWSar7xJmeBtJj9tfQapRzT8zwQditHnH+eMomRFPYk/TIcLhVRC5cfPXZnJJ1xYS/
 Iggxf09RLZuenm/KFgDHX7F7yWWj2eETPlKRxMRqdAC2yGNlYUhs41AqV6Zh2LPm72Qb
 1QwJpimWensgbEficiLYsC41zEURN3RlcfzIyl/vg7JNx2nd9IA8L/WzSWc4Fk5q6pig
 vdzJcUaXndcyhd932dsqr4tYxeP1RjNkH+NCPWdJThVx/b2eGOW4ifmUbpyVJdCUnNt+
 OqoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW63fTHYRhrOvTHKZBkkniPBHk9CIR/4kCQlCvAtCF3ryrakX184MJumH9FB9KQGqsPvB5DRZMtiYP9@nongnu.org
X-Gm-Message-State: AOJu0Yy6+wTIsA4WJrPmXE2fO1cb/r4Ql5Jf8W/V4je858E/OtfEUT7Z
 a8EXPokrvCdXfHevUXAG+XQ6O+Y6WaXMdTOkUOC8f+C27fI+f2hlbcc9kGx2FIg=
X-Google-Smtp-Source: AGHT+IGR4HbaHYQd3mxLzAOLLuiEi3qZdHDVD6wNImKMAbpSXJBRhhWC612oHEWx5jOERNNKyrxGWA==
X-Received: by 2002:a05:600c:1d1e:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-43283255922mr120989675e9.16.1730715517752; 
 Mon, 04 Nov 2024 02:18:37 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9479ebsm176876595e9.23.2024.11.04.02.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:18:37 -0800 (PST)
Message-ID: <396b6a26-0127-479f-af5a-00feb4103a26@linaro.org>
Date: Mon, 4 Nov 2024 11:18:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Don't set always boot properties of the emmc
 device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Jan Luebbe <jlu@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>
References: <20241103210829.2307729-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241103210829.2307729-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 3/11/24 18:08, Cédric Le Goater wrote:
> Commit e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
> HW strapping") added support to boot from an eMMC device by setting
> the boot properties of the eMMC device. This change made the
> assumption that the device always has boot areas.
> 
> However, if the machine boots from the flash device (or -kernel) and
> uses an eMMC device without boot areas, support would be broken. This
> impacts the ast2600-evb machine which can choose to boot from flash or
> eMMC using the "boot-emmc" machine option.
> 
> To provide some flexibility for Aspeed machine users to use different
> flavors of eMMC devices (with or without boot areas), do not set the
> eMMC device boot properties when the machine is not configured to boot
> from eMMC. However, this approach makes another assumption about eMMC
> devices, namely that eMMC devices from which the machine does not boot
> do not have boot areas.
> 
> A preferable alternative would be to add support for user creatable
> eMMC devices and define the device boot properties on the QEMU command
> line :
> 
>    -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb.raw \
>    -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8
> 
> This is a global change requiring more thinking. Nevertheless, in the
> case of the ast2600-evb machine booting from an eMMC device and when
> default devices are created, the proposed change still makes sense
> since the device is required to have boot areas.
> 
> Cc: Jan Luebbe <jlu@pengutronix.de>
> Fixes: e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
> HW strapping")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> ---
> 
>   Changes in v2:
> 
>   - Simplified "boot-config setting
> 
>   hw/arm/aspeed.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


