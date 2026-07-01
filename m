Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E685C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welGA-0005zx-JV; Tue, 30 Jun 2026 23:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welG2-0005kx-41
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFy-0002su-9U
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c9dbd00f1dso940805ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875096; x=1783479896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpBHHB2qT6NwCe+qvDWA02RscHS+6npmH3JynUqQKmc=;
 b=pVr27IqIX7K9tkV9V4vQAxRprMOK9HRFSf5IUeVlw6NrumilGlNE+K00VhrVxL0Ksz
 U/f+8vek9VhvQVWHSAKE+l0wLKPwnjEB+1v2+hrA7outWDF774B5Y12Qlrw5V0fbS7zv
 uYQnjbh5qOkiR6N1VjTzFT3tA+CHGDalGokXQ+3icEqU3+LnIh54ombxURanxlrNzRFA
 EJg1LEWH+IHIQ2khOvnds6WCBNclncA2CnpKo3B8y8Qb/m2eUgNog6YjhUa8bBGES5fY
 GB1Fu+yNh9GnaGlZchkHIEdBHBdWeIWbNSmspGI21PM0ehjbhhTLCcamQV1MP++zplbE
 DUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875096; x=1783479896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpBHHB2qT6NwCe+qvDWA02RscHS+6npmH3JynUqQKmc=;
 b=ght8Wc4EjXtjfp8EpZfC3u2BpOotqX+SOw3DJaxbNH+vhGwc/XROh+82m3MbYL0oyA
 uVAnFgskDDs210tn4NpslvoKBun+c66zsDbnGcM1j2IjjylCM+LVqOOr2OUUWlPN7wbY
 oKBb0FeRM62u0Bm5OgWfu/0uls5lzV9kKNh7N5kYHPktDBMi+mxvUB0lWSdgjfddlQyE
 ue+DyADuFa/5S56dQj0d9MrSF9Jbp7QRVRQoHXLubo9AoxVIq3j3MxMVKCrYwcm6oYAF
 qcup8hQFMlBlZyYn/lK+6z4+Ej17CQUoGK4RSsvz5uIN7hx36kIWoh3KfzBOx9bx73Pk
 Fwmw==
X-Gm-Message-State: AOJu0Yy8Evby6RgXr/vDkw5m8gV0dVFEy83cxZvMMni84JBTpPdY4EZd
 R03cPGjWLddc3NUIr3s8V/E4BiE57tTF/01bGS/FvqsWFGCmHO8EQQ8s2I8+HWLGXbobm1GLG57
 2uXzm
X-Gm-Gg: AfdE7clVJAnAZeqVofCIHBO6LIWVhzmJjjU5dkRRHtReABD/emEl4oRLqA4NVZRVR3Y
 xvWXR/02devPUXRq53uBFZahvD/aACeBZBraZkWqpGum8Tsgzj1Swh6wD6bLOwUJ5fwHoOKUiCD
 VmeZpVrJuOi8O2z6T5IloIystCqCxKu0F05h3ae4h8Ti7e5zxiLD0Ra2IfVkpENFzzo8rTHLfS3
 5KYzUUhw2QSdmcjV2vAQwhADpE/vxofEUbwqqKcyfM1FnPM08V0DlRsznGd0xY+8Azr/onmiCGZ
 r1b5dcLQ4cz+OkI6cLKPfy2sY66YxBnKmj5p0yorWD60klvkA3Gh6WUaed/NnsZDadbwNwh+E2+
 CeKhx3aSUv2Sxww9xPHlC0ypcIFlO3Meu3jPX1hDeHInStqfn793SdXDR9UGFDmdI1Ca9WzH8ZZ
 NgPFi1OALE24xjwY45m9HL3jfuycA7mPrvdqUuobU4mEzVuU9X9w==
X-Received: by 2002:a17:903:32ca:b0:2ca:eeb:cf64 with SMTP id
 d9443c01a7336-2ca5a55bb23mr28523375ad.9.1782875096270; 
 Tue, 30 Jun 2026 20:04:56 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 14/17] target/riscv: Use bp argument in
 riscv_cpu_debug_check_breakpoint
Date: Tue, 30 Jun 2026 20:04:40 -0700
Message-ID: <20260701030443.1382447-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the ID of the breakpoint instead of a loop over all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/debug.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5f76dd4b7a..f6ffc62f1a 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -943,41 +943,27 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    target_ulong ctrl;
-    target_ulong pc;
-    int trigger_type;
-    int i;
+    int i = bp->flags >> BP_CPU_ID_SHIFT;
+    trigger_type_t trigger_type = get_trigger_type(env, i);
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
-        trigger_type = get_trigger_type(env, i);
-
-        if (!trigger_common_match(env, trigger_type, i)) {
-            continue;
-        }
+    if (trigger_common_match(env, trigger_type, i)) {
+        target_ulong ctrl = 0;
 
         switch (trigger_type) {
         case TRIGGER_TYPE_AD_MATCH:
-            ctrl = env->tdata1[i];
-            pc = env->tdata2[i];
-
-            if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                env->badaddr = pc;
-                return true;
-            }
+            ctrl = env->tdata1[i] & TYPE2_EXEC;
             break;
         case TRIGGER_TYPE_AD_MATCH6:
-            ctrl = env->tdata1[i];
-            pc = env->tdata2[i];
-
-            if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                env->badaddr = pc;
-                return true;
-            }
+            ctrl = env->tdata1[i] & TYPE6_EXEC;
             break;
         default:
             /* other trigger types are not supported or irrelevant */
             break;
         }
+        if (ctrl) {
+            env->badaddr = env->tdata2[i];
+            return true;
+        }
     }
 
     return false;
-- 
2.43.0


