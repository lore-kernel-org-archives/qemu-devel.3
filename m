Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50465CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk4-0008Vv-Rc; Sat, 30 Aug 2025 11:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bL-0004QU-QY
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bJ-0003cS-TE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so2376482b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506580; x=1757111380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvEXEx1VDU0jBpHbT/irolqC9K1ixlWLmUyzXXcC9HM=;
 b=oMgCcIkuac9LBfuU9IVHee/NxscD4MVjk0OjJDEJ5LFCxN8SewJLaAI9lQE+kPkwzM
 gxmoHPDYsDB3sgLuZ4lWJogQBPNSiiXz1ut+ghqGmjP5DUIjSOqq52gwIi6TlrRfiazx
 y+keABRTbmG7D6IETMNp1CCPzhlp7pXeK+LOmRmQ7bOT8ZV0Nqtp3/IcmXkdUbuzHDiO
 JlVN6lE16GWNFnKipdevGmpOB92i4rHseNSMgj04iE//mmyOmPafxRSVqpArxX4rByeZ
 W9QwZ9NVitRzjhLi/dSLeK6Xz4/LutIPHR/uJbkeIiuNyZmmv6N6SuyZ2OEnQhlvzc7X
 Mmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506580; x=1757111380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvEXEx1VDU0jBpHbT/irolqC9K1ixlWLmUyzXXcC9HM=;
 b=CKVS4qEokNQHVXSQzAwURsJx7HemL9cpI5v/U9ylWe3U7aztBbUpDOHbNfVyO/VopC
 scMjkEnHzbUA7d0E4uLPZzQvqtLx1dsJOiNga1fTP/fiCV8Cu/kbUFnobXVpd3N3acbq
 IV7ORqpD4AVYyvrUHAQAA+NRoVgblfIUjoAIfyQdR9ZOVJb56v81PFwzmrUU8n75SXvs
 b0pvNzgHmO7ODo/MYT3tq9D7JLbjBSXLfyD0E/M8rqjTPYBtiicIMCtzG959DwkQaBAX
 PfDlYYwekmjm0ONm5k11YDjmmQJEzrwXZl5GvT52mMYBds/VGGIOH0f5yHaE2Xf3nPVj
 zDgw==
X-Gm-Message-State: AOJu0YxTyX7ZSW1/+WBvPsU/mTWiEbd+yUDGhWBfkY18HXc2qQgpTxF2
 BF+GmioTQU8p9MHXA3mONzL0Ezf+aj4AnTjnWEhZMnsRZ092GL1+P2G04AfQnFyOQLfV7cDb/xh
 94RKnYeo=
X-Gm-Gg: ASbGnctirE3oOgst9xAaU+w2pFLzEPL9B85fDrzBR5uG9JW6thfdQJdwdAMl7sKkJs2
 tcsJ7JgfoT6xrpqDAVRoDxMASHmLZI1VR1FZyv50pdoM9f0DVAOKilq/xzm/S62b/99UTGXkW8W
 +vSfGkJZjUFFMKm7AqU+b5hka0kuseLcH5KW4rF+wjhT2RgLL8sh/8vUbst90nVOtsW7NaezHve
 Ko4pjxnkeIQjogYf5yXFv3pRlc756SSPVJjAvUFRJcV65cwpmVCBGfOtM7NUa+WFYLjgXtaaRnn
 M6zd70/wFlEVq4HAbFg5yIHWG3SQbYaxaX1zLW6uleB5XBA7RK2uzAxOj37c9JX8P1y5L0HznkL
 nCcn9mREtNISZYv2p3l92D/7G8UDuhbAJHbej1DyiamiSmGYyF0Izvn6o01UBJGc=
X-Google-Smtp-Source: AGHT+IGsPhj+9a92VfeXy3JySQVgtmDptO1QR/UjL0azYG2JNCkmvO8RbUxzJyOWR0p0+c5dIvAb3g==
X-Received: by 2002:a05:6a00:3c8e:b0:772:1fa1:be50 with SMTP id
 d2e1a72fcca58-7723e33708amr305116b3a.9.1756506580120; 
 Fri, 29 Aug 2025 15:29:40 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 52/91] linux-user/openrisc: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:48 +1000
Message-ID: <20250829222427.289668-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_elf.h | 12 +++++++-----
 linux-user/openrisc/elfload.c    |  8 +++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index e97bdc11ed..ad80e4b41a 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,14 +8,16 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel arch/openrisc/include/asm/elf.h.  */
-#define ELF_NREG                34 /* gprs and pc, sr */
+/*
+ * See linux kernel: arch/openrisc/include/uapi/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_regs_struct via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_regs_struct pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
index bb5ad96711..6bf02bf58d 100644
--- a/linux-user/openrisc/elfload.c
+++ b/linux-user/openrisc/elfload.c
@@ -11,13 +11,11 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "any";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUOpenRISCState *env)
 {
     for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
+        r->pt.gpr[i] = tswapal(cpu_get_gpr(env, i));
     }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(cpu_get_sr(env));
+    r->pt.pc = tswapal(env->pc);
+    r->pt.sr = tswapal(cpu_get_sr(env));
 }
-- 
2.43.0


