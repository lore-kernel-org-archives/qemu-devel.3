Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF44C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7a-0000go-0p; Sun, 09 Aug 2026 18:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7Y-0000g0-Gd
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:56 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7V-0007HO-NU
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:56 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso1140136b3a.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314952; x=1786919752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/Qxcz2btKv/Jlv8Q59q1Tcr9ftaoSWR1K6PGxnzQFs=;
 b=FrpagPtZyPAmIYCzK3OsaQn9WgiPuSqrKNJ0lk5S3LmV0y+V6E5pKrupV84SAuV0xP
 ewTnK7V8N/T1STx7kPqHztIluVVthMR48Av1ZGs1NMlMQmnxGsHgnnNHl/3KEINFkVXz
 t4bK1+EiPtLmVGvG4JZ5CqvyCapiS34T1ubgNuVyW+c1eNUSJ8j0sPlmOkI6kwkTV7cQ
 d10zS3LjUzEzByXO97sOVw1vQfx8aRnSIexQrFCjdjElWr5SKpAjGPat8gCKWKv2EcpR
 gkkB1CIIqObPS1d4SR/XZxzxb/ug8/piJROJhMb7hLS8m6Onmo5kcX3FDARyaQENzavc
 vG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314952; x=1786919752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/Qxcz2btKv/Jlv8Q59q1Tcr9ftaoSWR1K6PGxnzQFs=;
 b=Yv+UdS/bWR/Ip54J6KMRn3LZq4IDwIktzRQZuDXIIT5XcZHcOaHD/eZIHyoQBbWZjx
 BelIkWL/WWKovC3VPFAaeTQXheM02xGt8FXSmBE/iRr89m4k9bAHz6LHCPH9DGQbauaw
 kWSLGfphuwkleah88B6GQ1JgtGsU5b395WYJpjuflDvW8SgnngpokUO8U/9Vq6SXzD+V
 c4xPKo99KU9zyYaY1BdSMhp5P7gAlUjCAV7Bpd/9SCrKKmn7h7IqHdSAycEFa9TJV5bt
 hHYGPLJSsiwksFqAJZfCNtjqLhbAqXMkeSf6rMvrJa8xtNZunlOrfK1P1iIDHzqMqI+u
 wmSQ==
X-Gm-Message-State: AOJu0Yx+WxZlUC77SF74UZUGyNUeJBZ3ZG1bsnRz5yOXcIgxhb6tuXYZ
 f0it0tjuK+sUkHVVvtT/l9TCXqm9/WKe9IQ/PGvzEF36d4Jv+FEkMns+IK+S7gbM+nvdGkRIH9o
 dJSiZ
X-Gm-Gg: AR+sD11PU3MNlULl063b4SuJ7MlIczK8lyhZEi6EjXBZtrUTeDlSXftqgFhQdmazFIe
 DY+8nI6Q/ARIyozNANZSLBFEdDJ+nvcrPxwsfN0JNx7i1gvv68eF2crqXUQRKdUF7z95HJjqzy9
 dpil9ebdWM59i9sx5EWLNSTeCKzhqEaz9guoCUHdJx6rChm4/GYjtGG2ayt8y45GsHO9fGyA/Oj
 Ixi9P94PVvE0UG5OcGFVppbQ4uSq0MI5ei21D7qMNPj9RW1mwEAWEeQLysExJ3v/C+9L6cMEMmI
 JFR9OkgEd4oTIHDJsdvHnx/e4BzBRlfsTMhD3OYQTgf5/5s4hWe3H5JDa84ZRMDep/2cBg05rwx
 isK8+4qxYSippOhK6q8j4bdX41PWMGSg8Sujs5tDqlLC1SMU14s9xJXK8hf6CZ/sd93zKUR8Lht
 JRvPAC1XrIgf0q7klCI9KjXQeFv0VkVYuIOXwspJD9b+eKbmeP7B8JxBQPcaPrGFy6f6bvtBk/+
 LjDm/dGakBryL98fkAj
X-Received: by 2002:a05:6a00:2d0b:b0:848:4d1a:9554 with SMTP id
 d2e1a72fcca58-84f2e0ed972mr39534878b3a.38.1786314951828; 
 Sun, 09 Aug 2026 15:35:51 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:35:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 04/56] disas/riscv: Decode unsigned vector immediates as
 unsigned
Date: Sun,  9 Aug 2026 15:34:53 -0700
Message-ID: <20260809223545.730664-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
Message-Id: <20260703-b4-disas-xthead-fix-riscv-next-v4-4-84c566330bc7@linux.alibaba.com>
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
2.43.0


