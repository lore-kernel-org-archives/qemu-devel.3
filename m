Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB8BC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSu-0005YM-PX; Tue, 22 Apr 2025 15:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSC-00042L-RZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSA-0007L8-H5
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:48 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2255003f4c6so63622265ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350725; x=1745955525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TD3+nJDQxNuFLk7Pe2oHBRQSgwi4i3j139vVWlzEmKQ=;
 b=TrO9JR8ADsrOUaBjB5gw0cZqrIeX57adNtc7x2jF3EPtFDdIacFzUP24dboVKRXgzH
 zY9F3TW3D6nfGVvOjmVv5+4GNWqZML6JBomTos1s97npNJm6ZRdc4nW/GS28I1ZjcpmL
 cF9hmVd4H9OUB9nirf1rZMszYO9HcKaAeIpogO4HMwMnKEsS1mdcTbug+CEZTpdZudh4
 eYRvngp977JCJlh2s4ismVpCdcs0KEr2vM0/sby+ggWjr1kBW9i5yGmsx/n+BERTjV3Y
 Z1NbEGo/wuO7T3K4dbVKb/yVT+o/j7sAjk9BGXzDKWAQicTn+Y3aAv3QKR20tVi5xpU5
 9gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350725; x=1745955525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TD3+nJDQxNuFLk7Pe2oHBRQSgwi4i3j139vVWlzEmKQ=;
 b=MJRvYa+5EocDw9YuGKB2MTeh+A43/Ods16h8Wvk/Il2EAX8XEXBjJ9OlrO39iE9f3Z
 UttLUie6zCz+uoFQyIIHCkGdcslbRSkWqhRWa3Z0bSEvzl/7ZGEjVAkf2H08U3YUJBcV
 lFYbelO37/nSBoGEDZyO1sn6iK0+YqOxL623tVmNot6H0f79ByIz93BN8gPWOe5/Tsuc
 d51O9G7fXE3Hi09JIyPTNA0Devd8XCnat8hCyE3R0FWX51mYmVpnrhqX4EitolocWFWI
 YUcxvVD1DKXMsX8xBepxkReok/8VIbjxxu/4WFTDqdLur1w8kIIBJMf66DY1CWUmG/Ny
 7dnQ==
X-Gm-Message-State: AOJu0YzguaHWT/PcBwlG/SF4qhkg4fV4qeOgpiJmlCG2DMCmb0OcTkCF
 rEljHn8cpPDCriFJsFeNOb2mVk6uO3839G1T2eExYsZVy68S00eiWEScsCC81q7MujgIvap6DBI
 L
X-Gm-Gg: ASbGncvBQ1nkZUwCKmZGp43l5B5pTVBYAWBkEW8KdGIxaCBLy+5YcLxSwdUqyv8u4Ns
 T8z7lEU63OY2fP0uohSk+s9Kt9+iPOYWiSk6X4TnsQmA1deWrFJcw928IuKwAGBZ8UBy4tdSvuh
 +nvxdoACjXFHV9QxfUnDPTwrFheGsAfBYR7RizzJJpXe5QmSEeoKUnaqjihyVReEXCAsfRAcKDp
 tgQVp6w8eLc/WDIE9BQCs02xmhn0BKvk7g9x1QqQfBllCQDyK6u9ZGZRmBjO0HEaqwKO4x8C95m
 fLEDpf4v82nondO+wuMA6LNUixeqyvB3drIQo7Xv7ZZknrospQPqC3Gp1jRNFVagBQZXSa0QWnI
 =
X-Google-Smtp-Source: AGHT+IGILEgBStpVz0htWTEfN2Dq5fZg9gBpREPVHoxX3R3xsgnpEXfkMUzst98JTiIqTxMT1N1Iog==
X-Received: by 2002:a17:902:f60f:b0:219:e4b0:4286 with SMTP id
 d9443c01a7336-22c535b49f6mr248768355ad.29.1745350724891; 
 Tue, 22 Apr 2025 12:38:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 128/147] tcg: Always define TARGET_INSN_START_EXTRA_WORDS
Date: Tue, 22 Apr 2025 12:27:57 -0700
Message-ID: <20250422192819.302784-129-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Do not define TARGET_INSN_START_EXTRA_WORDS under the
hood, have each target explicitly define it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/insn-start-words.h | 4 ----
 include/tcg/tcg-op.h           | 2 +-
 target/alpha/cpu-param.h       | 2 ++
 target/avr/cpu-param.h         | 2 ++
 target/hexagon/cpu-param.h     | 2 ++
 target/loongarch/cpu-param.h   | 2 ++
 target/ppc/cpu-param.h         | 2 ++
 target/rx/cpu-param.h          | 2 ++
 target/tricore/cpu-param.h     | 2 ++
 target/xtensa/cpu-param.h      | 2 ++
 10 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
index c439c09f2f..d416d19bcf 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -8,10 +8,6 @@
 
 #include "cpu-param.h"
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
-# define TARGET_INSN_START_WORDS 1
-#else
 # define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-#endif
 
 #endif /* TARGET_INSN_START_WORDS */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index bc46b5570c..cded92a447 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -23,7 +23,7 @@
 # error
 #endif
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
+#if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 63989e71c0..dd44feb179 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -24,6 +24,8 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 /* Alpha processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index f5248ce9e7..9d37848d97 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -25,6 +25,8 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 45ee7b4640..635d509e74 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,4 +23,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 52437946e5..dbe414bb35 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,8 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 553ad2f4c6..d0651d2ac8 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -37,6 +37,8 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index ef1970a09e..84934f3bca 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,4 +24,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 790242ef3d..eb33a67c41 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,4 +12,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 5e4848ad05..e7cb747aaa 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,6 +16,8 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 /* Xtensa processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
-- 
2.43.0


