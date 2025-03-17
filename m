Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43484C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2px-0004Ro-EX; Mon, 17 Mar 2025 01:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2pu-0004RM-1I
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 01:16:26 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2ps-0007Gd-6K
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 01:16:25 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so2155403a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742188582; x=1742793382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdm1TFTjCSrFPt9xCmwN5Gf1cvoenzJnQeIBQnWfFyU=;
 b=hyznmYhMUlDzAvVOtQSbYvB/8bArqjWo5TmbiaYjbisurSHNfl+/NnR2fwjVJvEEFd
 B/lXf3ejN/s/JtQTkSFt5LQPhaXo9dy5QSV8dnX6qHsDL4EjahsNfWKLX21kMFdrE2z7
 xrDQB+krlI39IVjAuILMX5J/SIFh4OAmPCng9RzX8/rvfhGRlpo88cTCAXK73FbOUa8m
 iwvR8NimH/Yo0fskOD2OHAqWr0QSahct8X23MyNA4IQhoMKsT6sxHC9SDYbGSA5O921i
 tX/HBlWRwyBbsv395C6uuVnAxozIqCPRrvrF959qDw1Q5+8fubZ0ZE43/Ei8mJhuy0Yk
 mcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742188582; x=1742793382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mdm1TFTjCSrFPt9xCmwN5Gf1cvoenzJnQeIBQnWfFyU=;
 b=mb9vGDpQnuc+Lmc6bWJFlSRYyRzueTs5pHn20tRd2D0tg1SMesTGtV6b9BUu1rrZn3
 RfLYJT+n72CESWAjHZtHVQ4aXNeQmmIY9QKjsSXKHj9oTpU5Kk8Q9zSR4NZiEzM4A9Sd
 s7qhWQ/c3WCuKuL1jgnjX5tZ86w4VJR4bcZOWkf3Vjr3PypFJCNZVrNB/wmkLxNs3Wlo
 ZkFshdhsnPMPYReT6mCRyIFxqzxnBa+4lupaAM2YqycDSizfyZ6UglqihSZTVjVQz7gn
 JGHhraWLLcV64h7xq/df0oNII0PgvdWhfRkzEKaqB/cgFz39Nyx2zuud6dbNh+iZHan8
 ml3g==
X-Gm-Message-State: AOJu0Yxwq9eJA8V1xe67GL1Y6G9itXnOf9A49ackWazrdqd/cq0QWVQJ
 OCofiOb5s+BRO2A3HQ+a3t5/jM+qiIQM1L6eOi/5mQ22/Q4DOvRVpJb3Jw==
X-Gm-Gg: ASbGncsTKMdN+UPzzLFn30MAKWJwwVf4Md0OUtkHFYwCdQPVz16tqqW2rgpipKbJQrT
 LCywyZAIqYFKkvwoiqv+SFajIEcE6mR5Q4R7SwE3cXRKhx3B4R04LMi3eqSpvX0fq6bqPAw9UsB
 VkezkjSZrOos6931LX9YhRr+ue75wKQqAJk4Ksj/UuwzPz3XnXEXuDi9sF2BZCiXnUiVE8v2AKt
 NfI/pH7Gr29hkcq6vL9ruZvoTb4lY7RkEQvY/TcYb+5xzD9Zj+beie/tCezq6MomQe6kJkqXWMt
 uz9ZpQufzQ9es2GmVEiRiiRMfDbSWJggWweDuMEtPdL9xVrYhPPIVW/fB5yf
X-Google-Smtp-Source: AGHT+IHb/eN3OjV+UfukHKGl8jgr1Lqg6p1gxw37pnc/2+ix/MFTvCYew/jZy5T3gRzsTfa30zNyqQ==
X-Received: by 2002:a05:6a21:62c8:b0:1ee:e96a:d9ed with SMTP id
 adf61e73a8af0-1f5c11242ffmr18461220637.7.1742188582391; 
 Sun, 16 Mar 2025 22:16:22 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711564cf1sm6544163b3a.72.2025.03.16.22.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:16:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/2] memory: suppress INVALID_MEM logs caused by debug
 access
Date: Mon, 17 Mar 2025 15:16:04 +1000
Message-ID: <20250317051605.1108128-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317051605.1108128-1-npiggin@gmail.com>
References: <20250317051605.1108128-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
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

Reviewed-by: David Hildenbrand <david@redhat.com>
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


