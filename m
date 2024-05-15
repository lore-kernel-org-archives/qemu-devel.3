Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9576C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7G6F-0005H0-2w; Wed, 15 May 2024 10:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G68-0005EH-KH
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G5x-00079t-Iq
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-420180b58c3so23928165e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785144; x=1716389944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpiThysDuX7JPl+AhNyZ7t+FQuyygOMAjCR+jn6zrYU=;
 b=VAj7sfll52bIq08uflTWutQGWAiqZlQkktxno/BnZ8fC1s7YkFZdxhFFn1JtEnvMJj
 EMxcARCwNI0cWeRFm9HBLHAMaJJp6M4vxuaBTvB3RhybZ83WdyJJ9vGATafXryutSf2W
 vSDTGeRQMtlmbtiFPKlloCzvSI6vd+9VqE+qCodl5DLnBdvLsnYATl4cjOO0xbEVLwda
 wdZQ1ofUSVOFDVL6jQEDtlinYc3mefsmg4BT9pwXYAEs3fQ1znG5KRkHSf1f+VtiL+Q6
 v3XMNzL25XAgot88huNi6L2SljvBcgapf6qRhAfOxhnP4kL3YfN5hrixjGJvZx6sxE4g
 B1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785144; x=1716389944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpiThysDuX7JPl+AhNyZ7t+FQuyygOMAjCR+jn6zrYU=;
 b=ecOxnlQJgaLklF1C896yzADJEYfivOrayR5fMl/XtK7BmFg98DFTcH8c1TgP6BAi3Y
 vrE6jMtVAuRXVKySdlcrckYM/xurYNTNV3XZf5e1dl9GHQDHxYQj4TBhfCKfJYkdtSVh
 yNOYZIoB7lO8U3u/8YqU9WAo7Eibtk0iecM8iKYA7pgZeqbSngv113gT4lLDeYSmsV0j
 usMt91OZQFC3fgzz6bXTkRO+CEC9JvFC0BTgV2nmtU+KskqaQrwV4nayizv4njWgN0oO
 iuvb1y8pFXXRcSBJY6ePiQ9+v0HvQ3rU9ORf2UooVsSIDqcbDTvoZROXmGN0N4Wei/Wa
 kb4g==
X-Gm-Message-State: AOJu0Yy5TMg+TJ5UYQM2VpYbrF9bQ0YYNsx/CJ5opUaZD4mYg+hkTz1x
 IwKnVDiKr2qHqfoMm/zKRFz8vqgY92oUyzSrgJXVfufScII5NaXcRxa7rZDL1lR/XZSufq9DcBX
 VGM0=
X-Google-Smtp-Source: AGHT+IGqvmUqit2qg62rJGEPd1ZMWeFQqcenH6/C5+cB/ac3SfnVAkbzaf19auUuuujpwwdWzHA6Yg==
X-Received: by 2002:a05:600c:3544:b0:41a:b54a:9ad8 with SMTP id
 5b1f17b1804b1-41fea52e620mr118768115e9.0.1715785143901; 
 Wed, 15 May 2024 07:59:03 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88111033sm272134645e9.34.2024.05.15.07.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 07:59:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/5] tcg/arm: Support TCG_TARGET_HAS_tst_vec
Date: Wed, 15 May 2024 16:58:59 +0200
Message-Id: <20240515145900.252870-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515145900.252870-1-richard.henderson@linaro.org>
References: <20240515145900.252870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.c.inc | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 434a892e07..fb7261499b 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,7 +150,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
+#define TCG_TARGET_HAS_tst_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 6a04c73c76..3de5f50b62 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2740,17 +2740,33 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_cmp_vec:
         {
             TCGCond cond = args[3];
+            ARMInsn insn;
 
-            if (cond == TCG_COND_NE) {
+            switch (cond) {
+            case TCG_COND_NE:
                 if (const_args[2]) {
                     tcg_out_vreg3(s, INSN_VTST, q, vece, a0, a1, a1);
                 } else {
                     tcg_out_vreg3(s, INSN_VCEQ, q, vece, a0, a1, a2);
                     tcg_out_vreg2(s, INSN_VMVN, q, 0, a0, a0);
                 }
-            } else {
-                ARMInsn insn;
+                break;
 
+            case TCG_COND_TSTNE:
+            case TCG_COND_TSTEQ:
+                if (const_args[2]) {
+                    /* (x & 0) == 0 */
+                    tcg_out_dupi_vec(s, type, MO_8, a0,
+                                     -(cond == TCG_COND_TSTEQ));
+                    break;
+                }
+                tcg_out_vreg3(s, INSN_VTST, q, vece, a0, a1, a2);
+                if (cond == TCG_COND_TSTEQ) {
+                    tcg_out_vreg2(s, INSN_VMVN, q, 0, a0, a0);
+                }
+                break;
+
+            default:
                 if (const_args[2]) {
                     insn = vec_cmp0_insn[cond];
                     if (insn) {
@@ -2769,6 +2785,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     tcg_debug_assert(insn != 0);
                 }
                 tcg_out_vreg3(s, insn, q, vece, a0, a1, a2);
+                break;
             }
         }
         return;
-- 
2.34.1


