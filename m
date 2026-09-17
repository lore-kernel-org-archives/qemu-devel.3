Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592D9C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jnv-0002Yy-BG; Thu, 17 Sep 2026 17:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnt-0002YM-L8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:01 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnr-0007c5-Ql
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747f01363so656945ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681078; x=1790285878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4FHOhpejOV47/X37ErUbW9PdgEcWnyMAOss72MLQgec=;
 b=vR9PiJ2/4lRUdUzwJJSpwqF+EvPpOEcy0zVoZEBO0Dr8YZJRKx8Wd8b0NgKF1f+/RT
 l60hzSBwKRa8KHJBPDkJDOQ4dxsME40BcVElilzjxs4Y9bwvC35BaljOD4mxY5sakS5r
 B0tTxpByGf4m36UYsBxA0VD7xorNsvqSFoY7B/fyfvnUhNnE8eH7UXFpwtu5PoO6K4EH
 +xLHR2qMCfaLadpZwnJWMvGiVVq+BFZJUeTnkvHUGvAYZJWwpRaB5hFWLh1hg6vrFd1q
 Zi9EgcQOf+spUW00L+3irMT8Mz67+eybuiiN+zGfLw/fVLD1Y05TS4XLK7oxOlVc17Dh
 vZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681078; x=1790285878;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4FHOhpejOV47/X37ErUbW9PdgEcWnyMAOss72MLQgec=;
 b=sn/FsCUEOx1AYtRkdPmWHLkUCkULMkQ4Jib6elkFmb2E1ohz+AzeWji7lxSuVekS03
 ZGJvHVBfL4Gv9vczjD6rKv3vXyEMxC/eg7TT3Fa0s4W0Az1TLtEDaLU9QwPJCW3DkUIY
 2dLRciYQ24l9KfGMjWFFui0zfYAQPOX2UfJHEQuDDSG4FEo6V+JRZbOilcI6+QHPfRix
 dKuQQysS4/tbskF0CyU96+JTfUySMzdv97XiFDyQDN7HlrTTlhZ1LFyT+E2l9zIIURGn
 h+KDnfrksx3C1GtcoNfvvXDdQLMsM81IHMgwIBPsvJIw5lBsoMenVvYyUHwp0etMClpt
 ukvQ==
X-Gm-Message-State: AFuF++ljYw330hW1zaww7FMwrxGfMqa8CfJW0Q/q8siTvgVD80Yf9Z2o
 dnGI2PdwcmsJEkfV4Bp4IvwDRWvxZ2qZWMj3tgWHcJpEF0psLOgSYI6RkhsPESxM7GelGK1SNiP
 WhncF4BI=
X-Gm-Gg: AYBFou01LDNyjJaxTIvJjnj8j/dWiaLWNJZ01az+xpYwjLebttP/qdj+HgShRi8RL5w
 LIjhtdhF4AN6+0wSf3FR+r1syF9OybxbDjCiq/O1onRoRx1U9dV5IeW57DHJxf+20/BXTVupzGj
 EEhIz1xrVaARUGBJDTChZfURd1v6q7timlrUyiU/3/4lh+6SkeOY/h2orQP6HwhRLvH3iOJbeXA
 uq6UqHiM4Sqk8Iuh8RrD9vcDuLEVhmr6EPD5nEvLo1uqjKc2IGT6qiOfCTlP2bkcU3A4D1n8cK0
 9/Gk5pdd2qAKqanXoWYru9LgaxzUwQXZdXrVN2Pntto+uzCg9AILGr3fxFGN/LwJKKKcZyp93d0
 2iAIocn0KNYbGF0qDEvMWoCNU8WCNZA4WSkRB1G8YiBdE/LAohGAd1Na3K+2Hpod0TazHIra8pD
 PWAJ6XbBxaQumREScm79sfjjGaPIsl978gfAQxcKdYd/8qFJ1RoD9uwbS9xYPK8y2PSVcJ8HZ4e
 ukyhGc=
X-Received: by 2002:a17:903:4590:b0:2d9:2688:8be6 with SMTP id
 d9443c01a7336-2ddb1b898afmr9769325ad.19.1789681078045; 
 Thu, 17 Sep 2026 14:37:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 05/15] target/s390x/tcg: Convert op_ld32s to op_ld
