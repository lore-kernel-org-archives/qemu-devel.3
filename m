Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700F8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwQc-0004hG-9C; Thu, 21 May 2026 01:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wPwQY-0004gP-PZ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:58:38 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wPwQW-0005I5-Uw
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:58:38 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so5709737d50.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779343115; x=1779947915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6c549bujclCLya+44+iHLpjNmLlWKpBjzAdA1lzSZtk=;
 b=saqMeFPs8bz+OndwQvOvzU5z9kGWdHV4UH7+v12cQTEbgJaG2fg0NKZIyo8Uz+5l4R
 gdH9sjZbRj6Ea91UL15g7J/6RmvZMcof9Ilol5U5pEM8eooPKWZKDHAORo9TCVW+wrb6
 dpGKcegJb53ZQAA7aDfjBOrD9uyJGKVqigmc31BxBb5NXylxl312Kxpm5DalCHeKANI4
 y72tt7PYCprg1crsd01I+VWZpWqAjLboCEe/2ZghS3JlpwDYKPyPwYqvxq8mLdTG1wsG
 gHT/eV84J17dr0I6yUssEEeKxd1x0509tixBqFQ9NwgK3B6NYwCelu/+chMPNu8r2Hu8
 89PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779343115; x=1779947915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6c549bujclCLya+44+iHLpjNmLlWKpBjzAdA1lzSZtk=;
 b=AJWuwnjy+Wfgaw2rL4dozz2jKMnA4Q9Tlc26RV0xerAyaPogHk079FNKRYu7yT320I
 vnDt7SPY5W1ezgx2E/PzqwEKskiSZhPQS2OmOe4TmbsBVLIW5kCvGJVaqtdDX2l2r2SA
 5cxxXgVOEuZ3F8wqmqPcSM92wx2RoETzlwH+wUvto3vuxYCQLKm8Z4DyCi0o0whAnxRG
 1bs8cpzIZS35jLO0Sfg/+ZOcqNQgaUIDMdyNzF46y0knObl5xWPJfE/QXzjppL+pD7I2
 QCuvbC4FE5Qwz+gxgWbQXu9Z9X6VQm9mn8X07ZsSpp1OYy2qNh4ZZ3A6CT922fnMqUe2
 pEbg==
X-Gm-Message-State: AOJu0YwM+cwWw3Vo7KVkG5SJOEml9cHy9rhr4HcN3gkK2z90zNhRB0kd
 P4LAT+LXT+3k8iqGQR1b7vRTRlYedZ0WLhhYRF1ZYQfPfww1YS/C8B+w4IpWEMZG
X-Gm-Gg: Acq92OHK2MQXRr3yNzgPPRQhNbavCYI1rACLWQ/v9i4EajG9nlpcl513t5+ti1WFItp
 EJxzO/fPYG1HFF2Cwm9jM0kub5O8jfVKUCFKrFOhNKcGkvitYqPKrp/CqY64enzeSjJPZ8dYk5x
 xorqDH5zxvvw/bjd2umSK9gbIA8whT3/LP7ZA8ERM68kQ0P1v7w7TaOQuRVbxwbS+L/LLbSBw6y
 xHf/DBv1/22ii8O/L+q8d1/6X2FAEpNf2xioAtSDdtnHXHBwlsgLC136m+UQTRjSt4efm+yC9jS
 tSSXYqB9FxUW5qve5T+6BoPljyA0h0cC1OhshH1wOFkIHmm17nS7MjEJ1+O3CplbgccjC6eYmqQ
 R7DZFXSYKt29ASQbwoqmBaNP1QKJhy/wyJq1vnW6ILPQ7g0+sV5zDXww7FRBTQFF6poENRQ/Xlu
 nWFmWyU9Ej4k/pPINEDanIVCpYeF6lfW8nPdLWV+TxMrUlSsckLQVC8rzRUx/4l0mjgT+Rb0IlX
 qU=
X-Received: by 2002:a05:690e:128c:b0:65c:65aa:df7e with SMTP id
 956f58d0204a3-65eadfe4ca6mr1103260d50.17.1779343114632; 
 Wed, 20 May 2026 22:58:34 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65e0db6f4f4sm10255358d50.15.2026.05.20.22.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 22:58:33 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] linux-user/mips64: fix elf_core_copy_regs register layout
 in core files
