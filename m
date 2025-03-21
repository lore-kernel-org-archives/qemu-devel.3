Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ACCC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVrH-0003R6-Ch; Fri, 21 Mar 2025 02:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoq-0008Us-QM; Fri, 21 Mar 2025 02:25:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoZ-000345-38; Fri, 21 Mar 2025 02:25:11 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso32598455ad.2; 
 Thu, 20 Mar 2025 23:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538302; x=1743143102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7DqV4tV/voUsRe6QWgdTDXfFT62jTytrnlFn7HzaIs=;
 b=C8y2CpyjqBCc1vvuKFXBsFD/PJ5ycJXIQ+Jvd2ED9VVM2h9KFphuQnplj+/ref+NyH
 Q2jTOc8f6PxeAswIsnhE8kFn0wUONOH+vvl23n41EZk8SCKhwMNYNRYvoxz+oWIVIdF3
 qGSgHW6N4DZ3I7BZS1IQoxQqQshVfUOMZriQkSkcq7lxtX8lGLpsrqapufZuPj79w+xD
 vcRYozV2/fZ7vCtEi4Z4+2bY1CEk4hCTyPDk6/91CN/MdLxxZGt9xBm8Udoh7s35wonr
 3wXQ1zhR0UW8rU5F8hpOvZ73C5KrDBIDjQJNs90ObBSA14juPuEgzfPYJvbUq0Cyi9je
 Z6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538302; x=1743143102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7DqV4tV/voUsRe6QWgdTDXfFT62jTytrnlFn7HzaIs=;
 b=wVWId6bao/ESWGD7R/flz0qTOnZvi8qvfsi7r5UGWCqJQbi/g9w69wDtGSetoT70Zp
 zqXp+5FGDZWlSi1bN/TMHQtJ4hI1MdVIRRa/CshFp2Io9y1VbUgGWckGV09msmvtgj43
 mQh+MMMxUdDn8MtFdlY9upWnz4Bd8ZjI7gLbnkwBUrQIgLg4KztSK4nfxsEe9Db+4Y4+
 sHiM/3/8qCwe700dM52p9hIQXVrR3ETO3StbVRuJB0Cr/Ur/rjS+Kvtw08ycmZH5cvt6
 XxKTe3ay6z1pokHZVFI+7X7yaUKXB2qlpLpbtZqXDGuFxMcTsypYnYBx3gkMgIGMcjZU
 /1SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwHpwyclcV9Gy72PBu5ZM+51uewVFjsylY/aUISRUvuLIjkdEM+PMRk1bA4iDg6ZW8UnbyRqtiD/OB7Xg=@nongnu.org,
 AJvYcCWWnogKuNA3ZGmzmz+pfNbNGUIQcJ96s4H8IS6qKWFx1HcAuIh+np73/7fGdyu7wdI3i8nJY5z2YQ==@nongnu.org
X-Gm-Message-State: AOJu0YxzZaU61zNFaL2rTI7dovVU+ET/HSWmCy8l8bZu+O8XmduMi3u5
 /tpSioNpEBQPZgSd7nliAHEUc0asR4Fp2VMpzd2wY5n24+x3S07xJF1euQ==
X-Gm-Gg: ASbGncuylApWYLE8VegbRsLy+mHUDFp2v5+KMfBiK4j26ZTu00cezIFMPfqg0jDBjqF
 V08bHcgBEoHjgqSb5CDJYcizCifIJ4ycNw9MjPqH6WXd4jyC+CL/NZrbdXIt07t15i7HVLK8Xiq
 l3FZ/Wr11SPPVBt9Mnz0xOAQ+L2LSIey4ywsUKT1lkBNUqiHISjQISpE+P8VfRwND7hdtEDPgc1
 3/Y8GoAqW9btrLSFM9qLTCLi4p0njee60hE2MsEa9CRPGF7Dtq8HWuKnyDIomZEyDX6fP9U0gs3
 H8682VK3c6WbWhvJpOUSsab5nQdoWNiBWzk/fcAsdC7wIlJC5g==
X-Google-Smtp-Source: AGHT+IGdLwwP+v4bVMmXG7zn9pCGOTBGiaziUN/j24uCJ5F1LwW29b5eEDovMAIy5qpW/j/J4JJiWQ==
X-Received: by 2002:a05:6a21:9214:b0:1f5:8e04:f186 with SMTP id
 adf61e73a8af0-1fe4347d987mr4155579637.35.1742538302414; 
 Thu, 20 Mar 2025 23:25:02 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:25:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/12] target/ppc: Fix facility interrupt checks for VSX
Date: Fri, 21 Mar 2025 16:24:15 +1000
Message-ID: <20250321062421.116129-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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
Cc: qemu-stable@nongnu.org
Debugged-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: aa0f34ec3fc7 ("target/ppc: implement vrlq")
Fixes: 7419dc5b2b5b ("target/ppc: Move VSX vector storage access insns to decodetree.")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vmx-impl.c.inc |  2 +-
 target/ppc/translate/vsx-impl.c.inc | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 70d0ad2e71..92d6e8c603 100644
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
index a869f30e86..00ad57c628 100644
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


