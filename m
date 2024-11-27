Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BECD609CE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGFOv-0006Ac-AU; Wed, 27 Nov 2024 05:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFOu-0006A6-9q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFOs-0001D2-Ij
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732703761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zNdxrb4f+HDgq2AGchAcDvoIDaLfr/gxCTxBiYFIZ0=;
 b=hfrGXUmJD94ceSOkeu/bqQXqJ4Z+Ou/O21gd6ACXvsN0HCn67GfCjJ90SNu8H6amPa5O9Q
 R8T2R+Y0UaoiXnAj4/kpumX2HtGv8m38xj5sXOzlYZseMJ5SX0jHcXfXLf4Oo0wh4MWRaX
 qjZN23lenPMUZTGr2NjDfu8JeTS19QY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-6hZ6qhd7NWK0duDhaNR4kg-1; Wed,
 27 Nov 2024 05:34:35 -0500
X-MC-Unique: 6hZ6qhd7NWK0duDhaNR4kg-1
X-Mimecast-MFC-AGG-ID: 6hZ6qhd7NWK0duDhaNR4kg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BDC219541AE; Wed, 27 Nov 2024 10:34:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 966B01955F3C; Wed, 27 Nov 2024 10:34:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 3/7] tests/functional: Fix the running test case causes
 loongarch64 to hang
Date: Wed, 27 Nov 2024 11:34:21 +0100
Message-ID: <20241127103425.378289-4-thuth@redhat.com>
In-Reply-To: <20241127103425.378289-1-thuth@redhat.com>
References: <20241127103425.378289-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

From: Xianglai Li <lixianglai@loongson.cn>

There is a bug in the process of resolving the serial port base address
in the fdt of the loongarch VM UEFI. When both serial port information
and rng-seed information are chosen in the fdt, there is a probability
that the serial port base address cannot be resolved correctly.
This problem can be fixed by updating UEFI.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2686
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Message-ID: <20241127013438.2206426-1-lixianglai@loongson.cn>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_loongarch64_virt.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/test_loongarch64_virt.py
index 2b8baa2c2a..b7d9abf933 100755
--- a/tests/functional/test_loongarch64_virt.py
+++ b/tests/functional/test_loongarch64_virt.py
@@ -18,16 +18,16 @@ class LoongArchMachine(QemuSystemTest):
 
     ASSET_KERNEL = Asset(
         ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-         'releases/download/2024-05-30/vmlinuz.efi'),
+         'releases/download/2024-11-26/vmlinuz.efi'),
         '08b88a45f48a5fd92260bae895be4e5175be2397481a6f7821b9f39b2965b79e')
     ASSET_INITRD = Asset(
         ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-         'releases/download/2024-05-30/ramdisk'),
+         'releases/download/2024-11-26/ramdisk'),
         '03d6fb6f8ee64ecac961120a0bdacf741f17b3bee2141f17fa01908c8baf176a')
     ASSET_BIOS = Asset(
         ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-         'releases/download/2024-05-30/QEMU_EFI.fd'),
-        '937c1e7815e2340150c194a9f8f0474259038a3d7b8845ed62cc08163c46bea1')
+         'releases/download/2024-11-26/QEMU_EFI.fd'),
+        'f55fbf5d92e885844631ae9bfa8887f659bbb4f6ef2beea9e9ff8bc0603b6697')
 
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(self, success_message,
-- 
2.47.0


