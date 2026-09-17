Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8B3C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73qv-0003hQ-JR; Thu, 17 Sep 2026 00:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qt-0003Xu-CI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:03 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qr-0007wY-Kr
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:03 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4d04d740cso250530a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619760; x=1790224560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EEZjclD1Pfg6ab1ffCtW1YR8no5EBaKysar8IuTZsyQ=;
 b=lVeodAkHvjUwhX1oqNdIcif4Cr/Eik/dnioA+uAbnWULB4bc4wfr+fSUt0Nz1NPuOa
 8nxO+OFroSbs4Nj7oqLMvIjC/OOf4AO0OySt8sGUxtPM+EWtByAhdACgLO6EfkrDB+49
 n3+EbiDTDUx8RroV3+fVlKyRYpITmrBIdnXqVWfEfG3X/S1U6unhlpc4o10+MuulJvy8
 ZnHutTAnBSYGfaqfwjdhSzZ1OZejMtkOBImNfCY4UGKpkMg/cwDPQelmtjs08WAWP8mh
 5HrGW7MsuZmWOdkumLDepziin4M2ASDmWl3Noby6lmNbcxSQs0FQMF9ExEXMyLnt7Dyb
 GXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619760; x=1790224560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EEZjclD1Pfg6ab1ffCtW1YR8no5EBaKysar8IuTZsyQ=;
 b=IYWrX6jm3QNmlF+kBi6X2ztuxJ1vMSjt6kABWsqhRk5yc+dXlqQNPAhqV/NC5ko4UI
 K/MYvRgVuRByqFv9/B7jJcrdUzFCQQ4YFew1bElBfomBA4mUBGS5QxPTul+RpeR17IlJ
 bKkKwjeY0XgQvnfJLHdxIQa/NWJADE5SG3zxXk1ckNCtZxXfLQTDaMXnSMKo81MoVTfj
 WwCSu+Qhm6EKjxV/ryFHq7VAHRXEV424syzGsbeHdGIfDLBSEi9Y9cq+RALb+FWe/1xm
 nPIA2aFgjEr9Cyc+mFFpoPK4l8gNQCsskJG444ZHl8uku4E+TM2RmDCSenVMIrbuqeNT
 EnsA==
X-Gm-Message-State: AFuF++nc1zKCqiXarQMZXteu9JSHANPKPfT1YFW9MJgjZMq8XVjdpnPu
 Okp+E6IOq7hqywlvHkfWMAZLGypBnx74v9xP6L7aV1fG3h3sgPuO4i4+WTkHqMJNshEjTwXMM8V
 cUVSW3Sk=
X-Gm-Gg: AYBFou3guZHZpOVfkU5LfO4lDUPvhFZKL4BKLyJTzbOsHeRBar5zCnWbGURAOVz0EP+
 P3xMY01eKWyr+oyTgddDWSNWGB0ehPws5xGxaQSQoO6vI+8J7TfXpzVK/4RsdbsvYAFfwrxjLkp
 NPKvPXeLL/zw3+YQg1I26yEYCLcu0XlWF8mCgBOXWevQMiMdPAiNDU5T2E8Ca2t6HLioZwVKljd
 YdNPpSYhbev+myH3hTbyi+0/acC+pQTe7dOpnJYo6MCn5CMuTtx9m9sr0ZWEEwse6OnqQfl5A2e
 q57TVUsSDBcoQooCBcin+1J9DbdEU76I+6EvuW/cP6KL++qWoE2exy7vyq3I4RHQ0UAqS/P5PC+
 CEu+zjIEQ1ZkbpwiOQgbh8oXB8tqoL/RKnDWh1rwNHYSE6TcmXsPwju2QhiGmxqcmLMA2bgViOg
 2dBNITdAhx9BrbpLDS8A+RbOZYFk5QocT6BCS/vjzaE3El+HsxVMaQB2IAuekcRPfpcgyc4IAdW
 5EfhvY+WSUPHyybQg==
X-Received: by 2002:a17:90b:578b:b0:39e:14db:4371 with SMTP id
 98e67ed59e1d1-39e1e27a374mr11442722a91.1.1789619759950; 
 Wed, 16 Sep 2026 21:35:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 089/101] tcg: Split out gen_bitswap
Date: Wed, 16 Sep 2026 18:28:11 -1000
Message-ID: <20260917042823.542588-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 418750776a5..a2ac9380802 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -382,6 +382,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF5
 #undef DEF6
 
+static void gen_bitswap(TCGType, TCGTemp *dst, TCGTemp *src, uint64_t mask);
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src);
@@ -505,6 +506,26 @@ static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+/*
+ * Internal helper for bit and byte reversal.
+ * Given a repeating matched block of 1's and 0's, swap the bits within
+ * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
+ * right 8 bits.
+ */
+static void gen_bitswap(TCGType type, TCGTemp *dst, TCGTemp *src, uint64_t mask)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+    g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+    TCGTemp *tmask = tcg_constant_internal(type, mask);
+    TCGTemp *tshift = tcg_constant_internal(type, cto64(mask));
+
+    gen_and(type, t0, src, tmask);
+    gen_shr(type, t1, src, tshift);
+    gen_shl(type, t0, t0, tshift);
+    gen_and(type, t1, t1, tmask);
+    gen_or(type, dst, t0, t1);
+}
+
 static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
                        TCGTemp *src2, TCGLabel *l)
 {
@@ -1409,43 +1430,14 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-/*
- * Internal helper for bit and byte reversal.
- * Given a repeating matched block of 1's and 0's, swap the bits within
- * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
- * right 8 bits.
- */
-static void gen_bitswap_i32(TCGv_i32 ret, TCGv_i32 arg, uint32_t mask)
+static void gen_bitswap_i32(TCGv_i32 dst, TCGv_i32 src, uint32_t mask)
 {
-    TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-    int sh = cto32(mask);
-
-    tcg_gen_andi_i32(t0, arg, mask);
-    tcg_gen_shri_i32(t1, arg, sh);
-    tcg_gen_shli_i32(t0, t0, sh);
-    tcg_gen_andi_i32(t1, t1, mask);
-    tcg_gen_or_i32(ret, t0, t1);
-
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
+    gen_bitswap(TCG_TYPE_I32, tcgv_i32_temp(dst), tcgv_i32_temp(src), mask);
 }
 
-/* Similarly for 64-bit operands. */
-static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
+static void gen_bitswap_i64(TCGv_i64 dst, TCGv_i64 src, uint64_t mask)
 {
-    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-    int sh = cto64(mask);
-
-    tcg_gen_andi_i64(t0, arg, mask);
-    tcg_gen_shri_i64(t1, arg, sh);
-    tcg_gen_shli_i64(t0, t0, sh);
-    tcg_gen_andi_i64(t1, t1, mask);
-    tcg_gen_or_i64(ret, t0, t1);
-
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
+    gen_bitswap(TCG_TYPE_I64, tcgv_i64_temp(dst), tcgv_i64_temp(src), mask);
 }
 
 /*
-- 
2.53.0


