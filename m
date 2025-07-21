Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AE3C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtIx-0004qA-3O; Mon, 21 Jul 2025 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtI3-0003Id-C6
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHz-0001O7-Ch
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LFIA52aLnJLo4iSfDSS+0eck6FoSAwP11FgR2rElbiU=;
 b=X1NzwxOyV6TGjsDsaekBwbHel+WKdoDqhh71p/19fvzgt5LianNQq2Wr8GHefvZIZuPn/I
 4860YjwWM+mCM10WP6LVt9JA/kyPfhzYw1z52U0q0JeiGs6SKtbanb9C7Jh4Lvbwp5RIy+
 pyYZY+EGPVwY+z5Hwrypc0PQXUCC+Ko=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-4rRK5E_vPLWASb9WVJNFIA-1; Mon,
 21 Jul 2025 12:22:50 -0400
X-MC-Unique: 4rRK5E_vPLWASb9WVJNFIA-1
X-Mimecast-MFC-AGG-ID: 4rRK5E_vPLWASb9WVJNFIA_1753114969
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F47618001DA; Mon, 21 Jul 2025 16:22:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3DEE195608D; Mon, 21 Jul 2025 16:22:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/50] ppc/xive2: Remote VSDs need to match on forwarding
 address
Date: Mon, 21 Jul 2025 18:21:47 +0200
Message-ID: <20250721162233.686837-5-clg@redhat.com>
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

From: Michael Kowal <kowal@linux.ibm.com>

In a multi chip environment there will be remote/forwarded VSDs.  The check
to find a matching INT controller (XIVE) of the remote block number was
checking the INTs chip number.  Block numbers are not tied to a chip number.
The matching remote INT is the one that matches the forwarded VSD address
with VSD types associated MMIO BAR.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-5-npiggin@gmail.com
[ clg: Fixed log format in pnv_xive2_get_remote() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/pnv_xive2.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ec8b0c68f1a4..6b724fe762f6 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -101,12 +101,10 @@ static uint32_t pnv_xive2_block_id(PnvXive2 *xive)
 }
 
 /*
- * Remote access to controllers. HW uses MMIOs. For now, a simple scan
- * of the chips is good enough.
- *
- * TODO: Block scope support
+ * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
+ * scan of all the chips INT controller is good enough.
  */
-static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
+static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
 {
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     int i;
@@ -115,10 +113,23 @@ static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
         Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
         PnvXive2 *xive = &chip10->xive;
 
-        if (pnv_xive2_block_id(xive) == blk) {
+        /*
+         * Is this the XIVE matching the forwarded VSD address is for this
+         * VSD type
+         */
+        if ((vsd_type == VST_ESB   && fwd_addr == xive->esb_base) ||
+            (vsd_type == VST_END   && fwd_addr == xive->end_base)  ||
+            ((vsd_type == VST_NVP ||
+              vsd_type == VST_NVG) && fwd_addr == xive->nvpg_base) ||
+            (vsd_type == VST_NVC   && fwd_addr == xive->nvc_base)) {
             return xive;
         }
     }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                 "XIVE: >>>>> %s vsd_type %u  fwd_addr 0x%"HWADDR_PRIx
+                  " NOT FOUND\n",
+                  __func__, vsd_type, fwd_addr);
     return NULL;
 }
 
@@ -251,8 +262,7 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
 
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
-        xive = pnv_xive2_get_remote(blk);
-
+        xive = pnv_xive2_get_remote(type, (vsd & VSD_ADDRESS_MASK));
         return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
     }
 
-- 
2.50.1


