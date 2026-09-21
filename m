Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8055C982EF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Wro-0000w5-F8; Mon, 21 Sep 2026 01:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8Wre-0000re-4I
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:46:56 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8Wrc-000300-Ft
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789969612; x=1821505612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JuW2CEC7Cmu/PgatyYuctFLm0GjvHfshVNmPDHk2gzQ=;
 b=gVRtN7jvaIUaz+DLEZ83WBBJx+GGpQ4HHs6vF0Jn55ih0F8Fa9/lnovA
 ofYGPvWRDf96w3lpAevEXOwZDCOoRkr22HgtJOmfaUO9hpoYNHUnq23Em
 9buy4sQIqYVt57qD/8HE9/D3S+r0+lLH+ZBO1pSeN1wex+uo91GeXjll+
 k2jl7/BYsjMxr2pwlSPuST8kBebwmA2l3efTwId34X1/V1dtb8UNLL4pQ
 69FqmRjLcYwmakUYNmr46YZiiHUbhdntvxYcYUIVzDXbr+SUovGM7zK4M
 19sO6pH4W0M5bPKIrBC9m56o+2GrSClvMe+JURGIYQ1HbbPOqBxlCvjcH g==;
X-CSE-ConnectionGUID: 3BVL2QxuT1ecpvyVAvGYsQ==
X-CSE-MsgGUID: ApAWKyzRRDSNvp6nopxGoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94287057"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="94287057"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:51 -0700
X-CSE-ConnectionGUID: Hw3xCsrRSg+io6zCuLrIKg==
X-CSE-MsgGUID: TaT83Ye0QfKlqGFMPsSi0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3815219"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:49 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Feifan Qian <bea1e@proton.me>
Subject: [PATCH 4/4] tests/qtest/usb-hcd-xhci: test isoch endpoint type
 mismatch
Date: Mon, 21 Sep 2026 13:46:32 +0800
Message-ID: <c1166d1b83db5a507035d6fc27b1b552d4a95b0e.1789968699.git.junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789968699.git.junjie.cao@intel.com>
References: <cover.1789968699.git.junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Configure the interrupt IN endpoint of usb-kbd as Isoch IN and queue one
TD. The TD is deferred by a microframe, the kick timer retries it,
usb-kbd NAKs, and a second doorbell retries it again. The TD has to stay
pending both times and the controller has to keep running.

Without the fix QEMU aborts in the timer retry. The endpoint setup is
taken from the reproducer attached to #3886.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 61eca37b15..2e173af750 100644
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
2.43.0


