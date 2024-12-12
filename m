Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7728E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoMB-0000VW-VP; Thu, 12 Dec 2024 13:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoM9-0000II-KU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:13 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoM4-0006rv-Nt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:13 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7fd51285746so645565a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029766; x=1734634566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rY7v3gnKlkSHCmEQoYs8O0U0xsJ45+WLP88dw8tMIX4=;
 b=twmqpiSxb3y7EY05D7DASlTZDg9F+7CguE6NRWWKjGeX4DbBBwyPM5rL8u2Dtgkf+r
 GyZ8PEPvfdLlzolDSssPGfxCwXBqgi+BqS1dfrRVozfPksdwQZ+dMo5FO66IDRaYO0Ij
 ZTpXJxLZFFjtF4LYSuzqtlWmocNOTSeEh+SaP/XZrnlZCJ1m2GqTPxkS5PjDti4VZR3V
 xvE+bWLRWy7atriEmyUBpeq8KxjAoY1MbZ3qpgFlWt5HLSDT9C+TZIfvHXfXJBd4+HXK
 0xGqkXSmNoBtwu5iEF7Njns6FNwwtvM/vtETEbueHGuM5+QuywdExGIs7CTFrMI0NUmo
 6Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029766; x=1734634566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rY7v3gnKlkSHCmEQoYs8O0U0xsJ45+WLP88dw8tMIX4=;
 b=dWxYonaF9SFy3a4cjA72BkopyVSCJdAWBxAW9pMcXKwqU5CT8bzmM8XSspo8sQJIwx
 xrf9T1PPLqB0C/EwFT3DJ2PokdTMF8mnlRZY+MzZjSDwf+jjtRRlOHzkNoYYPu4gN4vj
 aZp6Pz4+48U8WD93A2XqbLdt0Ux1mEvmcTGVXMlxzgzJcmDALMNbvDKQxfzAOir6oakn
 Tx8xxzvipNIwEdRVgiupd5RPe/J9IrCRxzA3EyG6CLWMeQF3hdLFkFL0NOh69faXdTa4
 sTZjfTXdAi9f5IJ5P8AodEdSposCeRJMLmXipqTNxFGS/vOe8ZRV+BaGhalQiu56HRei
 qI6g==
X-Gm-Message-State: AOJu0YyC31d1YqEXNwzRgir9yLko5QKZLmokzbO7C+BqKgeR99i0EeLm
 UrwcQPyDF18MbFb0QXwUJiFEQIzk+6mEO2VjDs9fqbMq7qOeIKm2e3oBHoPOQfKPQoAxnC+OR5/
 T
X-Gm-Gg: ASbGnctptcZ+eDXzhmbACFR2T+AebhRIgyi3ME3OIdTzW7TrqhyFnS5MHVhKWmee/Qh
 kWWztJbz2pbocrLmbRoxQIZCq2mL+5SBNCgdriVfjMjzNFWkD337eQCEMmdDG+Y8pLZGKIY86gb
 yKq8C5K4RyMCJ2K9fxEfv4a8xP1+8VGETrVOJvLSSRuUFRV4LdPWWMaaPPQtZoIuTQzOJx63gkH
 IdXkGndfajex1cpu/wcZfOWXj2Fe1altVi4SrlSTZrJcjTcku3Mo2kmb+hCzQZmVPlvnAqs+lav
 HhliL+YS+jjbIvALABxjRlpik6z5rYE=
X-Google-Smtp-Source: AGHT+IGVriHepJXLt9Oqlkoyemt+3qI5X+c5gNt7ub/QiFf6Yux5eB90Xk6ywMjw2pELro7JQeUIoQ==
X-Received: by 2002:a05:6a21:390:b0:1e0:d2f5:6eca with SMTP id
 adf61e73a8af0-1e1dac0ef09mr1813449637.46.1734029766200; 
 Thu, 12 Dec 2024 10:56:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e62bb302sm8328220b3a.139.2024.12.12.10.56.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:56:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/18] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (2/4)
Date: Thu, 12 Dec 2024 19:53:35 +0100
Message-ID: <20241212185341.2857-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x532.google.com
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

Move declarations related to page protection under user
emulation from "exec/cpu-all.h" to "user/page-protection.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/bsd-mem.h             |  1 +
 include/exec/cpu-all.h         | 55 --------------------------------
 include/user/page-protection.h | 57 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/mte_helper.c    |  3 ++
 4 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index eef6b222d9e..f5ec0de24ca 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -57,6 +57,7 @@
 
 #include "qemu-bsd.h"
 #include "exec/page-protection.h"
+#include "user/page-protection.h"
 
 extern struct bsd_shm_regions bsd_shm_regions[];
 extern abi_ulong target_brk;
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 3d97323893b..86cd40020c9 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -130,21 +130,6 @@ extern const TargetPageBits target_page;
 
 int page_get_flags(target_ulong address);
 
