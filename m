Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9348ACD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoJB-0000vT-CD; Wed, 03 Jun 2026 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJA-0000vL-50
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:08 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJ8-0001VW-I8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:07 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7dd7818ac2aso62346717b3.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780503545; x=1781108345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c0WQBCu0poxsHhDkr66FcJ+v1B4l82uzEU1uE4brKXM=;
 b=nihK5phK6TiCx2B26SSdNYKnzLx1qD0gQoVPfMflEB3KL2wnOG5oabM7yG5BrROvcb
 odgx2nQ3N27wjRC/29WRBDSQFFWqPY31Zr0w5MgBZDzbYdbA68m3xLVDH2ahw5W4T75F
 xriBMA4mxHnBTSvHs7jYy7q/MFSrb4sArZmVzvbZ+nSUJ1lPvbx3gO/rBs52OVlx9c/C
 6zDDzrqxZeMg6H0teTDjzZdbUSc98/BSG90COv9roxcvJRrH/Hl/Xl/xP7mZL9jRkVAh
 ugeEuf8BjtFks3tHrNa4uIRjOLFCX/kU61f9kSAhzy5CMMQ/9ZVqpseJK/3QzveoM44G
 c53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503545; x=1781108345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0WQBCu0poxsHhDkr66FcJ+v1B4l82uzEU1uE4brKXM=;
 b=h8RV88cD5epfX6OUWUeMcknl8TgUifhNqq0ReK/IEHS0XGkeEKgpAEMeFRX2OGdYNE
 VVJsYOq1j5M4ZKwMglmC/RdRq1UpWTZbwisSKcAcqYv7mq1Nox8+T+nG7e/0aJtzEVBC
 LTH72WFjR69IH2LlEJHitXlhk+huJjgDTH7Ix8wwC9lhaMsCwmJpRe+RP8LsC/fAfgeV
 Xf2/zt6PJAhM+WdgGnwbzbeeaJ7QyM4J3wADj8/+mlMUWMoMHvUeZkkhWoHMqd2YvAsK
 4U95DWFQG42gNWOgC3Yt+zfKEkfb7vfcToJUuRtajecS0+HqaoOkom8K622B9+xd49eZ
 N32Q==
X-Gm-Message-State: AOJu0YxCQP3RVjceeqn667+c/AqnyEqNpHpF57VWDTLOH5p6AsAInw3a
 wKPlFOQ0Swx4FX1x7GrYA3iqXSnKnnU0VnKvBFiE52gVj9DrXaaefK4ikiPk2wkyNDM=
X-Gm-Gg: Acq92OG2uZiC5TCgyF69+5LmKP8g1JKj76+ikXAHBQQJ46FpzHwXNsinAn/FHFcHQOM
 sKCbTQf00aTJes26XJpjjU9Ery6gfWoFSSc7btrbNdXmcLuB/+fBn/ZrZkcvVVwtUs4erQ0TBOI
 XUgEFyj5r3uX38Qz2H3BYDzdZEcoaMsgFghJD+0ni6ldKtB6niTda/esHoYIEpffzdH7f8+/4iZ
 AiZ3mThnPDxxDea9RgISl+vXRW/4E0nJmbX+vmnkkudrYXo9t9FBgS3UGGiZVjkDTz9efJxMK/J
 Mu43evK0SD7EZNFMiveOIvnXT7HS6wAAUwmR/OvZD27SjfTAxY2xTDnIdQX1iHRgCmhqF4FuAxn
 2+P7nqvjl1FNI0NLq6n5X5nENfhHi01d1NKFD9DiZoqpr7R37Wddl5hv2NRqpC9ZQgpOH34aEpp
 5rAlOT7ttifDEVPZf2wxFZrsOboPJsc2UOeg==
X-Received: by 2002:a05:690c:c52e:b0:7b2:9347:7bdf with SMTP id
 00721157ae682-7ea4ca9256fmr40128207b3.37.1780503545183; 
 Wed, 03 Jun 2026 09:19:05 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea24098d74sm19419377b3.48.2026.06.03.09.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:19:04 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 1/4] linux-user/sparc: add coredump support
