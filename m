Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67550C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtio-0008Aa-AY; Wed, 19 Aug 2026 23:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtim-00083d-Jc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:40 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtik-0003y9-R4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2437398a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197537; x=1787802337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dpctRoR5ytohYBbHmTxahKvAOMfFUypV6/ZUeeRK850=;
 b=hucIvgJf7rOpwzqQ3rWh6PcmHgncUKN8xJfIgl3H9BXH09cYc9Uj1OwFP+/UBwcgPx
 AidA0kiUD0xsUoGrfc0O+ORPmHunSMpfNH/ppn88Waz3sxDfGTowm7mCAlzEgDpdulwj
 z5u2fJdeF6h2fHMjBJbxMA+8dY2MuqZ2hfrDRKR0fbFl/F1ZwK2tB8jyvmQy2HLb5gHt
 gagi3jXafisWorPoieRCy8gViOP/ZC2gi2xmlaGpC/ZqUXyaXHwpBzSEhGgBxzxUQT3k
 FtQbqBGKdO84qFe1gNRo/GjP5SDhFYVF9I9pge0Hm1lHwvnGRYufTSVVVTN5deI+39kA
 PDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197537; x=1787802337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dpctRoR5ytohYBbHmTxahKvAOMfFUypV6/ZUeeRK850=;
 b=DJMOo/iLU8ThUU7AVxYd7etYFspaXEpOsqfi5iRwYWAH3Mn79CXyCkPuF4s95+22LW
 C+cszVadqOZh4Ki7sQ4TdCsZstZ5IcGp49wrq64N276DuZzCHe3ivBt8sW7fepPvjj1R
 3nEpy/Oi+5CRdCmC4Cc+VxBOki6JX7TigkGhm3F7s1ilA21PxDEJu9aKU1GL1pQZUYz2
 Dkt/EL/oam2QBJYJJAH+2FnBVfb/84ufh9hkt8rPiSvi6JvLBLhu4wHagaJdmT3Kaaqb
 Isa6Ow9wJ+GrzqL5eZiUQdMit917mnboW0rKw+18463cx7Q8lqTBc0sz1bUHADNUudiL
 3BuQ==
X-Gm-Message-State: AFuF++nU8yStiQLmwuNtkzgmXjQHAtgj5lYcWFnn2hKNlLw08NiSSNPG
 BWbSxaChjD26SBF2ULsLfGdbzXoLBs16rpXs7FqQHI8TNqHzQ4D/r4h1GYYvFA==
X-Gm-Gg: AR+sD11AqKAgtws6gnUnVHk56bHm76Q9OCp8UWce8+LvXrXQdHvJe8KeXF1dCacEpwH
 tMRL0v5BTCN2eOQrUpGDWSjARHQR8vEKrDcVnOuUWshfOC5zPz77vcH/kt2GE0ZiSmBKmjQ+iBg
 XAoBK65UtRKTT/OruGFsrV+Qt9BOlCHEqYPdgq3VRXgEGPCcYeNXSq1v0fL/VGyvst8nbKcnDeR
 JetM6XZhfdUmXxiIzWEXFPqQTPUh8RyJcWZdWE+0WwQgRmK4A9OOFQRnVSCaroUjmTurmUP8HFO
 BcsLuP6B5M78bjt83IXz+pl1iwt9epm8aFSw6tjscLtGX0su5EAZGdOz23Zp8+w2K+pwGosf7SM
 L5cV3klabIRtaIlFMjy5XE7Yw2L30U/RrxfrLyuLw2k80jGG2mt+QpO3eO5y6FMasKwjHaJ9Zqn
 tWSv1Xp4VXp5FkY/13pO8F2f+KUF4jLseT0hhWaiLHycD0mudkdtIzLPcMcV/KaKX8Sj2YxjB2X
 Nl13g==
X-Received: by 2002:a17:90b:2f8b:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-395810d73e6mr18328539a91.15.1787197537469; 
 Wed, 19 Aug 2026 20:45:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/93] target/riscv: Support raising misaligned exceptions for
 scalar loads/stores
Date: Thu, 20 Aug 2026 13:43:15 +1000
Message-ID: <20260820034430.1186695-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from scalar load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260810055618.1175500-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index e47b16a7fa..cc1b5dbbad 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
@@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
-- 
2.54.0