-/**
- * page_set_flags:
- * @start: first byte of range
- * @last: last byte of range
- * @flags: flags to set
- * Context: holding mmap lock
- *
- * Modify the flags of a page and invalidate the code if necessary.
- * The flag PAGE_WRITE_ORG is positioned automatically depending
- * on PAGE_WRITE.  The mmap_lock should already be held.
- */
-void page_set_flags(target_ulong start, target_ulong last, int flags);
-
-void page_reset_target_data(target_ulong start, target_ulong last);
-
 /**
  * page_check_range
  * @start: first byte of range
@@ -157,46 +142,6 @@ void page_reset_target_data(target_ulong start, target_ulong last);
  */
 bool page_check_range(target_ulong start, target_ulong last, int flags);
 
-/**
- * page_check_range_empty:
- * @start: first byte of range
- * @last: last byte of range
- * Context: holding mmap lock
- *
- * Return true if the entire range [@start, @last] is unmapped.
- * The memory lock must be held so that the caller will can ensure
- * the result stays true until a new mapping can be installed.
- */
-bool page_check_range_empty(target_ulong start, target_ulong last);
-
-/**
- * page_find_range_empty
- * @min: first byte of search range
- * @max: last byte of search range
- * @len: size of the hole required
- * @align: alignment of the hole required (power of 2)
- *
- * If there is a range [x, x+@len) within [@min, @max] such that
- * x % @align == 0, then return x.  Otherwise return -1.
- * The memory lock must be held, as the caller will want to ensure
- * the returned range stays empty until a new mapping can be installed.
- */
-target_ulong page_find_range_empty(target_ulong min, target_ulong max,
-                                   target_ulong len, target_ulong align);
-
-/**
- * page_get_target_data(address)
- * @address: guest virtual address
- *
- * Return TARGET_PAGE_DATA_SIZE bytes of out-of-band data to associate
- * with the guest page at @address, allocating it if necessary.  The
- * caller should already have verified that the address is valid.
- *
- * The memory will be freed when the guest page is deallocated,
- * e.g. with the munmap system call.
- */
-void *page_get_target_data(target_ulong address)
-    __attribute__((returns_nonnull));
 #endif
 
 CPUArchState *cpu_copy(CPUArchState *env);
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index ea11cf9e328..d21fab1aaf9 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -18,6 +18,63 @@
 
 void page_protect(tb_page_addr_t page_addr);
 int page_unprotect(tb_page_addr_t address, uintptr_t pc);
+
+/**
+ * page_set_flags:
+ * @start: first byte of range
+ * @last: last byte of range
+ * @flags: flags to set
+ * Context: holding mmap lock
+ *
+ * Modify the flags of a page and invalidate the code if necessary.
+ * The flag PAGE_WRITE_ORG is positioned automatically depending
+ * on PAGE_WRITE.  The mmap_lock should already be held.
+ */
+void page_set_flags(target_ulong start, target_ulong last, int flags);
+
+void page_reset_target_data(target_ulong start, target_ulong last);
+
+/**
+ * page_check_range_empty:
+ * @start: first byte of range
+ * @last: last byte of range
+ * Context: holding mmap lock
+ *
+ * Return true if the entire range [@start, @last] is unmapped.
+ * The memory lock must be held so that the caller will can ensure
+ * the result stays true until a new mapping can be installed.
+ */
+bool page_check_range_empty(target_ulong start, target_ulong last);
+
+/**
+ * page_find_range_empty
+ * @min: first byte of search range
+ * @max: last byte of search range
+ * @len: size of the hole required
+ * @align: alignment of the hole required (power of 2)
+ *
+ * If there is a range [x, x+@len) within [@min, @max] such that
+ * x % @align == 0, then return x.  Otherwise return -1.
+ * The memory lock must be held, as the caller will want to ensure
+ * the returned range stays empty until a new mapping can be installed.
+ */
+target_ulong page_find_range_empty(target_ulong min, target_ulong max,
+                                   target_ulong len, target_ulong align);
+
+/**
+ * page_get_target_data(address)
+ * @address: guest virtual address
+ *
+ * Return TARGET_PAGE_DATA_SIZE bytes of out-of-band data to associate
+ * with the guest page at @address, allocating it if necessary.  The
+ * caller should already have verified that the address is valid.
+ *
+ * The memory will be freed when the guest page is deallocated,
+ * e.g. with the munmap system call.
+ */
+__attribute__((returns_nonnull))
+void *page_get_target_data(target_ulong address);
+
 typedef int (*walk_memory_regions_fn)(void *, target_ulong,
                                       target_ulong, unsigned long);
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9d2ba287eeb..ae037dc9143 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -23,6 +23,9 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 #include "exec/ram_addr.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
-- 
2.45.2


