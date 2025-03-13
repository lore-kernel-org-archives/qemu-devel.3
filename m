Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6B5C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZVy-0004bK-VP; Wed, 12 Mar 2025 23:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVx-0004av-QL
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:45 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVp-0007lc-21
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:45 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so1172659a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837533; x=1742442333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTz0opqvxfbqwvltJvZBi8g6Tk2gJy+3YsapeLlujac=;
 b=j2zfo2qQCArmW5qUnQSmYKqoN+A0HDguUp5A4xcXSWi64Z3uXOrCpacGhBYzc+YXa6
 Tic1/UGnqYAIwAvAwdwYUvmmDJ7Hp+rP7TU1G8IpGhVWgDtqdE0hS5RiMEKYjM8JrLBm
 f5urjq5OOi9wEhASlpnU27T53VNFwCXgMyPdBlpiQg3gQgaF2f6EjE0t/nz4zFHNVLVN
 0E2pu7sQZ/pNoWfJUE6pm+EXADAhsSFbilgW0qM2v6TPZrPBX1kRopYb8U75h+ULvyiw
 HE7ILPXebVAvVpV15BKf9r0R708YdUQzc2R3vX8bG7WWKQtrj4moxcgeKczfLvs7bMru
 9fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837533; x=1742442333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTz0opqvxfbqwvltJvZBi8g6Tk2gJy+3YsapeLlujac=;
 b=Fl4OS4P9lPy2Aw08FEH7QjTJQjwCjYCI9RoifteCoyjsr81OZVymoKyQwrmZyVW2sv
 DEXcM1yLYa8eXNvzQwyVvpwb0PeWnHhAT2m+y6IOuzyYxbOF6tq0EahrNhvnwh/XhDtQ
 izsEkMbgHv+9XHBzk5tBXPX1z2VuLF69kyKtiSLB9V3RuEXH/+Jr5S/c5BoZdN2vi2EW
 LPAVIfjdQ6iHVXawuWvxizYmvuIqql/F8aSxuCgw89qhWV064HKgiDiF7slcjJI4rTwq
 8ZRJuwW2Xg3heYLSRPsMvlwnMGQZ5aZVsgu4W/t5fDqHkWpIGnXF8e1SY9SKr2nlRZuX
 0+IA==
X-Gm-Message-State: AOJu0Yz7yWRAQ9AHBYV9cD50r/8r0x0xTxGZTs80utWaw/Ns0TDnxcNi
 3z/ElELzBtSFM+NKX6e/45uHryddsLdioJ5M27hUkZFVM2pSRN28agjn2K/Me5bpIHZ7pO1N0DF
 S
X-Gm-Gg: ASbGncszkGHmvSk3UQ0oOKQRt5zeSAvdrjqom4pyXJCdT2osV5BxmYNYHwtypk/zkYZ
 t1HkW0Y3BYd84o9UN+C0vHZ328ZIk6m2Y8u7ADfrFEmr9pSXuuxFNxk/Gk3G9gUJ9yZpD2sbPQR
 YGitgNPEYAqlI1lqrPXH8uLp/r9fYSYXe60Dc6xIk2Y8rLN1gtSZ4JAlT2ix6tnBxiF71oqEiJG
 BcKVk4ZRFF133i46tZTCJcCs4JakKm/5goeuW1dsdtJlHmsAYZq5/FNk/eHYXz4WKPZHWOzWRaq
 Wev275V4kKBF1cLX4Zrq3fiXJht7B9HBZmpZddhhoSEfhCmx5HwLUxsy9hzOUYZ/AANFIWoW4tO
 X
X-Google-Smtp-Source: AGHT+IG/2nHTL2ulvhNi6w6c2ylL2+m4IfJPtPwj/c3lDR+LGYUFuJVtrPdbt/37xjfKWzbymtcEkA==
X-Received: by 2002:a05:6a21:158c:b0:1f5:837b:1868 with SMTP id
 adf61e73a8af0-1f5837b1902mr21097964637.29.1741837533461; 
 Wed, 12 Mar 2025 20:45:33 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 09/37] accel/tcg: Perform aligned atomic reads in translator_ld
Date: Wed, 12 Mar 2025 20:44:49 -0700
Message-ID: <20250313034524.3069690-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Perform aligned atomic reads in translator_ld, if possible.
According to

https://lore.kernel.org/qemu-devel/20240607101403.1109-1-jim.shu@sifive.com/

this is required for RISC-V Ziccif.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ef1538b4fc..0260fb1915 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -265,12 +265,14 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
 
     if (likely(((base ^ last) & TARGET_PAGE_MASK) == 0)) {
         /* Entire read is from the first page. */
-        memcpy(dest, host + (pc - base), len);
-        return true;
+        goto do_read;
     }
 
     if (unlikely(((base ^ pc) & TARGET_PAGE_MASK) == 0)) {
-        /* Read begins on the first page and extends to the second. */
+        /*
+         * Read begins on the first page and extends to the second.
+         * The unaligned read is never atomic.
+         */
         size_t len0 = -(pc | TARGET_PAGE_MASK);
         memcpy(dest, host + (pc - base), len0);
         pc += len0;
@@ -329,7 +331,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
         host = db->host_addr[1];
     }
 
-    memcpy(dest, host + (pc - base), len);
+ do_read:
+    /*
+     * Assume aligned reads should be atomic, if possible.
+     * We're not in a position to jump out with EXCP_ATOMIC.
+     */
+    host += pc - base;
+    switch (len) {
+    case 2:
+        if (QEMU_IS_ALIGNED(pc, 2)) {
+            uint16_t t = qatomic_read((uint16_t *)host);
+            stw_he_p(dest, t);
+            return true;
+        }
+        break;
+    case 4:
+        if (QEMU_IS_ALIGNED(pc, 4)) {
+            uint32_t t = qatomic_read((uint32_t *)host);
+            stl_he_p(dest, t);
+            return true;
+        }
+        break;
+#ifdef CONFIG_ATOMIC64
+    case 8:
+        if (QEMU_IS_ALIGNED(pc, 8)) {
+            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
+            stl_he_p(dest, t);
+            return true;
+        }
+        break;
+#endif
+    }
+    /* Unaligned or partial read from the second page is not atomic. */
+    memcpy(dest, host, len);
     return true;
 }
 
-- 
2.43.0


