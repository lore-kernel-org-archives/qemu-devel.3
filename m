Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A304CC982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNq-0007sP-2W; Wed, 16 Sep 2026 09:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNQ-0006n1-8r
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:44 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNM-0001Sf-43
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:39 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae7089c1so497953eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564115; x=1790168915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CxofCjOeWFFiSa/MeBCuy34Bn9m6cyF7qDLcsEEIiQg=;
 b=wBmuti5npeNzLDTismeCB/DYiEzWmXnJnTaTi3FTX5o5zKYgbQZUNUMxikMdPKR9y2
 /oPn24QjvKYT0dFvykpJccArnMgnHRmbpwHqoayDi+AY6ilEjn6pRhFlWqTLTcC6jkp2
 PdFlnv8NPxjEf0+BqTt1io2mqmwM2N0n94VkWWfpoVjIGf+j1M7CxCelkb7Zdu/M3VWV
 ZjVx+mZt4KF4jchOnt/lI+KCm52qmv2bd6CuW2u8y333ZQ4Bgsdg9iSNGH85E4U7yiHN
 q85idYX9nPcqo1HZeSUOhfRTivXegzPrs21+1bABtj1tVEP0VYuOIdacxMyodwFn4lre
 eZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564115; x=1790168915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CxofCjOeWFFiSa/MeBCuy34Bn9m6cyF7qDLcsEEIiQg=;
 b=Z5YYvOc4qKtOmC5ZYIMgG0ijOLPmeYd7/ZtZO3xqLhRcVB+OC1aAqmzXdT6QqDiu6g
 f6j0HlPnEF60kCH97VGoDSXv/b3wi4WH6spGU165X7eVsUzEQuRylexUGAynorXU/qU6
 XLI5Q7BXcolLd24vu+r0fl5gUUyvfUBM/IC0FXcUIAE+ArLifNCc6aHRJNRy9IJXSlYX
 8eydQaP+C4ID+NMDuoagCzWKx7uAyyXAHSCDNrVIg/giM+gKlDeEi40kdzm5irbKUrWZ
 kvh3q2tGKEwfrHovHocfJimx1bOzJ+b/KzexGzlUA3DhiDBhTULHYTvhZcshLLrggnTM
 00Cg==
X-Gm-Message-State: AFuF++nExuro5yEJDCGSPrEP954fN9/neNLK2b0wavdiLlAjPPu4Evz9
 c3Zgb+Cr7rB5li/8x+QEUHEtvvaHx9ymkW2xTX+/Ak5CFS6w0FNa0yqYHypnIGE/+2aiEourRZy
 7UzmMqAU=
X-Gm-Gg: AYBFou31U/H+3YkDokHmH5Ruso6NP4ysEFLFI1Q0hoUjR9kwFl6huUSlAhZqE2wLsYa
 sMHPED+DRAMNKDaXzwf3ATPVU6NwPIVOTUOgV7tp4CzWa8B7DDGt3EtxcMjfbXD6VIgm+w0eRMd
 6TNdO+xwyNa6auitBEFbu6wPHRDI29biywnGsK03djpoAsKyoNAvXjllVM7hPvH68rsUhhk4BPD
 JZT+40/8wrKKKRL47RZft//taseMKw1Aul8eXbBc8H5deE6Q/6BfLrdQTl2HDD4q9XAF5SmPBmQ
 mcr32A8bmF7LOi+aQANr9OrNFWN3i+6P3Bni/CO3CoFNXLKyOKaZ2P8MWBK+xlgx63mN4bTpr/u
 I/EQnmoe0G0DVe6OrWetKEdDGMhlCRrNVR987wTa/ODMlpNZFHOqepXjNWQhPUMr/RvAFnjDWSW
 Kvl0Yv/b8NNZRk0TNCQIkhrPvLJQZvEg+XfneqdfbHeUHDDTLimXKd0Bj/TWYbno1ey+S5p6aNa
 Umtq5I=
X-Received: by 2002:a05:6820:a0e:b0:6b6:55b7:38f8 with SMTP id
 006d021491bc7-6c7d17cc7a8mr2432987eaf.18.1789564114543; 
 Wed, 16 Sep 2026 06:08:34 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 61/92] tcg: Generic expansion of tcg_gen_rotli_*
Date: Wed, 16 Sep 2026 03:03:36 -1000
Message-ID: <20260916130409.3382710-62-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 39 ++++++++++++++----------------------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index aa5257d9e31..2b65e996acc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -181,7 +180,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 383a13aa1e9..57d6f07b907 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1d31a1a3f1d..de42f536b80 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -872,6 +872,21 @@ static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else {
+        gen_rotri(type, dst, src1, width - src2);
+    }
+}
+
 static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
@@ -1013,18 +1028,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
-    } else {
-        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1787,18 +1790,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
-    } else {
-        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


