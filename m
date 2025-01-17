Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D55AC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2P-0004UO-IM; Fri, 17 Jan 2025 13:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr29-0004AO-5Q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:29 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr27-0007uk-46
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:28 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21661be2c2dso48278725ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138323; x=1737743123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Du/hcUzCRJCFSS7gZnhBMRv2GOlMkHp+q13zYEfxw8=;
 b=Ob6FmSdDTixNi07w48hCDCOv0rcosHU9ELPR3aoBUd+VtR33ge7DMsYSeMe8SHaNrX
 4osimsgMTlsNt96+9XUWHo1TcqLOS8qRDvx7edC1+mawxEQj86wLEtbG1xa5y9L3V/OC
 Z87HyiQBp8SV0ylmfCxjt+BA0s/Aj3Uy3eYCocLZ1Hpjv6z+0cmoBViuo5Bytwg83fiN
 ByhvHkhlj69nCjGJqfQuqcsfvyazS7p7NYs9fgfUWvep0osJnAHASe5wGap+T0ZbZKHl
 lbaAP0OTyv4Bpw9NOe2/3n4tBiZqw7XWKeQpxBH7Htwd152skBiMj8F85KwWv6LIGZle
 N7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138323; x=1737743123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Du/hcUzCRJCFSS7gZnhBMRv2GOlMkHp+q13zYEfxw8=;
 b=b1BrHptAMBBoxJq9WDXg8UjDHoBNLNuv0NOdhJSVjEUjXESFr2y9qC0nAzF/99DYx+
 8yukzcHPNCwuYfNDNIjGoIgjuhxAorss/dhrsVfojDAGm7rTm/y7wSDhl96grKW7+ulR
 WuniHUAZEaOXT7OLvFKUkqBSu1+rLsvDtPmy4NCbXX1atsGkeUU6igse6cjyF4B2gOUZ
 D6CrK1X6TkDFsqh0B1NpIv815tsZIW3h4IgpIu//2bsomWMRLzopaWcR28/qNEZt4622
 RX1PO1DJsgEqzLe3C5yG5IFILS9nbtKg9uFzaIofdLkMjjtgIVeGuTIiOYJMjrCsRw0H
 Z4jQ==
X-Gm-Message-State: AOJu0Yzjjzq95jCp6eceLBmZ7FVwi2riHkHWP7ZYl9ol8RqASGDs3KIB
 1fCIoUQSQpPZQXr4BPIK03ooyPreLFluv4ooDVPMFUkBpfCIXgWrE27P0Elvj2fwu5Te2vK++05
 b
X-Gm-Gg: ASbGncsFGmmXV35r+Q4hwJr/N22ypEaV7wUBa0mgB8pRKNrYKpi7f7Yc6FtIjQAlE7/
 Uh+zAruw6pdwjIhoelhsgR9b6bkiRPF0iapWeLGI3GhdqnF99fiqEfbJ8gKziJmaamdP7F65tdF
 C+r+yBRApzg9eAtl//Fctojom9hQVErSTciPRSyiKRfpxU2CUeFebS6S59IwO9tt0f0esqwRfup
 WWTWgJ+KN6jQ/FyA4jIZWNKoWW4sJyqVc10o1K/qQmzPMR+D+aMitb1r87Yq/mvmqSekxVY3IvN
 5k6q6eKScsBthNg=
X-Google-Smtp-Source: AGHT+IGvlXhHot+TZtaSReiscRsImwCaWNWSqkhko6qlOV7OPNVNpDHU43BOhqVGs3aOV84JSzhfVQ==
X-Received: by 2002:a17:902:e80a:b0:216:6769:9ed7 with SMTP id
 d9443c01a7336-21c355c7dc2mr59086525ad.40.1737138323361; 
 Fri, 17 Jan 2025 10:25:23 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/68] tcg: Use C_NotImplemented in tcg_target_op_def
Date: Fri, 17 Jan 2025 10:24:22 -0800
Message-ID: <20250117182456.2077110-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Return C_NotImplemented instead of asserting for opcodes
not implemented by the backend.  For now, the assertion
moves to process_op_defs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 10 ++++++----
 tcg/aarch64/tcg-target.c.inc     |  2 +-
 tcg/arm/tcg-target.c.inc         |  2 +-
 tcg/i386/tcg-target.c.inc        |  2 +-
 tcg/loongarch64/tcg-target.c.inc |  2 +-
 tcg/mips/tcg-target.c.inc        |  2 +-
 tcg/ppc/tcg-target.c.inc         |  2 +-
 tcg/riscv/tcg-target.c.inc       |  2 +-
 tcg/s390x/tcg-target.c.inc       |  2 +-
 tcg/sparc64/tcg-target.c.inc     |  2 +-
 tcg/tci/tcg-target.c.inc         |  2 +-
 11 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3576299a1c..05bb464940 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -862,6 +862,7 @@ static int tcg_out_pool_finalize(TCGContext *s)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
+    C_NotImplemented = -1,
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
 
@@ -3176,6 +3177,7 @@ static void process_op_defs(TCGContext *s)
         const TCGTargetOpDef *tdefs;
         bool saw_alias_pair = false;
         int i, o, i2, o2, nb_args;
+        TCGConstraintSetIndex con_set;
 
         if (def->flags & TCG_OPF_NOT_PRESENT) {
             continue;
@@ -3188,11 +3190,11 @@ static void process_op_defs(TCGContext *s)
 
         /*
          * Macro magic should make it impossible, but double-check that
-         * the array index is in range.  Since the signness of an enum
-         * is implementation defined, force the result to unsigned.
+         * the array index is in range.  At the same time, double-check
+         * that the opcode is implemented, i.e. not C_NotImplemented.
          */
-        unsigned con_set = tcg_target_op_def(op);
-        tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
+        con_set = tcg_target_op_def(op);
+        tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
         tdefs = &constraint_sets[con_set];
 
         for (i = 0; i < nb_args; i++) {
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index d77d305f30..d1e08def60 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3158,7 +3158,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(w, 0, w);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 90ac80077f..b4cd36a9b8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2260,7 +2260,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
         return C_O1_I3(w, w, w, w);
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 167228a781..813c12ca0e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3885,7 +3885,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I4(x, x, x, xO, x);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a273e7fce5..686b94ccda 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2391,7 +2391,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I3(w, w, w, w);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 8857398893..199bd97c0e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2292,7 +2292,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
                 : C_O0_I4(rZ, rZ, r, r));
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 94997b126f..3ce4fa1db6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4354,7 +4354,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I4(v, v, v, vZM, v);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 7d1bba100a..51cd7e7586 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2767,7 +2767,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_cmpsel_vec:
         return C_O1_I4(v, v, vL, vK, vK);
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fdf57c0b07..98925b1d5d 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3427,7 +3427,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
                 : C_O1_I4(v, v, v, vZ, v));
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index fe3e727399..1201607722 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1627,7 +1627,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, r);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 5f88ca0537..74b649c902 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -186,7 +186,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I4(r, r, r, r);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
-- 
2.43.0


