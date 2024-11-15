Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97695D68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8i-0002ga-0s; Fri, 15 Nov 2024 10:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8f-0002Wu-QZ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8e-000485-26
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so16090545e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684092; x=1732288892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5wTkh/tztyRKNsfUcuDCaLezbrFiqbSDF32QCsIdnM=;
 b=lTJLxhxoldrbF3mcvntkIDDDmt2DAPDfZuZgPLYKoVYqN0WGkf6/EHJyjjsFEAlxZb
 SKZZkhSWR2258yoiTdwiYbN+tHk+lHo7sGdityBF2CLtwu175wz6wrgs1BG/jyK9niq3
 Ns0z89k4wxzx3Gh1SKZ60kpvyvTOAFju86NWAicQgT7ZXpcwg6cKSYJDoZorAWh5laZ1
 5MfF0JPJRZeJ4hWBYZrA9PdnKrf/3zv5H+t9vGMs2QayMxrPUELny9pxFuAKvasnueu9
 eSq9a16+uT/3Wx4MbVC79KsmyfW2hCpFoeTPAkjfOULoncusKdIMcPZP62xJf4hI6uMG
 HP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684092; x=1732288892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5wTkh/tztyRKNsfUcuDCaLezbrFiqbSDF32QCsIdnM=;
 b=IR35S5K3JjyRJKwXXVYjuvDqYuaSvi45G/ALjb7wEoycoTVZLm7wg/t6RUQqG0WgSA
 vAKXHsTNznl7PmwIRA+zpKInMeQTS8L6LD9ixenVxUd373ZNH3f0995KWKEcgR8XvMet
 3eXwalyg7SHhkGd5PZZ2fNHr0/fbmyvbUX9huK9HlzWWxcFYn4v06bdrDR8JRiJpgR5C
 cZWfAbwLfdTNAetWiUm2ZtLjdHvnXbBbvuD0Xqs/Nb6tAZWiImuqnUAOGhXox1M3u/kM
 3U1LIGZLnB1eNXxIowx11mn5sxfB0YkugXANVO2ML9RV+Y5z5h11HS0a8nEcv/1b8/Hf
 liXQ==
X-Gm-Message-State: AOJu0YxHNqaX8VnzGrEs48PpzDsPGFKANZq6Kle0O7gdahwFUxQ3CUW9
 tqPkMb+Xc03qro0UM4n870RjUHHHWojphx9FFRZ6zXkrIO0I+yEens1jAxAQtX+yBs+2lEZIreB
 R
X-Google-Smtp-Source: AGHT+IEws/cKA1SJsZDLtdIHB5PGgZ6EERwXm23XXKlLIop7YAvzL29TZI+Sw4gSL4W0at70NsS4wQ==
X-Received: by 2002:a05:600c:1387:b0:42c:b45d:4a7b with SMTP id
 5b1f17b1804b1-432df78a971mr24952685e9.25.1731684092591; 
 Fri, 15 Nov 2024 07:21:32 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da24459bsm61825705e9.6.2024.11.15.07.21.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/10] accel/tcg: Reduce log_pc() declaration scope
Date: Fri, 15 Nov 2024 16:20:50 +0100
Message-ID: <20241115152053.66442-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

log_pc() is only used in cpu-exec.c, move it there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h | 10 ----------
 accel/tcg/cpu-exec.c        | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index fe109724c6..750b3706b1 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -71,16 +71,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
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
index 033f5fab10..73bc9f00f7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -433,6 +433,16 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     return tb->tc.ptr;
 }
 
+/* Return the current PC from CPU, which may be cached in TB. */
+static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
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


