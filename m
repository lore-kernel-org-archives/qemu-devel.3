Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD97DC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5l-0005jU-FL; Fri, 17 Jan 2025 13:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5h-0005Ca-2m
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:09 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5f-0000Gr-3e
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:08 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso5827623a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138545; x=1737743345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMG+oLoCjABLWPojpZt4F9SjI0QtkGeaKIfn70EscWo=;
 b=KsraHB5yhZxa5hgQPUVZ7JR7eSaGkDhSqPuJMoKV8T+gx1AxutYsRJujWzX4Bwzu94
 NUkv7EYLnUv8v3pA/4QoVwWf80akEanZE1uurCqBafe37QkueWLZhfu8kHTBiD9VFR39
 fqrxf87xY0QPBpvxacxuPuIAui+dCOb8uydVqT5BnuEOsrJl9HV6wqpjtoLSvvyl5PMS
 ReecPtJGPkEhkwd/xquvUAGBrvu9iM68d5bQ8+2VlIyYEfiTa7eXZ0jlB4LDIe/oZgeA
 2QWdoi3KITTBFiVIDemRfYzGk+TleNmC0lJ/bY+37EsHhLUdbKZWnDQbxhlSPu3XQhiW
 8iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138545; x=1737743345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMG+oLoCjABLWPojpZt4F9SjI0QtkGeaKIfn70EscWo=;
 b=cXxX154xZYjsP32xaKNUTzLrPqd0DbqCtb8NjcWfJAY7vFEBbc56pbBGRZASZSaLAn
 WURKmtcCL4JHqxHAhoQlNpN6Y4mhMPfPojlygqYMwvcOzQN2en5zSLruwJzqGP1VLMLl
 usjfSOBrJPZdFe9ThirkIsKI+GICgWvsk+c1iV0b6cJsjSs4N7sSjH9trRI930LOWsuv
 R3QcQg6QWfGYig02QWD4twJKdi5hg0irrh1zAJ3PYHa+FzK9oY8VmjaihX1FMMQImgup
 kkti69A/+uS4RF+AXt0BZOr7HvBWQ//9ROG1EYzBxqp8/52W93mN4ICIrLrAXss+gNEO
 X0uA==
X-Gm-Message-State: AOJu0Yw6SNJx2tA5nhaiOs6qZXvqCUUhlQI2BYRZys7KmYrLMdzNChcR
 SBz2fwagGWldBQyhYb0uxz5Qd0xlf4CP4uMiz/EEYXwlew1l4RWyjoqR5rpENF9SuqESSLteYRl
 6
X-Gm-Gg: ASbGnctt4/KOQZEJ7iqN2qORCYqsH5ruYwdW0tl98JPNX4KiHyZ0kS8RugzuhzujHF2
 7FoXsWf7hJspVcslYjVAw7nlq20jN1dRo7sHigYg7qaP6iTT6Ljczo+5GL888Hu2sdi/LHgVoia
 GPKQHzHHhLehNHt07Cdb5WS2n78r1vO7KPbiokXE8bzv6CblPbCZpgJ+VZ/0SbDzirCSYcQ2GEm
 ccn06bEZZVCdh2WctOJ1qg5UQfSab1IUWV3/6WozGcAVcFKEGYQMDbYqJjECFh0U831wu8KM5hy
 KwUgzOb1/Reu17Q=
X-Google-Smtp-Source: AGHT+IF0/RtdavXFvRGBNghQs5nXg9N98PajYSVQmPGZgS9nqWawVrg9Ikeil69k0PNzZFL4ZKIxng==
X-Received: by 2002:a17:90b:1c91:b0:2f5:63a:44f8 with SMTP id
 98e67ed59e1d1-2f728dc073emr20174529a91.8.1737138545595; 
 Fri, 17 Jan 2025 10:29:05 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 54/68] tcg/ppc: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Fri, 17 Jan 2025 10:24:42 -0800
Message-ID: <20250117182456.2077110-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
 tcg/ppc/tcg-target-has.h | 16 ++++++++++++++--
 tcg/ppc/tcg-target.c.inc | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index a6c7cdba5d..d087189a77 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -39,7 +39,7 @@
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -75,7 +75,7 @@
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -121,4 +121,16 @@
 #define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          0
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        return true;
+    }
+    return ofs == 0 && (len == 8 || len == 16);
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9205ac99e9..6e711cd53f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3430,13 +3430,41 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_extract_i32:
+        if (args[2] == 0 && args[3] <= 16) {
+            tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
+            break;
+        }
         tcg_out_rlw(s, RLWINM, args[0], args[1],
                     32 - args[2], 32 - args[3], 31);
         break;
     case INDEX_op_extract_i64:
+        if (args[2] == 0 && args[3] <= 16) {
+            tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
+            break;
+        }
         tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 64 - args[3]);
         break;
 
+    case INDEX_op_sextract_i64:
+        if (args[2] + args[3] == 32) {
+            if (args[2] == 0) {
+                tcg_out_ext32s(s, args[0], args[1]);
+            } else {
+                tcg_out_sari32(s, args[0], args[1], args[2]);
+            }
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_sextract_i32:
+        if (args[2] == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_I32, args[0], args[1]);
+        } else if (args[2] == 0 && args[3] == 16) {
+            tcg_out_ext16s(s, TCG_TYPE_I32, args[0], args[1]);
+        } else {
+            g_assert_not_reached();
+        }
+        break;
+
     case INDEX_op_movcond_i32:
         tcg_out_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1], args[2],
                         args[3], args[4], const_args[2]);
@@ -4160,6 +4188,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -4179,6 +4208,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.43.0


