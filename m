Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A24C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo7-0006pT-Ea; Wed, 12 Feb 2025 17:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKo2-0006nA-31
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:06 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKo0-0004TA-Cl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:05 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso573551a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397723; x=1740002523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmaajkaaAGIJ5jI2bE/DwNAq4pcqOQSPMALbdv9/6WI=;
 b=ccv+2o8QQWIfFgvjY94SXiexTUccnzk7GdmRmApH9SucsKkdi0djG2e9VczgDJDOUk
 epFBFoNPpm0WtrnDPETAk9Lsx5pGY8GtWUljWGimjS4SNNApUNo7bKc8vAY7mver9hT1
 m+5iDplbD17mJrO3LA7WVqWiGvKd4VripBy0lxl+W4R5ONB44LGfYrP8vaL/Bv5lAfwC
 M6vNdHPu/ZfU0v7AyiIpJHfuJyuNNo/B7JTMUePan8zG4qjq5fT/8WTTi4qJTjslQFaZ
 NwREd+gK1YcOyyamnVduhIF0vhYoGl1Y47iLN3979Xg53irXWSyOcIH/7QhEXZJCNET0
 x6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397723; x=1740002523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmaajkaaAGIJ5jI2bE/DwNAq4pcqOQSPMALbdv9/6WI=;
 b=BRa28MMiJbnesC+9lMhrpznwwkbsvWq2FjlZi0ZH99AHDT6wEVh3GuxypYFkVbb1DL
 EksIof/em3Wwi2/mn8DN6tb6iOYf4XsuZdjpmK2P+MmOLQilc0tkVANnMS++swWthmtv
 yNJlRpzh0LbLLcaIqYrFsvlO0YG6N2/Id54MsYfCSYoASAtJJyXMfvjGgVSiVqXMU6qe
 BdgcMbDaQq+2lOalbHLXdg2imR2Di6hvuUswTweJ0MkRVWPzXfpn9PFbDK6afMB6c3JM
 tGTdTL28eA96++0ddY4QiZMP2s97hxZaetL6c/QIIsPGKhmg65xOIItRGnk0otoLmqWl
 5eZQ==
X-Gm-Message-State: AOJu0YwkKYGFQEcCOP/Nx9JO0fh21VxvAhwN49xerHvjupqtYF81iPye
 /mXOttXmvn6+ZguWzoAxoiqrlUA3fh2e90L9tXoS45/8I+X586WdQvEWBh3rA18HKE2rrNsWPVB
 z
X-Gm-Gg: ASbGncsow6kdue2008z48IW9IVfHEiEGIpEWG6sPAHTWWyiEHASheR+bTqceaFYmB09
 grblZhlZ+IMmsdhW1wb839AUBkZ5uzlYOaRp8j2UUrpYO5L0B8pIr6h7SivHulVzf0yUl5F/VmV
 XxMzs5b3Xq3u8Zeanef33G3+cNCpLVGLCJ45En9VrFYUlBzoaqThtC0eqAJd2zASYI1P8czHA9t
 y/PwkSgRS/PPwKqyAJ48ohIGQUhOwg4an9XT5gDOf+Nj8dTszg+ESD20naI81UnHVLstVsWbRNn
 88rKSnQhV42aByhvDapNK2Krk6PfgbaYS/956bDlwqQ5fJQ=
X-Google-Smtp-Source: AGHT+IHqiZTa8l5XmYTQbepUTIeSsWxZ0UpC5KQcpDsbUHpfJYLZuZw9nPhyB9s5LkG/l70qn8OWWw==
X-Received: by 2002:a17:90b:1b0b:b0:2ee:cddd:2454 with SMTP id
 98e67ed59e1d1-2fc0e4b9e47mr1251934a91.15.1739397722792; 
 Wed, 12 Feb 2025 14:02:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:02:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 8/9] target/microblaze: Drop DisasContext.r0
Date: Wed, 12 Feb 2025 14:01:54 -0800
Message-ID: <20250212220155.1147144-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Return a constant 0 from reg_for_read, and a new
temporary from reg_for_write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a1d81b0166..5750c45dac 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -63,9 +63,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const MicroBlazeCPUConfig *cfg;
 
-    TCGv_i32 r0;
-    bool r0_set;
-
     /* Decoder.  */
     uint32_t ext_imm;
     unsigned int tb_flags;
@@ -179,14 +176,7 @@ static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
     if (likely(reg != 0)) {
         return cpu_R[reg];
     }
-    if (!dc->r0_set) {
-        if (dc->r0 == NULL) {
-            dc->r0 = tcg_temp_new_i32();
-        }
-        tcg_gen_movi_i32(dc->r0, 0);
-        dc->r0_set = true;
-    }
-    return dc->r0;
+    return tcg_constant_i32(0);
 }
 
 static TCGv_i32 reg_for_write(DisasContext *dc, int reg)
@@ -194,10 +184,7 @@ static TCGv_i32 reg_for_write(DisasContext *dc, int reg)
     if (likely(reg != 0)) {
         return cpu_R[reg];
     }
-    if (dc->r0 == NULL) {
-        dc->r0 = tcg_temp_new_i32();
-    }
-    return dc->r0;
+    return tcg_temp_new_i32();
 }
 
 static bool do_typea(DisasContext *dc, arg_typea *arg, bool side_effects,
@@ -1621,8 +1608,6 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->cfg = &cpu->cfg;
     dc->tb_flags = dc->base.tb->flags;
     dc->ext_imm = dc->base.tb->cs_base;
-    dc->r0 = NULL;
-    dc->r0_set = false;
     dc->mem_index = cpu_mmu_index(cs, false);
     dc->jmp_cond = dc->tb_flags & D_FLAG ? TCG_COND_ALWAYS : TCG_COND_NEVER;
     dc->jmp_dest = -1;
@@ -1660,11 +1645,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         trap_illegal(dc, true);
     }
 
-    if (dc->r0) {
-        dc->r0 = NULL;
-        dc->r0_set = false;
-    }
-
     /* Discard the imm global when its contents cannot be used. */
     if ((dc->tb_flags & ~dc->tb_flags_to_set) & IMM_FLAG) {
         tcg_gen_discard_i32(cpu_imm);
-- 
2.43.0


