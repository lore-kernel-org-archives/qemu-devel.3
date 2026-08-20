Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79406C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2Rs-0000Mq-O7; Thu, 20 Aug 2026 09:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wx2RU-00009D-It
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wx2RS-0006mk-WF
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cc891373e0so26035295ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787231062; x=1787835862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7yS/0giiUDXne7qukcztmfwnfi+ZSQS0WX/E61pcERI=;
 b=dYm81o4ziD1i/1cnFx4dBNyGdrdqYYZxu561FkgTjmwYL0nWZEdoP4SsifLjcxJSK5
 7sFA3D61C1b1RMH52nNRbakj5SHQYRHLNkcMJXaSfozHtbXnXIcPtPIblEYg4vUpjbn+
 NEtPrb1VHkplb0OB6ASXVZhPPLpdx8Z6NTGmoOTp5a6v6N3b0ETIvwuViSeTHuyKwTl9
 lQ0rQGmdWJxUTW6YNMCUbyerHd5uoD1ujHtOoMU4312vgeqdWRT1eirr+Pvgt+nE0X+I
 LwRTpzXVcmp8d4kojlsUUNAJzLBvm7MKEusCKqZ6mafs3aqukCaQapiHrIA1mEyvJnuh
 QZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231062; x=1787835862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7yS/0giiUDXne7qukcztmfwnfi+ZSQS0WX/E61pcERI=;
 b=QIYlihZImVvF7JoBPUV0Zx+0zCmBZEFni+fcRBy4ICwtKWrFPfJ2zHUI8y2xeaBcH5
 7gXS/6epyiJvDprUkcU6gs6mnSBBELQx1uFok/RYtS4+k8TDLykksjsyMpXe5x8oHhxR
 AcpfDc/88lM0kPKzY5O5b8VFQwDoY4XxDDuYSSmYoISwHBvcOq9D9YK15eZ1YbPiZhlI
 djMCP4hAEKcbTkRbFsyM82JmoqgAfrWRzG51kzKepuP/NKdRKYVcXnqZcu1HAe2LmsIV
 oLeg3vkKMbTgwOVwJykUs3y79XpMm1p/Bl+rYymlo3E56X7enNPedSHk7Y3FwIrJjvGu
 ao4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4q36ia4K68cDUsXW3jSzLFTJpX7JqRjySBciKrFSvC92WuSpUE7j2b2yFWQBsRCnXi+6IRG60F536@nongnu.org
X-Gm-Message-State: AFuF++niHC28jfwtkc2ALIJzJAjOVvOo/NQkZ9PEeth8uSFlxUVvtgqv
 cKKgnSmKAPUgxVWfQSaIj7KEAM3Cgs8jJWFiuV8jeKWfccaoSo6uKt8/
X-Gm-Gg: AR+sD13rZrBPM49fcYWbvH/nwRCQKkPdgijzhZ5+GL8oJIePeuxiXFmx8lHezhdalG/
 fDTPsuApRLBj3oNxONHkqVNNS0yk9BI1E/JwSr/y0Wpbu5zKBF66EOzS1Gb39wrKBjMp/uQi8R4
 vUI87TH1RnmwQ/3iuA33+rp8qKX9/22BNRUT2THdcbjplj1i9h1iz9EwJzcT4PTi5iCpuZNM3oD
 v7RILE0U5w773oMaRXp52IwFzTD2DS8wwzS6T5eJJdQZh9cHi8NC1bwj5UQPVGy+hch3QhxrL4A
 1DkgzG9EsL9+tgaKQ0EXheereHMDt02ooW08zwCpc4VEPwPMqYQl4D0i3Wxa4ZS0hdm+4dkUvO3
 vgvmw6O+WLFbstt3WwDrdxLKYNItFnulw2c4jF45w+nG9NC1ZjdsEHlpomVxYlLZKVjkpeHUDMu
 POZwOK0SgZVLIHwL8V4HW7tI6ByYHUzpIf/zklZC8Y5jouYJXVk1U1DnVoE8guEsRexPVz+MJhS
 UWmRPSvGH5rXl31Pej1dPsfE/7N5xS0orqvkdBZCa9Ham1sQ7ypOm07MbLu6KzmZMc7pjVTjbc0
 j+S5IyoFwSbfhsZVniSVPQ==
