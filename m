Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE07C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlxU9-0002SB-C0; Mon, 20 Jul 2026 19:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxU4-0002OG-Vc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:17 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxU0-00050W-GT
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:16 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BEF4D4014BA;
 Mon, 20 Jul 2026 23:33:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com
 (trex-green-7.trex.outbound.svc.cluster.local [100.103.92.160])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 70169400F61;
 Mon, 20 Jul 2026 23:33:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Average-Fearful: 0a1c7e6066406f08_1784590389702_758826701
X-MC-Loop-Signature: 1784590389702:1016739499
X-MC-Ingress-Time: 1784590389702
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.92.160 (trex/8.0.2); Mon, 20 Jul 2026 23:33:09 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdx00fSz1P9; 
 Mon, 20 Jul 2026 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1784590389;
 bh=iZqxenwoIt6yu+IkNTihBz891cvUJGF++ChizIyZjAk=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=IBvmN7VylmNt50oIZ1RwmEGGarPNxbbsk94Ci+zUz2WiHJGXuBYDHYCQkU5LcWaXh
 OoNkOZPkbF2uGGAZB1KUhz/gnO+RBqmRblNCqwvsGT/CPgQCIzE8l2sWZCYmu6d/01
 PXOc+e2iUCMVo12sJ5enJjyvmSNgj9Y4wjJbX7fS8qukujrUy/4fyTnddiIwuLP23z
 s4G6VHywSWEZWImH6QktPbhx7y/VzMV/6ddSrVzoudTM9HMxZn74vo1T8cAiQ+kTtm
 wVxJ3TqCfVVCVE6/LKX29Zj1pkZqmLXdfX9x5sLnhd11TkD3awWt6JML9h3ulWHGdR
 m0F5u2gUCyhZQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 5/5] tests/qtest/cxl: Add CXL Fixed Memory Window
 restriction flag tests
Date: Mon, 20 Jul 2026 16:32:42 -0700
Message-Id: <20260720233242.901544-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
References: <20260720233242.901544-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Add a /pci/cxl/cfmw group exercising the configurable CFMWS Window
Restrictions.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tests/qtest/cxl-test.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 8fb7e58d4f17..49d820cde16f 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -81,6 +81,13 @@
     "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
 
+/* Single pxb + volatile type3 + one window; base for the CFMW tests. */
+#define QEMU_CFMW \
+    "-machine q35,cxl=on " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    QEMU_RP QEMU_T3D_VMEM \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G"
+
 static void cxl_basic_hb(void)
 {
     qtest_start("-machine q35,cxl=on");
@@ -117,6 +124,81 @@ static void cxl_2root_port(void)
     qtest_end();
 }
 
+/*
+ * CFMWS "Window Restrictions" (CXL r4.0 9.18.1.3) are configurable per
+ * window; check that valid restriction sets are accepted.
+ */
+static void cxl_cfmw_default(void)
+{
+    /* No coherency flag advertises both HDM-D and HDM-H. */
+    qtest_start(QEMU_CFMW);
+    qtest_end();
+}
+
+static void cxl_cfmw_host_only_off(void)
+{
+    /* Disabling host-only leaves device-coherent (HDM-D). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.host-only=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_device_coherent_off(void)
+{
+    /* Disabling device-coherent leaves host-only (HDM-H). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.device-coherent=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_back_invalidate(void)
+{
+    /* Back-Invalidate implies device-coherent (HDM-DB). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.back-invalidate=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_fixed_config(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.fixed-config=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_device_and_host(void)
+{
+    /*
+     * device-coherent and host-only may both be advertised (the spec
+     * permits multiple bits set); this must be accepted -- a regression
+     * guard against reinstating a device/host-only mutual exclusion.
+     */
+    qtest_start(QEMU_CFMW
+                ",cxl-fmw.0.device-coherent=on,cxl-fmw.0.host-only=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_volatile_only(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.persistent=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_persistent_only(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.volatile=off");
+    qtest_end();
+}
+
+/* Two windows in one VM: a Back-Invalidate window and a host-only window. */
+static void cxl_cfmw_two_windows(void)
+{
+    qtest_start("-machine q35,cxl=on "
+                "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "
+                "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "
+                QEMU_RP QEMU_T3D_VMEM
+                "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,"
+                "cxl-fmw.0.back-invalidate=on,"
+                "cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G");
+    qtest_end();
+}
+
 #ifdef CONFIG_POSIX
 static void cxl_t3d_deprecated(void)
 {
@@ -233,6 +315,19 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
         qtest_add_func("/pci/cxl/rp", cxl_root_port);
         qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+        qtest_add_func("/pci/cxl/cfmw/default", cxl_cfmw_default);
+        qtest_add_func("/pci/cxl/cfmw/host_only_off", cxl_cfmw_host_only_off);
+        qtest_add_func("/pci/cxl/cfmw/device_coherent_off",
+                       cxl_cfmw_device_coherent_off);
+        qtest_add_func("/pci/cxl/cfmw/back_invalidate",
+                       cxl_cfmw_back_invalidate);
+        qtest_add_func("/pci/cxl/cfmw/fixed_config", cxl_cfmw_fixed_config);
+        qtest_add_func("/pci/cxl/cfmw/device_and_host",
+                       cxl_cfmw_device_and_host);
+        qtest_add_func("/pci/cxl/cfmw/volatile_only", cxl_cfmw_volatile_only);
+        qtest_add_func("/pci/cxl/cfmw/persistent_only",
+                       cxl_cfmw_persistent_only);
+        qtest_add_func("/pci/cxl/cfmw/two_windows", cxl_cfmw_two_windows);
 #ifdef CONFIG_POSIX
         qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
         qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
-- 
2.39.5


