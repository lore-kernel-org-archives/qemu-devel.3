Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC24C5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcT-0001s3-5m; Mon, 24 Aug 2026 01:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcS-0001gr-4O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:16 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcQ-0003J1-C0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:15 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-395ea741d07so1004890a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550793; x=1788155593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6F951Dj73cRUnbMDFWDOvChFepiHGGhTEiS7TDO+nT4=;
 b=EW9yEp9HVh6uXFsMYSxYyssx7eEfgEZffY+drtWPLsfU/SGlBREOLOjxT9UqwasiMX
 3AgONexRvOFCOBCGAc1el+Y0F5B1Rb/PbQDA0xgl3SE6ZCjcGBL7EfPxHxahGNCvmnGR
 SAA67S8jXm3qtJf0ZlJri0eS5fdnxKdWJYEoSAxwy3C6WeyiCxh2jxxW0P2KnW41Tc0h
 8a9yrh8+1NnKEB7GAQmUYD8gpm9btqEqOVkGR5q1lmOzGHDC093JNnQJAs6ecY9XNaxE
 1+hgGXhb5eof8qo2gUBhpEdHasl2r4ezQzQHTezmrrf5GB3oQNqLpXOT3rrEiTDlv2Uy
 lqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550793; x=1788155593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6F951Dj73cRUnbMDFWDOvChFepiHGGhTEiS7TDO+nT4=;
 b=Ef0U0dhYjEiTzoeThs+P6IDsTCbKH287pq3gviy+kguFHuU8mwRJnYyMTfQnxdDP6f
 VyCCBGgZX1ummW75YYsPfhioZlJDdgu15Y6FAhZh2GC5/O5wul3iFXcEmvdNkt8z43Ml
 CBnbmjq7vXUYHW9veujlHeQxK0pZF8pkzgbZSpWNeydxlfOJoXmCeUQmc4FRDslD2Qyh
 qQayFS0THSfINtBHxwb+g7vquqXhkixv39P3SZQ9gdwanBqclCUk3XX4Rw2zsqLpET/9
 AUD226FM7YPUDnMquQkQ90W9fmFkuHeZpzmNicRkIcD/KkiNVI4MpENMMDSLd1JtXWn1
 oydQ==
X-Gm-Message-State: AFuF++nRFhiNnyKlccA7uUMjE2w78YKwCxgJk8HCw/mr2Lw/CRaI0+fx
 fLkBppFGCu0BDlMr066A2EDvg8kwtdx4XtIefhiL4FXJzPN8gIY03EKCKPzjhQ==
X-Gm-Gg: AR+sD127crPUsQwOOswC9Tm9zDXiDww2mfE55d2aZJamSMLTlhO+bj1+yyTlDd/YsaN
 BHZG12SNkj2vKcxydq1pRS18Z1+GJ0Y193q4kfxzTjH4qsMwkpt9fMB4IcAbwjdICJhwWgavhiY
 PE8BynDEGkg54bLt8JCteitHKepIw4Qr0GhygTWZVecekVS3z3qd2Af8YDp0HCNblBEn/Z6+vPH
 0QqQYfmi1RT5zNyq2N6VGM7+ingeZaSl83ZJKV9e3vCNIVAIT32F02Nbf6eb69JWrWnsbp0ZXgV
 ieZeRubhVsqWg3waQsWP31goEzyF95wpjz0MK8ANnb90spMGgLPx6WwYZsDpTL3mPfGDFsjbEqU
 Zdcnv3B248RmYAPqhMD1vq8GYoOnx4hx6FBvych+WTKvj0MeXGq5bGgCeTko6MFL07YLjVeRZoq
 0Cb0wgA99sE9AjyT2NS8h8v/LwkXP6ZTpbxrFzmK4+dk3sk7PrBHWm8J+xMVH0/3rEk9MLwERh5
 yDnCpZJQAMtmpFM
X-Received: by 2002:a17:90b:53d0:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-395c359a74bmr42157484a91.12.1787550792991; 
 Sun, 23 Aug 2026 22:53:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:53:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xu Liu <liuxu@nucleisys.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 95/96] target/riscv: Make Zcmt JVT loads endian-aware
Date: Mon, 24 Aug 2026 15:48:05 +1000
Message-ID: <20260824054806.2790041-96-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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

From: Xu Liu <liuxu@nucleisys.com>

The Zcmt specification says JVT table entries follow the current data
endianness. Support that behavior as described by the specification so
big-endian guests can use JVT tables stored in big-endian form.

Signed-off-by: Xu Liu <liuxu@nucleisys.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <02050B1BBB8815BE+20260817083005.2392-1-liuxu@nucleisys.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/zce_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/zce_helper.c b/target/riscv/tcg/zce_helper.c
index 15bf0a99c8..c6ba4c1a47 100644
--- a/target/riscv/tcg/zce_helper.c
+++ b/target/riscv/tcg/zce_helper.c
@@ -18,12 +18,14 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 
 target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
 {
     unsigned mmu_index = cpu_mmu_index(env_cpu(env), true);
+    MemOp endian = mo_endian_env(env);
     MemOpIdx oi;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -45,11 +47,11 @@ target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
     }
 
     if (xlen == 32) {
-        oi = make_memop_idx(MO_LEUL, mmu_index);
+        oi = make_memop_idx(MO_UL | endian, mmu_index);
         t0 = base + (index << 2);
         target = cpu_ldl_code_mmu(env, t0, oi, 0);
     } else {
-        oi = make_memop_idx(MO_LEUQ, mmu_index);
+        oi = make_memop_idx(MO_UQ | endian, mmu_index);
         t0 = base + (index << 3);
         target = cpu_ldq_code_mmu(env, t0, oi, 0);
     }
-- 
2.54.0


