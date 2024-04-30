Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590E0C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNb-00074c-KL; Tue, 30 Apr 2024 15:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNa-00073p-0Y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:06 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNX-0006lC-DN
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:04 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-234db9dde9bso2541710fac.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506182; x=1715110982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZeDc+rGPQ24e0m555YcdhuR3YwVPpI0p6P9+s6hA88=;
 b=C/g84SjjRBUlvu6UltOh8AGqIpezWPyrh8XldhnZh5bHOmZkib9fstVJp3xfdZWSPj
 Fxb38lj3vxHesNT1TZt68lsc7jkyy9xuMQvLLYHfchReWzV2CLP/vugGgwXpiwpJIiRC
 94/nWQ1ZZM50R/EgG+KLPSzIykk3+Cx1XgXS8qjl2MdvSViXxGaflAbY/mrdiCvJo1Kt
 qezumWvMAcRBUD5MmMBaBLWQfRhORle+r52KqYQFU0+/N3er2HXEVfnTDRGP3nHEAybJ
 VUq6CBuPPRl11Yo74bvYk6NFEJxjZ5wMlAJFSCPJr67n0WOIxgPLrwdr9IoppCa2q4qd
 dOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506182; x=1715110982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZeDc+rGPQ24e0m555YcdhuR3YwVPpI0p6P9+s6hA88=;
 b=fZVirYqv05Br5lh2IvsVpP3VGIXy528Ved7HLl2wdmJqzNuVsyltfOzPLXptqWYJbt
 cvyLefOzft756o70GgfN4A5Oav/cLWj71elKowvGrKKXmOnntKPGawA8cQOPcAuJ0+9X
 DSIORiis5fSh8/sivZfiKLmH/lv7oZYf0A1VF6yy5Pq/04IgY95wWMDiDVmHYM0G8v/R
 vi6vsrhJW6n8VWqn5qkzJs6cYBEuNjolfMGELV4s8JSI2/00CCeg56Xg5bECBeTi+tFE
 HxRUXTEs5rmOCycO2A/KaLZ2AQk+aHtHJumwjLO2mG+kAqxxnlpBF27lw5oJTNVPmg1I
 QbDw==
X-Gm-Message-State: AOJu0YwKy9PgRKs0emUyQYwlF75ycCN0851COE+ZHUj0IadFEYWw02qM
 SNQSdSXVDY5zCXsS66d2TcayPgevIUt57fUm2F1xUWrfHt5AVoDBucuiaE7xUXBnbf1y3wHeoNU
 L
X-Google-Smtp-Source: AGHT+IGp8sBIP44JchRabfRi/cIPD9nyJoYQBmX5ehvtgkZHU2aWJkE7NGFKw5AjA3fGJEIsG/al1A==
X-Received: by 2002:a05:6870:f22a:b0:220:873d:dbcc with SMTP id
 t42-20020a056870f22a00b00220873ddbccmr566264oao.49.1714506182119; 
 Tue, 30 Apr 2024 12:43:02 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:43:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v7 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
Date: Tue, 30 Apr 2024 12:42:51 -0700
Message-Id: <20240430194253.904768-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430194253.904768-1-richard.henderson@linaro.org>
References: <20240430194253.904768-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Because the three alternatives are monotonic, we don't need
to keep a couple of bitmasks, just identify the strongest
alternative at startup.

Generalize test_buffer_is_zero_next_accel and init_accel
by always defining an accel_table array.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 81 ++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index f9af7841ba..7218154a13 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -27,7 +27,6 @@
 #include "host/cpuinfo.h"
 
 typedef bool (*biz_accel_fn)(const void *, size_t);
-static biz_accel_fn buffer_is_zero_accel;
 
 static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
@@ -179,60 +178,35 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
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
+};
 
-    for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
-        if (info & all[i].bit) {
-            buffer_is_zero_accel = all[i].fn;
-            return all[i].bit;
-        }
+static unsigned best_accel(void)
+{
+    unsigned info = cpuinfo_init();
+
+#ifdef CONFIG_AVX2_OPT
+    if (info & CPUINFO_AVX2) {
+        return 2;
     }
-    return 0;
+#endif
+    return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
-static unsigned used_accel;
-
-static void __attribute__((constructor)) init_accel(void)
-{
-    used_accel = select_accel_cpuinfo(cpuinfo_init());
-}
-
-#define INIT_ACCEL NULL
-
-bool test_buffer_is_zero_next_accel(void)
-{
-    /*
-     * Accumulate the accelerators that we've already tested, and
-     * remove them from the set to test this round.  We'll get back
-     * a zero from select_accel_cpuinfo when there are no more.
-     */
-    unsigned used = select_accel_cpuinfo(cpuinfo & ~used_accel);
-    used_accel |= used;
-    return used;
-}
 #else
-bool test_buffer_is_zero_next_accel(void)
-{
-    return false;
-}
-
-#define INIT_ACCEL buffer_is_zero_int_ge256
+#define best_accel() 0
+static biz_accel_fn const accel_table[1] = {
+    buffer_is_zero_int_ge256
+};
 #endif
 
-static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel;
+static unsigned accel_index;
 
 bool buffer_is_zero_ool(const void *buf, size_t len)
 {
@@ -257,3 +231,18 @@ bool buffer_is_zero_ge256(const void *buf, size_t len)
 {
     return buffer_is_zero_accel(buf, len);
 }
+
+bool test_buffer_is_zero_next_accel(void)
+{
+    if (accel_index != 0) {
+        buffer_is_zero_accel = accel_table[--accel_index];
+        return true;
+    }
+    return false;
+}
+
+static void __attribute__((constructor)) init_accel(void)
+{
+    accel_index = best_accel();
+    buffer_is_zero_accel = accel_table[accel_index];
+}
-- 
2.34.1


