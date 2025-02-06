Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADC1C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80P-0007Hv-2c; Thu, 06 Feb 2025 14:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg806-00079S-Bw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:26 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg804-0000So-8A
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:25 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f40f2bafdso11961875ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871843; x=1739476643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuA0ciCWKNdG1BUB3drnqJmCT7zYMzgjdkDnlRwo890=;
 b=edTCUJHdXKoiQRUdAH+eAl4DE0k28RAawqW69B5NdON7IcYFUi5SEtSW/Vr6x/M4y/
 +iKfDC8yDUlnIFfW/WPFAQTOKunxdsVmtkiFNH/hE+7PYrtvUdQskesjo/Gh3Uu6SsoJ
 rcF4nUtkT58Afr0SOWN7h2WjgczGV5j/DugH4+bIk9B4mCjMMf0b1eiq5IXdVawTYk6d
 xyjPLjdD9aiTt4LYKa5Cf8dQNRwKs/SmY/97A6zbd70521blaQ1hnQN6Lzk5de6r8Glq
 1fM1rmRPTAxg7hoZiVySZs1781PusoTSocAI0uo4DqDj9pUWCP/2LxB34oGb3rVKBdED
 72tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871843; x=1739476643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuA0ciCWKNdG1BUB3drnqJmCT7zYMzgjdkDnlRwo890=;
 b=UQ6auUoOf5HGCZo/7OoecJbm7KYqA7NNNEz9IVj2Mv+f9/NqP/VHYMdBnsWYu26aFF
 29M4SutmE2EHSx427n0fm9KyVzPrwcsK1vSu6Y1QKrBserqoyB1WEWkrVdmcWsXdz90t
 ukRtwCRTUrsA8xVqbnPAB2SJN7vIm8RBJgSNKwJnBrv0GEWvO+XVPGeUzZMpoYykgl5I
 BRa8UKath9WLip3gHAFzoGRcFO3zOxfV0a1AeXeDw2X/acMN3wzxGZfqeirb9PMEro68
 4VD2g2JP3yGaG7KfJ2US7nN3N22J60moIR9K/DMBgt7cRYhUZU+ArcqOb+6y6uN+yuVB
 dBfQ==
X-Gm-Message-State: AOJu0YxvogvACHpGMaWzO69oQX6VPqMLLr3zFIhddlc5nBDwflghUO4G
 Ur1tYHEVcX3avJsjYsV/spuYr4tQV/anlWc1f1qxstUhpPnEVD4iyoQA2B+IUwCmF1OM7CGzAty
 3
X-Gm-Gg: ASbGnctmy+mMSfONOzSc66DA+GLdVwtVrq4IDjKdUSPCecTREF3ja3rLIabzUv44ld+
 KnyZcresTya0+sybIVXyIECBkeQ58eSSwjLiwaIpbX2Bw383SBXNRHRPeb2P+3Enb8rlqKwbRU2
 al185wKe/CcfV0LkcuHiRVw/lWeimdQpZ0j855cGNja2H8MojDVHuf875wXXJLKCz6MrMHDpaBV
 MrxoQs8ICyrQ2kNtW0zQ77nVhmLdP7Pu3Z1YqssWtVvEHGu7kecjuX96IqaUIZHcrOZzt1mWzKK
 WQWW8i8CQtLNQKxr7WgQFPmhwxWqBqxbDzSkxNN88NDCM5s=
X-Google-Smtp-Source: AGHT+IFdINsXhrdcY96P+dxResSxCfD7tM9Pln9dDyHs/Jk97YvTr7o31HSROw5SPYGDQS6IaQ6xVQ==
X-Received: by 2002:a05:6a00:368e:b0:725:cfa3:bc76 with SMTP id
 d2e1a72fcca58-7305d421aecmr1059146b3a.4.1738871842820; 
 Thu, 06 Feb 2025 11:57:22 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/61] tcg: Split out tcg_gen_gvec_{add,sub}_var
Date: Thu,  6 Feb 2025 11:56:22 -0800
Message-ID: <20250206195715.2150758-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 include/tcg/tcg-op-gvec-common.h |  9 +++++++++
 tcg/tcg-op-gvec.c                | 32 ++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index cabbe957c8..fbe5a68a7e 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -266,6 +266,15 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_add_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sub_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5e58b1cc75..d5fbd4e885 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1994,8 +1994,10 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static const TCGOpcode vecop_list_add[] = { INDEX_op_add_vec, 0 };
 
-void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_add_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fni8 = tcg_gen_vec_add8_i64,
@@ -2022,7 +2024,15 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+    tcg_gen_gvec_3_var(dbase, dofs, abase, aofs, bbase, bofs,
+                       oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_add_var(vece, tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                         oprsz, maxsz);
 }
 
 void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2175,8 +2185,10 @@ void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_sub_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          TCGv_ptr bbase, uint32_t bofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fni8 = tcg_gen_vec_sub8_i64,
@@ -2203,7 +2215,15 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+    tcg_gen_gvec_3_var(dbase, dofs, abase, aofs, bbase, bofs,
+                       oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_sub_var(vece, tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                         oprsz, maxsz);
 }
 
 static const TCGOpcode vecop_list_mul[] = { INDEX_op_mul_vec, 0 };
-- 
2.43.0


