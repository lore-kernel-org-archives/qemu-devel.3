Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4170FC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JY-0002j8-HX; Thu, 17 Sep 2026 04:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JM-0002gv-LB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:40 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JI-0001wM-QD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:39 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b4bff33ceaso278192eaf.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633055; x=1790237855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SeWdDHbVbllNkmMMSap4+CPhDBFxSy3XaIfEB9dyWNM=;
 b=SnpgQ8W4u6wm6cMfxdKluSj5wtxAETB34USIWgvT2qBbly/cbfWd79/U1HYvzO2JRk
 T94vZ94XojwUHbLVX/d/9ROtVjStUJS+admjzxhRR2ShN/Az0Ty/qeO+oizMTYBbpii6
 7vpUES7LJRSTqdBLeb7LBdg3q8JJKCxyR1si9sl4wkBoJ0gCrW5RA2Are8co3mNNf0WK
 l7eN5bYAZ4K/EUdnWfkoeRvv2mlv1BzrZNLrJ94qBKn8bRusiNZQZNjzqmVIJCl1oQK2
 NsZ4wmS/ntAR1QmcA6PHMaE3y4KDBX1VtHFJp0Ftl8psdHhzhH+kEC5sYsYSjpff7Sy7
 dbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633055; x=1790237855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SeWdDHbVbllNkmMMSap4+CPhDBFxSy3XaIfEB9dyWNM=;
 b=RvKNWwZEe8Yg9+IMS4mbifW0vwrCRPUleN/Ogp4qTWYs4D3LeKJve0r7lXt5orVlfu
 vJOhqMvQ+KlpP1seH8fLt1+zRBuvWUgml/btTLVmqUpeI5TbHYdF8Tlk/I0Ixl56sldr
 c7rUGx3VIAsFcZHA1pjP5T02EKuHLtmo8flsq+Cxigg1tsjAXP4prMhq1XreTjwRWxpC
 1FA7LyGysqF00QUSSQTSQ5Id4qxTU/06Ik91MFgdRdtK9IapWd11KJqPFsWVNS5GG/Fa
 dtISnbQZv9LaFjtzQ8oxmo/z3rt1Vmoc+knGGLvgWe8bRv9BVDU3cmaTzV9QNCLLrf6A
 ISfQ==
X-Gm-Message-State: AFuF++leTQ6os9JhDRr9Vm696qnRykHDhKZpubmvWwEma/EC6Vmv4XeR
 s8FURhevbWaWtvwsaw+6wC49O7PrFPqNFC3BVWU/73NZrRSOIhzwuiHIt61spbqaBvpaFvvbctc
 s7eeEI8M=
X-Gm-Gg: AYBFou0GVJ1FIXiVaPaZ7aCq1yANynYcB7vuBEpoZLImMaP90BAolgqC+5TM2k4G7U9
 IujqZKxtw8CVjFP3mcqIE0OJrv6LdbOz6BCnbY+iz6R/YEwg1bfFO4pk2Jhsf1DpN30SqySxMky
 lTxcPm8yEinEZL6d7L8ujjQQWJbnL98N17077vrB2iGr662OGuEk3wnEiux6MDWvnHYWgmDk9IK
 iPvjGA4MLeQQqSqP71eFjR35BUmpCHkRrHKMqff6qyjnw7Lb0y+SKOXAp7xBKGIncA7kHVLySsL
 gV78hBj2JeIIR7bXjCLIczUzzu6zdcns2CBTWwvY6PaIaHbeiA+qWddWIfJX/Y/r6mGWMZD7Ogs
 kAnkmSYNS3lnQfLN6VPju4F12FULS11suoRro3SIwQtXlLg4YAZbg82oh7gLFAl8hG4yo1iyHlQ
 pGntvguXCh/rKoUAcdm3JWEunayU71hM0FXSc4YjM770YzOJvRtfhL5GrFV/0SA4VJTLC8n9ff+
 Y6UB3bDSu7RtewtSw==
X-Received: by 2002:a05:6820:81d4:b0:6b9:6c3c:9492 with SMTP id
 006d021491bc7-6c7d47f704emr5526561eaf.64.1789633055524; 
 Thu, 17 Sep 2026 01:17:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 15/16] tcg/riscv64: Implement INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:15 -1000
Message-ID: <20260917081716.946668-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target-has.h | 12 ++++++++++--
 tcg/riscv64/tcg-target.c.inc | 16 +++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
index 93f8baad09f..3cdeb5c3900 100644
--- a/tcg/riscv64/tcg-target-has.h
+++ b/tcg/riscv64/tcg-target-has.h
@@ -69,7 +69,15 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_deposit_valid(type, ofs, len)  0
 
-#define TCG_TARGET_lea_sh_valid(type, sh)         0
-#define TCG_TARGET_lea_imm_valid(type, imm)       0
+/*
+ * The SH*ADD instructions only operate on full register width.
+ * To allow TCG_TYPE_I32, we'd need a subsequent extension,
+ * with the result no better than the separate shift+add insns.
+ */
+#define TCG_TARGET_lea_sh_valid(type, sh)         \
+    (cpuinfo & CPUINFO_ZBA &&                     \
+     (type) == TCG_TYPE_REG &&                    \
+     (sh) >= 1 && (sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)       ((imm) == 0)
 
 #endif
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index df4c4a9789b..ba7aab9246c 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -224,6 +224,7 @@ typedef enum {
 
     /* Zba: Bit manipulation extension, address generation */
     OPC_ADD_UW = 0x0800003b,
+    OPC_SHxADD = 0x20000033,  /* plus sh << 13 */
 
     /* Zbb: Bit manipulation extension, basic bit manipulation */
     OPC_ANDN   = 0x40007033,
@@ -2725,8 +2726,21 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out32(s, encode_r(OPC_SHxADD, a0, a2, a1) | (sh << 13));
+}
+
+static TCGConstraintSetIndex cset_zba_rrr(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBA ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zba_rrr,
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0


