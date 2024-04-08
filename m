Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC82CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8s-0002Kt-T5; Mon, 08 Apr 2024 13:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8V-0002B2-HU
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:29 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8S-0003qM-VQ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:26 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a2d248a2e1so3034345a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598623; x=1713203423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DA4w6vWBcl/o/fCPqKs/e8JAcC2+x8OTjBrtE2E7+xQ=;
 b=cgC6t8W++rsm4GL4DdBm2x4la/mNiP5CD1+N+vKqUhrhHmAyfgBPGhvWuRv8giGwLA
 kF1SlwafiwEIiJo4oJkTgOeN9Vy1JWtPnJzZ8DV6R7463IOfgytxHjYw8xLCdqZxkW57
 KCvl3HBN6bE2q/taxUeU2Uff6wt+Z+BSmswl2bTU21QoP1tsOzuDZDjbg5isiyqgHeBb
 TgRrgjDZ6uUT/W1vbkaJvECqbJS6oivPe4IfawZbCF/WnzVPkB9Pv4LS3z0R3edj+CAu
 Jn4u+UEPmouK9fvEhw7Xbad7BkmmFNcBtojxMkIbvlRLxixECS9mEVibD/UCJZ9q7ws2
 FCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598623; x=1713203423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DA4w6vWBcl/o/fCPqKs/e8JAcC2+x8OTjBrtE2E7+xQ=;
 b=DDfqBacFkJ0ht/xVA1lHf0nf4tIaqoCDytxAWmZ+7/s8AD/TW8qiJRKWhsOtdRkIs6
 t9moCIcRxF/XVS8bb/uAjgPZIKM75Tcb5uhCEty1Zea3Z53WHUqjfVozyEt7scI49B3X
 6RTeILVt5a6mB/fDU6JQVf14cq99pCoGDiRNQzRlTabbTxQGdzBcEpmDAbASZpyYFela
 DVmfJJxMdiPWSAGDHM+mnjQa3iRuC5Jdc/5sSwFTcoh2xRZQVWcbpwjTzxQwkgke+N6C
 4P7LZoJZrr1A2eecZofjcGX7obHXeg1i36HbSjRPBsQ+Oci7zpeYyFwa4EQmCWG/lx9M
 iRjg==
X-Gm-Message-State: AOJu0YyUHvFELsCcpZ3zTeqvlE7IiDGgk1v+BEo20TAC9nuoQ80NKjHA
 abFsM2f2zlYswSZX70u3zEtYBDomnra1J4HCO9LpadCxWLhAmKnL1ys/a11wWwlgGY9Xu9x5U67
 E
X-Google-Smtp-Source: AGHT+IGh2zBQzIOIx0Bp0nDudYdGEyajL48EphKT4LwZ4YIVhHK5OYUIE5z8ANMj2z08EKto03klyw==
X-Received: by 2002:a17:90b:4a12:b0:29f:76d4:306a with SMTP id
 kk18-20020a17090b4a1200b0029f76d4306amr469099pjb.24.1712598623420; 
 Mon, 08 Apr 2024 10:50:23 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/35] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
Date: Mon,  8 Apr 2024 07:49:29 -1000
Message-Id: <20240408174929.862917-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Because the three alternatives are monotonic, we don't
need to keep a couple of bitmasks, just identify the
strongest alternative at startup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 56 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index eb8030a3f0..ff003dc40e 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -179,51 +179,39 @@ buffer_zero_avx2(const void *buf, size_t len)
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


