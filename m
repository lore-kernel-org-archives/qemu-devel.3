Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFFBC79FA0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP4-0003un-29; Sun, 06 Sep 2026 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOl-0003f4-7G
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOg-0000A8-38
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+OJEvp6qQtG96GnSpFsdMxDmp6CgUEf9X2LWPZDhGk=;
 b=iR7iS01nVmpnboQ+siRrvEowStiAzEbGhEX8oT1H0dwJfCf9AAUJKcR7i5PKt4N96je6jV
 LA+4v012PzkChbRRO0pefhDLTfM0WLN6Pm9PTWXFndCq+vvRwm90e0OOP1qZSvr0+oh/US
 T9100xqltVdaXUD6AQeOIvHRzq4Asjo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-PXtqv-lNN_OnraOWtWk1Sg-1; Sun,
 06 Sep 2026 13:11:11 -0400
X-MC-Unique: PXtqv-lNN_OnraOWtWk1Sg-1
X-Mimecast-MFC-AGG-ID: PXtqv-lNN_OnraOWtWk1Sg_1788714671
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED7AD18011F6; Sun,  6 Sep 2026 17:11:10 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D35C1955F06; Sun,  6 Sep 2026 17:11:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/40] tests/qtest: Add ASPEED SBC ECDSA engine test
Date: Sun,  6 Sep 2026 19:10:01 +0200
Message-ID: <20260906171021.26568-21-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add a qtest for the ASPEED secure boot controller ECDSA engine. It stages
the public key, signature and SHA-384 digest of a secp384r1 known-answer
vector (from the Linux kernel crypto self-test manager,
ecdsa_nist_p384_tv_template) into the SEC SRAM, triggers the engine's
verify command and checks the status register: a valid signature reports
done + pass, and a tampered signature reports done without pass.

The test is skipped when the crypto backend does not support ECDSA, via
qcrypto_akcipher_supports().

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-sbc-test.c | 194 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   2 +
 2 files changed, 196 insertions(+)
 create mode 100644 tests/qtest/aspeed-sbc-test.c

