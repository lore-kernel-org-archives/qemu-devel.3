Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4687C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQI-00074M-ST; Fri, 12 Apr 2024 03:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQF-00073M-M2
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ0-00075y-Vg
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e455b630acso3259055ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907231; x=1713512031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rvakkgiyK54UTlLULBlH8+XzGitioxqA6YEQltyd0/U=;
 b=hKhneatP3JxefFbpSjx+2RsvWTzNmgAROrGwt10PAYaGUGnMYQqWju2IjtD9lhLw3G
 3cDQz/YzF6IzIA8A0R9etF06dNM9pgKspsuTBfWNaaM1KydQN9NlpqtmDzDb0CZ8mqAn
 U76MfmrFD+Ap72LpiwR+B/cbzmO2PHW8IokQ/IgPZvCf1RaaaOzYoRlb2dOXKA1iizyu
 BBlcChnOFfg8nB5yBMSmJnXyHZxWhyHW1w1OoxXxmjbqWc9hxNzgqN9Y1b25WvUUmCyB
 7lLm9SKdutRX8ZmHrw7FiSmo019YHbAnbauSkIiUsOiL7LZbYZjDVBAn4bZWx0UmrxoI
 jXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907231; x=1713512031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvakkgiyK54UTlLULBlH8+XzGitioxqA6YEQltyd0/U=;
 b=of0EQwyglxxM+qxmUejj1hXznes6C+R7D+0lJZ2GtRN0dNZAonisC5zuLwphzyO4zN
 vXSwah4VW2k4+BVQojV1Ffrvyi9Lg6XhqHbjPims897OK3AAcF8qNWMOeP4R8gnOJjfX
 w5wbEsoqub2sVxPZO4y4ELtan6lLydB2Ggv6RvuO4Zw6dDA8zb38qMAew8e5aK5hnUBS
 A1U+2xuJ+1MUMX2OyRClLscLX3SOIb3RK4bZDqTD6q94bqcqeBxXvF0S3Ub+RaQ4BuNj
 a4AaZD/+uQ4zzpjCBO2ISX6XodlPuFKfEfMhUOjV5UFYKcytVmy8YXmxNcDFvavUrxct
 Wbew==
X-Gm-Message-State: AOJu0YyZodsSI2NWI/H6qC/YsFp+0KH0WpxAHPykF5m9WwMDOFEMzVz4
 7HcinVxXdV8+eSi8zLMmZJbPrIJblIGBtP1QPJRUO4F1wBw6CTiJt5owH9s6FEj805sYoW9oY5s
 i
X-Google-Smtp-Source: AGHT+IGb66LroTK49OZTU7Mt0yOPDcjzDGRZNIr4HEmn0XXOQl9Lzcvpin+8kCao63rM1+deY7WWxw==
X-Received: by 2002:a17:902:6f16:b0:1e5:3c5:55a5 with SMTP id
 w22-20020a1709026f1600b001e503c555a5mr1557546plk.8.1712907231562; 
 Fri, 12 Apr 2024 00:33:51 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/27] util/hexdump: Inline g_string_append_printf "%02x"
Date: Fri, 12 Apr 2024 00:33:24 -0700
Message-Id: <20240412073346.458116-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Trivial arithmetic can be used for emitting the nibbles,
rather than full-blown printf formatting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/hexdump.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/util/hexdump.c b/util/hexdump.c
index b29326b7f2..ae0d4992dc 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,6 +16,11 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
+static inline char hexdump_nibble(unsigned x)
+{
+    return (x < 10 ? '0' : 'a' - 10) + x;
+}
+
 GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
                            size_t unit_len, size_t block_len)
 {
@@ -35,6 +40,8 @@ GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
     }
 
     for (u = 0, b = 0; len; u++, b++, len--, buf++) {
+        uint8_t c;
+
         if (unit_len && u == unit_len) {
             g_string_append_c(str, ' ');
             u = 0;
@@ -43,7 +50,10 @@ GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
             g_string_append_c(str, ' ');
             b = 0;
         }
-        g_string_append_printf(str, "%02x", *buf);
+
+        c = *buf;
+        g_string_append_c(str, hexdump_nibble(c / 16));
+        g_string_append_c(str, hexdump_nibble(c % 16));
     }
 
     return str;
-- 
2.34.1


