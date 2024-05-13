Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A03EC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QR4-0005LP-Nl; Mon, 13 May 2024 03:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPV-0002wm-IT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:49 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPR-0001QF-C7
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:49 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e0933d3b5fso58355281fa.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586463; x=1716191263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fHOltBHJMUYAs0ifImrgAbY5phtILtBQ88LfAq6uw0=;
 b=MjY8TUWcjoJEqiO9gLNWvlWrV5vlRZJ7xitLPjdqzHLosGqOF1n1/6CCeGDmiZVRto
 pQxMJyi4B+cPwUUgVp2hsmKl9DdeJJNHQ3FipSY0Du2KH4WTeAIb10HSqWfyx58p89A4
 s2133UcrTtE0jBTiWiYPuMcNok4XpXJ6aWA84Am9hunKFkfbaMzA0PWO+fOpQcXSr+HB
 44pOADLhg5E3UtB4fYwq2CEKWsEPTsTysc8hTJi7j+LxYDQ335azaruywyr5eio+XGll
 gsuW8VmkTeYaqnGVwgkVsgtqrYhN57av8RkHQujWnxw/F/kROO1Du/j7w819PwtimBJZ
 DdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586463; x=1716191263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fHOltBHJMUYAs0ifImrgAbY5phtILtBQ88LfAq6uw0=;
 b=XohluoPHr3Dv2R9P2rLclkOxODhcNbHQAYSakSFQamtud9sOQMLZYwRhaQS91BlJ7J
 /+u0Vc0pb57RqPfqI3rPVBkFjVLCcIKgOrM4N6WwyDXdBjL9Kr3x9l+blW/G5WJ31TfF
 A4EaDzaR6WSlkfOSKBg+wdDjpn7dW0Ezrj3/CQJ+TKEZ/HQT5GL+spZab5jjqleBjc67
 Ryzc34JNJWBnrggIXkO8zvMv46adyUzbhs6xr6sgLVokzZUnPFxP+hlsPGiKeeJ8M7Uy
 T0YT6Pl9C5x4OVO2HzOkJc5tA9Dqe0LHSJbcROp8w3J4XHl4/zhLuLJUq52Q9GEnp/BR
 Ql+w==
X-Gm-Message-State: AOJu0YyeVuRig0j/OCvVbmA9LMnrz5fsvttCiApnZCiqhAlzrpfUW3Wk
 xQLVby/7oG9DcwK2kTYTVhPFovn+aH6N3ZjlClJoPwt0QCAsGp025kAKe9dzsz9Ih7bJ3/m02+S
 e8Ac=
X-Google-Smtp-Source: AGHT+IHpiw0rxSNxvecMQU54mMr37rH2BS2K5CUI5K6OBOGcwGnFb5IiggF1T3r1BFIhbUOp4PkLMg==
X-Received: by 2002:a05:6512:39d3:b0:51c:5087:909f with SMTP id
 2adb3069b0e04-5220fa71af9mr7684054e87.10.1715586463712; 
 Mon, 13 May 2024 00:47:43 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 34/45] target/hppa: Improve hppa_cpu_dump_state
Date: Mon, 13 May 2024 09:47:06 +0200
Message-Id: <20240513074717.130949-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x230.google.com
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
Print floating point register if CPU_DUMP_FPU.

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


