Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E3FC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7hJ-0005kZ-4W; Thu, 22 May 2025 11:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gh-0005KE-U6
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:28 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gY-0007jc-Oz
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:26 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so7737900a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747927097; x=1748531897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdWtyILUVkLh4rqVNXXy+skYMS+HEC2iR5mqTybr0fU=;
 b=eNkTE2KziTG37tjG4dDeJmKDAQkAzy5J4LGCOSzur9eORCFywAHmNskTx2pDk9zNPY
 I4CLHm12/cVKN+h7ORtReTksK9bIrilRHvgCn0JQ7XrIxif3Fv6zJdSOWWmhVThRwdVv
 m8OMUpOXQWWPPdkGk7vU6SxT1yn24voMKccy9Poqto2sYVlJye/7B0PHWR1KxD+UiMpe
 LxLPKQZhW8FwGvkIhTvwuh14HZTidNHGT52mbahkNV0uFv8edPPKQl/PaQb7wBppCwhT
 tvDzOt8xEFDdRrXBpzJe4trRJq/Sgk/Np1Rhua5BjodvqFqRkM8hoipf+9ekDJrYG6TP
 6iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927097; x=1748531897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdWtyILUVkLh4rqVNXXy+skYMS+HEC2iR5mqTybr0fU=;
 b=bU6x7gdccLtLBJQYWeqtQFroV3eKeougT6hlV6AJhvVe2zZemzBo3Wntal0q3N2M4r
 i78NxISQdN0BwfwDBOFNWgWgXcG+BPI/clBGG8ogRYG68dbsglNYLm6mvfmjJQx/7BPl
 xRCadqw8NOTWurA64dbtsgWG5PU/6M7RivqtSC9mAFHlrYM6KsorTkzPKAcEs85S6UUh
 aWa71tcaJiC9g90Ag/N2Tgz7rRVj4QXJO3K0kU6ZSUUn6aVuHVMJ60sylWpBYHbHhWdu
 75kcRvCRXUlWmsmwo62sQoEuhwzkYiRC0/fu2BGs5tuOE4q/ry69qjkoK1aGfgfv3Da2
 uiXw==
X-Gm-Message-State: AOJu0Yx6s3jCi48s0otst2DRR5NHLhs77DeXJjG/e8jSShNLwZgxct+G
 X0z08/uIZa+Qu1sqY5z49WGEviSmXvIfJtjITLitNhNgWLGaju3MXNGvIQlUjQ==
X-Gm-Gg: ASbGncvacP8C91qZh6LnuE/GNd15A7ddgDggqHofjgpm1EmraNErOUuF+fWYS3tgPvI
 lA3oxsvoHNttIE8Lt4Hy+PDKlvXb8vnPRKfN07rLPPxdHqaga4Kcu9+DIUFVncGVLhS6yVnFQQa
 cytZXff3EyevWwia7h23edyzufqvxxP1uuvXcvSG1622Dd/tIpag97UZ7sWD67FeJWkMLL96hHv
 Iq7LgyBJq63EjLvbeuYma4YN16HZMtV0i6Q/S5gT553Db5Dt37VzwUSro9FPN4rtDnwobbHhwyK
 wQxdAoOY4yJZRuxlBSqjisFKRgOexAPZhiM6mvA0vF1P7vXvIHw=
X-Google-Smtp-Source: AGHT+IEjAs9RNfvRXxiqnGOGVuceI9Q1+Y4N5bQZ11RNzBeuCezOjWUvRqx0W2yCA7krLpR8n7wCgg==
X-Received: by 2002:a17:903:2ec3:b0:231:d0dc:f2d4 with SMTP id
 d9443c01a7336-231d438b4efmr340721465ad.2.1747927096843; 
 Thu, 22 May 2025 08:18:16 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:c732:a88c:b916:8b9f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4b017dasm110443555ad.98.2025.05.22.08.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:18:16 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ktokunaga.mail@gmail.com
Subject: [PATCH 3/5] tlb: specify address field size based on TCG_VADDR_BITS
Date: Fri, 23 May 2025 00:17:28 +0900
Message-ID: <4fae51045e4364957ad7bb0220748932d4febd66.1747922170.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747922170.git.ktokunaga.mail@gmail.com>
References: <cover.1747922170.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit sets the address field sizes in CPUTLBEntry based on the value
of TCG_VADDR_BITS. For non-wasm hosts, TCG_VADDR_BITS matches the pointer
size so this change preserves the original behaviour.

WebAssembly supports 64bit atomics even though sizeof(void *) is 4. This
commit also updates ATOMIC_REG_SIZE value for the wasm build to ensure
assertions pass.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 accel/tcg/cputlb.c        |  8 ++++----
 include/exec/tlb-common.h | 18 +++++++++++++-----
 include/qemu/atomic.h     |  4 ++++
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5f6d7c601c..b15e9e80ee 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -109,13 +109,13 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
 {
     /* Do not rearrange the CPUTLBEntry structure members. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
-                      MMU_DATA_LOAD * sizeof(uintptr_t));
+                      MMU_DATA_LOAD * sizeof(tlb_addr));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
-                      MMU_DATA_STORE * sizeof(uintptr_t));
+                      MMU_DATA_STORE * sizeof(tlb_addr));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uintptr_t));
+                      MMU_INST_FETCH * sizeof(tlb_addr));
 
-    const uintptr_t *ptr = &entry->addr_idx[access_type];
+    const tlb_addr *ptr = &entry->addr_idx[access_type];
     /* ofs might correspond to .addr_write, so use qatomic_read */
     return qatomic_read(ptr);
 }
diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index 03b5a8ffc7..87f8beab9a 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -19,14 +19,22 @@
 #ifndef EXEC_TLB_COMMON_H
 #define EXEC_TLB_COMMON_H 1
 
-#define CPU_TLB_ENTRY_BITS (HOST_LONG_BITS == 32 ? 4 : 5)
+#if TCG_VADDR_BITS == 32
+#define CPU_TLB_ENTRY_BITS 4
+typedef uint32_t tlb_addr;
+#elif TCG_VADDR_BITS == 64
+#define CPU_TLB_ENTRY_BITS 5
+typedef uint64_t tlb_addr;
+#else
+#error Unknown pointer size
+#endif
 
 /* Minimalized TLB entry for use by TCG fast path. */
 typedef union CPUTLBEntry {
     struct {
-        uintptr_t addr_read;
-        uintptr_t addr_write;
-        uintptr_t addr_code;
+        tlb_addr addr_read;
+        tlb_addr addr_write;
+        tlb_addr addr_code;
         /*
          * Addend to virtual address to get host address.  IO accesses
          * use the corresponding iotlb value.
@@ -37,7 +45,7 @@ typedef union CPUTLBEntry {
      * Padding to get a power of two size, as well as index
      * access to addr_{read,write,code}.
      */
-    uintptr_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uintptr_t)];
+    tlb_addr addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(tlb_addr)];
 } CPUTLBEntry;
 
 QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f80cba24cf..76a8fbcd8c 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -56,6 +56,7 @@
  */
 #define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
 
+#ifndef EMSCRIPTEN
 /*
  * Sanity check that the size of an atomic operation isn't "overly large".
  * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
@@ -63,6 +64,9 @@
  * bit of sanity checking that other 32-bit hosts might build.
  */
 #define ATOMIC_REG_SIZE  sizeof(void *)
+#else
+#define ATOMIC_REG_SIZE  8 /* wasm supports 64bit atomics */
+#endif
 
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
-- 
2.43.0


