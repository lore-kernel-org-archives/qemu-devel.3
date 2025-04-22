Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JLo-0000pq-8d; Tue, 22 Apr 2025 15:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLU-0008RK-7l
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLR-0006aX-As
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22438c356c8so59088945ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350307; x=1745955107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D18VcATJhF8EFEqTXXDGcua3PJA4kTwRczbppkM1bEY=;
 b=PNMp0MPNJsnzvWgo21PNpCubqA6bxV4oTfzHnlnuSEwetVgDKIaaBCbrXPCdoAJKxT
 KS+MnKKj2Cy43XbR49KOvY1nStkV8y+0jYJkCSFgPfbw1Tf9Kf1qnHAeXhalLCQlaxnV
 D3eJxuiSr66NjKAy6DkcV/8l4Frl1zQFRYu0h2ekQRWDUeLDWrU9m1hlsYqQocLl4UGB
 avtqbceLScQPy0j6BFVfopeZgYavaN/ZYUKx64eLD0verB6pc+FFRmwsXWecXtYbKEXA
 tYBJT0gl6S7a9EO8ZtTOIzy3fXCV6sG/sh7ofyBfIs8ZzVOCREwb76KZ532HpeoFt1Cl
 fuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350307; x=1745955107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D18VcATJhF8EFEqTXXDGcua3PJA4kTwRczbppkM1bEY=;
 b=cTtLCCOPYMsWk6Tt/pdWubuTnxNsPQdGyq9sDM6kzdC54g7deznjAMz12PXaryQWfw
 ZKVFIk04wgIRKYLmntXaz4V+vufRx0Kd02JbGkzOlP/lmFRzmEc8MNERcTFS8ilFC8Gd
 wloR4R5l96ujGanx351VTc/nE2HlPG/owmV+mujhJqBP3nHN/z/SZzA3KZ2uoXC1TfYZ
 u2mej97qJ/rWQfZWrj08dZCcgyK0K73C8RlhZuNTlY5ctYo4lY6E8wSloDR7ntBt3WOk
 2UYRtkU1WHJaJbRvrFwfgsjX0JX5ku575UmqJN9pIHi9jjTbF8VonSMFZDu6HCGL9kP7
 vYFg==
X-Gm-Message-State: AOJu0YwdzDiLTV4ugAgNOtbzI3T5mx7XQ/2PlwNS1W60R3IQshsufWmq
 6Dg9CKq5N14xISewo6Iz6eD8ABpJprgfEYkzQVCfIQ0tZ5NwIDmq5p9HQbFN2UMlA4JXsy7uP+T
 Y
X-Gm-Gg: ASbGncuXmNiogWjqBJo+RjRsqQHExBVEHtwgKHgfsEcG7kBZqOAGps+jAgKFS/hkrae
 6h5utzWWgiAw6i7bqpc2l2a6ziAwaqAg8N7s0ZoAYKolUpfmsAuvUu7uGqu2tigRKr95oHr5lMD
 KWFNUzdKIajzkQf97fdF61VYwnTSQHKwQglx8IOmMATpIc766gSJD/tkDGMnk56ZRmBXAvQ6+db
 GDqoC3MkHYUVljxRaAflFh6dCcU6nt58d5alpnRAFL+NVr8fAV+aCZ6xK9H3xliPRsZe2Y+lZiE
 D09V9ntG0CJakH9mRFjlrlgiBaTQKBA+lGxl+jYJGZvCzIX2gh2zqt0zxhmNfnzhfo+ZMUinlX8
 =
X-Google-Smtp-Source: AGHT+IFi2gOqrZWXIZ2s3xc4AD/2pNQDdy4Sfmt/zXrxwzlOuT5NRtXB9ivtXdWU20g5oHSjoZhPFw==
X-Received: by 2002:a17:903:11c6:b0:215:b75f:a1cb with SMTP id
 d9443c01a7336-22c53573db0mr239222625ad.9.1745350307616; 
 Tue, 22 Apr 2025 12:31:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 040/147] exec: Restrict memory-internal.h to system/
Date: Tue, 22 Apr 2025 12:26:29 -0700
Message-ID: <20250422192819.302784-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Only file units within the system/ directory need access to
"memory-internal.h". Restrict its scope by moving it there.

The comment from commit 9d70618c684 ("memory-internal.h:
Remove obsolete claim that header is obsolete") is now obsolete,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317161329.40300-3-philmd@linaro.org>
---
 {include/exec => system}/memory-internal.h | 6 ------
 system/memory.c                            | 4 ++--
 system/physmem.c                           | 3 ++-
 MAINTAINERS                                | 2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)
 rename {include/exec => system}/memory-internal.h (88%)

diff --git a/include/exec/memory-internal.h b/system/memory-internal.h
similarity index 88%
rename from include/exec/memory-internal.h
rename to system/memory-internal.h
index c75178a3d6..085e81a9fe 100644
--- a/include/exec/memory-internal.h
+++ b/system/memory-internal.h
@@ -11,12 +11,6 @@
  *
  */
 
-/*
- * This header is for use by exec.c, memory.c and accel/tcg/cputlb.c ONLY,
- * for declarations which are shared between the memory subsystem's
- * internals and the TCG TLB code. Do not include it from elsewhere.
- */
-
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
diff --git a/system/memory.c b/system/memory.c
index 6a5d853071..7e2f16f4e9 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -24,8 +24,6 @@
 #include "qemu/qemu-print.h"
 #include "qom/object.h"
 #include "trace.h"
-
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
@@ -35,6 +33,8 @@
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
 
+#include "memory-internal.h"
+
 //#define DEBUG_UNASSIGNED
 
 static unsigned memory_region_transaction_depth;
diff --git a/system/physmem.c b/system/physmem.c
index 307d0764b6..16cf557d1a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -66,7 +66,6 @@
 #include "qemu/main-loop.h"
 #include "system/replay.h"
 
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 
 #include "qemu/pmem.h"
@@ -88,6 +87,8 @@
 #include <daxctl/libdaxctl.h>
 #endif
 
+#include "memory-internal.h"
+
 //#define DEBUG_SUBPAGE
 
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
diff --git a/MAINTAINERS b/MAINTAINERS
index e0dc64aa3e..c7083ab1d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3116,7 +3116,7 @@ F: system/ioport.c
 F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
-F: include/exec/memory-internal.h
+F: system/memory-internal.h
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
-- 
2.43.0


