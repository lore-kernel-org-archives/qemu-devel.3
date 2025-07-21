Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A3AC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtK3-0000Sc-Lg; Mon, 21 Jul 2025 12:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIu-0004sJ-UA
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIq-0001WR-Vi
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jzuyb0TwYPkuBmLFTkEwXo7WimGA6V333RZVisJcj7U=;
 b=FG+HfR3ShNIXKFh1OZHUVTfpCEsYslXmy5jnJvdxzzhnZNJMOs/f9pz//BchrkgZAaVHKm
 G1iDYwR7g93FEngicgETcweK/xzWtyWHfUVHmWJSZANDV0dTFePB9ZXE5h3CQHZhgJ9/1K
 VroRQex+0GLlo1IvWsBdoLhDOSSRE3A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-CcKn392TO6KUpuK5e_G0bg-1; Mon,
 21 Jul 2025 12:23:31 -0400
X-MC-Unique: CcKn392TO6KUpuK5e_G0bg-1
X-Mimecast-MFC-AGG-ID: CcKn392TO6KUpuK5e_G0bg_1753115010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5950E1800281; Mon, 21 Jul 2025 16:23:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF23A195608D; Mon, 21 Jul 2025 16:23:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/50] pnv/xive2: Print value in invalid register write logging
Date: Mon, 21 Jul 2025 18:22:01 +0200
Message-ID: <20250721162233.686837-19-clg@redhat.com>
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

This can make it easier to see what the target system is trying to
do.

[npiggin: split from larger patch]

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-19-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/pnv_xive2.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 25dc8a372d2f..9d53537e3e09 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1197,7 +1197,8 @@ static void pnv_xive2_ic_cq_write(void *opaque, hwaddr offset,
     case CQ_FIRMASK_OR: /* FIR error reporting */
         break;
     default:
-        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx, offset);
+        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
@@ -1495,7 +1496,8 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        xive2_error(xive, "VC: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "VC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
@@ -1703,7 +1705,8 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        xive2_error(xive, "PC: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "PC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
@@ -1790,7 +1793,8 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
         xive->tctxt_regs[reg] = val;
         break;
     default:
-        xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "TCTXT: invalid write @0x%"HWADDR_PRIx
+                    " data 0x%"PRIx64, offset, val);
         return;
     }
 }
@@ -1861,7 +1865,8 @@ static void pnv_xive2_xscom_write(void *opaque, hwaddr offset,
         pnv_xive2_ic_tctxt_write(opaque, mmio_offset, val, size);
         break;
     default:
-        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx
+                    " value 0x%"PRIx64, offset, val);
     }
 }
 
@@ -1929,7 +1934,8 @@ static void pnv_xive2_ic_notify_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx
+                    " value 0x%"PRIx64, offset, val);
     }
 }
 
@@ -1971,7 +1977,8 @@ static void pnv_xive2_ic_lsi_write(void *opaque, hwaddr offset,
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
 
-    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx, offset);
+    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
+                offset, val);
 }
 
 static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
@@ -2074,7 +2081,8 @@ static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
         inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
         break;
     default:
-        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
-- 
2.50.1


