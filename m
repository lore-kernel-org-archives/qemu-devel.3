Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA47C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mIL-0004vr-I9; Tue, 15 Apr 2025 15:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mC5-0001ph-CV
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mBz-0008PY-46
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7376e311086so7847766b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746209; x=1745351009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xYaHSVpuuJwemQCux86oN8VsMmNwcQA05yBYxPQ4D2Q=;
 b=LqiZ7ObNM2qfnBoH1xevwcle52yfnwd8l/hce6YPNLlA0cpqwrIXSNVUkqG8umiRvF
 5B+6SFQ8cBpp4w3TJd+QhtTcHAqMCteJLh2z1EH6rzUvBUb7NZV4XsgxP1qAXNYtWDi3
 8qeu8XAv6d/Y7udXFWWX42josuVfxuKr+dinAkx6msYXVRKDlDZPbsb3+NaSj8eDT/OZ
 3hKQhwV88o+QLi5YTisrWnxFMerjkSf2+UQqYozMKoTKA7Tmj4ZhCFVI6lPX2meNqR6s
 uLfOfTk3UptXTeIKOxqghrNytkpQYAG12sVU2uGBPCQ8nupYhGkCcqshH5KVF1o5991g
 ypGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746209; x=1745351009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYaHSVpuuJwemQCux86oN8VsMmNwcQA05yBYxPQ4D2Q=;
 b=seMqXfmlpvQEp9ozYnvrBpf23w0ELuNTSNmqZMV34NETsfYlLRVzNW8FqK/o9W+KKm
 9xCx9rYJ4zNrCIHrmVPUEwif/tZnOGqx3fqoRs5OknHKcOjy9LKnxSNnElkCr1HX1lxg
 tV/MTSnKXe9E2KgwoGzGCtgZCpkNqc0iX20JG3VudGavNZNqiMLd5RvXLPsZC0B2yKBM
 2kuuIxY3FkbdpgfMPV5FxwQy+enwup7+FHVyLKU4K0iVFk6kQtVNlLjCmKdyclNl9HG4
 BdKrcbFR/f57hD+vSWOlX0VD/kx/KJrJk6ZBPQTHLyDU6NnSWzzV/y+QGF0AUnGNam37
 xNiA==
X-Gm-Message-State: AOJu0Yy2frpE+IR/yElYvFoZ2Az9VLRCJ4vvO/buvlVS5O8DOq1PivoG
 2BU8ZMdZZRdHFS2jMarD9q70Cq4pSKbDXZVwCEAC7qiRn38nQ5pZvj7qLxlTLIHbZGnctVD1EmL
 2
X-Gm-Gg: ASbGncsQmPjj2ne4ipGJgcM5luxXeGtOU70mURaKrQra8Vj2PXOANQgCDC+bChzVJE/
 rxCDHpJbDmv4sc2or47n+ifty0g4QhvK+kkK7ecIySNy2xhenRyl48/IakiH45qcXMbrbYIOO+Y
 ioDNVnmbdfHdc3IFWMh9VRQQjRQjbgKMbBfTnjCazx5Y8zzXNKXUtKZJd0V/UeQN65dHM4c0T4E
 T8yXtlwZgLrc7vEq/7TpsXLlcBMOQpOpW7Q3apcsKC97TXSBjS8BOnlGqyo7Rl2LksS/Fb/cL5E
 GmE5AH/2HFs1nThdakY6btxoSAxtCK4hvzKNMB8MQ/E5ZT5Bfs3p9slOMdkgTvjjTfmhixTiUjw
 =
X-Google-Smtp-Source: AGHT+IEV/yMN1RsnLOeCGcsfqfajk6PVPb92f/jfwV944rjD6UJoOUINX6m0MHkW+swP3g6VnX3UTw==
X-Received: by 2002:a17:902:ba95:b0:224:194c:6942 with SMTP id
 d9443c01a7336-22c31a86b63mr4159995ad.34.1744745775397; 
 Tue, 15 Apr 2025 12:36:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 143/163] tcg/s390x: Remove support for add2/sub2
Date: Tue, 15 Apr 2025 12:24:54 -0700
Message-ID: <20250415192515.232910-144-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


