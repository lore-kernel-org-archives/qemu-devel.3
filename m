Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65169C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKb-0001mR-P1; Mon, 27 Jan 2025 05:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKZ-0001lw-DH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKX-0001z8-BS
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436202dd730so29374485e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973615; x=1738578415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InMVf2ZZje/aoRKeRH0BkvDrp1REa1eaMrJrh52vEqU=;
 b=OfRvaGb4XFGPoGAEVYdiTAA63riwUnQE4YthH/AJ2W4d45KcLSYynoTOxXRzvYRPd2
 8ljgKWnAIl7kfy6KTmNOhXwrsfa9gWuWP9bPN+RO0H0St+F5X3z/RCz/MeMQcX3tMYur
 zDezuYd2zentahA9mlhN3wZLJVVdn0OqsCJ0rz6+rb0x2BaEQmJvh+qEK96INP5hrscB
 YhNTeqHydofimrS3G8dyheUPldd8HngPyvSPhhdUTtB1aHN9tl9Ejps9ZxyBPbLNHvpt
 nPCCTffxF6JDqYIyNsSGHn8jbHFlybrOLc+8dI37oe68XghybGjEGlAPyw/JDKEeplWE
 qslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973615; x=1738578415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=InMVf2ZZje/aoRKeRH0BkvDrp1REa1eaMrJrh52vEqU=;
 b=VYzZS5QSSbiKCNovfNSCdA2SOmOfJp29saNy3KvsryowqmZt4Ro9pumyo9jONi6FbH
 y2iczJy/ZpmYojLFkD6rXBpsDu6qtzdac1qYQ/hXI7V1LpQkADgqBuEqa63dpyGVh4ON
 fb0Kl8007MdgSIWae4g9Ckt2SbSmvbW5o7RnEekPApOqoMkHLtABBsl+iV/9hV8vNP0G
 PoBjeeFBm+klCiNWtHlHvN3iYNWtZ6CcGvFAmlT8N6cuUA/uVJM9g3pyQldNaJnghCcU
 pwE99swCGddFmnAVv/UJLR+rdM/VMbo5zlh7LZD6FLoNobfzarcrKNUMJn8zi4O3Qq77
 Ve0w==
X-Gm-Message-State: AOJu0YwZo8m/sqP/f81SIODM2zAXUHbLSG2dSSzQN9IpbMr08sJ4N9U4
 rZ+NWNZwlvLwQ5SD/D6Wb4dSt+LSMn5SXRnWmedXttc/WRTE6PB0W0C6fdu9Rp7Z+AyvfNfJFNQ
 xDcU=
X-Gm-Gg: ASbGncugxQFjLeBU9atDJuWtMUgno8RRE4mFrXFVt8utCCJilxILz+E6CFi52WoceQ3
 DJlaj6eP4p5A0YZ2nGYH7nkzioCqKuuaJGM0uVdMqdG53enO6QxeGsGeol5iQN+ynLvmN/QkJlw
 ju6HH+druubwrwCn6RvAqAMfasfsec49hQwUd/dwGK7ZlB8Ac1AwA4nHd1nuySe69pkRAX/r3DC
 l04O++Dk6FbvIjBH77yYk1KpFCOw0c0FgiDpEYF7IZBL/jq4bOpcHtBh716IoiiPtnhlaEPqpRe
 S7P7veNsH8N+6Xx1HMaBaDFo/jpH0UExA8zwjYgq8GFEKlB3jPSoZBo=
X-Google-Smtp-Source: AGHT+IG0Sr9qGrc05LVPnl2gmXU4pZ7+lAWnjW+8zeZ8cBX99j3kjiXqtFaKCnDoZk1jxojkhgFcXQ==
X-Received: by 2002:a05:600c:3d96:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-43891439dfdmr352013725e9.23.1737973614885; 
 Mon, 27 Jan 2025 02:26:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d3dbcsm129273465e9.40.2025.01.27.02.26.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/15] target/ppc: Restrict powerpc_checkstop() to TCG
Date: Mon, 27 Jan 2025 11:26:11 +0100
Message-ID: <20250127102620.39159-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Expose powerpc_checkstop() prototype, and move it to
tcg-excp_helper.c, only built when TCG is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h        |  4 +++-
 target/ppc/excp_helper.c     | 26 --------------------------
 target/ppc/tcg-excp_helper.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 46db6adfcf6..62186bc1e61 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -289,7 +289,9 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 void ppc_cpu_debug_excp_handler(CPUState *cs);
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
-#endif
+
+G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
+#endif /* !CONFIG_USER_ONLY */
 
 FIELD(GER_MSK, XMSK, 0, 4)
 FIELD(GER_MSK, YMSK, 4, 4)
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b08cd53688c..236e5078f56 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -400,32 +400,6 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 }
 
 #ifdef CONFIG_TCG
-/*
- * This stops the machine and logs CPU state without killing QEMU (like
- * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
- * so the machine can still be debugged.
- */
-static G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
-{
-    CPUState *cs = env_cpu(env);
-    FILE *f;
-
-    f = qemu_log_trylock();
-    if (f) {
-        fprintf(f, "Entering checkstop state: %s\n", reason);
-        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
-        qemu_log_unlock(f);
-    }
-
-    /*
-     * This stops the machine and logs CPU state without killing QEMU
-     * (like cpu_abort()) so the machine can still be debugged (because
-     * it is often a guest error).
-     */
-    qemu_system_guest_panicked(NULL);
-    cpu_loop_exit_noexc(cs);
-}
-
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 void helper_attn(CPUPPCState *env)
 {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 6950b78774d..93c2d6b5a03 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -17,7 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "exec/cpu_ldst.h"
+#include "system/runstate.h"
 
 #include "hw/ppc/ppc.h"
 #include "internal.h"
@@ -199,6 +201,32 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
+/*
+ * This stops the machine and logs CPU state without killing QEMU (like
+ * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
+ * so the machine can still be debugged.
+ */
+G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
+{
+    CPUState *cs = env_cpu(env);
+    FILE *f;
+
+    f = qemu_log_trylock();
+    if (f) {
+        fprintf(f, "Entering checkstop state: %s\n", reason);
+        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_unlock(f);
+    }
+
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+    qemu_system_guest_panicked(NULL);
+    cpu_loop_exit_noexc(cs);
+}
+
 /* Return true iff byteswap is needed to load instruction */
 static inline bool insn_need_byteswap(CPUArchState *env)
 {
-- 
2.47.1


