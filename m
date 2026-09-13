Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9351C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7z-0000Rs-6S; Sat, 12 Sep 2026 22:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7I-0008OH-84
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:53 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7F-0000xw-QZ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:51 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so406547a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267128; x=1789871928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cpFZGCMDl7PrMntWEpSU/UIfo8AKMlFCL9rwjnk3jK4=;
 b=gm1RrAKBlppcAKVb0GQ3pGjFEucV6iGDYq34i5d1e0rO2+nsw/epjas02BMpTKDTcX
 t0SMzNRg2EZYm5PDvuBda/sFuevM7CSkXYfnJr0ptCs22umsUU3+OtpCDDHlt2Gl2eaE
 Zj3URn/BpqJ+4fyBsU1pJqbn3+eVmqq8/mOzrexsu6+GzN6Khe2v5rFNNf+sZ0ZOv7Mz
 vAckv4EaJaJzl3CNDXIv1XeNtdvfVwdvY3zNoCvG8Qs3IMWTWUq714OtweU7xxjCAWss
 sFRXEdbqTuQIe0YgkP5Dbpv28NqR6QeVMtrRhPLsCXnQsFaFTCrX02HwlS0fmq7uxAja
 XatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267128; x=1789871928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cpFZGCMDl7PrMntWEpSU/UIfo8AKMlFCL9rwjnk3jK4=;
 b=CoOzapZOL7cai9iFH24WBuCvDhgmpjFpAB5dswX+84POHFNXbFOKsPnKLGZTdq0Bta
 3Axfawvkpn+ngkz9YEqjotcN6PpWDj8hJcW8p2hjH8IZJM6dMiNSVvOI0nIZKnU1QKwj
 wDQmjediHliyMVM3XvMk8hCXc9y1pVDiKCwZXhUdiq2eXE7rTJ4f+xue77fP6jwB5E9B
 WEpIX+haU5IvN98deVu6kirG06p60qtJI9iQH+CO+2aJ0sD9KYHlXM7wCRldMfuMxZVp
 jFZFAmYpwXDX/HR7PqKY4ErssDUAhmgd/Pomo3QlGwyQxRrWm9NzohJUmXk+IoshWCkN
 XHDg==
X-Gm-Message-State: AFuF++ncnvOSf/7kKmmM6G9BN+w3Lv1FHazfKmtWvwJ+5k8mCi1UPtUK
 oCmJiF/s74RXbVFtofpzFOdp6mjiKbfKM5uEL8EB9UmO9yHbB3OQFP4Ypta7EEV45PyD3qKOnHc
 BY1IheZM=
X-Gm-Gg: AYBFou1vBQeYfX/CneS+DpZdZFHX7F/FnzCWbXwSkQHW+ncw/SvFm3z1JpFnG6urixl
 ImJAbNgYbHvj/Nj/vaJKikWppUWMfncLv3sNR/WEuHr68fekNQLVm4csQe2xCR8T8ZqXdwlZpJ1
 +insD7x1fym7D7GhP61vjDRlBQcPZiPl2jZhE2LYpIU1NbNwOvj3m+E2mtensS6kfsWKh7WY+Df
 Qc5pPvdby5apfXICginTbExMiFp2Wzj/GNZ4KSVajuzF4Mm0GbTXMyxiBK/KjlcWYXQD72fZHgl
 ymRolCLQggrgiU+pXRCh42Ne9XDOgYtoBUVzOOG7Q1sFI9nyfqhITW/C+Rwees3SAUqeid0Jtvz
 N2pa1zNTUTPNGMpmuJlrknN3P3LB7NGQ6khBH4+VjjnTgkbLCSfsVIFbJrsoilUnoB1gc04D1tS
 OMQhw7D+0POseqk4Xs5sYIr9GTPuIRYFK4iibYEXnX+E7h2xCISwjE+AWtOt8hp4iXavkG1Tgqe
 vZO5EA=
X-Received: by 2002:a05:6a20:12c7:b0:3c3:7a0a:18a6 with SMTP id
 adf61e73a8af0-3db0e408702mr9267077637.18.1789267128377; 
 Sat, 12 Sep 2026 19:38:48 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/86] tcg: Generic expansion of tcg_gen_addi_*
Date: Sat, 12 Sep 2026 16:37:18 -1000
Message-ID: <20260913023837.741866-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 tcg/tcg-op.c                 | 29 +++++++++--------------------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2933db9f869..62487268a2f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -226,7 +225,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index deb3484fc60..31982e2dc6e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 
 DEF3(add, TCGV, TCGV, TCGV)
+DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 243f56493df..548fe84b233 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -402,6 +402,15 @@ static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
 }
 
+static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_add(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -421,16 +430,6 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
@@ -1568,16 +1567,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
     if (arg1 == 0) {
-- 
2.53.0


