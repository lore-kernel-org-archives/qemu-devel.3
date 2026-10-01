Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67317CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPmP-0004PM-Ib; Thu, 01 Oct 2026 19:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmF-0004O6-Uu; Thu, 01 Oct 2026 19:01:25 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmD-0007jX-8l; Thu, 01 Oct 2026 19:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=c/yI1a/
 b+A+eA/Srk7Leuzs3Whw+U+hvJrCn5XmNosR3lTLhK4zERfowG69HPdyM+rt2Ydk8sgRL3
 w1KbqritYEZ8o/0UA9VyZ+Ydcc7gxZ0miUnMaIWbAP6A7FyEo6Rv0TGgwkxhAQNBP+Pvx4
 gx1O+f2tbxzFahyT3zDxAYsyojIhoDUvTEwNfX3l6eezeJCwIjhnAOp4aKrgnYkHXR2bn0
 AU5cHd9KNkKSvv0/Ta4LmeEyf1RZpMIncloTABSbv6MIV3Ki5Fu/ZAkeVsGkbu7hb5x/xQ
 xTygJ90k9dpt6aMP14LTHByZWHXn4cD0JN5YT8DqJKuynT9yQArIY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=g
 kKTvn9s/lYw1zAlj9kSBjShEkdgZBP1EPjl78qjmB8=;
 h=references:in-reply-to:
 date:subject:to:from:dkim-signature:dkim-signature; d=mx.catap.net; b=
 G4Sznj45LK7vM+49q7P5jIE9uGHfv+sE2F1vGCXC4pcf/H/fBFVj0qZPPEAN1kemSLXcy8
 bJ22TZir6BU4wNR4efd4NTzOtFPMCVwYEB2b1lUrAS9yylzW+0n9k9HfE8rY6R46JY8NiD
 34Y53g/ZkI4HBrvmW/jM4V5LV8Hgokhj9TpoiLUFUOFFWIB5oJPYoSKxfTenBIUrNNEDAV
 eAgUCWTgQeLN8fO5xhP7xCIlbukolSKKsZI4RxJefkNk4FWDep5krv+yyMWR9BoMPOGiLg
 ktTM/xrYbh7DdWUAQa3gF6SDJ0zYex7ctj8g/XH4btr+NPFTNgD6XHiPDjtWqw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=QJueQkSN; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=iZ1OWUra;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=gkKTvn9s
 /lYw1zAlj9kSBjShEkdgZBP1EPjl78qjmB8=;
 h=references:in-reply-to:date:
 subject:to:from; d=korins.ky; b=QJueQkSNHVp4mgQbLERMqfKlxWaMJOQNSHRY0c
 RMBH9YCytCOjpbXVWi5xdO2yRfveacp2eFaSLPeEX3m8cHiHEhvySso8g859aESuk5ZFj0
 TDhUcLDQlgI5t5p77oyon0629ZEhZ14dhEaqbLRh6a0L8IM1q8ekbHJ0fSbrHT3CshuLX6
 KWn4zDosE1z1rL1lr2wOWhxJQZhee4cwh8Yxhg91Y0hD7QrkMBWLFVth6x3roX6Z20pHXU
 Si8R+4QUs5bbTazYMCCv24KharEHzsIV1zl+iAmqV11b0t6J0oIh0PqE5qFWzHeOdL86K4
 UAqV2+s8st3VEFpGC4khdAdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=gkKTvn9s/lYw1zAlj9kSBjShEkdgZBP1EPjl78qjmB8=; h=references:
 in-reply-to:date:subject:to:from; d=korins.ky; b=iZ1OWUra6ZRocLJWEmQgI
 wl47Y6iOQ3j9/nsCeSd7AKTdKOJZG0+h4KrCaqv4mkj37kxLJevuDKLbCCS211rBg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id b4cc36f4
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 2 Oct 2026 01:01:11 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 6bbfeb61;
 Fri, 2 Oct 2026 01:01:07 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
Subject: [PATCH v3 5/5] tests/functional: Boot OpenBSD on mac99
Date: Fri,  2 Oct 2026 00:59:04 +0200
Message-ID: <20261001230058.11465-6-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001230058.11465-1-kirill@korins.ky>
References: <20261001230058.11465-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

OpenBSD device discovery exercises CTPR masking, zero decrementer
writes, and CUDA reply timing and layout; regressions in any of these
paths stall the guest before the installer starts.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 tests/functional/ppc/meson.build     |  2 ++
 tests/functional/ppc/test_openbsd.py | 46 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/functional/ppc/test_openbsd.py

diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meson.build
index ae061fe5a6..1055cdaa17 100644
--- a/tests/functional/ppc/meson.build
+++ b/tests/functional/ppc/meson.build
@@ -2,6 +2,7 @@
 
 test_ppc_timeouts = {
   '40p' : 240,
+  'openbsd' : 240,
 }
 
 tests_ppc_system_quick = [
@@ -15,6 +16,7 @@ tests_ppc_system_thorough = [
   'bamboo',
   'mac',
   'mpc8544ds',
+  'openbsd',
   'ppe42',
   'replay',
   'sam460ex',
diff --git a/tests/functional/ppc/test_openbsd.py b/tests/functional/ppc/test_openbsd.py
new file mode 100755
index 0000000000..73fa328b1f
--- /dev/null
+++ b/tests/functional/ppc/test_openbsd.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Test that OpenBSD boots on mac99 and reaches the installer.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class OpenBSDMac99(QemuSystemTest):
+
+    ASSET_CD = Asset(
+        'https://ftp.eu.openbsd.org/pub/OpenBSD/7.9/macppc/cd79.iso',
+        '227fef3d5089d56ce8376d8bfa28181ce5b19f0eceef0a6d82d58d8e52832b24')
+
+    def test_openbsd_79_installer(self):
+        self.set_machine('mac99')
+        self.require_accelerator('tcg')
+        cdrom_path = self.ASSET_CD.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-M', 'via=cuda,graphics=off,usb=off',
+                         '-cpu', '7400',
+                         '-accel', 'tcg,thread=single',
+                         '-smp', '1',
+                         '-m', '2g',
+                         '-nic', 'none',
+                         '-device', 'VGA',
+                         '-global', 'cuda.x-sr-delay-ns=0',
+                         '-prom-env', 'input-device=ttya',
+                         '-prom-env', 'output-device=ttya',
+                         '-cdrom', cdrom_path,
+                         '-boot', 'd',
+                         '-no-reboot')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
+        wait_for_console_pattern(
+            self,
+            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
+            'panic:')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.55.0


