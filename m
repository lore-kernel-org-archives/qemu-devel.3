Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9378ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLA-0003sF-1N; Wed, 07 Oct 2026 04:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJx8-0002Su-LE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:12:45 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJx4-0005oc-Rl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:12:29 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5ba4180a65aso1125182e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791349926; x=1791954726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PgiXUJeOdSQHkFY/lmMpgI1RTVTNH0DvcOAFlKDbgKo=;
 b=X41HFKqx588VMenHK87mPFB0fC8gvw+/8ULezm7JpciQY5cpYQUaYbvhcRaTYiUmnG
 qoYcw8CzYEsxfZjlV4maJlmH4pOydVVSzYftybd0KRM902nVRjuIg1E9+wDiTx/dmj8P
 /bP6tGoVkefewKAnmOw0N9ZaIHknmlqJmOk+tyfBvoeLImwzC/PuVI0Hg+b7+GIDvlk5
 4wM5vnXSMld5Q7184cx2bbuIAiwwRAR7Z+WBhe0yYd31kjyES1F/fBo0C6ONP3m7xnwQ
 9ArmVWbVRuHc6nKjnn7fMYFRVmdpKK0FSygBQ+SsnBi2NIA341DofOEqa6TFlO74jnyW
 m1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349926; x=1791954726;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PgiXUJeOdSQHkFY/lmMpgI1RTVTNH0DvcOAFlKDbgKo=;
 b=03mxSzo2DQ16NR+20aD8Iss8/rtVEwm3+YT0ZS3xh5fWCFu083Qu8ME61lD7HCqtw6
 loVcxlKUklDes0MYqJLMD60lc/u31eTftZCE+w6yiTmpUVccJQOPoOlEIr2a8tVp9hqL
 Ilz3vXROBwqOfyQmC0UrxXpza5oG7WiYf5sNiqWZRCAY7zZnr7XQQsV43U5pQ6Ykdkt/
 URLMzsCMLc+aQ0gk2fbCY61ItdJEuSGMnwuE/3MkkuGVNBtyiKYhs7dNXlHPxOPYj5IA
 YdlggBDrK9G43aXoTJz8dxopLkJPE+kx99dpraZOthYd2gvl14c0pAwvigHfj06aI/8c
 8Clg==
X-Gm-Message-State: AFq9FYLM5rV9HQTSml7HyN+dEKBF+goO8/7S9OeqfJlcod8tBtdHXmlg
 e002mrDscCr/H4SfAAS2kC/NGmaw25ghIo+xyathuRnazefPkOPbM/CYCoJ6eQ==
X-Gm-Gg: AYBFou2pcrzgHFV1Alr70/OxFf5xvlcfWIF9Lw67kRYFw/x282//HxOmJ9rZwTNRvf6
 66tXWGN1bFynnXgENbQU7clvfvg1Ejo9DoLyrdbr4kyje67/OvgkTbdXCo37E4oqz62BoHO5m0I
 fYveV/1l3rUxtFrk9dSyaC2B5TcY/OLVRxdekicOyEQ2kE6xIIabPF102K/8KNeIJPqpkgPjOqa
 kWP25PhthOjG4GQwxbhy9p3sOWZ5ic1z6wzCmjk++nyJzhMTUoFcr6Pl3uxH1494/GSAK98VpnC
 ydSyNOJOfQiI09goqgoXnGdxWNhE7I62NzRqWFnGM5dzUvtE6FS2Nvpco9QLx6NA58GtMZ9ZGAJ
 q82LZw6YpCjMwWxqELV8Y96KIAepvM1ogDtrUYkTCOUB7RRR5kK+zZla5qsGGItLWQyLiQGafUn
 JG2/46hiF87brPC7iWhuKO5zk8GsYHtZF80uQnJoaErV489+n4M88UrzIqE0IsRdgKYPv1PiaDE
 66a2TK/09iMZPebhj/VQO93n2+6nZ9eNuu7QA==
X-Received: by 2002:a05:6000:4b04:b0:486:f6dc:52c8 with SMTP id
 ffacd0b85a97d-48c6d1981ffmr1217522f8f.37.1791275733120; 
 Tue, 06 Oct 2026 01:35:33 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:32 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 11/31] tests/functional/arm: Add console test for
 `mcimx7d-sabre` machine
Date: Tue,  6 Oct 2026 10:34:23 +0200
Message-ID: <20261006083445.30362-12-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The test currently exercises the Linux kernel and waits for the first
daemons to be started. At this point, basic hardware is initialized and
if the log message is reached, no driver ended up in an endless loop,
thus the system should be usable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                                |  1 +
 tests/functional/arm/meson.build           |  2 +
 tests/functional/arm/test_mcimx7d_sabre.py | 46 ++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py

diff --git a/MAINTAINERS b/MAINTAINERS
index f31245716a..a605d65d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -935,6 +935,7 @@ F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 F: docs/system/arm/mcimx7d-sabre.rst
+F: tests/functional/arm/test_mcimx7d_sabre.py
 
 MCIMX8MM-EVK / iMX8MM
 M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 989b841555..e657ecd278 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -20,6 +20,7 @@ test_arm_timeouts = {
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
+  'mcimx7d_sabre' : 240,
   'orangepi' : 540,
   'quanta_gsj' : 240,
   'raspi2' : 120,
@@ -60,6 +61,7 @@ tests_arm_system_thorough = [
   'emcraft_sf2',
   'integratorcp',
   'max78000fthr',
+  'mcimx7d_sabre',
   'microbit',
   'orangepi',
   'quanta_gsj',
diff --git a/tests/functional/arm/test_mcimx7d_sabre.py b/tests/functional/arm/test_mcimx7d_sabre.py
new file mode 100755
index 0000000000..2894b5201f
--- /dev/null
+++ b/tests/functional/arm/test_mcimx7d_sabre.py
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
+class Mcimx7dSabreMachine(LinuxKernelTest):
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
+         '20230607/images/device-tree/imx7d-sdb.dtb'),
+        'eed45fe3ba682cc814217bc4558551d36c034ec7a7692c4eb6eaf86132baf80c')
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
+        self.set_machine('mcimx7d-sabre')
+        self.vm.set_console(console_index=0)
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


