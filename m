Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE1FE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xg-00015V-TJ; Tue, 07 Jan 2025 03:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XH-0000Pm-U0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:02:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XF-00030p-80
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:58 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21634338cfdso1873655ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236915; x=1736841715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1bNfY/97XJ3h+VRN9JxDBynW7EJ1OysO0WoaVxBH6w=;
 b=ubo70EWIkw/5IvE5upz7cTPxFpDeflEG0y58aTdi1Grkdi2vPgaL0d7R1RxZbnyJp8
 y1m/X3GfzDxENrViqpN84Ir05mdW7FdyXQ2ned9C4ULiVZF7e4/rwPhL0DhP5GHK/kbi
 hILp7PK4JNRkpC97VbTjkP86DtOqhkGbgXzjQ0jcRcQWsUlUd1LnI81Lh9s4t1QxXuTZ
 DHse5Ef3zB/u/YR7tyRIY24mgprH5yZaLlliQGoOnc9F1HTwNc0I7E+nDvFmJ2Bjwii9
 3VfJ8+fe/LhYcA5Z/flYInVthqGZJKL7QGdir2oc5pCa4t4k8yD5sJ6WFDHvKTFF71vW
 0Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236915; x=1736841715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1bNfY/97XJ3h+VRN9JxDBynW7EJ1OysO0WoaVxBH6w=;
 b=O99oFcs1idVt7nX2qv5vSnwNml1PcULaersgtEGoD5K3uszY+VQQ9d5etnVicg+s29
 e8zcVxWtSK/jCPI/YyO0FnoCjvkUE/DFpE+4Z4kRXAsuszzy3EsldK4Htaa64z73aP5h
 vS5Jv6nllGBpt7jBlCUvs6G7pdKJYbza8+jkaJWa4eUN0f35WZJHJMLYiEkxiusDp5S/
 H6ZHHAJ+mWf/glaZ8RL9X3G0TYj40Ydh8tDW1Ob6AbswxBw7lYA0dc5N8JalsmXnSzQ6
 8TtMfz8QMzhXfDycZgALa+R/gaXzMh13KdfjYsooKzQaU4pBqIevdM56FcAA2fQbprxX
 0OcQ==
X-Gm-Message-State: AOJu0YxdEqaxTQjcG4VOav//z3dO6jFrJ7alWqvHshNmU87lWDqLS9Hk
 9vbNkYMoLj8n9N1UZg0yKgkpZ6Jd9t5wFIxZy5zUqqBkBDU07zbwNAtys0djQ0GCyrT7FETqiwe
 0
X-Gm-Gg: ASbGncsC8vp21nJwAHaFDpqe1CCjx/CLZjKdqL+sdydQEVX6NcOralTCikIFsCxk9DX
 3sBqgCwzeVUY2BoeAfdyFuRdyvHZbiIRZEYfQ5nZ4X67XEQ2eXbJoC+uRa+WjWoqZIavr1nxQMh
 HyUaSKpyHrORsRVokMq2b4DmXea+RIeEqnE1U2H8uf62bIQ+KBaDFYI6NyvS43WP5fbi+kVFbE5
 8dqJ803GF8VVWWL7HzBxxyX/4siCsVl5MJfOlWzEFnPMjCCwP/Y8KqmvmVwCgTV3Nenvs5sWbAB
 Fyj1mZDfFLeZa+KyvA==
X-Google-Smtp-Source: AGHT+IFf11p0Gs9KzKNl87iRtPcgV0OFCiCv7ohzonTIpfR7cQHRE7eVX+XfMKt/zS6aLzeTLD+yng==
X-Received: by 2002:a17:902:f54e:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-219e6ea1b6dmr842678445ad.13.1736236915279; 
 Tue, 07 Jan 2025 00:01:55 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 38/81] tcg/loongarch64: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Tue,  7 Jan 2025 00:00:29 -0800
Message-ID: <20250107080112.1175095-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Accept byte and word extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-has.h | 15 ++++++++++++--
 tcg/loongarch64/tcg-target.c.inc | 34 ++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index e4333c36c6..ac7d2fcdf9 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -17,7 +17,7 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -52,7 +52,7 @@
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -109,5 +109,16 @@
 #define TCG_TARGET_HAS_cmpsel_vec       0
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
 
 #endif
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 3dff29facb..cebe8dd354 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1375,10 +1375,38 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_extract_i32:
-        tcg_out_opc_bstrpick_w(s, a0, a1, a2, a2 + args[3] - 1);
+        if (a2 == 0 && args[3] <= 12) {
+            tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bstrpick_w(s, a0, a1, a2, a2 + args[3] - 1);
+        }
         break;
     case INDEX_op_extract_i64:
-        tcg_out_opc_bstrpick_d(s, a0, a1, a2, a2 + args[3] - 1);
+        if (a2 == 0 && args[3] <= 12) {
+            tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
+        } else {
+            tcg_out_opc_bstrpick_d(s, a0, a1, a2, a2 + args[3] - 1);
+        }
+        break;
+
+    case INDEX_op_sextract_i64:
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32s(s, a0, a1);
+            } else {
+                tcg_out_opc_srai_w(s, a0, a1, a2);
+            }
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_sextract_i32:
+        if (a2 == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
+        } else if (a2 == 0 && args[3] == 16) {
+            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
+        } else {
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_deposit_i32:
@@ -2243,6 +2271,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
-- 
2.43.0


