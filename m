Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969C5CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMNX-000473-Tf; Thu, 03 Oct 2024 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMNN-00046c-CB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:00:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMNK-0002qf-2S
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:00:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37ccfada422so658132f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727964012; x=1728568812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pv5cgA5tzehOzZwhcqZ8BLb8c5W4q5Yxc57Fkm02PHw=;
 b=jlH4uxJjZwzeD4eCeQGQkwjo2S6US9lqh/lubGv2ipoY9BNwiZtJbCIFiZYVIv4rdG
 mjYC6lNgFMUii+NT5XxRgECDAWoz5AZhWvpIjVN/5LTpeCmWFCBR+6Lp8uaTUzqUfGL3
 VAXWQ2k05gAKmCrybaGCoeszhxGoXR5ksJy7TMGyup2SBKFNvgH1XrAdbOBw8UmApOtW
 sKL8YilT6sTtls+nAkMoa3Uq3GSD6z1UkzORB0JAAflEvhrxKlnzNvWEJPA5cs3xNCH2
 HqIlvfNo1v6fYNEuKAJf0/8Q10cU0Eg4fCEoF8bkJNQvtlsLvC22Bwhsc4H5wMHTjnzE
 Enug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727964012; x=1728568812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pv5cgA5tzehOzZwhcqZ8BLb8c5W4q5Yxc57Fkm02PHw=;
 b=PPRxohx+PiWIixJjGeWPfWvuRLHDrIcuJF8nIGSMDwAwB7mMvUmXlpKOzp+YdV0e/G
 Is+/RsOWPPI6MY/gNP2gyYUToNzcQ3tboJOVPg91ayzyeTDXb/iWW9ktD0gyBr2RwvUb
 6XECUuF7loVZlVizMzFsDJh3npWfvO7ddSoNmfcSFIBskh5ZbayiP5NX3CK4LtEJKjCa
 ftDrXV7CO5MqLO3k+7Y9Odh+FBQpXjKvQ0dOQGodjaR8DOsHeW37BbrAMbu/sZdn64Vs
 jxZlGbTneuKatYDF4TI4G5qwJBXorg8qUVi6MJBbxHpNoUqep3bLqGXFihRQTEyZYju/
 dEdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdo5QdcX26hJ8p1z4dvpzn+HxRJI37GYWA8sknJITGl4Dsg80xTWd3wfRSvlKTr3zLwLlwcCius6BY@nongnu.org
X-Gm-Message-State: AOJu0Yw+Uaelwy0z+TrGkV3gzFusVX8kpZK31DsVHQRi0/cEn4r4s4Pk
 KPzquKLvRzOF4AEnifSokrTsgzBJoirAcz6YV6z2lqed+wlt+qAz5cxtbdnU1qg=
X-Google-Smtp-Source: AGHT+IHvfztpwtRlla1h9qamgf/ISrL85/GcMBow9HicA4XcTDcvEwxBo7dfmG9sP78ygz2jhKZznw==
X-Received: by 2002:a5d:584c:0:b0:377:6073:48df with SMTP id
 ffacd0b85a97d-37cfba1832amr5298622f8f.58.1727964012190; 
 Thu, 03 Oct 2024 07:00:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d0822bc38sm1340255f8f.45.2024.10.03.07.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:00:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/6] arm: drop last bits from deprecated boards
Date: Thu,  3 Oct 2024 15:00:04 +0100
Message-Id: <20241003140010.1653808-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series is the remaining patches not yet applied from my "arm:
Drop deprecated boards" series; this is essentially the device
removals which didn't get review in that series and/or which had some
discussion about whether we should remove them.

