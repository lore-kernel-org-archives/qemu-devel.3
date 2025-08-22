Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCBCCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSDa-00060w-3j; Fri, 22 Aug 2025 09:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO2E-0006HD-5E
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:26:11 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO27-0007Kh-4M
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:26:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b4716fa7706so1246860a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1755854760; x=1756459560;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4ze1BLKJzZuVnqxNymG670NaM+4LDJ76LZIGkYOHPQ=;
 b=SSrfO2TSftR/oSYszHwaH8TvzMz/lJfkMLVAptCHjFonviGAuXcmGJ3FrQQQ2m2FNu
 6jO+XNG+QvQfDQPRN7nAAegthyGOM6zElOp4Ofa8ziwGNxgXgfgntaZQGGg9I9+GA2Ve
 iJBEHfdTXolZnPzTTGN5GtVFJCvIJhJAEyIUW12Jyh/1Vv8zIana0eVsdieK/wq+n8Z/
 H09YpWtiV2B5sU6SexC96Aixcl1MTQfHdS/1fE84xJ7NyY94AAS6niNKP7LG+bZFg+zN
 DE1PMmVIo+Z51ESUrfkdSZTCdjxNzSMZTMoHXr+RwVYYGkvZmFGehVxVK2cf+I4KooB9
 w/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854760; x=1756459560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4ze1BLKJzZuVnqxNymG670NaM+4LDJ76LZIGkYOHPQ=;
 b=vQqnuDusek+kh8hnYb71KKLNdH/jJEc+YLnLZWsGdobrOiKpL8wuIa0D9oW7W8KZrJ
 F71G55/rEyHhd69Q0nPJxxmGun5E2vxBVNk8QztCfU9ZgWuUc+c//1bPzVhhiG5bwW+X
 EtQY4xZTfrHoUru9iNH2OttJAm/6N37rgjWg8eLTxNFZiRYV6f6HJ5Liz3dY/t/Fbo+s
 H4+TVYefcUXYAUHuf+/G7uCM30pDmJ0ZI23bCOBk+oio/+Hpj6Vbvzt9jonn+PC6AmKw
 bVvY33H+ySFYZnLXYWu57FtvEzDA1dOxjscK4TmqLzwF1GOJLIh4Z6YKp8OIEXHRqc1I
 EEGg==
X-Gm-Message-State: AOJu0Yz9nQZ4xG5BK5oz+RtaGO3vTioFwW7eP48F/Cbl8rILGCnzXerg
 yxk167+Ta/GJqHeCmKtkCCcghBlA0gY00m1rCDingCti65qtGrUa25BRN3DuNFfN4cnl1Enu8V7
 xdvZKPHw=
X-Gm-Gg: ASbGncsp9+8xQqX7g2d75KS9wdfgdtNLUq3JN80/F/PEL+6dpaGx3Xpk7t07Q7RukA4
 cc5+O5aI5GBWo2mLr0KIEB/H75rqKVh+k+jxMqmY+yzpSl9B/jiTcXv6hSkfK/zCbP3edDu4G/d
 Q1PF7E4DN8v1mfHx80uzUS0gRUXtw1FxoEDLC2YrVgWes4d9oNRzx3pYIsKlW/fLT3Ao5X76bRS
 03TLqiAwCcsgfvooS4RdDEuepU7VJuvSJK60be5stOgSNiUZPSigqftv7e6Td1UZeQw18EkMejj
 g2bDmFGk0U5o9CAaS2ru70qsbwyihgLwSRfglxW/VqSbpc8C5/QQgnilrWALxdIb7oUH163uArB
 ktYoXXya37THme3Ap7RtC5UEPlIeL9oq/fUEkjStZFrQ726CVhgK+
X-Google-Smtp-Source: AGHT+IGpWxGAbGJaVIwLElF7OV0p0FwtlYPpgPzH8Y1mB7NywDt9vua8AdmQEkhAbWmmluT7TOFgQA==
X-Received: by 2002:a17:903:1b4b:b0:245:fbf8:dd0b with SMTP id
 d9443c01a7336-2462efd4ec2mr32896205ad.57.1755854759890; 
 Fri, 22 Aug 2025 02:25:59 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4c6fb7sm78560215ad.89.2025.08.22.02.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 02:25:59 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, CJ Chen <cjchen@igel.co.jp>
Subject: [PATCH RFC v2 9/9] tests/qtest: add test for memory region access
Date: Fri, 22 Aug 2025 18:24:10 +0900
Message-Id: <20250822092410.25833-10-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822092410.25833-1-cjchen@igel.co.jp>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=cjchen@igel.co.jp; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Aug 2025 09:53:59 -0400
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

