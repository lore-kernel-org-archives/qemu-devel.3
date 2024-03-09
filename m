Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E431CC54E5D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj3Y7-0005iS-Tr; Sat, 09 Mar 2024 15:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3Y5-0005fy-1J
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:05 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3Y3-0006XD-Aq
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:04 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2072627b3a.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710017041; x=1710621841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/ejtrzarPrG0PNfpEFunidUoSZrIjXAq7l/f+eMwmY=;
 b=cFbb8WhLPclgiY0b7aQkGMOcggiaxreGUt5A8b1vXm8krp0GlfSXzOosTeXUvoxwZ8
 1CUILjg2IuiIGQEPDOVuKerILMpAJkVOb8SD671Z/G5oaAVHf3aUws71rB8J9FUIGTz6
 JszyRD+9tk285mQQb4QEaBQgFS1oI0boD68zgluRcG2H+4IKdgIFYCmNDeJHvebq2xRX
 TgbAf2bd0Pbg6zD7aPwnOA0RlfoBr2Bl0Cdv3NjTvI9m6vOH9oyYnd6D4ziStnQRhQPP
 HldUKnaviVhYC85T9W0savUN0Hrkl4IvaW+yS63od2pZ3DhFrl3Jvhxq6gCFz4Q8ojUc
 Rzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710017041; x=1710621841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/ejtrzarPrG0PNfpEFunidUoSZrIjXAq7l/f+eMwmY=;
 b=CvbzD3lMnYBoBNzOZsriOImTE1gK5g8Pmuc7u2ry0AWSpF9p1s9ny6uAfMEQBFTgNb
 jq3tGyEiK7UppGlWjeMUu79erKFHk09svPmZhFE260luhl+pzNPfNIl1v7mFjjuOrxya
 QrDzutx+xU43E2pD/TKVbzRirvFmJuZSDwsDyNPirMbMOLA3QCSTS1R9dyWixhm1UEFb
 8z9WgwWpgl647fLyq8fgmsmw+k8LHZ9eXkdIcins4mELrZJibs1W2ltkm84trmh6QYvm
 8C6KhM5pSSKyVxVfq4OXL8iohenTOESLWrj/zlgQ3vpxRALmVgF7hjVohRjykyTPsTzu
 02/g==
X-Gm-Message-State: AOJu0YzUj70jKby3373zK+AsHtWnO3STPzvcSJ7+xa1NUo+g14f84qdv
 o/4Qo+v1jA+05FFnxrhq2ci77uRDEC+JP/ppND8L48VJfRuqts0W8KfYCVUO3TnCHnjFzTXYlx4
 n
X-Google-Smtp-Source: AGHT+IGJG/Zbmsx4FW7I0WxXPOtERhpY3LKM17mZSDGmQXR1SknHDOmPMKsdYUbuuoKxsoSQXCGAQg==
X-Received: by 2002:a05:6a00:c95:b0:6e6:3406:26d3 with SMTP id
 a21-20020a056a000c9500b006e6340626d3mr4909450pfv.4.1710017040968; 
 Sat, 09 Mar 2024 12:44:00 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 ey15-20020a056a0038cf00b006e647716b6esm1656270pfb.149.2024.03.09.12.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 12:44:00 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 02/10] target/riscv: handle vstart >= vl in
 vext_set_tail_elems_1s()
Date: Sat,  9 Mar 2024 17:43:37 -0300
Message-ID: <20240309204347.174251-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240309204347.174251-1-dbarboza@ventanamicro.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We're going to make changes that will required each helper to be
responsible for the 'vstart' management, i.e. we will relieve the
'vstart < vl' assumption that helpers have today.

To do that we'll need to deal with how we're updating tail elements
first. We can't update them if vstart >= vl, but at this moment we're
not guarding for it.

We have the vext_set_tail_elems_1s() helper to update tail elements.
Change it to accept an 'env' pointer, where we can read both vstart and
vl, and make it a no-op if vstart >= vl. Note that callers will need to
set env->start = 0 *after* the helper from now on.

