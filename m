Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFEF10D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Arf-0000NR-NM; Mon, 30 Mar 2026 07:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7ArR-0000My-0G
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:32:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7ArO-0001Jw-Ie
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:32:48 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260330113242epoutp01ed9714af6143ff317b46e5f0479ee23e~hmzDbqfwV0365303653epoutp01S
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:32:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260330113242epoutp01ed9714af6143ff317b46e5f0479ee23e~hmzDbqfwV0365303653epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774870362;
 bh=/o3FlU03Oe6rl5Dj39HCVuOrtTZRLzXEPhkcD0TGGcI=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=XObh5Yph0HzFh8NY8rjsOqKQZbjDq41pWE3LSr48lCDr1+BbGUwIzDv3HYxiW6MXG
 G0Nn5W43QUC6Kj7kxbdryEc0wTVTKnR9zy25eXkSN7oJKIWRFbxC+YrhYz2ASVTAsU
 JIUwzP1x468iKmrbbwG1V8qFlCRBDbzf6sV/pDPM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
 20260330113241epcas2p101fd0087e8444aeb7488f5f48de74f09~hmzDEX3cE2147921479epcas2p1g;
 Mon, 30 Mar 2026 11:32:41 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.206]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4fkpyK4MGBz6B9m4; Mon, 30 Mar
 2026 11:32:41 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 3/5] hw/ufs: Add IDLE operation
From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260330113241epcms2p61c09e78855ad9c7b0fa9d9e3a183e98a@epcms2p6>
Date: Mon, 30 Mar 2026 20:32:41 +0900
X-CMS-MailID: 20260330113241epcms2p61c09e78855ad9c7b0fa9d9e3a183e98a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
References: <CGME20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p6>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=jaemyung.lee@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
Reply-To: jaemyung.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add timer-based idle behaviour to UFS Device.

When no I/O occurs, the UFS Device performs various internal operations.
To emulate this, adds a timer that periodically checks the current I/O
status of the device and call the ufs_process_idle() function when idle.

Signed-off-by: Jaemyung Lee <jameyung.lee@samsung.com>
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

