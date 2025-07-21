Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2286FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtJU-0006y0-Jc; Mon, 21 Jul 2025 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIs-0004oD-Pz
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIp-0001X6-C1
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ac/QUVQGSJO1a5hZVsjUbANeNkNU/atUCzOkeaMJXV0=;
 b=THhIW017X5cgvZbo9uoHmouR5MfAzi2hAFm8xxAI/Xas3ZbrdfqSRUTCrszShWGBLqJH7g
 2yTWmT3dNtF77wEdIf4dxFgo0M2cWi+odnDYRRYqapUNW+R+YFO//sx5EHdCgF8BLETz/X
 86Pnej4I5XgfNW2fKZhP0qM9pN1Ub8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-fvGerBM_Orqh30blk3q3zA-1; Mon,
 21 Jul 2025 12:23:37 -0400
X-MC-Unique: fvGerBM_Orqh30blk3q3zA-1
X-Mimecast-MFC-AGG-ID: fvGerBM_Orqh30blk3q3zA_1753115016
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E9F51800D86; Mon, 21 Jul 2025 16:23:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C34C0195608D; Mon, 21 Jul 2025 16:23:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/50] pnv/xive2: Permit valid writes to VC/PC Flush Control
 registers
Date: Mon, 21 Jul 2025 18:22:03 +0200
Message-ID: <20250721162233.686837-21-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Writes to the Flush Control registers were logged as invalid
when they are allowed. Clearing the unsupported want_cache_disable
feature is supported, so don't log an error in that case.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-21-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/pnv_xive2.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e15f414d0bb3..386175a68b29 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1411,7 +1411,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
     /*
      * ESB cache updates (not modeled)
      */
-    /* case VC_ESBC_FLUSH_CTRL: */
+    case VC_ESBC_FLUSH_CTRL:
+        if (val & VC_ESBC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case VC_ESBC_FLUSH_POLL:
         xive->vc_regs[VC_ESBC_FLUSH_CTRL >> 3] |= VC_ESBC_FLUSH_CTRL_POLL_VALID;
         /* ESB update */
@@ -1427,7 +1434,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
     /*
      * EAS cache updates (not modeled)
      */
-    /* case VC_EASC_FLUSH_CTRL: */
+    case VC_EASC_FLUSH_CTRL:
+        if (val & VC_EASC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case VC_EASC_FLUSH_POLL:
         xive->vc_regs[VC_EASC_FLUSH_CTRL >> 3] |= VC_EASC_FLUSH_CTRL_POLL_VALID;
         /* EAS update */
@@ -1466,7 +1480,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         break;
 
 
-    /* case VC_ENDC_FLUSH_CTRL: */
+    case VC_ENDC_FLUSH_CTRL:
+        if (val & VC_ENDC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case VC_ENDC_FLUSH_POLL:
         xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
         break;
@@ -1687,7 +1708,14 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         pnv_xive2_nxc_update(xive, watch_engine);
         break;
 
-   /* case PC_NXC_FLUSH_CTRL: */
+    case PC_NXC_FLUSH_CTRL:
+        if (val & PC_NXC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case PC_NXC_FLUSH_POLL:
         xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
         break;
-- 
2.50.1


