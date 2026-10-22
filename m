Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905860A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UDNUshqD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt8H-0007Vx-0B; Thu, 22 Oct 2026 09:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt88-0007BC-DY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:56 -0400
Received: from out-80.mta1.migadu.com ([2001:41d0:203:375::50]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt84-00051M-GQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:51 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=foNUTvbYV4lQzEDVrKpt82n6K34iOpXNfb2C5yBo9mI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676806; v=1; x=1793281606;
 b=UDNUshqDMD3BiumD17SckyQwRzoutAB9Ix30Z0eUu7zpxEcRMfqYeNDijmF3nOHfaPh/pMQh
 3hh6vIo+WaXHX+z7rL9s25Oq+24+SrxEpud57uN+DnmJ+mZmhkmCio8RmFSer4C/4fZkBGkBCx+
 UlbcdVZDcRtSPUEfzGOmSDB0=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id b9410c2015f47dc8;
 Thu, 22 Oct 2026 13:46:46 +0000
X-Mizu-Trace-ID: b9410c2015f47dc8
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 6/7] tests/qtest/usb-hcd-uhci: Test a successful
 isochronous transfer
Date: Thu, 22 Oct 2026 13:46:00 +0000
Message-ID: <20261022134601.1207204-7-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134601.1207204-1-junjie.cao@linux.dev>
References: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::50;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

The isochronous NAK test exercises a TD sent to an interrupt endpoint.
Add a successful transfer to an isochronous endpoint as a positive
case for changes to endpoint type checks.

Configure a USB audio device and enable its streaming interface
through EP0 before submitting an OUT packet. Check that the TD
completes without errors and reports the full packet length.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-uhci-test.c | 74 +++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/usb-hcd-uhci-test.c b/tests/qtest/usb-hcd-uhci-test.c
index bad279e9a2..28d38bcc7c 100644
--- a/tests/qtest/usb-hcd-uhci-test.c
+++ b/tests/qtest/usb-hcd-uhci-test.c
@@ -21,6 +21,7 @@ static QOSState *qs;
 #define UHCI_FRAME_NS 1000000
 #define UHCI_PID_SETUP 0x2d
 #define UHCI_PID_IN    0x69
+#define UHCI_PID_OUT   0xe1
 #define UHCI_LINK_END  1
 #define UHCI_LINK_QH   2
 
@@ -109,17 +110,27 @@ static void uhci_expect_complete(UHCITransferTest *t, unsigned int len)
     uhci_writew(t, UHCI_USBCMD, 0);
 }
 
-static void uhci_transfer_init(UHCITransferTest *t)
+static void uhci_control_no_data(UHCITransferTest *t,
+                                 const uint8_t setup[8])
+{
+    qtest_memwrite(t->qs->qts, t->data, setup, 8);
+    uhci_submit(t, UHCI_PID_SETUP, 0, 8, false, false);
+    uhci_expect_complete(t, 8);
+    uhci_submit(t, UHCI_PID_IN, 0, 0, true, false);
+    uhci_expect_complete(t, 0);
+}
+
+static void uhci_transfer_init(UHCITransferTest *t, const char *usb_device)
 {
     const char *cmd = "-nodefaults -global pci-host-bridge.bypass-iommu=on "
-                      "-device piix3-usb-uhci,id=uhci,addr=1d.0 "
-                      "-device usb-kbd,bus=uhci.0,port=1";
+                      "-device piix3-usb-uhci,id=uhci,addr=1d.0";
     const uint8_t setup[] = { 0, 9, 1, 0, 0, 0, 0, 0 };
 
     if (!strcmp(qtest_get_arch(), "ppc64")) {
-        t->qs = qtest_spapr_boot("%s", cmd);
+        t->qs = qtest_spapr_boot("%s %s", cmd, usb_device);
     } else {
-        t->qs = qtest_pc_boot("-machine pc,pit=off %s", cmd);
+        t->qs = qtest_pc_boot("-machine pc,pit=off %s %s", cmd,
+                              usb_device);
     }
     qusb_pci_init_one(t->qs->pcibus, &t->hc, QPCI_DEVFN(0x1d, 0), 4);
     t->mem = guest_alloc(&t->qs->alloc, 0x3000);
@@ -136,12 +147,8 @@ static void uhci_transfer_init(UHCITransferTest *t)
                     UHCI_PORT_CCS | UHCI_PORT_EN);
     qpci_io_writel(t->hc.dev, t->hc.bar, UHCI_USBFLBASEADD, t->mem);
 
