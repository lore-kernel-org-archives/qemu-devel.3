Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B8DC55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 11:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqUQn-0000vO-Aq; Sun, 02 Aug 2026 07:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wqUQe-0000rh-Uj; Sun, 02 Aug 2026 07:32:29 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wqUQc-00070D-3h; Sun, 02 Aug 2026 07:32:28 -0400
Received: from DESKTOP-J3VFOUN.localdomain (unknown [62.217.189.53])
 by mail.ispras.ru (Postfix) with ESMTPSA id 53CFA406E9A8;
 Sun,  2 Aug 2026 11:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 53CFA406E9A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1785670342;
 bh=OeUtX3MFYx5OI4D5LkUpJUOeDd9GdM2ff8ea3tnflKE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GzWIwLeat3jkWa2dPTejlXb0VYKE8CkvpV0cJEIBfs1zLEqqM8d9RBh8r9mMaHpLy
 e2TSRWpHYXWp5yhv9hanDCzXyirvkLZEklvgd5L18yv2c53ZDM8K1ZS5p/4wIeFJd9
 3ssM6AVE4b1qut/+XzTEC8r9dcpK23XKv7qEViuc=
From: Ivan Efremov <nendensu@ispras.ru>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 farosas@suse.de, lvivier@redhat.com, Ivan Efremov <nendensu@ispras.ru>
Subject: [PATCH 2/2] tests/qtest: Add seed CSR zero extension test
Date: Sun,  2 Aug 2026 14:31:29 +0300
Message-ID: <20260802113130.7818-3-nendensu@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260802113130.7818-1-nendensu@ispras.ru>
References: <20260802113130.7818-1-nendensu@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=nendensu@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a qtest that reads the seed CSR on RV64 machine with Zkr support
and verifies that the upper 32 bits are clear.

Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
---
 tests/qtest/riscv-csr-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
index bb1b0ffed3..7479a5c5bc 100644
--- a/tests/qtest/riscv-csr-test.c
+++ b/tests/qtest/riscv-csr-test.c
@@ -20,6 +20,12 @@
 #define CSR_MVENDORID       0xf11
 #define CSR_MISELECT        0x350
 
+#define CSR_SEED           0x015
+
+#define SEED_OPST_MASK     (UINT64_C(0x3) << 30)
+#define SEED_OPST_ES16     (UINT64_C(0x2) << 30)
+#define SEED_OPST_DEAD     (UINT64_C(0x3) << 30)
+
 static void run_test_csr(void)
 {
     uint64_t res;
@@ -46,12 +52,32 @@ static void run_test_csr(void)
     qtest_quit(qts);
 }
 
+static void run_test_seed_csr(void)
+{
+    uint64_t val = 0;
+    uint64_t opst;
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt -cpu tt-ascalon");
+
+    qtest_csr_call(qts, "get_csr", 0, CSR_SEED, &val);
+
+    opst = val & SEED_OPST_MASK;
+    g_assert_true(opst == SEED_OPST_ES16 ||
+                  opst == SEED_OPST_DEAD);
+
+    g_assert_cmphex(val >> 32, ==, 0);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     if (qtest_has_machine("virt")) {
         qtest_add_func("/cpu/csr", run_test_csr);
+        qtest_add_func("/cpu/csr/seed", run_test_seed_csr);
     }
 
     return g_test_run();
-- 
2.43.0


