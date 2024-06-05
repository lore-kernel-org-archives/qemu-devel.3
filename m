Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E75CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz0-0000eJ-Gs; Wed, 05 Jun 2024 17:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyt-0000cA-4y
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyi-0003PI-8E
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-703ed15b273so231564b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622126; x=1718226926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtdfLvGNq7oKYg7RFoNL4PoVXIIUjVrx0tqYusGM3x8=;
 b=W/vBvgb6b9uNTvDGoTZk04dmdVx4wQFRskozZSwCg02r5VhMJZyr9eNFE4/+D9vilY
 BETNF5yQSMt67uTArEYYDhj8sSj7FXhJR3Tljq94QI0BeNlyTGGGmnCdHrlg/wcdFv47
 fZrGEFSeHkjR6RnQOgl086v0jrAkNeQUmeUisP7mUB2rRzvOFJZLOX+XtfXM3kNsFoU3
 o5qFxw2fq1RLh9IAuOJ7tIrSR7cztQ6MbR/8t2Ek2gnst9iKeb4U+GFkJN74qxDdqkxw
 c8BpuRnJCs6oWahYmw7C84aYJLmtBA4qJbE96qlPmUImeXnR1I0aMZP0Zox3VCrjwDJw
 1SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622126; x=1718226926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtdfLvGNq7oKYg7RFoNL4PoVXIIUjVrx0tqYusGM3x8=;
 b=mbw7U6YVBOkqbO6jF24eOEyzojZdTFTMx0yGemha1+S1J+0/IfsZjRVPCys9KoYh6n
 YM+W/andBCcaMfMDk+lJwOcfFxVWl8VBoyuE1QqAXkI5TmyZmITUsxCEtIr5y7SeFsT6
 b8n/a2DVWb9yL8JTnwnGIS371OyF34EsXc8XDlMAsIQXGS9bP42jZgJgPl240O7KzDsx
 9gHWLpevxiZ9dKSqKWuvnwEfm526ZEm3HUtISM8jZxsE1rcbXwG1u1iYmKPoqBj6ey/M
 WizXGm7YvZ2sC9LZaEyzmPEjFpKtu4JeSNGzOrWHNdYE8SCkRUr17/yc5pEA4z57ve0A
 pFSw==
X-Gm-Message-State: AOJu0Yy2XlAOPtT8z5hPhStVO751b5ewI8arHU6S2tKG4xcjLBA42FGf
 mUOWoEzy5yQRFs/z65pdcUAF6pGg5swyRgHsJhr+etbXYvJ42MlBVTS8oiGOjtdJp8d4ZQUcP3/
 j
X-Google-Smtp-Source: AGHT+IEDSFRASxD4iWxkLYvcYKFyGBtW8uCWKI0ODsayzvmV+rmrf4Qb7VpRctFqvpnfeboh54MkjA==
X-Received: by 2002:a05:6a21:3998:b0:1b2:2ed2:b80a with SMTP id
 adf61e73a8af0-1b2b76374f4mr4477852637.61.1717622125595; 
 Wed, 05 Jun 2024 14:15:25 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/16] util/hexdump: Inline g_string_append_printf "%02x"
Date: Wed,  5 Jun 2024 14:15:08 -0700
Message-Id: <20240605211521.577094-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Trivial arithmetic can be used for emitting the nibbles,
rather than full-blown printf formatting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240412073346.458116-6-richard.henderson@linaro.org>
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


