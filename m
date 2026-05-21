Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9AECD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8Mu-0000OS-IP; Thu, 21 May 2026 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Ms-0000Mu-7Q
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:43:38 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Mq-0007gl-Lk
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:43:37 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7bdf83185bbso62535887b3.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779389015; x=1779993815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gMOdontz7doufMTo7l5nS4k8ywZqBP3f0aeppryBgMU=;
 b=dvf9NSPjbjgSvrHU+MI8gzvBNsfV/fKbpo/zop1khY9NWK7NyrCTH5Pbhu3HA1P+Sv
 hLYecjo2jm5lMjYkjPaau+LyAvBDkH6rv912n9fs8+9UVeRXT8RFl3HvEpO45HFUdZal
 2T/nOO01xFME5ry6P0DE0Vw9ye13ZiXj4hmDAQdP2n9IDdfqdsv3qsCBkPmdr2HwauhO
 GxZYiTV7eH8jDSDLg69rsqr5qguqVfiSss02vGaIyrr7Qc/vTR2cDxzMAQ6EHwg1IjcI
 dfdcgGCx0j3sbkXMRZkoqGVjRqxUC5WLbT4dNOtzVBDrvntapZe++mDrKqO7C/t2jzGy
 MQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779389015; x=1779993815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMOdontz7doufMTo7l5nS4k8ywZqBP3f0aeppryBgMU=;
 b=eSFijtekE4po9Kk8WfNPGRi3frLIXHSlU6srTwQ1hX+XUXcj37uzWz5YPsYuKOK6C7
 YgmIE7qibhIxorbshgb7/FVgY+wuJwjQKmdwCLNmyRqF+RZT70Kg8MJ3LiWu3RMDz8lE
 U8PltVNUZvbZ5/sds1gGF554XwEQCRdqMOP//ncozc6w2pZeDHzBO/EcPZLws6TCIIig
 F9xbluessK04TNujUJCkiTuQpiswHL6wr4/otK3RyYCC7bihQYM/8Xe9rt1tN8wxr0kk
 v0O4nM/4dVg6Sfi6P8RaXAd8ZQb+r8Lu8YCdHRYtNrADbXj7YNSZHIEekQipGZaZeV1L
 Ae6A==
X-Gm-Message-State: AOJu0YxZAEnjrJMpmJ8Nnusqj6bzbzqFVe+X92UJOIRtAbF6nPbtDhnR
 0VDzbAKiRS3X2m5QEpS36PBPkR1Fh+Zr1PW10doqjeG9MfUsQ2nAxlhe+Rj0qdG2
X-Gm-Gg: Acq92OGzY/72Eav1nvC7jEqfuluX1gFGB2jrcIFSz1XpcDgzst4BXXRQd22lKE4XB6G
 Pj74aLoqQR7xLSgYlu6OY9ZEuGhpKg/qhMaZwee5veS9FG6bQVmkLdg5LyTsPuN6wuedMNELtjT
 YtF2k55ZfNh1bjfWKn4fkm7Yp3njpiU3MUSfydH1vk/phoJIkt4WCZHqp3axa4Ny6oe3NLGDsFi
 gMPg/Q/R2YKavOCPiwQNY/5UJvQaY2/kM5KKWnzslYRQm5YdzcoR3rJPRGaIpwwR+7l6TonIKXl
 Bt/B5nqnKhNQaWICNWsAQh8n1Lq4Em6HSh/5Jem3jJWz3eEER+tf7jc3eQjDtz3DOqzB2/uqmJ5
 xg4bsEukXQxZUckH1JGy3u1545wKnAvf4L/YoLmwl3bLE3vBryLNya8d10yFz++Rs27Qv0k788I
 U4tX5nUy45F+z+NXXDBy8bdOye06tu5nskoDCD00Wnm04ynweG9XqQWfW1zMKG1J4+v9EFoUKA2
 J8=
X-Received: by 2002:a05:690c:6309:b0:7ba:fdc5:17a3 with SMTP id
 00721157ae682-7d33ad4ed9dmr6070397b3.43.1779389015384; 
 Thu, 21 May 2026 11:43:35 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d2cac6e97esm6257487b3.42.2026.05.21.11.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:43:34 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/riscv: add coredump support
Date: Thu, 21 May 2026 14:43:21 -0400
Message-ID: <20260521184332.1633410-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112e.google.com
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

Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h,
mirroring struct user_regs_struct: pc followed by x1 (ra) through
x31 (t6).  Implement elf_core_copy_regs() in elfload.c to populate
the gregset from CPURISCVState.

Without this, bprm->core_dump is NULL for RISC-V targets.  When a
guest signal goes unhandled, dump_core_and_abort() skips the core
write and falls through to die_with_signal(), which re-raises the
signal to the host.  The host kernel then writes an x86-64 core file
for the qemu-riscv64 process instead of a RISC-V guest core.
---
 linux-user/riscv/elfload.c    | 9 +++++++++
 linux-user/riscv/target_elf.h | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git ./linux-user/riscv/elfload.c ./linux-user/riscv/elfload.c
index 2e7d622232..afe103a631 100644
--- ./linux-user/riscv/elfload.c
+++ ./linux-user/riscv/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -10,6 +11,14 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "max";
 }
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPURISCVState *env)
+{
+    r->pc = tswapal(env->pc);
+    for (int i = 0; i < 31; i++) {
+        r->regs[i] = tswapal(env->gpr[i + 1]);
+    }
+}
+
 abi_ulong get_elf_hwcap(CPUState *cs)
 {
 #define MISA_BIT(EXT) (1 << (EXT - 'A'))
diff --git ./linux-user/riscv/target_elf.h ./linux-user/riscv/target_elf.h
index dbbfdf54d3..859f726578 100644
--- ./linux-user/riscv/target_elf.h
+++ ./linux-user/riscv/target_elf.h
@@ -19,5 +19,12 @@
 #endif
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_CORE_DUMP      1
+
+/* Mirrors struct user_regs_struct: pc followed by x1 (ra) .. x31 (t6). */
+typedef struct target_elf_gregset_t {
+    abi_ulong pc;
+    abi_ulong regs[31];
+} target_elf_gregset_t;
 
 #endif
-- 
2.53.0


