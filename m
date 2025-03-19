Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy50-0000wo-Mv; Wed, 19 Mar 2025 14:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4N-0000Il-Qs
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4F-0006P5-EH
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso52117185e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408582; x=1743013382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJ83uXoZhI6xrj/GFa6jaX+FdXqwSbl+PFyWsW6Q49c=;
 b=SBBtDHfnHBUgCAW65l8bC4JXayScaO41zq06oW8USRmH3gsE+M9+Ls8K9X+nsNH49+
 1O912l2uxXglXW0W39UZ33LbF7+Zw7SYWhOOj5Q4qLgI02fukFnIAF507OORDuV2Y8Yr
 kyF14RjnqK0/lEDJkUO1m//0TsHrAjD5Ym2dGYdiHMZEufeXBe2E0GrZPVcO/9sUrfD2
 rzK453D1PHtEEIvsr60FmsIOPakQPEqsiGOF1d1cdb2Hwq+bfjUOX9HcctX1KF8yG7za
 Fa5xfl0VbfLkAj8YPtd0qGHqkoIY/nFf9hbNRrNULVISWdXAojE7+3H9HB3qA+bBCJV0
 ipeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408582; x=1743013382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJ83uXoZhI6xrj/GFa6jaX+FdXqwSbl+PFyWsW6Q49c=;
 b=uovUqBXEUUOFr2/RJQp857yiEicdJUjTRl6K//bx3JDKF4ZdCymp23WYEbcRVVpLvs
 svJc0JIieW7ILgGcUNqrh8gbXU5TW7L6nAuK0lbtEIoCYso1oPBPfFLzqS2smUBEpHRE
 BNJYuuUZMH4VV6w2Sj+tZKHOx2KYkB7OS4SVxy+MTCce8vc4V9ID6U8UuF3axj/iccx9
 qQMLIrCKOB5qZktkTTYr139q22am7hBkegXlBZBQMIDZJlDOh5pa/y344IWsX5koY4P+
 GcmAFK9REiFTI+LY65JOyPTSl2ZxkfmHFL8VULsmJauB32mq9WQ6K9V9FIaPa8JcD+7t
 m8tA==
X-Gm-Message-State: AOJu0YyPNw05J3ZA1JmvUO/EF90VC/eTgOSB6LInVUKUdVyL0+yJ5QgC
 wkbpzXFMaI77h3ZwjpOStTYYobSM/d/7gbaF8Ka43xXbjT5diAL646LdjvZTj4s=
X-Gm-Gg: ASbGncv7kiQfrL7DTwXwO47Bmu4vWp8adhO/hQCi64VbpQc3v+VHsq8oIj9u6jBkNtA
 aXrwij5eL7WlCJneHm8VSfJTp7xgTFdsHL3GZ88KiDsIDVVmK5FD7N01nCPHuHReblrVgzIoIwq
 KXgs89jrHDWEyXfbYK1mwP9CTRBQ1qkeK4KKpWlllBArTuuvIKOsLYD7kn0MvzKdxzolDBBvZhY
 Xn9LYTVDsF+VznFRCF84Pl5OUjEB3EfAKihO/cPUWBsBPwdwTbyC1+stGAapH+xm3pxdUW5X3zW
 QiYh2NJU05k1HO0IbHR/XsMiXEXtfwVi/lZ8OwEJ0w7gAlo=
X-Google-Smtp-Source: AGHT+IHCXoxgAWOy4Rm1AajpPx+hsUvXObOFncd3EukhGfK1fHOKOMY3YnlS2UH3CGqXRhK1UsQG/g==
X-Received: by 2002:a05:600c:358c:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-43d437c1881mr37941765e9.18.1742408581639; 
 Wed, 19 Mar 2025 11:23:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4453227dsm25979735e9.40.2025.03.19.11.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 220CA6046F;
 Wed, 19 Mar 2025 18:22:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 10/10] target/microblaze: convert gdbstub to new helper
Date: Wed, 19 Mar 2025 18:22:55 +0000
Message-Id: <20250319182255.3096731-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

This is a pretty simple conversion which will be trivial to update
once TARGET_BIGENDIAN is replaced with a helper function.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/microblaze/gdbstub.c | 44 ++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index d493681d38..106d6efbab 100644
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
@@ -50,62 +50,52 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
-    uint32_t val;
+    MemOp mo = TARGET_BIG_ENDIAN ? MO_BEUL : MO_LEUL;
 
     switch (n) {
     case 1 ... 31:
-        val = env->regs[n];
-        break;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->regs[n]);
     case GDB_PC:
-        val = env->pc;
-        break;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->pc);
     case GDB_MSR:
-        val = mb_cpu_read_msr(env);
-        break;
+        uint32_t msr = mb_cpu_read_msr(env);
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &msr);
     case GDB_EAR:
-        val = env->ear;
-        break;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->ear);
     case GDB_ESR:
-        val = env->esr;
-        break;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->esr);
     case GDB_FSR:
-        val = env->fsr;
-        break;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->fsr);
     case GDB_BTR:
-        val = env->btr;
-        break;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->btr);
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
-        val = cpu->cfg.pvr_regs[n - GDB_PVR0];
-        break;
+        return gdb_get_register_value(mo, mem_buf,
+                                      (uint8_t *) &cpu->cfg.pvr_regs[n - GDB_PVR0]);
     case GDB_EDR:
-        val = env->edr;
-        break;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->edr);
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
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->slr);
         break;
     case GDB_SP_SHR:
-        val = env->shr;
+        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->shr);
         break;
     default:
         return 0;
     }
-    return gdb_get_reg32(mem_buf, val);
 }
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.39.5