Date: Wed,  3 Jun 2026 12:18:49 -0400
Message-ID: <20260603161852.1831864-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h
sized to match the kernel's elf_gregset_t:

  sparc32/sparc32plus (ELF_NGREG = 38):
    [0]      PSR
    [1]      PC
    [2]      NPC
    [3]      Y
    [4..11]  G0-G7
    [12..19] O0-O7
    [20..27] L0-L7
    [28..35] I0-I7
    [36..37] reserved (stack_check)

  sparc64 (ELF_NGREG = 36):
    [0..7]   G0-G7
    [8..15]  O0-O7
    [16..23] L0-L7
    [24..31] I0-I7
    [32]     TSTATE
    [33]     TPC
    [34]     TNPC
    [35]     Y

Also define ELF_MACHINE as EM_SPARC32PLUS for TARGET_ABI32 builds,
matching the kernel and ensuring the correct machine type appears in
the core file.

Implement elf_core_copy_regs() in elfload.c to populate the gregset
from CPUSPARCState, including L0-L7 and I0-I7 from env->regwptr.
A memset() at entry zeros the trailing reserved slots.

Without this, bprm->core_dump is NULL for SPARC targets.  When a
guest signal goes unhandled, dump_core_and_abort() skips the core
write and falls through to die_with_signal(), which re-raises the
signal to the host.  The host kernel then writes an x86-64 core file
for the qemu-sparc process instead of a SPARC guest core.

Populating the full register layout is required for tools like
libunwind-coredump, which reads pr_reg[33] for the trap PC and
pr_reg[16..31] for the windowed registers.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/sparc/elfload.c    | 27 +++++++++++++++++++++++++++
 linux-user/sparc/target_elf.h | 11 +++++++++++
 2 files changed, 38 insertions(+)

diff --git ./linux-user/sparc/elfload.c ./linux-user/sparc/elfload.c
index 32ca1b05b1..e6387ec891 100644
--- ./linux-user/sparc/elfload.c
+++ ./linux-user/sparc/elfload.c
@@ -4,8 +4,35 @@
 #include "qemu.h"
 #include "loader.h"
 #include "elf.h"
+#include "target_elf.h"
 
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
+{
+    CPUSPARCState *e = (CPUSPARCState *)env;
+    int i;
+
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+    for (i = 0; i < 8; i++) {
+        r->regs[i]     = tswap64(env->gregs[i]);
+        r->regs[8 + i] = tswap64(env->regwptr[WREG_O0 + i]);
+    }
+    r->regs[16] = tswap64(sparc64_tstate(e));
+    r->regs[17] = tswap64(env->pc);
+    r->regs[18] = tswap64(env->npc);
+    r->regs[19] = tswap64(env->y);
+#else
+    r->regs[0] = tswap32(cpu_get_psr(e));
+    r->regs[1] = tswap32(env->pc);
+    r->regs[2] = tswap32(env->npc);
+    r->regs[3] = tswap32(env->y);
+    for (i = 0; i < 8; i++) {
+        r->regs[4 + i]  = tswap32(env->gregs[i]);
+        r->regs[12 + i] = tswap32(env->regwptr[WREG_O0 + i]);
+    }
+#endif
+}
+
 const char *get_elf_cpu_model(uint32_t eflags)
 {
 #ifdef TARGET_SPARC64
diff --git ./linux-user/sparc/target_elf.h ./linux-user/sparc/target_elf.h
index 7827767bcb..edb0b3103c 100644
--- ./linux-user/sparc/target_elf.h
+++ ./linux-user/sparc/target_elf.h
@@ -13,6 +13,7 @@
 # define ELF_MACHINE            EM_SPARC
 #elif defined(TARGET_ABI32)
 # define ELF_CLASS              ELFCLASS32
+# define ELF_MACHINE            EM_SPARC32PLUS
 # define elf_check_machine(x)   ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
 # define ELF_CLASS              ELFCLASS64
@@ -20,5 +21,15 @@
 #endif
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Matches the kernel's elf_gregset_t (ELF_NGREG = 20).
+ * sparc32/sparc32plus: psr, pc, npc, y, u_regs[16] (g0-g7, o0-o7)
+ * sparc64:             u_regs[16] (g0-g7, o0-o7), tstate, pc, npc, y
+ */
+typedef struct target_elf_gregset_t {
+    abi_ulong regs[20];
+} target_elf_gregset_t;
 
 #endif
-- 
2.53.0


