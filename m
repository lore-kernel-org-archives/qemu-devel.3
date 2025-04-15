Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAE8C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mKB-0000tI-AF; Tue, 15 Apr 2025 15:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mCy-0003HQ-JH
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:38 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mBx-0008P6-1s
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:35 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-524168b16d3so5113150e0c.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746207; x=1745351007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xnOKRkVYNjmbi4selFTGOFb0kWlEgpoJ/8u2eUimwZU=;
 b=Dk38dW4gI3EpYdQX/UD4mrk7mBN44F6YtCG2EhtXBw49hSjWEh2cM+vRy+JISPCRHT
 1bofD2xRhPnzr3lM1+kws4YuXoTuTX3/RVsUjN8OmnBPudQfPXvU41nRAftorzGhGY1h
 J/kKxOi7yjY/eslXQAQhGYf5u/wvsquZcHwMWI2mbwFWp5k4eoD46ODEOBJH/9v9NHO+
 T5DtDGzAyrHcKvfDCe95koP/PjwNory+GfYxxcHmmLxf78K7T95u5iG2EF/NJ7QY9idV
 7+dYl2wHePjPtZ+bW35p84c7BILYuLZuLl3xPHZiYxR8zV/2rxMRFm+wM4J+oB1Z6pOS
 mzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746207; x=1745351007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnOKRkVYNjmbi4selFTGOFb0kWlEgpoJ/8u2eUimwZU=;
 b=AJdL4IgpLopFzjY3yOVxLykRkr2ImJYllKixUtGxs4mwR6FLtKWjFJxhr/eGJ5UN/a
 gjwQC8gbXDR+OL6FiCRanEfxCvdBjeiL6gOeCQ6YhkCOTT8wyp2fmOQRsw3EpZRn6iW2
 c+hYzNVNl/JmmWPt3zHk0vQ237NcvUsDOfqvra/HereslN84Namse9MCNmTg67s3Wlu8
 QumRcfvMNoMvVgFLpV/7T1AqmksXaw7HYItLJ55qDVDvMOypCeM9S4SXEQAKm4fqbZCO
 wVTwve+6GAgNK4NmVlsPpLFsO9r+npScHIV1rWUFEHKB1Z0lJNMfQhxq52OMyfLnoKt8
 LcJg==
X-Gm-Message-State: AOJu0YwOYZNG9eXTLUjM02+bQTvYUYjwXEzSxICAtAZgPEncZPs2l3ob
 aCJGbF0Acc6I1Or8wD9GIueDUreYHiwKQjM0t1PiIKTIcF4ocBY94+tx4wXb3XBJ+WcT0VIGw1k
 s
X-Gm-Gg: ASbGncul7hwfbdrOoswGDAjytSspCNhNSkcKwgDZ8lv3uzj7AEQYYyOcagkz6iwVTR/
 kvJ6/ikmoLX8lcFSD4Wk0Jdj/W/tOxYlQuQcQQZLTuSAeeL0cyXyK7SjyYAMtV6snxqyloflMFy
 nWQa6FqlnhEQcIz7fNPEeatHvCQz9qpFKbKF+ttzRWyzyaj2FxwlJpMqahsvj3jxKVdD7yCVRbo
 Ex6RgVoSju7ErBAiiJe7TUar3chgmWoe5Llk7AqcU3xLlQMkt2MwCQV1/t6JzundVZA2EQO85Xk
 B0f3UdI1gsxJOFUI2j1Hd+D7HrsJwshD2J1jeLcMHy137VEHOmMPf7fw7nl/w0sticit/pQUxb4
 =
X-Google-Smtp-Source: AGHT+IFzLk9a4fWnf0Dq0XOf8qxzB+0czx7Kw71N4x8CvSPDEApkrxo0u2UfAJUSE1dtsejkbpfUIg==
X-Received: by 2002:a17:903:1b6e:b0:223:4d7e:e523 with SMTP id
 d9443c01a7336-22c31af4df7mr4728125ad.50.1744745763929; 
 Tue, 15 Apr 2025 12:36:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 128/163] target/ppc: Use tcg_gen_addcio_tl for ADD and SUBF
Date: Tue, 15 Apr 2025 12:24:39 -0700
Message-ID: <20250415192515.232910-129-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa29.google.com
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
 target/ppc/translate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a52cbc869a..e082d50977 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1745,11 +1745,10 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                 tcg_gen_mov_tl(ca32, ca);
             }
         } else {
-            TCGv zero = tcg_constant_tl(0);
             if (add_ca) {
-                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
-                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
+                tcg_gen_addcio_tl(t0, ca, arg1, arg2, ca);
             } else {
+                TCGv zero = tcg_constant_tl(0);
                 tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
             }
             gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, ca32, 0);
@@ -1948,11 +1947,9 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
                 tcg_gen_mov_tl(cpu_ca32, cpu_ca);
             }
         } else if (add_ca) {
-            TCGv zero, inv1 = tcg_temp_new();
+            TCGv inv1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
-            zero = tcg_constant_tl(0);
-            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
-            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+            tcg_gen_addcio_tl(t0, cpu_ca, arg2, inv1, cpu_ca);
             gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, cpu_ca32, 0);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
-- 
2.43.0


