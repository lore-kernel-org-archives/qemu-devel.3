Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0856EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8Q-00074k-IW; Wed, 15 May 2024 05:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8L-0006bd-C3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8I-0001iR-WA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34e7a35d5d4so5368769f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766069; x=1716370869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hio8O4VlGrDNaYjRplJpmTel6P9cR/NqGITHgXJe1FA=;
 b=H9bT0aoqKex4EsRbVsOeRzJLSX9RaoLMdlkMsEh5oVfGvtJdQFg+9Vhr7Eqs9GtfOC
 QcUk7xnQlr3Aa2KiiRgDgWWnUwWWwZjzYO4OryqjEJVErFdtvKfeG45OTCkOeMdaTJY1
 nmrvkzvPdOtXIK2J97pUixswZhnRYlXRHarvvQpia2hlrYS4iw1Tnywc9YUk+0qY4xwY
 M1G3/Qo0y9gWDF4SZncX5Q/IFKH8SicPCgBYOPXIVPUAydvavODgEB2DplEXEttPPy8B
 ZCySkgkSvykjtDMTVp/QQ6k8sDUhdW/odzqDtY7B+g3uzKok7qkUs8FpWUvUsiDswfKN
 8upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766069; x=1716370869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hio8O4VlGrDNaYjRplJpmTel6P9cR/NqGITHgXJe1FA=;
 b=te+NOy5S5OEdp/SkrCYAjsjo0uZSlC4Uiqqjw6fPQ/QXGsebUy3aGsstEP8HGLfyGN
 ZD5z8naBB3kjPew2MyYmIXzVMJokJuYTgbdhexo2+LLiu+xnIojl7GbSGHaorOQ168/w
 C1asdKSCKxj140dpkj/IMsJYsvD0CmPzjO9kWaDJZCBUQE7YcPstr7YgHONFAWBmw2sy
 Q16AzhBGK/k92iTt1BJYwbgkThTAh1MSOI7xjFdNvFcLSWaEFs/rk3NWSqD4nMAUu2/Z
 hog/52QLEIaJHDOkGNbgjyWegD0CywzEmfw4B46fRbhaKK85reLBIPxEZo4hB/xwsaQc
 8EmA==
X-Gm-Message-State: AOJu0YzOWsj0fUOnXM9hMNsm/Bdnt4fcSD3wRuOpT40ztW/yyVqMim4n
 ZTnFsD4ibxPN6pv1wrB/I0ENVCbQwEhnr99koRSODBIgVL5W0JRQrvsZiEAKOOIViE4MIk2e5Q9
 WLhA=
X-Google-Smtp-Source: AGHT+IEHi+11sD6LZP3CibckykcC431WTjTgDE5fmkl3RByw43I/A8YPEJHFG7e835hhtwBlV9O6OQ==
X-Received: by 2002:a5d:45d1:0:b0:34c:120a:fbed with SMTP id
 ffacd0b85a97d-3504a635932mr11051656f8f.15.1715766069454; 
 Wed, 15 May 2024 02:41:09 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 34/43] target/hppa: Improve hppa_cpu_dump_state
Date: Wed, 15 May 2024 11:40:34 +0200
Message-Id: <20240515094043.82850-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

Print both raw IAQ_Front and IAQ_Back as well as the GVAs.
Print control registers in system mode.
Print floating point registers if CPU_DUMP_FPU.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.c | 60 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 9d217d051c..7d22c248fb 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -102,6 +102,19 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
 
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
+#ifndef CONFIG_USER_ONLY
+    static const char cr_name[32][5] = {
+        "RC",    "CR1",   "CR2",   "CR3",
+        "CR4",   "CR5",   "CR6",   "CR7",
+        "PID1",  "PID2",  "CCR",   "SAR",
+        "PID3",  "PID4",  "IVA",   "EIEM",
+        "ITMR",  "ISQF",  "IOQF",  "IIR",
+        "ISR",   "IOR",   "IPSW",  "EIRR",
+        "TR0",   "TR1",   "TR2",   "TR3",
+        "TR4",   "TR5",   "TR6",   "TR7",
+    };
+#endif
+
     CPUHPPAState *env = cpu_env(cs);
     target_ulong psw = cpu_hppa_get_psw(env);
     target_ulong psw_cb;
@@ -117,11 +130,12 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         m = UINT32_MAX;
     }
 
-    qemu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx
-                 " IIR %0*" PRIx64 "\n",
+    qemu_fprintf(f, "IA_F %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n"
+                    "IA_B %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n",
+                 env->iasq_f >> 32, w, m & env->iaoq_f,
                  hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
-                 hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b),
-                 w, m & env->cr[CR_IIR]);
+                 env->iasq_b >> 32, w, m & env->iaoq_b,
+                 hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b));
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
@@ -154,12 +168,46 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      (i & 3) == 3 ? '\n' : ' ');
     }
 #ifndef CONFIG_USER_ONLY
+    for (i = 0; i < 32; i++) {
+        qemu_fprintf(f, "%-4s %0*" PRIx64 "%c",
+                     cr_name[i], w, m & env->cr[i],
+                     (i & 3) == 3 ? '\n' : ' ');
+    }
+    qemu_fprintf(f, "ISQB %0*" PRIx64 " IOQB %0*" PRIx64 "\n",
+                 w, m & env->cr_back[0], w, m & env->cr_back[1]);
     for (i = 0; i < 8; i++) {
         qemu_fprintf(f, "SR%02d %08x%c", i, (uint32_t)(env->sr[i] >> 32),
                      (i & 3) == 3 ? '\n' : ' ');
     }
 #endif
-     qemu_fprintf(f, "\n");
 
-    /* ??? FR */
+    if (flags & CPU_DUMP_FPU) {
+        static const char rm[4][4] = { "RN", "RZ", "R+", "R-" };
+        char flg[6], ena[6];
+        uint32_t fpsr = env->fr0_shadow;
+
+        flg[0] = (fpsr & R_FPSR_FLG_V_MASK ? 'V' : '-');
+        flg[1] = (fpsr & R_FPSR_FLG_Z_MASK ? 'Z' : '-');
+        flg[2] = (fpsr & R_FPSR_FLG_O_MASK ? 'O' : '-');
+        flg[3] = (fpsr & R_FPSR_FLG_U_MASK ? 'U' : '-');
+        flg[4] = (fpsr & R_FPSR_FLG_I_MASK ? 'I' : '-');
+        flg[5] = '\0';
+
+        ena[0] = (fpsr & R_FPSR_ENA_V_MASK ? 'V' : '-');
+        ena[1] = (fpsr & R_FPSR_ENA_Z_MASK ? 'Z' : '-');
+        ena[2] = (fpsr & R_FPSR_ENA_O_MASK ? 'O' : '-');
+        ena[3] = (fpsr & R_FPSR_ENA_U_MASK ? 'U' : '-');
+        ena[4] = (fpsr & R_FPSR_ENA_I_MASK ? 'I' : '-');
+        ena[5] = '\0';
+
+        qemu_fprintf(f, "FPSR %08x flag    %s enable  %s %s\n",
+                     fpsr, flg, ena, rm[FIELD_EX32(fpsr, FPSR, RM)]);
+
+        for (i = 0; i < 32; i++) {
+            qemu_fprintf(f, "FR%02d %016" PRIx64 "%c",
+                     i, env->fr[i], (i & 3) == 3 ? '\n' : ' ');
+        }
+    }
+
+    qemu_fprintf(f, "\n");
 }
-- 
2.34.1


