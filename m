Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B181C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lcC-00013N-PH; Wed, 16 Sep 2026 05:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lc0-0000lm-Mu; Wed, 16 Sep 2026 05:07:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lby-0007EO-LK; Wed, 16 Sep 2026 05:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=/bxgVcHEK6Vu822bzNHTaM2Sah5dOzYWRwwPzRqIuUg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BPU6FYrSt3uVF259TBQWnHJpKoC/brvvuEoHFkUVGxXyG6VrpSZPmVUlnUyGaxtHb
 fDA5rotxm1oO+wsHvTIzOesg1iJVA2GgBh9RToZrozjZBY2HdNYzz8wdZlrqPcudHU
 /y76nBSbMH6Xh8TUjzpFGbJ/Hf9Kb36LPSsSw4JeMOEq5uRFvC1peE3IKh/65+ZlUD
 dbsq/uWxGrVL7FkW9nwMSqjqwUMUAckokdap88jpqkqzGm0czk8EjWcw8zVyGh6UgD
 X8MMiXBV/SrwaGcIH/ECDvOfGteDXPPHoxHX+YtJFS77oS0QTTRDObo3Lhf+WUU6Im
 ljKZwyK3wpPSQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AFA0A1D56C3;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B4E2429E0E;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2E2DB5A777; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ivan Efremov <nendensu@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 15/57] tests/qtest: Add seed CSR zero extension test
Date: Wed, 16 Sep 2026 12:03:39 +0300
Message-ID: <20260916090516.677749-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Ivan Efremov <nendensu@ispras.ru>

Add a qtest that reads the seed CSR on RV64 machine with Zkr support
and verifies that the upper 32 bits are clear.

Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260802113130.7818-3-nendensu@ispras.ru>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e80cf294797870b019d31dd299328aebdfaaa76c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
index bb1b0ffed30..7479a5c5bcc 100644
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
2.47.3


