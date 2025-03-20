Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F395C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEYs-0004Tt-QE; Thu, 20 Mar 2025 07:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvEYk-0004S3-N2; Thu, 20 Mar 2025 07:59:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvEYg-0000hu-FS; Thu, 20 Mar 2025 07:59:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso10683575ad.2; 
 Thu, 20 Mar 2025 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742471972; x=1743076772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qBGU2HPyZqGUmQfUxDXC8xQeLiBDHmvbNECnmom4caY=;
 b=S4JDoYbe4Mg83fFBQyhqK+K+XsvtUHUaCjBM5Fq41ekvwGEgnu/UWUGzY4TndCyc5M
 K0u5FizsP67a4BCF55fsS9v7uO0cS1tGgnTpD5Q3kEP59Qrnm9aBFL+5TIXsfWsdINs2
 bCseFYLgxv4LQhvyKL+aIGYw25U/DuJmOFaMtWFB0eeo1HZ1H/WP55tRwZtxJAe7WL7v
 0mn0rSH3LCxVSprlcKUa8YmAUVpjghv55Y7bx/Nr8Fvw87JlRYYB2gP1xwrcH0ppuzk6
 hqJqP7qCKugTVslgazM6BD0EeY2q2TAwXJAx28PICSCcBe6iemZcci8QlCEdJnevDXFp
 6JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742471972; x=1743076772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBGU2HPyZqGUmQfUxDXC8xQeLiBDHmvbNECnmom4caY=;
 b=QpEwbjtw67KavLfaBNJ5N6MWgRtDOr+gPBvl5IXWpY6i1lLHmD88L6K+umg0qefunG
 IYSP7AHNiIu7RYhWTcck4x9rk59XAtumgntbZKf3eWliRkL3K9QZsIF/KtEPjEVL39kk
 T8DkBpyFOsa9tx0yHS3BBUjK2DSN8uymhfeAPDtEzQBTDi5YX4xxvZum+seekFTT96kn
 DnXbpHlEZ4jw5X9dXeJhYwx6rC7zmJWlyH20bVVQ/kXLqRflrOT08spB5WNOu1Ir6qUJ
 2YRVoBOrZ7WQ5mHq9WjHHawZteoewdTJ6Ej+4pqhlI7/4VJ3zya8VRqN238qc/rZ65eF
 OgLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgGQ0fzVZzFQRL0EGI7lTUmM7pp4CdRUXowNS/Zia/fROiDWOw3NVg64+Mv6aEpbTMN0aPhBwk5Q==@nongnu.org
X-Gm-Message-State: AOJu0YxZvYhUwqAkwpkOuApguOkCnibBrhT8NaX6pt38cIMkGDQlJJAy
 AzI8LNMhfP6IZ4G3ofgaXRWQqXWLNuMOjDkdTEBPkCUUJhlZ1ONUMFsqkA==
X-Gm-Gg: ASbGncvFfJCKsSxnw3FStrLj1q7cJfhMyyZtBsDgcI/JLcZyOkwtvzpeDEMNY+MZuLT
 PdFfZOdP1nBJHGM96wuembg80FP1Rrqy9QoTRP+zuYrE5Jc2cs3bJLpngY4RiROnjZp1nZpudF9
 yTMfi/YYhyY0tE4jrAZ3Io2UOPPJMR4IefaAHlL0qjgcAlWjJdozE7Y2EEJ5MuZ3kTwSlVwkUfP
 0aPig5RnGkj8/IFfsj9CquTYD6YbDaEU1ES416eVznSaGW4UXGYfmVfw8LWlg1lL79O+lmOTnXt
 qtz1lFW5KYOVBmS0ecXK37N/+KWJ4taDTB87iD8fuKgBrWWzWw==
X-Google-Smtp-Source: AGHT+IFQlEuD9eyXjVfKxT/aEs6IU4TbzvUYC2W2w1SvEqOB61VS4U/LBKk/8mAf6lFrQ1RYxUU/Jw==
X-Received: by 2002:a17:902:d2ce:b0:224:3c6:7865 with SMTP id
 d9443c01a7336-2265ed8184cmr47332175ad.3.1742471971851; 
 Thu, 20 Mar 2025 04:59:31 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711551170sm13557473b3a.42.2025.03.20.04.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 04:59:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/ppc: Fix facility interrupt checks for VSX
