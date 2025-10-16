Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ED9CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvy-0001Um-O8; Thu, 16 Oct 2025 08:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvS-0007uK-N0
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvI-0008L1-BX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso5131055e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617047; x=1761221847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rWLBQeCWwDm31QcWIDi89bNTwaZNrE4cp6KvZ+FPaoc=;
 b=dbB0P3jM8D5rOVvwLWF6wypM1CK6UcIgD201d+x4rZacjmw50kEBfwPF3BM0hX/H8z
 ql9oEOhdK1iKFOIUxR6d7iM+eC3CKhlc6t4dorE2/cgmOmWhf4IaE60AIRZbs2tlrVmI
 w8J5teT8qXtx3eVCNE+Gc2tEP8QfDMeO9zMyvcbdotQPIXjN2Y6NdKWTBayo1zPprPDV
 cIgnFr9WLgmpg2LvQXlLcycdcGCQoXsHFlhNhB2lRVXN3kbYFr95e4Du1cAYFN+EEw6T
 0mNOaZDMLeThxY1X8dscuap4HbpgEIco02ztVqu0Ald6UNK4w/BZ6nIkMPpDqY8VcDLJ
 iG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617047; x=1761221847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWLBQeCWwDm31QcWIDi89bNTwaZNrE4cp6KvZ+FPaoc=;
 b=khNY6a+QuguFB42QDTCVXAkvD1HyAGVxmzNkUlJip7KLv6jfutvzkpDmZtr9FoKR2Q
 KpTJsFiMetoG+/fy9cmeSDX2gM2oGb4hKGRGaCftATm7x3GexIKj5+fh91FRaoMiuS0e
 NwWN1nR97ArbrB4tlClp7ON70QME36Hc2kFK+1Snp1Sok7oqhv7OL6pSEVnRJ0q5j7o8
 Xz6WOHqeCRlLelRUBhY7wDYVhsDyg68muRgRITy/aVcQ/1MBcNzrYx5iEwa/jP8WLMb9
 EY664W7MWaEXhgR6BYVnFC6Pu8ygNXj24FsP8jNqwrT8/1AT6p1hGcLCf5jWhzeVz7Xp
 IKow==
X-Gm-Message-State: AOJu0YzOvCNqf9JziI1dv4J2pfiNibB0pdsv0cGYJB0zBSOOwCN1G3/9
 7fs/7OWnN7Axy7EZZV/i0ruCDJ8u4eJBg4sD8uKSHtaB7V2eSjmbJn2j28vRaz/IHU7IloVkXDP
 SVHXdg2M=
X-Gm-Gg: ASbGnctOD3BfVRvh7WuYkISx2hivihTpJZrnnok5A/UiLisx7k575WsnBoRJK+/MXC4
 nR5QV6jPSs+V3KOy6fq2GB06FpxhLS4rDT98C9ClZGfjvRMSHFLcEnwxDCY+3AWkgUz05I2ndxP
 p+r2lbTEtHEDDztCL1Ccj04uUB4glIkoCa3ALtBckAIOdvDDJ8sWtmPOR1XWngHlKTcYBVl9S2d
 fejC9J+zDgjyKMAygb8BpLsBV3KFpqfAQ1fQDN+BrVdDZMh/ViqX5Osa90CWaZNrixh++9ovMOX
 U9BVzW8b/gODsycsUmMdGV16HoysnLu9X83ZSJBzJejghl385/jxe6wjRTIZZt9nmEgsdEM0xfl
 j4B35uV3z4CeaFSxPXDYH6Er76wWVqpDzag/kf/bzZulEzR/Djgosdmf4jQxS6v6ADd28b1h62f
 HdY6ZaLz/2D50qppf7NWz4/r3o39VklyV44Wh7aMYRgzYC0Q6XM9qJwNfZ1qkDJm1m
X-Google-Smtp-Source: AGHT+IFLnlZP+rYRfQ8EGPYMQ8Y1YSDa9NlTVWoFROGjCQhQaQTDw76l5MpcfOgvOd576Ue3XM0doA==
X-Received: by 2002:a05:600c:628d:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-46fa9aa471cmr229923205e9.16.1760617046842; 
 Thu, 16 Oct 2025 05:17:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca4931csm22986485e9.0.2025.10.16.05.17.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/75] target/microblaze: Have compute_ldst_addr_type[ab]
 return TCGv_i32
Date: Thu, 16 Oct 2025 14:14:40 +0200
Message-ID: <20251016121532.14042-25-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Both compute_ldst_addr_typea() and compute_ldst_addr_typeb()
bodies use a TCGv_i32, so return the same type.

Suggested-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251015180115.97493-6-philmd@linaro.org>
---
 target/microblaze/translate.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 994e1d5cef0..1554b9e67b0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -604,7 +604,7 @@ static bool trans_wdic(DisasContext *dc, arg_wdic *a)
 DO_TYPEA(xor, false, tcg_gen_xor_i32)
 DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
-static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
+static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
     TCGv_i32 ret;
 
@@ -626,7 +626,7 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
     return ret;
 }
 
-static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
+static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
     TCGv_i32 ret;
 
@@ -750,13 +750,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
 static bool trans_lbu(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_lbur(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
 }
 
@@ -776,19 +776,19 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lhur(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
@@ -810,19 +810,19 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
@@ -844,16 +844,16 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
 
     /* lwx does not throw unaligned access errors, so force alignment */
-    tcg_gen_andi_tl(addr, addr, ~3);
+    tcg_gen_andi_i32(addr, addr, ~3);
 
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
                         mo_endian(dc) | MO_UL);
@@ -910,13 +910,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
 static bool trans_sb(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_sbr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
 }
 
@@ -936,19 +936,19 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_shr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
@@ -970,19 +970,19 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
@@ -1004,19 +1004,19 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     TCGLabel *swx_done = gen_new_label();
     TCGLabel *swx_fail = gen_new_label();
     TCGv_i32 tval;
 
     /* swx does not throw unaligned access errors, so force alignment */
-    tcg_gen_andi_tl(addr, addr, ~3);
+    tcg_gen_andi_i32(addr, addr, ~3);
 
     /*
      * Compare the address vs the one we used during lwx.
-- 
2.51.0


