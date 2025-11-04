Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93422CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL9G-0004LT-L0; Tue, 04 Nov 2025 12:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL8v-0004IR-KF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:32 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL8t-0005ht-Jv
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:29 -0500
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-640a0812658so2833534a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278505; x=1762883305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/zhoairPLtQSrbGeNqEjZd+Q/UzplYaMRB9A0sulArY=;
 b=jdE9Z6dJUwom7pd0Owz8iws2ipC6ENz4Koe+CmKJz8vEsyypw/hxsXPeOssw+B+fhA
 pKToNh123fZD10mj3bRPPgFR6aHjCv03YsJgNs8iPqTTVy/Nx47aaycigWGrvL/1vuTV
 bxmItZeelB0uHvDsp9IgdJ4H38OfIcIu2wxLn9jUztdVA29XMi01ub822F1VkKVAkbiU
 Pmt5ZFIDX1ykoiRCtiUnNcE3z7wtKpMdK/LMIRvQBSYfNXgL1jSTPzEinnMEwt7lMZdY
 RnebkoTjAinvYlp6UIjPeWw8G8PXC5MYDBkWQqO8cR++6m8a8p3gaFch7UQicsKjXHPK
 vszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278505; x=1762883305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/zhoairPLtQSrbGeNqEjZd+Q/UzplYaMRB9A0sulArY=;
 b=Vpy9HJF8lw6sAoFqmPiO3LKs+t0jgsuqqB5H+GKmuRfK7ZD+VVo5/Gra17rQN/UXH+
 vxknVt1RHBas0ZxEuvGlUxe0+GBhKMosDqKnvuIeN9CKaLtiZzMuGqtEeuEo29o0BhQg
 upP26sC/SMbRxBFTFX+Hx6hvY3WXrS0AYZHrp85T40nuNAFFSyyYc0Rcp9++OiCtTGco
 tLkDzAnnyOpf3o5pUVbFrppYxtl5t9502ikgEmlSv1sFNwkGYA5nbDx3DWZaEalECbaj
 F6ayWD9XvgvfeybxeNXkp8y2tIrFZ8+VQ2Rc41skUyn8NnMFysOAQ8654sV7C/4mlv8X
 bE0Q==
X-Gm-Message-State: AOJu0Yw6Zmc1pqCdpIpNDgkSAuGdhZkymF6bbzfhWiFp3bU9TP/UuV8v
 pss/1wWV4cc9r6JfWaN5HrF/04Bt3dQDHcVvVRrAgh4ajOPVMK/4Jja1mkOoA12+es1YEsfC/Vj
 nqoh0nTQ53x9v
X-Gm-Gg: ASbGncvA8iYaAnghB5ep2aAfbKvElPHdkKbbanxTKifvnvRpofMb7AkPQXN5gc1tfoL
 ox57rFoBgBwbQi8hTh6Zewp8vAsxARV3xBbdENjAGvthFvD+1Wtq0mb1F6lfDu5fQ8sAKOpkZXt
 1rQdP+SZ7MXjVuU4/C4HJVCThXKLWqYkzXsF5deLDVXvjxx4on9OENu8ZWk9OrDy7Ji/WbBaFm4
 80UFXbhfeDgtGzvLmS6BLSoODFHk+MPFaL7oaOutf24SksxmxGTy4RIMDHOLCMoN902KxH8G0hq
 /bY8u1vJmkmXJg1KQ0J8tJOO7kyo8YVPr75eOFxUvV5cixjagcOVzA6Wbk+uHYrm29DTd59Sxfb
 ip0lJSm0Vzdk3tDjaROHTo2+XuX8t+54chs4aM3pDdQ4azvkUdOsRv6wCmMYk6H3xyE3LMLuPaU
 JE/krvE2w8rWqQLmsZeYcsvQ==
X-Google-Smtp-Source: AGHT+IFP7bJ8czVPMCYPIaa4nrIlccRC6qFxDFZX1aVnUpZFj+axnjz8BP2V1EU3J4G3j3H861Lp6Q==
X-Received: by 2002:a05:6402:3509:b0:640:b2a1:8199 with SMTP id
 4fb4d7f45d1cf-64105b7a131mr47411a12.36.1762278505100; 
 Tue, 04 Nov 2025 09:48:25 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb47sm2599698a12.19.2025.11.04.09.48.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:48:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Misc HW patches for 2025-11-04
Date: Tue,  4 Nov 2025 18:48:15 +0100
Message-ID: <20251104174823.92412-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x542.google.com
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

The following changes since commit e9c692eabbbb7f395347605a6ef33a32d398ea25:

  Merge tag 'next-pr-pull-request' of https://gitlab.com/berrange/qemu into staging (2025-11-04 15:17:31 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251104

for you to fetch changes up to f79fec0275ee7a5151ced9b893c4af676c7f5db6:

  hw/audio: Remove dead code from ac97_realize (2025-11-04 18:19:16 +0100)

----------------------------------------------------------------
Misc HW patches

- Add RPMB emulation to eMMC model :)
- Use generic MachineState::fdt field in microvm machine
- Remove dead code in ac97_realize()
----------------------------------------------------------------

Jan Kiszka (5):
  hw/sd/sdcard: Fix size check for backing block image
  hw/sd/sdcard: Add basic support for RPMB partition
  hw/sd/sdcard: Handle RPMB MAC field
  scripts: Add helper script to generate eMMC block device images
  docs: Add eMMC device model description

Jan Luebbe (1):
  hw/sd/sdcard: Allow user creation of eMMCs

Luigi Leonardi (1):
  hw/i386/microvm: Use fdt field from MachineState

Osama Abdelkader (1):
  hw/audio: Remove dead code from ac97_realize

 docs/system/device-emulation.rst |   1 +
 docs/system/devices/emmc.rst     |  55 +++++
 hw/sd/sdmmc-internal.h           |  22 ++
 include/hw/i386/microvm.h        |   2 -
 hw/audio/ac97.c                  |  19 --
 hw/i386/microvm-dt.c             |  96 ++++----
 hw/sd/sd.c                       | 368 ++++++++++++++++++++++++++++---
 hw/sd/trace-events               |   2 +
 scripts/mkemmc.sh                | 216 ++++++++++++++++++
 9 files changed, 686 insertions(+), 95 deletions(-)
 create mode 100644 docs/system/devices/emmc.rst
 create mode 100755 scripts/mkemmc.sh

-- 
2.51.0


