Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C133C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JM-0007Aq-2C; Thu, 20 Feb 2025 11:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JJ-00077T-1r
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JG-0008FC-Vj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so9945435e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068517; x=1740673317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YMeWR3nzg9/+YwDWkwsi3fWnSYAK6QnRW2CCJY0E4oc=;
 b=FLx28BPJEgyfkLhicAWxyh1jc8ae7Cg+YiYe1k2JEv3md/T/ywK0mh4Xxp6nNBpUGj
 yYzZ1oe8zrRTBybL2d8DMDO6JzZnrXaTTngQxTa43KozbfkL/qlAXmzgZQxVuCE/oKTi
 aE1wygef2294R7JuVOPQZysiC84tNDOIX7nTohLpx3fsIwVJSWm2iIstc/d+kT1smsiO
 7r3QiQiWng5LIcgP1ZHwc+H32JLa3xHyMT6zp7/ycsQy9eDi+fh54psdU2FLG7z8oj2m
 PLRJzxQIGiV5VQ/bq9BOjrEllA7IRzalfv0XTmqyxZ6W3euBtkDUegR2JXXqsqVea5MU
 cBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068517; x=1740673317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMeWR3nzg9/+YwDWkwsi3fWnSYAK6QnRW2CCJY0E4oc=;
 b=M44THZF7zxJrHDqXwvr5TeLe+mfFhyn9x9hZXpAGwOPxxAeUU+AyIe+FphykOhCn8H
 Lccv0UbXwZlo8Jt0HOh+ZCHamkKZin3wLQ01TGGUm0sfBSTJ5cjKpBx33BweoBhDxRLo
 g7/2ATywy0aqQpIvmQ5mQOABXTT9rfxPQOuby2S/iMRhua6Aygsz78brmaAg8HslO8fc
 p96aH5QKMPjusKdgng/I2bW3BsGvJmHMUK1WhQSF4W6vXIwg0CqzRAt4S+dp+L3Ge4JH
 CdOgIh1C1ULS13PjE9kzkS+voeofMjDEPFMavxI7XSF2eDCopT+cX0vNu33KP7Kk04BK
 eeqw==
X-Gm-Message-State: AOJu0Yyq9pVs9AGBCULWvMCeWQVNj8qAvyADl3vUeDmL8GffjN9nQF77
 tSECl1GtSEbjbRp7ZPmvgd/iQodbdDditsLKbDefLKqD+peAOs3/6yXHvlBPP/TVJYfm6CP91MW
 N
X-Gm-Gg: ASbGnctkL+QCZnPuqJa79Y0qJ1+jRSsKGZeHq9/2V4dU1ZueH38vXRq+k6vDoarsnk/
 ldvP6p/gZEy1YHg+x36UMOvWK9byj7no1eqBTr2AHFnESQ53DPBDJlxmqCeq7YPmyS+Dkc9T2hM
 2fsr5KtHn4bn0F2eWXaiJ3Naa8qC+LKP0NpaW6Ec7nLtW2qVKL3QFYcjVg7V1ELdz7RRLfe4lIw
 nhlcEFMxoClQfByMZ5yQnm/gHfbVzZ+L4WFgU54esa//xbQNyDCodNFwwBaV/sogGRLpHxDNpAt
 Pmy3iyxHEoOkfwiiQrsjTA==
X-Google-Smtp-Source: AGHT+IFwu5dFx2hhfqqBGUNeTFVY09O31XJqqKO9jPwKYF0MivY3XbTTTTjpmWFl+dytoUQsy1OsXg==
X-Received: by 2002:a05:600c:1c18:b0:439:6d7c:48fd with SMTP id
 5b1f17b1804b1-43999d755acmr83259385e9.4.1740068517499; 
 Thu, 20 Feb 2025 08:21:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/41] pc-bios: Add NPCM8XX vBootrom
Date: Thu, 20 Feb 2025 16:21:07 +0000
Message-ID: <20250220162123.626941-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Hao Wu <wuhaotsh@google.com>

The bootrom is a minimal bootrom used to load an NPCM8XX image.
The source code is located in the same repo as the NPCM7XX one:
github.com/google/vbootrom/tree/master/npcm8xx.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-3-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                 |   1 +
 pc-bios/README              |   8 ++++----
 pc-bios/meson.build         |   1 +
 pc-bios/npcm8xx_bootrom.bin | Bin 0 -> 608 bytes
 roms/Makefile               |   6 ++++++
 5 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 pc-bios/npcm8xx_bootrom.bin

