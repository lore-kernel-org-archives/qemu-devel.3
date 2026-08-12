Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526D6C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAP4-0005Hx-7u; Wed, 12 Aug 2026 10:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAO1-0004Iz-8H; Wed, 12 Aug 2026 10:57:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANw-0000gt-8b; Wed, 12 Aug 2026 10:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=VomVhxY0qpKIttSRay7Qzb9XuAHdORaKXklaQ/i3WD0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DAV4PHtvnz5hi7PNvsqrLHM7boAQc/TPvkleKez+BC37htj14oeKyEzEo7qymzs/S
 eL50m2nO5ITYAmKplPQk9zxhbWq5T+3Xq9vRVPJe2+abq9RrIKLixUy+RFOwT/3ds/
 Asrgv6nmrwhC5xggO2Kf5nDGH5j0c42cU3beo5QywqtwvsmF35j6m+gEJISMZ2iirZ
 FzGuFgIqR0MStrV8383xBXS48YG9uQ5FFEMLl978d7kS8apJFxcTFUKZuuORMLgghX
 OgHbPlPbOL7R0mYJpMnJZE17haKpIJOc9d+exL1fC8NXK/dRall0sftxVZFi2+0z6Z
 BBRIMYyWv7KdA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 754611CA642;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D0250409D84;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 39C552F9DF; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Michael S. Tsirkin <mst@redhat.com>
Subject: [Stable-11.0.4 062/120] hw/pci-host/q35.c: Avoid early return in
 mch_write_config()
Date: Wed, 12 Aug 2026 17:48:45 +0300
Message-ID: <20260812144955.649205-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In mch_write_config() we return early if has_smm_ranges is false.
This is slightly bug-prone because it leaves the door open to somebody
later adding non-SMM-specific code at the bottom of the function.

This case isn't as bad as the one in realize, because the function is
a lot shorter.  But putting the handling of the three SMM specific
ranges into an if() rather than having an early return seems better.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260708121011.1653365-4-peter.maydell@linaro.org>
(cherry picked from commit e07c67584c69da44a4d52df747a6fff1f411500d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e44f23c1d9f..0246317cbcf 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -474,22 +474,20 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
-
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
-                       MCH_HOST_BRIDGE_SMRAM_SIZE)) {
-        mch_update_smram(mch);
-    }
+    if (mch->has_smm_ranges) {
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
+                           MCH_HOST_BRIDGE_SMRAM_SIZE)) {
+            mch_update_smram(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
-                       MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
-        mch_update_ext_tseg_mbytes(mch);
-    }
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                           MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
+            mch_update_ext_tseg_mbytes(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
-        mch_update_smbase_smram(mch);
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
+            mch_update_smbase_smram(mch);
+        }
     }
 }
 
-- 
2.47.3


