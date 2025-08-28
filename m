Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8866CCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbX8-0000Mr-2V; Thu, 28 Aug 2025 08:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS8-0003SZ-Rd
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS6-0007Md-FC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso707507b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383000; x=1756987800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbyT5R6klG2h52SSw2CW+OGcOtC0Zmu7aFbJ12I/MfY=;
 b=kTT+HEjoM5aq9O5CaJ/UTrNDqMam6xjDMuA9uXHzx1qvgbhpo81GyGDQbLrfRcOOaq
 KE2qYdgd7PRc5e2rsC8UJnzP3EIvBlwj0GC4/Vouw8X+huo3+C3SUIfItq7xQtzNE8SN
 7cT9mMAFgbcRYlFKMNf2LtvXq+5WgGDbA9IriLMJhHdwxpWZaeZ/b2S6k3e8fUBm/sXo
 1/+Kb/vbXYpGwuaOE7MCq4woKWVGkCakq1V2vPBUgEhyMsLVLAcudBdmJ6gcURcWDUCr
 TTV+jrJ0HRu7Yiikh01iHQzzL1jLrYMWLMOoXQPnT39AMk1XCWmjQ6OYwGW4s6qa73Ac
 xC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383000; x=1756987800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbyT5R6klG2h52SSw2CW+OGcOtC0Zmu7aFbJ12I/MfY=;
 b=PIEL7ZPokVSc9J893q/AUlRp6JphBbve2am7MyXo3oCsDA23o5k8PexRebEnZbi6H7
 sNSsB52E7aHhdYkJGtqgA14Ni3QmFcAXzJMdiyUi/QsMIhrdrksKRRmXzREZTgw+4Ob0
 xkByXmrlXrtjswaWmqqnDKzikQRt3aQZDSYoKcDHauiyGgjmReJHy2f7H5E82N5eoAw6
 rX7YysZNIwaM2AN67mVPOTvORsvthbJk4CLBxCVEWRezM+S1U/+7vq/iiQCyJCUeMVyz
 udtPlFmdmol76s2fzbuIszj13FsTqX8TAOuq/17pMv+IUT26bKf3uJqR5aKPodDx8k1x
 e62g==
X-Gm-Message-State: AOJu0YzwEt6x4uJUTWSsbR5cNe2ywa0A+/jVIS4+knZsdqtByw1zaI5N
 TR5lV5KipYmF2cUGU3d69Q1RMZTKDSyZdGCuhg+5ZfTu7yiIT32cm/b6NGKlMdwzADh5gug8dYM
 h1SLVopE=
X-Gm-Gg: ASbGncu9saiaSEqFHb3lvCVKN0iQtENXN6RzjQBaA6OAssF1Ok3ZESLraBS1cXJMOJy
 HiDx/a8EzbdCsxOIXe5cV3zWviC/uKTip0qwKFWES4Tsd58FnufIUuYIHBqQr5BZEl25+b0Hi5L
 IpfRwE6WmRHzTBmDQQb/PkywNPx/sC1c9GhSIjwdYi+dwFccJMsEwQ3n+LQgxNRkdPpTBjOg9KY
 O8SOTgI7EV+nIUZSNzRRsj6dmrtPcxOiDOQzTctSr1d4nnRiXZ1GK/NZDWAhSGFRyLjS69tr0GX
 qQMSOl+hb9+MQZ04H9ymMqhfD7MZ7wYcn4q09niUhk2up1fX88WxLFQCaqzB0HhXF4RhZ/4wsC+
 UZysjbdJBIBLIwMArxUJv8RvriQ==
X-Google-Smtp-Source: AGHT+IH9HHKYFZN6TNeXQJNK8uZ34VS/txk5MWqEbvTDd8VHT5FTD8/usHhc6DZufEXNxL0cdzIl4w==
X-Received: by 2002:a05:6300:4ca:10b0:243:a251:cf46 with SMTP id
 adf61e73a8af0-243a251d3f9mr4837606637.32.1756383000080; 
 Thu, 28 Aug 2025 05:10:00 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 33/87] linux-user/x86_64: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:42 +1000
Message-ID: <20250828120836.195358-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The comment re ELF_NREG is incorrect or out-of-date.
Make use of the fact that target_elf_gregset_t is a
proper structure by using target_user_regs_struct.

