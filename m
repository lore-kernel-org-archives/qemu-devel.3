Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F94E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoLu-0006z7-2k; Thu, 12 Dec 2024 13:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLX-0006Tm-82
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:37 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLV-0006pf-M0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:34 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee51c5f000so656450a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029732; x=1734634532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziwrhan20pghgkypPdFtUixUvLCoelaBHFetr07pBgc=;
 b=yMu1IIsN01z52n5su6yZffIIwa8ADp1YFG7Lhe6fR2inJHeJ9HElGs031pke33avwX
 8zLFGZjZTy6aClwEm+EkAfkqRHRjN4wGJowPEl0iHfFC0QBdOhlvO88SR2moUojQnFf5
 9slG/7Ic+SiZGfTNVhMvLsF9AWbw8ABqh+jlVXdmV8AtemCdzsgWql4VtrpQy3O+0w7i
 tELgQDzRkcmqYq7aowadqpByjHjHusy8fcN8+NmCWzlgXtMUaAxUVroh0NChYoEJkPsL
 HSitagiOWrcnvm0VSfgGExn4tIZgx4XGdOP5XVP3otXcUzOmHOBl3q+ww4msKW7hxL6i
 KNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029732; x=1734634532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziwrhan20pghgkypPdFtUixUvLCoelaBHFetr07pBgc=;
 b=Zxlqb5BQsHHIdGlaiyEV/H/2MEdM48gYM2tzF9//egrJqk4h5LOOwtcNbgOiglskvS
 M0mf4C1diZr2P9gj8UdHmJYxaiyDAhMj7USGR/LnTjLoFw2Oe9AMUbKFnbKPiZ4fnQn6
 cpM4vIxov5MT2tysi7ftn7teAdH8HaKuBEM1sPfV/YZpjtqzlupYl4aXiQZk198OzofX
 QpEdc10krtTOQV/jXG85X4QR87/irVlWHXRELtRu9diOgPJbeBTVry9DCFqx97LXnc9s
 cNTSigGFGT3Owx7kBhXpzKMfm3Kccm31qS2QmJc/CfeUuiY2WKOt8RvY/OeMJl4/uaKI
 xLXg==
X-Gm-Message-State: AOJu0YzMEMqIzUnCWOmLfkULI8ROzuLmTf5APKrv0Kk5D9FYvBCsSYB1
 bmv4bFd8w8d6y99YTr7TxLsGCm8DyW0XU2EcucQIuCg8UNVV2BPHwA6qIH0InK9C9g11QunaLUV
 W
X-Gm-Gg: ASbGncsuMny4/AH5E5clxoNkzHqNjb0gCfqzEk2NunlqFwBzr/ZenQ0UZu/pwO33jYt
 ao21A4BeeAbWmgyTznMwhTzq24EL29/QTWmFLQByVjk7rPnPYVSEW5C8kvUmS8bMz25Bhb1zd7+
 3E+Cc66I09Av+F38/bpZrs7I4EfMZc/kyJCGz5tPdUvB8xNH7Sd9pccauXwsg1pLiz4KOt+GzJ6
 Ojpluq6MxhZM5yAJHvrNtvF0J1cEDwdPqN/tfyQrGRlheQr3CmEb3mUPFRWdUWgzUASAHPAZMkN
 4TVMD+KGP1QC5ouv5NVHsafzixeQ7qc=
X-Google-Smtp-Source: AGHT+IEjVYnKYHst3x982Mj+S8+Yf9LbZFi2Xvy3Us7PwtpoPXMWd780sprz5mJY06DeBw3Cpo5qdg==
X-Received: by 2002:a17:90b:1a8b:b0:2ee:7538:be70 with SMTP id
 98e67ed59e1d1-2f127f5502emr12265129a91.5.1734029732064; 
 Thu, 12 Dec 2024 10:55:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142de347esm1620629a91.25.2024.12.12.10.55.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:55:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/18] accel/tcg: Un-inline log_pc()
Date: Thu, 12 Dec 2024 19:53:32 +0100
Message-ID: <20241212185341.2857-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1032.google.com
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

log_pc() is only used within cpu-exec.c, no need to
expose it via "internal-target.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h | 10 ----------
 accel/tcg/cpu-exec.c        | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 6f4ec0bd424..0437d798295 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -72,16 +72,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 
-/* Return the current PC from CPU, which may be cached in TB. */
-static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
-{
-    if (tb_cflags(tb) & CF_PCREL) {
-        return cpu->cc->get_pc(cpu);
-    } else {
-        return tb->pc;
-    }
-}
-
 /**
  * tcg_req_mo:
  * @type: TCGBar
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f82870a1e2a..396fa6f4a6b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -21,6 +21,7 @@
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
+#include "hw/core/cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
@@ -434,6 +435,16 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     return tb->tc.ptr;
 }
 
+/* Return the current PC from CPU, which may be cached in TB. */
+static vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
+{
+    if (tb_cflags(tb) & CF_PCREL) {
+        return cpu->cc->get_pc(cpu);
+    } else {
+        return tb->pc;
+    }
+}
+
 /* Execute a TB, and fix up the CPU state afterwards if necessary */
 /*
  * Disable CFI checks.
-- 
2.45.2


