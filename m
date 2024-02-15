Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E288CC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWuB-0007lG-QB; Thu, 15 Feb 2024 03:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWth-0007Dz-8B
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:10 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWte-0001bl-5n
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:08 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ce942efda5so490502a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984905; x=1708589705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKwcsoqbJERmdkOS9kUB6SrPLVGyNwfg2Re2n5hH/Bw=;
 b=tRUrP5e6NdYPo3/srRcWW+J33mNgrgP5pH11LQoIQ7QHX6XqK5T2Q9cMbTPR7Ozyha
 bJpHHXWshDE3kfxcq0PAdFl6SRlSwxs19PXqUjNocxTaES6sZQQ2Pv2FySCfyi7AouZv
 6JDwcncYI2DpmGOdO8/w3U8orXdOLfGS2g63bMNX5vSgVt7vo72SfsPANrwdOAl+Cf20
 M3SVJtq4V7LEbdbVLmE+48kx10CJO3H7m5ySvkC/el1+9NizhhFj8Wq02TdUvrc+LIYn
 jeZsbBZRdJBEjagNc56siuWU1KzhaBc1Pb4szEQ4PCgas6FR7NSlGrndkXrDx3FAC3tX
 Fhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984905; x=1708589705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKwcsoqbJERmdkOS9kUB6SrPLVGyNwfg2Re2n5hH/Bw=;
 b=QJyHzbCWZ9SnN7D2cawUk4qIinJ7cIzfdZ2jVraXf4bMLenclf3Nrawhv/xxJgCP/m
 bfd//hzOgR+lIBFmrIO3GKbl3U7L6XrYS12McwXvwmh4rnKq6MAVFwsmVzEgtacNdLiW
 l2STdQoSWjr6b9yhL95iPto4eBQnIYJoS4YnjqPAc86kSM3tONYTxQjkoqpljSIM/rhj
 tLsE4LZGYpZhFDBYt7eVljRPz33134u5gEdfbbzyI8NJyzOFem+YuWS/z4kxu8sKtKEs
 HckWPhVu3jQNNzQX6XQMVOWoUEfrl5sQluytEqERFR2MWvL4GTahEKrmxed3H9qsZa2s
 Q/hg==
X-Gm-Message-State: AOJu0YwUkt/W635hKlA1lWQbf6dZ7pJeuZ9y1Y4U7laC3a1WZWNAYXDA
 lz+/VSdBf7cNgsU6d0xzp00iTb8je2P/j/uBcKVCU44fBuZQPpCrl3aKpm93XC7MDTobAJeeMVV
 D
X-Google-Smtp-Source: AGHT+IFm67fZWp8xIQeGNOkUQuYe3WQy07lgADg/ZqQ4rqGUdTAOiDD9rBMQTZ9RUo2nno/QZPzVxw==
X-Received: by 2002:a05:6a20:20c1:b0:19e:b534:1bcb with SMTP id
 t1-20020a056a2020c100b0019eb5341bcbmr1028640pza.23.1707984904797; 
 Thu, 15 Feb 2024 00:15:04 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:15:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [RFC PATCH v4 10/10] util/bufferiszero: Add sve acceleration for
 aarch64
Date: Wed, 14 Feb 2024 22:14:49 -1000
Message-Id: <20240215081449.848220-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

RFC because I've not benchmarked this on real hw, only run it
through qemu for validation.

---
 host/include/aarch64/host/cpuinfo.h |  1 +
 util/bufferiszero.c                 | 49 +++++++++++++++++++++++++++++
 util/cpuinfo-aarch64.c              |  1 +
 meson.build                         | 13 ++++++++
 4 files changed, 64 insertions(+)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index fe671534e4..b4b816cd07 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -12,6 +12,7 @@
 #define CPUINFO_AES             (1u << 3)
 #define CPUINFO_PMULL           (1u << 4)
 #define CPUINFO_BTI             (1u << 5)
