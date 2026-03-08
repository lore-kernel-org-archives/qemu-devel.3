Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C767EF55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8T1-00059I-Cu; Sun, 08 Mar 2026 03:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Re-0002Pa-B9
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:21:00 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Rc-00037Q-4O
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:57 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so12156485eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954455; x=1773559255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkoDc6MBlz/jZoZq6BE9pNkHGRnj/JKNI2l3ZUwxxf8=;
 b=OgiLiqtk9O+r5cDC709PfVwlmecZR6Iyb+dXaj7em+ep+FEYgQmTzRbgI2++32AuGC
 KdStFiarHJNpwXYBVjFb66ljKnDrO56CZ3lN8+VziF3LtPSFFY4yIin+TLJG/gjzJOHR
 +ZuI+WdvBTb29vcwDytuFnq8olbC4VbMKsDMxHhp8OecIqMw5n4i/VFBKB5bs9lFKFP0
 KHU4ob+S9Vx0iARNsoehiMBL7skgHWH2skRMu4h3N7V8NwAAznDiVv8n3ZEEA3YcXvzE
 Ii7QAvTDJMZFNQj21kOz+iYPbufYuDYXWeSl3l4OCZ6Kz8AWVykueoQ6byK5qPlIF9sl
 Atog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954455; x=1773559255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rkoDc6MBlz/jZoZq6BE9pNkHGRnj/JKNI2l3ZUwxxf8=;
 b=sYe5VphNmfUhN3UG5HGcshy4lKuhgZQJ24rl/5VeuURk42caiMj2llZGlrYd/3hIqA
 w3njsEuuvxz6eCWpfIt/Z1o1wsNaIN24aXX6TLYYsPIJWDowmMGV6Bkx0Pk0CldKhHJ5
 sLWaYVa0LDIkiTuMd0TaYAmifLCGrziCrnDyFxzd9/7eL8z4f+zo2gz8mjc/QuZywiH5
 0aA2Mxppp877biwqjvvaNU7An84I/UHkD3WzEJfVftYExikyAQrJN6jdnKWGR2aFVAeD
 xwvPevGyU6igI110mInNNbU4ccKoKM4jauHeWHMrvuRSLMddKVO+kU+nFNFbZe+UAIxJ
 tCsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT/5j2IgyxzHc9I6htDlnXE7L0rd+UuCBM3RZKHr1xoRRMgBiE5Tf1lydge4S9Q29rMIS6BiNG1OOy@nongnu.org
X-Gm-Message-State: AOJu0Yy0EFgvpn2844L1h69CoeNKRAJHzYO5oecBIefy/BhaDKeiBx32
 KS/D7qnr4SGdXLOubTm2pBKOXPhcisifVnolvqZuzdmSZlCXzHJVMHqv
X-Gm-Gg: ATEYQzxpcpgNc25lTMBy45Z4xwl101GcapuuwW+YXnWp1003jhl+NBIV2wzUh1dbC9Z
 cHD0+sbMo526H7unxqDSHDvydKoQ/038Zrc4nSGgG8qCrWKckdLeYbQZbp8bgWoqrzfjKBjdK9O
 WSyISNnQHGhsLkI7iLbOH0RQdAqk0YX5uNwxvaxYalEjT6zYO6WEsEs18vG1yYvUGrj9cQO1HjE
 iaVZD7uJkSI/QD7ku3F5ej3OQ4ayP99PTYGTRk3gd+qBLmaqfKA4DQtCIDmFvrADO7cFRXHsgXx
 XpPkLeUcqTEv4ta/PjopRNx5Zh1kwOj+z33fWl35OeYIBIoCvLpksgD1lrfowCmzqd7JAfE6Jfz
 HVt+cXxRVWlBcApd34W/G0JZFPCLu5dp2vHzPGpfuSGwLNxN756kHA8HkfEaiHNxxLwqW7E2zja
 qU/fYr15FbDa1TsdoJTKxWwyGpWvIsJMZL0C9n6iNnuY8vxg7aFEjD/N2QBIZZYslwWp0Y7xMfD
 ORyn2fN07k9HyhV7ldSAAzOMMI=
X-Received: by 2002:a05:7300:a10b:b0:2be:22b0:8bf3 with SMTP id
 5a478bee46e88-2be4e063a50mr2384586eec.30.1772954454640; 
 Sat, 07 Mar 2026 23:20:54 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:54 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 24/28] tests/qtest: add initial RISC-V Debug Module tests
Date: Sun,  8 Mar 2026 15:17:27 +0800
Message-ID: <18d94d4d321cd011e7d61fffdff3218ad5a23cc7.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the first qtest coverage for the virt Debug Module model.

