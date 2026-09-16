Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288C7C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJx-0001Sn-5U; Wed, 16 Sep 2026 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJo-000199-GJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:57 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJl-0000R8-K3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:56 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6f1637so335786eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563892; x=1790168692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pBqAhA0+CdAZCUkJyOnIcW3nJZE20xi/oNfYr0M4rBM=;
 b=eIAtNOUul91n+DgFjQKCzH3G6pnqyQKUZB43c42OrOrJCfJDP74Wj/QZ+SEBFoUyXB
 tjOY0zA0bJ1OJaEMY2OfWaNxNqsVU3rGbPHcJlEgXsHxJNEnXFVjSv5gKJ5rwpcvGJX6
 AtzLZTWliw0NiagaeJ09cLbVGJJwxAS9fsuq4TlwzDbCw7jOESEWJz0XV/r4inYwrSaP
 0BogIl+pfIq3u2kmP7tqLGAw/laoPjEfYLCJ0QI3aCpcmk4bmI/lZiZqzvbIfIhdOvjL
 u2I/WaFjz/mskgdNJbnFvSMGxTBmE0qinjWNmX2sHI4c2JRgJAVLqCZFWFRC20H0gvQH
 BwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563892; x=1790168692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pBqAhA0+CdAZCUkJyOnIcW3nJZE20xi/oNfYr0M4rBM=;
 b=UNtw0biByr6F+YygMChjcpDGCWcHG9V808FJUWNwIzPxLGfS2zVpvLaqL7xxNHMkBO
 GtoneP8s1Dbh9hXUURm2o8SjGPqRR9KXqVHojaMMzDmQHl2Lbl7LEKS/kZgF0bsRHUIJ
 okBZDZxGZY/LQfP1uLZs7RggMtYDDUAL/t3iDUSdVWqL2N0gFlQtmEHtswIjTrJ1GInx
 AVTFEO2N6MsUftbOxVx130emKUGnDU97LOpA6MEPNcLn4aNBJ/4n2i7KpneGegAjVNOQ
 os53TSrNgeQzQFEioWX4GP61vnlM3k1pBCF77LKbHUGuxWrEsF0qxd2A3jhdLXE3aXeU
 Refw==
X-Gm-Message-State: AFuF++n0tY0kRNFRmf6TdGd5w1u9aARKlGVEyntBMZxZoPCMQdvQ7UlJ
 CgO049d1DviATo4zlrqB5yjBngfNWtbDGNvGT3eOx/Q06OUyAFFpBX6QlxyHecyiJVozMeeV7Z9
 Z+HW/RTc=
X-Gm-Gg: AYBFou1HocxHJHOn9Bldq56XSGNvzRB3towbtztyTXIvqqZfrSVvjtypiA/P+Iuta/j
 weX4bo7dZxPchghqZTczQtRnQ/QleWhQNCREKzi8I/voHZUsIUDCKFC2nEYJK8YWMuE7lbwOW9+
 SjLK8heqvRWS4JyaXesOMPJib/GWyr8EYSUDvM3TE1KxhkqSpg00R0nJ6B3mmVR8BKfWAlKJ59u
 0vDADmDU+tWHaHxN5QzosZh0qv6znpDg1sRQ78g142wpM5SCIAG34rI5+1xJkGGlHYzF+P6Z6/8
 CbEtqzGWEvBj42J4HB93700Gonm5q/afkplVNvTNpEWOkDJsTPF92x4UXlBmvELVHHuzUmw4hYA
 l+cSB6h2a5akQXPB2S0qr9IOxiCj6zef8Fe8NIcvJwYmJjMt7tNc+Whu2DzmGXv6QzuobgE2Y+Q
 qG27O7ZqvIuI2HYReiGaR4ir3hCO710m8IPQ5LKha9Wayu7+gFHTTsO26bBDJmjaH/7vfG1cbOD
 kHbvNA=
X-Received: by 2002:a05:6820:f06:b0:6b7:46e9:96fc with SMTP id
 006d021491bc7-6c7d39f9c02mr2423134eaf.44.1789563892398; 
 Wed, 16 Sep 2026 06:04:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/92] tcg: Generic expansion of tcg_gen_shri_*
Date: Wed, 16 Sep 2026 03:02:58 -1000
Message-ID: <20260916130409.3382710-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 14f8dce347e..e8ed65d8c15 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +215,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b98e5bd80e9..b95e51a07dc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
+DEF3(shri, TCGV, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1546fc3c094..99b56361558 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -473,6 +473,16 @@ static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
 }
 
+static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_shr(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -564,16 +574,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


