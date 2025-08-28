Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20D3CA0FFC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbRW-0002Re-BF; Thu, 28 Aug 2025 08:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRG-0002IA-Ni
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:15 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRC-0007Ay-RT
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:08 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-770d7dafacdso967621b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382945; x=1756987745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CRS1yiQ3bKJdT/Rq/3w5P24gdaPGfDV064zsVM1688=;
 b=C7x0eU+VJrvv+K/x+H29wEK78AN93p0731xDkXGx7A9dw1RRVSiqGXGxRqN6pH6ATc
 20gXlKdrRJ7XsejXMUAmGhIxI2Tx7AmEXskQNw8chKHQHiuJXrLKNTJsYE4C+6V7LE9E
 5fz7Tc6f2zebnhuSCf4Wcpf00e0kpEaM+LqEH7r12jjPr5PFVCxPSL6GpqoVAe7TRSYB
 NIFfpmKiz/RTMNrsJDr8Frz1F8it11w8CcCrPL/6zfRQU1VaTC4gzS88tjIa4KYwHtuq
 DUHIjqm4oy4xR/pnnf8ib1zxyUCmXsd8vpwDQ8aPeyihH6xRVN4VnrKWL05OUA96GSHr
 EyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382945; x=1756987745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CRS1yiQ3bKJdT/Rq/3w5P24gdaPGfDV064zsVM1688=;
 b=FJqN+4EpTX5nvWlrj9U12JduMUENG+8LsZrpxFYjkh1pRLVN7CI7okGgCS8M4JOGJ8
 M8QEVQ+1Nqelr7CxDxOLOggNu0iKFY34+dZAR+NxRG+aHGCF5UzSvHvF+VBn3qp+oeOa
 3UUy/MQziBQwoCunLfCHmo/DFA+nNsvD9Q7MG9yHXCXGde1GhiP8KQoZqgSO8jPR5CeY
 dbQUNBosAyRxSUbTZz0TeI6MM1ZDgI5TjlfEAbScYWAiRoNSN4ldtg1tRwecXTr83NKJ
 3croe72FCE853B54Rz+7sGweGOo7YrK1PasAkvrGWAVn8QhFe2fKdBIqYlGbutgRrJUF
 ThvQ==
X-Gm-Message-State: AOJu0Yz1e5BNpMerPNJ4wLRiXZXTq2d6Xzy4ce8oVRSw1ZdFtFLf6kbW
 PqKfForBrs144kwywRmBPTt0wpIWDEVZeJ3F0dOYJKr61hD3rt1eg2uZeo5XW2m2a7Rhk36P1Em
 jlw0KuOQ=
X-Gm-Gg: ASbGnctTYsoksFwNnbrJVjr35aPl4qR71yo57NBNUghJvT3FkKUoYkzvnKJQN4vajEu
 JArVvjXwWo2cF6Wv+yGYwM/4oYbM+UG0msh4s+raZQcYxz7nIr2XdNc1UrF7M1e19JODA8FuRl5
 Vt4WwbxMXoxWyTKyxvDviOmElZI/Ykj61sH7rogVvfOU93uJt/O5NbSp4Lh4laJXTRYhcsMBINO
 A6gHH8+AEnCdmPVtSPJRHoYJLhWBfa6I+rOw7W0tfWsM4DGxkpjyw2Wm+CqFYdQ7PraXyxb+Iw0
 cKYQPS4aiEc788mWhtlSWstx7EW5ENxx4ltdLaIcbU92QWBT+28Avg+HHHKWgG2Kkhy4Dsi5cWO
 S5M8ZeyRzoCW4kKU4/W/kt5KHtg==
X-Google-Smtp-Source: AGHT+IHdY14ECQpXkSxZ6JMxbrYwtzQ+XrkIyTWKQNaNk7q8rGkK/c0Trcjd3oWs3rWkw8r1kl9uXw==
X-Received: by 2002:a05:6a20:3d07:b0:243:b700:9535 with SMTP id
 adf61e73a8af0-243b70095femr992066637.52.1756382945041; 
 Thu, 28 Aug 2025 05:09:05 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 09/87] linux-user/openrisc: Convert target_elf_gregset_t to
 a struct
Date: Thu, 28 Aug 2025 22:07:18 +1000
Message-ID: <20250828120836.195358-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 40a5bcccab..da034e5a76 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -655,18 +655,18 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
 
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
 #define ELF_NREG 34 /* gprs and pc, sr */
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPUOpenRISCState *env)
 {
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(cpu_get_gpr(env, i));
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
     }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(cpu_get_sr(env));
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(cpu_get_sr(env));
 }
 
 #endif /* TARGET_OPENRISC */
-- 
2.43.0


