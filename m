Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E28CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G59-0003RY-RH; Mon, 29 Sep 2025 11:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4X-0002tr-9c
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:45:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4Q-000839-Vu
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:45:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3e8ef75b146so3435856f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759160741; x=1759765541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ier7ZLUPhxlD0fGogfBr0oZm5kAnkym39eZlbfBVpIE=;
 b=yZViLbV7N1SA2VHKm8n3oG4137DtMbW6PQJ77+8RQxR0LLRnzVDYhtFDg62vy+5+Wq
 Us5OPsF6MIXNqEWskwvOa9xAFCrlDAPjNj0DGvzKOpyw48S2eykf7DCOdl84pWNaeDsH
 TbkHxZ02n2YhVhjG60kvQV7tBlJFTdGXcM+Wmr/DRutYojBBPzRcNMVSnPycp5NaSQEx
 OS3tg2IahHhTKcXFnAJpWIeDdJluu54Iu+ZsVHHtVgIM62k6EddCrIRpC+SIKsEPq6eW
 QZaBLBhc6zK6DxZr/dBF+mJ1+tCVWyqTg2WUoDjzWNvkIeuCAi6OLBbcymkI6/DIvQno
 fa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160741; x=1759765541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ier7ZLUPhxlD0fGogfBr0oZm5kAnkym39eZlbfBVpIE=;
 b=hlc7Xxpumgv90WvGJ12nrVkEyH6hR4eaoC/QJE2r5XMGgqm6wHKl8Ge8DVtcTYXUw6
 OwY8VnNM0VXvod0ssDAgaSfnul+lRBThPOB/McTjxLa13duji8DO9/m4dZxvsL4YozDa
 5yAQbsb1sAZEsO4sSGWdkHGZnSu+PipvNurpSHJEgn1BnjccRwPG5+F0D8hh+zAF1G0/
 bKCHcbaWqioX0C5OvJmiV5ttxgXIla5XMnwW6sKlzeLGrUxFxqjKSHqkF5uOwBEeBMrm
 oCn8PI5i8yEB5xxfs6WKrecWFe3/0fqJ+zJQlvawBe00NCBLoQUYLuH5CwfLwO2MhdKz
 MyZw==
X-Gm-Message-State: AOJu0YyEXIUWgUSItexEmIcA8Wi+/sl+D9dCDO/lONOYZadCG4goi7to
 zGAOsjzt6K3qEOd8K54gjpK23mTV0uVJBf/fk10UnDYgsFNfLkOLzQJNrlRJHcs9dHpR4ibRJ6s
 GlcwGQPPFNQ==
X-Gm-Gg: ASbGncvgaSihUfAJWyKjh8h0AFnmFZx6wjAkc0mvGV+MEZBPEJKsBYPFTuqmNn6csBn
 jx8+2SsfoGUSMhyw504cIXEqCnL5FQmQy7SuLp5V8yzUylZEckkxtNFnwb6UNV50f1uCXXsFAjX
 sgaFJtwfwyTRYPGlZv8G7Mfcu8uoxpQfnxv8C2XGBmfbzymkLtWmtKda0jxT9VfMTz9kLyKGsQI
 frNQEbfZ4FrY73UzHNRvEgK12qoC8XiNhZQaxf8yrDGESxm9Ypvo9QHIoaMWosVYcM5bjABlA5G
 FZloHmAv1yybPMC88KFFv1PqufkTfdJIrXJn0HNAZemLIVHBRdTbZtyEsvHUbBKU2MDy4XuXP95
 xV6rlXf2jFRvfeLvdQssBWWCH+R2kCa/iUAVbf3NHQvUqZmzRXTqriK3OFc/4V4A9jaKSh8dz8C
 ey6yDtsC4=
X-Google-Smtp-Source: AGHT+IH9iVMg3sncAg6Mjrqkf34b84fuhD2iKYy8WAQ/+/TUPiyjYY3xhW8ytrinUFRfyHO92RR0MA==
X-Received: by 2002:a05:6000:1ace:b0:400:6e06:e0ae with SMTP id
 ffacd0b85a97d-40e4cc62efbmr15549709f8f.47.1759160740972; 
 Mon, 29 Sep 2025 08:45:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e59af1975sm402735e9.3.2025.09.29.08.45.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 08:45:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/6] system/ramblock: Move ram_block_is_pmem() declaration
Date: Mon, 29 Sep 2025 17:45:25 +0200
Message-ID: <20250929154529.72504-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154529.72504-1-philmd@linaro.org>
References: <20250929154529.72504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
index 8999206592d..12f64fbf78b 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -108,4 +108,9 @@ void ram_block_attributes_destroy(RamBlockAttributes *attr);
 int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
                                       uint64_t size, bool to_discard);
 
+/**
+ * ramblock_is_pmem: Whether the RAM block is of persistent memory
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


