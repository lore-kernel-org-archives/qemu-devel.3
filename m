Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0694C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYX-0000Uc-Iy; Wed, 24 Apr 2024 20:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXx-0008J1-RG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXr-0006Iz-Vq
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e65a1370b7so3857815ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003258; x=1714608058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5fHOltBHJMUYAs0ifImrgAbY5phtILtBQ88LfAq6uw0=;
 b=imfCadOka8VI+pky/QJYJPjFV7aZNcrCVn8+Je7XnRVmVO4+5AKspEg+qghnwHEUHY
 yDUwKMXR0sHPl/hMamT0JVE7unJqojZdeyAAVsDnLJ9z2jnIT8h5tJeV8sYkR3CIxbtT
 aAjWZ/hOyt08FSmjjTrtuSKCxieP+xWTIThGTBZI4cEI0+4Bc20VWMgss4rI2KhEe33v
 NXHe4n+r/9agpMuUpujKLmTo37rUfEogH+4LcSmN0F1RwGtfUKzmw3BdwtrfxCNTtNF7
 bCyyMBaCUPqmyYVK/KYWNon3wFDiOt+GAGAlaoXu8NjQWrqy7tNY7GcZ+oawOL5pjZIq
 P3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003258; x=1714608058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fHOltBHJMUYAs0ifImrgAbY5phtILtBQ88LfAq6uw0=;
 b=Z19xhoUVPp0OPLTGwFchHTukM2ErSA/l/X9I8ypFZVvSaarIsE8Zn+avP7uZf98m2E
 uVAEwueQ6BliKByYDpCieInCotdv7GL1sDKSMtG2lIiM5jjhTSjOM5o3YQKztE/s7i4v
 CcwFhEHXAT2pZLP72FWinroBa2/uUNYVqfcANw+cmafgTDV7SLEKZhLFg/VebBLb7bhF
 vltNeRHXHYOtpxbuex2RCOOzsY/RnF7oFF2ARDzoxDjfHap2Qy2efwXFq5Id02hCPgpe
 lQUdQa16MPxNFawsdTLjZaWbYL9y9tmWiE9OwM3MMYU9TsqNhl7uQaBedM+yGe1nFBYy
 msqg==
X-Gm-Message-State: AOJu0YzBrbE8NS/YT1r6YG8ETaBuUtPXdVMh0FY+RWCrYO/gohJWv2FX
 9HtUM2Gn6os+QbKKDJfXhzfbIVmbrQpLaL3/QMfZimJ51Qg8ZM2eKiuNb97DLVfn3bLlkwx+Jzq
 0
X-Google-Smtp-Source: AGHT+IHpGXUW6dBeBEP3dsDq8ZEIt3hNpICjNe9IPWtpEy6WvKvxO36ZH11sPtFVBeBC3d2lzu/PmQ==
X-Received: by 2002:a17:902:d486:b0:1e0:2977:9dfc with SMTP id
 c6-20020a170902d48600b001e029779dfcmr5404892plg.55.1714003258304; 
 Wed, 24 Apr 2024 17:00:58 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/45] target/hppa: Improve hppa_cpu_dump_state
Date: Wed, 24 Apr 2024 17:00:12 -0700
Message-Id: <20240425000023.1002026-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