Drop target_elf_greg_t and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/x86_64/target_elf.h    | 14 +++-----
 linux-user/x86_64/target_ptrace.h |  2 +-
 linux-user/x86_64/elfload.c       | 56 +++++++++++++++----------------
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 74a77d94cd..32a9eec431 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -8,22 +8,18 @@
 #ifndef X86_64_TARGET_ELF_H
 #define X86_64_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
- * Note that ELF_NREG should be 29 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
+ * See linux kernel: arch/x86/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_regs_struct via sizeof.
  */
-#define ELF_NREG                27
-
-typedef abi_ulong target_elf_greg_t;
-
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_regs_struct pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/x86_64/target_ptrace.h b/linux-user/x86_64/target_ptrace.h
index ba162569a6..33527127cb 100644
--- a/linux-user/x86_64/target_ptrace.h
+++ b/linux-user/x86_64/target_ptrace.h
@@ -23,7 +23,7 @@ struct target_user_regs_struct {
     abi_ulong dx;
     abi_ulong si;
     abi_ulong di;
-    abi_ulong orig_rax;
+    abi_ulong orig_ax;
     abi_ulong ip;
     abi_ulong cs;
     abi_ulong flags;
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 76cf5c1509..18d632ec34 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -21,35 +21,33 @@ const char *get_elf_platform(CPUState *cs)
     return "x86_64";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
-    r->regs[0] = tswapreg(env->regs[15]);
-    r->regs[1] = tswapreg(env->regs[14]);
-    r->regs[2] = tswapreg(env->regs[13]);
-    r->regs[3] = tswapreg(env->regs[12]);
-    r->regs[4] = tswapreg(env->regs[R_EBP]);
-    r->regs[5] = tswapreg(env->regs[R_EBX]);
-    r->regs[6] = tswapreg(env->regs[11]);
-    r->regs[7] = tswapreg(env->regs[10]);
-    r->regs[8] = tswapreg(env->regs[9]);
-    r->regs[9] = tswapreg(env->regs[8]);
-    r->regs[10] = tswapreg(env->regs[R_EAX]);
-    r->regs[11] = tswapreg(env->regs[R_ECX]);
-    r->regs[12] = tswapreg(env->regs[R_EDX]);
-    r->regs[13] = tswapreg(env->regs[R_ESI]);
-    r->regs[14] = tswapreg(env->regs[R_EDI]);
-    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    r->regs[16] = tswapreg(env->eip);
-    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    r->regs[18] = tswapreg(env->eflags);
-    r->regs[19] = tswapreg(env->regs[R_ESP]);
-    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
-    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->pt.r15 = tswapal(env->regs[15]);
+    r->pt.r14 = tswapal(env->regs[14]);
+    r->pt.r13 = tswapal(env->regs[13]);
+    r->pt.r12 = tswapal(env->regs[12]);
+    r->pt.bp = tswapal(env->regs[R_EBP]);
+    r->pt.bx = tswapal(env->regs[R_EBX]);
+    r->pt.r11 = tswapal(env->regs[11]);
+    r->pt.r10 = tswapal(env->regs[10]);
+    r->pt.r9 = tswapal(env->regs[9]);
+    r->pt.r8 = tswapal(env->regs[8]);
+    r->pt.ax = tswapal(env->regs[R_EAX]);
+    r->pt.cx = tswapal(env->regs[R_ECX]);
+    r->pt.dx = tswapal(env->regs[R_EDX]);
+    r->pt.si = tswapal(env->regs[R_ESI]);
+    r->pt.di = tswapal(env->regs[R_EDI]);
+    r->pt.orig_ax = tswapal(get_task_state(env_cpu_const(env))->orig_ax);
+    r->pt.ip = tswapal(env->eip);
+    r->pt.cs = tswapal(env->segs[R_CS].selector & 0xffff);
+    r->pt.flags = tswapal(env->eflags);
+    r->pt.sp = tswapal(env->regs[R_ESP]);
+    r->pt.ss = tswapal(env->segs[R_SS].selector & 0xffff);
+    r->pt.fs_base = tswapal(env->segs[R_FS].selector & 0xffff);
+    r->pt.gs_base = tswapal(env->segs[R_GS].selector & 0xffff);
+    r->pt.ds = tswapal(env->segs[R_DS].selector & 0xffff);
+    r->pt.es = tswapal(env->segs[R_ES].selector & 0xffff);
+    r->pt.fs = tswapal(env->segs[R_FS].selector & 0xffff);
+    r->pt.gs = tswapal(env->segs[R_GS].selector & 0xffff);
 }
-- 
2.43.0


