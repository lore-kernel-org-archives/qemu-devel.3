Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D8FC35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 07:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tszfl-0002ML-8e; Fri, 14 Mar 2025 03:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tszfj-0002LQ-Ev
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:41:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tszfh-0007f2-BP
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:41:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22355618fd9so36256045ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741938091; x=1742542891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loRbL1QacVm6MsP7dUN2VAmZuHSFiZwpkSE40StNMUQ=;
 b=I89XPBnkxjq4iDS+qJzpkv7dKscurVRzGpJGbLIFHjrKJly/qgNYHSpA/p1VMSJxsy
 2myXxx8PbIwzckR1pYyu3Q9ME/q7mHY+SxHHjBILKWGiJ4KgJXrehBNcpthageQla6ir
 4vyt6wjD6T8Ray3aB1JuOoTHI4vxs1WQN4jjoFVwm55CfMa10s147CWVf48nIoSd/XoG
 HrtYfgdNo5lfU8VaMGvk9/eNDx2NXMAaraITyqgcUyKVn677uBFCVEajeTT5giT/XGzg
 ISD1zdGf/gS7DE8h6+MAvkkRSVaSB4FtUrjtAip9C11qpeY1J0IwgJSYumJWVYB3ZjeV
 KpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741938091; x=1742542891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loRbL1QacVm6MsP7dUN2VAmZuHSFiZwpkSE40StNMUQ=;
 b=wbXLsePpjJQDDN4X6rXcZTsYL4HqMURLOdc3gipeVxniv1dC5ipQOoNzodd3vKG0sT
 RKgkVtJrU9pKrHGJDUdsglqknk9jDQ89FSMBpzAdJlq76ML00RlcMYpOJ0bBDUqcnPKt
 /bCwA6MaxIDZRyXm4N96cUAv8CZyebeOPalk6ujmpKDnpKPN9HOlUuxb/UwcdT/NE3vS
 NJpWfU95pDDqeaiKPdKD9yMcIVaKTfk3ZUcSr+YOpo9FJqaw1sJhe1789B1wFGS+X/yL
 J/pj9AwU1K96v3NhYXygOji8DnqqMvcDab84kofEItqxr49qWHkqNRM9poPLGd8s6OFb
 NyLw==
X-Gm-Message-State: AOJu0YwUwLWqrGFNt15QE0d0W1bUirOsFdHGPpRPD+HaSLNGwKtX6+bT
 kjyMXpimMPG1WrA/gE0QjAV3Y/ruhQy8v8zVLD8JLjYE90dOxUCs4iDpZoP0
X-Gm-Gg: ASbGnctheJbUP5geQXLU6PPJwQthZFwZsy9mXuDzX6o2cO49GZSOoiJlQKeH9HaW+DU
 ruhVu/zBVAo+MVjjBJvba4PMKg4v/rgGCe0F1aVf5pMwe689uoGh1ccloLWWNDjA0ZyrUPsCktf
 N5Y3PmdX5lwWv0Mz/YHWtJdaAYiLZGMQZUhBpz27zPaLC9gAS++1jJ9JyZ6ZXJ6k89sjv0u5juP
 jvjijejAxYUpwljg5HZS3PpG/7V8a301sqU2BbZI4lnVLNA5zLB49pq+afGdm64gon0TQvY+uGn
 0EMd19aBdebCKSA7X0B/XKAPmrNeSoDx1+CEUnlSCHLhOWA=
X-Google-Smtp-Source: AGHT+IEHC/XZzbckZsnxPs/RyJu+KVf1yNM8xqh9yrPBoRgzYJlJ2hb/1De5uzbgTqjBMtE+xm3FfA==
X-Received: by 2002:a17:902:fc44:b0:220:eade:d77e with SMTP id
 d9443c01a7336-225e0aef1f3mr22356805ad.40.1741938091251; 
 Fri, 14 Mar 2025 00:41:31 -0700 (PDT)
Received: from wheely.local0.net ([1.146.112.81])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688857esm24322315ad.17.2025.03.14.00.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 00:41:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 2/2] memory: suppress INVALID_MEM logs caused by debug access
Date: Fri, 14 Mar 2025 17:41:07 +1000
Message-ID: <20250314074107.992163-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250314074107.992163-1-npiggin@gmail.com>
References: <20250314074107.992163-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

Debugger-driven invalid memory accesses are not guest errors, so should
not cause these error logs.

Debuggers can access memory wildly, including access to addresses not
specified by the user (e.g., gdb it might try to walk the stack or load
target addresses to display disassembly). Failure is reported
synchronously by the GDB protcol so the user can be notified via the
debugger client.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 system/memory.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4c829793a0a..960f66e8d7e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1412,18 +1412,23 @@ bool memory_region_access_valid(MemoryRegion *mr,
 {
     if (mr->ops->valid.accepts
         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
-        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
-                      ", size %u, region '%s', reason: rejected\n",
-                      is_write ? "write" : "read",
-                      addr, size, memory_region_name(mr));
+        if (attrs.debug) {
+            /* Don't log memory errors due to debugger accesses */
+            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
+                          ", size %u, region '%s', reason: rejected\n",
+                          is_write ? "write" : "read",
+                          addr, size, memory_region_name(mr));
+        }
         return false;
     }
 
     if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
-        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
-                      ", size %u, region '%s', reason: unaligned\n",
-                      is_write ? "write" : "read",
-                      addr, size, memory_region_name(mr));
+        if (attrs.debug) {
+            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
+                          ", size %u, region '%s', reason: unaligned\n",
+                          is_write ? "write" : "read",
+                          addr, size, memory_region_name(mr));
+        }
         return false;
     }
 
@@ -1434,13 +1439,15 @@ bool memory_region_access_valid(MemoryRegion *mr,
 
     if (size > mr->ops->valid.max_access_size
         || size < mr->ops->valid.min_access_size) {
-        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
-                      ", size %u, region '%s', reason: invalid size "
-                      "(min:%u max:%u)\n",
-                      is_write ? "write" : "read",
-                      addr, size, memory_region_name(mr),
-                      mr->ops->valid.min_access_size,
-                      mr->ops->valid.max_access_size);
+        if (attrs.debug) {
+            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
+                          ", size %u, region '%s', reason: invalid size "
+                          "(min:%u max:%u)\n",
+                          is_write ? "write" : "read",
+                          addr, size, memory_region_name(mr),
+                          mr->ops->valid.min_access_size,
+                          mr->ops->valid.max_access_size);
+        }
         return false;
     }
     return true;
-- 
2.47.1


