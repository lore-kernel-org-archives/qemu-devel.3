Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2226BC98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fPk-0008H0-RW; Thu, 24 Sep 2026 05:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fPH-0008F1-6m
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fPF-0000kP-K9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790240777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcWcPE7FohJ4oBJ9imAYYpTxgR7PhSPCSzr+yu/w12E=;
 b=WRzXBKCutaoctqN3xYlLZueXk866/wgkLLUKPYOiQyZ6Gx89r7QroHy+YuIEkRhmC+Dy0p
 /JQDMHhXUgYp7x/DXl5CxQ0C4AE/Vy7rdZAz45y+7F6FyrKvRusqkgzQF+XYGmaZqyECk8
 iXQP17ZijxLS2sG/eUtrQz31Sw2w3GA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-dIGYbfO0OtKRm63GY4z49g-1; Thu,
 24 Sep 2026 05:06:13 -0400
X-MC-Unique: dIGYbfO0OtKRm63GY4z49g-1
X-Mimecast-MFC-AGG-ID: dIGYbfO0OtKRm63GY4z49g_1790240772
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 551C9195420D; Thu, 24 Sep 2026 09:06:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3190195604C; Thu, 24 Sep 2026 09:06:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@intel.com>
Subject: [PULL 7/7] tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch
Date: Thu, 24 Sep 2026 11:05:58 +0200
Message-ID: <20260924090558.801845-8-thuth@redhat.com>
In-Reply-To: <20260924090558.801845-1-thuth@redhat.com>
References: <20260924090558.801845-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

Configure the interrupt IN endpoint of usb-kbd as Isoch IN and queue one
TD. The TD is deferred by a microframe, the kick timer retries it,
usb-kbd NAKs, and a second doorbell retries it again. The TD has to stay
pending both times and the controller has to keep running.

Without the fix QEMU aborts in the timer retry. The endpoint setup is
taken from the reproducer attached to #3886.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Message-ID: <c1166d1b83db5a507035d6fc27b1b552d4a95b0e.1789968699.git.junjie.cao@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 61eca37b157..2e173af7506 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -33,6 +33,7 @@
 #define USBCMD_RS               (1 << 0)
 #define USBCMD_HCRST            (1 << 1)
 #define USBSTS_HCH              (1 << 0)
+#define USBSTS_HCE              (1 << 12)
 #define PORTSC_CCS              (1 << 0)
 #define PORTSC_PR               (1 << 4)
 #define PORTSC_PP               (1 << 9)
@@ -57,6 +58,7 @@
 
 #define EP_TYPE_ISOCH_OUT       1
 #define EP_TYPE_CONTROL         4
+#define EP_TYPE_ISOCH_IN        5
 
 #define XHCI_RING_TRBS          64
 #define XHCI_MICROFRAME_NS      125000
@@ -390,6 +392,37 @@ static void test_xhci_isoch_mfindex_32bit(void)
     xhci_test_end(&x);
 }
 
+/*
+ * The endpoint type in the endpoint context is whatever the guest says. Tell
+ * the controller that the interrupt endpoint of usb-kbd is isoch. The idle
+ * keyboard NAKs, and the TD has to stay pending when first the kick timer and
+ * then a doorbell retry it.
+ */
+static void test_xhci_isoch_ep_type_mismatch(void)
+{
+    uint64_t ring;
+    XHCITest x;
+
+    if (!xhci_test_supported("usb-kbd")) {
+        return;
+    }
+
+    xhci_test_start(&x, "-device usb-kbd");
+    ring = xhci_configure_ep(&x, 3, EP_TYPE_ISOCH_IN, 0, 8);
+
+    xhci_write_trb(&x, ring, xhci_alloc_page(&x), 8,
+                   TRB_TYPE(TR_ISOCH) | TRB_TR_SIA | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+    qtest_clock_step(x.qts, 2 * XHCI_MICROFRAME_NS);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+    g_assert_cmphex(xhci_readl(&x, x.oper + XHCI_USBSTS) &
+                    (USBSTS_HCH | USBSTS_HCE), ==, 0);
+
+    xhci_test_end(&x);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -406,6 +439,8 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/xhci/pci/isoch/mfindex-32bit",
                    test_xhci_isoch_mfindex_32bit);
+    qtest_add_func("/xhci/pci/isoch/ep-type-mismatch",
+                   test_xhci_isoch_ep_type_mismatch);
 
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,"
-- 
2.55.0


