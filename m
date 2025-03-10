Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22721C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treo2-0002vB-9E; Mon, 10 Mar 2025 11:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tren6-00028v-LB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:40 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tremx-0007gl-Qr
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:11:40 -0400
Received: (qmail 30796 invoked by uid 484); 10 Mar 2025 15:11:11 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013247 secs); 10 Mar 2025 15:11:11 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 10 Mar 2025 15:11:11 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH 08/16] gdbstub: Expose GDBRegisterState
Date: Mon, 10 Mar 2025 16:05:02 +0100
Message-Id: <20250310150510.200607-9-mario.fleischmann@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=mario.fleischmann@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 gdbstub/gdbstub.c      | 7 -------
 include/exec/gdbstub.h | 8 +++++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 282e13e163..8166510f06 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -48,13 +48,6 @@
 
 #include "internals.h"
 
-typedef struct GDBRegisterState {
-    int base_reg;
-    gdb_get_reg_cb get_reg;
-    gdb_set_reg_cb set_reg;
-    const GDBFeature *feature;
-} GDBRegisterState;
-
 GDBState gdbserver_state;
 
 void gdb_init_gdbserver_state(void)
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0675b0b646..c2941e5c10 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -16,11 +16,17 @@ typedef struct GDBFeatureBuilder {
     int base_reg;
 } GDBFeatureBuilder;
 
-
 /* Get or set a register.  Returns the size of the register.  */
 typedef int (*gdb_get_reg_cb)(CPUState *cpu, GByteArray *buf, int reg);
 typedef int (*gdb_set_reg_cb)(CPUState *cpu, uint8_t *buf, int reg);
 
+typedef struct GDBRegisterState {
+    int base_reg;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
+    const GDBFeature *feature;
+} GDBRegisterState;
+
 /**
  * gdb_init_cpu(): Initialize the CPU for gdbstub.
  * @cpu: The CPU to be initialized.
-- 
2.34.1


