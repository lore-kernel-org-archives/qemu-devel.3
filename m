Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E4AC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJN-0004B4-Nv; Tue, 11 Mar 2025 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEB-0005HS-O1; Tue, 11 Mar 2025 09:01:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzE4-0000AK-NB; Tue, 11 Mar 2025 09:00:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224341bbc1dso67994515ad.3; 
 Tue, 11 Mar 2025 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698051; x=1742302851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyPpxpR1LPgC7kHmIhSLHr8dyizfyqPn+5SkC4Qa1kM=;
 b=eb69PDmc6vgFL5ZGMpEkb/6i2Vb6ANHUT0/1zgouWOqdAJIZMQmqTrjh1BuBT6V+ua
 aSwtkdo7d7cm2cise4vFKrUK9eZgrvNYCuTS9SQ34kQHWt+LTAErsw+GdZyDC+1a7AYv
 jeGDJEgmU7mEaSGEzf89rLqgKLG4QkPJwQQ+ewqYfvQ6gEv6LoNltHtglWnZCnIqZ+Cj
 /vI3denqz7CA9Zl5wS5k23382xW+uImEslHyMAxfDti/i6lMh8/IItJtbiJoOPm7B6u1
 BmhySgYv766x1l3XPSjgWwvGxR6ONRBzlWOfpD/XcvIuKUuXNLr7KNLGbzs16jU33FlU
 Rd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698051; x=1742302851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyPpxpR1LPgC7kHmIhSLHr8dyizfyqPn+5SkC4Qa1kM=;
 b=dBLpFqJxPXPy+2Kmi6Ky0ZjVAx/RpSKjVlZWPyQE26NFywZZMZtOscK9sYG9LuuBCp
 ott9VHRo6xBu7Xbwdx8Bi39i6ziIZE85RHSxs+tzZ3dM9qppTWLF15ic2L8PliNlapSz
 W9yeUpemkPZXPaLfmx2cRp6GDAdNid7yJLVoJKP+8Va8rXOlsN7rhbmUquh495r216T0
 DNyH7HouvDwi/s2i3RlHcNSYco1+eqEkvZ8MRg4Pz+AMghXMP4bzdlQ7YsugRDYrmwAA
 92nspWVqbaGj7Kmpl3q/bHK5WitawxBK9yR4+3hu3RYyw4Tbk40VrdSX3cRwAoDVi10H
 4xwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXohdBXpmIkIppv/mAraqR+QnWhjykf7WOHbxBDgmK4qJyZf1l/mMoRlqtW6jWGGVH0z7lL2m06gQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz4k3Y8ih8Uotb6UvBN1Gnp4/iPYxD8CrH9ewlRFxS+GxJ9QHrJ
 jzYgtTH0dEtZCvW2KF7pUkkwezi1/dXtvNAYwv1F3LbvPr5Y0FvNiPlwrA==
X-Gm-Gg: ASbGncti2/TSZvvHusWKJGyPkg8dMIZDgt2utdFE/6MIV9NOVTkgc7/4JCXs412q4WL
 4WDXBQKscmNi81SVIdPFfeo7PFiY3JvrED7LfbgNcVJ+OwmYYTt2JB67Ougsym2xxYEn+0lQ2jc
 y+AuakrGvwAenWjxK3LLwC9ogU4OObuyjj2EwYaJhFyripNlRSHLRYpBkQFVScmWO4VdZd1RL9T
 cug2PUMdZ26nsDyvmVQ69Ueyumm/9zDBZR2qQPyrO4JF1N8OKDPi3qPQER7TgE5jopV+FlDeu92
 h+kHVQw3jSZvDcvCXHB81940gnhTJ5uVpEHIPhU1QGTlsCjgYXY=
X-Google-Smtp-Source: AGHT+IG3/dJF0uCdNybHet8gcnCbHhEvUcYDAyybd/VVNwW6hC8T/djteCM/ofz2DtXmA4DQfaZzJQ==
X-Received: by 2002:a17:902:c94d:b0:220:c066:94eb with SMTP id
 d9443c01a7336-22592e407damr48788845ad.25.1741698050538; 
 Tue, 11 Mar 2025 06:00:50 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 47/72] target/ppc: Restrict powerpc_checkstop() to TCG
Date: Tue, 11 Mar 2025 22:57:41 +1000
Message-ID: <20250311125815.903177-48-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Expose powerpc_checkstop() prototype, and move it to
tcg-excp_helper.c, only built when TCG is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-8-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c     | 26 --------------------------
 target/ppc/internal.h        |  4 +++-
 target/ppc/tcg-excp_helper.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b08cd53688..236e5078f5 100644
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
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 46db6adfcf..62186bc1e6 100644
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
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 6950b78774..93c2d6b5a0 100644
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


