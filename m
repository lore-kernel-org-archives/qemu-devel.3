Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5B7C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5o-0006BO-Uj; Fri, 17 Jan 2025 13:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5j-0005UI-6F
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:11 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5g-0000HY-9E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:10 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so4238192a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138547; x=1737743347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNuOBt1JSPghM0keCROPJeDQ4NGjiUPvhG7aOaf94cA=;
 b=JntfwglDUCQzeVa8dpmwNya1AilOOl3pWz+YgxGZdiNQZsERzk4YHNLRYH1dgJTpF4
 HNuAXPu9fvWpbKW9ltsRJGKqQwekmYoaqv3VLld4GKyYhX08tAcQKY3pMoQ4nqs0Pcc6
 NIxKcqXmePTiOT81I88fwvOjIJEHz8fPdmaDN1pPxebRUO/gESjzp7UKtkdYbxCSi18q
 NWsAh79grHP4sgLQtfJ2lwXI6V69M27BKxHcK55JG7vJ7h+PWTwb90nNIMLp1/u1+yB8
 CYhKfmlkFPil81q6AY/VRvbTTeK5rHqbclrRfUj4eXgYmztL59XZtQEZLTuSa+G6B6c+
 WxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138547; x=1737743347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNuOBt1JSPghM0keCROPJeDQ4NGjiUPvhG7aOaf94cA=;
 b=NxdpHb7+LAGcZzGByxRVJ7Slcb5s/lnas6R8GAX7J2rrwNzadJnPwSmu3N9mh5jwmP
 HuJIilFUiCxjreb1TopEJxYdiX9cdBwuhVksziTJly2ydW54dFNyH0VUHO23TatuAfvb
 j4eqOvC+JsgRecLK978DPu3JnFlGUjZcP5VG383tE5DlJPmaogCxfi4B5Ylj5R09w9os
 46h9neCkIk1Ii3Nm2i+rolpewSLu1mGkUmZ90eEp07OIDqNNeRUkMcHtjrV6TxOwat4L
 C9CpSLBqJSVb39cD5YuXEvyZsM4X7uLpsKnw0jw+vvy58nb06OZw4K7dqcSV2UdjpkH3
 jpxA==
X-Gm-Message-State: AOJu0YypNk5R+crBMwLEz+XZ7FUC4eByFo+u2r35h29V4JHqJ4G0T/hC
 uxgF6JKgX/ZM4HAwOA3zysiSoHxM3mGE3CZiS6Rg1YKA2e14xxYkW8T3YBwn1rRjv+YAy6Z88Ly
 o
X-Gm-Gg: ASbGncvWMmpwsfOGyJOuCGP6QjnjyBWQ+e2n42ZiiMtYUe7l14epVEVOHH+Y6gqum8/
 botU5cUgsj8lnKN6yB9iwv/44z+lj+7+hYjY2wF7bARitAcovG+0jZ1p3um8cqTfVVyhw6WAgOK
 EqzapDFEEVH+F8DSL7fPKZQqDbufolD2NkvKAbtfkB5Pt2WB+LJhCYp1XhEkEbnzhJbLgKo2XBe
 njQxO5zWJE9SVuWciiKSqMAl6dOFapX1N/BoqRxlTYioomE/ipYYmwcm0nqa+XQzKR5LAIQ2T7z
 Vp3LJGgcu2z228s=
X-Google-Smtp-Source: AGHT+IFXmj2SY0pzZULMQ0mZ0Bu7DvGDMsrFMED13D2ttS9yaND8ffR4PtGKUqkUCcqDqOBVH0Oy5w==
X-Received: by 2002:a17:90b:2709:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-2f782cb58b8mr6020530a91.17.1737138546946; 
 Fri, 17 Jan 2025 10:29:06 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 56/68] tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
Date: Fri, 17 Jan 2025 10:24:44 -0800
Message-ID: <20250117182456.2077110-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Extracts which abut bit 32 may use 32-bit shifts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-has.h | 24 +++++++-----------------
 tcg/riscv/tcg-target.c.inc | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 5bf62c7c7f..e890546c3a 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -112,31 +112,21 @@
 static inline bool
 tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 {
-    if (ofs == 0) {
-        switch (len) {
-        case 16:
-            return cpuinfo & CPUINFO_ZBB;
-        case 32:
-            return (cpuinfo & CPUINFO_ZBA) && type == TCG_TYPE_I64;
-        }
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        /* ofs > 0 uses SRLIW; ofs == 0 uses add.uw. */
+        return ofs || (cpuinfo & CPUINFO_ZBA);
     }
-    return false;
+    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && len == 16;
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 {
-    if (ofs == 0) {
-        switch (len) {
-        case 8:
-        case 16:
-            return cpuinfo & CPUINFO_ZBB;
-        case 32:
-            return type == TCG_TYPE_I64;
-        }
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        return true;
     }
-    return false;
+    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && (len == 8 || len == 16);
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index fc93900c6d..4f6e18f59e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2344,8 +2344,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_extract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32u(s, a0, a1);
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32u(s, a0, a1);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
+            }
             break;
         }
         /* FALLTHRU */
@@ -2358,8 +2362,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_sextract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32s(s, a0, a1);
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32s(s, a0, a1);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2);
+            }
             break;
         }
         /* FALLTHRU */
-- 
2.43.0


