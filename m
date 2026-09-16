Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6CBC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNe-0007Gi-GB; Wed, 16 Sep 2026 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNV-0006sa-Mp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:46 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNT-0001VK-MK
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:45 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccdd7695so393757fac.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564122; x=1790168922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0bnSsN9p+L6doKH+UU31+jNB0nqiEgr6lxmAGJ82QcY=;
 b=RKJvbZrpYw0QQHAKUzMubBHw66mDnuMM+O3Yf7fgRf+Ff+7HhCABCetTClA09uco9E
 wsZGrmXKEP/BGlrP29kxJQslCth8MOH/8FFZMB2N2K9d5y8Z6Z8ycxeld7Repzq5az8k
 Mz8kIw83YrsHMKsiEA2tP1IrXHzcaGVj+UFPpsLSe9y8GcGDnoqz533fwGadlDbKsEmd
 19eO4Bnx79T2HtVr24MNcViuep/EXZRoDXt2mS0Ve4aRtV32OYBdofRABoxojAxym12U
 eaqcRiOUZu6YT4FQA6c69lJyyjwTmfOmz8fmw1zlC1afqWxZ6Qn7QCYNJX9qu/IChRXq
 RNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564122; x=1790168922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0bnSsN9p+L6doKH+UU31+jNB0nqiEgr6lxmAGJ82QcY=;
 b=D0L15StSeKBMk87J1QrULJix8pW2/eomZDfMC7JVEwx967xkF67ko9zQ0OdHFYmdoK
 ONM3HLP7B2rSIM425r3mz38AohUVaNf7yC36zz80Z55IXzxMFqEP6DGpT/t3nL7GnMLe
 K4zg6SzT4ODFRuu6WbIURwo889XUH25v2dZnnQ2QMNI2y52ZEwk6ZGx3o7vN4RmQdA78
 fHD21c4JkPZV5QjcOpOgald5O+a/Q6CeJ/kAffYazh07CpYDNEGuzRfXLYDTrzUXMyGy
 1I7OVp1ptDjclVBXhTPf8q8qFpSu6S3DmZZFtPugvsci5URFa2xDG1GBqVH909O3bUFs
 s9qg==
X-Gm-Message-State: AFuF++nK/aA/xoWcSX5JW5STu4H/btSrkX+OE2VW0xwUruc3+k3OzPLV
 GUm83hC2uX91y0ZdHkGOOkxDbX9dAJbX2LGOuP5nMIXOzICd2f2DSR6zibd+5C7nvkQ9Y0xg1Cs
 M1Yea3Pk=
X-Gm-Gg: AYBFou2J77UFGdYZgMn+ypIIDkhe7+At7VfxYw/5/bGRV8uLUU8JLzHbOIUB4SYnHxc
 4yhQ2P4DYfGzdoxMc1JyAnyNaAZvQRZCrGJ1O2rbdz+pVg4ZGjB01VHn9Jh1YeCRb2HdF1H748W
 6jTNJB0Fjlfv7di1dOaqzrFOzZrQ36Sy4e8H/l6PpF1DjMMAVqB3NNU+r6B/RfIg6CXUyOr4JrP
 xiQdsBRKnvsPZHGQcoBM+/SzaQbqQmJbkT2efJwjfJqWrHG2QkkCAds8qpLbSm4SfM+4x5CQZQ/
 LeA2Zf6FoIfexLFgH5wZ+RHh/vXxFrejAsSsM/Jwp3E/X/M9hGp4WqUudm3ndfOwCtoauS/JL2D
 97rmsI17HUwfvtPJfLYNuGCqH/rznZ/ST/u7z0zZZqsAumDegu9SPjWLQiOu3tl/2mS5dysuDAI
 zrUziFK2116/qPwvUr2Zq9ArVxsxzzzaxJ6QM51/lDTX5oAoW2vhr7bFSyP5lMhvlK+dOgJEPDo
 yIKliw=
X-Received: by 2002:a4a:e910:0:b0:6b7:46e9:970c with SMTP id
 006d021491bc7-6c7d4af22d2mr2408741eaf.60.1789564122214; 
 Wed, 16 Sep 2026 06:08:42 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 69/92] tcg: Generic expansion of tcg_gen_ext16u_*
Date: Wed, 16 Sep 2026 03:03:44 -1000
Message-ID: <20260916130409.3382710-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8f4d1dd633c..3d01609810a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cb8436e3b39..dfad7288bb4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,6 +21,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
+DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3c4074d860c..1feb5352648 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -709,6 +709,11 @@ static void gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_sextract(type, dst, src, 0, 16);
 }
 
+static void gen_ext16u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_extract(type, dst, src, 0, 16);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1299,11 +1304,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 16);
-}
-
 /*
  * Internal helper for bit and byte reversal.
  * Given a repeating matched block of 1's and 0's, swap the bits within
@@ -1595,11 +1595,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 32);
-- 
2.53.0


