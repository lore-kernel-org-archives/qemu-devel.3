Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F849C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYE-0001P0-JG; Tue, 18 Mar 2025 17:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXu-0001FU-Kv
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXs-0000kb-2i
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225df540edcso1783245ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333538; x=1742938338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcMEdfq6hiU3L5D0NgU/JReS9ixFpwCT7tXsb8tm0s8=;
 b=zzCLapjIDS6MGG24zs8kMWcaZGDsoS7RoLmjMNKZNLtfC6zrze7zN6JtZ3CrH6ybou
 7T9AFtNqR3ZyYr2/KmTeaZ7ZJpcxlAEYP/qFfXyLfJtCsBtcyVGXf9KPoEMs3HnF6ztn
 awGihH7ECZQyauEvR2bHAVEJFecP9w4BTss1UKd9MM667IfeISZld9gAnXm0LbKwGD2C
 WsYsyjLoZrDApzad2XOLzW6eNn1deVpZ+D8K+S93XITKEdtX2NUUyRz9srikfJGTb11G
 FKA25MU/JIBahsIjsplrAtph7EEOii1+fgUjAaeXcVwTWSdJEiOipLwVBlwO+rxNsYaf
 K5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333538; x=1742938338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcMEdfq6hiU3L5D0NgU/JReS9ixFpwCT7tXsb8tm0s8=;
 b=Co0B8U6szAEYEjB1XhDdI33atB11crhXp7aFyzWynsJCBtA1SFqhmlj3bF290g1cCu
 j2AaitUdgMHAsnl57dYzveaQIFik/BIuwZFzvDbDJ+l+V7eqVXuuZL7uKp7DEL5xfuhz
 2X2Y9PDt+7BNXNfeJBCVlVCdKhMVtBcEV/zcByCThWYV+iKboXn76qungyL3tlQG25r5
 E777LZFpuKB2rAB3NhM4yOetV+/XMZsu/ZyaKJk7BtYnV3vzAnhQTHjCWh2YzRKS4+BI
 Ubvf0Rs37BC7DJL38bniEIxzPJDxBnt/gDndR00/4ZZMIL4qaNWWkjFNloajP8hNXYvS
 Utcg==
X-Gm-Message-State: AOJu0YyHPs0TwaxZLW82QctoAtYbTcwksMOsO2GkOk94owgyO6y5arsE
 wEh6XFhN4p7mgIdJAhRdxaR0cB2hLlW9M4o9ZtJNMTrzqt/BgTNxsGJEkp0C/AavDfavRRhuTL1
 a
X-Gm-Gg: ASbGncuBQtNRRHSNE+vgTY1Zv/b8FYaY8JWujIfZ+cHiIrzOf4GHaXeAag2zS1OATSe
 mnaUhbWUlYuRcAxVumluESbhYOuQG9POL9F92c5NM6RGIwyYsKhegrUb1C2fekbmh+5M+xDwCk2
 sUCBaT1IqILh/q2MUuW1el5tvcyycZv8uY26xhbeyz6SPT29tXrGBjbQUNnnWFu8RJ65Mwp2RRw
 pidFyvLl3xbYdcSJ7jiBtHYgLm6e/vT4jgvkZUURifVR61BN8f5uasC93ncPCb6dkqTjGeMvYpT
 1thuue56GDFBsJIsFWZ4UnZrxYTBA6JGFXVKJ87Ts5QL7nnvcPzyDuLZJBSfG9nqE2upaG0GULj
 G
X-Google-Smtp-Source: AGHT+IFUDmbBRSXI81qAm8dWYvW3ZroxqqbJ3NF4m2VHiBfuTgUkPu69OMPovaZ0cAoCxxyaazLcnA==
X-Received: by 2002:a05:6a00:6813:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-7375778c95fmr7261989b3a.5.1742333538281; 
 Tue, 18 Mar 2025 14:32:18 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 11/42] accel/tcg: Perform aligned atomic reads in
 translator_ld
Date: Tue, 18 Mar 2025 14:31:36 -0700
Message-ID: <20250318213209.2579218-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Perform aligned atomic reads in translator_ld, if possible.
According to

https://lore.kernel.org/qemu-devel/20240607101403.1109-1-jim.shu@sifive.com/

this is required for RISC-V Ziccif.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ef1538b4fc..157be33bf6 100644
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
+            stq_he_p(dest, t);
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


