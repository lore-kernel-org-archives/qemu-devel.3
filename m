Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02242CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwWm-0003OP-ON; Fri, 31 Oct 2025 17:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwWk-0003ND-U7
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:19:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwWc-0002KD-Eu
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:19:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429bf011e6cso1369135f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945545; x=1762550345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dtB18Pvc9S14eiCOzWzreWzk+lt1hMQZD4T89jMibmU=;
 b=R/pQ2lNJcbHCGD6uCCLT4NHuafClw0Bp2meOR+G642VeyWv33e0LzByaRWqiDyCBgV
 L+JioqpniR3dg2pbmVmNGlbxMGXZZ8kYJkAj9HqpzgjrSyWOy2qZ/CUOm+HlKFx7Z+yL
 H0RKa1daISjeY+um126yWnoX7Jz2uWs8cuxAcUH6gvea4ky/ZuvXOloGAeYEjqssIp5i
 UnoVNSFpcCKZTCSyU9vKn1Dw0YwO/sSpjlozZmegUU7iJqiX5V48KAiZz3SOjdNSIAnR
 hPuvIkyP8GUN/AuNZsOQMJbzD5AXBN1aQmahesM/Tt4qAByNUkii0ceKy3boUxH+Turn
 1KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945545; x=1762550345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtB18Pvc9S14eiCOzWzreWzk+lt1hMQZD4T89jMibmU=;
 b=HPeKmhosp/VsVRtWhi996o8PVCUl8mStrLO/Qi2+QSrXIXp4PgRCYHjR6zHFzQmLT5
 SoZkt8N6DDhC4hRtBwnEN/qJfxNSEHlWNad3NQPw0M9h9cZMTehnKRm6ZZFK2s5ejB09
 yPH0NPAmDfVPSnhYlSsQfiyoPaEgzi6hPK55uZzRTf4DcOZSkYz+2UiWQT1kcfyvMABB
 cWbLqWu8nY3r8sOSVwfuNVQAzRxxNhEFIymNLrzPnSDLuPaxKEz9A4PZ8x6k5tCVUQzG
 tUsj/BJbMjv7/wj5dlj0ZvmbXLZfRp5eWSJAu+FIUnNCiVmFIHcGu9qHHKgLqAwYbDA4
 1ZFg==
X-Gm-Message-State: AOJu0YwQdOpQQM3vNH7h7ch/GtUHGtcGhSFQjBh4Fnxwf/Z9NZ2vBnD0
 I8ButJDWdEjXjjDv7WqbkjsTruBfQEu5owxWXX7N7btBNZV44LEqRnp2Q81DAAcSF+5mpMgv9Wj
 Zk1CYzhoSYA==
X-Gm-Gg: ASbGncs/lCvA0qxFU+6c7dNE6h9a4O9WclEFxYHeZIVkpNphXpfv4hZMsfV+6aKt4YV
 BqP3ycdlrai5tAesC7riPqrv5Jy50DhfOONDO8Fqgg5sjV494QFosqlolehB26tryZwYqjDv0u6
 okVInjnVWgEdxWNoMCaVAsiJ/HPwtN59DZW7KqS/+8njYUgVpLtrX4LULDd+uyqendpC31ijTEW
 xDqfZ+w4MVf/o+6AIvUA1GaEvo1v3Qoe1fmSWPhof3iB/CeA6N57XguKkmcG+7tbmE0AMccxSAU
 u/ql12pt0MYxRGU+L3zZVNTNjXGcz4GKWjWxe2+e+gceqcqD+ovlE5m/NAdg6SNRn3yfQye6/+H
 Je6eTTptGv8cCTk0CInd+CQFOGdRibsbx0lgHBcGqbLMNn53H+4/UQs7BMVY6IXBW0d+8U6jZ8a
 uGoX9nV0mZE/0ibCfuvm/CfDXe8FNCLLT2S6KlV8up18/D/2oa
X-Google-Smtp-Source: AGHT+IFrsaJGgwF2yOSCmVBULDmoRt4zzlKIoCMbn1/VY9QQCfR1Fnnp10dBvo/w7b9XLjYpajJW3g==
X-Received: by 2002:a5d:64e8:0:b0:429:8a40:e995 with SMTP id
 ffacd0b85a97d-429bd6ece4bmr5326479f8f.61.1761945544603; 
 Fri, 31 Oct 2025 14:19:04 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13ebfe8sm5401752f8f.35.2025.10.31.14.19.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:19:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Date: Fri, 31 Oct 2025 22:15:16 +0100
Message-ID: <20251031211518.38503-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

QEMU_HEXDUMP_LINE_WIDTH calculation doesn't correspond to
qemu_hexdump_line(). This leads to last line of the dump (when
length is not multiply of 16) has badly aligned ASCII part.

Let's calculate length the same way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251031190246.257153-2-vsementsov@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/hexdump.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/util/hexdump.c b/util/hexdump.c
index f29ffceb746..7cfc5472613 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -22,6 +22,19 @@ static inline char hexdump_nibble(unsigned x)
     return (x < 10 ? '0' : 'a' - 10) + x;
 }
 
+static size_t hexdump_line_length(size_t buf_len, size_t unit_len,
+                                  size_t block_len)
+{
+    size_t est = buf_len * 2;
+    if (unit_len) {
+        est += buf_len / unit_len;
+    }
+    if (block_len) {
+        est += buf_len / block_len;
+    }
+    return est;
+}
+
 GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
                            size_t unit_len, size_t block_len)
 {
@@ -30,14 +43,8 @@ GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
 
     if (str == NULL) {
         /* Estimate the length of the output to avoid reallocs. */
-        size_t est = len * 2;
-        if (unit_len) {
-            est += len / unit_len;
-        }
-        if (block_len) {
-            est += len / block_len;
-        }
-        str = g_string_sized_new(est + 1);
+        str = g_string_sized_new(hexdump_line_length(len, unit_len, block_len)
+                                 + 1);
     }
 
     for (u = 0, b = 0; len; u++, b++, len--, buf++) {
@@ -76,13 +83,16 @@ static void asciidump_line(char *line, const void *bufptr, size_t len)
 }
 
 #define QEMU_HEXDUMP_LINE_BYTES 16
-#define QEMU_HEXDUMP_LINE_WIDTH \
-    (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
+#define QEMU_HEXDUMP_UNIT 1
+#define QEMU_HEXDUMP_BLOCK 4
 
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size)
 {
-    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
+    int width = hexdump_line_length(QEMU_HEXDUMP_LINE_BYTES,
+                                    QEMU_HEXDUMP_UNIT,
+                                    QEMU_HEXDUMP_BLOCK);
+    g_autoptr(GString) str = g_string_sized_new(width + 1);
     char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
     size_t b, len;
 
@@ -90,11 +100,11 @@ void qemu_hexdump(FILE *fp, const char *prefix,
         len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
 
         g_string_truncate(str, 0);
-        qemu_hexdump_line(str, bufptr + b, len, 1, 4);
+        qemu_hexdump_line(str, bufptr + b, len,
+                          QEMU_HEXDUMP_UNIT, QEMU_HEXDUMP_BLOCK);
         asciidump_line(ascii, bufptr + b, len);
 
-        fprintf(fp, "%s: %04zx: %-*s %s\n",
-                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, str->str, ascii);
+        fprintf(fp, "%s: %04zx: %-*s %s\n", prefix, b, width, str->str, ascii);
     }
 
 }
-- 
2.51.0


