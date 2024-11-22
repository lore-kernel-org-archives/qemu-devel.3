Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F286E65D18
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 03:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEKFt-0005a4-Jb; Thu, 21 Nov 2024 22:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tEKFm-0005YL-JX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 22:22:42 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tEKFl-0003yS-4T
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 22:22:42 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21278f3d547so13415585ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 19:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732245759; x=1732850559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziiRgdmp8/djQe/OUBTNWsmMki7f4gTCJYiLTqE+tsI=;
 b=OHQmRaSVC5NxyDtrUVEueMAfzY5X12tkezD3QPfmlySoC6ssfCo7efn7Ip+qJPm0zc
 ZP8wnvnNPjIWY7WJpw+oL6Sm9XtXyr+MHcHf3RnkvQQBIvMakvKUmShJwYtURC6+EfXh
 xXIN30AdmVxuqr7oJCy/PR6k/sgCrNDwohgMbMYXmGnlYTiIZItYozBJku0ffGpRt2DJ
 1Grk0v3AWWgbI7LhwqxI1gqGhWcBCXcOZX7MZtmvvGe8wCACOGyqOyuuNrqoimE/8XoH
 e9qOvgTu3gSC3XlKfD/tgQlF3KOuNiOSErkCP5e8JQIVczca9TYVb8LxvEWisDbteSJd
 ElDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732245759; x=1732850559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziiRgdmp8/djQe/OUBTNWsmMki7f4gTCJYiLTqE+tsI=;
 b=jseywJGpooCdLVmo7B8l9jAaaET0ajIy/IAaumexH46s67+cFH+ayKjXlovq3cKpTi
 gQb0sFhyoTY5YsttOg1zJZcEc7Izw7KU0+6Suc+mdeGk9/HJxE0L3Na9oj6Bun8f5Cbv
 YJw0l4Y66fuv8MVhdwz1kcQaIYr/T/cHO2T4FwB0KW+b/ShXMwp8ZLXakQ4cg/TPZWzD
 Xt/WGQJZVrfSvFtj3vLGRQ0KgK0C5g070o8wgh3HDvybwvFkxBaKycIZbL0V1Xhbj9Hb
 f5kQgtvX5infNcMZb6Vc5xxCqN6Wrbh0YiEjHlHZj8W5dV6fedUX7fP1K3YlJJsT8YfB
 mrBQ==
X-Gm-Message-State: AOJu0YwFWDIAzL8idcggb20BqaEZU7Oo8ZVcmz3MArQSrL4W9h9Beuhg
 otO4MNNp1hxxsM/GcxwgrCENwFOUOzHJMdn/ByJAL2PMDEvD7GdL+4lxSTOJKaYyfm4YeTIH9fA
 dORlTgdUO8SPsUs3G8WHASbtIqA+/sExCTzGao6fbJm4+QQYmlW4JG6yrOs+f26g+NwNDNkvCt0
 BVy7A9aMo+sUWJQm4GZDdXo9+v19S6yrYi5I6eoll/o/2d
X-Gm-Gg: ASbGncsJlxw5mxbXuLp2Xd8HBiRdziE+ijLM9Y+JX/ZJzIP25/s8LkrrZzoDjKV+MKm
 sqR623syW5RDzlJg/0N8WjUdkFYYrd4A08mxGedsM1uDYLBfpPZK/dADU9+vL+AAlheqpHx+MO7
 Hu/mUz9WlOtDd43Wv9j3566DKSJlRr0oNNGHq6H4lMfLPQAwk/1IMKofEHwnqO+08BV+kg3E2sa
 aeqoVvPhStB8ZMX6TCGLlkWZWpb6SUK1q97HZEvNbx/4WDdGvGkfkzBTVktxwfITj4KgFTsG9qi
 0P3lUQ==
X-Google-Smtp-Source: AGHT+IFZYVmDYfhXQLuGHV+w2uZrMzWRR21YsjcvW60NmTvIH/kA5RVeCpSqQwwT0f5aRNMmiMBoeg==
X-Received: by 2002:a17:902:e84f:b0:212:514:b30a with SMTP id
 d9443c01a7336-2129f72fa48mr22064765ad.12.1732245758605; 
 Thu, 21 Nov 2024 19:22:38 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc157f3sm5506905ad.203.2024.11.21.19.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 19:22:38 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v9 6/6] target/riscv: Add Zicfilp support for Smrnmi
Date: Fri, 22 Nov 2024 11:22:17 +0800
Message-Id: <20241122032217.3816540-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122032217.3816540-1-frank.chang@sifive.com>
References: <20241122032217.3816540-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

Zicfilp extension introduces the MNPELP (bit 9) in mnstatus.
The MNPELP field holds the previous ELP.

When a RNMI trap is delivered, the MNPELP is set to ELP and ELP set
to NO_LP_EXPECTED. Upon a mnret, if the mnstatus.MNPP holds the
value y, then ELP is set to the value of MNPELP if yLPE is 1;
otherwise, it is set to NO_LP_EXPECTED.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 11 ++++++++++-
 target/riscv/op_helper.c  |  9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 01e279dc25..f31735d15b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -642,6 +642,7 @@ typedef enum {
 /* RNMI mnstatus CSR mask */
 #define MNSTATUS_NMIE       0x00000008
 #define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPELP     0x00000200
 #define MNSTATUS_MNPP       0x00001800
 
 /* VM modes (satp.mode) privileged ISA 1.10 */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 828b6a1003..d53ddc384f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1863,6 +1863,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mnepc = env->pc;
         env->pc = env->rnmi_irqvec;
 
+        if (cpu_get_fcfien(env)) {
+            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
+        }
+
         /* Trapping to M mode, virt is disabled */
         riscv_cpu_set_mode(env, PRV_M, false);
 
@@ -2030,7 +2034,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* handle the trap in M-mode */
         /* save elp status */
         if (cpu_get_fcfien(env)) {
-            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            if (nnmi_excep) {
+                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
+                                          env->elp);
+            } else {
+                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            }
         }
 
         if (riscv_has_ext(env, RVH)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 63ec53e992..a4b625fcd9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -402,6 +402,15 @@ target_ulong helper_mnret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mnpelp in mnstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mnstatus, MNSTATUS_MNPELP);
+    }
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, 0);
+
     return retpc;
 }
 
-- 
2.34.1


