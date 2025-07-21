Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4229C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtIz-0005Gf-Kq; Mon, 21 Jul 2025 12:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIC-0003YC-JM
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtI9-0001Q9-T0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PeaxLgyiIYKj0kt5yg0H9AiCj069c/p8og5RfRh37nA=;
 b=UzqVyQdiLYrZycS71pQuyKhxlbTjK+yrJhaJYRZPpq2y2FLuEOvUmFUDqjBipaCcS3RuQt
 iCcdkFPJQ9dMWVm6T3UodFZf3PgXkE1SsN2ygUC7H66hp6kJNUbGGXKa8XIpCtN2loVNUU
 eLqeKFudaNFQmjPeU+yPJc3pZuYHQ8M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-DI98qf95OJ-sz9uemG2XAw-1; Mon,
 21 Jul 2025 12:23:02 -0400
X-MC-Unique: DI98qf95OJ-sz9uemG2XAw-1
X-Mimecast-MFC-AGG-ID: DI98qf95OJ-sz9uemG2XAw_1753114981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E46ED18002B6; Mon, 21 Jul 2025 16:23:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74FE5195608D; Mon, 21 Jul 2025 16:22:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/50] ppc/xive2: Use fair irq target search algorithm
Date: Mon, 21 Jul 2025 18:21:51 +0200
Message-ID: <20250721162233.686837-9-clg@redhat.com>
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

From: Glenn Miles <milesg@linux.ibm.com>

The current xive algorithm for finding a matching group vCPU
target always uses the first vCPU found.  And, since it always
starts the search with thread 0 of a core, thread 0 is almost
always used to handle group interrupts.  This can lead to additional
interrupt latency and poor performance for interrupt intensive
work loads.

Changing this to use a simple round-robin algorithm for deciding which
thread number to use when starting a search, which leads to a more
distributed use of threads for handling group interrupts.

[npiggin: Also round-robin among threads, not just cores]

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-9-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/pnv_xive2.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ec247ce48ff7..25dc8a372d2f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -643,13 +643,18 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
     int i, j;
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
+    static int next_start_core;
+    static int next_start_thread;
+    int start_core = next_start_core;
+    int start_thread = next_start_thread;
 
     for (i = 0; i < chip->nr_cores; i++) {
-        PnvCore *pc = chip->cores[i];
+        PnvCore *pc = chip->cores[(i + start_core) % chip->nr_cores];
         CPUCore *cc = CPU_CORE(pc);
 
         for (j = 0; j < cc->nr_threads; j++) {
-            PowerPCCPU *cpu = pc->threads[j];
+            /* Start search for match with different thread each call */
+            PowerPCCPU *cpu = pc->threads[(j + start_thread) % cc->nr_threads];
             XiveTCTX *tctx;
             int ring;
 
@@ -694,6 +699,15 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                     if (!match->tctx) {
                         match->ring = ring;
                         match->tctx = tctx;
+
+                        next_start_thread = j + start_thread + 1;
+                        if (next_start_thread >= cc->nr_threads) {
+                            next_start_thread = 0;
+                            next_start_core = i + start_core + 1;
+                            if (next_start_core >= chip->nr_cores) {
+                                next_start_core = 0;
+                            }
+                        }
                     }
                     count++;
                 }
-- 
2.50.1


