Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15B8C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 23:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0qtz-00014c-PB; Fri, 04 Apr 2025 19:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qtr-00012t-0p
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:56:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qtp-0008WO-01
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:56:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso1785887f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743810992; x=1744415792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGMVLsDBH5VDaPNCTBg6x48JohQ2QxgEWxQZWJUvoeQ=;
 b=fvPtF+w3LW8hSw8WLY3/AQe/1We8HMIjUteOOzJd/yeb6Tpej2LT23/IO6GWRBsWUN
 b05BYcnfGL0hc9HhYj7d/BRpWqNaUGhNi4CTJerbPi0PZEYKCuotaEgDQJEiPoL+6kBt
 fzvZnBaytgtxJfdoFLXQU8tVA4m9sTdMC4iMpLMkA/Z+b2yx7oQ59QKzj4jVImRLr6x/
 nQj/ytPBqCnNAWeSlBavOsRJPfy0sb1fz2MZu3rfuuPAkqKDKnrwfFqSYRYnSTYFATeF
 NhAUJ2b5EImpHB8xMNx2q+xnhMAAI4UZLG802+BI9QWIGEHem15Gh4w/EWox707fkMw6
 uzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743810992; x=1744415792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGMVLsDBH5VDaPNCTBg6x48JohQ2QxgEWxQZWJUvoeQ=;
 b=q2HgJd95WI4drOF1kroiYWSoqBaZfzmu4I4iZYigTFWniVtAt1h1qnKu+mkYqcgXdq
 IaazX6UQAO63ucJSwd2VxaQnWzJQZ5uLCXw0InYVlO3VL6itVcUMnZU92jvSrsKUo0qJ
 ZoDPjyKfL4YBN4mCv5QNQQLQ5dxP2wA4hZu/CxNiyLuT5SQenzvl/cz540EATyj+NcPf
 VnoCrLMgAoPqxBBSzid+7UJUk1bW9zxJROWTRDuxx7XHQ0jyawafN9t0Gb0FVIfZdpPF
 FjsoH/DaeK2rIuKtc4fMOHBX/jGihMc4do5DKgSayVZbQIhfoTw9bzdKJ8/w/s+NIpBr
 L6wA==
X-Gm-Message-State: AOJu0YwC3zC7+u2yV7zk0VYX9bCx3rsNawOd13rU7zJ4m0Oo284Rzd0p
 JxcQ6b7oHTwYjP8fRxvgbZYZKIIDjjX3WxItWxeW3HK0qgYvE+ZkuZq5PG8VOk3gXXgNkfuIWnZ
 9
X-Gm-Gg: ASbGncsjMtu6v9b5uzMmcMp/QyRHNdXQzYdOaOoGdA+cDqkbqTyLDSI2iX8reATGP7S
 1RNtaqerJDPVYViAUWv46QmNs7DQtnirjsEdEgiqs2l7nzy7oziUJTZSvukdu8SDG9wfvhqGM6h
 hKFn0bxtOxHxJpYD8O1D8sZYZcN+4UMTy/oDzepUPZ4LNU2SIgN/9ozI/QBfsYBvIcksN+nJrwS
 R6cW0TWLqdw1MvOX4e/ewedZgdGvAeqHUWIpcmDWJX4G3Hr01crlg7th+PewpS/DiGOOrpkZ4jj
 JpgbHHnBOE0KvBmjDLoOcj6oIgXM197aKeV3IVG4hE5okkxXwSP9twKBP8u+tVX4wkAA/8sFOvG
 VYaWCOkm6IHgkEHKjXQk+J3yRXCkZC+sCJRk=
X-Google-Smtp-Source: AGHT+IEaoQjArW5S2JpweQl0Roj9RwU5ycB843D1TSip8G1Ii9MJm9wFS/6NwNEoTZugOFUIDTsPkg==
X-Received: by 2002:a5d:598b:0:b0:39c:1410:6c20 with SMTP id
 ffacd0b85a97d-39d6fce100fmr786620f8f.45.1743810992071; 
 Fri, 04 Apr 2025 16:56:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6321sm5384167f8f.44.2025.04.04.16.56.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 16:56:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/2] tcg: Introduce and use target_has_precise_smc()
 runtime helper
