Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F84C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuw-0006P1-Bl; Sun, 16 Feb 2025 18:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntR-00032N-DL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:45 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntO-00065w-Jm
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:45 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220bff984a0so66527765ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747861; x=1740352661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GVClMtq+qpH9xhrl7s4WqRl6mw5bCbbA1nThQkkb/Jo=;
 b=NqTBDrYX0Qhh2U4wPQruh3T5slIu1gcuNcXgRP0tDXVdmjZWmUSX6SGxPiJWi4Q+te
 OYDkz2yVP+BZAsABIPox9ENj1Tf8RIdTKmkAfKobXgha2XU5VT8WSbSe/4UHDl7owemv
 npvvQq1Ima5AIkHfDFHtlO/7al5P+deN9zPzVgURS9nHSYs0oc6J5y1s8iNSyG4zmQ8G
 1UL86E4zKkpkXKfrsmm2JM2PWv1Bgoebc7WSJnz/upwHpcdwtWOeKQ836DLgHv8+epn2
 GU8Ey084udWVlc5cJJuKDXsF8AH0Xw4NaEUF1ZDoyp5DCzByFvyTWmRXI2IJWP6Cmh8E
 NsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747861; x=1740352661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVClMtq+qpH9xhrl7s4WqRl6mw5bCbbA1nThQkkb/Jo=;
 b=L5a1z0cTwi++oeHSJFDZqm+eTcxGC9lyABW1IwKGyZ4NhgiuUtFaa5X4jqZuhL1dk5
 yvDOXapagne94VHxiDVCOEtE6YcPfoNevowHms8+qOIoFK1J0dv5tKDZZ1fswZzhl8gg
 nRlqpHTHlFUuvwx3NyqSsQ+8MzsbRDPkasz8A+T1cm56XCfJhZD+XKzlDIeQrgr4vlt7
 YvQxf+ayNx2NXj7GO1F3755YzWudYADK6HUneYBXNgqt5vSiyO3A18ZExek7gcXHuUaf
 OtP1oGHg6Ku6NIwTV9jE/N0Z8mkgHl+5uekVOqLfcYWzYebe0+B9EENFDGSqwdu1SBeF
 3pgQ==
X-Gm-Message-State: AOJu0YyrVLd7oj9nX+tqivmsWuEPolxXEqSZLerPEh9uo29ebn/D4YRx
 PcYi6uQ0e9TjuV1XIzFDAzuynO2gPKahgzRw4fjBHIcbvOxT2JQ7B7GnCZdIghQqvK6D3dQI7KH
 R
X-Gm-Gg: ASbGncva6ohGZ8nCy7kt31pSVCVuIFLUo8GC0pilAoHrueAZ7oqnUKFszUSPHQNGBg8
 T5YvEsEqeEmRmuT4/PJ1HDAUb2GGgG/0XEtrxdugVsmJH4F0E0wPZxCzMOGXi+NN1YyNPs3k3At
 yiKt2RgpzG8VTKSQGylOJZT4s6YkFfqm+I06JXCwYa4W7Y+uRcpiuWElZblHm4u/zkWRK6kYh8D
 CNIB16fMG+OFF3/whwZUupvZzSIMik42z6Xh3JVS6gR9X0Yq/FEvmjwp/tn5p2L4ewGUt6IzuM+
 PbYBSkcUojyrPdpBiBRFR3bA24eg92PHj9TORgf31NMGorY=
X-Google-Smtp-Source: AGHT+IE38N3QsHL3aJriHDL8UFpIViNZqVnClPNTASULsF5hmJ8bbScIBC2+9ncu4dzWlzbKlm+6Xg==
X-Received: by 2002:a17:902:d502:b0:21f:859a:9eab with SMTP id
 d9443c01a7336-221040a9a34mr119575955ad.37.1739747861117; 
 Sun, 16 Feb 2025 15:17:41 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 116/162] tcg: Use add carry opcodes to expand add2
Date: Sun, 16 Feb 2025 15:09:25 -0800
Message-ID: <20250216231012.2808572-117-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 127338b994..f17ec658fb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1102,7 +1102,13 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-    if (TCG_TARGET_HAS_add2_i32) {
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
+        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+    } else if (TCG_TARGET_HAS_add2_i32) {
         tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2822,7 +2828,26 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-    if (TCG_TARGET_HAS_add2_i64) {
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+
+        if (TCG_TARGET_REG_BITS == 32) {
+            tcg_gen_op3_i32(INDEX_op_addco, TCGV_LOW(t0),
+                            TCGV_LOW(al), TCGV_LOW(bl));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(t0),
+                            TCGV_HIGH(al), TCGV_HIGH(bl));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(rh),
+                            TCGV_LOW(ah), TCGV_LOW(bh));
+            tcg_gen_op3_i32(INDEX_op_addci, TCGV_HIGH(rh),
+                            TCGV_HIGH(ah), TCGV_HIGH(bh));
+        } else {
+            tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
+            tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
+        }
+
+        tcg_gen_mov_i64(rl, t0);
+        tcg_temp_free_i64(t0);
+    } else if (TCG_TARGET_HAS_add2_i64) {
         tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.43.0