Date: Thu, 20 Mar 2025 21:59:24 +1000
Message-ID: <20250320115924.107996-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Facility interrupt checks in general should come after the ISA version
check, because the facility interrupt and facility type themselves are
ISA dependent and should not appear on CPUs where the instruction does
not exist at all.

This resolves a QEMU crash booting NetBSD/macppc due to

  qemu: fatal: Raised an exception without defined vector 94

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2741
Cc: Chinmay Rath <rathc@linux.ibm.com>
Debugged-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: aa0f34ec3fc7 ("target/ppc: implement vrlq")
Fixes: 7419dc5b2b5b ("target/ppc: Move VSX vector storage access insns to decodetree.")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vmx-impl.c.inc |  2 +-
 target/ppc/translate/vsx-impl.c.inc | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 70d0ad2e71a..92d6e8c6032 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -994,8 +994,8 @@ static bool do_vector_rotl_quad(DisasContext *ctx, arg_VX *a, bool mask,
 {
     TCGv_i64 ah, al, vrb, n, t0, t1, zero = tcg_constant_i64(0);
 
-    REQUIRE_VECTOR(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA310);
+    REQUIRE_VECTOR(ctx);
 
     ah = tcg_temp_new_i64();
     al = tcg_temp_new_i64();
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index a869f30e863..00ad57c6282 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -61,8 +61,8 @@ static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
     TCGv EA;
     TCGv_i64 t0;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
@@ -80,8 +80,8 @@ static bool trans_LXVW4X(DisasContext *ctx, arg_LXVW4X *a)
     TCGv EA;
     TCGv_i64 xth, xtl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
@@ -113,12 +113,12 @@ static bool trans_LXVWSX(DisasContext *ctx, arg_LXVWSX *a)
     TCGv EA;
     TCGv_i32 data;
 
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     if (a->rt < 32) {
         REQUIRE_VSX(ctx);
     } else {
         REQUIRE_VECTOR(ctx);
     }
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
@@ -133,8 +133,8 @@ static bool trans_LXVDSX(DisasContext *ctx, arg_LXVDSX *a)
     TCGv EA;
     TCGv_i64 data;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
@@ -185,8 +185,8 @@ static bool trans_LXVH8X(DisasContext *ctx, arg_LXVH8X *a)
     TCGv EA;
     TCGv_i64 xth, xtl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     xth = tcg_temp_new_i64();
     xtl = tcg_temp_new_i64();
@@ -208,8 +208,8 @@ static bool trans_LXVB16X(DisasContext *ctx, arg_LXVB16X *a)
     TCGv EA;
     TCGv_i128 data;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
@@ -312,8 +312,8 @@ static bool trans_STXVD2X(DisasContext *ctx, arg_STXVD2X *a)
     TCGv EA;
     TCGv_i64 t0;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     t0 = tcg_temp_new_i64();
     gen_set_access_type(ctx, ACCESS_INT);
@@ -331,8 +331,8 @@ static bool trans_STXVW4X(DisasContext *ctx, arg_STXVW4X *a)
     TCGv EA;
     TCGv_i64 xsh, xsl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, VSX);
+    REQUIRE_VSX(ctx);
 
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
@@ -364,8 +364,8 @@ static bool trans_STXVH8X(DisasContext *ctx, arg_STXVH8X *a)
     TCGv EA;
     TCGv_i64 xsh, xsl;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     xsh = tcg_temp_new_i64();
     xsl = tcg_temp_new_i64();
@@ -394,8 +394,8 @@ static bool trans_STXVB16X(DisasContext *ctx, arg_STXVB16X *a)
     TCGv EA;
     TCGv_i128 data;
 
-    REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    REQUIRE_VSX(ctx);
 
     data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
-- 
2.47.1


