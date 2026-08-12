Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19BFC5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXk-00015y-I9; Wed, 12 Aug 2026 18:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXi-00012T-5r
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXg-0001ov-2H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38101f85591so379020a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574122; x=1787178922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oHmxQeSr/dTTNzFrqNQqSRdCV/mZHqBgLnLzZSztk8w=;
 b=KvQ36ox++yOEj9MEQGfD1WGphXjPXb0CgDpP/g3d5llPgdcHhZbTcvoIg2WFiEMtrn
 UXiEcmVnvOlsnG1cnMNtoVvV7JXrbYtl7PGvjLfwe9skzy6U4N8nBCl7bA8zjbcicL1g
 CU659Zx0KWRQZ2856mjXhKiugGFRwTbJmrbfYRcYMM9mRjUeQFP/bMQbS/XI3SfrFPLL
 +9bvR2jCjamBhyEbxZ+Yg7G+QtK3u7vumMmmj+weF/w2yl7Z7BVdg0KR6xoQS0YvqZ7g
 3zMucjAW+gySfO5jU9xrR7KJ9nH6j6EWJlCWZBDeH1xoXI0PmnYf01CYo42JN5grvxTr
 cB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574122; x=1787178922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oHmxQeSr/dTTNzFrqNQqSRdCV/mZHqBgLnLzZSztk8w=;
 b=Wcok/MRm5bSix65zzrL6GD2v8hgnLPZVW6SORMJmxn0K14HAxj/hJl3PqObHeVvoUH
 M871nUjuxXXAd12hjicUWrXvXS99SkJMTNM36+EMA3Z6O4Z8slR+Mi4dyJ6+0m7FeRF6
 YFNg24h+H6lk0jvNQhXKxUE+sABof5ZXMnb8apR74pl2aDJW96aR0PMb/Bjs+bJrm5Gc
 MRPb9r6yd7OsmfKL7wNkAz1vUITHWkyqLhRXizEZrnrMy1xub8hJakcmyIlhBaqnw0x4
 p44wdkBpT800otuTRt1QCBKG4yDkHPPnniGRfoAtPMHWAb94u0q4/Hfv+haSHMT04Rv2
 o41A==
X-Gm-Message-State: AOJu0YzPE7DQ6rxSlleUTchxw7aEPG4iqL46dDoKnuhVmSpK2d2xXaZj
 LKTULTxFLlRCvm7vvl45axKk80aemgDaEM+t2WdxBgkb4CAQviG0McA4HimwmIopby6p5TX/d9M
 E4xij
X-Gm-Gg: AR+sD12JPJxjyu7V6uzfj/COFCOHJjcD15cnUkxj6EdgrHKcus/AL4sbPw99g8NJ5qI
 mHJaExkiyLyYwsVql56J/1U/KrKkaxFvKZFiQdbN2kx/9XQHah3GRC+SWUcMSnfFPyXTl1miYMs
 +lLCIXvZhjzDOzFUk+QFHCJtqzQ2oFuvGaHjphB8VhYgD/iR7PTdY6E+0OEx7sOfLrElzzTgLZX
 Rfh0vPwC7aruu6IIRfDYepbeiLkHCCEpD0j8lWz0l+XUUXvFeSlYmyv9Y6cFE+iIr0at7vv06xl
 Pz/vqHpSgPu0fH+BcMaq/JpXxVaFrvfTpyH4gpJsQShPSOB5FYJ2osONP3MWk/ORk0jh6bBIKkq
 4Rsz1KcIHu//G4Hs+S26xnEREI0fWaNW5V6VwSbmBzEOBCUODElNHmDKxieszBAshxs8JcoDh73
 xI7iX94TpkM/mRycDvdw+xi+Z8dZEtCO8RJd1q/i49DnegwrClzb8eT7r1g7tluh6AktyJb+KAn
 N++mi4dGKkJfb53tujUY5IPrMVkHLA=
X-Received: by 2002:a17:90b:53ce:b0:38e:4f42:d0d6 with SMTP id
 98e67ed59e1d1-3931f9126e8mr399390a91.12.1786574122300; 
 Wed, 12 Aug 2026 15:35:22 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 41/52] disas/riscv: Split ventana_opcode_data
Date: Wed, 12 Aug 2026 15:31:31 -0700
Message-ID: <20260812223142.349142-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Move the table to riscv-xventana-op.c.inc and massage
the lines into OP() form.  Drop vt.illegal as unused.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv-xventana.c        | 21 ++++++---------------
 disas/riscv-xventana-op.c.inc |  2 ++
 2 files changed, 8 insertions(+), 15 deletions(-)
 create mode 100644 disas/riscv-xventana-op.c.inc

diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index a4e59312d0..5d2e07865f 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -8,35 +8,26 @@
 #include "disas/riscv.h"
 #include "disas/riscv-xventana.h"
 
-typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
-    ventana_op_vt_maskc = 1,
-    ventana_op_vt_maskcn = 2,
-} rv_ventana_op;
-
-static const rv_opcode_data ventana_opcode_data[] = {
-    { "vt.illegal", rv_codec_illegal, rv_fmt_none },
-    { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-};
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xventana-op.c.inc"
+#undef OP
 
 const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
         switch (((inst >> 2) & 0b11111)) {
         case 30:
             switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
-            case 6: op = ventana_op_vt_maskc; break;
-            case 7: op = ventana_op_vt_maskcn; break;
+            case 6: return &op_vt_maskc;
+            case 7: return &op_vt_maskcn;
             }
             break;
         }
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &ventana_opcode_data[op];
+    return NULL;
 }
diff --git a/disas/riscv-xventana-op.c.inc b/disas/riscv-xventana-op.c.inc
new file mode 100644
index 0000000000..0fe4666aee
--- /dev/null
+++ b/disas/riscv-xventana-op.c.inc
@@ -0,0 +1,2 @@
+OP(vt_maskc, "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(vt_maskcn, "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2)
-- 
2.43.0


