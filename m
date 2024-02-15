Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F3CC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWuA-0007kI-AF; Thu, 15 Feb 2024 03:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtd-0007Cy-Dw
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:06 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtb-0001QN-MG
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:05 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-290da27f597so466759a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984902; x=1708589702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GT2gVjPR6SgaNO/ooCzaomL/QLce0sgZc8b20aaRw0g=;
 b=H+gbamLFlmM9NNvGzN2OwVWi3rlwwOWLdtjbkxG3rf/w2aJi26BM0tr/uNz6AWpt6U
 nhKXY79JVXI+li093NB6VSQngNLpJCDxQ+2V4B+4dCsKmzIxevUb8/hR9Ts2h/tF4NXU
 qCr6ItTWiKxCe4l5qejFJ9Dq+Iz3mmoFuSQwdMD3xRuP9ixzpE82VpLCYnsOCbNA7t2m
 0Xy/p1MdS41vH6/v+sqz5mJiZ55/EVmbl0L5tujA+ZWgNcAcfhfcddUa/4Vkal1k1WrZ
 Ih0v+aBCdEM/erSNBHHT6vKy50lccG9FHNwlE5nkwr7Ay2TNX/M69oBEBkneHS2fEL+P
 2cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984902; x=1708589702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GT2gVjPR6SgaNO/ooCzaomL/QLce0sgZc8b20aaRw0g=;
 b=vB+CrLX21LwR9Kukz8gPN2kL0eJczYxbQessVT2ZUE4uY89yxl3pIIxcQEyvMnZU3H
 KPp4GcIzcFu+iKBsgDT2kycfKgzSNOj8qfXqH/y9PzWdQ29jQA7I3zX8rVNbuEPs2Ht/
 m9hIi2+3Fn52YGt3Uz8heikkEkyHcasaeIZy0jtmr7jIYv2YpJzfsjh+guHt+ZJF5d0y
 tRLT0mc+QftGvOecp5jL2sV/nLMXUNj3JexULX2Y141waS60R/qCP+GE+lDrmQCRCUdz
 W4dfhkBWhKbko4wiabPRHBIvkTOXNLQkNsjGassoCVh7ba5Ft8CuAsWsQyKhplvpAlxb
 GZVQ==
X-Gm-Message-State: AOJu0YzromjsVXG/W8EvVtMjBPOJ+pqmE0qZcTa8QR+mZyFvh1Y/8qYW
 omaxvgeGzegkvGGXRpzyyuY7BL3t9qLBa5JDrvo7VDMOJdmujzIU27kKt7BUuCRYqoW3HISKZNN
 U
X-Google-Smtp-Source: AGHT+IEFgp/lcu2AAGdZFAR7JBo2Wf+vbs81VYylavDSIm699qxyozPRLot3mcOks9CPBJKa7XFjTQ==
X-Received: by 2002:a17:90b:1642:b0:299:165:b429 with SMTP id
 il2-20020a17090b164200b002990165b429mr963156pjb.23.1707984902259; 
 Thu, 15 Feb 2024 00:15:02 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:15:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
Date: Wed, 14 Feb 2024 22:14:47 -1000
Message-Id: <20240215081449.848220-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index ce80713071..4eef6d47bc 100644
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


