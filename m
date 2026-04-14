Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF9F531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRhX-0005z1-JV; Mon, 13 Apr 2026 20:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhE-0005jh-HA
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhC-0003Mp-Pm
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so2934523f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126721; x=1776731521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqimOdJ6hFzYLdeBM1HdjXv15zxnUiOqn0YPr8e4A/0=;
 b=J3rUscBDQ5kYcgZri7Fy0sXMqwzTAUahuniyX0Te0sm3QmfS+gwo+bNgdSoXxqH0Qx
 P95lkWLf4aUUcUEdA/OiHwFAkihdJr9KUaEC0zFfvsJag+egkWpjpgQC7o15nSfJ1hDW
 Ef+b8mb25V4caclGE268n4n9iq2cRgLnbt1PJVl/DqPuISJ2tQPaG/kRGtpgSx7+TBf1
 iFgkSZhNWUqb07j3qyiubBTgN7f9AYX23k9Ehs5dYbFZpupqkxnbHBtbc+NwywT82OIT
 K/k9myCCVoHiy5VN+JvSwoDSF/eqaLq9uzA5T7F9a1ki3w/z5YU0ILveAGyvmkmZd6WS
 T5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126721; x=1776731521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SqimOdJ6hFzYLdeBM1HdjXv15zxnUiOqn0YPr8e4A/0=;
 b=J+Uxew2QHRlAEosmwM/mzLh/Ew0Z84M96VjXR3eotoFTdDraisD/m+tulKaYAGsyyR
 U2gAaWpj4Sqe4bz/dbnzLt54hy1b5/3yXTmzMSAtorFCXd+maJchbAST8QZ4TJkFaCqw
 Vr3kvtgLB4yoiRBzneQr4Ye4+3TGNa6Eq08PYjN6NbeSZdV+2oqYdYjI325NfpjroL+c
 CLYIFLrW+aGF7w9Rxt60qziLRHzuyYrqMVNOMiDCkxiFkaooGFVbXA8AYuzlAvaP3faD
 xg44HOzDK3LtfeD8huKjqp3px1fm8+0zUdcdSUuDbQ9poWXVthn4uKVmrS75poXgGzo7
 uICQ==
X-Gm-Message-State: AOJu0YzFq52wvc+Upj0IxLymB8NNT790AEPDX+/0PR/oUDMACm2jzjy9
 IlVeMgo0/O7HmrHRv0nE/Uk1h2EOsSTJsUgayt2mf+ZlrZs2Nsobb0tM5tSHKQgrVREKlFv8R9l
 3YZvX1zQ=
X-Gm-Gg: AeBDievaNaRkX9QG3WzM7nQMRd8TOX/deRvZ04XZl9d2uoa1B2E8WE+qlAUz8PYXc+X
 TCJFTNvNpSMQp7IGIU2Bi0lTu74gIYkXLt5Sv29hVRkz7ZlLFCPajihktMxF1aMzR/Ql6PAVq72
 wOf+hdpzlobd96znqhIgqDB8B7mcN2evY2pQP+r2bUOw/VRysm3C5fDlunTMb09oI5pZimDqP7r
 X4vWQfukejrXwqtiAHmLJrxvhWEWd89yK+oDsvAXYcLpJySU6cj7803OK/yH9zOW3Zo+dRUJWPM
 tLtasDxVK5Ah6/5daKo79e1jmgAvLXTb3pyh+zxRLHxtdNtUXThUUz6Dv0fmxnd3M0A5IRpIUJu
 6duY/8r5Kbt4fHxKu+csqRkJj2UV/iuQzOm5jX1V5Ri+yRiKHM072rG2KwJpIS7gNABompds4jV
 ZmA4IdpXX+ljXdOOSz102zOJ+ozO7MT+7zwoT98cpa4HB3F1gPq5Sh1W6NpCMoxYNsYKMocVM9
X-Received: by 2002:a05:6000:1087:b0:43d:6a13:1efd with SMTP id
 ffacd0b85a97d-43d6a131f32mr13020649f8f.6.1776126720527; 
 Mon, 13 Apr 2026 17:32:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ea5f26274sm1779835f8f.1.2026.04.13.17.31.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 16/27] target/riscv: Register target_get_monitor_def in
 SysemuCPUOps
Date: Tue, 14 Apr 2026 02:29:48 +0200
Message-ID: <20260414003001.97571-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
and register it as SysemuCPUOps::monitor_get_register() handler.
Take care to sign-extend values for 32-bit HARTs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h |  3 +++
 target/riscv/cpu.c       |  1 +
 target/riscv/monitor.c   | 11 +++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 460346dd6de..28b61d25888 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -245,4 +245,7 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      int64_t *pval);
+
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8ac935ac06e..dbd88fa6655 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2720,6 +2720,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
 };
 #endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index a9d31114442..00a68c26abc 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -27,6 +27,7 @@
 #include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "system/memory.h"
+#include "internals.h"
 
 #ifdef TARGET_RISCV64
 #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
@@ -311,16 +312,18 @@ static bool reg_is_vreg(const char *name)
     return false;
 }
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      int64_t *pval)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *hart = RISCV_CPU(cs);
+    CPURISCVState *env = cpu_env(cs);
     target_ulong val = 0;
     uint64_t val64 = 0;
     int i;
 
     if (reg_is_ulong_integer(env, name, &val, false) ||
         reg_is_ulong_integer(env, name, &val, true)) {
-        *pval = val;
+        *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
         return 0;
     }
 
@@ -369,7 +372,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
          * to do the filtering of the registers that are present.
          */
         if (res == RISCV_EXCP_NONE) {
-            *pval = val;
+            *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
             return 0;
         }
     }
-- 
2.53.0