To summarise the remaining removals:

 * max1110 and max1111 are SSI devices so in theory could be
   created by users on the command line. However I found no
   evidence of doing this when I did a web search for
   "device max1110", and the utility of doing so is unclear
   to me since it's not possible for the command line device
   to have its ADC inputs or its interrupt line output
   wired up to anything.
 * max7310 is an I2C GPIO controller, so it has the same
   "in theory a user could create this on the command line
   but in practice it's pretty useless because there's no
   way to wire up the GPIO lines to anything" status.
 * the microdrive device can only be used with our PCMCIA
   bus emulation, and we no longer have any boards using
   that, so I think these are uncontroversially deleteable.
   Some boards we still have should in theory have a
   PCMCIA controller (strongarm, kzm, sh7750), but we don't
   model those controllers and none of those boards are
   sufficiently interesting or active that it's likely
   anybody will ever add one.
 * The ECC code is entirely unused now; this is an
   uncontroversial removal of dead code, and I only didn't
   put it in my pullreq because it wasn't reviewed yet.
 * Consensus on the v1 series was that we could get rid of
   -portrait/-rotate even though in theory you could use
   them on a non-pxa2xx machine type to achieve the odd
   effect of rotating mouse input. I've added a section
   to removed-features.rst about this and beefed up the
   patch commit message.

Of these, I think we should definitely be dropping microdrive,
pcmcia, ecc, and the portrait/rotate options, and I didn't hear any
dissenting opinions on v1.

For max111x and max7310: these are fairly small (a couple of hundred
lines each) and not too badly behind the curve for code quality/API
usage (in particular they're both QOM devices), so I could fairly
easily be persuaded that they should stay.  However I would like in
that case to see:

 (a) what's the use case/user ? (e.g. examples of "I'm
     actually using this on the command line, like this"
     or "I'm using this in the machine model I plan to submit
     in the next six months")
 (b) some kind of testing of them (which we can write
     based on the answer to a.)

thanks
-- PMM

Peter Maydell (6):
  hw/adc: Remove MAX111X device
  hw/gpio: Remove MAX7310 device
  hw/ide: Remove DSCM-1XXXX microdrive device model
  hw: Remove PCMCIA subsystem
  hw/block: Remove ecc
  vl.c: Remove pxa2xx-specific -portrait and -rotate options

 docs/about/removed-features.rst |  22 ++
 include/hw/adc/max111x.h        |  56 ---
 include/hw/block/flash.h        |  11 -
 include/hw/pcmcia.h             |  66 ----
 include/sysemu/sysemu.h         |   1 -
 hw/adc/max111x.c                | 236 ------------
 hw/block/ecc.c                  |  91 -----
 hw/gpio/max7310.c               | 217 -----------
 hw/ide/microdrive.c             | 644 --------------------------------
 hw/pcmcia/pcmcia.c              |  24 --
 system/globals.c                |   1 -
 system/vl.c                     |  11 -
 ui/input.c                      |  36 --
 hw/Kconfig                      |   1 -
 hw/adc/Kconfig                  |   3 -
 hw/adc/meson.build              |   1 -
 hw/arm/Kconfig                  |   1 -
 hw/block/Kconfig                |   3 -
 hw/block/meson.build            |   1 -
 hw/gpio/Kconfig                 |   4 -
 hw/gpio/meson.build             |   1 -
 hw/ide/Kconfig                  |   6 -
 hw/ide/meson.build              |   1 -
 hw/meson.build                  |   1 -
 hw/misc/Kconfig                 |   1 -
 hw/pcmcia/Kconfig               |   2 -
 hw/pcmcia/meson.build           |   1 -
 qemu-options.hx                 |  16 -
 28 files changed, 22 insertions(+), 1437 deletions(-)
 delete mode 100644 include/hw/adc/max111x.h
 delete mode 100644 include/hw/pcmcia.h
 delete mode 100644 hw/adc/max111x.c
 delete mode 100644 hw/block/ecc.c
 delete mode 100644 hw/gpio/max7310.c
 delete mode 100644 hw/ide/microdrive.c
 delete mode 100644 hw/pcmcia/pcmcia.c
 delete mode 100644 hw/pcmcia/Kconfig
 delete mode 100644 hw/pcmcia/meson.build

-- 
2.34.1


