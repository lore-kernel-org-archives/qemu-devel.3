Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A477ECA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0liM-00012I-AA; Mon, 22 Sep 2025 14:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lg1-00057N-BT
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfP-00050J-B5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-269af38418aso50836415ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567212; x=1759172012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+vOWjqjVhjZBnSwWBDevzrEa0tx9HH7KqcxFqdDEmU=;
 b=uW6B2o/CM2+IaJLevJfESwJNpiXLH4j+jdbcAn/igTAgZaIClYYWl1MeL6h3F6NIOQ
 g2CX5T9OBpMrCRy6jdQr5L0wznXZ0YblRCTLDGDKnrgYvmxvgAWAe/KKinDcHkkPD0uz
 RS6K5ZflFGk94pmKDqki4ppOvsxy/GDj9elgnBysED0vxIjP9oLjSM8UQyTvS3J58Iy7
 takEQmp7kE5PfUu+Qg3teWG1dReTB2OQS/uIyfkCNWFerdssqsIPDaeqVI9lbdzVAFYW
 qsLAYOB50x95uRWe45tV0Fn8eWyjAYDT2inBKEbo11gQhIjGzm9dc5E7pvbDX3QSnuhe
 xYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567212; x=1759172012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+vOWjqjVhjZBnSwWBDevzrEa0tx9HH7KqcxFqdDEmU=;
 b=b7HYJ9+HYTbbz3tuxS633z1hwX3OyMgkzjWNeC+xoxP7hW1mDRoDJtafdBTa15ZAmy
 Fukk/3zyWpDnj6yOfq9TyOV68otPYsqze/S0gNImK1Zg+7DBKQf8fr4tcRQJGiKqY/LJ
 OhLi0rIJvVCLgUpW8bGkzUHWdwo0kLpELB4dJ2O5VRlOlAsxSC+BqRqePjOUSMBWkm+3
 dfSFw5L3ftD7L1k/fQspd+48rCiPukICFofpAxclWzIoKKYWw8EZsP0wJ9Hw9iuS5eno
 T50qKZfQxbGsGcPWpO2Sn7pb6/YTKTodEe2LR5vp4KSe+N//PtBViS7A/dE77lhqsR9s
 gFrw==
X-Gm-Message-State: AOJu0Yz5S7CsBtz3gV0bDeBJo9K4mgkWj9/QXe6AZ3VruPMtt0x3pwfg
 hIKvE0DIghypdaVxKAU33dPaRH9StIXd9jg7TexBM4eK/Pkv/gmSW7YUvs4vmAYcawfmz3nIij+
 fjtxi
X-Gm-Gg: ASbGnctK1otQpvG23uw25CQ0kYMO23Q4vLeqLjZ85FJWxGssFVu3GgEVbz1i8soHV+c
 VHx5xcMx4m7v1lFEJllQgUE2utc3UOI201tKU9RD30Q504xgItL46bGPvWS36QFMDOWLZWNToDC
 KKSrX9zcDIX8cBonlRaSGNP3xzWHsG1wKrTs4UsEdIfQldbB61DiVnnDPwrEhoiyx0TfZ/dnScS
 mqEhM1mrgUpkEe97kLrGFPbT4BGjfFsgnAf+CSkBlfgca2gKIbis0QTbbfKu3zPKacQ9OXB4K/r
 IsaOWrXGjKW2lSTZEnWuMg4F7/PR/mFRxbDyOjsvFP3DZazXMYQofJqLlb2F39uj4JNHlxQAH36
 l3J4rd5f/viFQNltFJDNAhQL16uAH
X-Google-Smtp-Source: AGHT+IGNEaenhRPjkiWefT5VawfX6fEyYedFzSnEHNie8boIk99AOG8zaI5Gu0fNV5rh/WxUwvDupQ==
X-Received: by 2002:a17:903:246:b0:269:a8a8:4029 with SMTP id
 d9443c01a7336-269ba3ea13bmr199516385ad.5.1758567211882; 
 Mon, 22 Sep 2025 11:53:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 60/76] target/arm: Add gcs record for BLR with PAuth
Date: Mon, 22 Sep 2025 11:49:08 -0700
Message-ID: <20250922184924.2754205-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 79fc7b8c3d..529c5bef0c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1842,21 +1842,21 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
 
 static bool trans_BLRAZ(DisasContext *s, arg_braz *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
-
     dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
     gen_a64_set_pc(s, dst);
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
@@ -1892,20 +1892,21 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
 
 static bool trans_BLRA(DisasContext *s, arg_bra *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
     dst = auth_branch_target(s, cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
     gen_a64_set_pc(s, dst);
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
-- 
2.43.0


