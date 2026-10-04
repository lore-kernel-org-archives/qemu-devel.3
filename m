Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29A3CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJk-0006Tv-Vr; Sun, 04 Oct 2026 08:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJj-0006SE-4I
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:47 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJg-00077w-Ts
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:46 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so6079875e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116863; x=1791721663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7885PgXNL6lhtxxU6fuNxrSx+w9QI495pm3jx+KXf1s=;
 b=hdjNd9QMdllJCCrMaOD2TtAS0Vg5WLF69B/9e21Cx/0VdQzO5gAatB1bL1jDrVjWHu
 oLwimbokYVxOIzCfZkx1KUvf+vF2aZZ4c+w08RmAdt/ij3rSjrbxLWt4+ALpUQbTj6WS
 Stfy68L0RYy1r9EfHQVdL+834Mm76MZWcBihjawm0UHleHcJazMxLu0pXxlvy10dx0Py
 yNljCwsZiyKUw+xVPFI1ZzUUD836KwbxfPpilu/W3LO7tifOuV4PcmboyI8cYkYfcg6l
 PdpYhQLcNRngon7tsnT60PA1TY2QvzTBEMEmIV8jn3kIEfOaEn6zEkKSdqxnjIsRryxG
 wPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116863; x=1791721663;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7885PgXNL6lhtxxU6fuNxrSx+w9QI495pm3jx+KXf1s=;
 b=iUfMooYiNWmkKi5LmEg6ZSCOzyQjcR1yJSEf6MyL+41pXtCPzTXqi6rXX9e2FlGU6b
 dVd0cLz8AjchG8oZkWcpVINAv7P2jtgo+St0f5AuoUC7/8Lrl+9jabgjrB21SEO+b+sg
 nqWxKKmWiIJhg46A/ELdv72DDWz5gKAq1iDs7exHpY1pIXJuAjyuhYUDE/9osqWo/gDs
 vU2559UuML/yP6fRXP13VRDmJRhr3KS7TNqLZsa8nIgApBwKWzqwTwP++clsMS2x/ekR
 xP/PY64xaiTKgHT0o7nXFA9Jzm7FZgUxZdOXx4E5WNaG0s6Y2DA27ygHowfvBDZYArri
 JRfA==
X-Gm-Message-State: AFuF++mP7m28epSfFHq+u2T28xoCHfiDTf3UimpTKHddl2gnkjSauexI
 x+bmSNf441XU0gNTcRRqA/8UnJGTGjy7/zp7e195aEdgDtEXq7/lsGP2JoCZHA==
X-Gm-Gg: AYBFou2umcxeX9M2PksxPwS+SsZcgPC9rdUzOvJhjaxwy3TkAZiwyQB/+1QIUluulXG
 aJoRXPtdxZz01ZCY45lRRDw2TGVAQn6ImJmEgai8ErKzdmOANEMtGZ2dE8HPxfGSjwog39DnEdO
 dzedBsl4Hwy7M08FZCK0yYXnjt/GQBFBuBWcwI7ZS2vF9ly9BXuxN8vASN1UfRXWJEa1MPJMBXa
 KGhlpAcmqj3/zvHVtzjRIRTHbYlBqgU7Sy8BSh1Rxtur7z/8PUYdUpG5L0Qmn3LpUJkeTIzxG9q
 mN6nUnh5nT0WzvsIVw+G/3pJuozao/t2LQwwZRXY4DtzgE89zyR2nfRRH6mzmItyVgkoBP+t4fL
 K6ii4KvDYvhSEhB101RmTAaCJpuFfbGwBPIsYEaiTT3q4CKfoQ9edfRghLt5vVABGljpYw03PGj
 XmAibzcJm2KTraoUUXeo4S1Ubx4Segy139y/C1rFX7z1ZNR4p0ZMpJdraIdZ05YrLxCyKuV2IiD
 bZ5maFLwfPUjhWEgHXktRt97xHGfvoQF3uda6U=
X-Received: by 2002:a05:600c:c116:b0:4a0:eae0:b30e with SMTP id
 5b1f17b1804b1-4a0eae0b82fmr102523655e9.22.1791116863292; 
 Sun, 04 Oct 2026 05:27:43 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 07/30] tests/functional/arm: Add console test for
 `sabrelite` machine
Date: Sun,  4 Oct 2026 14:26:23 +0200
Message-ID: <20261004122647.3913-8-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                            |  1 +
 tests/functional/arm/meson.build       |  1 +
 tests/functional/arm/test_sabrelite.py | 46 ++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100755 tests/functional/arm/test_sabrelite.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..f31245716a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1054,6 +1054,7 @@ F: include/hw/usb/imx-usb-phy.h
 F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
+F: tests/functional/arm/test_sabrelite.py
 
 SBSA-REF
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..761b371a8d 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -24,6 +24,7 @@ test_arm_timeouts = {
   'quanta_gsj' : 240,
   'raspi2' : 120,
   'replay' : 240,
+  'sabrelite' : 240,
   'tuxrun' : 240,
   'sx1' : 360,
 }
diff --git a/tests/functional/arm/test_sabrelite.py b/tests/functional/arm/test_sabrelite.py
new file mode 100755
index 0000000000..31a0a49eac
--- /dev/null
+++ b/tests/functional/arm/test_sabrelite.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+
+class SabreliteMachine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/vmlinuz'),
+        '5851e9c61465a26db810796db671c4729e66e81c365b3ebb1a4b7f772737605b')
+
+    ASSET_INITRD = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/initrd.gz'),
+        'fe33f836232a9107716d34dc56d36dea81bab039243a2a42ea6583a50c9b92ca')
+
+    ASSET_DTB = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/device-tree/imx6q-sabrelite.dtb'),
+        '3ad637c8ea55ebd058a67f686e050b82ccb0d1327bc283623c133c48ad87db44')
+
+    def setUp(self):
+        super().setUp()
+
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.initrd_path = self.ASSET_INITRD.fetch()
+        self.dtb_path = self.ASSET_DTB.fetch()
+
+    def test_console(self):
+        self.require_accelerator("tcg")
+        self.set_machine('sabrelite')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path)
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Starting system log daemon:')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.56.0


