Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47405C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjN-0002Lj-62; Sat, 02 Mar 2024 00:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjJ-0002LN-Vo
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:14 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjG-0007To-QG
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:13 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so2374975a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356569; x=1709961369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NJ0CHRGS5ogMQU2PTHyrbDWsaPoNSmVFmZRaOgb2+Y=;
 b=V9xswyMsOFfHNF32r7HPqwItLARrbgY6A2MRqkQ9lK3hKTBzdbdPc6MGyRcJOmr6Pf
 BNxQR+UQ0G95ys5j2ObMPuD+GpRunnKOL8/co/0nx8uMkVYTsqqaW/2Co5FXrQVT2Ggc
 70CWowIHbkqyADrLf1B0sqezJvelxpqBwHTBziAhNAuNNLgDkVOJpfEM53hDT9BOOchG
 o061YnuEqDGqZQJhthHQLR1A5+AneI3lHO68SxGcfrOJq30aXtLAlUpDIohtGS3D1eUl
 l9IlJaYm8/WR2s2lhIn2eLkUYTy2NAFcDjnSXsIZAQVv9zOQzKzWsT1a7/VVxnBCajCY
 gt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356569; x=1709961369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NJ0CHRGS5ogMQU2PTHyrbDWsaPoNSmVFmZRaOgb2+Y=;
 b=THiGHtNM/EIh3/DnmoZWRf0yRjx9KUe9KRlW3O2MC9RUeXqbaXiW7fAJ8VDjGFYocf
 epxSG4uzi8n/6QeGyDFarM0uUxZ85yL95+qhj5Ejsr1RC/dfe6ABJgYl8LhUq8UEgEfQ
 2a3SJSK+tlu4ZsmRn92V1LvfjoT/Z1lI4ADMCSxQ6ag+n9BBCeBWvaIgN2fvgv48xcxg
 MpiSEoKzaAXnngUnu5LdNqOxdV/6Zu7ttAIVXKHWmSetTP1PPzj/c7EEN7U8DR9xz8tl
 gMIC9nYS6R9wbNtBGZ8yNawF7talWikunMbBZ8xO0nvmKqZHSkPWke0fNlANaP2zIdEO
 C8aA==
X-Gm-Message-State: AOJu0YxPv1qSLoo1+Qoa2oBR9XZPNMekuWJEEglw1fy/Q9Zuev0hc19t
 RwaOdIFsyO46lSva2xqprgZulhQbrXxnQQ3H8RiFIW8zyFVBLkKHBFhnuzS6SO8Iz9XyAGG23zJ
 b
X-Google-Smtp-Source: AGHT+IE+vxKEWku6rGoN/hB0EY0HW7NvXhVEy9Ra/pRgwBU8GFQNrzq5Udh0NnWtOThCaajF+P3K+A==
X-Received: by 2002:a05:6a20:3d01:b0:1a1:14f2:4b70 with SMTP id
 y1-20020a056a203d0100b001a114f24b70mr4318154pzi.22.1709356569473; 
 Fri, 01 Mar 2024 21:16:09 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 03/41] target/sparc: Fix FMUL8x16
Date: Fri,  1 Mar 2024 19:15:23 -1000
Message-Id: <20240302051601.53649-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This instruction has f32 as source1, which alters the
decoding of the register number, which means we've been
passing the wrong data for odd register numbers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  | 21 ++++++++++++++++++++-
 target/sparc/vis_helper.c |  9 +++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index ef21ef49ef..adc1b87319 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -92,7 +92,7 @@ DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
 DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5016664869..5144fe4ed9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4539,6 +4539,26 @@ TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
 TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
 TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
 
+static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
+{
+    TCGv_i64 dst, src2;
+    TCGv_i32 src1;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMUL8x16, VIS1, do_dfd, a, gen_helper_fmul8x16)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4556,7 +4576,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
     return advance_pc(dc);
 }
 
-TRANS(FMUL8x16, VIS1, do_ddd, a, gen_helper_fmul8x16)
 TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index db2e6dd6c1..7728ffe9c6 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -94,16 +94,17 @@ uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16(uint64_t src1, uint64_t src2)
+uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
 {
-    VIS64 s, d;
+    VIS64 d;
+    VIS32 s;
     uint32_t tmp;
 
-    s.ll = src1;
+    s.l = src1;
     d.ll = src2;
 
 #define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B64(r);       \
+    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B32(r);       \
     if ((tmp & 0xff) > 0x7f) {                                  \
         tmp += 0x100;                                           \
     }                                                           \
-- 
2.34.1


