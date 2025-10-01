Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8BCCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zxu-0004CA-Ai; Wed, 01 Oct 2025 12:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxK-000411-7H
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zx9-0008De-BK
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so8044f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759337108; x=1759941908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b7SjVDM7x27mqOISYHK6sGtoV+Vz1yW6Bp7Z2odYdE=;
 b=aGi2TFiwyUsGasKN2b/FWg+7k2zGB6zQOxNm70vfTf6s9MhIPs60244mgT/PI6FmOW
 CFEp58Hkia90ebfiWa/lIb6/cB0t96jVDQesLeXVdSI/PuWxPJuJnyksuIroVgpsKdl5
 OYNwRn3zgyuFmv6dYYRVnp2J7C1GPm8gQIkswSmNv8pooGSUMP07e6ZY5GN3wmUE/zL7
 p1b2W1j8cfKCvokBmhKwe1bWiBJUXk98KnSwhQqA/9i12AgukH/niCCgw24QQoXVGk7j
 FXgbuyPvyBzo1XoTKjG6JAyOWsmWuCe4qSt/4bmkUpAZtQXzqUTvcVY+1n8wKHUyozC4
 tRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759337108; x=1759941908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8b7SjVDM7x27mqOISYHK6sGtoV+Vz1yW6Bp7Z2odYdE=;
 b=g8282ZKLz+p24QBmlAZudnZeCl/CiKjBw62ypCSdnLOfEsglBSTxdkXBhJufpMCLk2
 Q4uhp7qcip4nj3L6HyUgtOJvbUVlbWSouOXGKeP0uvdfdKiVT5Ifiern4neVfNFBuwG0
 lS8kwk2V8ouruVw3PHdVv7VrSBkhW3UtaY6KtyR/s0DTRL/GpAZ66j/LlHtWJKEJhMxT
 almqJZK5kgqYv6NfFZ1kEYpUovYWinRCieOj5ArzkhmXmFeLtpkIrKXQ4/xBDj6NuWxA
 M6/HWINqvD1sKFIbfR/uvV+uOElPul/8aV34xpkzuFxOKZyRqljQhnlDdg/Sewd1b9hT
 0W9A==
X-Gm-Message-State: AOJu0YwJLezwnFp7IBMFDztnur5e0IYr0K5BqAu9aGS3QrAeWViKbrLt
 yAUjYy3m2qco/oTFNjI0h2XyrLM4doF9Tw/UMjaPj7hmIBCjJpHDpj9BL5xHxMIjTy+i1t+KNef
 2SVkuNmHYTQ==
X-Gm-Gg: ASbGncsGQbjXfGffX0rlUc++u/glNnz4nYC1ssMZUiAAWF70qyo7K5qY72UJ0/X4SZl
 ldl7UA2hMhJn1WWguO6zjRYvA9EnfGFxvopnPchcSwZx8uKyL1jtJlQzpEn2dwL3A+UEeuCF0Az
 aQocTek/netJnbQfAAc2LgBlvHD2bZEdz5yRJkTnG9y3hrLoR9Gr0GzgzfqCPJu7kwv7yCkpF0d
 F9Dc+PegJUyeHl5XNTngOwr6l0vRhk1aINgGzb4tfjhHwS0sTsYJPTfmEUuXIX+afjwH7lrzEVI
 PYeC0eSNlNGEeKRoCo44vnczD5gkKzc1Q6Jyjsl73/lgHOqYvNsmRbOE2sUPdub8+wSXYmnduOQ
 9iSYRapNPK/Z8wm2ecTsS8cRceeISgsvc6WSyrjkDVv64n4fcLWLMROuf5xNoS+F5nUfDWleiBv
 iMZOgAfspISzriA3Ulj2cq
X-Google-Smtp-Source: AGHT+IHMHiIv3Gm0O2fKETILRigrKi9nt4DR/GCQ5opvYfK7xcl36n2RWU61ts9bNcXzgiUvtcFXsQ==
X-Received: by 2002:a05:6000:2388:b0:3d4:f5c2:d805 with SMTP id
 ffacd0b85a97d-425577ea471mr3018368f8f.16.1759337108303; 
 Wed, 01 Oct 2025 09:45:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921b7dsm27494281f8f.42.2025.10.01.09.45.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 09:45:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/6] system/ramblock: Move ram_block_is_pmem() declaration
Date: Wed,  1 Oct 2025 18:44:52 +0200
Message-ID: <20251001164456.3230-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001164456.3230-1-philmd@linaro.org>
References: <20251001164456.3230-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


