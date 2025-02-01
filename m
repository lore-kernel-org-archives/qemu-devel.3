Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22ACC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZK-0001RP-Et; Sat, 01 Feb 2025 11:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYx-0007q1-FB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYv-0001PX-Ms
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so20935355e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428100; x=1739032900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/2K8Z3pwUQ/oXE8NyEXdkhcGga/r0RB0mzMV+vu/gw=;
 b=HpnUcnlXy1XSRv5ukDQm2bxK+fbSQKBegkU5LdKwDxrp8QAUKxTnKf2/HNboKBODXX
 eGqitR6EzbDY7STfe3WqYs+vfNyZnyW7xd/lZjobceyJRiKxQOReMuy5ZIynOXIepy2u
 1RdxfCX3v9QNgVxdE37RH1L2UvZD0BtF3jME4ThuyJkpcP/p+vZmQ4jgGWQTN7LXEqub
 zibX0TZ8tVNnjGsIieqkFUqZPCBwIzQ82QXRhxPHfj9HHDvT+H7y/etixEwFKCbAedef
 UxlATlIBz95Af6N4Gj2QOaLaFII69Y+0nquAdta/yy/Cmw6H03WkDOUB67SMQ5vY55ML
 OhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428100; x=1739032900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/2K8Z3pwUQ/oXE8NyEXdkhcGga/r0RB0mzMV+vu/gw=;
 b=Al3rKDb9e3yq/6FU6V/IIzWpxCsP1B0emJ/xlRZn/0RG8B3S6zWcEqwuhDQb4ibPuS
 4AP8BxdobkJ+Hvuj2FEgi1/WExrVIdENEepR/hnmbjdwUQdWOPMKufwJOotfx2oggX/K
 CtQnMbyyZkPqKZSCJ0CBfimqtWmxcnvmwHoqDlYCJiTSarpILQKJ6TCdPBPWgs8ei4Ni
 oIKjcRd1qbuWBqrapFS4xvreVGYRSsAAuyYRmmcaG9gDk10azlySRZVhCXANJyWk816s
 OB8un4RkohDqRUybPeEXz/82CQLw/2+uK5VNRS6xueeEpkY7QVD2n/upPMIspgFwAH39
 updg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYwRwY1gbS7/z0DJLQ6yCXS0/7e+plMvEG7PZLqDHexvYoB+AedeAIp6O3mwv71/xJzOeOiYQbcy8L@nongnu.org
X-Gm-Message-State: AOJu0YxsWQW+ssGfUqk8FisFRqrA9dHYaVj5axqokrvOIqMdYpfDQjEp
 zHoh/NpQ4jvPy/9qVFIeTi3hUyGmkNzMJzRWzIXK5M3mwkapwhDt4D5kmsHE0XQ=
X-Gm-Gg: ASbGncuvh47aBGQ3vOywhjl91TRUkJfnHHEZbzA7m7JyOUgh0zmyfppWQoTBmzN6c/L
 aqRAHRwJnvqEBLOVLxCI4f9YIgTXKlC664aJx1k8LviqXM5sVwDaRdRSaFV1KXkY95XPOFBiUH8
 +D1upINN+eJZ8Z14Kq0draqsZ3SAk+taY91OnaekCXaI7kqhkh8+l6MEXRCF5wdyrepql+YKzUr
 ZnwAy0KhWYzcyjKj6pO0yPGZH0/IRbjWcAqsl42qQ9mRnwoyl8dyHTkw0IMgh17LG54K0WeAkwd
 sreFgAQSH7tv6rr8cqnr
X-Google-Smtp-Source: AGHT+IFGiudVddJ1Gllwlmw7ow/aXOmwX64d048+LqdaCl+Tyhm2y/aLU80Wb/o6h1VWe8YHfqxk9A==
X-Received: by 2002:a5d:5988:0:b0:38b:ed1c:a70d with SMTP id
 ffacd0b85a97d-38c5167b477mr14007649f8f.0.1738428100234; 
 Sat, 01 Feb 2025 08:41:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 69/69] target/arm: Sink fp_status and fpcr access into
 do_fmlal*
Date: Sat,  1 Feb 2025 16:40:12 +0000
Message-Id: <20250201164012.1660228-70-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Sink common code from the callers into do_fmlal
and do_fmlal_idx.  Reorder the arguments to minimize
the re-sorting from the caller's arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-35-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index cc3586f44ac..986eaf8ffa4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2125,9 +2125,13 @@ static uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
  * as there is not yet SVE versions that might use blocking.
  */
 
-static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
-                     uint64_t negx, int negf, uint32_t desc, bool fz16)
+static void do_fmlal(float32 *d, void *vn, void *vm,
+                     CPUARMState *env, uint32_t desc,
+                     ARMFPStatusFlavour fpst_idx,
+                     uint64_t negx, int negf)
 {
+    float_status *fpst = &env->vfp.fp_status[fpst_idx];
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     intptr_t i, oprsz = simd_oprsz(desc);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int is_q = oprsz == 16;
@@ -2154,8 +2158,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-             env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal(vd, vn, vm, env, desc, FPST_STD, negx, 0);
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2172,8 +2175,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
             negx = 0x8000800080008000ull;
         }
     }
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-             env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal(vd, vn, vm, env, desc, FPST_A64, negx, negf);
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2205,9 +2207,13 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     }
 }
 
-static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
-                         uint64_t negx, int negf, uint32_t desc, bool fz16)
+static void do_fmlal_idx(float32 *d, void *vn, void *vm,
+                         CPUARMState *env, uint32_t desc,
+                         ARMFPStatusFlavour fpst_idx,
+                         uint64_t negx, int negf)
 {
+    float_status *fpst = &env->vfp.fp_status[fpst_idx];
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     intptr_t i, oprsz = simd_oprsz(desc);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int index = extract32(desc, SIMD_DATA_SHIFT + 2, 3);
@@ -2235,8 +2241,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-                 env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal_idx(vd, vn, vm, env, desc, FPST_STD, negx, 0);
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
@@ -2253,8 +2258,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
             negx = 0x8000800080008000ull;
         }
     }
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-                 env->vfp.fpcr & FPCR_FZ16);
+    do_fmlal_idx(vd, vn, vm, env, desc, FPST_A64, negx, negf);
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
-- 
2.34.1


