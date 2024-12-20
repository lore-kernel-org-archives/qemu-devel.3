Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6E2E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiV-00026z-Qc; Fri, 20 Dec 2024 11:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhx-0000jY-Dp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:34 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhv-0008AR-J0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1091131f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711509; x=1735316309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjQsKFSPnrMo0qfcXdcQ0jhEDeij4rKLey65pvPCxLY=;
 b=PfaiWawAo1Jq2GN4KG+eeVPOLL6DiiUwV7+icODPDtPDYTUo60FsMi6y3JyhX3s4Dl
 NOcpXd9XLIiToqS2Jzv660cjNTTTFsfFxvMDb8yUq9kcsmLYHIusYocvcuLJsMZhFBRB
 ITmxLhllfI06NYdlVAEGvldOHDcWfxk4C7p6kd2Rk2fFDaRAZlIuaJiyIBq8dtU6Rz9o
 f4i2Wy4VCZcSwsALRyQwO23Pjdr1V7YQSC4Qf1q2afVH/a4SeELUgDMfYiXqG4GBbrQl
 FAlpV3YkQCd8CZDLMsl7dg3kPbG+CkPNdsBsEnvxhGIFHRpUzEvdDtb+AxPSC7qREJf/
 GlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711509; x=1735316309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjQsKFSPnrMo0qfcXdcQ0jhEDeij4rKLey65pvPCxLY=;
 b=X4cjngGOoWAJI6xIYR5fG2Se78Ld9hOMLfnHrq8iBcWkKEh7Hz6DTZ/zlCLCRruZKJ
 reglm//x031qKr7hYRU4jMUipkel/yE+4tzX6nAFrvYx3WhZ7239vexoab4vCpW40D94
 DMw42QVkzR85Y8Al0BU6Cn8R8focc31fzgJFbX7qne68PJwZCCC/M/m0tAZBRhXtg+XY
 lVzl9LNA+WSE+ClNpTFXhXwGbuHivv2eJ0DRWjifQ0fD3kVbYtfVOZD9h7WcCIoKaZqJ
 lcXOIoVpBPFZqPj9KpgMM2TDmMId1rMIEaG2tiWolT6Cx1dnGLzVAfLPxmDSEQacMUCB
 oFlw==
X-Gm-Message-State: AOJu0YwtbSbR7LOrhwNOp9/tgDYaIZWMy5CFFQzLYRhM84jN/AIq9MGP
 PAzumuykuNT2cmIGsHlo70TqALvsmHMTfm5miy4DeXxzWs2ZcU1j9r2B1SXEpO9A8E0URMUIWfS
 Y
X-Gm-Gg: ASbGncspPGyZedgEzLCyF/eQP3ftk209wpRO1DQsjh09sM0JAkK7X2sZnicATdcobbY
 qJZg9O4CK7jyKUbyn474LihR2+ZhpI4SsDU05mUegTimeIlvA1/XL9xRbv4W+b+i1afUWC4zCOT
 FlJbGTicpnfP0kPEjQMDdjm5++xlBZmiEUC4OKtKAaHwvIyzaz8Xh+rdHZ7SJSsp4qSwARFaYCt
 8+wpnTIGJJy1/AJNJtwkoUZfVepIi4SualGOfzkOO+o2k/1Zw+H7hYUdrETnc051DgOYygTGVE=
X-Google-Smtp-Source: AGHT+IEFbZ7loz4KgataK9+Tt+7cG3QAhA8OzpmELW1G0yZDHuSl7s8btekJccqSSA4v6FA1wgoRKA==
X-Received: by 2002:a5d:5f8b:0:b0:385:fc70:826 with SMTP id
 ffacd0b85a97d-38a223fd808mr3373144f8f.52.1734711508925; 
 Fri, 20 Dec 2024 08:18:28 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e278sm4455830f8f.75.2024.12.20.08.18.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 34/59] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (2/4)
Date: Fri, 20 Dec 2024 17:15:25 +0100
Message-ID: <20241220161551.89317-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-13-philmd@linaro.org>
---
 bsd-user/bsd-mem.h             |  1 +
 include/exec/cpu-all.h         | 55 --------------------------------
 include/user/page-protection.h | 57 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/mte_helper.c    |  4 ++-
 4 files changed, 61 insertions(+), 56 deletions(-)

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
index b017b26d07b..7943ae2d608 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -23,7 +23,9 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#else
 #include "exec/ram_addr.h"
 #endif
 #include "exec/cpu_ldst.h"
-- 
2.47.1