+#define CPUINFO_SVE             (1u << 6)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 2809b09225..af64c9c224 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -270,13 +270,62 @@ static bool buffer_is_zero_simd(const void *buf, size_t len)
     return vaddvq_u32(vceqzq_u32(t0)) == -4;
 }
 
+#ifdef CONFIG_SVE_OPT
+#include <arm_sve.h>
+
+#ifndef __ARM_FEATURE_SVE
+__attribute__((target("+sve")))
+#endif
+static bool buffer_is_zero_sve(const void *buf, size_t len)
+{
+    svbool_t p, t = svptrue_b8();
+    size_t i, n;
+
+    /*
+     * For the first vector, align to 16 -- reading 1 to 256 bytes.
+     * Note this routine is only called with len >= 256, which is the
+     * architectural maximum vector length: the first vector always fits.
+     */
+    i = 0;
+    n = QEMU_ALIGN_PTR_DOWN(buf + svcntb(), 16) - buf;
+    p = svwhilelt_b8(i, n);
+
+    do {
+        svuint8_t d = svld1_u8(p, buf + i);
+
+        p = svcmpne_n_u8(t, d, 0);
+        if (unlikely(svptest_any(t, p))) {
+            return false;
+        }
+        i += n;
+        n = svcntb();
+        p = svwhilelt_b8(i, len);
+    } while (svptest_any(t, p));
+
+    return true;
+}
+#endif /* CONFIG_SVE_OPT */
+
 static biz_accel_fn const accel_table[] = {
     buffer_is_zero_int_ge256,
     buffer_is_zero_simd,
+#ifdef CONFIG_SVE_OPT
+    buffer_is_zero_sve,
+#endif
 };
 
+#ifdef CONFIG_SVE_OPT
+static unsigned accel_index;
+static void __attribute__((constructor)) init_accel(void)
+{
+    accel_index = (cpuinfo & CPUINFO_SVE ? 2 : 1);
+    buffer_is_zero_accel = accel_table[accel_index];
+}
+#define INIT_ACCEL NULL
+#else
 static unsigned accel_index = 1;
 #define INIT_ACCEL buffer_is_zero_simd
+#endif /* CONFIG_SVE_OPT */
 
 bool test_buffer_is_zero_next_accel(void)
 {
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 4c8a005715..a1e22ea66e 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -61,6 +61,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
     info |= (hwcap & HWCAP_AES ? CPUINFO_AES : 0);
     info |= (hwcap & HWCAP_PMULL ? CPUINFO_PMULL : 0);
+    info |= (hwcap & HWCAP_SVE ? CPUINFO_SVE : 0);
 
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
     info |= (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
diff --git a/meson.build b/meson.build
index c1dc83e4c0..89a8241bc0 100644
--- a/meson.build
+++ b/meson.build
@@ -2822,6 +2822,18 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
   '''))
 
+config_host_data.set('CONFIG_SVE_OPT', cc.compiles('''
+    #include <arm_sve.h>
+    #ifndef __ARM_FEATURE_SVE
+    __attribute__((target("+sve")))
+    #endif
+    void foo(void *p) {
+        svbool_t t = svptrue_b8();
+        svuint8_t d = svld1_u8(t, p);
+        svptest_any(t, svcmpne_n_u8(t, d, 0));
+    }
+  '''))
+
 have_pvrdma = get_option('pvrdma') \
   .require(rdma.found(), error_message: 'PVRDMA requires OpenFabrics libraries') \
   .require(cc.compiles(gnu_source_prefix + '''
@@ -4232,6 +4244,7 @@ summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host_data.get('CONFIG_AVX2_OPT')}
 summary_info += {'avx512bw optimization': config_host_data.get('CONFIG_AVX512BW_OPT')}
 summary_info += {'avx512f optimization': config_host_data.get('CONFIG_AVX512F_OPT')}
+summary_info += {'sve optimization': config_host_data.get('CONFIG_SVE_OPT')}
 summary_info += {'gcov':              get_option('b_coverage')}
 summary_info += {'thread sanitizer':  get_option('tsan')}
 summary_info += {'CFI support':       get_option('cfi')}
-- 
2.34.1


