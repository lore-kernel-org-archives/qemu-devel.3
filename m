Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1713CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSK-0003UI-Ss; Sat, 04 Oct 2025 03:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSI-0003To-LI
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSG-0004sX-Qo
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so27952155e9.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759561999; x=1760166799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KHkbePhkbzKsxDMSg1uIeJwujfjDCu0ba4WcfqHxU8U=;
 b=yxe/jn0MXt4cCWxtlLJNoz0Z1p38Ing2tg73BtPoL+5R+cnuXDnUDU9TKPx3dOuMCa
 I08mfeKyfSRnHsquaW9gEWYKNNL2RxArJ0bxauZB5J2zn+GVUz91gfUnMfAUrofmYQjq
 RpfGEUXAsNHpciJCQ9ZcmedZSUsH8DxV8TvKz5HH0oaTKHWz/HhJnIjad0Ni/eWLxUdB
 yxLnSCEVzKPjpdPaB3VdJvx1wdhaqgS+OsL9t8plpU/WCaumKsIVggRY4RQRKXp/cS84
 /MeqUhoPDJvibee65WbEn3Hnquagx6BWuzxtP1WsdiKZBFtolKVUQztXCbi280aPfWfl
 oE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759561999; x=1760166799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHkbePhkbzKsxDMSg1uIeJwujfjDCu0ba4WcfqHxU8U=;
 b=j9Jy+uAcFGmReW+Tvk+J4gljTvhcvrTszu+UDAIaqA3rM3cJ7BBzp6c2tKifWyEteR
 thmcULFaz4yhTkSNXXiigS8Yjxe3e2bzwMzi/+y21bNdAizn/P9KfE7ScvM5vKnLtAiA
 UTj4HnWtA4+MAXodD/6425/NGjED4+vD68xaRh1nDd2c5KeEzHPLc5bD0ZGFSBgQv5Zs
 gADP0ded0GTzrdc7V/vAXjfjRRe+gU6j7ZPjWngm39N3EsoF8IkkoVhDoJlCIP0iIlsX
 YOVoDAAICJIhPMQ+XNyuXtjIlBzv20EScNpg9Va3siTB3dinicmZxBTJ+lyx5nHmmItt
 JnUA==
X-Gm-Message-State: AOJu0YySx15RzMQ0vuV2sPheIoZDKSLCAcmUTxWJHkGWACFePxdLyMLB
 Ne5KqxAGYp20UcUWZ5dNju8h08ImRJ66yga0tzzsCVtbtzEmbr3SlfFUzPck0cwfls6YDljdc3m
 yvhblOfZL6g==
X-Gm-Gg: ASbGncsnRANOL1SKdL/sJ/WOsWOg7H4BR2jtK4K3jcje4h1KIIlvW+gSI6kb0+Qg9Pc
 uUjnNvm/aZHDerircwpRrOrZVb7KPGi2vvMvcXUCcABjd2Lic/erfoL4xQecZL+qbm3KyiuimYl
 +4uXjAy/Xp66R9oyixEcFxdxFioGmXTLdgWecmQx0sPeDXhPaVbTH/tQRNcWaTnGBQvXBQnwlkP
 izOTgEZfctgtsqTJU0v/2zyGD92mervQjXjfzqYSr79xXsYgbpuUNJ3rvWsdijNvKESL5EAdze6
 kChnJHoxaXVbVscqNuiBmBFY1oI6pJdveY5sdji6ahLRGX3Xcvr+sZjr6JqLmJpGC8TccaBsnL6
 8SgvthhbKNR3HUvveVv1CHjJgG0nBu/9CVemr5rgUPQ9rFQ/u2ifMF6Q+ta7wZDv64AiPgnWV99
 t7fQWu7MLAP2Ok3heTUrawDxSY
X-Google-Smtp-Source: AGHT+IHxEoa+BPtYpNMS3R1sbNRrgwaAyE/6skcG/oPTNHTAOgk6OtU+78vyuFPWwA+luBDsg23Rvg==
X-Received: by 2002:a05:6000:604:b0:424:211a:4141 with SMTP id
 ffacd0b85a97d-42567165eabmr3529810f8f.27.1759561998579; 
 Sat, 04 Oct 2025 00:13:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a022d8sm151072685e9.12.2025.10.04.00.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] system/ramblock: Move ram_block_is_pmem() declaration
Date: Sat,  4 Oct 2025 09:12:28 +0200
Message-ID: <20251004071307.37521-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Move ramblock_is_pmem() along with the RAM Block API
exposed by the "system/ramblock.h" header. Rename as
ram_block_is_pmem() to keep API prefix consistency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20251002032812.26069-3-philmd@linaro.org>
---
 include/system/ram_addr.h | 2 --
 include/system/ramblock.h | 5 +++++
 migration/ram.c           | 3 ++-
 system/physmem.c          | 5 +++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 15a1b1a4fa2..53c0c8c3856 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -99,8 +99,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
     return host_addr_offset >> TARGET_PAGE_BITS;
 }
 
-bool ramblock_is_pmem(RAMBlock *rb);
-
 /**
  * qemu_ram_alloc_from_file,
  * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 8999206592d..7059b20d919 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -108,4 +108,9 @@ void ram_block_attributes_destroy(RamBlockAttributes *attr);
 int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
                                       uint64_t size, bool to_discard);
 
+/**
+ * ram_block_is_pmem: Whether the RAM block is of persistent memory
+ */
+bool ram_block_is_pmem(RAMBlock *rb);
+
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 7208bc114fb..91e65be83d8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -53,6 +53,7 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "system/cpu-throttle.h"
+#include "system/ramblock.h"
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
@@ -4367,7 +4368,7 @@ static bool ram_has_postcopy(void *opaque)
 {
     RAMBlock *rb;
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        if (ramblock_is_pmem(rb)) {
+        if (ram_block_is_pmem(rb)) {
             info_report("Block: %s, host: %p is a nvdimm memory, postcopy"
                          "is not supported now!", rb->idstr, rb->host);
             return false;
diff --git a/system/physmem.c b/system/physmem.c
index ae8ecd50ea1..3766fae0aba 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -43,6 +43,7 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/qtest.h"
+#include "system/ramblock.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -1804,7 +1805,7 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 
 #ifdef CONFIG_LIBPMEM
     /* The lack of support for pmem should not block the sync */
-    if (ramblock_is_pmem(block)) {
+    if (ram_block_is_pmem(block)) {
         void *addr = ramblock_ptr(block, start);
         pmem_persist(addr, length);
         return;
@@ -3943,7 +3944,7 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
     return ret;
 }
 
-bool ramblock_is_pmem(RAMBlock *rb)
+bool ram_block_is_pmem(RAMBlock *rb)
 {
     return rb->flags & RAM_PMEM;
 }
-- 
2.51.0


