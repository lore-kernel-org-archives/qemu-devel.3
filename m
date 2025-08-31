Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3FDCA0FF2
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 13:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usiW7-0001Ea-PL; Sun, 31 Aug 2025 09:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim@guixotic.coop>)
 id 1ushYr-0007CL-6d
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 08:53:33 -0400
Received: from mailtransmit05.runbox.com ([2a0c:5a00:149::26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim@guixotic.coop>)
 id 1ushYf-0007nu-Kz
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 08:53:25 -0400
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <maxim@guixotic.coop>)
 id 1ushYX-002VxF-BL; Sun, 31 Aug 2025 14:53:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From;
 bh=dWZ2oPkGh/4u0vMN2ckIu5AvknPfjebCqx+qYvpdFj4=; b=L0Mal7/7U7nAxSPb06aCyBj2aD
 FE9p4Fwfnu9Q6gTE4Y7dJvZlfu+hOM/nM6XKtynlkdXyohs/wPtLOJVB0Lp2EiyAFfaZsy6lOcCtw
 7/FFo02Pxu71OxeNrdQXzTr7CEkzeTI47kggFaTfTPKQSAZ/y2DTz7Fp2SFNXScJDUNMgR2jsKKOE
 xuidIcjqeHNGwD3opJ5AhkO/B42HktOmIptDQ5OGG7D9RtiPpGL0AIdpOtIu0Z2tq3EjIPPeOzOHf
 kJ4hgp7pKcO6mkBiD/mYWUjMSUXQ7+/XPMruOx3CJfk9x9hPHVuEPFgO+iAq9A3s5IjuF01z90V9r
 HYx/xP8Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
 by mailtransmit02.runbox with esmtp (Exim 4.86_2)
 (envelope-from <maxim@guixotic.coop>)
 id 1ushYW-0007Rv-JP; Sun, 31 Aug 2025 14:53:12 +0200
Received: by submission03.runbox with esmtpsa [Authenticated ID (1476852)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.93) id 1ushYO-005AKS-Q5; Sun, 31 Aug 2025 14:53:05 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH] tests: honor $TMPDIR for test_virtio_version
Date: Sun, 31 Aug 2025 21:52:55 +0900
Message-ID: <20250831125255.7066-1-maxim@guixotic.coop>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a0c:5a00:149::26;
 envelope-from=maxim@guixotic.coop; helo=mailtransmit05.runbox.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Aug 2025 09:54:46 -0400
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

Until 10.1.0, the test suite could be run without having a writable
/var/tmp in the build environment.  To avoid now requiring /var/tmp in
the build environment (which can be a very minimal container like in
the case of GNU Guix), consult TMPDIR first, using /var/tmp as a
fallback.

Signed-off-by: Maxim Cournoyer <maxim@guixotic.coop>
---
 tests/functional/x86_64/test_virtio_version.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/test_virtio_version.py b/tests/functional/x86_64/test_virtio_version.py
index a5ea73237f..501545f655 100755
--- a/tests/functional/x86_64/test_virtio_version.py
+++ b/tests/functional/x86_64/test_virtio_version.py
@@ -10,6 +10,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
+
 from qemu.machine import QEMUMachine
 from qemu_test import QemuSystemTest
 
@@ -68,7 +70,9 @@ def run_device(self, devtype, opts=None, machine='pc'):
         """
         Run QEMU with `-device DEVTYPE`, return device info from `query-pci`
         """
-        with QEMUMachine(self.qemu_bin) as vm:
+        with QEMUMachine(
+                self.qemu_bin,
+                base_temp_dir=os.environ.get('TMPDIR', '/var/tmp')) as vm:
             vm.set_machine(machine)
             if opts:
                 devtype += ',' + opts

base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
-- 
2.51.0


