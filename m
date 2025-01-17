Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA37C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5l-0005lJ-QH; Fri, 17 Jan 2025 13:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5j-0005RR-1K
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:11 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5h-0000Hu-2Z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:10 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so4224309a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138547; x=1737743347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE6kmTZ7Zafe4pp+w0w04pzNctCrVCZYg/jS8o99R1M=;
 b=LXzoER8G9f2j8mGVBFO/+Vjnf2iRuNfGQtojG9r9RE2t2oxzz2W3eYRq8nM+ugAtE/
 WAc7IwVcVykTVU9+yjazxajNJWFuw0W4+wBrzwLCzusI4AYJYmh1PybTNQIBSh5FPjzk
 RXxQww+DY60aMvUGeIwlyQTBD+J8Bq/8ra20JIOuUqsqeXYMrPudcsFl6VcQOFin7MTz
 S25DIL6ItO3aUscRYScBHR4Uz4Jn+c5O0YE9gHir3yzXlcYOP8CKY2S1HEMP0ZkPADxN
 6UWpju1R14W/uck4nCNK7+DTiIvoNKjXKymOwG1ZJebN7VFBZS1ELLYK13JysWygSu1J
 Ymgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138547; x=1737743347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vE6kmTZ7Zafe4pp+w0w04pzNctCrVCZYg/jS8o99R1M=;
 b=pToHtV+H4wVrrqXQs0MMZzWJOTZnFoSD6EontgtzIqHC/saQbHs41wQmIqQsAm6RZU
 rezULBOTULDDW8eOLa88SiBXoGaptz6690qKsHipPjFtfv9EtFzGOOxLA3B2Cos/DWHi
 PPnxBC0XS9l0GbKSNhfxDaaiI9VV+v9LNuBVajr7QYu9MQawy0ZtelFlfBM7CLH2dmnD
 SJEXh4M5Da2yE8jfaTYJ7M6X+ysqBXi66nllm15jK2kGwP8wCaWgklpXqIe4UMAdojei
 +ig+9M3fprZpqg+aZDmdZ+Vv7EPJPhoyrTe3Iuwq7ZT8U2d+GCikc/AQv7NPBBxzozqL
 ccyg==
X-Gm-Message-State: AOJu0Yz+xKYTY+nJf1doKex6lEycO9pfidt+JRcVgm1VmBjg92VG87yA
 xUwDvsxKvHb2mvEBGTDQlqqTIsTvMQ/DWCOCOxY7Hk3Rr/k5YXmo/RbFxhnhW0nJvFzSExPsWLG
 H
X-Gm-Gg: ASbGncuV/FMVD6Yjoq60SazWws4AKDuyln4uuz7CxL+K2AuBdViaLCx4+bK0J8zJDoz
 dmFuFSxkAi2GbfoR+D1z7WbvEfJ9LRaMEito/H7f6BCnRkA4BEF4qM6hBVFHGhmCLozmYLvjd8r
 l2TFbMZN+OhHQjO9C2PyapKt4+rn3RmCPIbec9fFD70U7lBrYhaLTNiqiJBj9yrFCK5BYauBfj6
 GvQgdXVU8lFdtUOXqewyOYhLwawYmihk/KV0j3oX06kSvIwYysEyPmrd1MnDE72+s2at9qPTwFd
 CBnu6jFjjuu6tYI=
X-Google-Smtp-Source: AGHT+IEhj8qAr+KiIaVRXhNOQLxY0flpRcGTev7B2kCXcffdBZtZv5FDfLk4vmvnjn5KTA8jB8RHWA==
X-Received: by 2002:a17:90b:54ce:b0:2f4:4003:f3d4 with SMTP id
 98e67ed59e1d1-2f782d972c5mr5219219a91.30.1737138547560; 
 Fri, 17 Jan 2025 10:29:07 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 57/68] tcg/s390x: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Fri, 17 Jan 2025 10:24:45 -0800
Message-ID: <20250117182456.2077110-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Accept byte and word extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-has.h | 22 ++++++++++++++++++++--
 tcg/s390x/tcg-target.c.inc | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 4992d74f12..72b57407d4 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -48,7 +48,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ctpop_i32      1
 #define TCG_TARGET_HAS_deposit_i32    1
 #define TCG_TARGET_HAS_extract_i32    1
-#define TCG_TARGET_HAS_sextract_i32   0
+#define TCG_TARGET_HAS_sextract_i32   1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
@@ -82,7 +82,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ctpop_i64      1
 #define TCG_TARGET_HAS_deposit_i64    1
 #define TCG_TARGET_HAS_extract_i64    1
-#define TCG_TARGET_HAS_sextract_i64   0
+#define TCG_TARGET_HAS_sextract_i64   1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
@@ -121,4 +121,22 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_cmpsel_vec     1
 #define TCG_TARGET_HAS_tst_vec        0
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+        case 16:
+            return true;
+        case 32:
+            return type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fc7d986e68..dc7722dc31 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1572,9 +1572,41 @@ static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
 static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
                          int ofs, int len)
 {
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8u(s, dest, src);
+            return;
+        case 16:
+            tcg_out_ext16u(s, dest, src);
+            return;
+        case 32:
+            tcg_out_ext32u(s, dest, src);
+            return;
+        }
+    }
     tcg_out_risbg(s, dest, src, 64 - len, 63, 64 - ofs, 1);
 }
 
+static void tgen_sextract(TCGContext *s, TCGReg dest, TCGReg src,
+                          int ofs, int len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8s(s, TCG_TYPE_REG, dest, src);
+            return;
+        case 16:
+            tcg_out_ext16s(s, TCG_TYPE_REG, dest, src);
+            return;
+        case 32:
+            tcg_out_ext32s(s, dest, src);
+            return;
+        }
+    }
+    g_assert_not_reached();
+}
+
 static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
@@ -2726,6 +2758,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(extract):
         tgen_extract(s, args[0], args[1], args[2], args[3]);
         break;
+    OP_32_64(sextract):
+        tgen_sextract(s, args[0], args[1], args[2], args[3]);
+        break;
 
     case INDEX_op_clz_i64:
         tgen_clz(s, args[0], args[1], args[2], const_args[2]);
@@ -3325,6 +3360,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
-- 
2.43.0