The new riscv-dm-test binary checks dmactive gating, dmstatus,
hartinfo, and abstractcs reset values, then drives a basic
halt/resume cycle by writing the ROM mailbox words used by the
CPU park loop. Register the test for both riscv32 and riscv64
when CONFIG_RISCV_DM is enabled.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/meson.build     |   7 +-
 tests/qtest/riscv-dm-test.c | 208 ++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/riscv-dm-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d8f326c8b2..faaa7114ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,6 +361,7 @@ F: tests/functional/riscv32
 F: tests/functional/riscv64
 F: tests/tcg/riscv64/
 F: tests/qtest/iommu-riscv-test.c
+F: tests/qtest/riscv-dm-test.c
 
 RISC-V XThead* extensions
 M: Christoph Muellner <christoph.muellner@vrull.eu>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ba9f59d2f8..3bb9e3cc16 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -282,13 +282,16 @@ qtests_s390x = \
    'migration-test']
 
 qtests_riscv32 = \
-  (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
+  (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RISCV_DM') ? ['riscv-dm-test'] : [])
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-   ['iommu-riscv-test'] : [])
+   ['iommu-riscv-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RISCV_DM') ?
+   ['riscv-dm-test'] : [])
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
diff --git a/tests/qtest/riscv-dm-test.c b/tests/qtest/riscv-dm-test.c
new file mode 100644
index 0000000000..c9e3c22a20
--- /dev/null
+++ b/tests/qtest/riscv-dm-test.c
@@ -0,0 +1,208 @@
+/*
+ * QTest for RISC-V Debug Module v1.0
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define DM_BASE                 0x0
+
+#define ROM_HARTID              0x104
+#define ROM_RESUME              0x10c
+
+#define A_DATA0                 0x10
+#define A_DMCONTROL             0x40
+#define A_DMSTATUS              0x44
+#define A_HARTINFO              0x48
+#define A_ABSTRACTCS            0x58
+
+#define DMCONTROL_DMACTIVE      (1u << 0)
+#define DMCONTROL_HALTREQ       (1u << 31)
+#define DMCONTROL_RESUMEREQ     (1u << 30)
+
+#define DMSTATUS_VERSION_MASK   0xf
+#define DMSTATUS_AUTHENTICATED  (1u << 7)
+#define DMSTATUS_ANYHALTED      (1u << 8)
+#define DMSTATUS_ALLHALTED      (1u << 9)
+#define DMSTATUS_ANYRUNNING     (1u << 10)
+#define DMSTATUS_ALLRUNNING     (1u << 11)
+#define DMSTATUS_ANYRESUMEACK   (1u << 16)
+#define DMSTATUS_ALLRESUMEACK   (1u << 17)
+#define DMSTATUS_ANYHAVERESET   (1u << 18)
+#define DMSTATUS_IMPEBREAK      (1u << 22)
+
+#define HARTINFO_DATAADDR_MASK      0xfffu
+#define HARTINFO_DATASIZE_SHIFT     12
+#define HARTINFO_DATASIZE_MASK      (0xfu << HARTINFO_DATASIZE_SHIFT)
+#define HARTINFO_DATAACCESS         (1u << 16)
+#define HARTINFO_NSCRATCH_SHIFT     20
+#define HARTINFO_NSCRATCH_MASK      (0xfu << HARTINFO_NSCRATCH_SHIFT)
+
+#define ABSTRACTCS_DATACOUNT_MASK       0xf
+#define ABSTRACTCS_BUSY                 (1u << 12)
+#define ABSTRACTCS_PROGBUFSIZE_SHIFT    24
+#define ABSTRACTCS_PROGBUFSIZE_MASK     (0x1fu << ABSTRACTCS_PROGBUFSIZE_SHIFT)
+
+static uint32_t dm_read(QTestState *qts, uint32_t reg)
+{
+    return qtest_readl(qts, DM_BASE + reg);
+}
+
+static void dm_write(QTestState *qts, uint32_t reg, uint32_t val)
+{
+    qtest_writel(qts, DM_BASE + reg, val);
+}
+
+static void dm_set_active(QTestState *qts)
+{
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE);
+}
+
+static void rom_write32(QTestState *qts, uint32_t offset, uint32_t val)
+{
+    qtest_writel(qts, DM_BASE + offset, val);
+}
+
+static void sim_cpu_halt_ack(QTestState *qts, uint32_t hartid)
+{
+    rom_write32(qts, ROM_HARTID, hartid);
+}
+
+static void sim_cpu_resume_ack(QTestState *qts, uint32_t hartid)
+{
+    rom_write32(qts, ROM_RESUME, hartid);
+}
+
+static void test_dmactive_gate(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+
+    g_assert_cmpuint(dm_read(qts, A_DMCONTROL), ==, 0);
+    g_assert_cmpuint(dm_read(qts, A_DMSTATUS), ==, 0);
+    g_assert_cmpuint(dm_read(qts, A_HARTINFO), ==, 0);
+    g_assert_cmpuint(dm_read(qts, A_ABSTRACTCS), ==, 0);
+    g_assert_cmpuint(dm_read(qts, A_DATA0), ==, 0);
+
+    dm_write(qts, A_DATA0, 0xdeadbeef);
+    g_assert_cmpuint(dm_read(qts, A_DATA0), ==, 0);
+
+    dm_set_active(qts);
+    g_assert_cmpuint(dm_read(qts, A_DMCONTROL) & DMCONTROL_DMACTIVE, ==,
+                     DMCONTROL_DMACTIVE);
+    g_assert_cmpuint(dm_read(qts, A_DMSTATUS), !=, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_dmstatus(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    uint32_t status;
+
+    dm_set_active(qts);
+    status = dm_read(qts, A_DMSTATUS);
+
+    g_assert_cmpuint(status & DMSTATUS_VERSION_MASK, ==, 3);
+    g_assert_cmpuint(status & DMSTATUS_AUTHENTICATED, ==,
+                     DMSTATUS_AUTHENTICATED);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==,
+                     DMSTATUS_ANYRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ALLRUNNING, ==,
+                     DMSTATUS_ALLRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ANYHALTED, ==, 0);
+    g_assert_cmpuint(status & DMSTATUS_ANYHAVERESET, ==,
+                     DMSTATUS_ANYHAVERESET);
+    g_assert_cmpuint(status & DMSTATUS_IMPEBREAK, ==, DMSTATUS_IMPEBREAK);
+
+    qtest_quit(qts);
+}
+
+static void test_hartinfo(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    uint32_t info;
+
+    dm_set_active(qts);
+    info = dm_read(qts, A_HARTINFO);
+
+    g_assert_cmpuint(info & HARTINFO_DATAADDR_MASK, ==, 0x3c0);
+    g_assert_cmpuint(info & HARTINFO_DATAACCESS, ==, HARTINFO_DATAACCESS);
+    g_assert_cmpuint((info & HARTINFO_DATASIZE_MASK) >>
+                     HARTINFO_DATASIZE_SHIFT, ==, 2);
+    g_assert_cmpuint((info & HARTINFO_NSCRATCH_MASK) >>
+                     HARTINFO_NSCRATCH_SHIFT, ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_abstractcs_config(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    uint32_t acs;
+
+    dm_set_active(qts);
+    acs = dm_read(qts, A_ABSTRACTCS);
+
+    g_assert_cmpuint(acs & ABSTRACTCS_DATACOUNT_MASK, ==, 2);
+    g_assert_cmpuint((acs & ABSTRACTCS_PROGBUFSIZE_MASK) >>
+                     ABSTRACTCS_PROGBUFSIZE_SHIFT, ==, 8);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_halt_resume(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    uint32_t status;
+
+    dm_set_active(qts);
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==,
+                     DMSTATUS_ANYRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ANYHALTED, ==, 0);
+
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_HALTREQ);
+    sim_cpu_halt_ack(qts, 0);
+
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ANYHALTED, ==,
+                     DMSTATUS_ANYHALTED);
+    g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==,
+                     DMSTATUS_ALLHALTED);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==, 0);
+    g_assert_cmpuint(status & DMSTATUS_ALLRUNNING, ==, 0);
+
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_RESUMEREQ);
+    sim_cpu_resume_ack(qts, 0);
+
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ANYRESUMEACK, ==,
+                     DMSTATUS_ANYRESUMEACK);
+    g_assert_cmpuint(status & DMSTATUS_ALLRESUMEACK, ==,
+                     DMSTATUS_ALLRESUMEACK);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==,
+                     DMSTATUS_ANYRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ALLRUNNING, ==,
+                     DMSTATUS_ALLRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ANYHALTED, ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/riscv-dm/dmactive-gate", test_dmactive_gate);
+    qtest_add_func("/riscv-dm/dmstatus", test_dmstatus);
+    qtest_add_func("/riscv-dm/hartinfo", test_hartinfo);
+    qtest_add_func("/riscv-dm/abstractcs-config", test_abstractcs_config);
+    qtest_add_func("/riscv-dm/halt-resume", test_halt_resume);
+
+    return g_test_run();
+}
-- 
2.53.0