Date: Sat,  5 Apr 2025 01:56:23 +0200
Message-ID: <20250404235624.67816-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404235624.67816-1-philmd@linaro.org>
References: <20250404235624.67816-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

target_has_precise_smc() returns the value of the
TARGET_HAS_PRECISE_SMC definition at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-internal.h |  3 +++
 accel/tcg/cpu-exec.c    |  9 +++++++++
 accel/tcg/tb-maint.c    | 18 +++++-------------
 accel/tcg/user-exec.c   | 10 +++++-----
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 08538e2896b..a844709bbb2 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -44,6 +44,9 @@ void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_pages(TranslationBlock *);
 #endif
 
+/* Whether the target supports implicit self modifying code */
+bool target_has_precise_smc(void);
+
 #ifdef CONFIG_SOFTMMU
 void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
                                    unsigned size,
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b00f046b29f..cfe3b93e1e3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1065,6 +1065,15 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
+bool target_has_precise_smc(void)
+{
+#ifdef TARGET_HAS_PRECISE_SMC
+    return true;
+#else
+    return false;
+#endif
+}
+
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d479f53ae02..ae12ad2d867 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1057,10 +1057,7 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
      * Without precise smc semantics, or when outside of a TB,
      * we can skip to invalidate.
      */
-#ifndef TARGET_HAS_PRECISE_SMC
-    pc = 0;
-#endif
-    if (!pc) {
+    if (!target_has_precise_smc() || !pc) {
         tb_invalidate_phys_page(addr);
         return false;
     }
@@ -1109,10 +1106,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
 {
     TranslationBlock *tb;
     PageForEachNext n;
-#ifdef TARGET_HAS_PRECISE_SMC
     bool current_tb_modified = false;
-    TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
-#endif /* TARGET_HAS_PRECISE_SMC */
+    TranslationBlock *current_tb = (target_has_precise_smc() && retaddr)
+                                   ? tcg_tb_lookup(retaddr) : NULL;
 
     /* Range may not cross a page. */
     tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
@@ -1134,8 +1130,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
             tb_last = tb_start + (tb_last & ~TARGET_PAGE_MASK);
         }
         if (!(tb_last < start || tb_start > last)) {
-#ifdef TARGET_HAS_PRECISE_SMC
-            if (current_tb == tb &&
+            if (target_has_precise_smc() && current_tb == tb &&
                 (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
                 /*
                  * If we are modifying the current TB, we must stop
@@ -1147,7 +1142,6 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
                 current_tb_modified = true;
                 cpu_restore_state_from_tb(current_cpu, current_tb, retaddr);
             }
-#endif /* TARGET_HAS_PRECISE_SMC */
             tb_phys_invalidate__locked(tb);
         }
     }
@@ -1157,15 +1151,13 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
         tlb_unprotect_code(start);
     }
 
-#ifdef TARGET_HAS_PRECISE_SMC
-    if (current_tb_modified) {
+    if (target_has_precise_smc() && current_tb_modified) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
         current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
-#endif
 }
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 5eef8e7f186..135c54980a2 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -731,12 +731,12 @@ int page_unprotect(tb_page_addr_t address, uintptr_t pc)
          * this thread raced with another one which got here first and
          * set the page to PAGE_WRITE and did the TB invalidate for us.
          */
-#ifdef TARGET_HAS_PRECISE_SMC
-        TranslationBlock *current_tb = tcg_tb_lookup(pc);
-        if (current_tb) {
-            current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
+        if (target_has_precise_smc()) {
+            TranslationBlock *current_tb = tcg_tb_lookup(pc);
+            if (current_tb) {
+                current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
+            }
         }
-#endif
     } else {
         int host_page_size = qemu_real_host_page_size();
         target_ulong start, len, i;
-- 
2.47.1


