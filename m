Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765D7C48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWotr-0001Qh-B9; Sun, 04 Feb 2024 21:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWotp-0001QJ-T9
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:39:57 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWoto-0003bK-E6
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:39:57 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d91397bd22so29770185ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 18:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707100795; x=1707705595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tm00fo32ukKBaFGSugm65eVz3+HZdTUwSvO4kdDzRYM=;
 b=dnjlwGAuCw6MFHlj7bBBzLz/3Ckclc7YQ1G/tImwDA+jQboB8h1Jz4mfc/AdalvsYu
 oXXNGDnbPUjUccFpYSGsGTQA777kFgB8K8JOhYoQnNpMeMy+qNtOdkLipadtCLoDfyhX
 I7KCVZdePTTcaAtFEQARFqo1CMMHFm9EPLe859OD21dKMgjmBdrfoHNej5gEqQdZOQNE
 FU1zH+4VCrfJ31G9SeqOld/MajdWxgaxMPDsoVyJxKqiYdH7f54GTpUbE1DHJDlkU1kt
 2gOQF+g0Pg7tv/fIqbelLqSSBxQj/eiAuwIzQp/a9wrM0wnyr31wgz7xf5Z65KiJ2Q+H
 OfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707100795; x=1707705595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tm00fo32ukKBaFGSugm65eVz3+HZdTUwSvO4kdDzRYM=;
 b=DWYyAtq/O9zmAuhPSwWzLrHng+XHKSU7IXXsr7RotQlIIr/zO/ytKXfBLwNXaAGSZB
 MODCQtkHHphha+Q+C1bQCbfnP6sFB8zB8PlvqEZwhANBXFne4RHLly3YvUoIjMpcF19F
 4/7DlpBdTZtUbphEEXYQeopfMISAVGpovHfmoSnLl/4zYYWRSTclQ/YOdwL8ESpTqJQ1
 go5QfIQ0tZfjCKIWdwS86jNRWLvn+iZLOHFy1MHNxS4IS42DmDCwCbao5QTp9KANaBJl
 eP+ZY00DniPKTL5hmMXoAba1sOaawfYtesCWQ2evXqJ2g6yytfudzYo1m+hkGx2WtFSZ
 Ge2w==
X-Gm-Message-State: AOJu0YxECvK5lZhBNCsPV6uoG0IVqVf8MfuR073cXPn4dAKMkfZyH+ij
 njFk5X61BjuTdrOtXFyYPoLlKJtp6KnPkFFmYPNLWOiQccIzWjqu6jWUSxh35hXKJNK6j6iOcLd
 HWU0=
X-Google-Smtp-Source: AGHT+IHV4J5QUtEZnJhOp8AMM1VP+ExoQsj8PK+Vshih00vTL8rX3XKYRudZqOqkyaiUuddxwrgFYg==
X-Received: by 2002:a17:902:db02:b0:1d9:bba8:16f1 with SMTP id
 m2-20020a170902db0200b001d9bba816f1mr1216216plx.50.1707100795156; 
 Sun, 04 Feb 2024 18:39:55 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 d20-20020a170903209400b001d98942d290sm3292130plc.124.2024.02.04.18.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 18:39:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 1/3] target/arm: Fix SVE/SME gross MTE suppression checks
Date: Mon,  5 Feb 2024 12:39:46 +1000
Message-Id: <20240205023948.25476-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205023948.25476-1-richard.henderson@linaro.org>
References: <20240205023948.25476-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The TBI and TCMA bits are located within mtedesc, not desc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c |  8 ++++----
 target/arm/tcg/sve_helper.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1ee2690ceb..904bfdac43 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -573,8 +573,8 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -750,8 +750,8 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bce4295d28..6853f58c19 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5800,8 +5800,8 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6156,8 +6156,8 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6410,8 +6410,8 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
-- 
2.34.1


