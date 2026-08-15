Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D16C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKm-0007P3-VF; Sat, 15 Aug 2026 15:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKY-0007It-8T
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKT-0008GW-1p
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso39476925ad.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823163; x=1787427963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s86Xnn5/dpDzfSJV6NAIFZxa3V37+nMyLlFJu9gce9M=;
 b=f4LpFnQCSi1qQUpQEKDkbaM61OtRPO9ZdVXjEQBe+ynxZqZiwtilfBN2o15vB+tP0x
 0MVJgis6cEEbCO9RI1yvvftDhS68FbKYhVuJ7M0Kr4tV+/H9FaMPDKn+DgOHbpqX2hVn
 yEpDbrrUsCabq4TtCWxlO04K2JTBP+Dle4RlT7Y7t6gTvb86HmSW8b+43jjZhCyJCeth
 TVcTGR4swheUgjRwlrPmv9o8/VPpTEk80OVtrVq49xeXFqR+XQFbspoXVrOffKqOyqNr
 NMm7dPZA2RDyHL4Y+UkiekQAZHzEBE6VOVpDgtS3tBxVSV7GQDmoS7QYLEMkB2J9ZW+T
 XkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823163; x=1787427963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s86Xnn5/dpDzfSJV6NAIFZxa3V37+nMyLlFJu9gce9M=;
 b=RBbF9RKCPysbemuxFqUSUN8zerJq3231r62/rZQF4bFUmcmb5nTQJk/FK8YStf34/o
 0nRvG2GQcpYAFdnX/hOK5yv25K3Em7NpedEN51Kiubc0yzIjGAB5nnZVtQzi93A1quPu
 EBhKFfON9GyGwkpNfo3Q2hDkrPxj0hUaPsDQiQ9Y11pDFQEhimel3d9cCTKuIX1zd7LU
 JM+09YVCupmxFPuFItt+PsuWLcrj3OLbnL0zzX4rxxBxQ/mfXE1hijV3oFXHZ4edVNHe
 MVMR4gG9Zv4g2FvKpAVplP/oyCPvpN5mCxU6zFsYHOxZoIqeR+hk/zfMhb0OKjzQFp7H
 ta8w==
X-Gm-Message-State: AOJu0YyruEVSxP8kgvnYs2iHerWyAKyeNKog7T+c8i6r1/GOfW1PLRra
 CierTP2NymraYjfhQ+5w2ttYirsexpJJh4Dhy8UtcWe/4Vhj/u7tlFyq83vYY3vFKJ2jWV+f7Nn
 UcAgb
X-Gm-Gg: AR+sD11V0t4rwOuT6kxJA9UktMquEwllHvrC6KGlC5s8FFf07IxWPZO1Y9YpSxaCveb
 hF01HMhrCnuq6KTpk8sB2LvpS8OU69KFTHueW+2SPw3Nm47OvR1ky2WXqDlhWXtiOtszdC0HNAU
 zLXKp37wMeTxSgRrHTckth2Vx5RVFZCa2s/aG9njtSYfMR67KRJ1GI3uOQ9Et5a4stBpR8fl1l+
 Dj8MufBJ2nvlQk5wRPz4LSbnoo1Uvcpp1iMgfFTnfHOe9xYT7HB2/yHocWpdKMlbMoX7ixUOoT4
 QjY+DkupcuwddQey19/8UDsG1fhHWk1HYbbBGDIm+ekRxa85Gt0uvNGiebTN8qdu9jFa7dTYRYt
 LdBZb7a2chBGzBtbb1uCmztmjItza4hNZA5OxW0tWXCHF84zGQQviK47fWY2OYtTnSINRKc3bzy
 98HnhKMNRdXdMv2dqq2aM0CTjYqDMkyqTsEKQzx1+5s28iyfHuu1HeYLVZAWws36SqAJTvk9X49
 cvPVGDqNSZIP/r0fC5u
X-Received: by 2002:a17:902:ce83:b0:2ca:e496:5f19 with SMTP id
 d9443c01a7336-2d3b0043318mr120672885ad.19.1786823163368; 
 Sat, 15 Aug 2026 12:46:03 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 04/23] target/riscv: Split out vext_ldst_nf_host
Date: Sat, 15 Aug 2026 12:45:29 -0700
Message-ID: <20260815194549.1377505-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Provide a helper that calls ldst_host for all NF vectors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 9c0cbcac16..661f1ab2f6 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -329,6 +329,15 @@ static void vext_set_nf_elems_1s(void *vd, uint32_t i, uint32_t nf,
     }
 }
 
+static void vext_ldst_nf_host(void *vd, void *host, uint32_t i, uint32_t nf,
+                              uint32_t esz, uint32_t max_elems,
+                              vext_ldst_elem_fn_host *ldst_host)
+{
+    for (uint32_t k = 0; k < nf; k++, host += esz) {
+        ldst_host(vd, i + k * max_elems, host);
+    }
+}
+
 static void vext_ldst_nf_tlb(CPURISCVState *env, void *vd, target_ulong addr,
                              uint32_t i, uint32_t nf,
                              uint32_t esz, uint32_t max_elems,
@@ -413,7 +422,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
                   vext_ldst_elem_fn_host *ldst_host, uintptr_t ra)
 {
     void *host;
-    int i, k, flags;
+    int flags;
     uint32_t esz = 1 << log2_esz;
     uint32_t size = (elems * nf) << log2_esz;
     uint32_t msize = nf * esz;
@@ -444,13 +453,9 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
             vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
                                       host, esz, is_load);
         } else {
-            for (i = env->vstart; i < evl; ++i) {
-                k = 0;
-                while (k < nf) {
-                    ldst_host(vd, i + k * max_elems, host);
-                    host += esz;
-                    k++;
-                }
+            for (uint32_t i = env->vstart; i < evl; ++i) {
+                vext_ldst_nf_host(vd, host, i, nf, esz, max_elems, ldst_host);
+                host += msize;
             }
         }
         env->vstart += elems;
@@ -459,7 +464,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
             vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
                                    ra, esz, is_load);
         } else {
-            for (i = env->vstart; i < evl; env->vstart = ++i) {
+            for (uint32_t i = env->vstart; i < evl; env->vstart = ++i) {
                 vext_ldst_nf_tlb(env, vd, addr, i, nf, esz,
                                  max_elems, ldst_tlb, ra);
                 addr += msize;
-- 
2.43.0


