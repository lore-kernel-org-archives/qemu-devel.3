Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31984C54798
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 17:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reICS-0006zH-P1; Sun, 25 Feb 2024 12:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reICQ-0006yO-TA
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:22:02 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reICP-0004pJ-7c
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:22:02 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d23a22233fso21881451fa.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708881719; x=1709486519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T9aNBWwemZI8JUbqOJH8stDMJ1LLfZFVkjEh8JhyMDo=;
 b=E/iil/QfrNPblRsutcCWa/xdVMNPNYE5BfzVbxCZt/ZcL7zIlkq3lhgjbfDNHwBPkI
 +66qzdtbmvaWPX/fr6QrIMGeIj+KuDN6oHwZnCqJgcxhfaQhlx96bBmZUFEMnb1jvxCW
 TDXXgz9x8KGfe4WgCfeDUWsj7jPOh8qHNPpsosbtx8C5Obvtn2BId+Of/8wcyGo8V9ue
 CMc6Wizdhhi/euf0G9ixFY40FgRnfQqSMWqLXQ8ZYmUZLLOUSG5bgL4wqFuq8WNmouZH
 WLJUlreB6Qz35xGs5HOK7lfoNexZvL7ZwWKdfH5LTaO+YZ2MecBZ6zZj4abGQOqnbHLL
 l3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708881719; x=1709486519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T9aNBWwemZI8JUbqOJH8stDMJ1LLfZFVkjEh8JhyMDo=;
 b=weSLdbAbUvgORoEsPxJLRa4E+MkTjImfZTUNSXzWczlfdspYvwyNHGP8MgR1xo2I/z
 aZlhE12rWBBVsIY/nVkLph9Xay3tz7KG/rgOTvjUu7T4phm5dE+RtFVDXTk0y51DNkmX
 0SbwB7hplRvIXlK8Go+fnFCeY9k7J5qRbNQAOK7JrsSeLwoA/7dj9ELXx0lBX53x86Nj
 pToJ5Bov71cKf2CLYSbrR+V6KdyMvjEQarUgU5gBOWn+SQwuG7B42wGU8FCut0JJSrkh
 H+o/p3iYCK7oshI4Ff8ewHFgFUWeQQsQse7SfmHu05bCcoyeUJdVvc/iJjvG9hEuysku
 WCNw==
X-Gm-Message-State: AOJu0YzwKe1oL9itUdDqJyvT1lZe216C5W6BPVfLgPlMZfY4Sb++MAoI
 Ut35N+0mXGvnX1xFKOVEg8djXQrK97nQEk2f8bqDeSWzkl7xLDEWx1/pAOmykuonJ89HzfTBNyF
 w
X-Google-Smtp-Source: AGHT+IE8xoc79nfANBC+ELWNtKXMuvJD8dsi8FYANb0+QwGdOkKJxn/TssXQCxEL6nqJgy+aoc6h8w==
X-Received: by 2002:a05:651c:2128:b0:2d2:3fac:5fdc with SMTP id
 a40-20020a05651c212800b002d23fac5fdcmr3504213ljq.10.1708881719173; 
 Sun, 25 Feb 2024 09:21:59 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b00412a2060d5esm2592868wmo.23.2024.02.25.09.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 09:21:58 -0800 (PST)
Message-ID: <0fa25487-f25a-433d-b916-4b12ea5649ed@linaro.org>
Date: Sun, 25 Feb 2024 18:21:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/arm/sbsa-ref: Do not open-code
 ahci_ide_create_devs()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240225171637.4709-1-philmd@linaro.org>
 <20240225171637.4709-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240225171637.4709-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25/2/24 18:16, Philippe Mathieu-Daudé wrote:
> Use ahci_ide_create_devs() instead of open-coding it.
> Not accessing AHCIDevice internals anymore allows to
> remove "hw/ide/ahci_internal.h" (which isn't really a
> public header).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 5d3a574664..995c7be23e 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -37,7 +37,6 @@
>   #include "hw/block/flash.h"
>   #include "hw/boards.h"
>   #include "hw/ide/internal.h"
> -#include "hw/ide/ahci_internal.h"
>   #include "hw/ide/ahci-sysbus.h"
>   #include "hw/intc/arm_gicv3_common.h"
>   #include "hw/intc/arm_gicv3_its_common.h"
> @@ -572,7 +571,6 @@ static void create_ahci(const SBSAMachineState *sms)
>       DriveInfo *hd[NUM_SATA_PORTS];
>       SysbusAHCIState *sysahci;
>       AHCIState *ahci;
> -    int i;
>   
>       dev = qdev_new("sysbus-ahci");
>       qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
> @@ -583,12 +581,7 @@ static void create_ahci(const SBSAMachineState *sms)
>       sysahci = SYSBUS_AHCI(dev);
>       ahci = &sysahci->ahci;

Bah, we can even remove that 'ahci' variable.

>       ide_drive_get(hd, ARRAY_SIZE(hd));
> -    for (i = 0; i < ahci->ports; i++) {
> -        if (hd[i] == NULL) {
> -            continue;
> -        }
> -        ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
> -    }
> +    ahci_ide_create_devs(ahci, hd);
>   }

-- >8 --
@@ -571,8 +570,6 @@ static void create_ahci(const SBSAMachineState *sms)
      DeviceState *dev;
      DriveInfo *hd[NUM_SATA_PORTS];
      SysbusAHCIState *sysahci;
-    AHCIState *ahci;
-    int i;

      dev = qdev_new("sysbus-ahci");
      qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
@@ -581,14 +578,8 @@ static void create_ahci(const SBSAMachineState *sms)
      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, 
qdev_get_gpio_in(sms->gic, irq));

      sysahci = SYSBUS_AHCI(dev);
-    ahci = &sysahci->ahci;
      ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < ahci->ports; i++) {
-        if (hd[i] == NULL) {
-            continue;
-        }
-        ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
-    }
+    ahci_ide_create_devs(&sysahci->ahci, hd);
  }
---


