Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9F6C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXy-0008Jd-VY; Wed, 24 Apr 2024 20:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXU-00088j-NG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:40 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXN-00068n-K8
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:34 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed32341906so488537b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003228; x=1714608028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ygFLD876CIrAdUeERdKDaK6OhehnvKPDKxHUBl+Z6U=;
 b=lqE3RzEtD1mVqEHzftl5wCNvH5HyfiY/uZuRQ0OdRuABVeZB2tn4FdNx1DgDZvCTcJ
 wz1rBhX0eps3Xs3ULnWw7wOqKIxgdMRwEYEqLmvZ/JaUg84SOVb26Rxc4pEJi8avDE5H
 F9TI1d+dBJHeTyU/mtqBrGctFk/jHphd788MFsyhUEU+5WNua6K5h36J0UlFVpK3xKBc
 VDdBwYgAIFMO7wcCB5dbxSX6NbfS9ahDHtMI9jMxWau/fH3KXtuA5Npgh8k5GXwVbYtg
 9ezlluXvo1HCeJYur0rM1vByRfwQbCi9kY9TRG0wRemUs0M1XdMqpxRvXUUgsl7b/eHg
 Nbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003228; x=1714608028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ygFLD876CIrAdUeERdKDaK6OhehnvKPDKxHUBl+Z6U=;
 b=beibRtv5Uirh392xAx6VuQoSErxQ3QQ2ayOOR5ERsH1ep6TJhtmPGZMRipK9W60gJ3
 atc6+kUXQ15vylikDeR0/et5t+2ZSAslu1QSKpsiNlIAc7wXZnWNDPI5pa63JRDio12X
 xVL4uMColVKxaaHejsKMrKZ1TxTw/C2drBug36i+Xi8QnEUiUPbSzzyze31+ynPdvmxl
 m2rDYT+B+YW7jg+rEGhuUfunsrxSP1lOSq7asIYFLjvXTuzrqmMnMDrz4fpPySbpP13k
 w1KabGkO/6erknunQhe8ayJYg0mw6HJYjP69bQw7Y0y+cjCrmIG0/k7q2VFV6xkri4Lb
 jpXg==
X-Gm-Message-State: AOJu0Yz7xH2FRk82EUX4IeJ3kCh90vwhXlPVEXQaEcbPEEzP3YNkMXOH
 FOaS+RBFeClDVkdoelHRiqSdrhgU23gC0/s3xFvp+MaIB8X75RFry4n9pNwldXnZj+LNr2W2Wy8
 V
X-Google-Smtp-Source: AGHT+IEJ6PUBsFgYu15QWIhzeyjCplblLsNaXABVCSFDc8qjoLNdxvPTo8ebzUQZsQWqkMOAbFE8og==
X-Received: by 2002:a05:6a20:4392:b0:1aa:928e:62a2 with SMTP id
 i18-20020a056a20439200b001aa928e62a2mr5150599pzl.10.1714003227587; 
 Wed, 24 Apr 2024 17:00:27 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/45] target/hppa: Move cpu_get_tb_cpu_state out of line
Date: Wed, 24 Apr 2024 16:59:39 -0700
Message-Id: <20240425000023.1002026-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/hppa/cpu.h | 43 ++-----------------------------------------
 target/hppa/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a072d0bb63..01dc8781a5 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -320,47 +320,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 
-static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = env->psw_n * PSW_N;
-
-    /* TB lookup assumes that PC contains the complete virtual address.
-       If we leave space+offset separate, we'll get ITLB misses to an
-       incomplete virtual address.  This also means that we must separate
-       out current cpu privilege from the low bits of IAOQ_F.  */
-#ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f & -4;
-    *cs_base = env->iaoq_b & -4;
-    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#else
-    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
-    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
-
-    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                            env->iaoq_f & -4);
-    *cs_base = env->iasq_f;
-
-    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-       low 32-bits of CS_BASE.  This will succeed for all direct branches,
-       which is the primary case we care about -- using goto_tb within a page.
-       Failure is indicated by a zero difference.  */
-    if (env->iasq_f == env->iasq_b) {
-        target_long diff = env->iaoq_b - env->iaoq_f;
-        if (diff == (int32_t)diff) {
-            *cs_base |= (uint32_t)diff;
-        }
-    }
-    if ((env->sr[4] == env->sr[5])
-        & (env->sr[4] == env->sr[6])
-        & (env->sr[4] == env->sr[7])) {
-        flags |= TB_FLAG_SR_SAME;
-    }
-#endif
-
-    *pflags = flags;
-}
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags);
 
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 3831cb6db2..1d5f5086bf 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -43,6 +43,48 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
     return cpu->env.iaoq_f;
 }
 
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = env->psw_n * PSW_N;
+
+    /* TB lookup assumes that PC contains the complete virtual address.
+       If we leave space+offset separate, we'll get ITLB misses to an
+       incomplete virtual address.  This also means that we must separate
+       out current cpu privilege from the low bits of IAOQ_F.  */
+#ifdef CONFIG_USER_ONLY
+    *pc = env->iaoq_f & -4;
+    *cs_base = env->iaoq_b & -4;
+    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#else
+    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
+    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
+
+    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                            env->iaoq_f & -4);
+    *cs_base = env->iasq_f;
+
+    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
+       low 32-bits of CS_BASE.  This will succeed for all direct branches,
+       which is the primary case we care about -- using goto_tb within a page.
+       Failure is indicated by a zero difference.  */
+    if (env->iasq_f == env->iasq_b) {
+        target_long diff = env->iaoq_b - env->iaoq_f;
+        if (diff == (int32_t)diff) {
+            *cs_base |= (uint32_t)diff;
+        }
+    }
+    if ((env->sr[4] == env->sr[5])
+        & (env->sr[4] == env->sr[6])
+        & (env->sr[4] == env->sr[7])) {
+        flags |= TB_FLAG_SR_SAME;
+    }
+#endif
+
+    *pflags = flags;
+}
+
 static void hppa_cpu_synchronize_from_tb(CPUState *cs,
                                          const TranslationBlock *tb)
 {
-- 
2.34.1


