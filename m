Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7658C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFThX-0000wr-5k; Thu, 15 May 2025 04:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTgd-0005VC-69; Thu, 15 May 2025 04:11:33 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTgb-00018W-9g; Thu, 15 May 2025 04:11:26 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 May
 2025 16:10:13 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 May 2025 16:10:13 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 16/28] hw/misc/aspeed_hace: Support to dump plaintext and
 digest for better debugging
Date: Thu, 15 May 2025 16:09:48 +0800
Message-ID: <20250515081008.583578-17-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
References: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

1. Added "hace_hexdump()" to dump a contiguous buffer using qemu_hexdump.
2. Added "hace_iov_hexdump()" to flatten and dump scatter-gather source vectors.
3. Introduced a new trace event: "aspeed_hace_hexdump".

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_hace.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events  |  1 +
 2 files changed, 47 insertions(+)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index ee1d9ab58f..8924a30eff 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -10,8 +10,10 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/iov.h"
 #include "hw/misc/aspeed_hace.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
@@ -88,6 +90,42 @@ static const struct {
       QCRYPTO_HASH_ALGO_SHA256 },
 };
 
+static void hace_hexdump(const char *desc, const char *buf, size_t size)
+{
+    g_autoptr(GString) str = g_string_sized_new(64);
+    size_t len;
+    size_t i;
+
+    for (i = 0; i < size; i += len) {
+        len = MIN(16, size - i);
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, buf + i, len, 1, 4);
+        trace_aspeed_hace_hexdump(desc, i, str->str);
+    }
+}
+
+static void hace_iov_hexdump(const char *desc, const struct iovec *iov,
+                             const unsigned int iov_cnt)
+{
+    size_t size = 0;
+    char *buf;
+    int i;
+
+    for (i = 0; i < iov_cnt; i++) {
+        size += iov[i].iov_len;
+    }
+
+    buf = g_malloc(size);
+
+    if (!buf) {
+        return;
+    }
+
+    iov_to_buf(iov, iov_cnt, 0, buf, size);
+    hace_hexdump(desc, buf, size);
+    g_free(buf);
+}
+
 static int hash_algo_lookup(uint32_t reg)
 {
     int i;
@@ -302,6 +340,10 @@ static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
                       __func__, digest_addr);
     }
 
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {
+        hace_hexdump("digest", (char *)digest_buf, digest_len);
+    }
+
     for (; iov_idx > 0; iov_idx--) {
         address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,
                             iov[iov_idx - 1].iov_len, false,
@@ -395,6 +437,10 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
          return;
     }
 
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {
+        hace_iov_hexdump("plaintext", iov, iov_idx);
+    }
+
     /* Executes the hash operation */
     if (acc_mode) {
         hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b980d7fdd3..e3f64c0ff6 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -308,6 +308,7 @@ aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%
 aspeed_hace_hash_sg(int index, uint64_t list_addr, uint64_t buf_addr, uint32_t len) "%d: list_addr 0x%" PRIx64 " buf_addr 0x%" PRIx64 " len 0x%" PRIx32
 aspeed_hace_hash_addr(const char *s, uint64_t addr) "%s: 0x%" PRIx64
 aspeed_hace_hash_execute_acc_mode(bool final_request) "final request: %d"
+aspeed_hace_hexdump(const char *desc, uint32_t offset, char *s) "%s: 0x%08x: %s"
 
 # bcm2835_property.c
 bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
-- 
2.43.0