The exception are three helpers: vext_ldst_stride(), vext_ldst_us() and
vext_ldst_index(). They are are incrementing env->vstart during
execution and will end up with env->vstart = vl when tail updating. For
these cases only, do an early check and exit if vstart >= vl, and set
env->vstart = 0 before updating the tail.

For everyone else we'll do vext_set_tail_elems_1s() and then clear
env->vstart. This is the case of vext_ldff() that is already using
set_tail_elems_1s(), and will be the case for the rest after the next
patches.

Let's also simplify the API a little by removing the 'nf' argument since
it can be derived from 'desc'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 59 ++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ca79571ae2..a3b496b6e9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -174,19 +174,32 @@ GEN_VEXT_ST_ELEM(ste_h, int16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, int32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, int64_t, H8, stq)
 
-static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
-                                   uint32_t desc, uint32_t nf,
-                                   uint32_t esz, uint32_t max_elems)
+/*
+ * This function is sensitive to env->vstart changes since
+ * it'll be a no-op if vstart >= vl. Do not clear env->vstart
+ * before calling it unless you're certain that vstart < vl.
+ */
+static void vext_set_tail_elems_1s(CPURISCVState *env, void *vd,
+                                   uint32_t desc, uint32_t esz,
+                                   uint32_t max_elems)
 {
     uint32_t vta = vext_vta(desc);
+    uint32_t nf = vext_nf(desc);
     int k;
 
-    if (vta == 0) {
+    /*
+     * Section 5.4 of the RVV spec mentions:
+     * "When vstart ≥ vl, there are no body elements, and no
+     *  elements are updated in any destination vector register
+     *  group, including that no tail elements are updated
+     *  with agnostic values."
+     */
+    if (vta == 0 || env->vstart >= env->vl) {
         return;
     }
 
     for (k = 0; k < nf; ++k) {
-        vext_set_elems_1s(vd, vta, (k * max_elems + vl) * esz,
+        vext_set_elems_1s(vd, vta, (k * max_elems + env->vl) * esz,
                           (k * max_elems + max_elems) * esz);
     }
 }
@@ -207,6 +220,11 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
+    if (env->vstart >= env->vl) {
+        env->vstart = 0;
+        return;
+    }
+
     for (i = env->vstart; i < env->vl; i++, env->vstart++) {
         k = 0;
         while (k < nf) {
@@ -222,9 +240,13 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
             k++;
         }
     }
+    /*
+     * Set vstart before tail update - vstart changed during
+     * execution and we already checked that vstart < vl.
+     */
     env->vstart = 0;
 
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
 }
 
 #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)                        \
@@ -272,6 +294,11 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
 
+    if (env->vstart >= env->vl) {
+        env->vstart = 0;
+        return;
+    }
+
     /* load bytes from guest memory */
     for (i = env->vstart; i < evl; i++, env->vstart++) {
         k = 0;
@@ -281,9 +308,13 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
             k++;
         }
     }
+    /*
+     * Set vstart before tail update - vstart changed during
+     * execution and we already checked that vstart < vl.
+     */
     env->vstart = 0;
 
-    vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
 }
 
 /*
@@ -386,6 +417,11 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
+    if (env->vstart >= env->vl) {
+        env->vstart = 0;
+        return;
+    }
+
     /* load bytes from guest memory */
     for (i = env->vstart; i < env->vl; i++, env->vstart++) {
         k = 0;
@@ -402,9 +438,13 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
             k++;
         }
     }
+    /*
+     * Set vstart before tail update - vstart changed during
+     * execution and we already checked that vstart < vl.
+     */
     env->vstart = 0;
 
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
 }
 
 #define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)                  \
@@ -532,9 +572,8 @@ ProbeSuccess:
             k++;
         }
     }
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
     env->vstart = 0;
-
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
 #define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN)               \
-- 
2.43.2