X-Received: by 2002:a17:90b:390c:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3958110c03emr19944382a91.10.1787231061400; 
 Thu, 20 Aug 2026 06:04:21 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf6849sm6451915a91.10.2026.08.20.06.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:04:20 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/tcg/riscv64: Add intrinsics version of test-rvv-ldst
Date: Thu, 20 Aug 2026 22:32:21 +0930
Message-ID: <20260820130223.2762-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260820130223.2762-1-joel@jms.id.au>
References: <20260820130223.2762-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A C userspace program to perform vector loads and stores that cross page
boundaries, and check the result.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/riscv64/test-rvv-ldst-intrinsics.c | 66 ++++++++++++++++++++
 tests/tcg/riscv64/Makefile.target            | 12 +++-
 2 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-intrinsics.c

diff --git a/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c b/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
new file mode 100644
index 000000000000..3dbc8624700a
--- /dev/null
+++ b/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
@@ -0,0 +1,66 @@
+/*
+ * RISC-V vector load/store test, including accesses that cross a page
+ * boundary. Intrinsics version of test-rvv-ldst.S.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <riscv_vector.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#define MAX_PAGE_SIZE 65536
+#define NUM_BYTES 16
+
+struct cross_page {
+    uint8_t pad[MAX_PAGE_SIZE - NUM_BYTES / 2];
+    uint8_t data[NUM_BYTES];
+};
+
+/* Page aligned so the within-page cases never cross a boundary */
+static const uint8_t src_data[NUM_BYTES]
+    __attribute__((aligned(MAX_PAGE_SIZE))) = {
+    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+    0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
+};
+
+static const struct cross_page src_cross
+    __attribute__((aligned(MAX_PAGE_SIZE))) = {
+    .data = {
+        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+        0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
+    },
+};
+
+static uint8_t dst_data[NUM_BYTES] __attribute__((aligned(MAX_PAGE_SIZE)));
+static struct cross_page dst_cross __attribute__((aligned(MAX_PAGE_SIZE)));
+
+static void vec_copy(uint8_t *dst, const uint8_t *src, int code)
+{
+    size_t vl = __riscv_vsetvl_e8m1(NUM_BYTES);
+    if (vl != NUM_BYTES) {
+        exit(code);
+    }
+
+    vuint8m1_t v = __riscv_vle8_v_u8m1(src, vl);
+    __riscv_vse8_v_u8m1(dst, v, vl);
+
+    if (memcmp(dst, src, NUM_BYTES)) {
+        exit(code);
+    }
+}
+
+int main(void)
+{
+    /* Case 1: load/store within a page */
+    vec_copy(dst_data, src_data, 1);
+
+    /* Case 2: the load straddles a page boundary */
+    vec_copy(dst_data, src_cross.data, 2);
+
+    /* Case 3: the store straddles a page boundary */
+    vec_copy(dst_cross.data, src_data, 3);
+
+    return 0;
+}
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 68a5ec525598..3c6cd4937cad 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -14,10 +14,11 @@ TESTS += test-aes
 run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
 
 # Vector load test
-TESTS += test-rvv-ldst
-test-rvv-ldst: CFLAGS += -march=rv64gcv
+TESTS += test-rvv-ldst test-rvv-ldst-intrinsics
+test-rvv-ldst-intrinsics test-rvv-ldst: CFLAGS += -march=rv64gcv
 test-rvv-ldst: LDFLAGS = -nostdlib -static
-run-test-rvv-ldst: QEMU_OPTS += -cpu max
+test-rvv-ldst-intrinsics: LDFLAGS = -static
+run-test-rvv-ldst-intrinsics run-test-rvv-ldst: QEMU_OPTS += -cpu max
 
 # Re-run the vector tests at each supported VLEN
 TEST_RVV_VLENS = 128 256 512 1024
@@ -26,6 +27,11 @@ run-test-rvv-ldst-vlen%: test-rvv-ldst
 	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) -cpu max$(COMMA)vlen=$* $<, \
 		test-rvv-ldst with vlen=$*)
 
+EXTRA_RUNS += $(patsubst %,run-test-rvv-ldst-intrinsics-vlen%,$(TEST_RVV_VLENS))
+run-test-rvv-ldst-intrinsics-vlen%: test-rvv-ldst-intrinsics
+	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) -cpu max$(COMMA)vlen=$* $<, \
+		test-rvv-ldst-intrinsics with vlen=$*)
+
 # Test for fcvtmod
 TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
-- 
2.53.0


