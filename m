Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7351D35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rhk-0004WS-Rn; Wed, 01 Apr 2026 05:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7rhh-0004VX-O9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:17:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7rhf-0004OW-QL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:17:37 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260401091733epoutp042f28bddb4fd43e7bcd59020211a5d487~iMPoGvUVb1592915929epoutp04J
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2026 09:17:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260401091733epoutp042f28bddb4fd43e7bcd59020211a5d487~iMPoGvUVb1592915929epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1775035053;
 bh=ATWNpJ89zL6IYEMAVy1iWb//wiNeXnRdE/33UOrU+yM=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=kDeFg715I+Iu10Ivv/V6I/zVYMKLoCzAHn+WDzzChVYMFEIHDUo6jqmuqAckRkYu+
 idT1AEopw7ZsaleznYqN0vG1RHRg0hDYtQ0flfYqjNZaKdKWMO6HwQEO7ELQPiMLIc
 HKI/Dl8Zpi3H8EF0Vug+huYDOgjjrT7unhNUifDA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
 20260401091733epcas2p158788ac2ecc6218860e7c882b51247d7~iMPn4uy8n1166211662epcas2p1b;
 Wed,  1 Apr 2026 09:17:33 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.200]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4flzsT077Jz2SSKZ; Wed,  1 Apr
 2026 09:17:33 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH RESEND 3/5] hw/ufs: Add IDLE operation
From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260401090457epcms2p2368a82c8b794d8591aa62a421db9e8f7@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260401091732epcms2p8822df565a95c0fa3098e918697b293b2@epcms2p8>
Date: Wed, 01 Apr 2026 18:17:32 +0900
X-CMS-MailID: 20260401091732epcms2p8822df565a95c0fa3098e918697b293b2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
References: <20260401090457epcms2p2368a82c8b794d8591aa62a421db9e8f7@epcms2p2>
 <CGME20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p8>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jaemyung.lee@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: jaemyung.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add timer-based idle behaviour to UFS Device.

When no I/O occurs, the UFS Device performs various internal operations.
To emulate this, adds a timer that periodically checks the current I/O
status of the device and call the ufs_process_idle() function when idle.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
 hw/ufs/ufs.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 69f82ab462..19438c89e1 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1801,6 +1801,46 @@ static void ufs_sendback_req(void *opaque)
     ufs_irq_check(u);
 }

+/* IDLE */
+static void ufs_process_idle(UfsHc *u)
+{
+    /* Currently do nothing */
+    return;
+}
+
+static inline bool ufs_check_idle(UfsHc *u)
+{
+    return !u->reg.utrldbr;
+}
+
+static inline bool ufs_mcq_check_idle(UfsHc *u)
+{
+    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
+        if (!ufs_mcq_sq_empty(u, i)) {
+            return false;
+        }
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
+        if (!ufs_mcq_cq_empty(u, i)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+#define UFS_IDLE_TIMER_TICK 100 /* 0.1s */
+static void ufs_idle_timer_cb(void *opaque)
+{
+    UfsHc *u = opaque;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+
+    if (ufs_check_idle(u) && ufs_mcq_check_idle(u)) {
+        ufs_process_idle(u);
+    }
+
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
+}
+
 static bool ufs_check_constraints(UfsHc *u, Error **errp)
 {
     if (u->params.nutrs > UFS_MAX_NUTRS) {
@@ -1863,6 +1903,7 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);

     u->reg_size = pow2ceil(ufs_reg_size(u));

@@ -1959,6 +2000,9 @@ static void ufs_init_hc(UfsHc *u)
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;
+
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL, ufs_idle_timer_cb, u);
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }

 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -1986,6 +2030,8 @@ static void ufs_exit(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);

+    timer_del(&u->idle_timer);
+
     qemu_free_irq(u->irq);

     qemu_bh_delete(u->doorbell_bh);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 13d964c5ae..f0b1f8b0e0 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -148,6 +148,9 @@ typedef struct UfsHc {
     UfsCq *cq[UFS_MAX_MCQ_QNUM];

     uint8_t temperature;
+
+    /* IDLE timer */
+    QEMUTimer idle_timer;
 } UfsHc;

 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
--
2.34.1

