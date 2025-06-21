Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E9C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z9-00058f-64; Sat, 21 Jun 2025 19:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z4-00056H-Ar
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z2-0004Ti-SG
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:54 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2371924b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549851; x=1751154651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PddwxWDB2j+zcRTwEZIk3BbnocBq9Wkl88ZErJ2pTF8=;
 b=KA6izelN8eB7Echn1SDxygi8cA4LbTtu6Q2iLUU3/HVSXcIzni86G//2ysCYBynfJj
 4ao4JhtNBgVwyWbe5Hg6kt6IdSUapEt/L6LvS9NBWC+gjq5c3VenyLsrr/o1P0hT51dt
 3zDHUKKf7pARMuwB80JfpU1XFlDdyzq6nx/M2P9XuYi2QdZwWyz5gyfPBfSQxW12+45q
 mnhhyXPjlNt1XmacdTB0mpsfOi00LyDD2MuvX8sO4UvvJbDAX2udhQsG8BrPDjtAZ/7a
 rVOwZBgZFI/lZ+eCXrHdgKJLlmf9p6JzUo9FkNT1FtmzdloFO0mkwAsbqwP2YPyQ83ve
 BAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549851; x=1751154651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PddwxWDB2j+zcRTwEZIk3BbnocBq9Wkl88ZErJ2pTF8=;
 b=oKsif7B9LbO4O6ijOdI/NGaK3Gv02Xdx/E5zBcy216a5BkE07H/A3BCW+OOgdElEq5
 oQbkASgt0ZW6Mwo+gWOhr1xjG1dj7+1qZHfYXaH3KE9v6814ClqOv3GrbVUEWUcrN8JB
 PkQCCsFqb4m2XgsY07t1pZcKpmxrTfctfM43anOHbyY51H/H2rGewB3RBnIuBEfpEgE+
 uUiN250/CW1PScenaBHabYA1yVUe9abAsGCXHP5LfroBdtAjZpvMOmGQ5uXJ3Mohz02P
 ZIWdJsfJZPIkeD3QiXVMEsfKdJtVTtOBCczbIWdDulKy7XszyM73b24gZUG0mR7gwY7K
 U/PQ==
X-Gm-Message-State: AOJu0YzIjHQcjgRZMq+JsP0iNvcbPoFVnhRrsIn3BGOGeqfOc2RsoBBn
 8zZn5uJ1byeNY6pn1ABWeZg05Vmrnw810rPE5TyLaYAnkz3Uz3gTAfLvuDGTcKprc5vXhzwkVV/
 gM7u9
X-Gm-Gg: ASbGncvA/qaGnabqpypTW5TVGabUFs0QRyIYPaeLXve7lkzzLlQF2mkqDol7u/JsqQY
 4inrO+DruFONZedTikUd0OvVMYR3xi5RGvUgVkg1MdAd9oSSol5CTHNtmV5vC9A3sFk6RG0Kw8j
 KiYIemHtTETRtupsiKnZU1S+5Ejlqu82sRvB2GuOOaAkiXUW0z0wLPr+wZ45gaHYinDbigIXDLU
 vN8MlPfAvbgArNmF80I7yHjdIvRqya4iKQpquijKKpfxtNsIxEcp32Mq8NF+3lsrT49D1hVMdwo
 DcXoAO6xi40bF7Kla+EkZZYj5uNBjL3+WuRzmY7LhLGV9+uV8wm2z+I9NRwRR3uM6MzS2SjQUmi
 HmYcS8cbnpyK8dqPYFNUp
X-Google-Smtp-Source: AGHT+IHOc+uFWexN1poZLnXREV3XjniNhhJpgFpY2ePsoC/Gr1gjiWIyF5D3xZlK9Gcn/Qj/TvRuKg==
X-Received: by 2002:a05:6a21:9986:b0:21d:fd1:9be with SMTP id
 adf61e73a8af0-22026e928a3mr10624174637.12.1750549851190; 
 Sat, 21 Jun 2025 16:50:51 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 019/101] target/arm: Implement SME2 LDR/STR ZT0
Date: Sat, 21 Jun 2025 16:49:15 -0700
Message-ID: <20250621235037.74091-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/arm/tcg/translate-sme.c | 12 ++++++++++++
 target/arm/tcg/sme.decode      |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 37f4d341f0..8b0a33e2ae 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -291,6 +291,18 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 TRANS_FEAT(LDR, aa64_sme, do_ldst_r, a, gen_sve_ldr)
 TRANS_FEAT(STR, aa64_sme, do_ldst_r, a, gen_sve_str)
 
+static bool do_ldst_zt0(DisasContext *s, arg_ldstzt0 *a, GenLdStR *fn)
+{
+    if (sme2_zt0_enabled_check(s)) {
+        fn(s, tcg_env, offsetof(CPUARMState, za_state.zt0),
+           sizeof_field(CPUARMState, za_state.zt0), a->rn, 0);
+    }
+    return true;
+}
+
+TRANS_FEAT(LDR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_ldr)
+TRANS_FEAT(STR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_str)
+
 static bool do_adda(DisasContext *s, arg_adda *a, MemOp esz,
                     gen_helper_gvec_4 *fn)
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index dd1f983941..cef49c3b29 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -55,6 +55,12 @@ LDST1           1110000 111     st:1 rm:5 v:1 .. pg:3 rn:5 0 za_imm:4  \
 LDR             1110000 100 0 000000 .. 000 ..... 0 ....        @ldstr
 STR             1110000 100 1 000000 .. 000 ..... 0 ....        @ldstr
 
+&ldstzt0        rn
+@ldstzt0        ....... ... . ...... .. ... rn:5  .....         &ldstzt0
+
+LDR_zt0         1110000 100 0 111111 00 000 ..... 00000         @ldstzt0
+STR_zt0         1110000 100 1 111111 00 000 ..... 00000         @ldstzt0
+
 ### SME Add Vector to Array
 
 &adda           zad zn pm pn
-- 
2.43.0


