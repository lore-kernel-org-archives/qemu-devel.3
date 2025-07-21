Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432F2C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtJt-00087C-LK; Mon, 21 Jul 2025 12:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIq-0004nA-M4
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIm-0001VW-R5
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbcOZYvYxcpn7qLGoZRN868cWZlnWPR04Tvliab+iGE=;
 b=M/Qrnb1rHK6ySCalEApjeEquWD4QkvR/UsVfzesqp6+/wTMOlmS93+AZ3hLkhJDS5n21De
 dsM1B65d7HSQf9zSJxoZNE+R6Gv+majH+AKA7E08dtJYsyC6rkd3Wcv+mgzBUIgpDB7U57
 DRyBUdVwSrD/w2Xl7D0+mLrW0OxoO+o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-qGW7kRUuNr-n9Pdqo_mb0Q-1; Mon,
 21 Jul 2025 12:23:28 -0400
X-MC-Unique: qGW7kRUuNr-n9Pdqo_mb0Q-1
X-Mimecast-MFC-AGG-ID: qGW7kRUuNr-n9Pdqo_mb0Q_1753115007
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D5DF1944CC9; Mon, 21 Jul 2025 16:23:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD0571956050; Mon, 21 Jul 2025 16:23:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/50] pnv/xive2: Support ESB Escalation
Date: Mon, 21 Jul 2025 18:22:00 +0200
Message-ID: <20250721162233.686837-18-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Add support for XIVE ESB Interrupt Escalation.

Suggested-by: Michael Kowal <kowal@linux.ibm.com>
[This change was taken from a patch provided by Michael Kowal.]
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-18-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2.h      |  1 +
 include/hw/ppc/xive2_regs.h | 13 +++++---
 hw/intc/xive2.c             | 62 ++++++++++++++++++++++++++++++-------
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 8cdf8191742e..2436ddb5e53c 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -80,6 +80,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
 uint32_t xive2_router_get_config(Xive2Router *xrtr);
 
 void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
+void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
 
 /*
  * XIVE2 Presenter (POWER10)
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 3c28de8a304d..2c535ec0d0f1 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -39,15 +39,18 @@
 
 typedef struct Xive2Eas {
         uint64_t       w;
-#define EAS2_VALID                 PPC_BIT(0)
-#define EAS2_END_BLOCK             PPC_BITMASK(4, 7) /* Destination EQ block# */
-#define EAS2_END_INDEX             PPC_BITMASK(8, 31) /* Destination EQ index */
-#define EAS2_MASKED                PPC_BIT(32) /* Masked                 */
-#define EAS2_END_DATA              PPC_BITMASK(33, 63) /* written to the EQ */
+#define EAS2_VALID         PPC_BIT(0)
+#define EAS2_QOS           PPC_BIT(1, 2)       /* Quality of Service(unimp) */
+#define EAS2_RESUME        PPC_BIT(3)          /* END Resume(unimp) */
+#define EAS2_END_BLOCK     PPC_BITMASK(4, 7)   /* Destination EQ block# */
+#define EAS2_END_INDEX     PPC_BITMASK(8, 31)  /* Destination EQ index */
+#define EAS2_MASKED        PPC_BIT(32)         /* Masked */
+#define EAS2_END_DATA      PPC_BITMASK(33, 63) /* written to the EQ */
 } Xive2Eas;
 
 #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
 #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
+#define xive2_eas_is_resume(eas)  (be64_to_cpu((eas)->w) & EAS2_RESUME)
 
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf);
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index cca121b5f13c..541b05225cd2 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1552,18 +1552,39 @@ do_escalation:
         }
     }
 
-    /*
-     * The END trigger becomes an Escalation trigger
-     */
-    xive2_router_end_notify(xrtr,
-                           xive_get_field32(END2_W4_END_BLOCK,     end.w4),
-                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
-                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+    if (xive2_end_is_escalate_end(&end)) {
+        /*
+         * Perform END Adaptive escalation processing
+         * The END trigger becomes an Escalation trigger
+         */
+        xive2_router_end_notify(xrtr,
+                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
+                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
+                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+    } /* end END adaptive escalation */
+
+    else {
+        uint32_t lisn;              /* Logical Interrupt Source Number */
+
+        /*
+         *  Perform ESB escalation processing
+         *      E[N] == 1 --> N
+         *      Req[Block] <- E[ESB_Block]
+         *      Req[Index] <- E[ESB_Index]
+         *      Req[Offset] <- 0x000
+         *      Execute <ESB Store> Req command
+         */
+        lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
+                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
+
+        xive2_notify(xrtr, lisn, true /* pq_checked */);
+    }
+
+    return;
 }
 
-void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
+void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
 {
-    Xive2Router *xrtr = XIVE2_ROUTER(xn);
     uint8_t eas_blk = XIVE_EAS_BLOCK(lisn);
     uint32_t eas_idx = XIVE_EAS_INDEX(lisn);
     Xive2Eas eas;
@@ -1606,13 +1627,30 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
         return;
     }
 
+    /* TODO: add support for EAS resume */
+    if (xive2_eas_is_resume(&eas)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "XIVE: EAS resume processing unimplemented - LISN %x\n",
+                      lisn);
+        return;
+    }
+
     /*
      * The event trigger becomes an END trigger
      */
     xive2_router_end_notify(xrtr,
-                             xive_get_field64(EAS2_END_BLOCK, eas.w),
-                             xive_get_field64(EAS2_END_INDEX, eas.w),
-                             xive_get_field64(EAS2_END_DATA,  eas.w));
+                            xive_get_field64(EAS2_END_BLOCK, eas.w),
+                            xive_get_field64(EAS2_END_INDEX, eas.w),
+                            xive_get_field64(EAS2_END_DATA,  eas.w));
+    return;
+}
+
+void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xn);
+
+    xive2_notify(xrtr, lisn, pq_checked);
+    return;
 }
 
 static const Property xive2_router_properties[] = {
-- 
2.50.1


