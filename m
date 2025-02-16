Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD341C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyQ-0007pQ-72; Sun, 16 Feb 2025 18:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwm-0004V1-N5
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:14 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwf-0006TY-Q5
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:12 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fc3fa00323so3157691a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748063; x=1740352863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xYaHSVpuuJwemQCux86oN8VsMmNwcQA05yBYxPQ4D2Q=;
 b=IcPjs8eom/r3TlreNMdwueBEJBpdsy1u+SFmaynhhbcstWSDhtBpD4EIlRoDe21w9l
 ZHrtYPeAtr5LfgbhTm0lBlOWZnI3LCXEG/B022zdVDxJ17dc3EeQMp1zkHoHVc0qJR9b
 yvHpx9+bFpktQsyQOL4dkz0Brq6ZWIuzYf/hFrBBxheDASRJXKSdRjcuOjsldZ4bXKc9
 a0rtXnT2m8XQU9F3s7MG4jlliG+/bDjnJDiYYPi5UqUUvnbtKRcltHGTuJbDE3m0lo6p
 8svHkWtjYnCuiv3IkJee0WiK9JVbDHq+QmDMYeyFUY64/3ob00D0enD/yMLawkMOn4SZ
 OGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748063; x=1740352863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYaHSVpuuJwemQCux86oN8VsMmNwcQA05yBYxPQ4D2Q=;
 b=KgYOvvW2tegrEhVtMd6GLWf0xPOMsEUvwo+lySr9N8Z+6Dylut1VMfi4t/ULlApog8
 jy0kBlcFCzlvdWTfv9kyRgLBBPCZ/qQgaRwqBS/J3EY2Gj8LJZHIYamlsJtcsJfoPWMO
 pCEV6AEkiy+11CxhlaLFIFs2kKkH55I5ZGLWMcOlW4wzbTviYG3zkqAa5TZHmVeHYBDV
 aLITs342Zox9W99LF9n8WHAqyYDS3XwhjcvsiLJZbSNlRgX25FRwnhcFdRVRqQ/dnU7r
 pozKspQucBJT5pyeby+u4kUmHoV0jKXPKDBa1sy+L3NsJl7FbY+2cije53lr/8LODr6K
 3ZqQ==
X-Gm-Message-State: AOJu0Yy3jkIlE+yztAXjEl/scxn/TqL9KmqLs5w1cDsBUCgBgsKll5JM
 Dza0N2XCu19mAlX42cH5+dtost4IWPq4oISI96xAPOs6bN7VjXMitttADIyjtfwbNLOkypu+8Hl
 /
X-Gm-Gg: ASbGncukTeYJqZuWhNP4mZ/Ucl0p67m1WhCrM6pNtT1cCclFnq+mIG4ZQSDBV8gEXvh
 jj+pznmaSuGkPRwRLYrMymXcXdfKxdBLAefAi8wMNnNLvsomvtYueIWDRdj295jrLBbrY4cBp1z
 eLqwaYcAYWxZ6ifjNjMPJk8d48hNdApVNjrz9Al4qQ+KU02jC8rHD4BIe8rKYX2rInPNJzkxCIx
 Wz7ql+0z7CVgTAGFgtCrTuaRoXIhmxI/Zvx9ld41NsGQfDd4knjVkP5f6VL/T1j+XPTE2qRDUe0
 kJj69CpM7scc5K6oedmCfSvB65mhA8fpyhbY+P2xVxci2iw=
X-Google-Smtp-Source: AGHT+IEaaTyB6gt7hSpo+LDGKBfNYCqtA4kcTffiDIhtfsJpEd7go9ZbUJx1dATV/HIn/9JtbqK8nA==
X-Received: by 2002:a17:90b:4d8b:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2fc40f0ecb4mr13685708a91.12.1739748062893; 
 Sun, 16 Feb 2025 15:21:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 142/162] tcg/s390x: Remove support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:51 -0800
Message-ID: <20250216231012.2808572-143-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

We have replaced this with support for add/sub carry.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  2 --
 tcg/s390x/tcg-target-has.h     |  8 +++---
 tcg/s390x/tcg-target.c.inc     | 50 ----------------------------------
 3 files changed, 4 insertions(+), 56 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 0a991f6d5d..f67fd7898e 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -45,5 +45,3 @@ C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
-C_N1_O1_I4(r, r, 0, 1, ri, r)
-C_N1_O1_I4(r, r, 0, 1, rUV, r)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 4a2b71995d..17e61130cd 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,13 +29,13 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32       1
-#define TCG_TARGET_HAS_sub2_i32       1
+#define TCG_TARGET_HAS_add2_i32       0
+#define TCG_TARGET_HAS_sub2_i32       0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_add2_i64       1
-#define TCG_TARGET_HAS_sub2_i64       1
+#define TCG_TARGET_HAS_add2_i64       0
+#define TCG_TARGET_HAS_sub2_i64       0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 36293d0f42..09c7ca5b44 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3064,23 +3064,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add2_i32:
-        if (const_args[4]) {
-            tcg_out_insn(s, RIL, ALFI, args[0], args[4]);
-        } else {
-            tcg_out_insn(s, RR, ALR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, ALCR, args[1], args[5]);
-        break;
-    case INDEX_op_sub2_i32:
-        if (const_args[4]) {
-            tcg_out_insn(s, RIL, SLFI, args[0], args[4]);
-        } else {
-            tcg_out_insn(s, RR, SLR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, SLBR, args[1], args[5]);
-        break;
-
     case INDEX_op_br:
         tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
         break;
@@ -3124,31 +3107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add2_i64:
-        if (const_args[4]) {
-            if ((int64_t)args[4] >= 0) {
-                tcg_out_insn(s, RIL, ALGFI, args[0], args[4]);
-            } else {
-                tcg_out_insn(s, RIL, SLGFI, args[0], -args[4]);
-            }
-        } else {
-            tcg_out_insn(s, RRE, ALGR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, ALCGR, args[1], args[5]);
-        break;
-    case INDEX_op_sub2_i64:
-        if (const_args[4]) {
-            if ((int64_t)args[4] >= 0) {
-                tcg_out_insn(s, RIL, SLGFI, args[0], args[4]);
-            } else {
-                tcg_out_insn(s, RIL, ALGFI, args[0], -args[4]);
-            }
-        } else {
-            tcg_out_insn(s, RRE, SLGR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
-        break;
-
     case INDEX_op_mb:
         /* The host memory model is quite strong, we simply need to
            serialize the instruction stream.  */
@@ -3643,14 +3601,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(o, m, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_sub2_i32:
-        return C_N1_O1_I4(r, r, 0, 1, ri, r);
-
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, rUV, r);
-
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
     case INDEX_op_ld_vec:
-- 
2.43.0


