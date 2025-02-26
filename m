Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E188AC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEBa-0004MM-84; Wed, 26 Feb 2025 04:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEBN-0003xP-Gi
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEBL-0008An-IE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiAdPKaRegoPhirESYIdsNfptwm2HXlEoiWpf5Rhsq8=;
 b=YYZ9R+kSbeYYkC/e11vA7RFUDGmtXa1QY+V+9CisnXSuqjYL7fPKO1n4Y5wW4h4wk8cPOS
 GOT/or+wxchgb+8GAaW/6L71A6K9p2tJzmELVVANojb4DX/7l3jG9oAsI8qZgxP7eE8yL/
 av3xOWKy6xyWUltHOwASgkPeuymA1PY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-2PE15d_HNCGnLdrCtV5m8g-1; Wed,
 26 Feb 2025 04:58:20 -0500
X-MC-Unique: 2PE15d_HNCGnLdrCtV5m8g-1
X-Mimecast-MFC-AGG-ID: 2PE15d_HNCGnLdrCtV5m8g_1740563899
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53C5D1800360
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:58:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 082811800965; Wed, 26 Feb 2025 09:58:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/18] tests/functional: Replace the ppc64 e500 advent calendar
 test
Date: Wed, 26 Feb 2025 10:57:31 +0100
Message-ID: <20250226095731.1172375-19-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Replace the advent calendar test with a buildroot image built with
qemu_ppc64_e5500_defconfig. Unlike the advent calendar image, this
newer buildroot image supports networking, too. Thus boot a ppce500
machine from kernel and disk, test network and poweroff.
Add '-no-shutdown' to the command line to avoid exiting from QEMU
as it seems to bother the functional framework.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250226065013.196052-1-clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Add some wording about network support to the commit message]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_e500.py | 33 +++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
index b92fe0b0e75..9ce7ae6c479 100755
--- a/tests/functional/test_ppc64_e500.py
+++ b/tests/functional/test_ppc64_e500.py
@@ -5,20 +5,39 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
 
 
 class E500Test(LinuxKernelTest):
 
-    ASSET_DAY19 = Asset(
-        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day19.tar.xz',
-        '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
+    ASSET_BR2_E5500_UIMAGE = Asset(
+        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/uImage',
+        '2478187c455d6cca3984e9dfde9c635d824ea16236b85fd6b4809f744706deda')
 
-    def test_ppc64_e500(self):
+    ASSET_BR2_E5500_ROOTFS = Asset(
+        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/rootfs.ext2',
+        '9035ef97237c84c7522baaff17d25cdfca4bb7a053d5e296e902919473423d76')
+
+    def test_ppc64_e500_buildroot(self):
         self.set_machine('ppce500')
         self.cpu = 'e5500'
-        self.archive_extract(self.ASSET_DAY19)
-        self.launch_kernel(self.scratch_file('day19', 'uImage'),
-                           wait_for='QEMU advent calendar')
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
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.48.1


