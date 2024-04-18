Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EEBC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXOP-0007eM-MY; Thu, 18 Apr 2024 15:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOE-0007Yb-C7
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:46 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOC-0007GH-IC
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:46 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a51ddc783e3so143533466b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468341; x=1714073141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rg2JOTw5ouUti560CWKRK7poJqCPTKGwJpqCuG5tVqg=;
 b=UvG7XzXja7W/vpv+RxjXTKd/QJrmfmCasdlRzL7j4UFNjVz+dWb56rIjPtrlz9r4S2
 kTzAClKeIX9oqw1TfXSytPPwuSL/m1H4cuvlvL6/gIk1/AEFYgcqk2/9p/MYxtlKzXZi
 D/FL/PutDeDnt0anMkXIvQF06JV47wMOKLt7rIhAIpTIqFWV+K1sP1GFZ5Chy9/BDSSO
 MQFqk8yxgw/5AdikOLmqsFfn4CNcNxgwyActLZeB5YT7xVFgNucDK4i3I0tPmEXmPOb7
 BHLMwsaynffcNJJFBchrzbmwFsKO95z3ZxYzHBGOBYNbc8GQwU3S6wvxTjGqOHVX6Oep
 oH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468341; x=1714073141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rg2JOTw5ouUti560CWKRK7poJqCPTKGwJpqCuG5tVqg=;
 b=keFN8BQbDX6e7UJx3gHnipJun6g1Ak1jnDO+D8T01lexJcEDPK7mxkfRDkIjeDdji6
 GtE7XRSVftWBFFaMCZSVxqUxjWR/l9V+3Ea5w8l1oDNPXHaP9ixbHpofOfjTjnhZnlDW
 hKGQkiAy8V7o/dzoHD0LZLCGiCJemxPaYGTHMUntWO9qbuc/+S2u4efwwf+uWimFEtIz
 PI/Jmix+GeYuegKnzOnPF7g17GUFKUNJGWsCTzz1TV1/MdVhuJsEr5uaLQs30GiZjt5A
 q8bgDrNKaOj4zcMEsePuwhnfG0Oo4f7SqkNlDF/HBnSAYThpasgAgSCCROmmJD1Bnf5o
 +VJg==
X-Gm-Message-State: AOJu0YyKJiX+CsxNH41qvnBe/ZnMRxI7Y8L5+fXUDeU2coymyfvz2fF3
 xvIqgyGVoaKrshIZOyzR4W9zxnpsD3dQNFXZobII3xSIOCGC/SURv+5IkbrRfV32QYFpdfnHdn/
 B
X-Google-Smtp-Source: AGHT+IGASUllNpo0Va0P2dkaALouSNHWQpdA0Wzw0LXpl6pAHWuJa2Joj8M3jDkvfPrz+ilPpgnX1w==
X-Received: by 2002:a17:906:2591:b0:a52:6cb2:9347 with SMTP id
 m17-20020a170906259100b00a526cb29347mr49043ejb.8.1713468341444; 
 Thu, 18 Apr 2024 12:25:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 hx12-20020a170906846c00b00a5582324219sm68524ejc.16.2024.04.18.12.25.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:25:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 02/24] exec: Declare CPUBreakpoint/CPUWatchpoint type in
 'breakpoint.h' header
Date: Thu, 18 Apr 2024 21:25:01 +0200
Message-ID: <20240418192525.97451-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The CPUBreakpoint and CPUWatchpoint structures are declared
in "hw/core/cpu.h", which contains declarations related to
CPUState and CPUClass. Some source files only require the
BP/WP definitions and don't need to pull in all CPU* API.
In order to simplify, create a new "exec/breakpoint.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/breakpoint.h | 23 +++++++++++++++++++++++
 include/hw/core/cpu.h     | 16 +---------------
 target/arm/internals.h    |  1 +
 target/ppc/internal.h     |  1 +
 target/riscv/debug.h      |  2 ++
 5 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 include/exec/breakpoint.h

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
new file mode 100644
index 0000000000..45038263e3
--- /dev/null
+++ b/include/exec/breakpoint.h
@@ -0,0 +1,23 @@
+#ifndef EXEC_BREAKPOINT_H
+#define EXEC_BREAKPOINT_H
+
+#include "qemu/queue.h"
+#include "exec/vaddr.h"
+#include "exec/memattrs.h" //MemTxAttrs
+
+typedef struct CPUBreakpoint {
+    vaddr pc;
+    int flags; /* BP_* */
+    QTAILQ_ENTRY(CPUBreakpoint) entry;
+} CPUBreakpoint;
+
+typedef struct CPUWatchpoint {
+    vaddr vaddr;
+    vaddr len;
+    vaddr hitaddr;
+    MemTxAttrs hitattrs;
+    int flags; /* BP_* */
+    QTAILQ_ENTRY(CPUWatchpoint) entry;
+} CPUWatchpoint;
+
+#endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5f0422493b..6f5a16e0fc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,6 +22,7 @@
 
 #include "hw/qdev-core.h"
 #include "disas/dis-asm.h"
+#include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
@@ -347,21 +348,6 @@ typedef struct CPUNegativeOffsetState {
     bool can_do_io;
 } CPUNegativeOffsetState;
 
-typedef struct CPUBreakpoint {
-    vaddr pc;
-    int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUBreakpoint) entry;
-} CPUBreakpoint;
-
-struct CPUWatchpoint {
-    vaddr vaddr;
-    vaddr len;
-    vaddr hitaddr;
-    MemTxAttrs hitattrs;
-    int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUWatchpoint) entry;
-};
-
 struct KVMState;
 struct kvm_run;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index dd3da211a3..a7c5ec1849 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -25,6 +25,7 @@
 #ifndef TARGET_ARM_INTERNALS_H
 #define TARGET_ARM_INTERNALS_H
 
+#include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "syndrome.h"
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 5b20ecbd33..601c0b533f 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -18,6 +18,7 @@
 #ifndef PPC_INTERNAL_H
 #define PPC_INTERNAL_H
 
+#include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 
 /* PM instructions */
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 5794aa6ee5..c347863578 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -22,6 +22,8 @@
 #ifndef RISCV_DEBUG_H
 #define RISCV_DEBUG_H
 
+#include "exec/breakpoint.h"
+
 #define RV_MAX_TRIGGERS         2
 
 /* register index of tdata CSRs */
-- 
2.41.0


