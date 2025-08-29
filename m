Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26C8CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiM-0003ew-U8; Sat, 30 Aug 2025 11:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X0-00031F-Ex
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wy-0002u8-CP
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:14 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-771f90a45easo2233460b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506310; x=1757111110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DLQHYrFBBQgrJX6BSepayoYNYcVFTIA/ZVA/HIxSrQ=;
 b=cmjJC290+EYX8goDhAh7zsPEjaF8+UAv/fl5GlbdPcdcH8hHmE7jlFFT4sP79QCSJZ
 Oq3HuJ7EeW9O8AGWt2mZRyC9aITuMulnE0S8O2WtTAE3i6PXdTTVUVIzXZWKUxsye8Wa
 Cbagc79BnzWyTVXGCoOPLV1wG31zUCXnk3xdQ55//lMCDHrKt6aG3ChCo4hRoJVDO8+p
 n3NCBhf+f3ymGz0KAYLyalKm0Jcbq5xmrClru1rQNWwyHmlVEfQWIxmaiHqn8jhaAexa
 7dpZwulwg12blTOpJpibf6pGI7VBA1+FxNsCGSlmbOaPK989bn2MXGFsKB+cY4jJSirp
 qA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506310; x=1757111110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DLQHYrFBBQgrJX6BSepayoYNYcVFTIA/ZVA/HIxSrQ=;
 b=iFoK8zqfgBYKXociruZHnewv7TaaW9qT/FR5wXdO9CN4c/izX2hDYX4LDpaAyFW77v
 sxXDsRujKWYsg7k41UgTXZPYQfyvyKIRgR8w7TTDBUiZeI4pYF+BYMOET4En7QIMxgSK
 jPgOhb389eIJ1One8u78TDhPcADjPp/RjmnS7IfxUzSfO4cCmnl6G3hzh60EanGJQ9u3
 4FAluXwwyGtzl/6S5tBYZBNa75QP5P+e4DqJMMR+J/bNEkeRt4WBnL98oEuTWqatkkJt
 RRtpR+siYxPMtmRxH1UjAxrirHHTMj/PG4KZUDakfilT2p44o1H7t//aVjgEaEl5lUXr
 eHtg==
X-Gm-Message-State: AOJu0YzC5cLPDTL/XfThWdJGkruFSKarBWphSvxT1DuLp2V6tVydxZqJ
 CZLQiIIbJypCVSBc6/cY6hPKXwKJB0pJvj/qhfPdF3c2onhE5QisDiaeQ7uIF8DW1Jhsz3P3NaW
 E+eGnH0I=
X-Gm-Gg: ASbGnctB5CizsJfNLW3TXLk3yCYNp0OSHHsBCWLBHam4W98rf/8Jv0qqkPUSiOOrkXT
 8qUX6ViwjfjSSS3ZJAifVds0z041QVNA4hF9gAknDe3Bs7Mua7PasyLvmEPu+YRUCsT4/5ibvgb
 BM78vI3bfxcmwjLmDAS9btB15SnUIVAHtEEU3uj4flS0bDzd2TUf116nV9k4pHm5KL487FTRTsF
 NbdFHJjoHvtZ+lk9ibehWSvlKGzsC/GPuOdhA3OcbW3dF+4m2GVKLX6AqOIyL6cN6js9Rivb6Uv
 baV2VnmjzqiZe/a7kDkHoN57FRSCRcgfFrIrvMQloRSMdEGh6xQ4uRV2IVMDv6uRnkV1BKLtB4d
 Y95VUnoqsQ/F+DurqgVPqr95JGfD6yADIUSqVgLVYMaGg0hbzsvz3ehF63Wgb
X-Google-Smtp-Source: AGHT+IGLjX6318Vny1PtbO53PP0M/Q0WooP+7zs6JzXGRm9qpv9cKmoTBwnFBHehll2IOhIz96mmKA==
X-Received: by 2002:a05:6a00:b84:b0:772:1a18:b8d0 with SMTP id
 d2e1a72fcca58-7723e3d1d5bmr228459b3a.30.1756506309973; 
 Fri, 29 Aug 2025 15:25:09 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/91] linux-user/m68k: Convert target_elf_gregset_t to a struct
Date: Sat, 30 Aug 2025 08:23:11 +1000
Message-ID: <20250829222427.289668-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 46 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cc9140bf32..63376fa1d6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -720,30 +720,32 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
 {
-    (*regs)[0] = tswapreg(env->dregs[1]);
-    (*regs)[1] = tswapreg(env->dregs[2]);
-    (*regs)[2] = tswapreg(env->dregs[3]);
-    (*regs)[3] = tswapreg(env->dregs[4]);
-    (*regs)[4] = tswapreg(env->dregs[5]);
-    (*regs)[5] = tswapreg(env->dregs[6]);
-    (*regs)[6] = tswapreg(env->dregs[7]);
-    (*regs)[7] = tswapreg(env->aregs[0]);
-    (*regs)[8] = tswapreg(env->aregs[1]);
-    (*regs)[9] = tswapreg(env->aregs[2]);
-    (*regs)[10] = tswapreg(env->aregs[3]);
-    (*regs)[11] = tswapreg(env->aregs[4]);
-    (*regs)[12] = tswapreg(env->aregs[5]);
-    (*regs)[13] = tswapreg(env->aregs[6]);
-    (*regs)[14] = tswapreg(env->dregs[0]);
-    (*regs)[15] = tswapreg(env->aregs[7]);
-    (*regs)[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    (*regs)[17] = tswapreg(env->sr);
-    (*regs)[18] = tswapreg(env->pc);
-    (*regs)[19] = 0;  /* FIXME: regs->format | regs->vector */
+    r->regs[0] = tswapreg(env->dregs[1]);
+    r->regs[1] = tswapreg(env->dregs[2]);
+    r->regs[2] = tswapreg(env->dregs[3]);
+    r->regs[3] = tswapreg(env->dregs[4]);
+    r->regs[4] = tswapreg(env->dregs[5]);
+    r->regs[5] = tswapreg(env->dregs[6]);
+    r->regs[6] = tswapreg(env->dregs[7]);
+    r->regs[7] = tswapreg(env->aregs[0]);
+    r->regs[8] = tswapreg(env->aregs[1]);
+    r->regs[9] = tswapreg(env->aregs[2]);
+    r->regs[10] = tswapreg(env->aregs[3]);
+    r->regs[11] = tswapreg(env->aregs[4]);
+    r->regs[12] = tswapreg(env->aregs[5]);
+    r->regs[13] = tswapreg(env->aregs[6]);
+    r->regs[14] = tswapreg(env->dregs[0]);
+    r->regs[15] = tswapreg(env->aregs[7]);
+    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
+    r->regs[17] = tswapreg(env->sr);
+    r->regs[18] = tswapreg(env->pc);
+    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


