Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E887AC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8tL-00043a-ST; Thu, 08 Feb 2024 13:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tI-00043A-Ln
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:12:52 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tG-0006jN-I6
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:12:52 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51168addef1so165470e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707415968; x=1708020768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lxTc3jqSRUKEXY4j7x33THoNlB0OypgFh9Be8wo9PFw=;
 b=CxNWf5Eq7hYGE3BLucdav8+rxOsIyKevySChOoH6+XH1KPQtzCP4TKQ8LjWuZpaRmx
 aO/2UwPUJgHvg6av58vS9/B1jH1+TRezOgUPYG8bOOhSgpITj0F2CNW8qnVV1oRW5got
 38HAo/aW9qs2Ug96ZwDUO8CSr8PNx6jJT1oUknKVYzYg7+5tZB7sLZBNjngzPBuWn5WF
 2V/RymTLKUfLsbLW/8KUQN9EH23uSvF6HdWv3khTFk4t55AYdDu1Qxn6JtK/0PRvS2DM
 63FikfnS7z217QmrfFXL2VESAC4nThnjgu0Eps8yaFvEfbExlaw/1GDXJwEfu3hD7OeX
 OG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707415968; x=1708020768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxTc3jqSRUKEXY4j7x33THoNlB0OypgFh9Be8wo9PFw=;
 b=vquDLDsLWjsh5mIuhWgOlyoM3CIxTMIsmlEN5v6u9huMmd9e/6jTijZQ6MpG6oztAz
 J+H+u7fdflKt7gWm4P2o5vp7tf37ExvHcrgWz03YoHYpE781g105RP3GDi0tgFJDfwit
 iB0OuFvyA38ex6GYvgke3JwgUrFE9uMW24Tsl8CmcouYjSAiOxPUTfAERoovkPgQOFtD
 9ph9iJOTscepUSjbWLt+8V3idvQPlaCsUKVEsRsUTR9FsDAcPRmmV/Awir0CfUR9fB/G
 aH3lM2zI84woK8JvyXuv45dqa80ziEePMWZvZWGKXHjK+uFTeSRHGf8zQnML2E7MD2ga
 5EZQ==
X-Gm-Message-State: AOJu0YxeWihPtfnVpyq53FF6zgqqkghoNz9AzRUMgd6Wzf44+Ck4tf7g
 X4GbdPClDNJfqJoHqWNUCghxNa45jFr2aTNc9YxKGACkXt0/TTvC99yOOF9Vua5/AxEjnxp15KK
 pg64=
X-Google-Smtp-Source: AGHT+IFU++EFtBUA1FX3v/oeyEp9Xc1Rm21MvP9AaTU02dxGYb0HITrNHniqFZ47DfUQFTWaTGKYOA==
X-Received: by 2002:a05:6512:3a86:b0:511:4a6e:59c1 with SMTP id
 q6-20020a0565123a8600b005114a6e59c1mr42903lfu.3.1707415968177; 
 Thu, 08 Feb 2024 10:12:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUn9d8FpwwC50ysKTEoGY0+axwfWp/5cltV09CHgPYKGpS+GxoJd1XD5iKz38rUSc+KSuCpxnZLSTgTZjmsErKl3IXJ3l+LER4BEaDsZEKSHl2hmDLuoMA2ii6t6W2vNlGP6O8DNvkiI04saUlhclG/ltVKc9ShMlaLxgAQjjxr7fJEAOY0maEY0wb5Mac89LtCG4fTkFTugmEVfnn+bSyccA2nA61SyEH3nfUa1YA+9+4IVAItiJIASPTXtMfeLcHL0vFq0DSFzqco40sc/CBdEGG/7mthij/lCuaIAZmQXQnfbWaasM9Q6Z2KRtCcxBp7qEhH5A==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a39e0196eecsm303335ejl.26.2024.02.08.10.12.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:12:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/11] hw: Strengthen SysBus & QBus API
Date: Thu,  8 Feb 2024 19:12:33 +0100
Message-ID: <20240208181245.96617-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Hi,

This series ensure following is called *before* a
device is realized:
- qbus_new()
- sysbus_init_mmio()
- qdev_init_gpio_in_named_with_opaque()

and these are called *after* it is:
- sysbus_mmio_map()
- sysbus_connect_irq(),
- qdev_connect_gpio_out()
- qdev_connect_gpio_out_named()

Patches from v2 enforcing these checks will be posted
in a separate series.

Philippe Mathieu-Daudé (11):
  hw/ide/ich9: Use AHCIPCIState typedef
  hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
  hw/rx/rx62n: Only call qdev_get_gpio_in() when necessary
  hw/i386/pc_q35: Realize LPC PCI function before accessing it
  hw/ppc/prep: Realize ISA bridge before accessing it
  hw/misc/macio: Realize IDE controller before accessing it
  hw/sh4/r2d: Realize IDE controller before accessing it
  hw/sparc/sun4m: Realize DMA controller before accessing it
  hw/sparc/leon3: Realize GRLIB IRQ controller before accessing it
  hw/sparc/leon3: Initialize GPIO before realizing CPU devices
  hw/sparc64/cpu: Initialize GPIO before realizing CPU devices

 include/hw/rx/rx62n.h |  2 --
 hw/i386/pc_q35.c      |  2 +-
 hw/ide/ich.c          |  6 +++---
 hw/misc/macio/macio.c |  8 +++++---
 hw/ppc/prep.c         |  2 +-
 hw/rx/rx-gdbsim.c     |  1 +
 hw/rx/rx62n.c         | 17 +++++++++--------
 hw/sh4/r2d.c          |  2 +-
 hw/sparc/leon3.c      | 11 ++++++-----
 hw/sparc/sun4m.c      |  7 +++++--
 hw/sparc64/sparc64.c  |  4 +++-
 11 files changed, 35 insertions(+), 27 deletions(-)

-- 
2.41.0


