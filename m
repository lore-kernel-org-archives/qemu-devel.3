Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4826BC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAwb-0004qa-Q1; Fri, 28 Jun 2024 08:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwV-0004oB-QC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwT-0005fX-AM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57d07f07a27so703178a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578584; x=1720183384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHuZmnhAdWHG3UIOg5pOVL+PmE5Wzgi3P02hFFcB2fk=;
 b=OeBHdPtRwtgq0VJkvuv6b1btbC83mdHxaGT/XsPcS1fVToTe0km/az7/BnUXuaFe5I
 wfZ88GjqN+toKzo1dvRe1RA9QtV0G/OZErezHCtjsyKKQ02DJU174USGrv7/OQN2ecLF
 FoZuSb9q9cPiBot14qTs64B+3MfVbxk2Ak56zr9N5zsHQi2bCjfMboitNMNspcdkgNH0
 /wg88X558gVlw5+0/nXciFbG12YxTpgGqbCGmK/MkTlZ6f3AkNoIp7JnILW6YNU2vFx6
 GPGYn7VL8kJVOGozsMk12f1KJQ/mUSFJsSBLFfMrWKfMWr6VyLsNKQwQL71UK/Z6ZEtD
 1pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578584; x=1720183384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHuZmnhAdWHG3UIOg5pOVL+PmE5Wzgi3P02hFFcB2fk=;
 b=HnpIqizLLETnw3U4CIw5KYck9rsNN5lB4GrKa0/5AqXfVJihXasnAr2GCawx6OwIP+
 tuVkNI8/2PpKYk5GOr/QO0eWfMNy+JJUv2W2Y8NjWAc5iUL8Ee7DWJn5s4v0vwQ9SpkC
 jCgFeOSROXDz3mftCfopCwU5wdQPARGkPzmY9GSBdklTe4M+mgdHoWiA+Mk3mxov9gDy
 fKq/7Sl094F60vRvFcp11vkIlFaOJUZus34xuyDGAkQYLtEOpJjC1R6mWH5In6e1RHMP
 WOjDdd8U1Q9hOW22tWJ/aL8SuC22AbmEuK5eGzjp24d2wgpVm2myx9i1H5/zl1ZQf0Ri
 8inA==
X-Gm-Message-State: AOJu0YwMy41Wb3MPCW9sxtiLw/pjZRRIUKlS8ydZzPxwROwyBmTagStO
 IWFRSw+QNlHhgFMQn/xeIXTS8fdVNlMVKlReQB3NbxnhSPNcTk3eaSqEVG9itX8=
X-Google-Smtp-Source: AGHT+IFe6RsSVULiEZ9TSzaDNcxNpoCit9aWaibpEZa+IWOdNprR2gR92o9RMSSsrQoXiPMK2L7NvQ==
X-Received: by 2002:a05:6402:5216:b0:584:8fcd:260d with SMTP id
 4fb4d7f45d1cf-5848fcd26cfmr4530730a12.3.1719578583395; 
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c834ecsm984261a12.12.2024.06.28.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 577735F9F9;
 Fri, 28 Jun 2024 13:42:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 04/23] tracepoints: move physmem trace points
Date: Fri, 28 Jun 2024 13:42:39 +0100
Message-Id: <20240628124258.832466-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

They don't need to be in the global trace-events file and can have a
local trace header. Also add address_space_map tracepoint for tracking
mapping behaviour.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/physmem.c    | 6 ++++--
 system/trace-events | 6 ++++++
 trace-events        | 5 -----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 33d09f7571..17c9c70f97 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -53,7 +53,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace/trace-root.h"
+#include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
@@ -1885,7 +1885,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     } else { /* list is empty */
         QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
     }
-    ram_list.mru_block = NULL;
+    qatomic_rcu_set(&ram_list.mru_block, NULL);
 
     /* Write list before version */
     smp_wmb();
@@ -3193,6 +3193,8 @@ void *address_space_map(AddressSpace *as,
     MemoryRegion *mr;
     FlatView *fv;
 
+    trace_address_space_map(as, addr, len, is_write, *(uint32_t *) &attrs);
+
     if (len == 0) {
         return NULL;
     }
diff --git a/system/trace-events b/system/trace-events
index 69c9044151..2ed1d59b1f 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -21,6 +21,12 @@ flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 
+# physmem.c
+address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t attrs) "as:%p addr 0x%"PRIx64":%"PRIx64" write:%d attrs:0x%x"
+find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
+find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
+ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
 
diff --git a/trace-events b/trace-events
index dd318ed1af..9cb96f64c4 100644
--- a/trace-events
+++ b/trace-events
@@ -37,11 +37,6 @@ dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
 dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
-# exec.c
-find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
-find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
-ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
-
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
 job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
-- 
2.39.2