Date: Thu, 17 Sep 2026 11:37:39 -1000
Message-ID: <20260917213749.36756-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Note that op_ld32s already or'd in insn->data, with the only
use being MO_ALIGN.  We now put the entire MemOp in insn->data.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-6-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 14 +++++++-------
 target/s390x/tcg/translate.c     |  7 -------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 23b00a0eeba..69d5114f244 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -418,12 +418,12 @@
 
 /* LOAD */
     C(0x1800, LR,      RR_a,  Z,   0, r2_o, 0, cond_r1r2_32, mov2, 0)
-    D(0x5800, L,       RX_a,  Z,   0, a2, new, r1_32, ld32s, 0, 0)
-    D(0xe358, LY,      RXY_a, LD,  0, a2, new, r1_32, ld32s, 0, 0)
+    D(0x5800, L,       RX_a,  Z,   0, a2, new, r1_32, ld, 0, MO_BESL)
+    D(0xe358, LY,      RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_BESL)
     C(0xb904, LGR,     RRE,   Z,   0, r2_o, 0, r1, mov2, 0)
     C(0xb914, LGFR,    RRE,   Z,   0, r2_32s, 0, r1, mov2, 0)
     D(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld64, 0, 0)
-    D(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld32s, 0, 0)
+    D(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BESL)
     F(0x2800, LDR,     RR_a,  Z,   0, f2, 0, f1, mov2, 0, IF_AFP1 | IF_AFP2)
     F(0x6800, LD,      RX_a,  Z,   0, m2_64, 0, f1, mov2, 0, IF_AFP1)
     F(0xed65, LDY,     RXY_a, LD,  0, m2_64, 0, f1, mov2, 0, IF_AFP1)
@@ -434,9 +434,9 @@
 /* LOAD IMMEDIATE */
     C(0xc001, LGFI,    RIL_a, EI,  0, i2, 0, r1, mov2, 0)
 /* LOAD RELATIVE LONG */
-    D(0xc40d, LRL,     RIL_b, GIE, 0, ri2, new, r1_32, ld32s, 0, MO_ALIGN)
+    D(0xc40d, LRL,     RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESL | MO_ALIGN)
     D(0xc408, LGRL,    RIL_b, GIE, 0, ri2, r1, 0, ld64, 0, MO_ALIGN)
-    D(0xc40c, LGFRL,   RIL_b, GIE, 0, ri2, r1, 0, ld32s, 0, MO_ALIGN)
+    D(0xc40c, LGFRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESL | MO_ALIGN)
 /* LOAD ADDRESS */
     C(0x4100, LA,      RX_a,  Z,   0, a2, 0, r1, mov2, 0)
     C(0xe371, LAY,     RXY_a, LD,  0, a2, 0, r1, mov2, 0)
@@ -464,9 +464,9 @@
     C(0x1200, LTR,     RR_a,  Z,   0, r2_o, 0, cond_r1r2_32, mov2, s32)
     C(0xb902, LTGR,    RRE,   Z,   0, r2_o, 0, r1, mov2, s64)
     C(0xb912, LTGFR,   RRE,   Z,   0, r2_32s, 0, r1, mov2, s64)
-    D(0xe312, LT,      RXY_a, EI,  0, a2, new, r1_32, ld32s, s64, 0)
+    D(0xe312, LT,      RXY_a, EI,  0, a2, new, r1_32, ld, s64, MO_BESL)
     D(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld64, s64, 0)
-    D(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld32s, s64, 0)
+    D(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld, s64, MO_BESL)
     F(0xb302, LTEBR,   RRE,   Z,   0, e2, 0, cond_e1e2, mov2, f32, IF_BFP)
     F(0xb312, LTDBR,   RRE,   Z,   0, f2, 0, f1, mov2, f64, IF_BFP)
     F(0xb342, LTXBR,   RRE,   Z,   x2h, x2l, 0, x1_P, movx, f128, IF_BFP)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index b724db6a1cf..42b208a3cad 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,13 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-                        MO_BESL | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-- 
2.53.0


