Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1906C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksf-0000cI-5M; Wed, 23 Apr 2025 20:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015a-So
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqE-0004jn-QG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so369429b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456005; x=1746060805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOOwFzTm67uo3oPX6s2weGo0GWckaSTCY9AaRBdOnWQ=;
 b=DevLiO5iHiCoj/BkCmBtDp16WufjkcAYFDUZVxEvjxP1De1dal6FcGoUHa/UH8oB1r
 yEhrjac/pctmX7HfgQY0GfstXwAwmblr/YShOGC3R7AJjCtJcbbA5rNjT7IbN59A8Oa7
 OrqjcRAXMEI/Xc+XdCh9tt3HtgjijeT3dsl6BTPOs+2c9Aiwrhx3tlwJY2+fLlaXqSfm
 f7KM6aKAZumryMSo2NvLzaHCbkjJZhN0z+2zXTpeG8oOFRZvduQFEGG1SDz+BOIoDy6q
 WwoWEl4Vl6tYdektAwxFv2OCk3PlpuCqN2NkGT1X0N36O7vQ8G49FpUN3g4NHS1AwWQ/
 18Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456005; x=1746060805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOOwFzTm67uo3oPX6s2weGo0GWckaSTCY9AaRBdOnWQ=;
 b=R13b4yMsQj4Kz0iwKjWeKecr+m2IG67BQ/qx63AaPn3SoOa+NJoDM8Z581yRq/oNC3
 kFg+xsaDl3G7ekLhZXzRaBi6aG5tCHLDd/rm6UJUg7pOjT3/BtmRGJuBVZshu+QjAKwP
 jX3oWe1tZ4bpFXjMAZNbtWCpH6AHOPC+5NzeyGzlKvHRzjv7SWtxL6NAM4OIXWzfm+1f
 k9+eYk36/qGpxsSQnphprOg+n/Rm6UZoottuyJ/GFB+FzX5NLR2Jg7N7z4I459HgxgqX
 z9kjW0mFUfD7mFOGKSwt4SKgYPEdWLVYmgMAZyXHxdE29slgVJaXu/5++Kgot2XA76gT
 7iiQ==
X-Gm-Message-State: AOJu0Ywv/YCGSbbiHWSvrIGnyq8LXefrXhy/HCzanhWhOl+lxdn7d8sy
 6JM86gefTjyr/yZe6sTt2aUAM5N/Ds/P0beX3Oq8rvQSOi7W5WxgGAW3cQeeoZHwth9mjxGSrsB
 1
X-Gm-Gg: ASbGnct7fct0962435YXQZCbUVbDoZskSlo9TcZU+aCVDZLGT2/yzrO7MTjGazAjyrU
 48C5TK7gbItorpALosR7y7LoW5TYArxHy7fMOXZ+5a/O1m4tHBr6jYo6IQk4WezCiKhv6awhzpt
 oxPMUFmolUdr1+Go1szy11+boudZPEfwuhjkZQJzjMjpzSxYeaBZUpUU6QUi5ewjYtXTtPk1dgD
 IAF46k50Tpa/rgOGOha6uMzhZc0BAuJX9da+cYU1qUKJYQnK65Le9eFzQwE7bdowMYf6s9VfnnD
 Gys49fkQ1KZw8pAhXJF+agBDXBw5uXQ5Nd0op0P2Hjj2UBYxIE4Mphgr+49K2pdqV68OgK/oNvQ
 =
X-Google-Smtp-Source: AGHT+IGB04EYQ2sGDUkBror4Du2sEj5BJvgEH7OGGiAoj9AjpjEwIgfGQutv8/GE27KZPsznrjjOIg==
X-Received: by 2002:a05:6a20:439f:b0:1f5:8655:3282 with SMTP id
 adf61e73a8af0-20444fde923mr691177637.42.1745456005299; 
 Wed, 23 Apr 2025 17:53:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 066/148] include/exec: Move TLB_MMIO,
 TLB_DISCARD_WRITE to slow flags
Date: Wed, 23 Apr 2025 17:48:11 -0700
Message-ID: <20250424004934.598783-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Recover two bits from the inline flags.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-flags.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index a0e51a4b37..54a6bae768 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -53,20 +53,15 @@
  * contain the page physical address.
  */
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
-/* Set if TLB entry is an IO callback.  */
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
-/* Set if TLB entry writes ignored.  */
-#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
 /* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
-#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
+#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 3))
 
 /*
  * Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
 #define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
 
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
@@ -78,8 +73,14 @@
 #define TLB_WATCHPOINT       (1 << 1)
 /* Set if TLB entry requires aligned accesses.  */
 #define TLB_CHECK_ALIGNED    (1 << 2)
+/* Set if TLB entry writes ignored.  */
+#define TLB_DISCARD_WRITE    (1 << 3)
+/* Set if TLB entry is an IO callback.  */
+#define TLB_MMIO             (1 << 4)
 
-#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
+#define TLB_SLOW_FLAGS_MASK \
+    (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
+     TLB_DISCARD_WRITE | TLB_MMIO)
 
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
-- 
2.43.0


