Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62543D6CFAA
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2uB-0006b7-05; Thu, 22 Jan 2026 17:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2u9-0006a9-Ji
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:53 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2u8-0003N0-4y
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so17660525e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119910; x=1769724710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP/MTK8KNSVzyu6zuIe3MwXkpcWMuvGz5r3wnr6DkDY=;
 b=EsqReTOrxgGSAFmYhE9WuZ4ucve99hX+kpPfHnSkuUzc4tLU+eCWT5AYZOM2XRxDxw
 90AE087KPqGYJj42zHkcbuFu8FlzBZkW3RiZT415UZAon55x9sbosL7Bl5K+M8f1p8Vw
 yHX06bsMysbDEOhC2LF0G2zY653nZlGVV/MaLl0rlFuibYzMdR5kYDkWST8zk+jP74vv
 O6+63wArD8WtlsBEZ9b24oiEp4p4i+48ezfJxcC5+gbbk+a/QmLh6gWzhUUI6gMcJbha
 OL52dE3vajX1wnl30+HeoCeHEU9SeO9n9fgEfLqWufRbR9hh+X7L9nM4p1Z9O6X0uxyH
 +9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119910; x=1769724710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RP/MTK8KNSVzyu6zuIe3MwXkpcWMuvGz5r3wnr6DkDY=;
 b=ZDe8q692a/mokh2PqIvnLCZJqDx5Iwq7hLz4RbJAKszYXE9A+TElWqEl732eZ9l7MG
 kFHtBHZnvzZgIB6UqzSdeahg3k5ttEB73p8tJSgUydMjW7qZSowX6AaQzIkaktoDFYzn
 M5OW7pZoBKJTwteJ8ynORleMKB0pmFHJwO1G2uCpDpvrpGYRTY4yIIxCZ/ZT0ZVn8j+n
 9CARIc4FHuFXy1Kvc8xPtjdXwuv2Bynd7KA3Ff+Bo/v06x2gti9E0ORQwc7NAOD01a+V
 3SuYh+pU3Dc3M+MOd1GiBhEbnihWt6gSwC8FXYamrG/cylkLQxPt7J6mnmkt9iz6mJCw
 mZ3w==
X-Gm-Message-State: AOJu0Yza/l4x/J0GK+dewb2/e+z7ULDQmi9ueAv1euo2h1x9dzN1j0KJ
 jSvemeSRWuiVbkXQH+qp2d7/5Kk7MaCWwILk7UKQOENH6HQMUJpd5cUDB9BAe49Omo8NMJAfHKQ
 zCEvX7Ko=
X-Gm-Gg: AZuq6aKTdOuCl3t2BjViWKmZLkTTCw21Xg+cm9qMH1ciisuXzMaKQQAxY0PZIDQXnoB
 eYJlETT+1pHPKAGW5UXYwsTh7cExrzrzLeAJ5zxnx9L86vqOlAD2Vv3CnHvS3LYoJMtJUdoEm2G
 FR41M7oZ74c43zEq+kq5F4y8/o+PXSs/Aq8DX5iG+s0MluFMvDBdpMMyVwZizYC1mTSL1JfqP/1
 zBkQTqM4QWloErRdJW277PHkXqaf3/WzlDy1dRQYSjmr/0fDS7IEXwJHlhgrZVe7MV4hovuphQm
 +rlrt7nxDHvooUfM/f3y1ch5/c+/VIjbJ5KM7H7jGE34XIO+hI7M/MHZiZcDktO5n9iUGnO5gBR
 U1Uc4jQfJYwxtpoEQMxQh8YIJy37oZ8XHhm0/icL4ftP7Mh7l4miv86WHx9Va6HUmBP0EeyUtGK
 d00H2AH5czW/LF3ThCkW7gu/gn5MOiRNPF72jB6AgobaefkL5FYFULmgPKhE8U
X-Received: by 2002:a05:600c:4e15:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-4804c9ce9c8mr15223215e9.27.1769119910375; 
 Thu, 22 Jan 2026 14:11:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470bfe42sm92326415e9.9.2026.01.22.14.11.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:11:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 06/11] target/ppc: Introduce ppc_code_endian() helper
Date: Thu, 22 Jan 2026 23:11:00 +0100
Message-ID: <20260122221106.57184-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Introduce the ppc_code_endian() helper which returns the
MemOp endianness for the CODE path.

Use it in need_byteswap(), removing one TARGET_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 17e6d07c8c2..4a9199a4473 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -214,14 +214,15 @@ static inline bool is_ppe(const DisasContext *ctx)
     return !!(ctx->flags & POWERPC_FLAG_PPE42);
 }
 
+static inline MemOp ppc_code_endian(const DisasContext *ctx)
+{
+    return MO_BE ^ (ctx->le_mode * MO_BSWAP);
+}
+
 /* Return true iff byteswap is needed in a scalar memop */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
-#if TARGET_BIG_ENDIAN
-     return ctx->le_mode;
-#else
-     return !ctx->le_mode;
-#endif
+    return ppc_code_endian(ctx) != MO_TE;
 }
 
 /* True when active word size < size of target_long.  */
-- 
2.52.0