diff --git a/MAINTAINERS b/MAINTAINERS
index 3848d37a38d..e145017d533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -878,6 +878,7 @@ F: include/hw/*/npcm*
 F: tests/qtest/npcm*
 F: tests/qtest/adm1266-test.c
 F: pc-bios/npcm7xx_bootrom.bin
+F: pc-bios/npcm8xx_bootrom.bin
 F: roms/vbootrom
 F: docs/system/arm/nuvoton.rst
 F: tests/functional/test_arm_quanta_gsj.py
diff --git a/pc-bios/README b/pc-bios/README
index 7ffb2f43a46..700dcaab523 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -70,10 +70,10 @@
   source code also contains code reused from other projects described here:
   https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
 
-- npcm7xx_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for Nuvoton
-  NPCM7xx BMC devices. It currently implements the bare minimum to load, parse,
-  initialize and run boot images stored in SPI flash, but may grow more
-  features over time as needed. The source code is available at:
+- npcm{7xx,8xx}_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
+  Nuvoton NPCM7xx/8xx BMC devices. It currently implements the bare minimum to
+  load, parse, initialize and run boot images stored in SPI flash, but may grow
+  more features over time as needed. The source code is available at:
   https://github.com/google/vbootrom
 
 - hppa-firmware.img (32-bit) and hppa-firmware64.img (64-bit) are firmware
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index b68b29cc7d1..51e95cc9031 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -80,6 +80,7 @@ blobs = [
   'opensbi-riscv32-generic-fw_dynamic.bin',
   'opensbi-riscv64-generic-fw_dynamic.bin',
   'npcm7xx_bootrom.bin',
+  'npcm8xx_bootrom.bin',
   'vof.bin',
   'vof-nvram.bin',
 ]
diff --git a/pc-bios/npcm8xx_bootrom.bin b/pc-bios/npcm8xx_bootrom.bin
new file mode 100644
index 0000000000000000000000000000000000000000..6370d6475635c4d445d2b927311edcd591949c82
GIT binary patch
literal 608
zcmdUrKTE?<6vfX=0{*3B5ET?nwWA^;qEk()n=Xb9-4dxoSBrz#p|QJQL~zokn{Eyc
z?PBXUkU+aB?k?IbNQftG5ej|*FC2c{bKkr7zLy3jhNxj`gc_y5h&V=Ru)PgZC)Y`f
zTqA9Am28qL<U6@cMtA>Hlr*^&hT#;re-)dpxT0U42|O+cWOcx=B;{6xXH04vx?cjm
z+%U{oFx!aPpV3>ZKz0i$XA-yq{f}<H?{MHBq+VwIvR9WmcL(xr1vuIRGELcRC-S+P
zl3%RlR5(6+1;xg_<~xR#bPItDN1*Hp^{JyNs7o*BMq0Q9q1#>x4;|pb<NWIbQ8wb1
zTac^<ebj^E^Ig<?U?(PO-w>w;l#@9zGd|z-rs*H@V-o%PEV)D-)8n2%DyH5@w_^Y8
LH5R3RMV#gjxYTW}

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index 31e4b97c983..beff58d9d50 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -34,6 +34,7 @@ find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld
 # finally strip off path + toolname so we get the prefix
 find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
 
+aarch64_cross_prefix := $(call find-cross-prefix,aarch64)
 arm_cross_prefix := $(call find-cross-prefix,arm)
 powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
 powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
@@ -66,6 +67,7 @@ default help:
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
 	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
+	@echo "  npcm8xx_bootrom    -- update vbootrom for npcm8xx"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
@@ -194,6 +196,10 @@ npcm7xx_bootrom:
 	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
 	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
 
+npcm8xx_bootrom:
+	$(MAKE) -C vbootrom CROSS_COMPILE=$(aarch64_cross_prefix)
+	cp vbootrom/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
+
 hppa-firmware:
 	$(MAKE) -C seabios-hppa parisc
 	cp seabios-hppa/out/hppa-firmware.img      ../pc-bios/
-- 
2.43.0


