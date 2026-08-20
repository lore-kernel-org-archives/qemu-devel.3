Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE7C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjW-00014X-1A; Wed, 19 Aug 2026 23:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjU-000120-1k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:24 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjR-00043G-SK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:23 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc11a905ba5so1033954a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197580; x=1787802380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UxYkvzeEyEowcGzylLSarORZJmNgzBitvz+9ePz3P9w=;
 b=OlvaGRQN5BZGBpS+3eN5JvV27BsoniYGsBo/mQMTdlyTm2fAxevJ+y5WUIzpGeUCZM
 3KhqVH7c5CgEazD5Npt6UCC5mIaQcG95fnaYJ9RvzDg8UcJmXE/E1/ZRhlcQgj6cAKXm
 SzBgHzLAElE31FZBwQTnYoruaQym8pg0oX5TIBuUzkKB//dAYBT4cZqpmUdh33jHp6/V
 gXDhm+zKhEAuVUbMFQTdb5Xpkzb9ENYe+Qkm7PvA6uMPfA3VoatNawQk6ezIGlvGWxlC
 NFYSYE7U83wTXvMsP+kfQln+fNLUV7OOES9/M1INbr/BhIrVXHLHbWqbsDXK7lFrQR+y
 iqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197580; x=1787802380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UxYkvzeEyEowcGzylLSarORZJmNgzBitvz+9ePz3P9w=;
 b=Cupn2LKDTZY3UywDbOdO7GO1hyTRey/eHxizbcLyc/nWsykM7Slrfk8W4/QJpAgaV7
 Pqfmfjsgx2LhqxufwrTQu32TlxW8AlwZ+/L7xyXRcC0OxyIZQ40HMUa0mtqiAkhCxnQQ
 PdktuEWTf8/8V3MR3SxcSa+DYjL8w0armyK29HFwe8l8OfkCfpWhAPphqG18+XM61l3i
 Gq3laawpCx5xfN8ssj+Dw7AXtRLTjY7rDKk0Ryc2MwAqWm3MK+stk41JFmIdIJ5RLGbP
 JYXphjcw2WeE3hJywbQVOo27sGyKE2yUgcSnRTlaWRKA0lsM4oGC/+RElBfn3S632MZ9
 2bkA==
X-Gm-Message-State: AOJu0Yww/PVcC68KnPg5pQDIa0kmI9Jf2rKgVl7tQkkfNg8Wq978XP8G
 zJkgAQGOpelO+q47uK6OqEpQbzK0AXWdYawy7bcpGha7orRFZ9lSisEwkZeLUw==
X-Gm-Gg: AR+sD13mz134P6Z6QppRY3wT7KX9RR/wWNNMgGJkHpDYWqqpVxaZb+Wx+S9+z4Z1Hzb
 aaf1t9Q1jsH14Fj1GueGqT/5luP8JHDRWpfgcxEQVozC2e5/QB0FgpvGphNTev4QXQBTsBndVqo
 +NthLyqc2WmmEt8AdAZIswD+/hY4x9pDWpK0WQODtSyEcV6FJT7hqbQL5wTnLu5Vakn81PrcIKP
 lxe12qK20viaI4VBW7BGs6u3CS447Bwy8tNgOJ/y6+c9Un54kkiGekmR5F4wIE8JMvfPn7rqjCM
 To/VVABm/u1jCn8MgVCYfK+RBNdZtTrSBN3JWWpb7iP72qdJJzugJUcPw5osL7fktphQjnKH6Iu
 Xsgs37qqXk0SVgPDzykq01QU8emfkRFnjwRKt1byB48I3HQ0kO5qpHOiTzYzzZEqTCEu+YA1opO
 5mx5YpJfKAVmGtaBZdznS+jLhHpDegDNiwCS05A3CVTY26FmuC7DT7vayk2hW+kBidqC1jHpk/x
 X/iqgL5kf/bKewF
X-Received: by 2002:a05:6a21:394c:b0:3cb:c1f8:5722 with SMTP id
 adf61e73a8af0-3cd011c8420mr19443549637.10.1787197580220; 
 Wed, 19 Aug 2026 20:46:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/93] disas/riscv: Decode unsigned vector immediates as
 unsigned
Date: Thu, 20 Aug 2026 13:43:29 +1000
Message-ID: <20260820034430.1186695-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

rv_codec_v_i decodes all .vi operands with operand_vimm(), which
sign-extends bits 19:15. That matches spec operands named imm, but not the
.vi forms whose operand is uimm; uimm=31 is decoded as -1 and printed by
the shared 6-bit 'u' formatter as 63.

Add rv_codec_v_i_u/operand_vuimm() for the 5-bit uimm forms: vsll.vi,
vsrl.vi, vsra.vi, vnsrl.wi, vnsra.wi, vssrl.vi, vssra.vi, vnclipu.wi,
vnclip.wi, vslideup.vi, vslidedown.vi, vrgather.vi, vaeskf1.vi,
vaeskf2.vi, vsm3c.vi, vsm4k.vi and vwsll.vi. The remaining rv_codec_v_i
entries are the signed imm forms.

Fixes: 07f4964d1785 ("disas/riscv.c: rvv: Add disas support for vector instructions")
Fixes: 9d92f56d4a44 ("disas/riscv: Add support for vector crypto extensions")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-4-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  1 +
 disas/riscv.c | 45 ++++++++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 379e642ec8..91ada8b531 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -149,6 +149,7 @@ typedef enum {
     rv_codec_v_r,
     rv_codec_v_ldst,
     rv_codec_v_i,
+    rv_codec_v_i_u,
     rv_codec_vsetvli,
     rv_codec_vsetivli,
     rv_codec_vror_vi,
diff --git a/disas/riscv.c b/disas/riscv.c
index 967739bdbb..82b962dc71 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1803,19 +1803,19 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL, 0, 0, 0 },
     { "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vsrl.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vsra.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnsrl.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnsra.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL, 0, 0, 0 },
@@ -1909,16 +1909,16 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vssrl.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vssra.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnclipu.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnclip.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NULL, 0, 0, 0 },
     { "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
@@ -2048,15 +2048,15 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2, NULL, 0, 0, 0 },
     { "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1, NULL, 0, 0, 0 },
     { "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vslideup.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vslidedown.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vrgather.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
     { "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
@@ -2144,8 +2144,8 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
-    { "vaeskf1.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
-    { "vaeskf2.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
     { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
@@ -2169,14 +2169,14 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
     { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
     { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
-    { "vsm3c.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
     { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
-    { "vsm4k.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
     { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vwsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
@@ -4492,6 +4492,11 @@ static int32_t operand_vimm(rv_inst inst)
     return (int64_t)(inst << 44) >> 59;
 }
 
+static uint32_t operand_vuimm(rv_inst inst)
+{
+    return extract32(inst, 15, 5);
+}
+
 static uint32_t operand_vzimm11(rv_inst inst)
 {
     return (inst << 33) >> 53;
@@ -4895,6 +4900,12 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->imm = operand_vimm(inst);
         dec->vm = operand_vm(inst);
         break;
+    case rv_codec_v_i_u:
+        dec->rd = operand_rd(inst);
+        dec->rs2 = operand_rs2(inst);
+        dec->imm = operand_vuimm(inst);
+        dec->vm = operand_vm(inst);
+        break;
     case rv_codec_vror_vi:
         dec->rd = operand_rd(inst);
         dec->rs2 = operand_rs2(inst);
-- 
2.54.0


