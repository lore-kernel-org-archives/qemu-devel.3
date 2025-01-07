Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF937E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XN-0000RG-OV; Tue, 07 Jan 2025 03:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wy-0000Hz-Cx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:41 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Ww-0002wE-3O
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:39 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f4409fc8fdso19042502a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236895; x=1736841695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Du/hcUzCRJCFSS7gZnhBMRv2GOlMkHp+q13zYEfxw8=;
 b=PtHR4bSZayeXzB2gm/5pV/DOeHCQyv/CM26kkkM/LAzAIZHEt0L97fmBn5kYzi7PKo
 lnK8fvey3tTByZZCxFK/f58JZZ0D78MbpCAfy4hrqkkcJqZu/3d4sS2KjwqQ2P8UVXIF
 +s0yB0meAdydfJNDZSd/juzqvayrPcfccJDdnysltm4dav6+RY/QVyZRtE/ERRglXhaH
 aAcQvyx/ZOWzbPMJUlZajGLg+wwVhOT9jP8QF4fp6tq8cORHm/dxqgUTBYK6u1EdcJoW
 S0tGzgcbOwPnUBqb1xGGj2H8lHCRvg5GFRYaJFGPow2CUkhu+N05IVPa8MYsGkyuwgSU
 bgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236895; x=1736841695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Du/hcUzCRJCFSS7gZnhBMRv2GOlMkHp+q13zYEfxw8=;
 b=tl+9zFhSi3XrUwTtf/FN+2TiOQBqrYnxZm8QlDpG4qV/JkwyO/3Ezih1Bz/9sN2G4p
 4IOjTOQMFpqQGYWWFQrz+7QijA7KptbT2H+CNdUi/y23PqBtS7nydFugvNkB8dEUCZvb
 9XZO0Tb635bOWhtqfpWDDmw72nev1S62WWYM9wTiXCtT0hS4j6KZ0xHjmAcnXoQUBIUJ
 JYdvpt3rgtVZ4iTQ++xlgSHiMv8rKUNi5i8NJUTrsZu0cLzoykIJs+ge+HdZJBdxrAlA
 tQk4NTYbha+VoDd9oj5Tl8B4cwcPAbuEUkTsQPuQglvkjeDpxxLJi7TVlZOUciu0JXOp
 xPuA==
X-Gm-Message-State: AOJu0Yx+3cH7hyey/YZqm6B8FF4DCxhfeSFHjfk+oPQmOsO7WhjgPGXU
 5Rw0nUJEZR5EY5o4Q8IT1iTD7tNxTblTZKtzLlWpIxDghtcpwKTP2rmZF9Pt3ey42QRFQS0NWFA
 9
X-Gm-Gg: ASbGncvd+zKvj8AQCTvr952H47f1dK1IHpsZjWwxSvHRCw89Rr+Ghax4Hza+a6KSqg2
 ySUKb42pRkA0xpKGkwdREmSjX+RUZU2tQvgXQsnoL3tnkV6e6mLt41zWx9+2Oh2fX2OVjT86CJ0
 B84l1tV7zrbZluLBhaiqEi7fy9f5AvjY0QdcE6rBLAg9g4hSN8inD+iXINFgPZmnE+NugnNlbEx
 7aSnBm2kR21hNsmmxTwKCpu0Qb02rfuTD+nfiLGjH44fkGI5EWtExzIGcSSreGt30d+tKKi80Ox
 MJjwHu1vpTHJ1TPbtw==
X-Google-Smtp-Source: AGHT+IHyxKVMazJb3qjib+zG229/7BgQWO8pDzXu7L0Rw9mgSo14dJ2v8wgTdvOictJpOgKtyYhkTA==
X-Received: by 2002:a17:90b:2f4e:b0:2ee:e2f6:8abc with SMTP id
 98e67ed59e1d1-2f53cbdfee1mr3142339a91.10.1736236895488; 
 Tue, 07 Jan 2025 00:01:35 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 20/81] tcg: Use C_NotImplemented in tcg_target_op_def
Date: Tue,  7 Jan 2025 00:00:11 -0800
Message-ID: <20250107080112.1175095-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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


