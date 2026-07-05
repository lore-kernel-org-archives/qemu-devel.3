Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8FCC44501
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdx-0008WP-K9; Sun, 05 Jul 2026 00:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcV-0005Hk-BN
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc9-0004Rj-Ub
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso3366875ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226277; x=1783831077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlU1WJhs/EKnxRmtpuuBgS8HV9oUIdhQMc6Ge3RayaI=;
 b=Dg8EUxH7r7kK1S7o1tH96qSvwjj8v83i5UzPuPZy650+p93amflzk6AqO9XBGLug5W
 OpDXVQ4c7mYRm9g5qvedOWiemcQCQY9lbkepnirREP9l2FC1rgNbrOYgOL0IVnkb6q2s
 6GMWsiVkT6M7mSVrIqb+yOfdotr1wLOPDoqQJzjTzVyOe66T1oVd7zpo4gvhitY1y72R
 pOKgVbuba9+2Cf5iCzXwMnqVzCuaNhPbZYGAHm5J92EXQcTWQy1Fe/G5lNvBoIYaWXre
 bqnnqkYNNspNk0MkQ9BaG3az/2piJ7IxIrPXuwdFZGt1o8th3vbcN3/xAXhWclX6s8jW
 7CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226277; x=1783831077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HlU1WJhs/EKnxRmtpuuBgS8HV9oUIdhQMc6Ge3RayaI=;
 b=B6oRi2vmMxXF1zX+hy9ImsO/Bed/HGhMv4Veb+jpmO5YUrNedBqjKhY474Ri2TDPgO
 adPVggNewg2WOnHE4wrG8NbNlMpXjooRJ0BV7ri5c4I35esVSoqvuEoPA9J4ttdPSRnC
 cQ7Ssp+K2qbwxj7ilIF07x9O6bURkDVOq65sgEtHGh4Q+VrfLWlKJT/MCedO/jRVpuKM
 E+EQHm18lYylzk45+UsFNHJx+YrUQJ4uTWdXqUIIaTYm9FDwIvT3Zen8bYkR4GAbUu7U
 JXDu4+REMvxHpeXxwYbKsA94+5Dz3+0FXlUpJhprHuceO0f6DWe0pn7VCYGBOrkb+XZG
 RmYg==
X-Gm-Message-State: AOJu0YxAlfRSYzkrunrfROR4NpuCmcs/KoNT9T+3hbUzZE4w1iBgBHeR
 PciBn8mOZySgF4wg3itK18xs16JDZgmiGEktECSBIs+Cc8RXLpoFoUdArkoRjlul3+gc/26jAF9
 nQF7F
X-Gm-Gg: AfdE7cl1u6lI3lS0lPGVLS1PJncpVNuYzUM5Ap8wSUz5Ppa+h8627BDgQxzM26a1S9e
 KsTu7huQ7W50k9ILQkPhnIat9jtMSofEyW5Goycz+m88efjs9xsKBHxLrbxKGN8HWqKXqhdO5jx
 ExZ1xwZIkBjJkiyzyWzPySgQHzjzoOlkcsyBMEtvRQkYB+AE6/RDryFJ/h2Ji6xzr/xJELmNW0j
 jQJmEyFLUH/5kmam3XvhGYMx9zVjGgAFj2/yo7Y9DkVHGFmkAVia13RZwoPagIRNVMEhvDuunaw
 32aIapA1AAgyVmlOVU5qMrUTpFOEQ0dSX2uNwe4yvMMkBIxtEenOw6Z8dbnOv5KPLnxegZGiSuI
 q/AHWVr8hD3iRyukYPQKJtnzhPZTCBpKxzmr1a5xOXq/CFxX9MPnLHvMpyfY83J+buoIscJW3sL
 H2QWPcN/rujZWMB6qsU6+FY8WZ319XNyujxsYAQ7xXSdu6pak=
X-Received: by 2002:a17:903:26d0:b0:2c9:c083:cd50 with SMTP id
 d9443c01a7336-2cbb9e2e2admr50526815ad.17.1783226276557; 
 Sat, 04 Jul 2026 21:37:56 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 35/46] target/ppc: Use CPUBreakpoint arg in
 breakpoint_handler
Date: Sat,  4 Jul 2026 21:37:14 -0700
Message-ID: <20260705043725.1373137-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

We don't need to check PPC_ISA207S, because that's already
done starting with register_book3s_207_dbg_sprs().
We no longer need to check BP_CPU or clear watchpoint_hit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 51358c901f..56ca66e7b5 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -314,19 +314,14 @@ void ppc_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
 
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        if (cs->watchpoint_hit) {
-            if (cs->watchpoint_hit->flags & BP_CPU) {
-                env->spr[SPR_DAR] = cs->watchpoint_hit->hitaddr;
-                env->spr[SPR_DSISR] = PPC_BIT(41);
-                cs->watchpoint_hit = NULL;
-                raise_exception(env, POWERPC_EXCP_DSI);
-            }
-            cs->watchpoint_hit = NULL;
-        } else if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
-            raise_exception_err(env, POWERPC_EXCP_TRACE,
-                                PPC_BIT(33) | PPC_BIT(43));
-        }
+    if (hit->flags & BP_MEM_ACCESS) {
+        /* watchpoint */
+        env->spr[SPR_DAR] = hit->hitaddr;
+        env->spr[SPR_DSISR] = PPC_BIT(41);
+        raise_exception(env, POWERPC_EXCP_DSI);
+    } else {
+        /* breakpoint */
+        raise_exception_err(env, POWERPC_EXCP_TRACE, PPC_BIT(33) | PPC_BIT(43));
     }
 #endif
 }
-- 
2.43.0


