Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01774606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FczoZ/UT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqAG-0003dS-AB; Thu, 22 Oct 2026 06:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAD-0003ba-BS
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAB-0007mh-Kv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtipJlkkV1SGWhXJydF2ioHXbH2NpaSbxvIo9dufzCM=;
 b=FczoZ/UT+KlBhKlf6g9Wi3wUJiAlpwScWBhoO9vOTYU/LR4GszYee2coFLA/q37Vf2t0VQ
 OmPdBO/4Y3y9OLi6D6WgfYdaXNTLt0DMZxZVHai0BK1obI9UoK5eeQPJAmWlcJMN0bFzNY
 M1HP2s6NMGLPW1O8/ajWUcnFMmbbg/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-7lMkJM2pMOiCu8OuEzx9Sg-1; Thu,
 22 Oct 2026 10:36:43 +0000
X-MC-Unique: 7lMkJM2pMOiCu8OuEzx9Sg-1
X-Mimecast-MFC-AGG-ID: 7lMkJM2pMOiCu8OuEzx9Sg_1792665402
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DF9D1955F7F; Thu, 22 Oct 2026 10:36:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD0AB30000E7; Thu, 22 Oct 2026 10:36:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>
Subject: [PULL 06/11] tests/qtest/usb-hcd-xhci: test interrupt pacing above
 2^32
Date: Thu, 22 Oct 2026 12:36:17 +0200
Message-ID: <20261022103622.1151089-7-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@linux.dev>

Commit bfb82d57e7 ("hw/usb/hcd-xhci: fix interval alignment after
MFINDEX passes 2^32") fixed both isoch and interrupt scheduling, but
the regression test only covers the isoch path.

Queue a keyboard report on an interrupt IN endpoint after stepping
past 2^32 microframes. Check that the transfer remains pending until
the next interval boundary, then completes with the expected report.
With the old 32-bit mask, it completes as soon as the doorbell is rung.

Link: https://lore.kernel.org/qemu-devel/52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com/
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261004044803.9740-1-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 2e173af7506..add2290bffa 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -48,6 +48,7 @@
 #define TRB_GET_CCODE(status)   ((status) >> 24)
 #define TRB_GET_SLOT(control)   ((control) >> 24)
 
+#define TR_NORMAL              1
 #define TR_ISOCH                5
 #define CR_ENABLE_SLOT          9
 #define CR_ADDRESS_DEVICE       11
@@ -59,6 +60,7 @@
 #define EP_TYPE_ISOCH_OUT       1
 #define EP_TYPE_CONTROL         4
 #define EP_TYPE_ISOCH_IN        5
+#define EP_TYPE_INTR_IN         7
 
 #define XHCI_RING_TRBS          64
 #define XHCI_MICROFRAME_NS      125000
@@ -392,6 +394,48 @@ static void test_xhci_isoch_mfindex_32bit(void)
     xhci_test_end(&x);
 }
 
+static void test_xhci_intr_mfindex_32bit(void)
+{
+    const unsigned int interval = 6;
+    const uint8_t expected[] = { 0, 0, 4, 0, 0, 0, 0, 0 };
+    uint8_t report[sizeof(expected)];
+    uint32_t status, control;
+    uint64_t ring, data;
+    XHCITest x;
+
+    if (!xhci_test_supported("usb-kbd")) {
+        return;
+    }
+
+    xhci_test_start(&x, "-device usb-kbd");
+    ring = xhci_configure_ep(&x, 3, EP_TYPE_INTR_IN, interval, 8);
+    data = xhci_alloc_page(&x);
+
+    qtest_clock_step(x.qts, ((1ULL << 32) + 5) * XHCI_MICROFRAME_NS);
+    /* A ready report makes an early transfer observable. */
+    qtest_qmp_assert_success(x.qts,
+        "{'execute': 'input-send-event', 'arguments': {'events': ["
+        "{'type': 'key', 'data': {'down': true, "
+        "'key': {'type': 'qcode', 'data': 'a'}}}]}}");
+
+    xhci_write_trb(&x, ring, data, sizeof(report),
+                   TRB_TYPE(TR_NORMAL) | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+
+    qtest_clock_step(x.qts,
+                     ((1U << interval) - 5) * XHCI_MICROFRAME_NS - 1);
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+    qtest_clock_step(x.qts, 1);
+    g_assert_true(xhci_next_event(&x, &status, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_TRANSFER);
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    qtest_memread(x.qts, data, report, sizeof(report));
+    g_assert_cmpmem(report, sizeof(report), expected, sizeof(expected));
+
+    xhci_test_end(&x);
+}
+
 /*
  * The endpoint type in the endpoint context is whatever the guest says. Tell
  * the controller that the interrupt endpoint of usb-kbd is isoch. The idle
@@ -439,6 +483,8 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/xhci/pci/isoch/mfindex-32bit",
                    test_xhci_isoch_mfindex_32bit);
+    qtest_add_func("/xhci/pci/intr/mfindex-32bit",
+                   test_xhci_intr_mfindex_32bit);
     qtest_add_func("/xhci/pci/isoch/ep-type-mismatch",
                    test_xhci_isoch_ep_type_mismatch);
 
-- 
2.56.0


