Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A39C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZN-0001DW-Uc; Mon, 01 Jul 2024 12:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ7-0000io-Ou
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ3-0005Pz-An
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so22946035e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850054; x=1720454854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=akaP5CkcB85NRotBS27Sn9QbMl98HIBsHqiBEU5glnA=;
 b=tjK9qR4+zybpryZmgTMTeQG0UJknsN59KSJvUeXiB1snzApX1ZHnxJCp3NrVEXp5wS
 FVfgSmJD2NzXQR+qs3kK1PRdvqfZhsaho2pjmboV60ZWRhgKYZ+87B6uOl+QAdUqYMsg
 2Bam18Z8eAF1VIZiIjjYkvpbqgGZBSvxQuq3fB8YNvpvfAX8FE8W9GzSsuCZKM41v0Zf
 MK5IE6FxhZIWLmqRT0Ua59AE9wgKLv23Q8QEK0Jv2NugiAGSz10HNiIny6Oeh9pEhNmv
 5pSnE2l6zKhiXwia1Bc26EqL3zJNAUI3X7MfJQkOpIVbxqmapCGHUlwon+sOilOdy+kh
 wsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850054; x=1720454854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akaP5CkcB85NRotBS27Sn9QbMl98HIBsHqiBEU5glnA=;
 b=eq04IR2jaKjYfYKPevkflo9xo6uHVhEw+i5qKyj4H2wJkKSvIqzXLnBkxWmvL31mDE
 eBUdOA2juRa1v0fQlz/dZAOWHyyA+Otaf8hPRzFNMVyuSvAIeUWji5o4y71DZUwSd7iT
 uFW5dTvFwRx4+UA5mglNONhTB4fxmqPL91+CxOnzfET3nAsl9AMQ+teieL44HcqywsXc
 fw6eQXDKKHNtcBM4fUB/WA3SI1BmlpAemAj4voKOlbjpG7g4kNKeGKXxXsSbks5fH9Ih
 pEECXvgGDTpVrBNs4694FtGYjAsnl558wWMUI2jkQIrda51Z/AS159ukfdcLZ+afQ5Rj
 nQiQ==
X-Gm-Message-State: AOJu0YzSAnFR4Ug8Pw0xQdRLRoFckTR+v6EqMZDMeVZUq/GxSYruDqXV
 Nq0i43MjkDvDLt3sk07RVp0TKmbLJ10A0xiY4KLN7V6ZQeQOohOt6BDx9YsO+VL1AiKEtQr1jTi
 DsnA=
X-Google-Smtp-Source: AGHT+IFSdXp7IKjzKk5MY/9vIq3fCddNu+MVdBa5aUrXF8MYTd0B2rqT5BPJw1ffErC+mSq2/oB4/Q==
X-Received: by 2002:a05:600c:5cb:b0:424:a4c1:6ee7 with SMTP id
 5b1f17b1804b1-4257a010baamr39399315e9.18.1719850053972; 
 Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/29] target/arm: Fix SQDMULH (by element) with Q=0
Date: Mon,  1 Jul 2024 17:07:08 +0100
Message-Id: <20240701160729.1910763-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The inner loop, bounded by eltspersegment, must not be
larger than the outer loop, bounded by elements.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 7b34cc98afe..d477479bb19 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -317,10 +317,12 @@ void HELPER(neon_sqdmulh_idx_h)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+    intptr_t elements = opr_sz / 2;
+    intptr_t eltspersegment = MIN(16 / 2, elements);
 
-    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+    for (i = 0; i < elements; i += 16 / 2) {
         int16_t mm = m[i];
-        for (j = 0; j < 16 / 2; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, false, vq);
         }
     }
@@ -333,10 +335,12 @@ void HELPER(neon_sqrdmulh_idx_h)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+    intptr_t elements = opr_sz / 2;
+    intptr_t eltspersegment = MIN(16 / 2, elements);
 
-    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+    for (i = 0; i < elements; i += 16 / 2) {
         int16_t mm = m[i];
-        for (j = 0; j < 16 / 2; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, true, vq);
         }
     }
@@ -512,10 +516,12 @@ void HELPER(neon_sqdmulh_idx_s)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
 
-    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+    for (i = 0; i < elements; i += 16 / 4) {
         int32_t mm = m[i];
-        for (j = 0; j < 16 / 4; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, false, vq);
         }
     }
@@ -528,10 +534,12 @@ void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
 
-    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+    for (i = 0; i < elements; i += 16 / 4) {
         int32_t mm = m[i];
-        for (j = 0; j < 16 / 4; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, true, vq);
         }
     }
-- 
2.34.1


