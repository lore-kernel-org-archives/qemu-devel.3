Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036D0CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 03:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4A03-0004UY-IY; Wed, 01 Oct 2025 23:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4A01-0004U9-5a
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zj-0004ZI-In
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso253181f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759375707; x=1759980507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7/eaSTeP9UuFjUtgukk67zblH/osf+XrQn3BX925Ps=;
 b=ly9TrhGgSQCpAiy2tTLjcEeIWW/niH2FIF+Cg4t58DfPzjXjpHcCFpDp8e6YoGXpmZ
 qwh/Yi513Fl7X8bjZd0VTVv8zp09stYZGt+dWNSedZkgak0BrLMNBclfRzChxmdCon1D
 N+hfvQ3DWDy6WC3ywwfPmFqE0z0Ya6EtEjv07q8fgAmnGIHzOcBjpypAGvB9cih4tOJi
 SehV220W/opUdq4uQRc+lUmLfZOil0ijaDtIdAMVgR3SfINCvcZ9GfaH7bwFILs3365l
 HdBQJ3IFt1OdttKadPeUy3mpEqVqyfVFCX2G/u2l4sNXLKQd9r/OEsiOnFBV4PCwpUfC
 ppyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759375707; x=1759980507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7/eaSTeP9UuFjUtgukk67zblH/osf+XrQn3BX925Ps=;
 b=vAk5mmqDsvH5q5Sbp4m2uVMruzGJRmp9HsXFJw/BGR1MfIsSopnib/fYmJI/bSdjHm
 A9ULeZfn0nV5PUjzPzTkY43GhpD7pCsAGRx5zqsRLbuvkTioJHj9FpvX2uocjHUAzlpd
 mOAIJAZgTj+knuKNFqNkM2l0Vr8BLDYZ2BSDpgmnAqOOhH+hW7r45y+z7raqxsvC7zK2
 7zg4wGU8s95gX4Yk0AMtFCRyU+wpDCW98gLR//aSagudR7U1k06IyIoYj0cooXtuzdYI
 3iy4VyapaXzcxz4H/tOL+c/Vl3pnWZK1bbmAw75xxi7reohwIxdSrIddkYtcC1NsHAFs
 gflg==
X-Gm-Message-State: AOJu0Yzd4cLugzfMsemhzSfUbytlTJKZM7CCUtWFCF4aFgdCeok1HUwl
 CLCIIS7qoi5vKDb/SZzoGbzrbyqIAuLicv5hjJJ34PWfI/Tz5rE1XL+3GmEl13DIK7oxTUGRoJE
 kPcx8mgmxYA==
X-Gm-Gg: ASbGncuZa2HntqAnDBaM7U2aSVVJoYfa6dW6Al/YFValyuM1GhQOc8JuQJXUq5zWMmP
 oG2W/F8kgCL3J4U6Ov1/sS/dH/Wedcg7jz1FcZuBaCUwdelOOwdZg+ezNvR+Ym6qlDTs0GnAVxO
 aYcRVd1y62mv9WNxJ3n4oUgz4cLjVteO9/RmDDahWn37mmX6da15Bq+t38v2af8aXu6u7f3bBP0
 twjo64DZ75TEsVj4kC7s3R+3YeFFuLb+TtQ7sfsdjc81dfbrSiZlNMobIQwZjIkFBvzVUOHLl1D
 ovkP0n+LViyX5RmCnf39TNa3y/3EyX1aRGsT1DiIDQ2lseEQfGq9vFySJqi/tOUsfbMe3G3RvfO
 jwODI/VNRWk0KD2znQjqXa5F0cSkyzDoxrjwZQ8u95Ef4RnjBieyxQARQaejfYtMTcnD8qsfxpZ
 JYvjTA795B0k7gu+Y4OW38qxN9ikdrtQ==
X-Google-Smtp-Source: AGHT+IFa6DuP6+nSTyFdUQXX/N3DTc+ZczxQOaaLe3gO7ffPlke1IGNV+HU8W6+39+/JQKzkCxKctw==
X-Received: by 2002:a05:6000:25c6:b0:3ec:2ef7:2134 with SMTP id
 ffacd0b85a97d-425577f4fd4mr3773891f8f.18.1759375706962; 
 Wed, 01 Oct 2025 20:28:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4ccesm1552183f8f.59.2025.10.01.20.28.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 20:28:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 2/5] system/ramblock: Move ram_block_is_pmem() declaration
Date: Thu,  2 Oct 2025 05:28:09 +0200
Message-ID: <20251002032812.26069-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002032812.26069-1-philmd@linaro.org>
References: <20251002032812.26069-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


