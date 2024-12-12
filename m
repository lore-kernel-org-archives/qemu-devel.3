Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C3E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoKg-0004ou-7s; Thu, 12 Dec 2024 13:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKe-0004og-HF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKc-0006Zg-Ro
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:40 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2165448243fso10863785ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029677; x=1734634477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl4taCtFHZe8oQC4px0PP3McFaT9srtUpF3ia8zOgEk=;
 b=GpV2Zh8zBLMzZzxT+92bpSq3tjTPhB22Hgyy3Hd60JekXUmZVGtL+rSp3tFWbQ2lnC
 rvNAfsI3vSJ8qzXIBVbmYN7fWjlBlJob5umxiHlbHHAkrMDX1wQV3CPVIYy6kMKAbELo
 DmzQucaaZFzm80tyNowTyrwVH4RjnxxpT4ThQ28OQLB8hS63L5/YD52W3DwAfNroqZOM
 FQcCQnI8fWxNvJiPCHSIU5mXb6MCqSLVIL8wmaXCSxDGv3UDqqHdIiIW30U0+KbU0dLK
 EG4+XYnnHE2JMDtSGrnDTnO1flru338E3cPqovmpNHT+GHXNLXhhdw4k73V6VXLB6rXi
 0NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029677; x=1734634477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pl4taCtFHZe8oQC4px0PP3McFaT9srtUpF3ia8zOgEk=;
 b=XkV9KLCz4QftIn9XE0CSRVzqXaVwbGynghFf7taY0ENKHHaBxEtCikQdplKlrVBQeW
 eBUsbjQEQADJqMhvBZ/n08uM2pGUPymNnFalMU0CjL7tzmzdYFWnF0LF/Eov/VzYDKFx
 b+h7eXDHZc4WK+JqP43GGkcWi8xl6vwtF1Fy1PRArsAt4lebKXDSf+s9vgdk8A0CqZiE
 pr/F2u8U22YZJPecBSSzjJw5U3Ro6IQnrUtgQbtlEC92s/6tPwkcXIBLXcsk+f+Y61Xx
 pPwISDKpv6GMw0Y4xinArZqS7048Zjx+0kyoJsZ+ofpOc+zFj2sfHdSeUHk7tVrqbTUG
 yhDg==
X-Gm-Message-State: AOJu0Yz59tpaQagzazsAdAV/LZ9dy/qe/MtOxQMyLsrNaTpNmT9Cslng
 GRO+l5csgDrGaYHg9TJQS8ja2Uz8bhOnhtOmGXss+dHuVkyXrlNuxFgIH0CPpMqv5zhkdD/j9Nl
 K
X-Gm-Gg: ASbGncvzo7h81TB6cJ1VXFxo5AZawExJw7rio5w4mtnAUTaKzqHfkisU6cXKm0Q9i3I
 wCUEXiGp65ksP7aZUijGH5BZ/iBv3kqPZFF5pzDGBJOGfCVjmM/hWHXooAO1GFSoxoPCgeuxZHl
 vjhDEf39Lhb31O+SvRVXnOb6U259Lx8R8vGYk/H5N3zyZ8WrQBOzOYUlFKMEDysmkYheI9z+KNV
 FdAQzWGy9Uj/lywocaNt4/C3rfdPNm7ympIT6l7noPxBT4yHHDjA4urNXBOQiT4NUE3jZubiVDj
 HDEWfiV32kw/Ukeh2DssPyQyTdEL8JY=
X-Google-Smtp-Source: AGHT+IFx9eLiDTQfJwfgDAMUAoqCUp/MTS3FsvXzicRxBBDsxtidDJpG+pFvS7xhUIg8r3MKg2cvWQ==
X-Received: by 2002:a17:902:f648:b0:216:6855:164 with SMTP id
 d9443c01a7336-2178aeefc23mr74126785ad.39.1734029677241; 
 Thu, 12 Dec 2024 10:54:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21653b0d4f5sm69493115ad.70.2024.12.12.10.54.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:54:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/18] accel/tcg: Declare mmap_[un]lock() in
 'exec/page-protection.h'
Date: Thu, 12 Dec 2024 19:53:27 +0100
Message-ID: <20241212185341.2857-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

Move mmap_lock(), mmap_unlock() declarations and the
WITH_MMAP_LOCK_GUARD() definition to 'exec/page-protection.h'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h        | 17 -----------------
 include/exec/page-protection.h | 24 ++++++++++++++++++++++++
 accel/tcg/cpu-exec.c           |  1 +
 accel/tcg/translate-all.c      |  1 +
 accel/tcg/watchpoint.c         |  1 +
 linux-user/flatload.c          |  1 +
 target/arm/helper.c            |  1 +
 7 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2e4c4cc4b46..b5ea607cf45 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -27,7 +27,6 @@
 #endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
-#include "qemu/clang-tsa.h"
 
 /**
  * cpu_loop_exit_requested:
@@ -520,18 +519,6 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
 }
 
 #if defined(CONFIG_USER_ONLY)
-void TSA_NO_TSA mmap_lock(void);
-void TSA_NO_TSA mmap_unlock(void);
-bool have_mmap_lock(void);
-
-static inline void mmap_unlock_guard(void *unused)
-{
-    mmap_unlock();
-}
-
-#define WITH_MMAP_LOCK_GUARD()                                            \
-    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard)))  \
-         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
 
 /**
  * adjust_signal_pc:
@@ -585,10 +572,6 @@ G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                                      uintptr_t ra);
 
 #else
-static inline void mmap_lock(void) {}
-static inline void mmap_unlock(void) {}
-#define WITH_MMAP_LOCK_GUARD()
-
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index c43231af8b5..bae3355f62c 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -38,4 +38,28 @@
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+#ifdef CONFIG_USER_ONLY
+
+#include "qemu/clang-tsa.h"
+
+void TSA_NO_TSA mmap_lock(void);
+void TSA_NO_TSA mmap_unlock(void);
+bool have_mmap_lock(void);
+
+static inline void mmap_unlock_guard(void *unused)
+{
+    mmap_unlock();
+}
+
+#define WITH_MMAP_LOCK_GUARD() \
+    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
+         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
+#else
+
+static inline void mmap_lock(void) {}
+static inline void mmap_unlock(void) {}
+#define WITH_MMAP_LOCK_GUARD()
+
+#endif /* !CONFIG_USER_ONLY */
+
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c13f4a7cbbf..f82870a1e2a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "exec/page-protection.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a8b24be0b96..d586ac9bb1d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -44,6 +44,7 @@
 #endif
 
 #include "exec/cputlb.h"
+#include "exec/page-protection.h"
 #include "exec/translate-all.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index ca641eb95cf..8923301b8b8 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
+#include "exec/page-protection.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 0e4be5bf44a..d5cb1830ddf 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -34,6 +34,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu.h"
+#include "exec/page-protection.h"
 #include "user-internals.h"
 #include "loader.h"
 #include "user-mmap.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 63fe4ba318b..c35cb0f6a54 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13,6 +13,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/helper-proto.h"
+#include "exec/page-protection.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
-- 
2.45.2


