Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6E6C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Eif-0000Cm-Ee; Mon, 14 Sep 2026 18:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Eid-0000CV-5J
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:00:07 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Eib-0002ii-Bc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:00:06 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so1396042a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789423203; x=1790028003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7hkjhV80uvPjOJbQp94Qr0oZcXefpU/GH8DXWNi5WFA=;
 b=gL9qz+HiAKG4PpxclFaeRb0KW2RGDKqffMaemJWkqtkHO5Ca+a+5WWsP7U4WSZ/k/M
 m/om7clSdcZuSXRxrBCx/yTn/MBxqP/Ub30XjBTk/gLIRY1QD+BK3sJFkSaUUwc0Ehe4
 yYXHirwgsYl2PTzN0Fin/1K3Y0+pPDwAFcPB+gDfmoFL8hqWc0+jKvoY9OBNut9S882T
 U4hM7XaRhPMa5RzsLbOvJsv8PPhQqUNcfrs17SLXZQJItsREf+3r2Bslu8au/7P2gdM1
 THCzDThdL3EP2b/tORy1N7n0uvoXkpkIM9BynUAultyKdJmM2qINw9igRXf1Zq2IOWDA
 35fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789423203; x=1790028003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7hkjhV80uvPjOJbQp94Qr0oZcXefpU/GH8DXWNi5WFA=;
 b=GsTPaqeTTucWaiWBiIrnM5nCDCtE3A4m9rtbd4EVFOuZsQhblzEJY1Xz5TTmJQnPli
 HzMhaGSxJwq43yttwjqbMljhreUvY1N6yCh4FJIzGBdBmnqfX2YUUhz0MnXiymh+msMs
 SN2w6gYy6RaC1BpuWPu4mVHgXrzkYBlxZETNpj8q9FCU3b5IOHpZHHjn7ogoKwmzAPgj
 AeEIOC0PD7wes3rcuTUATUNOrYAXGN5iQNBKDQTMBnofhjt9SogMg7XgTyPqOdNj+v4w
 +mfd2HeqsphPJ+PhqlGEnW7GvUkA0fTpMYFgY5LXe10K5f2S2NoNXlRclUeyyQaeoG5P
 CTEA==
X-Gm-Message-State: AFuF++ncX4kT6zMGbD3NSAiqpWHtWlBsAE76/wX2W+cpVbWsqGfaWc2t
 zonDQ+Io4RUuJK5M5rcKs6GWAHuPhUczjvqfPAeqsI8XkuB/axMKkC8iW+8QfV/RwGhtUJ4K2HB
 fN//9p/s=
X-Gm-Gg: AYBFou1cwZnt5qIf+j0qXBziFUbQ06Av+nxC/hCU6OWaBQJtFiR4YJ1+TXO5SCCMBXh
 CZKUwB5MGUgzKifh71UFeszBf3NPweSYquCfkoDPm8zld3kXjXuln54qmVyt/ChheltLmtH0rUF
 iiR2N5+LGdJYpAR4PVS/Ikou2ejlp2n45lXBv473erbWlE8djYsF82ez08pViCX3d1AU5n96PE0
 HLJyb27H1CXAZiCV6eQ6QINk/QkBX0RCwF0x1kErRg9WYO1lYwBrdTMZALitbBdFmPuJ+Db2H2D
 JC7LCW2zYYFJnmrp4JtYMI0VBhHWkwQprzlqGV7QmjYP92V0qL91WjHTjusQ2RKxrLfNauZJuou
 W3r0vSjpbjbYWw9vp1B8JuN2CG58WvNwSXW2PKRgVrGP1WP2ZdILnT/kkNILIkyQ+bAeS9gzJe2
 WgQXQGx7n/dC3N3/aC/2AYQvExLMK7nO5Icodq/jruc9C/cZS33aE8lo6kKbIcc92xMZJ7d6tbv
 S6iaCMGs54Dluvejg==
X-Received: by 2002:a05:6a20:939f:b0:3d2:89db:1688 with SMTP id
 adf61e73a8af0-3db40422631mr9898942637.2.1789423202966; 
 Mon, 14 Sep 2026 15:00:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bc03778c7sm18753233eec.9.2026.09.14.15.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 15:00:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH] target/i386/tcg: Always initialize CCPrepare.reg
Date: Mon, 14 Sep 2026 12:00:00 -1000
Message-ID: <20260914220000.1757165-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

Forthcoming tcg improvements will diagnose the passed
null pointer with --enable-ubsan:

../src/target/i386/tcg/translate.c:1177:5: runtime error: null pointer passed as argument 3, which is declared to never be null
    #0 ... in gen_setcc ../src/target/i386/tcg/translate.c:1177
    #1 ... in gen_compute_eflags_c ../src/target/i386/tcg/translate.c:1182
    #2 ... in prepare_update_cc_incdec ../src/target/i386/tcg/emit.c.inc:407
    #3 ... in gen_INC ../src/target/i386/tcg/emit.c.inc:2213
    #4 ... in disas_insn ../src/target/i386/tcg/decode-new.c.inc:3151
    #5 ... in i386_tr_translate_insn ../src/target/i386/tcg/translate.c:3514

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb6..192cf43215e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -891,7 +891,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER };
+        return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
 
     case CC_OP_INCB ... CC_OP_INCQ:
     case CC_OP_DECB ... CC_OP_DECQ:
@@ -965,7 +965,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_S };
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER };
+        return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
     default:
         return gen_prepare_sign_nz(cpu_cc_dst, cc_op_size(s->cc_op));
     }
@@ -982,7 +982,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_SBB_SELF:
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER };
+        return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
     default:
-- 
2.53.0


