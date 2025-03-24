Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ED2C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewn-0002yb-Tq; Mon, 24 Mar 2025 06:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewQ-0002l5-AW
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:02 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewI-00070b-36
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:54 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso7481435a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811708; x=1743416508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvEFguP/n+l5iVEh8y4wIJsiJEQKzDjI+RP2AOZVDdk=;
 b=IMLDehX5gru1Lz+NCnyenpbRBbO7CUE5E9xIT7+rIp7jfIo+BAgoF3lLhjKRo1QVkE
 EqmSNYHZybU8MBBuGX8F9yru+N1nJmcHLoSviMHvWj8r+miHr4pbMZiOOzEu03ivLoYj
 jr6YJxkHe6FDGK3dfTQQflKh4gLiiospe1iJ5JZrgLhV5PJhfwtk31ytNXHHhCQ4D7kE
 IO/z+q0f6tCImHvS2z7QnK2rIyempiClVHsmS1gq0UUFvPnWbtQhKQwk2uYZMbpEF/ra
 FuV+D2EwENvenX4cAwrnjxqhSpEaDO6duAgcJ9foPjWm7mpBPFkZIAxd0NZkIvKU7+Y6
 lRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811708; x=1743416508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvEFguP/n+l5iVEh8y4wIJsiJEQKzDjI+RP2AOZVDdk=;
 b=GOoTcmE2jCVaaqPUh2HToXj0x101nTRg3dyYvLzetlMop1Ga5Y0QBYOSZKSLHb4oeq
 38pKjIrLJx+p5mynLPFFGpdm4D1cubCrHvmXcFltFNH2sGd5K8H6OnlbCdgGKhFTsHlX
 JCjtJlGkoyz0o3aKMCDFlym23yhjpX9riMZoSfuU/BY1MDavKNKWhYQX2i/g1OuorjpK
 keVaSpgmRZ0c1mPwQjmgZjZ6U97SZ8KuWutwzVoLZQCTAMYXCQM6GFJP0XeKFPgCHdoT
 KcN9BIOb5ZH6CGZVh7c3HdOq59RJK9Fndj9LK1VvwDKAEknE3MmYKKbLGtvp8ZwQStGr
 j+7Q==
X-Gm-Message-State: AOJu0Ywz9gQdfrB8upXidCzBv8lOBv13Pw75z1OJ2vR2JxqTz4zw1Tj/
 wvdSWPZBB945fK58p5QvluL5UYWcaVB73cjspL/P2f7ZgzLVmRtFjGuRLW4flWM=
X-Gm-Gg: ASbGnctM/R3YpTz2g74ePY/gJlOvVq/FhcMmXBHWRIcbPs81tfyplnybIk35rlUtBUt
 qY08IrRQk218Ka1nA8uuPSWhjcgDypg5+OlV6BW3bRZ0EbzEY3MFzqk0Zu++fEYFHI2lf7vxhji
 Y7eY77yNzYI+ZUGfh1Yxad7XdOtFzjhR7pHm8k6gycNGsYCGUJ5dVFNl0Gc+RwG0ChBJweF388I
 yhb54hraK5ovv6+wp6lcORYG8hkBl13yuopBq7B6KVaIpGNzKWNR3fnSRrnsC3mdLKKxHWcqfBi
 MwQvxhiQF+/AafW+O+ffJZbsnDHf1qS3of28JB15cQ/eEQE=
X-Google-Smtp-Source: AGHT+IGDWfMgXm172gFM5ZpT6y6QkIuB1n5uMp/jbE/z3hdwtHdmnqQIj2lu/wPvy5IDInyyRqUiQA==
X-Received: by 2002:a17:907:7fab:b0:ac3:ed4e:6b5 with SMTP id
 a640c23a62f3a-ac3f20ffb1amr1136013666b.10.1742811708276; 
 Mon, 24 Mar 2025 03:21:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aab3sm636836466b.156.2025.03.24.03.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 85D915FDAC;
 Mon, 24 Mar 2025 10:21:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 10/11] target/microblaze: convert gdbstub to new helper
Date: Mon, 24 Mar 2025 10:21:41 +0000
Message-Id: <20250324102142.67022-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a pretty simple conversion given a single set of registers and
an existing helper to probe endianess.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use mb_cpu_is_big_endian
  - use explicit MO_32 size
  - handle differing size of env->ear between user/system
---
 target/microblaze/gdbstub.c | 49 +++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index d493681d38..dbaf7ecb9c 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -19,7 +19,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "gdbstub/helpers.h"
+#include "gdbstub/registers.h"
 
 /*
  * GDB expects SREGs in the following order:
@@ -50,62 +50,57 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
-    uint32_t val;
+    MemOp mo = mb_cpu_is_big_endian(cs) ? MO_BE : MO_LE;
+    uint32_t msr;
 
     switch (n) {
     case 1 ... 31:
-        val = env->regs[n];
-        break;
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->regs[n]);
     case GDB_PC:
-        val = env->pc;
-        break;
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->pc);
     case GDB_MSR:
-        val = mb_cpu_read_msr(env);
-        break;
+        msr = mb_cpu_read_msr(env);
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &msr);
     case GDB_EAR:
-        val = env->ear;
-        break;
+#if TARGET_LONG_BITS == 64
+        return gdb_get_reg64_value(mo | MO_64, mem_buf, &env->ear);
+#else
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->ear);
+#endif
     case GDB_ESR:
-        val = env->esr;
-        break;
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->esr);
     case GDB_FSR:
-        val = env->fsr;
-        break;
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->fsr);
     case GDB_BTR:
-        val = env->btr;
-        break;
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->btr);
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
-        val = cpu->cfg.pvr_regs[n - GDB_PVR0];
-        break;
+        return gdb_get_reg32_value(mo | MO_32, mem_buf,
+                                      &cpu->cfg.pvr_regs[n - GDB_PVR0]);
     case GDB_EDR:
-        val = env->edr;
-        break;
+        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->edr);
     default:
         /* Other SRegs aren't modeled, so report a value of 0 */
-        val = 0;
-        break;
+        return 0;
     }
-    return gdb_get_reg32(mem_buf, val);
 }
 
 int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
-    uint32_t val;
+    MemOp mo = TARGET_BIG_ENDIAN ? MO_BEUL : MO_LEUL;
 
     switch (n) {
     case GDB_SP_SHL:
-        val = env->slr;
+        return gdb_get_reg32_value(mo, mem_buf, &env->slr);
         break;
     case GDB_SP_SHR:
-        val = env->shr;
+        return gdb_get_reg32_value(mo, mem_buf, &env->shr);
         break;
     default:
         return 0;
     }
-    return gdb_get_reg32(mem_buf, val);
 }
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.39.5