From: Tomoyuki Hirose <hrstmyk811m@gmail.com>

This commit adds a qtest for accessing various memory regions. The
qtest checks the correctness of handling the access to memory regions
by using 'memaccess-testdev'.

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Co-developed-by: CJ Chen <cjchen@igel.co.jp>
Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
---
 tests/qtest/memaccess-test.c | 597 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   9 +
 2 files changed, 606 insertions(+)
 create mode 100644 tests/qtest/memaccess-test.c

diff --git a/tests/qtest/memaccess-test.c b/tests/qtest/memaccess-test.c
new file mode 100644
index 0000000000..7e90028ea0
--- /dev/null
+++ b/tests/qtest/memaccess-test.c
@@ -0,0 +1,597 @@
+/*
+ * QEMU memory region access test
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Author: Tomoyuki HIROSE <hrstmyk811m@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#include "hw/misc/memaccess-testdev.h"
+
+static const char *arch = "";
+static const hwaddr base = 0x200000000;
+
+struct arch2cpu {
+    const char *arch;
+    const char *cpu_model;
+};
+
+static struct arch2cpu cpus_map[] = {
+    /* tested targets list */
+    { "arm", "cortex-a15" },
+    { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
+    { "x86_64", "qemu64,apic-id=0" },
+    { "i386", "qemu32,apic-id=0" },
+    { "alpha", "ev67" },
+    { "cris", "crisv32" },
+    { "m68k", "m5206" },
+    { "microblaze", "any" },
+    { "microblazeel", "any" },
+    { "mips", "4Kc" },
+    { "mipsel", "I7200" },
+    { "mips64", "20Kc" },
+    { "mips64el", "I6500" },
+    { "or1k", "or1200" },
+    { "ppc", "604" },
+    { "ppc64", "power8e_v2.1" },
+    { "s390x", "qemu" },
+    { "sh4", "sh7750r" },
+    { "sh4eb", "sh7751r" },
+    { "sparc", "LEON2" },
+    { "sparc64", "Fujitsu Sparc64" },
+    { "tricore", "tc1796" },
+    { "xtensa", "dc233c" },
+    { "xtensaeb", "fsf" },
+    { "hppa", "hppa" },
+    { "riscv64", "rv64" },
+    { "riscv32", "rv32" },
+    { "rx", "rx62n" },
+    { "loongarch64", "la464" },
+};
+
+static const char *get_cpu_model_by_arch(const char *arch)
+{
+    for (int i = 0; i < ARRAY_SIZE(cpus_map); i++) {
+        if (!strcmp(arch, cpus_map[i].arch)) {
+            return cpus_map[i].cpu_model;
+        }
+    }
+    return NULL;
+}
+
+static QTestState *create_memaccess_qtest(void)
+{
+    QTestState *qts;
+
+    qts = qtest_initf("-machine none -cpu \"%s\" "
+                      "-device memaccess-testdev,address=0x%" PRIx64,
+                      get_cpu_model_by_arch(arch), base);
+    return qts;
+}
+
+static void little_b_valid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void little_b_invalid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void little_w_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1133);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x3355);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x5577);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x7799);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x99bb);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xbbdd);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xddff);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x2200);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x4422);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x6644);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x8866);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0xaa88);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xccaa);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xeecc);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    }
+}
+
+static void little_w_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    }
+}
+
+static void little_l_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x3377bbff);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x77bbff01);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xbbff0189);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0xff0189fe);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x0189fe76);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x89fe7654);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0xfe765432);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0xcc884400);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x67cc8844);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xef67cc88);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0x98ef67cc);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x1098ef67);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x321098ef);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0x54321098);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    }
+}
+
+static void little_l_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    }
+}
+
+static void little_q_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x77fffe01decabefa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfffe01decabeface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xfe01decabefacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0x01decabefacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xdecabefacefeedfa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xcabefacefeedface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xbefacefeedfacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0xedfebeefef108800);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfeedfebeefef1088);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xcefeedfebeefef10);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0xfacefeedfebeefef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xedfacefeedfebeef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xfeedfacefeedfebe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xcefeedfacefeedfe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    }
+}
+
+static void little_q_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    }
+}
+
+static void big_b_valid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void big_b_invalid(QTestState *qts, uint64_t offset)
+{
+    qtest_writeb(qts, base + offset + 0, 0x00);
+    qtest_writeb(qts, base + offset + 1, 0x11);
+    qtest_writeb(qts, base + offset + 2, 0x22);
+    qtest_writeb(qts, base + offset + 3, 0x33);
+    qtest_writeb(qts, base + offset + 4, 0x44);
+    qtest_writeb(qts, base + offset + 5, 0x55);
+    qtest_writeb(qts, base + offset + 6, 0x66);
+    qtest_writeb(qts, base + offset + 7, 0x77);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 0), ==, 0x00);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 1), ==, 0x11);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 2), ==, 0x22);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 3), ==, 0x33);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 4), ==, 0x44);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 5), ==, 0x55);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 6), ==, 0x66);
+    g_assert_cmphex(qtest_readb(qts, base + offset + 7), ==, 0x77);
+}
+
+static void big_w_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1133);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x3355);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x5577);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x7799);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x99bb);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xbbdd);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xddff);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 1, 0x3322);
+        qtest_writew(qts, base + offset + 2, 0x5544);
+        qtest_writew(qts, base + offset + 3, 0x7766);
+        qtest_writew(qts, base + offset + 4, 0x9988);
+        qtest_writew(qts, base + offset + 5, 0xbbaa);
+        qtest_writew(qts, base + offset + 6, 0xddcc);
+        qtest_writew(qts, base + offset + 7, 0xffee);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x2200);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 1), ==, 0x4422);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x6644);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 3), ==, 0x8866);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0xaa88);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 5), ==, 0xccaa);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0xeecc);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 7), ==, 0xffee);
+    }
+}
+
+static void big_w_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    } else {
+        qtest_writew(qts, base + offset + 0, 0x1100);
+        qtest_writew(qts, base + offset + 2, 0x3322);
+        qtest_writew(qts, base + offset + 4, 0x5544);
+        qtest_writew(qts, base + offset + 6, 0x7766);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 0), ==, 0x1100);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 2), ==, 0x3322);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 4), ==, 0x5544);
+        g_assert_cmphex(qtest_readw(qts, base + offset + 6), ==, 0x7766);
+    }
+}
+
+static void big_l_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x3377bbff);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x77bbff01);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xbbff0189);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0xff0189fe);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x0189fe76);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x89fe7654);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0xfe765432);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 1, 0x77665544);
+        qtest_writel(qts, base + offset + 2, 0xbbaa9988);
+        qtest_writel(qts, base + offset + 3, 0xffeeddcc);
+        qtest_writel(qts, base + offset + 4, 0x01234567);
+        qtest_writel(qts, base + offset + 5, 0x89abcdef);
+        qtest_writel(qts, base + offset + 6, 0xfedcba98);
+        qtest_writel(qts, base + offset + 7, 0x76543210);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0xcc884400);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 1), ==, 0x67cc8844);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 2), ==, 0xef67cc88);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 3), ==, 0x98ef67cc);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x1098ef67);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 5), ==, 0x321098ef);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 6), ==, 0x54321098);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 7), ==, 0x76543210);
+    }
+}
+
+static void big_l_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    } else {
+        qtest_writel(qts, base + offset + 0, 0x33221100);
+        qtest_writel(qts, base + offset + 4, 0x77665544);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 0), ==, 0x33221100);
+        g_assert_cmphex(qtest_readl(qts, base + offset + 4), ==, 0x77665544);
+    }
+}
+
+static void big_q_valid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x77fffe01decabefa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfffe01decabeface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xfe01decabefacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0x01decabefacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xdecabefacefeedfa);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xcabefacefeedface);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xbefacefeedfacefe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        qtest_writeq(qts, base + offset + 1, 0xffeeddccbbaa9988);
+        qtest_writeq(qts, base + offset + 2, 0xfedcba9876543210);
+        qtest_writeq(qts, base + offset + 3, 0x0123456789abcdef);
+        qtest_writeq(qts, base + offset + 4, 0xdeadbeefdeadbeef);
+        qtest_writeq(qts, base + offset + 5, 0xcafebabecafebabe);
+        qtest_writeq(qts, base + offset + 6, 0xbeefcafebeefcafe);
+        qtest_writeq(qts, base + offset + 7, 0xfacefeedfacefeed);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0xedfebeefef108800);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 1), ==,
+                        0xfeedfebeefef1088);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 2), ==,
+                        0xcefeedfebeefef10);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 3), ==,
+                        0xfacefeedfebeefef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 4), ==,
+                        0xedfacefeedfebeef);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 5), ==,
+                        0xfeedfacefeedfebe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 6), ==,
+                        0xcefeedfacefeedfe);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 7), ==,
+                        0xfacefeedfacefeed);
+    }
+}
+
+static void big_q_invalid(QTestState *qts, hwaddr offset)
+{
+    if (qtest_big_endian(qts)) {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    } else {
+        qtest_writeq(qts, base + offset + 0, 0x7766554433221100);
+        g_assert_cmphex(qtest_readq(qts, base + offset + 0), ==,
+                        0x7766554433221100);
+    }
+}
+
+#define DEFINE_test_memaccess(e, e_u, w, w_u, v, v_u)                   \
+    static void                                                         \
+    test_memaccess_##e##_##w##_##v(void)                                \
+    {                                                                   \
+        QTestState *qts;                                                \
+        qts = create_memaccess_qtest();                                 \
+        if (!qts) {                                                     \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        for (size_t i = OFF_IDX_OPS_LIST_##e_u##_##w_u##_##v_u;         \
+             i < OFF_IDX_OPS_LIST_##e_u##_##w_u##_##v_u +               \
+                 N_OPS_LIST_##e_u##_##w_u##_##v_u;                      \
+             i++) {                                                     \
+            e##_##w##_##v(qts, MEMACCESS_TESTDEV_REGION_SIZE * i);      \
+        }                                                               \
+                                                                        \
+        qtest_quit(qts);                                                \
+    }
+
+DEFINE_test_memaccess(little, LITTLE, b, B, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, w, W, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, l, L, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, q, Q, valid, VALID)
+DEFINE_test_memaccess(little, LITTLE, b, B, invalid, INVALID)
+DEFINE_test_memaccess(little, LITTLE, w, W, invalid, INVALID)
+DEFINE_test_memaccess(little, LITTLE, l, L, invalid, INVALID)
+DEFINE_test_memaccess(little, LITTLE, q, Q, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, b, B, valid, VALID)
+DEFINE_test_memaccess(big, BIG, w, W, valid, VALID)
+DEFINE_test_memaccess(big, BIG, l, L, valid, VALID)
+DEFINE_test_memaccess(big, BIG, q, Q, valid, VALID)
+DEFINE_test_memaccess(big, BIG, b, B, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, w, W, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, l, L, invalid, INVALID)
+DEFINE_test_memaccess(big, BIG, q, Q, invalid, INVALID)
+
+#undef DEFINE_test_memaccess
+
+static struct {
+    const char *name;
+    void (*test)(void);
+} tests[] = {
+    {"little_b_valid", test_memaccess_little_b_valid},
+    {"little_w_valid", test_memaccess_little_w_valid},
+    {"little_l_valid", test_memaccess_little_l_valid},
+    {"little_q_valid", test_memaccess_little_q_valid},
+    {"little_b_invalid", test_memaccess_little_b_invalid},
+    {"little_w_invalid", test_memaccess_little_w_invalid},
+    {"little_l_invalid", test_memaccess_little_l_invalid},
+    {"little_q_invalid", test_memaccess_little_q_invalid},
+    {"big_b_valid", test_memaccess_big_b_valid},
+    {"big_w_valid", test_memaccess_big_w_valid},
+    {"big_l_valid", test_memaccess_big_l_valid},
+    {"big_q_valid", test_memaccess_big_q_valid},
+    {"big_b_invalid", test_memaccess_big_b_invalid},
+    {"big_w_invalid", test_memaccess_big_w_invalid},
+    {"big_l_invalid", test_memaccess_big_l_invalid},
+    {"big_q_invalid", test_memaccess_big_q_invalid},
+};
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    arch = qtest_get_arch();
+
+    for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+        g_autofree gchar *path = g_strdup_printf("memaccess/%s", tests[i].name);
+        qtest_add_func(path, tests[i].test);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..5d721b2c60 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -95,6 +95,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +      \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
@@ -138,6 +139,7 @@ qtests_x86_64 = qtests_i386
 
 qtests_alpha = ['boot-serial-test'] + \
   qtests_filter + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
 qtests_avr = [ 'boot-serial-test' ]
@@ -162,6 +164,7 @@ qtests_microblazeel = qtests_microblaze
 
 qtests_mips = \
   qtests_filter + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
@@ -172,6 +175,7 @@ qtests_mips64el = qtests_mips
 qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   (config_all_accel.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
   (config_all_accel.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
@@ -198,6 +202,7 @@ qtests_sparc = ['prom-env-test', 'm48t59-test', 'boot-serial-test'] + \
 
 qtests_sparc64 = \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) +       \
   qtests_filter + \
   ['prom-env-test', 'boot-serial-test']
 
@@ -248,6 +253,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
@@ -263,6 +269,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
@@ -279,9 +286,11 @@ qtests_s390x = \
    'migration-test']
 
 qtests_riscv32 = \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
 qtests_riscv64 = ['riscv-csr-test'] + \
+  (config_all_devices.has_key('CONFIG_MEMACCESS_TESTDEV') ? ['memaccess-test'] : []) + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
 qos_test_ss = ss.source_set()
-- 
2.25.1


