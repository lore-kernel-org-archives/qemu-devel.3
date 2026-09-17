Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2DDC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nw-0003Dh-Gc; Thu, 17 Sep 2026 00:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nU-0001dr-9e
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:40 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nS-0007HZ-9t
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:31 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so334390a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619549; x=1790224349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZvNyxBh51Etb9zSbXrXhjhV817soOtUYoVrNwVQckdM=;
 b=RRV8I49SA+mklOgTwITaNSIic5xbG/K1GfObrmEXpQrxox/RX7rwW5pUfvXjLMlmC6
 pnqiabwux5MsEryrUzR2wtr4iL065VErvSZSBBOL7K+v3l5jyHk6u3Bxr1necwOZW75O
 2mx1Big7UPRAwPrvz4amDSgcaIyuNU8JffFeOqqTstnKuZ39ntI0cnYyjV2ODRBKdQAt
 wfMuwSc99qQsS13lP9usuY/6i+//pOpWNUW5fCLy4u7FwAvHf1GqxjThD8cjTHWzEjIa
 IB9GvcsIeGKUR9vfItQmAiT76URpL29dBPFU/Mbx1GEqT4daOONOFc7lVq6FbIABwK9b
 Y3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619549; x=1790224349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZvNyxBh51Etb9zSbXrXhjhV817soOtUYoVrNwVQckdM=;
 b=A+se+IYPEkHMQlIwC7X0U9eIu1vTqABIi0mAP/rLdj1KU4Elu3u3y8XcjDxuRZHpaC
 +SREhGiWIHMhRYB5eJ26EcdYAUA1b945tC/qz00XboywAu1KM9ppIu/Qj3Ly5jrm2TWJ
 GCAN7wLF0e2rIkMk64b8U5qg+iPVMXZxJKo79spE/1v1w7lNNt9X4xhOzTNHDutY7ytZ
 t4ZbifPSh/pmMwhkfy0W1wB8CEbAAegOTlUHzdNlaEdVFOHMN8otgL3Yi05zQ1Aiexv7
 /BFlp2rcO06GGNs7qKhGsKNRosoHpCngKA5WRJJJTky6UP+Lt1ZMu82/KYmuivGR20rs
 ejqA==
X-Gm-Message-State: AFuF++m1JOZ3hkqxPN29zJDV6vr9vwr7gvqpGe2z/9RzWcEjwP+5RC3D
 aTzj7J86inlUd1PGwi5mK9dtRnbtgzUKLSWNm5IBjcg3amNUYXVtcGujd7g+K8qC1c4sLE4OBPu
 Q0MmnV8c=
X-Gm-Gg: AYBFou1Kb59CrL066DTy/cbEpAJbsN2T2YRYRXEHpxMiNx7ZXQpADvqYJcQrXbfoul7
 TdGoosgU/hzbPO2mibRF6i0EnLDwTpcrL5UxU1JKcSs4gAMnVYvJaBXCwnTURp4ZJybYR1bjPA0
 r62QeMYe5Zthfw4dX69oP6/Idwqcr+DKoPLxEn9mlguQAiTHipc5SQX4BI68XbAYa0lxHnHuKhG
 4ff9QcqjxLZk7ZJZuI0A6evxk5BqvoM6BvIGIASfALKHetVTyF3usw0WNaII/S4Bczv2izXNgTw
 ACSbx6utqcUMZUM+S7wiiqq8n9phHHhpFEtrNwFPeZdMVnIgboplJGds5F740RAScTXWf4+MJMP
 sBDW0ti2zv9Kx5bR//leR5D8cag6U4caJqQSMxwyttBzxbjBEWNZXDonPrnvSQZaZz1tpUhEFlc
 3oQxYZfou592b4BIxF6nnSYmCQZPFuSu5PKZTSmksWM+hzzQJNGAh+1LzbEl80sFhEuZnb/RPAo
 BdKP00=
X-Received: by 2002:a05:6300:2798:10b0:3dd:657e:b7bd with SMTP id
 adf61e73a8af0-3dd657ebcf2mr8116546637.6.1789619548678; 
 Wed, 16 Sep 2026 21:32:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 060/101] tcg: Generic expansion of tcg_gen_clrsb_*
Date: Wed, 16 Sep 2026 18:27:42 -1000
Message-ID: <20260917042823.542588-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 45 ++++++++++++++----------------------
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 96a8ba3026e..79bb00b4a5d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -185,7 +184,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 9968ca9516f..1bdf9876067 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ad738316293..eb3c55ba69b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -495,6 +495,23 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, tmp, src, width - 1);
+        gen_xor(type, tmp, tmp, src);
+        gen_clzi(type, tmp, tmp, width);
+        gen_addi(type, dst, tmp, -1);
+    } else if (type == TCG_TYPE_I32) {
+        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    } else {
+        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    }
+}
+
 static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_clz, type, 0)) {
@@ -922,20 +939,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t, arg, 31);
-        tcg_gen_xor_i32(t, t, arg);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_subi_i32(ret, t, 1);
-        tcg_temp_free_i32(t);
-    } else {
-        gen_helper_clrsb_i32(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1767,20 +1770,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t, arg, 63);
-        tcg_gen_xor_i64(t, t, arg);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_subi_i64(ret, t, 1);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_clrsb_i64(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


