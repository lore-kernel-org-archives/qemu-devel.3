Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640CBC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2pt-0004RK-P3; Mon, 17 Mar 2025 01:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2pq-0004QZ-C4
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 01:16:24 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2po-0007GE-Qo
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 01:16:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225a28a511eso62648215ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742188578; x=1742793378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ru+v8+TSkO8ijlhkTjCbMPy4tOSoCgmnNPF3C22VuCs=;
 b=Ljn6elzygw1Z9Xy37BkTh+02knw7joUCgQKGG4Ht4kyIXBNtw6Xo+a5QgtXSzMP72y
 CC46lF9B2O5xX00BBS+R/zI9xBOsnAzQDduuZ5gFN20rRAUxdFSb8Vw7ZDAviNabDZBy
 sLAcdJtliz4zJzc/bsWGSBZlMAInmtebgSNqkCAFXUznIiZ9hFqDZFUjjJdh9r6Vy3bq
 l+BrLIz35+CGrzK0/BhjJHl7hfMgEGz1jW2UHYQymkaGAiAQM7Es6BMXNjcknN9XTDpP
 iE1xtkUkTqDqPtbViBazq15iCygaPfweEBHG2xZlZa5/XiwNsPTiymmPMtKIxOCdDGK7
 E0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742188578; x=1742793378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ru+v8+TSkO8ijlhkTjCbMPy4tOSoCgmnNPF3C22VuCs=;
 b=cCuBvoMI27nYixWj/CTT0kgqtwrq012JPI3REWn1rLTJDsIGyA6hdfer5mXBvM4Wyo
 VB9nePv899R+rS3W5lhhp004x8V3bUKJ/xXZdXZMHgjB4/BQAQnYgGhh/+lc1Bh0f8qS
 iBVgiCl38umeM4PaL/xhb7vnCO5a3AsLoF/2Ptbco+xL9GqdsgZgOkEN07khIFYLz8Z/
 5v8xrzQQ/xNtOtK4G0W/u3FiXBq55+321qMMBSoyCkucbdqtCBXkTfQeC9hMRftREJZi
 4RFk5ZBiAou3DAkxNzd39jPRkYMjn/oW2Zos8ruhbeIf8sBTtM7Tt5L8rInITmXeEV1A
 NjUQ==
X-Gm-Message-State: AOJu0YwHePcS/wDuLoCbw9d6GnKglr2iCUPH1OcdIo6jhaK6oaWtq+te
 YedO/ectz7QTr+HVSFw7TgDRBM4MzAF/m8gcpPommNHQnzejdim2NXbw0Q==
X-Gm-Gg: ASbGnct0QwCXbyend0Yh0V1nUjrsxpEwvr3ArFcGp/xAhuZKHB5+89OGMhHFogdmxVd
 pbEkDHBqHHQpaumSYUh6F3HsA/ManDRMD62PsVz1L+QZiXS5Blu7f2Gnezxp1MroJ+0PoImPrPE
 jbP5sV8t2O3lyE2loe2llkspK2p6w29UvhhJ5Nz8r0xYwFrFVQUPWTiCTofLgWjg0NH4Wsslt7Y
 RO5v8jXCsLS21I5dcWfg1f8uqWlXSXUoAYY8BaHtzitHlu3lHRWXWc+5E8oBQHY8zQzXhP/b6aK
 5TWcxIfl8Kv+51rU4V8/BsyPk1/66mt0FwY+qBQWbT+7Gk89hQ==
X-Google-Smtp-Source: AGHT+IEFedUkCglN7NFKE0ceoqqNJMtUZzQLmRVOjZa97pHXnhL1hJfFnzNyEckE+AUkpV9Y701Kew==
X-Received: by 2002:a05:6a21:168d:b0:1f5:8d8f:27aa with SMTP id
 adf61e73a8af0-1f5c1126c74mr14441286637.8.1742188578473; 
 Sun, 16 Mar 2025 22:16:18 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711564cf1sm6544163b3a.72.2025.03.16.22.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:16:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/2] gdbstub: Improve physical memory access handling
Date: Mon, 17 Mar 2025 15:16:03 +1000
Message-ID: <20250317051605.1108128-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317051605.1108128-1-npiggin@gmail.com>
References: <20250317051605.1108128-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Bring gdb's physical memory access handling up to speed with the CPU
memory access, by setting MemTxAttribute.debug=1, and by checking for
memory transaction errors.

GDB with PhyMemMode will now report failure for memory access outside
valid system memory addresses, and it is also able to write to ROMs as
it can with virtual memory access.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 gdbstub/system.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index dd22ff0fb3a..6a550e229e2 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -17,6 +17,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
+#include "exec/address-spaces.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "system/accel-ops.h"
@@ -453,16 +454,30 @@ void gdb_qemu_exit(int code)
  */
 static int phy_memory_mode;
 
+/*
+ * Like cpu_memory_rw_debug but it operates on the system address space
+ * rather than the CPU's view of memory.
+ */
+static int phys_memory_rw_debug(hwaddr addr, void *buf,
+                                hwaddr len, bool is_write)
+{
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    MemTxResult res;
+
+    attrs.debug = 1;
+    res = address_space_rw(&address_space_memory, addr, attrs,
+                           buf, len, is_write);
+    if (res != MEMTX_OK) {
+        return -1;
+    }
+    return 0;
+}
+
 int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
     if (phy_memory_mode) {
-        if (is_write) {
-            cpu_physical_memory_write(addr, buf, len);
-        } else {
-            cpu_physical_memory_read(addr, buf, len);
-        }
-        return 0;
+        return phys_memory_rw_debug(addr, buf, len, is_write);
     }
 
     if (cpu->cc->memory_rw_debug) {
-- 
2.47.1


