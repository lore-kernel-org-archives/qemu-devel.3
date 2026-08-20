Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965B8C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtl7-0006DP-UP; Wed, 19 Aug 2026 23:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtl6-00064A-Jn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:04 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtl5-0004MC-2B
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:04 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so1646343a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197682; x=1787802482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QT+NqtS29Jb8B76mVXI/GmUgsUgPIu04DUnpKcaegjs=;
 b=CqgAp5mUb5lzOydlEJNd7QBtFNJrPXoJVnCr/kNENWptyFDnzbbwfAE2OkmqGAqQjb
 BDyx0x0MmgpstQFBOanWcyLJwjNRWo6QF2sfBaTUVABz5dA5aGcW48cPUjkhc5hwXzWL
 9VmZo/P4q0grylWKsZnMVRPLgMm7ZpMwZA2uR+E8dGKz1fkGiHfddo9duXQv66ItJyuA
 Bdjdm+jIW42ltxRlwr9G9s4cddk1x8EsmDE8CHXsBPXorfyyCxr3Lj/X/Llp0fDvon1U
 bDM5enb/t7oabOkHTGvZTl69O9IuUhN5rmXyYd/0Buka5B+gF9VHJN49iDnudouT7Yv/
 pF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197682; x=1787802482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QT+NqtS29Jb8B76mVXI/GmUgsUgPIu04DUnpKcaegjs=;
 b=WL4ZDj2Lp7cv8wrBJkUjXhoNpAreSM4CZ0lXjOE6pxXgqePa1uMn8/n1SCwkLWMkpK
 mifbajmi/FQtL8P1c+w+d0fbykORe1pvBI/0/8DWzffS78+ZGcaofW3faMqn7gwo8HKH
 1flAtiMCF4zyK+tWFzkqojuw7Pov4y80uE91J31gEY+DVdLxxI9SAX82KkqsGMsUlKnI
 OzdXvwbENpuPkAaLeUSwwyJe8zWqCE8hLn3vbvuk04h7e8AFm2hY8x/9A49+sPT3EAyp
 SEX900+PjeIOfQ5mjvOgWHWeecCXjqrhJRYHSAcGjmSg68y8BRWf+3w8DRJWzIMVR9uj
 96vA==
X-Gm-Message-State: AFuF++mMUDgjpD7YpDOti6vWLWv12gJQ4YH53JyXBG1OMyAwvNaD0ZJf
 w/OE38cwgh3GBxYiixZO2INanfNTuOloxPbiB7U0m2IgEQASrOB5X4XujzC0VA==
X-Gm-Gg: AR+sD13ro3QPhRuIDZn/5f8A/gOgT3EmJ1lQW8xbEnwyNP9tMWkFP5zlCd4PBXahwrY
 xPLogJMJzqDuDVj8DVCxJxnfQnkKCGCQdCNThr6JFRTsRL/59SQkwWJfOt3BrVc544vUZXIOkcy
 dlMriPpJveuih3ePZQiJMjACf7eO647k/LyPdcu2+qe14cqUCvJvaDVbfFKxVyUUpECahlPjMFh
 X2gf+U/8VFWy8fvRhU0z15T4+yf7xmmrH3Gcujf9T565ZdEGoHyJJXbWGbjQc+lHXzHLD6+SgIP
 G0XAerwAmzMrN96ZdCNcbEp1tZ/StMtvP7yyocVk/FaQqHep1RNMluxS75baOC0ifMxPDGWSHtd
 vEH+7/f73T7vwufoBn4viad7hXPnyeXKPe3Ku6th85WNC4U0F9s7kXXc3WPjYT3TyVWHmVRHs5f
 0xLESre27jqin5IxLh/40W5AVT03Qk3AMblGNUyVyPWLuH9/d8AQ/Gpiyb1wZL+qKTYFnnceSLW
 kGffaZEUwVzpmeW
X-Received: by 2002:a17:90b:1e4a:b0:37f:c97a:939f with SMTP id
 98e67ed59e1d1-39580ace5fcmr16860915a91.7.1787197681765; 
 Wed, 19 Aug 2026 20:48:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 69/93] disas/riscv: Simplify some insn decompressions
Date: Thu, 20 Aug 2026 13:44:06 +1000
Message-ID: <20260820034430.1186695-70-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Route "c.j" to "j" instead of "jal", etc.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-34-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index dedd925077..342e2db3cc 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1848,15 +1848,15 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
     { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
     { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
-    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_jal) },
-    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beq) },
-    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bne) },
+    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j) },
+    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz) },
+    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez) },
     { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli) },
     { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld) },
     { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) },
     { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw) },
-    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jalr) },
-    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_addi) },
+    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr) },
+    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv) },
     { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak) },
     { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr) },
     { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
-- 
2.54.0


