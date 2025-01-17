Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E3EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpXc-0004Fd-GH; Fri, 17 Jan 2025 11:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXZ-0004D6-J3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:49 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXX-0001Ej-Ki
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B96C2124A;
 Fri, 17 Jan 2025 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egkqiUdcl/1o5gN6c9wxmbbtscH/gM7mMCyj63nHiW8=;
 b=DJ2iwv0QfL8NLYEtu7G9U+10kqdG64AfqGIezIuAYi+NZRqM89Mz2Phko8Lr4kll5OOfoV
 CWI4gFnxz7Q7enikz2OaK1aXreW17tVqA+0FUhQpZIRW0MG5Ix3DRNYfCxHGAkSQrBNdbR
 74R0aYYXOZzdJlKV+j6u7P1mBqGa7VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egkqiUdcl/1o5gN6c9wxmbbtscH/gM7mMCyj63nHiW8=;
 b=xlELgvCPGM2Pbrv/+HF6qBuLAsJf4j2GZvQ6B+XJAenLIDa/mTNcBbbXrGd338n33ckjAu
 wmKg1Z7XJcLrrHBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DJ2iwv0Q;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xlELgvCP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egkqiUdcl/1o5gN6c9wxmbbtscH/gM7mMCyj63nHiW8=;
 b=DJ2iwv0QfL8NLYEtu7G9U+10kqdG64AfqGIezIuAYi+NZRqM89Mz2Phko8Lr4kll5OOfoV
 CWI4gFnxz7Q7enikz2OaK1aXreW17tVqA+0FUhQpZIRW0MG5Ix3DRNYfCxHGAkSQrBNdbR
 74R0aYYXOZzdJlKV+j6u7P1mBqGa7VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egkqiUdcl/1o5gN6c9wxmbbtscH/gM7mMCyj63nHiW8=;
 b=xlELgvCPGM2Pbrv/+HF6qBuLAsJf4j2GZvQ6B+XJAenLIDa/mTNcBbbXrGd338n33ckjAu
 wmKg1Z7XJcLrrHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A624613332;
 Fri, 17 Jan 2025 16:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eK6dGCaKimftQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jan 2025 16:49:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Ivan Klokov <ivan.klokov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 2/5] tests/qtest: QTest example for RISC-V CSR register
Date: Fri, 17 Jan 2025 13:49:33 -0300
Message-Id: <20250117164936.22223-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250117164936.22223-1-farosas@suse.de>
References: <20250117164936.22223-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B96C2124A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

Added demo for reading CSR register from qtest environment.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build      |  2 +-
 tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index edd53ec995..94b28e5a53 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -274,7 +274,7 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
-qtests_riscv64 = \
+qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
 qos_test_ss = ss.source_set()
diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
new file mode 100644
index 0000000000..ff5c29e6c6
--- /dev/null
+++ b/tests/qtest/riscv-csr-test.c
@@ -0,0 +1,56 @@
+/*
+ * QTest testcase for RISC-V CSRs
+ *
+ * Copyright (c) 2024 Syntacore.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define CSR_MVENDORID       0xf11
+#define CSR_MISELECT        0x350
+
+static void run_test_csr(void)
+{
+    uint64_t res;
+    uint64_t val = 0;
+
+    QTestState *qts = qtest_init("-machine virt -cpu veyron-v1");
+
+    res = qtest_csr_call(qts, "get_csr", 0, CSR_MVENDORID, &val);
+
+    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpint(val, ==, 0x61f);
+
+    val = 0xff;
+    res = qtest_csr_call(qts, "set_csr", 0, CSR_MISELECT, &val);
+
+    g_assert_cmpint(res, ==, 0);
+
+    val = 0;
+    res = qtest_csr_call(qts, "get_csr", 0, CSR_MISELECT, &val);
+
+    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpint(val, ==, 0xff);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/cpu/csr", run_test_csr);
+
+    return g_test_run();
+}
-- 
2.35.3


