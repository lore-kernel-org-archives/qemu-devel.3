Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A80C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSY7T-0001S7-He; Wed, 24 Jan 2024 02:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7S-0001Rl-8H
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:22 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7P-0005ST-M1
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:22 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a3082d450adso312069666b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082978; x=1706687778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGEZ+UuvywEJsfyGGnlTWqRmH+qv3Bs4CRVZRGITqsY=;
 b=vORECSnxiN7LOZfyCygpaLV5zOFahBtHgieiPedPKBsFmPbBaQ6tTNpzWq857tT6Vi
 LzL6PiQ62eOsbrMOlxmG5nfyiAr63FwiDbu/9wth4CfQtAVJTCQWe+KUn7uBGjKm/bzT
 /p82vCNvvRcaCHNtuvpYRNqrsmkQERqPuZ3hoXsEmumLxV12kcOfA/qOC3bgkc9twyoY
 C29l6pF79HqGMGRorhyEgakYMnepRcYTub+HV1iG9yGrTMdZnQZIfBvDJX5TourJ+eaG
 jp2iRlXOAPb+PHOWtDlap5L9mFFUjkIGwAy4pDPqD5MgJfURNY1t+TX86XYn56roRFpC
 ew7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082978; x=1706687778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGEZ+UuvywEJsfyGGnlTWqRmH+qv3Bs4CRVZRGITqsY=;
 b=hcp1wfvSO/l1C00lqHumR6h2QcGQrxBI3rWjkr+y488ptgzfq7AFHgCgTPhA4jDvsE
 EbVs2lBDHGKQPUYLc6yfrXnQDvaUngVLCzQlnr5M1iKp0wPoxYqVATn2MG/Pe2lXO5Vx
 n87Id3hNWZx99IoNZWWyjQ2zrsGz5SyBCRVjQlzutgqr1q8IBBX+Z/NC2Tcdt/l7jhku
 PPwomeCdoy05ZNPIex2TI12iKrgR6fGWkEtnldHkVxrEqS5mryLJeBlztNEtOJ4C1VWO
 pl4tVaik0RTqfGbB3I6EqZY8OYNLsekoJzjNlXE1v6GoMYs9DOcvvSfwGjkqTUUQs3wx
 fqCg==
X-Gm-Message-State: AOJu0YzfhpIR6hVyxvszk6tt0TZXcgHpCjXNvdotrxAitxqz+BLG1zeL
 KZNe6dvJlU2Tuew8NHaxqIQLpG6lyM/BdU8ZkI981Eql0JFEkqquv7We3yCCR3A75ZBy9Jxb9OX
 A
X-Google-Smtp-Source: AGHT+IFC2tRkJnE2epzGJPIFIsv+8KzmxuQxGiZXzegOkoOMmLR1KiTcHR5yOCQOcrVFcrDnOu1uqQ==
X-Received: by 2002:a17:907:d309:b0:a31:35c2:9238 with SMTP id
 vg9-20020a170907d30900b00a3135c29238mr116943ejc.107.1706082977941; 
 Tue, 23 Jan 2024 23:56:17 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 cu15-20020a170906ba8f00b00a2ec877d3a6sm8212455ejd.167.2024.01.23.23.56.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:56:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 1/4] target: Make qemu_target_page_mask() available for
 *-user
Date: Wed, 24 Jan 2024 08:56:06 +0100
Message-ID: <20240124075609.14756-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124075609.14756-1-philmd@linaro.org>
References: <20240124075609.14756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently qemu_target_page_mask() is usable only from the softmmu
code. Make it possible to use it from the *-user code as well.

Make use of it in perf.c.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20231208003754.3688038-2-iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/perf.c       |  3 ++-
 system/physmem.c       |  5 -----
 target/target-common.c | 10 ++++++++++
 target/meson.build     |  2 ++
 4 files changed, 14 insertions(+), 6 deletions(-)
 create mode 100644 target/target-common.c

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index cd1aa99a7e..ba75c1bbe4 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "elf.h"
+#include "exec/target_page.h"
 #include "exec/exec-all.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
@@ -335,7 +336,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
+            q[insn].address |= (guest_pc & qemu_target_page_mask());
         } else {
 #if defined(TARGET_I386)
             q[insn].address -= tb->cs_base;
diff --git a/system/physmem.c b/system/physmem.c
index cc68a79763..5e66d9ae36 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3431,11 +3431,6 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
-int qemu_target_page_mask(void)
-{
-    return TARGET_PAGE_MASK;
-}
-
 int qemu_target_page_bits(void)
 {
     return TARGET_PAGE_BITS;
diff --git a/target/target-common.c b/target/target-common.c
new file mode 100644
index 0000000000..903b10cfe4
--- /dev/null
+++ b/target/target-common.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/target_page.h"
+
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
diff --git a/target/meson.build b/target/meson.build
index a53a60486f..dee2ac47e0 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -19,3 +19,5 @@ subdir('sh4')
 subdir('sparc')
 subdir('tricore')
 subdir('xtensa')
+
+specific_ss.add(files('target-common.c'))
-- 
2.41.0


