Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9E4CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu7g-000314-Ca; Fri, 15 May 2026 11:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7S-0002yI-6R
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wNu7Q-0006L7-0D
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso5136732f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1778857586; x=1779462386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXicQdEbFuhViRNTnJzl4idoluEFH3ASMqDiECC5aoQ=;
 b=ZrC6zykDiutJ/06MlWT63aR1xxh4fW1XXNCd+pnCrNNY5UPYGdrohoSZ7Md0IN6AU9
 jWnScQmPX5CPw662fEMFMl4W+qR/jk9Gssxu1LpX0HlXBHM3A//bdPenjv9NorRB3LHQ
 7IZX3usId6JEkEqfYdpjr/b2/AaOlbJKsr4q+3yXbtFmaUQUO/z6pqAJRVjeGAjAJ6g/
 Hh3iWFkZlWKyDQlATyhVlTAha7bdJo2QM2hHnQNUhMdSCBRXTiBslzvhfIRWoVhBwKUK
 ghstJgdi/yF1ShGg4GYOTUjuZDHdKEZzUstIxp6eGjnLuDLq4Mvj+bpmI9iPzr5oBsQS
 I9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857586; x=1779462386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXicQdEbFuhViRNTnJzl4idoluEFH3ASMqDiECC5aoQ=;
 b=sZKxDOE6NGfEE7Av9thV3mMXQMkVUyBCXw678DKOwrJUlwFcZEyCim2sJHyccDzoK7
 ONs1qpkg2ufOlcMySY5Cl6XWmaStXDaDaWrsHmQiL9rY8LAxyFp5TLVNr9JzXk2uhZ+v
 iWa84YEmIOuOgd/3a7SsLrtmhzXECy36m2HjBINx1WpUtmdmlH45FnxhvI+S05eFd5Pt
 uF+hBhFoZZ9adtMwklT2Uzi/BL1UMC3YOCiR2FDLDy2gx/qPXlzg7TRq4njAf2K+fV6q
 tTeTq0lmRDTQy4MImGiJGE9Vgg7tORSIq9rWJ3AVNcXrOg+C1COTcukQBH5mJN3ZTV7m
 Be/g==
X-Gm-Message-State: AOJu0Yw1rhRICjx4YsCxhiFcFW2+x0prfcIrdkqLRGwGR77VRJRik+1S
 Q8m0DLWl8tA4ThxSO+9h9BDe4EN5R0NtcKqSJH7IGNcjnKfwzsPNKIj4qP1LAPV1SlgbEWIfzXs
 Pq50Nihs=
X-Gm-Gg: Acq92OH58P3u0x4oMMZsCaQqZXACHBH8zBwroLZDcrXM1rhQUoJ20wYZHbydJR6OaP4
 emUKJHij8fvX++SqVBhdBzilDjHDJtksJ/36NGzZjTU8JN/p+dG2CKOoB+bfxxoHW53njKWy8xN
 qCEEg6+eUm6AKYKazkfxI/bP1kR7m4zG9LnguLhF9jhExf94q0WPVNsJpAD0RQ6E6dlqsSiAhgk
 La7J4FQDLS47BXdxcJ0zT7S+KhPVVajowFyDv10U1+un5wqylwaA/x4izdxzGXwnHHLHzgKcN4o
 HBG3Xa0VBTb5NyK2qEYAMn/HRal52oLSvcfOg7h5FaSp4G3S18prHKgQNlpK07qV62mj1WiVjit
 IZfFI24WZRfNA1y5VaRkKBaOFGUHcfyJooiUG8rjGJjj+ezKd3P9D3Lq7KzMbNoSoIRdyg2fjP4
 sbj0fs8fj9HosApUI2v9kaR6Q3P8mZbneGPWUlAsknsmGM
X-Received: by 2002:a05:600c:470e:b0:48e:8741:fd3d with SMTP id
 5b1f17b1804b1-48fe60ea21dmr58723745e9.14.1778857585843; 
 Fri, 15 May 2026 08:06:25 -0700 (PDT)
Received: from alexanderarchlinux ([188.111.3.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab290e1sm29444715e9.2.2026.05.15.08.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:06:25 -0700 (PDT)
From: Alexander Hansen <alexander.hansen@9elements.com>
To: qemu-devel@nongnu.org
Cc: Alexander Hansen <alexander.hansen@9elements.com>,
 Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: [PATCH v4 2/5] ast2600: yosemite4 functional test
Date: Fri, 15 May 2026 16:57:59 +0200
Message-ID: <20260515150610.381066-3-alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515150610.381066-1-alexander.hansen@9elements.com>
References: <20260515150610.381066-1-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alexander.hansen@9elements.com; helo=mail-wr1-x42b.google.com
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

Add a functional test for the Yosemite V4 (fby4-bmc) machine
that validates:
- U-Boot initialization and kernel boot sequence

The test uses an OpenBMC image built for the yosemite4 board and
validates console output through the boot process.

Cc: Titus Rwantare <titusr@google.com>
Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
Cc: qemu-devel@nongnu.org (open list:All patches CC here)
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 tests/functional/arm/meson.build         |  2 ++
 tests/functional/arm/test_aspeed_fby4.py | 44 ++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100755 tests/functional/arm/test_aspeed_fby4.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 2f538f29a2..10c0006f22 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -14,6 +14,7 @@ test_arm_timeouts = {
   'aspeed_ast2600_sdk_otp' : 720,
   'aspeed_bletchley' : 480,
   'aspeed_catalina' : 480,
+  'aspeed_fby4': 480,
   'aspeed_gb200nvl_bmc' : 480,
   'aspeed_rainier' : 480,
   'bpim2u' : 500,
@@ -47,6 +48,7 @@ tests_arm_system_thorough = [
   'aspeed_ast2600_sdk_otp',
   'aspeed_bletchley',
   'aspeed_catalina',
+  'aspeed_fby4',
   'aspeed_gb200nvl_bmc',
   'aspeed_rainier',
   'bpim2u',
diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
new file mode 100755
index 0000000000..a3124c240f
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_fby4.py
@@ -0,0 +1,44 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class YosemiteV4Machine(AspeedTest):
+
+    ASSET_YOSEMITE_V4_FLASH = Asset(
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/yosemite4-bmc/openbmc-20260505132843/obmc-phosphor-image-yosemite4-20260505132843.static.mtd.xz',
+        'dff6946363b41f952b15cfc3156482b89fcfc1b0ecfc3ec8b3ed496a5f001ef9')
+
+    def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
+                                   cpu_id, soc):
+
+        self.set_machine(machine)
+        self.vm.set_console()
+        self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
+                         '-snapshot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern(f'U-Boot {uboot}')
+        self.wait_for_console_pattern('## Loading kernel from FIT Image')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
+        self.wait_for_console_pattern(f'ASPEED {soc}')
+        self.wait_for_console_pattern('/init as init process')
+        # yosemite v4 does not emit the hostname log which is
+        # different from the other machines.
+        self.wait_for_console_pattern('yosemite4 login:')
+
+    def test_arm_ast2600_yosemitev4_openbmc(self):
+        image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
+
+        self.do_test_arm_aspeed_openbmc_no_network('fby4-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3')
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.54.0


