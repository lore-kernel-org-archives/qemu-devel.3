Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E932CC48BF5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jy-000694-2Z; Fri, 16 Feb 2024 19:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jv-00068G-5c
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:35 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jt-0008HG-HK
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:34 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d73066880eso25546425ad.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130372; x=1708735172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+vMZHnTNPjSijzEPZ6pE1ZEQb70DOSnKuGgl762H28=;
 b=pTpzVQ6K1hAWblQycMsIJ7wnX4N4Upz/AKqBuk72pAFbryGG89nyBR0xK1Elglt7Kx
 by3MbFawWOvT6AEiSkCTCp77eZSFc7PphIeMCQLYuZLPAv4URWHxc4qFtAbraXr2gs4X
 Zi3Q07WZuZ6ikdrYrF+NGCdYhRv67ldooWzkHhGN0OcsTGpCTZH8Wd3iQ1q9W7N7O384
 iYU7RYO1LWgLAbN6iL4R28YEaoFnhabh0q3FRBhpR8+vICywFoIaxMHuFNv+Vu5H5ayt
 OmmbWM9jXM7G7VjMQVZKEbZHenmsElanYEU+4Zsc04SNzxd9/RLxt3OnihUqtYBvvnFj
 tkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130372; x=1708735172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+vMZHnTNPjSijzEPZ6pE1ZEQb70DOSnKuGgl762H28=;
 b=AlDjFOttL2biPLkGqgIywmzqdpZuicJEo/TuoaBgMg/gabT/mrir7USEcAiJJA/x66
 BGuuwRNSouuYTwgPs5W2a9WiAPEeV40ju1wh6BT57ohA5EU0B6LjYaAFlCNcOiCpO6ud
 GCk+7ta646/bO730tgxpy063WNw5ao1hPjFVqVo+EGa9YfSnfC2sO8Hn3LihhgUCeIPx
 lqn5FAQfRy+lG7rNXh6Sq8KUfzn9GWhS3JRhePsUTYkWv4VcjKQtG9yml8bIxBhs3frr
 pjuPu8xrrtugwZvEI+PdEjpNhZ3BFbpHr5PuEPH3ubOiw+w43Vzk61IdcEs7oy29WEC4
 RCBQ==
X-Gm-Message-State: AOJu0YxIyE+VUq9MloMFKTKxoLykp8c0/+ZQRA0rehXRfYEVqipfoXKb
 KeVqM+trklUUY6GFLO2lbCV2paTA7fwidM7MIivd4NcmLIsGqs70mm6pnPMB1VatvS+8btzI4u9
 W
X-Google-Smtp-Source: AGHT+IHMYy4o77CjpSpNLHtsRIsQjo2pBzCyjzgDEOrNSNonC7BcSGiqjwxrFx66Cm1v9UDFATcIxw==
X-Received: by 2002:a17:903:32c5:b0:1db:c348:60d8 with SMTP id
 i5-20020a17090332c500b001dbc34860d8mr1153996plr.23.1708130372163; 
 Fri, 16 Feb 2024 16:39:32 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
Date: Fri, 16 Feb 2024 14:39:16 -1000
Message-Id: <20240217003918.52229-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Because the three alternatives are monotonic, we don't
need to keep a couple of bitmasks, just identify the
strongest alternative at startup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 56 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 61ea59d2e0..9b338f7be5 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -180,51 +180,39 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
-
-
-static unsigned __attribute__((noinline))
-select_accel_cpuinfo(unsigned info)
-{
-    /* Array is sorted in order of algorithm preference. */
-    static const struct {
-        unsigned bit;
-        biz_accel_fn fn;
-    } all[] = {
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_zero_sse2,
 #ifdef CONFIG_AVX2_OPT
-        { CPUINFO_AVX2,    buffer_zero_avx2 },
+    buffer_zero_avx2,
 #endif
-        { CPUINFO_SSE2,    buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,  buffer_is_zero_int_ge256 },
-    };
-
-    for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
-        if (info & all[i].bit) {
-            buffer_is_zero_accel = all[i].fn;
-            return all[i].bit;
-        }
-    }
-    return 0;
-}
-
-static unsigned used_accel;
+};
+static unsigned accel_index;
 
 static void __attribute__((constructor)) init_accel(void)
 {
-    used_accel = select_accel_cpuinfo(cpuinfo_init());
+    unsigned info = cpuinfo_init();
+    unsigned index = (info & CPUINFO_SSE2 ? 1 : 0);
+
+#ifdef CONFIG_AVX2_OPT
+    if (info & CPUINFO_AVX2) {
+        index = 2;
+    }
+#endif
+
+    accel_index = index;
+    buffer_is_zero_accel = accel_table[index];
 }
 
 #define INIT_ACCEL NULL
 
 bool test_buffer_is_zero_next_accel(void)
 {
-    /*
-     * Accumulate the accelerators that we've already tested, and
-     * remove them from the set to test this round.  We'll get back
-     * a zero from select_accel_cpuinfo when there are no more.
-     */
-    unsigned used = select_accel_cpuinfo(cpuinfo & ~used_accel);
-    used_accel |= used;
-    return used;
+    if (accel_index != 0) {
+        buffer_is_zero_accel = accel_table[--accel_index];
+        return true;
+    }
+    return false;
 }
 #else
 bool test_buffer_is_zero_next_accel(void)
-- 
2.34.1


