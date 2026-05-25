Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C569CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdEh-0000j9-L9; Mon, 25 May 2026 17:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdEg-0000iw-44
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:53:22 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdEe-0006Ho-JO
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:53:21 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7c2fa14795aso77299227b3.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779745999; x=1780350799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l51dLVCHAR456H4i4+cgGwHpM+CpQO2jRyfd/gO3/ec=;
 b=GDjt3Jkz+Qtltlu0v6A/szxFzvefjy39WraNL02I8E6ukiu22Yt8mWSNhm0MYy7DX8
 lh8NroxA4WRaBw9r3V1MiHWxw4LVZ3nZeRIw+Xlu11pT6kvRn9/ulAKct3D3VhpFg2UO
 JqZFlayzABTvv9debRbZN3RTqxK3dumZ3MXN8Bepz271ZpWAocPy881mt6QZwGf+Yv88
 Hc18C5xjZMFPkHRiLHTOOjeoBDQOyhvh72+ceD9E4ta3Mstug5o4IkcofEC27zcoV8Gd
 KR83IkzbBCku1XLnI9/fbypAMQMYUhzQb4EsSFe/r5JJxl50EQZFuDSXUcFHiGGMBUSE
 Tvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779745999; x=1780350799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l51dLVCHAR456H4i4+cgGwHpM+CpQO2jRyfd/gO3/ec=;
 b=Qsx7Sb0Wf7he1vOWWAY4slXsYXd/v9h8Nk2cSDZceQpB9IhU/Vb90YDUUFhqeugAAH
 H9HI7dQPJI9QWlqzKhr99CKCo3TybdbSUmqtYC64I7fuS5vJGCQkUtsyk0EYTWdRTCpq
 Vxw7lRrU5Sd9HDSGiU7NSem5uudWAx4BkPl8+eJtHz8O3wthiLAdJ7/ymiGoNKEo6E7Y
 4WCFQ0Vlvk0zNDjJZ1b/A8VdqkoS1NYyeGX8BxE/l29JOy39qSmpXxppOKmd5Oylo9M0
 wIxa6DKxU/pnla6nvg9DYwpCDG12M8Z34udhQZW0ppKlGg85PSGcs+iGFHtUKYBT45YO
 6VGA==
X-Gm-Message-State: AOJu0YzGa4XgkTlzCaFwOLrzElmRUx8T46ecXvV02S9av6WQZ2RWb+z7
 gBAHogzcNbmUYqPco9psAvH63aZr8DPm0EEjVfozYheIQ9puNJ4C/bEaC9jnNYft
X-Gm-Gg: Acq92OFDxgL+h3d2+CItdAWJ9B5+bIKHks8qCfsOQMWxiXO362ujBAwWqBSw3wXmoV5
 gXqVtuYiOPoOzwU2IU8vbFZIGRDay25WtVch76VBT1yWdPLpWbdRI3FKDQqEedsnfaUxrksWRd4
 RkL/zEZFFG8I9FFTtLfm4TQNTftmfS6THZ4hF1ccdR141+5e1GQzUvGk/2cM5ob9hCfvbT2qYGT
 bBCsquzHTWKz+diBhaIgRozKAKEVBG5zCcTL595OqN2QBnZhY1rmttunEbV4XQ//8NAd4losyOw
 X3FgtfrB88EQmzj6C3y8MdNHQRJhsUpa+3qxit5f31XlZqd240bXW5cJjxOwDahvEkaTr7jp914
 QOiEZbboR9o2IZgmt7Dus+JxM8UA6dPt6ZK/ObX95ODFZPATo881+ijTsrs2cVZ1ERpz5xCzvmH
 HF+rdIMtcUzDMGVgp4+R1D223RWE6/WOE/aL5x4yHOApoVX1ZrqvNOpcy+V0EfyvDnibwsYt5Fl
 G4=
X-Received: by 2002:a05:690c:3706:b0:7bd:4792:66ef with SMTP id
 00721157ae682-7d33a961ab6mr184729847b3.42.1779745999449; 
 Mon, 25 May 2026 14:53:19 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d389815a8fsm51881127b3.6.2026.05.25.14.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 14:53:18 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/alpha: add coredump support
Date: Mon, 25 May 2026 17:53:08 -0400
Message-ID: <20260525215308.44096-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112f.google.com
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
mirroring the kernel's elf_gregset_t (ELF_NGREG = 66): r0-r31
[0..31], f0-f31 [32..63], pc [64], ps [65].  Implement
elf_core_copy_regs() in elfload.c to populate the gregset from
CPUAlphaState.

Without this, bprm->core_dump is NULL for Alpha targets.  When a
guest signal goes unhandled, dump_core_and_abort() skips the core
write and falls through to die_with_signal(), which re-raises the
signal to the host.  The host kernel then writes an x86-64 core file
for the qemu-alpha process instead of an Alpha guest core.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/alpha/elfload.c    | 12 ++++++++++++
 linux-user/alpha/target_elf.h | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git ./linux-user/alpha/elfload.c ./linux-user/alpha/elfload.c
index 1e44475c47..c86f9cf2bb 100644
--- ./linux-user/alpha/elfload.c
+++ ./linux-user/alpha/elfload.c
@@ -3,8 +3,20 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUAlphaState *env)
+{
+    int i;
+
+    for (i = 0; i < 31; i++) {
+        r->regs[i] = tswap64(env->ir[i]);
+    }
+    r->pc = tswap64(env->pc);
+    r->ps = 0;
+}
+
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "ev67";
diff --git ./linux-user/alpha/target_elf.h ./linux-user/alpha/target_elf.h
index 864dc6e2e6..bf3bd21b09 100644
--- ./linux-user/alpha/target_elf.h
+++ ./linux-user/alpha/target_elf.h
@@ -11,4 +11,17 @@
 #define ELF_CLASS               ELFCLASS64
 #define ELF_MACHINE             EM_ALPHA
 
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
+ *   r0-r30 at indices 0-30, pc at 31, ps at 32.
+ * r31 (hardwired zero) is not stored; pc occupies index 31.
+ */
+typedef struct target_elf_gregset_t {
+    abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
+    abi_ulong pc;        /* program counter           [31]    */
+    abi_ulong ps;        /* processor status          [32]    */
+} target_elf_gregset_t;
+
 #endif
-- 
2.53.0