-    /* Configure the keyboard's interrupt endpoint through EP0 first. */
-    qtest_memwrite(t->qs->qts, t->data, setup, sizeof(setup));
-    uhci_submit(t, UHCI_PID_SETUP, 0, sizeof(setup), false, false);
-    uhci_expect_complete(t, sizeof(setup));
-    uhci_submit(t, UHCI_PID_IN, 0, 0, true, false);
-    uhci_expect_complete(t, 0);
+    /* Configure the device through EP0 before using a non-default endpoint. */
+    uhci_control_no_data(t, setup);
 }
 
 static void test_uhci_nak(gconstpointer opaque)
@@ -153,7 +160,7 @@ static void test_uhci_nak(gconstpointer opaque)
     uint32_t ctrl;
     unsigned int i;
 
-    uhci_transfer_init(&t);
+    uhci_transfer_init(&t, "-device usb-kbd,bus=uhci.0,port=1");
     qtest_memset(t.qs->qts, t.data, 0xa5, sizeof(report));
     uhci_submit(&t, UHCI_PID_IN, 1, sizeof(report), false, iso);
     for (i = 0; i < 3; i++) {
@@ -190,6 +197,48 @@ static void test_uhci_nak(gconstpointer opaque)
     qtest_shutdown(t.qs);
 }
 
+static void test_uhci_iso_audio_out(void)
+{
+    const uint8_t set_interface[] = { 1, 11, 1, 0, 1, 0, 0, 0 };
+    const unsigned int packet_size = 192;
+    UHCITransferTest t;
+    uint32_t ctrl;
+    unsigned int i;
+
+    if (!qtest_has_device("usb-audio")) {
+        g_test_skip("usb-audio is not available");
+        return;
+    }
+
+    uhci_transfer_init(&t, "-audiodev none,id=snd0 "
+                           "-device usb-audio,audiodev=snd0,"
+                           "bus=uhci.0,port=1");
+    /* Interface 1, alternate setting 1 enables the stereo OUT endpoint. */
+    uhci_control_no_data(&t, set_interface);
+
+    /* Full-speed audio altsetting 1 advertises OUT endpoint 1, 192 bytes. */
+    qtest_memset(t.qs->qts, t.data, 0x5a, packet_size);
+    uhci_submit(&t, UHCI_PID_OUT, 1, packet_size, false, true);
+    for (i = 0; i < 10; i++) {
+        ctrl = uhci_step(&t);
+        if (!(ctrl & TD_CTRL_ACTIVE)) {
+            break;
+        }
+    }
+    g_assert_cmpuint(i, <, 10);
+    g_assert_cmphex(ctrl & (TD_CTRL_ACTIVE | TD_CTRL_STALL | TD_CTRL_BABBLE |
+                            TD_CTRL_NAK | TD_CTRL_TIMEOUT), ==, 0);
+    g_assert_cmpuint((ctrl + 1) & 0x7ff, ==, packet_size);
+    g_assert_cmphex(qpci_io_readw(t.hc.dev, t.hc.bar, UHCI_USBSTS) &
+                    UHCI_STS_USBINT, ==, UHCI_STS_USBINT);
+    uhci_writew(&t, UHCI_USBCMD, 0);
+
+    qpci_iounmap(t.hc.dev, t.hc.bar);
+    uhci_deinit(&t.hc);
+    guest_free(&t.qs->alloc, t.mem);
+    qtest_shutdown(t.qs);
+}
+
 static void test_port(int port)
 {
     struct qhc uhci;
@@ -251,6 +300,7 @@ int main(int argc, char **argv)
         qtest_add_data_func("/uhci/pci/iso-nak", GUINT_TO_POINTER(true),
                             test_uhci_nak);
     }
+    qtest_add_func("/uhci/pci/iso-audio-out", test_uhci_iso_audio_out);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qs = qtest_pc_boot("%s", cmd);
-- 
2.43.0


