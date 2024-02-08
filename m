Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552A4C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAbS-0008Ts-3W; Thu, 08 Feb 2024 15:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rYAbP-0008SU-Eu
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:02:31 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rYAbN-0001T8-1y
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1707422543; bh=74QhrVR/63+4QItElafq1F3na7ckc/nS7arttH/g2h8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fhWTAg5cn2LAn0ePLQzEWyW5kP6qpRzQr6ZlQMMUEp/Sd4tk25PENNyLqqlWvzH5z
 QtPDPws8YYCfg2ssLK2Ky2qiEz53NSloh2fh377pGBOzZHbdidaVQgGrhUPRF3BD3j
 TLUho1OcVrVP8gDH4zLQHorozFoFfzwpT4CwCKXE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Thu, 08 Feb 2024 21:02:22 +0100
Subject: [PATCH v6 3/6] tests/qtest/pvpanic: use centralized definition of
 supported events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240208-pvpanic-shutdown-v6-3-965580ac057b@t-8ch.de>
References: <20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de>
In-Reply-To: <20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707422542; l=2303;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=74QhrVR/63+4QItElafq1F3na7ckc/nS7arttH/g2h8=;
 b=VEv8caWCTAMsardqNRpQqQD0XJ0ts4qaifaoxfhlvJZcVrfV51RbePjMzVkIYq8/ap9oytojO
 YDqZYnMHg4xDxBpx8oRlYtkfyc0/9XvtNw928ZhMDRk3QH+Vq6VAymz
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Avoid the necessity to update all tests when new events are added
to the device.

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 tests/qtest/pvpanic-pci-test.c | 5 +++--
 tests/qtest/pvpanic-test.c     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index 2c05b376ba72..b372caf41dc0 100644
--- a/tests/qtest/pvpanic-pci-test.c
+++ b/tests/qtest/pvpanic-pci-test.c
@@ -16,6 +16,7 @@
 #include "qapi/qmp/qdict.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
+#include "hw/misc/pvpanic.h"
 #include "hw/pci/pci_regs.h"
 
 static void test_panic_nopause(void)
@@ -34,7 +35,7 @@ static void test_panic_nopause(void)
     bar = qpci_iomap(dev, 0, NULL);
 
     qpci_memread(dev, bar, 0, &val, sizeof(val));
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     val = 1;
     qpci_memwrite(dev, bar, 0, &val, sizeof(val));
@@ -67,7 +68,7 @@ static void test_panic(void)
     bar = qpci_iomap(dev, 0, NULL);
 
     qpci_memread(dev, bar, 0, &val, sizeof(val));
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     val = 1;
     qpci_memwrite(dev, bar, 0, &val, sizeof(val));
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index 78f1cf8186b0..ccc603472f5d 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
+#include "hw/misc/pvpanic.h"
 
 static void test_panic_nopause(void)
 {
@@ -20,7 +21,7 @@ static void test_panic_nopause(void)
     qts = qtest_init("-device pvpanic -action panic=none");
 
     val = qtest_inb(qts, 0x505);
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     qtest_outb(qts, 0x505, 0x1);
 
@@ -43,7 +44,7 @@ static void test_panic(void)
     qts = qtest_init("-device pvpanic -action panic=pause");
 
     val = qtest_inb(qts, 0x505);
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     qtest_outb(qts, 0x505, 0x1);
 

-- 
2.43.0


