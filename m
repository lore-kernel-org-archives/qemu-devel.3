Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F1BC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQv3-0007iK-7w; Tue, 04 Jun 2024 05:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQv1-0007Sq-HH
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuz-000282-1C
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35e573c0334so1245505f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495043; x=1718099843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cmg1ayuApwmH79kPzx40QOBelO6dVSgqwUpaSLnFGiQ=;
 b=YHiAQmUrSvdPbTySjrFpb2kMvhNiLXAd9lpVFSjnBQinrhDJ1mjfPoPU6ccvKe8nV6
 /aO+UnKUr+JfRzIoqRUUUox+mXe4XuIUBdO4qOnEK1RGfgjafI7rwX6U3nJvGv9AoHD2
 URCt/1/nCqUVUKscFCnw9cawRDeYcCe5ZDzaILYoegSYwHwozyTXP200wfbJCI7fmn27
 iBVlKQW10bcG4VbPY+IyyJ+jN/oQ63awjBw4p3k36qdagbu6guWLjx8uEQnru/juNozO
 zudkoXnDx9BTkY8iouMx00xmiJ8OMXCfOpYyDF4uz2n4n517iKXLGQ0HQqdPv/btnCQt
 sT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495043; x=1718099843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cmg1ayuApwmH79kPzx40QOBelO6dVSgqwUpaSLnFGiQ=;
 b=fOejli+M/+6OrPPsHzkeBpZXfC6yKMlwv734aOHBv0oGkpOtXxD0hl5WIwd2KDp6WR
 GmRIH/hZ6LLLwBwtV2JOPobiSpmKEc6jwMA4k4+cy78SbALQ4fMA2xBtX5gj8Lonxs96
 HNc26g6anyUgl70FPuhGdVrdecrQuXyKAejBojfCHmjN3a0xvGB726oQzKUEN95NdVHw
 p36MOSZ9GeYlgxKdCV6X82NV9lB8DgZTkFz/p49KB0YDK4aMguAeA9/HFvxDdGayJAot
 +39q20plA/jtapDroX+q0oFcjEmloBLMc3sTWsgIq+8fZv5q5GpFyei3AjjZ8DdnfULi
 5S8A==
X-Gm-Message-State: AOJu0Yzaj9Sn4u9KMXjpzcYI1DpZy4a0U4if1GMBbqPpXbVMR3r+yHM5
 13FKH0tslQzz6T0KveAmU0Ez+ucrKCPIq5w53JM5qRTOP47+qAS7Eo5z1zVAdswwH2XqqjzkvJI
 Z
X-Google-Smtp-Source: AGHT+IGE5AOIrfCmNaVABCZwujJ4Jv/skudobAVX++pyZBQDmCuC7KkxIGxPbJdpbWoDP1LLu/TQqQ==
X-Received: by 2002:adf:eb4a:0:b0:354:ece6:d9b9 with SMTP id
 ffacd0b85a97d-35e7c54b2b9mr1879055f8f.15.1717495042682; 
 Tue, 04 Jun 2024 02:57:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e4f0fd15esm8443084f8f.68.2024.06.04.02.57.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/32] accel/tcg: Move common declarations to
 'internal-common.h'
Date: Tue,  4 Jun 2024 11:55:49 +0200
Message-ID: <20240604095609.12285-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'internal-target.h' is meant for target-specific declarations,
while 'internal-common.h' for common ones. Move common declarations
to it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240528145953.65398-3-philmd@linaro.org>
---
 accel/tcg/internal-common.h | 15 +++++++++++++++
 accel/tcg/internal-target.h | 14 --------------
 accel/tcg/tcg-all.c         |  2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index cff43d221b..a8fc3db774 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -15,6 +15,8 @@
 extern int64_t max_delay;
 extern int64_t max_advance;
 
+extern bool one_insn_per_tb;
+
 /*
  * Return true if CS is not running in parallel with other cpus, either
  * because there are no other cpus or we are within an exclusive context.
@@ -41,4 +43,17 @@ static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
 #endif
 }
 
+TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
+                              uint64_t cs_base, uint32_t flags,
+                              int cflags);
+void page_init(void);
+void tb_htable_init(void);
+void tb_reset_jump(TranslationBlock *tb, int n);
+TranslationBlock *tb_link_page(TranslationBlock *tb);
+void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
+                               uintptr_t host_pc);
+
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
+void tcg_exec_unrealizefn(CPUState *cpu);
+
 #endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 4e36cf858e..fe109724c6 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -69,19 +69,7 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
-TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
-                              uint64_t cs_base, uint32_t flags,
-                              int cflags);
-void page_init(void);
-void tb_htable_init(void);
-void tb_reset_jump(TranslationBlock *tb, int n);
-TranslationBlock *tb_link_page(TranslationBlock *tb);
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
-void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
-                               uintptr_t host_pc);
-
-bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
-void tcg_exec_unrealizefn(CPUState *cpu);
 
 /* Return the current PC from CPU, which may be cached in TB. */
 static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
@@ -93,8 +81,6 @@ static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
     }
 }
 
-extern bool one_insn_per_tb;
-
 /**
  * tcg_req_mo:
  * @type: TCGBar
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c6619f5b98..2090907dba 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,7 +38,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/boards.h"
 #endif
-#include "internal-target.h"
+#include "internal-common.h"
 
 struct TCGState {
     AccelState parent_obj;
-- 
2.41.0


