Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAF5C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBm-0002ZN-LF; Thu, 28 Aug 2025 13:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVU-0007VC-Tk
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:39 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVS-0008BC-VI
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:32 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b471756592cso598085a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383209; x=1756988009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9WlSjF0+HjwhfJFeJ6DVK0cBfr4XpFmhJQo+afKF+s=;
 b=Fc5wCtUD09BZ7j46w6arblK+OdzvLEClCYOktwmroLPOZ7/LlyjLlMEPH4+sy2KDbG
 rF1bsSJiyjNnO1d53xNFgxtbX/LDgEF98dsKY7kyEHhkwD+DszvNvfVVLavjnhKaYE5/
 yI8ZM3GiAFDrjGONU2DkjsoSwUc1ljfIMcXyUffUVKlrNUYYbpR4rzwB8kvP8OHBVT0Y
 FZ5Iyd9VegTTtbDoztgIWmBg/IgrMTWETl7leRmljblteNBFtbFDoOd3JYH2iLaHNQX2
 jwArOzXXyBN97nOMruN9JZ/O/l7gAXJ/hWxga8rtHys4JqDs07hqZw/5htaFrN2yv+e8
 +frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383209; x=1756988009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9WlSjF0+HjwhfJFeJ6DVK0cBfr4XpFmhJQo+afKF+s=;
 b=ZjR4XnsF9jK8qU9PMlP3oYBlZpV6BtCUN8I3lilXD3GfQuEcuEIW6SagUJ+/+S6/An
 9VE/De2/rk8zS0BcebBKc69t7lTGhosrKiQEk2ObJ4Mc8JUZfSHJLr6eVTUAE7iwziYk
 Q+qrwZ2QG2FkV1wUKOFmM4MQouUkZyZeoAK1OR2oLeqFMk+t7NvYp1szhfs0qQOJmQj6
 biQFa7GVlVA/4iMe3CKlnTC3NWAyTmimBE+GFKMcPuWwjqCPviws3kxjFqVNnlUwA0BW
 JfX5IZBUQkZW3ppGykd1TSM+Sx62lb2piKDZ6DRsWsHrlyKjTufGtor5XVP3phTKwwCf
 5SPQ==
X-Gm-Message-State: AOJu0Yw5VzdDizSd1/ciFf3gA2SKDA3FWG4bAjlBEVtl5Z0LjRXeke4n
 zmVJBx4H2W901m42YMgBILT8xprKQ0MGKOTOn+GN4/gEyjUj1cdlOTJqXAAFWkby8+OJjMOeIne
 vRYF6MWA=
X-Gm-Gg: ASbGncusEBuB7ww8qZtWQkHzBNUX37gTwkoF/M0DQV9/XdKTNiY6Urn7I448C0Cu+Zi
 UwQi9ASIAM/TvpzBbz2DVbG1LBu1DYVmAHkWGzx2c73hU5EX5skdOQBTWvvUslzVgYSzosz6NvQ
 kgEVOWD+vi7JxOYB1K48ABj9SgruSI1zmUqHJytvvo5SQV92HuHHEeB355R3f0XCnR/7F/KxY1Y
 IMgbNqYRtGodiMg+SfRPzfdwFdHDaI59enIjc+i0g/ASe8Y2YkCEQqfbYZa86j1EQAuHMX16pMm
 9znLnZG7FYdwC0XOfBN7GAGO+hOkfDY1Mr3faoWRi5iixT7fiih77IbOibv8jmDWKlKB3YZvXsC
 zlfbXvZEgRPTaeh/NS1TOJBus3XiyfkjbBYEn
X-Google-Smtp-Source: AGHT+IEYP/ILgr4L4QmKcULUOk2t7mhr0of12kX8Kaxru8fohKz5l1ABc5LA1Y3uqk+lWqR4ngmjiA==
X-Received: by 2002:a17:902:f542:b0:248:7b7e:11e8 with SMTP id
 d9443c01a7336-2487b7e1af0mr121236745ad.18.1756383209000; 
 Thu, 28 Aug 2025 05:13:29 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 41/87] linux-user/m68k: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:50 +1000
Message-ID: <20250828120836.195358-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h | 24 ++++++++++++++++-----
 linux-user/m68k/elfload.c    | 42 +++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index cd6908ab57..0737412cee 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -10,12 +10,26 @@
 
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/m68k/include/asm/elf.h.  */
-#define ELF_NREG                20
+/*
+ * See linux kernel: arch/m68k/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_regs_struct via sizeof.
+ *
+ * Note that user_regs_struct has
+ *    short stkadj, sr;
+ *    ...
+ *    short fmtvec, __fill;
+ * but ELF_CORE_COPY_REGS writes to unsigned longs.
+ * Therefore adjust the sr and fmtvec fields to match.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    abi_ulong d1, d2, d3, d4, d5, d6, d7;
+    abi_ulong a0, a1, a2, a3, a4, a5, a6;
+    abi_ulong d0;
+    abi_ulong usp;
+    abi_ulong orig_d0;
+    abi_ulong sr;
+    abi_ulong pc;
+    abi_ulong fmtvec;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
index 2970ff7dec..423d1f680a 100644
--- a/linux-user/m68k/elfload.c
+++ b/linux-user/m68k/elfload.c
@@ -18,28 +18,26 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "any";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
 {
-    r->regs[0] = tswapreg(env->dregs[1]);
-    r->regs[1] = tswapreg(env->dregs[2]);
-    r->regs[2] = tswapreg(env->dregs[3]);
-    r->regs[3] = tswapreg(env->dregs[4]);
-    r->regs[4] = tswapreg(env->dregs[5]);
-    r->regs[5] = tswapreg(env->dregs[6]);
-    r->regs[6] = tswapreg(env->dregs[7]);
-    r->regs[7] = tswapreg(env->aregs[0]);
-    r->regs[8] = tswapreg(env->aregs[1]);
-    r->regs[9] = tswapreg(env->aregs[2]);
-    r->regs[10] = tswapreg(env->aregs[3]);
-    r->regs[11] = tswapreg(env->aregs[4]);
-    r->regs[12] = tswapreg(env->aregs[5]);
-    r->regs[13] = tswapreg(env->aregs[6]);
-    r->regs[14] = tswapreg(env->dregs[0]);
-    r->regs[15] = tswapreg(env->aregs[7]);
-    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    r->regs[17] = tswapreg(env->sr);
-    r->regs[18] = tswapreg(env->pc);
-    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
+    r->d1 = tswapal(env->dregs[1]);
+    r->d2 = tswapal(env->dregs[2]);
+    r->d3 = tswapal(env->dregs[3]);
+    r->d4 = tswapal(env->dregs[4]);
+    r->d5 = tswapal(env->dregs[5]);
+    r->d6 = tswapal(env->dregs[6]);
+    r->d7 = tswapal(env->dregs[7]);
+    r->a0 = tswapal(env->aregs[0]);
+    r->a1 = tswapal(env->aregs[1]);
+    r->a2 = tswapal(env->aregs[2]);
+    r->a3 = tswapal(env->aregs[3]);
+    r->a4 = tswapal(env->aregs[4]);
+    r->a5 = tswapal(env->aregs[5]);
+    r->a6 = tswapal(env->aregs[6]);
+    r->d0 = tswapal(env->dregs[0]);
+    r->usp = tswapal(env->aregs[7]);
+    r->orig_d0 = tswapal(env->dregs[0]); /* FIXME */
+    r->sr = tswapal(env->sr);
+    r->pc = tswapal(env->pc);
+    /* FIXME: regs->format | regs->vector */
 }
-- 
2.43.0


