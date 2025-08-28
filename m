Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC871CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJB-0008Td-5F; Thu, 28 Aug 2025 13:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRm-0002s7-5T
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRj-0007Hg-SQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-771fa8e4190so678186b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382977; x=1756987777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9vU7UtNMSkO1PPlm9WkjYpJ2Jl3RkR5+b6cjhq8aXM=;
 b=dH0OoVzWlE08ud6RyPcpbPiEQlAN0Eo57pnN/PWr4ANQHv66ALRuJ6FlfqowbF8Ozb
 wT7JFL1aNvSdJ/LLQHa0g/nVBeU27wFzkxvyGkq3Y3zBLm2S3Pmom0VFMmU4kOCymuUP
 9oobEXijqoJebZn62sjoiV6uQ440VM8FrnNs5if5ToN5Z5f7p0Kd2Ygl3Ec25+ypsHMF
 lOUNVvzzNP7GhR6qJe3x+0rraJPypMXwKHREHnjQ/ncK2S2asVrA3mng7eca9s15pjB3
 JcP7OcoHoAQusjHaiOP9qhlv0Fujwhd2r7sbjrxq1ZeqymDXhw12dEkAye2S5THHE30F
 08BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382977; x=1756987777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9vU7UtNMSkO1PPlm9WkjYpJ2Jl3RkR5+b6cjhq8aXM=;
 b=F3aJjyUcPxzaHNMtOM7oPjQNi7I4s7QYpSHLRMkdu7PnHy92xigDUift09WziLC+xo
 RQfwc6iCDfXjSyOjI94YmpzdzUh77Gr/ofFYFIqoUNAe8KSm08ZeHVAJq7CR+v/gajsu
 7pWA8LqW1kj275cwBQft/qbgUFD2BDIJSkD7tL1CjfVJ0TECgE0SHRogbvktfpdJ9Qtk
 yvPZShriSz+YMQO8kNfuCgbLLtjDi9Hz0QjBxsE4shVXMIrtAvIjB8hmylcyCSg+H9rb
 ne7Af98kum7hMaOnNSWIQ2CBZCYeaGv2wEcGQtN1U2mHGfh15lb1MGnF3UVcSJpFF/Zw
 abLw==
X-Gm-Message-State: AOJu0YyRw6WoGJwPXzrLVLhfUo7MGJWzxWRKewF4lluVafo4xgQi+WfU
 pHERqNOrVDWOIHyfUpvc/pDLF6O2RzdcG8fWeakOUofE27pwMYCmqzSYpGq1xiJcXVna293jDCk
 58F4hvfY=
X-Gm-Gg: ASbGncvjdED6pxI+0RIeOFUHEUqYpdlKlVsHwnYWIt6T9u01rndBh75yzAZ85gRPNuE
 HX1WYKUgjVBqSiS27oAOBWg4l0b+z7izSLiw5YzQf+uAhVjHCH6aqDfkSwfJvIH8mSfiW0xAz2y
 QytOlmkH3+vEFOwWbjAYB0oyR/cBCcjio64jxwpswXdrJnKTokx3m+px20f7KcuJkSgmLZT8A8o
 m897mvbCpRs1amK83FkAzOWJOLKfOPym/+6lrbO/Fquh988p9dVNunR6hZpgcBIZcaKt2HYnEJT
 RHmLW7WQ2UafAJvEdnnebMSQMrctTfok6eHKrd/GDe0HddAN/QBTrlfXpHYDlqIh4aNdQEq/QgU
 Om5mdJ4d+WiRp1IYRrUeL3Pg+aw==
X-Google-Smtp-Source: AGHT+IFkoiGE0hNm/h0oQnxMC/EOyYoKBsFV77+m5MdsEdEB8q8c1BSuDHnCf9vAGb3YnTNA46eElg==
X-Received: by 2002:a05:6a20:258e:b0:243:a5c7:3d6 with SMTP id
 adf61e73a8af0-243a5c71469mr6686798637.6.1756382977209; 
 Thu, 28 Aug 2025 05:09:37 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 23/87] linux-user: Move elf_core_copy_regs to
 microblaze/elfload.c
Date: Thu, 28 Aug 2025 22:07:32 +1000
Message-ID: <20250828120836.195358-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h |  9 +++++++++
 linux-user/elfload.c               | 21 ---------------------
 linux-user/microblaze/elfload.c    | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index bfe2997fd2..cc5cc0477e 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -8,4 +8,13 @@
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+#define ELF_NREG                38
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5a3a5cfc39..96ed6b6515 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -416,27 +416,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_EXEC_PAGESIZE        4096
 
-#define HAVE_ELF_CORE_DUMP
-#define ELF_NREG 38
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
-{
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(env->regs[i]);
-    }
-
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(mb_cpu_read_msr(env));
-    r->regs[34] = 0;
-    r->regs[35] = tswapreg(env->ear);
-    r->regs[36] = 0;
-    r->regs[37] = tswapreg(env->esr);
-}
-
 #endif /* TARGET_MICROBLAZE */
 
 #ifdef TARGET_OPENRISC
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index b92442dfeb..89250dbd63 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -3,9 +3,26 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "any";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->regs[i]);
+    }
+
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(mb_cpu_read_msr(env));
+    r->regs[34] = 0;
+    r->regs[35] = tswapreg(env->ear);
+    r->regs[36] = 0;
+    r->regs[37] = tswapreg(env->esr);
+}
-- 
2.43.0