Date: Thu, 21 May 2026 01:58:20 -0400
Message-ID: <20260521055821.1380491-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12b.google.com
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

mips64/elfload.c uses #include "../mips/elfload.c" to share code. When
the compiler processes mips/elfload.c the quoted #include "target_elf.h"
resolves relative to the including file's directory, so it picks up
mips/target_elf.h instead of mips64/target_elf.h.  mips/target_elf.h
pulls in mips/target_ptrace.h, whose target_pt_regs has a pad0[6] field
before regs[].  As a result elf_core_copy_regs writes:

  r->pt.regs[i]   -> reserved[6+i]   (shifted by 6 from the correct index)
  r->pt.cp0_epc   -> reserved[40]    (correct mips64 N64 index is 34)

The Linux kernel and glibc both use the mips64 N64 layout (no pad0): EPC
at reserved[34].  Debuggers and libunwind reading the core with N64
constants therefore see a completely wrong register set — EPC points to
GP, RA holds the branch target instead of the link address, etc.

Fix by:
 - Guarding the mips32 elf_core_copy_regs in mips/elfload.c with #ifndef
   TARGET_MIPS64 so it is not compiled for mips64/mipsn32 targets.
 - Providing a mips64-specific elf_core_copy_regs in mips64/elfload.c
   that writes directly to r->reserved[i] with the correct N64 indices,
   bypassing the struct field names that are tainted by the wrong header
   include.

The mipsn32 (TARGET_ABI_MIPSN32) and mips64el targets are covered by the
same mips64/elfload.c and benefit from the same fix.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
---
 linux-user/mips/elfload.c   |  2 ++
 linux-user/mips64/elfload.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git ./linux-user/mips/elfload.c ./linux-user/mips/elfload.c
index cc5bbf05ab..1a46e180cf 100644
--- ./linux-user/mips/elfload.c
+++ ./linux-user/mips/elfload.c
@@ -131,6 +131,7 @@ const char *get_elf_base_platform(CPUState *cs)
 #undef MATCH_PLATFORM_INSN
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+#ifndef TARGET_MIPS64
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
     for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
@@ -146,3 +147,4 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
     r->pt.cp0_status = tswapl(env->CP0_Status);
     r->pt.cp0_cause = tswapl(env->CP0_Cause);
 }
+#endif
diff --git ./linux-user/mips64/elfload.c ./linux-user/mips64/elfload.c
index b719555e65..d19e5f2439 100644
--- ./linux-user/mips64/elfload.c
+++ ./linux-user/mips64/elfload.c
@@ -1 +1,30 @@
 #include "../mips/elfload.c"
+
+/*
+ * mips/elfload.c defines elf_core_copy_regs guarded by #ifndef TARGET_MIPS64.
+ *
+ * We must provide the mips64 version here.  We cannot use r->pt.regs[] because
+ * when mips/elfload.c is #include'd above its "#include "target_elf.h"" resolves
+ * to mips/target_elf.h (compiler searches the including file's directory first),
+ * which pulls in mips/target_ptrace.h.  That struct has pad0[6] before regs[],
+ * so r->pt.regs[i] writes to reserved[6+i] — offset by 6 from what the kernel
+ * and glibc expect for the N64 ABI (EPC at reserved[34], not reserved[40]).
+ *
+ * Write directly to reserved[] using the mips64 N64 index layout:
+ *   R0-R31 at reserved[0..31], LO at [32], HI at [33], EPC at [34].
+ */
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
+{
+    /* R0 is always 0; r->reserved is zero-initialised by the caller */
+    for (int i = 1; i < 32; i++) {
+        r->reserved[i] = tswapl(env->active_tc.gpr[i]);
+    }
+    r->reserved[26] = 0;   /* k0 */
+    r->reserved[27] = 0;   /* k1 */
+    r->reserved[32] = tswapl(env->active_tc.LO[0]);
+    r->reserved[33] = tswapl(env->active_tc.HI[0]);
+    r->reserved[34] = tswapl(env->active_tc.PC);
+    r->reserved[35] = tswapl(env->CP0_BadVAddr);
+    r->reserved[36] = tswapl(env->CP0_Status);
+    r->reserved[37] = tswapl(env->CP0_Cause);
+}
-- 
2.53.0


