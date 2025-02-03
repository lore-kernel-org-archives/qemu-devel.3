Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49518C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 09:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetDv-0001x3-MU; Mon, 03 Feb 2025 04:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tetDR-0001rb-Au
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tetDP-0004Rs-Nz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738576681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rH8n0TFth9XFgWuQj+K/0kRI4UZNZzY0wtPxFR9Y4R0=;
 b=ZfimdKUsak7ZDRt5ybidaPloti+K+86TSefXUGYWh2AXcDfYdPOdU/LR+TNaUbmCUFRA+n
 9xDOX+pb1RalgodSXw7hjI6s5538yzlwb7q5XkT84Gpd5Yx0kBgPL+z1MipQQQ4JfH/SwP
 MyOJ5Ep86HEfYoWDMkMRbfmabJAGFbA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-kz7WZhq7OhC0Zy-xsoaucw-1; Mon,
 03 Feb 2025 04:57:58 -0500
X-MC-Unique: kz7WZhq7OhC0Zy-xsoaucw-1
X-Mimecast-MFC-AGG-ID: kz7WZhq7OhC0Zy-xsoaucw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00EFA19560B0; Mon,  3 Feb 2025 09:57:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46851180099C; Mon,  3 Feb 2025 09:57:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] tests/functional: Extend the ppc64 e500 test
Date: Mon,  3 Feb 2025 10:57:52 +0100
Message-ID: <20250203095752.506043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The test sequence boots a ppce500 machine from kernel and disk.

The buildroot is built with the qemu_ppc64_e5500_defconfig config.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_ppc64_e500.py | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
index b92fe0b0e75e..f21d7d84177e 100755
--- a/tests/functional/test_ppc64_e500.py
+++ b/tests/functional/test_ppc64_e500.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
 
 
 class E500Test(LinuxKernelTest):
@@ -20,5 +21,34 @@ def test_ppc64_e500(self):
         self.launch_kernel(self.scratch_file('day19', 'uImage'),
                            wait_for='QEMU advent calendar')
 
+    ASSET_BR2_E5500_UIMAGE = Asset(
+        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/uImage',
+        '2478187c455d6cca3984e9dfde9c635d824ea16236b85fd6b4809f744706deda')
+
+    ASSET_BR2_E5500_ROOTFS = Asset(
+        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/rootfs.ext2',
+        '9035ef97237c84c7522baaff17d25cdfca4bb7a053d5e296e902919473423d76')
+
+    def test_ppc64_e500_buildroot(self):
+        self.set_machine('ppce500')
+        self.cpu = 'e5500'
+
+        uimage_path = self.ASSET_BR2_E5500_UIMAGE.fetch()
+        rootfs_path = self.ASSET_BR2_E5500_ROOTFS.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', uimage_path,
+                         '-append', 'root=/dev/vda',
+                         '-drive', f'file={rootfs_path},if=virtio,format=raw',
+                         '-snapshot', '-no-shutdown')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('/init as init process')
+        self.wait_for_console_pattern('lease of 10.0.2.15')
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self, 'poweroff', 'Power down')
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.48.1


