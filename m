Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856FBC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1fS-0005EA-0v; Thu, 06 Feb 2025 08:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fP-0005C2-9c
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fN-00088e-At
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so9793535e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847495; x=1739452295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8KqGQ9zIkCuNT2EkzNy15iA5VEmYGDpqhCWVedzzZA=;
 b=EshzQQPoPeg8YzMvPK1lpDDOjJ+VGHLSFevlqfRyOJZ6K8gq+FeC4Xotl5HVOdNVd+
 Bm3tC6WY4bq5Mu/uhJsc5i+JrHzQqjlCezLTO8YZuzxyZYNnkTeRx0Q4e0EEK0bC00fg
 FEX0VF6wsJ5r5RqSSvUuP61fiFyWK+BZP3GKUfGjXbGeZccORfJoNbyH1TjsLHf5j+WU
 1DfDjlWGxZh14SLFpD91L3iS545BHMV7Fz8JwZYk8ZbN0aF6fkC3GJujojGM6rTpSfGI
 ts3ZMRYBanj5UqazvhR/s7g+rz9qcuInhpl2y14fyr5TpQQnharurFBi4PqLOnHXc4aX
 vPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847495; x=1739452295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8KqGQ9zIkCuNT2EkzNy15iA5VEmYGDpqhCWVedzzZA=;
 b=rdARv1NO4Y10J4DYxiZepap0EY7IjiWOAvHJQUI//p5SZ6av0qaJtoVgKO0XmwJNpT
 q38iRD37KM8DRoaMFReslgBV7ic1PSgqi52iOULEI1u+zKenQDOaVC9CrjwOey7Rt0JP
 VNtJM9RtV5BTmr4r8zJex6AAtypIG9mQXxJtiymelnlE1Gj4BECkJ3Ui5Hv7Xovy9RJz
 bGi5QmwG64gO66yi90Jg3inCj9oimi2tpDia9VC31jfAS3Tt9Odwdxd2rjFmnN24aLIo
 c81eOzprmqkpRZHfvCfWBOvXW2pfOBoblpgs5GSHQAi+fPPKc8nIcJo7CeN8V+GkMooB
 Disg==
X-Gm-Message-State: AOJu0YxZMDDMOPnByOaDaXXJu7n+AhTG9RaSruPj/HbUBuG4CYZbxZiC
 SERgTYTVLqy4VrkGWx+jFR2bcn9BwbBMMPVsndJFUnPSr0UyILUsAggJsy4qn3ZH19T/1mZE2pE
 ui/8=
X-Gm-Gg: ASbGnctBXcSmeBfrZasd/1ODawcOpfsbFvZNPAHn47QOFuuLf2Tx8Aj/4fynfKDp+mu
 63USE3j871Oir9ueHhpeUbetbE6twYrPhXbw3CCO/3iT3ymSRtb+w2SpAFi4Db/hQ+i5qM0H8JI
 DYqs3rlgslK4GvbV2FROi4OpoWm9HvolSMUpX29APxaM1OzKk6cGdS27wqOv29nWOm+korj7b+A
 NFthlK7I4cdxWeYbifQ7p5cVpbnfSQYgCoO58BXLk6+nmL+Os74SDGu1Ux6TbCigL9J7mqUGoD4
 T9wQ7furAEF/9m3rHMv1s4B5OMZ2pI20zJpsoYhd528XseP1iC3hPK+rWlq9SGeyIw==
X-Google-Smtp-Source: AGHT+IEV1USrRzwvVIpMUR6OsIWmCALx70YRgTDv39hZsHmcmipnLEn8n1uFhKs7oHe8Mn8UWIGf0A==
X-Received: by 2002:a05:600c:83ca:b0:434:f218:e1a8 with SMTP id
 5b1f17b1804b1-439133fe7abmr21066925e9.19.1738847495448; 
 Thu, 06 Feb 2025 05:11:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dcb0eacsm18832295e9.23.2025.02.06.05.11.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 08/16] target/microblaze: Set MO_TE once in do_load() /
 do_store()
Date: Thu,  6 Feb 2025 14:10:44 +0100
Message-ID: <20250206131052.30207-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

All callers of do_load() / do_store() set MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 86efabb83b5..0d51b2c468c 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -713,6 +713,8 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
+    mop |= MO_TE;
+
     /*
      * When doing reverse accesses we need to do two things.
      *
@@ -780,13 +782,13 @@ static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lhur(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
 static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
@@ -798,26 +800,26 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, false);
+    return do_load(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, true);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
 static bool trans_lwea(DisasContext *dc, arg_typea *arg)
@@ -829,14 +831,14 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, false);
+    return do_load(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
@@ -863,6 +865,8 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
+    mop |= MO_TE;
+
     /*
      * When doing reverse accesses we need to do two things.
      *
@@ -930,13 +934,13 @@ static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_shr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
 static bool trans_shea(DisasContext *dc, arg_typea *arg)
@@ -948,26 +952,26 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, false);
+    return do_store(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swr(DisasContext *dc, arg_typea *arg)
 {
     TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, true);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
 static bool trans_swea(DisasContext *dc, arg_typea *arg)
@@ -979,14 +983,14 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
     return true;
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, false);
+    return do_store(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
 #endif
 }
 
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
 {
     TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, false);
+    return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
-- 
2.47.1


