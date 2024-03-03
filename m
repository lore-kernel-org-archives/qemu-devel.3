Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD1C54E4A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 09:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgiDY-0001QK-OP; Sun, 03 Mar 2024 04:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDX-0001Ol-5K; Sun, 03 Mar 2024 04:33:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDV-0006TN-49; Sun, 03 Mar 2024 04:33:10 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0AD4F527CD;
 Sun,  3 Mar 2024 12:33:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 842598E8C9;
 Sun,  3 Mar 2024 12:33:04 +0300 (MSK)
Received: (nullmailer pid 1357007 invoked by uid 1000);
 Sun, 03 Mar 2024 09:33:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 79/82] hw/intc/Kconfig: Fix GIC settings when using
 "--without-default-devices"
Date: Sun,  3 Mar 2024 12:32:57 +0300
Message-Id: <20240303093304.1356981-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240303104213@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240303104213@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When using "--without-default-devices", the ARM_GICV3_TCG and ARM_GIC_KVM
settings currently get disabled, though the arm virt machine is only of
very limited use in that case. This also causes the migration-test to
fail in such builds. Let's make sure that we always keep the GIC switches
enabled in the --without-default-devices builds, too.

Message-ID: <20240221110059.152665-1-thuth@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 8bd3f84d1f6fba0edebc450be6fa2c7630584df9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 97d550b06b..2b5b2d2301 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -12,10 +12,6 @@ config IOAPIC
     bool
     select I8259
 
-config ARM_GIC
-    bool
-    select MSI_NONBROKEN
-
 config OPENPIC
     bool
     select MSI_NONBROKEN
@@ -25,14 +21,18 @@ config APIC
     select MSI_NONBROKEN
     select I8259
 
+config ARM_GIC
+    bool
+    select ARM_GICV3_TCG if TCG
+    select ARM_GIC_KVM if KVM
+    select MSI_NONBROKEN
+
 config ARM_GICV3_TCG
     bool
-    default y
     depends on ARM_GIC && TCG
 
 config ARM_GIC_KVM
     bool
-    default y
     depends on ARM_GIC && KVM
 
 config XICS
-- 
2.39.2