diff --git a/tests/qtest/aspeed-sbc-test.c b/tests/qtest/aspeed-sbc-test.c
new file mode 100644
index 000000000000..c445dac47a6e
--- /dev/null
+++ b/tests/qtest/aspeed-sbc-test.c
@@ -0,0 +1,194 @@
+/*
+ * QTest testcase for the ASPEED Secure Boot Controller (SBC)
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+#include "crypto/akcipher.h"
+
+/* SBC register block */
+#define SBC_STATUS              0x014
+#define  SBC_ECDSA_VERIFY_PASS  BIT(21)
+#define  SBC_ECDSA_VERIFY_DONE  BIT(20)
+#define SBC_SEC_TRIGGER         0x0bc
+#define  SBC_ECDSA_CMD_TRIGGER  BIT(1)
+
+/*
+ * SEC SRAM operand offsets for a secp384r1 ECDSA verify. Every operand is a
+ * 48-byte big-endian integer.
+ */
+#define ECDSA_SRAM_QX   0x2080
+#define ECDSA_SRAM_QY   0x20c0
+#define ECDSA_SRAM_R    0x21c0
+#define ECDSA_SRAM_S    0x2200
+#define ECDSA_SRAM_M    0x2240
+
+/*
+ * ECDSA secp384r1 / SHA-384 known-answer vector from the Linux kernel crypto
+ * self-test manager (ecdsa_nist_p384_tv_template, sha384 entry in
+ * crypto/testmgr.h, v6.18), decoded into raw big-endian form: public key
+ * Qx || Qy, signature r || s and the SHA-384 message digest.
+ *
+ *   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/crypto/testmgr.h?h=v6.18
+ */
+static const uint8_t ecdsa_p384_pubkey[96] = {
+    /* Qx */
+    0x3a, 0x2f, 0x62, 0xe7, 0x1a, 0xcf, 0x24, 0xd0,
+    0x0b, 0x7c, 0xe0, 0xed, 0x46, 0x0a, 0x4f, 0x74,
+    0x16, 0x43, 0xe9, 0x1a, 0x25, 0x7c, 0x55, 0xff,
+    0xf0, 0x29, 0x68, 0x66, 0x20, 0x91, 0xf9, 0xdb,
+    0x2b, 0xf6, 0xb3, 0x6c, 0x54, 0x01, 0xca, 0xc7,
+    0x6a, 0x5c, 0x0d, 0xeb, 0x68, 0xd9, 0x3c, 0xf1,
+    /* Qy */
+    0x01, 0x74, 0x1f, 0xf9, 0x6c, 0xe5, 0x5b, 0x60,
+    0xe9, 0x7f, 0x5d, 0xb3, 0x12, 0x80, 0x2a, 0xd8,
+    0x67, 0x92, 0xc9, 0x0e, 0x4c, 0x4c, 0x6b, 0xa1,
+    0xb2, 0xa8, 0x1e, 0xac, 0x1c, 0x97, 0xd9, 0x21,
+    0x67, 0xe5, 0x1b, 0x5a, 0x52, 0x31, 0x68, 0xd6,
+    0xee, 0xf0, 0x19, 0xb0, 0x55, 0xed, 0x89, 0x9e,
+};
+
+static const uint8_t ecdsa_p384_signature[96] = {
+    /* r */
+    0x9b, 0x28, 0x68, 0xc0, 0xa1, 0xea, 0x8c, 0x50,
+    0xee, 0x2e, 0x62, 0x35, 0x46, 0xfa, 0x00, 0xd8,
+    0x2d, 0x7a, 0x91, 0x5f, 0x49, 0x2d, 0x22, 0x08,
+    0x29, 0xe6, 0xfb, 0xca, 0x8c, 0xd6, 0xb6, 0xb4,
+    0x3b, 0x1f, 0x07, 0x8f, 0x15, 0x02, 0xfe, 0x1d,
+    0xa2, 0xa4, 0xc8, 0xf2, 0xea, 0x9d, 0x11, 0x1f,
+    /* s */
+    0xfc, 0x50, 0xf6, 0x43, 0xbd, 0x50, 0x82, 0x0e,
+    0xbf, 0xe3, 0x75, 0x24, 0x49, 0xac, 0xfb, 0xc8,
+    0x71, 0xcd, 0x8f, 0x18, 0x99, 0xf0, 0x0f, 0x13,
+    0x44, 0x92, 0x8c, 0x86, 0x99, 0x65, 0xb3, 0x97,
+    0x96, 0x17, 0x04, 0xc9, 0x05, 0x77, 0xf1, 0x8e,
+    0xab, 0x8d, 0x4e, 0xde, 0xe6, 0x6d, 0x9b, 0x66,
+};
+
+static const uint8_t ecdsa_p384_dgst[48] = {
+    0x8d, 0xf2, 0xc0, 0xe9, 0xa8, 0xf3, 0x8e, 0x44,
+    0xc4, 0x8c, 0x1a, 0xa0, 0xb8, 0xd7, 0x17, 0xdf,
+    0xf2, 0x37, 0x1b, 0xc6, 0xe3, 0xf5, 0x62, 0xcc,
+    0x68, 0xf5, 0xd5, 0x0b, 0xbf, 0x73, 0x2b, 0xb1,
+    0xb0, 0x4c, 0x04, 0x00, 0x31, 0xab, 0xfe, 0xc8,
+    0xd6, 0x09, 0xc8, 0xf2, 0xea, 0xd3, 0x28, 0xff,
+};
+
+typedef struct AspeedSBCECDSA {
+    const char *name;
+    QCryptoCurveID curve_id;
+    const uint8_t *pubkey;
+    const uint8_t *signature;
+    const uint8_t *dgst;
+    size_t coord_len;
+} AspeedSBCECDSA;
+
+static const AspeedSBCECDSA sbc_ecdsa_tests[] = {
+    {
+        .name = "secp384r1",
+        .curve_id = QCRYPTO_CURVE_ID_SECP384R1,
+        .pubkey = ecdsa_p384_pubkey,
+        .signature = ecdsa_p384_signature,
+        .dgst = ecdsa_p384_dgst,
+        .coord_len = 48,
+    },
+};
+
+typedef struct AspeedSBCTest {
+    const char *machine;
+    uint32_t sec_addr;
+    uint64_t sram_addr;
+    int index;
+} AspeedSBCTest;
+
+static void sbc_ecdsa_stage(QTestState *qts, const AspeedSBCTest *c,
+                            const AspeedSBCECDSA *t)
+{
+    uint32_t len = t->coord_len;
+
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_QX, t->pubkey, len);
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_QY, t->pubkey + len, len);
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_R, t->signature, len);
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_S, t->signature + len, len);
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_M, t->dgst, len);
+}
+
+/*
+ * Drive one ECDSA verify through the engine the way the firmware does:
+ * stage the operands in the SEC SRAM, trigger the command register and read
+ * back the done/pass bits in the status register.
+ */
+static void test_ecdsa_verify(const void *opaque)
+{
+    const AspeedSBCTest *c = opaque;
+    const AspeedSBCECDSA *t = &sbc_ecdsa_tests[c->index];
+    QCryptoAkCipherOptions opts = {
+        .alg = QCRYPTO_AK_CIPHER_ALGO_ECDSA,
+        .u.ecdsa.curve_id = t->curve_id,
+    };
+    QTestState *qts;
+    uint32_t status;
+    uint8_t bad;
+
+    if (!qcrypto_akcipher_supports(&opts)) {
+        g_test_skip("ECDSA is not supported by the crypto backend");
+        return;
+    }
+
+    qts = qtest_init(c->machine);
+
+    /* A valid signature verifies */
+    sbc_ecdsa_stage(qts, c, t);
+    qtest_writel(qts, c->sec_addr + SBC_SEC_TRIGGER, SBC_ECDSA_CMD_TRIGGER);
+    status = qtest_readl(qts, c->sec_addr + SBC_STATUS);
+    g_assert_cmphex(status & (SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PASS),
+                    ==, SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PASS);
+
+    /* A tampered signature must fail */
+    bad = t->signature[0] ^ 0xff;
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_R, &bad, 1);
+    qtest_writel(qts, c->sec_addr + SBC_SEC_TRIGGER, SBC_ECDSA_CMD_TRIGGER);
+    status = qtest_readl(qts, c->sec_addr + SBC_STATUS);
+    g_assert_cmphex(status & SBC_ECDSA_VERIFY_DONE, ==, SBC_ECDSA_VERIFY_DONE);
+    g_assert_cmphex(status & SBC_ECDSA_VERIFY_PASS, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void aspeed_add_sbc_ecdsa_tests(const char *prefix, const char *machine,
+                                       uint32_t sec_addr, uint64_t sram_addr)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(sbc_ecdsa_tests); i++) {
+        g_autofree char *path = NULL;
+        AspeedSBCTest *t;
+
+        path = g_strdup_printf("%s/sbc/ecdsa/%s", prefix,
+                               sbc_ecdsa_tests[i].name);
+        t = g_new0(AspeedSBCTest, 1);
+        t->machine = machine;
+        t->sec_addr = sec_addr;
+        t->sram_addr = sram_addr;
+        t->index = i;
+        qtest_add_data_func_full(path, t, test_ecdsa_verify, g_free);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    aspeed_add_sbc_ecdsa_tests("ast1030", "-machine ast1030-evb",
+                               0x7e6f2000, 0x79000000);
+
+    aspeed_add_sbc_ecdsa_tests("ast1060", "-machine ast1060-evb",
+                               0x7e6f2000, 0x79000000);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6e7ffcdbd09c..c3593f753049 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -233,6 +233,7 @@ qtests_aspeed = \
   ['aspeed-acry-test',
    'aspeed_gpio-test',
    'aspeed_hace-test',
+   'aspeed-sbc-test',
    'aspeed_scu-test',
    'aspeed_smc-test']
 qtests_aspeed64 = \
@@ -407,6 +408,7 @@ qtests = {
                        crypto],
   'aspeed_hace-test': [files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
                        crypto],
+  'aspeed-sbc-test': [files('aspeed-sbc-test.c'), crypto],
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
   'ast2700-hace-test': [files('aspeed-hace-utils.c', 'ast2700-hace-test.c'),
                         crypto],
-- 
2.55.0


