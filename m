Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862D5C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrx4-0002H9-E2; Tue, 11 Aug 2026 15:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtrwx-0002FP-Ei
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:15:48 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtrwt-000286-TD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:15:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so200461a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786475742; x=1787080542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWe3uPbG8QTQeWcNC7hsaTPyUcsTnfL69Da5dCKR/IM=;
 b=iVkcxKblc5kjxWW9eHxhYcw0KeCh3pPpoSL5+Q9T1ytx6sJC7kI3id36bhE/TCKefR
 WLfLUUSC2m56C79/Sng1UdM8iZ+4zm3V7uOFxFSoHJkMImZorRKMuXXNhyJY2NVR91Wi
 koI8r7hsQdKsQdXj3X++Xkq+5YNQD9dhnfZ+RMT75yo00A/Srpe56QAuz5u+XbznV57P
 4RUWQLGMsNdsZIehbJ7f7y8P8fpmcogBEE/KKP8p/k7f0y/SsSk98CeWuGWRiPEseEwi
 OvhjrsMRlP13fn3oWAxpu1py0Uy3bOH+s3o2f5/435DQnMW5Wzf/OtSNdc9EdE9P5j3z
 SDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786475742; x=1787080542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWe3uPbG8QTQeWcNC7hsaTPyUcsTnfL69Da5dCKR/IM=;
 b=oSdIDLk95Zfe15s/Q+rHPWp+gF7EbDPId1TSfncz94I/eNYYXIgQIMotpkBCCsPCEg
 p1mKbfeG+8t2mFAOZLc6G4KOZYTBODLc6I+hbZ5a6ZiRIvRr+gzYWv9LcdIlmBRrss69
 uwE6FYR+9EXwa1T+DybSOzoMGk2qnThWGb4wO/M/x7qs3lrJrJvQEJKYj57+crt5UzJD
 IUwkywaJf9QwU/O1Nt+2M5Qqe/EvtLJutlppE40hE7nkOzsQMgiZ4QM4RF+iA4SJzYd1
 DXAO2jlS+pQHn+0jEOmDhzF9nJyaAM/3LhHVL0L73aiB4I5EhlnzRWwPYO0FNXg/F6cF
 SW8Q==
X-Gm-Message-State: AOJu0Yznevx0/AXSBabXX0nBwWDxmMdwsGy+PX6URW9b7VC97kHJrJL0
 V49rNgxF0gTIpm2gGQ7vFHA4Vqrv03uxjhkriFP9j1+smpYxPGu1dctIiCAJb5Q6vh/3Zc0aWGm
 mike6
X-Gm-Gg: AR+sD12M0V7uRHC3PyiGDQuwtnSMpl0OkuVZErZ6Pb8K5QfxuOHnpSDhHhXADW59KaN
 TgzJSrSFMloItgtFeSsfTa7dT57i4AIkscVY3JmRtTJ7qUngTzgbkI2oWH0rm97q2AM3jAkZJpA
 WTZT+T/DBB6I1v+8grzS3ImdROqqqBXeMaeaZ1D7FxCLPAPaKXBO7ffUSGg+X9TSTUxBSxehdA0
 9pCpHH+y8IOcAP019Iq/eovzTfmsZutUsOsUxicoijOn1Cj+BVPjaDHkeraHvU4jCO8AqY0IwjW
 xKl7rIZYNd9zi0jB26YEHxcRw7NVe8qRF+SHJtLnJYg2CSwVB8adwkIFbdKLzMzq36L4VU0QYLg
 u/Gov8ZwI/ksJXTbYGgnI++QKx8KS95Ligd294GH7KP0AhMLAcfxfClhcvgFzbpg3InFY+QsJ/7
 TWrZY8rp8Ix3AqFXfUD4yfs2aTTf1y9c3N8MfNEC+/vTa1ItWwbDI3/yZ6nv11WPXDEF1hvM0VR
 O8ngcujXNabRPA2iTWT0yAKU/DHKKk=
X-Received: by 2002:a17:90b:180c:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-392ec5b6b8amr5463314a91.10.1786475741991; 
 Tue, 11 Aug 2026 12:15:41 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f97fc409sm209668a91.1.2026.08.11.12.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:15:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yang.yanjun1@sanechips.com.cn,
	qemu-arm@nongnu.org
Subject: [PATCH v2 1/3] tcg: Export tcg_gen_ussub_i{32,64,tl}
Date: Tue, 11 Aug 2026 12:15:38 -0700
Message-ID: <20260811191540.79882-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811191540.79882-1-richard.henderson@linaro.org>
References: <20260811191540.79882-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Move from tcg-op-gvec.c to tcg-op.c.
Use a temporary, to cover the possibility of operand overlap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  2 ++
 include/tcg/tcg-op.h        |  2 ++
 tcg/tcg-op-gvec.c           | 14 --------------
 tcg/tcg-op.c                | 20 ++++++++++++++++++++
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fe342db0d..c7d1529c4f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -163,6 +163,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
@@ -274,6 +275,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 96a5af1a29..40ce17eed2 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -149,6 +149,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_umin_tl tcg_gen_umin_i64
 #define tcg_gen_smax_tl tcg_gen_smax_i64
 #define tcg_gen_umax_tl tcg_gen_umax_i64
+#define tcg_gen_ussub_tl tcg_gen_ussub_i64
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i64
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i64
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i64
@@ -268,6 +269,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_umin_tl tcg_gen_umin_i32
 #define tcg_gen_smax_tl tcg_gen_smax_i32
 #define tcg_gen_umax_tl tcg_gen_umax_i32
+#define tcg_gen_ussub_tl tcg_gen_ussub_i32
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i32
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i32
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i32
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index bc323e2500..27f3807b00 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2399,20 +2399,6 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
-static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 min = tcg_constant_i32(0);
-    tcg_gen_sub_i32(d, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
-}
-
-static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 min = tcg_constant_i64(0);
-    tcg_gen_sub_i64(d, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
-}
-
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bbcb510c76..4d15d1abbd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1264,6 +1264,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_ebb_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
+    tcg_temp_free_i32(t);
+}
+
 void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -2433,6 +2443,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_ebb_new_i64();
+    TCGv_i64 z = tcg_constant_i64(0);
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
+    tcg_temp_free_i64(t);
+}
+
 void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.43.0


