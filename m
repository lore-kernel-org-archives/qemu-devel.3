Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6292AC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMr-0007fI-Pl; Mon, 21 Jul 2025 12:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtK0-0000F2-BX
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJy-0001qi-H0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQkr5sirkIYVlkew3vz7iKEHM5VQk0+durPjB467nNs=;
 b=dG7AFvkshVLFItu4uvD4fA5b5qt0VwYs+i6hDcrJNHxTiMXwV/NSsPh1bpn9BdV0XhsEUt
 SZT+vWNe9Pk45NVLqNeDfV7+wB4+FcK4Qfsju9zzK68MSX/OjvY+0wEhhwJUrTvjGNTy3R
 oyW2VlqLHyqs1A+htNg06/w7oycmuBQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-3PUIgMrDOca6ZYSgcRrjGA-1; Mon,
 21 Jul 2025 12:24:54 -0400
X-MC-Unique: 3PUIgMrDOca6ZYSgcRrjGA-1
X-Mimecast-MFC-AGG-ID: 3PUIgMrDOca6ZYSgcRrjGA_1753115093
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 230CB1956088; Mon, 21 Jul 2025 16:24:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B474B195608D; Mon, 21 Jul 2025 16:24:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 48/50] ppc/xive2: Implement PHYS ring VP push TIMA op
Date: Mon, 21 Jul 2025 18:22:31 +0200
Message-ID: <20250721162233.686837-49-clg@redhat.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

Implement the phys (aka hard) VP push. PowerVM uses this operation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-49-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2.h |  2 ++
 hw/intc/xive.c         |  2 ++
 hw/intc/xive2.c        | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 45266c2a8b9e..f4437e2c79a7 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -146,6 +146,8 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                 hwaddr offset, unsigned size);
+void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                 hwaddr offset, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 725ba72b8f7a..8b7182fbb86c 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
       xive_tm_set_pool_lgs, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
       xive2_tm_set_hv_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, false, true,
+      xive2_tm_push_phys_ctx, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
       NULL, xive_tm_vt_poll },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, true, true,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f9eaea119289..1b005687961a 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1005,6 +1005,11 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     /* First update the thead context */
     switch (size) {
+    case 1:
+        tctx->regs[ring + TM_WORD2] = value & 0xff;
+        cam = xive2_tctx_hw_cam_line(xptr, tctx);
+        cam |= ((value & 0xc0) << 24); /* V and H bits */
+        break;
     case 4:
         cam = value;
         w2 = cpu_to_be32(cam);
@@ -1040,6 +1045,12 @@ void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW2_HV_POOL);
 }
 
+void xive2_tm_push_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
+}
+
 /* returns -1 if ring is invalid, but still populates block and index */
 static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
                                       uint8_t *nvp_blk, uint32_t *nvp_idx)
-- 
2.50.1


