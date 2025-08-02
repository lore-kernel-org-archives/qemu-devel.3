Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320DAC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOC-0003Hq-16; Sat, 02 Aug 2025 19:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLO6-0002ri-G6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:39 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLO4-0001lL-Ow
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:38 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-61994f145fbso247431eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176295; x=1754781095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uyMtdJrWW5HbVPnFU4VMgr7B03c8Ws8hRDOWCMJUb+E=;
 b=pKb4c69zZDjcvPMIFRhUKkTiD5K2oAuRfuYQwygm+CJg108sWceENESDsIyBfU2yFC
 i6/PmuoZkid2OwrxsmBDS0iCUTDqzFB9TF+eIGNXs5Swi7CFAPX2nBZfbcvA3A0xIICb
 Y8h+OZUk82aw4Z7zApz0e+Od5ivAaQDv1PAEJ7AYGUzgOtHCqo7Yg7Y4yy1hW2bNxYk8
 zQTwSrN9/396e1DlpURpH/J9c1ym7RLyEVA34Q2XtZr9X2bAqsljSOEVE0GxcaAcDF9c
 ulL7Ce8152VO+cw2xaBGKzxv20HaBRN62c+LGzWDYnWKsVdpfTYpF/BdL+sRmbK+/bV6
 sKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176295; x=1754781095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uyMtdJrWW5HbVPnFU4VMgr7B03c8Ws8hRDOWCMJUb+E=;
 b=kClNabrLjLdvZV49ehLbeqVjCQk+4DqRXWrvGtgzg1RvQd6ce45rdm0Q9jrjHH7/0a
 3uYA+f0yLACXLoIxnTkz0SSULgFjqf8GPgvr4AtqRfOqeR4t0BC9RjQf5IqzgCegEV9x
 mrnr1nCK8mKRwUFZMNTyZQYDo2hK4fraVZ8bmAJvxZ35WI0ZbRu7KK5AimZ8BkMWbHnM
 6dQI7B888p2B62lNvoQyBmP59RunaML+EBNyQD274zfHgp+SFnrDwCI2iCaE/OPrCDmb
 UnMKnShtusX00nLQM465tPbXaafSwVBbJ+QecK3A3aYVfsR0lywK6UW3eNT+UpCzjYvS
 OHlg==
X-Gm-Message-State: AOJu0Yw7Xg5rCMZ4KS/HyjL3Ymmiea8zCtbhXr8AOhFlAuhgJielPJGb
 75p8pjHKGzpzL7N9r7CNPOtfybzuncY8dbXF1JqaVI9mmLFeG31RnTU8nwzklu0U0EWmtzM5HcH
 +xb2L+s0=
X-Gm-Gg: ASbGnctasgZM0xrBVdnACsPyCAINMKDQVmQS9YRNzo2BkNWmL2shYKvsMpfD8O4HWfj
 rZEW/sMh0g0hdz6eaLWEy73BGvjGrVUgjv4qdVr+Ae7+VroFA/b25UTSkLAu3tU317NKJ9eOmSa
 xegUp8GokTNk4jhivbqoMmFc4JQYNzQ5JhgwxIuRkYT1w209AcMPnA0uel8Gf/KrEC+0T1qnqOm
 xZLXZKdwxTSTSBBJ+DAWef/x7S/CJEx8PRi7B8IwP91JU+ckRc/iDRQrUmu1X1CfzkgWV2py8+I
 OoY3zURMn/Xty44o8RaxJkx2Kn5Y7oQXvkGGhguIfEebqXMUwK9UPlmV8RzuvUe34vYqUt77sJf
 BpuXSZCtKlw46j63fqCADVFDApnrJAkz7ntP2eGzQRTwMQodeyoqy
X-Google-Smtp-Source: AGHT+IHnCsBKJKUJsLB/oUpkYvdpk/S4UfdtePRwjinSTCXmYgMNILUqkVroG8+3SCzXdpPOvpP/vg==
X-Received: by 2002:a4a:edc5:0:b0:615:b2c9:7ffd with SMTP id
 006d021491bc7-6198ef153c2mr2424055eaf.0.1754176295438; 
 Sat, 02 Aug 2025 16:11:35 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 57/95] linux-user: Move elf_core_copy_regs to
 openrisc/elfload.c
Date: Sun,  3 Aug 2025 09:04:21 +1000
Message-ID: <20250802230459.412251-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_elf.h |  3 +++
 linux-user/elfload.c             | 14 --------------
 linux-user/openrisc/elfload.c    | 11 +++++++++++
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index b34f2ff672..4ffe54fe87 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
+/* See linux kernel arch/openrisc/include/asm/elf.h.  */
+#define ELF_NREG                34 /* gprs and pc, sr */
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 161118d855..2597fb8bc0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -418,20 +418,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_EXEC_PAGESIZE 8192
 
-/* See linux kernel arch/openrisc/include/asm/elf.h.  */
-#define ELF_NREG 34 /* gprs and pc, sr */
-
-void elf_core_copy_regs(target_ulong *regs, const CPUOpenRISCState *env)
-{
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        regs[i] = tswapl(cpu_get_gpr(env, i));
-    }
-    regs[32] = tswapl(env->pc);
-    regs[33] = tswapl(cpu_get_sr(env));
-}
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
index b92442dfeb..9851f04d64 100644
--- a/linux-user/openrisc/elfload.c
+++ b/linux-user/openrisc/elfload.c
@@ -9,3 +9,14 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "any";
 }
+
+void elf_core_copy_regs(target_ulong *regs, const CPUOpenRISCState *env)
+{
+    int i;
+
+    for (i = 0; i < 32; i++) {
+        regs[i] = tswapl(cpu_get_gpr(env, i));
+    }
+    regs[32] = tswapl(env->pc);
+    regs[33] = tswapl(cpu_get_sr(env));
+}
-- 
2.43.0


