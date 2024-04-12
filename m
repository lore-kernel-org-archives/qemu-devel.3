Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E134C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQJ-00075K-OM; Fri, 12 Apr 2024 03:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQC-00071a-0U
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:04 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ5-000797-O0
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e5b6e8f662so1413895ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907236; x=1713512036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7uXdJXbZvFgUDV/6dLp0dNk/3VKiyesi33hYvTO4ao=;
 b=GcSJtibv9rodPYdW6Y516ABbpRY5FWgJhv0J+olKvlxdW3H0wOOcjldEAAorJU+nBA
 xmA1gGRZh7RGVgmV7+PUOfU0QpGKlQSYVTrPWVQF7crgpgUal8M0C+5RCQav4Fo2c4WV
 hySv6crQTK5p1a5+xkkWhuc7gJpRie7lm4a8xZsvKGgUnXptFCsn8saEx7eVFtWkKPsd
 XBijoPHbjSQvlB+AFptewFzgwv0noF0IpRnH7mqK4qWYJS2N/w9l/UundvD4DFcG1vZG
 jvCYBuWaHkb9BCycS636Cn859AG8CzymIQdn9W2dT7qDPAYwb9+1HhqqrWzhV8WxPZND
 0bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907236; x=1713512036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7uXdJXbZvFgUDV/6dLp0dNk/3VKiyesi33hYvTO4ao=;
 b=TmNTkxy6iLyD0ActzZ1jkUJbAuEbNpOmjo9fM+F+YwMOSX5v4CohxHPStNq+7sQDb5
 qYkaoWLRB8r8Rmb2sGeG1ghcU1OynCJ9zUDUJfmNrNcNFUuVYL13BA8DefK179sH8Lun
 zHor5uvkRdSr4fWkfxiNqCcLoGbQvCg17Q4td9yTxiUB9sL77K+i0LkaA0wFN1MOmPV1
 1kP76AXoYrl0zX/4ZpKCqt5/pjz2cQwHHdTBW2cup+bzLZ4kD9X9dLBvEewDsWB0acbS
 uZa7ooAB/QNZRthSFLzsvAB56ogJV+5KUp3uUpguJ4hTMYM33XWvgtsOfNd7gwJkZ4Je
 yegg==
X-Gm-Message-State: AOJu0Yxojar7JS96yv+gdSeF+gPOKLUCaB+Ob7CQLwSr6iP6fz1oGgpm
 yVt+6Mc2NuOxPb43birQncgc4wgkPgbiaV2RAvdg1rbTLSAMqKQD43EBdFpY7wAzmv6dD1sCYTr
 R
X-Google-Smtp-Source: AGHT+IEthVWBJy8rEtPNwM/wziGLiVZWjIiCd47toWvQeIf9GVMAN+hPKl3g1b5kVWulJh1rUI2R5A==
X-Received: by 2002:a17:902:eb87:b0:1e4:12e1:88bc with SMTP id
 q7-20020a170902eb8700b001e412e188bcmr2498786plg.11.1712907236483; 
 Fri, 12 Apr 2024 00:33:56 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 11/27] backends/tpm: Use qemu_hexdump_line to avoid sprintf
Date: Fri, 12 Apr 2024 00:33:30 -0700
Message-Id: <20240412073346.458116-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[rth: Keep the linebreaks every 16 bytes]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 backends/tpm/tpm_util.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 1856589c3b..bf3378fbbe 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "tpm_int.h"
@@ -336,27 +337,22 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string)
 {
-    size_t len, i;
-    char *line_buffer, *p;
+    g_autoptr(GString) str = NULL;
+    size_t len, i, l;
 
     if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
         return;
     }
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
 
-    /*
-     * allocate enough room for 3 chars per buffer entry plus a
-     * newline after every 16 chars and a final null terminator.
-     */
-    line_buffer = g_malloc(len * 3 + (len / 16) + 1);
-
-    for (i = 0, p = line_buffer; i < len; i++) {
-        if (i && !(i % 16)) {
-            p += sprintf(p, "\n");
+    for (i = 0; i < len; i += l) {
+        if (str) {
+            g_string_append_c(str, '\n');
         }
-        p += sprintf(p, "%.2X ", buffer[i]);
+        l = MIN(len, 16);
+        str = qemu_hexdump_line(str, buffer, l, 1, 0);
     }
-    trace_tpm_util_show_buffer(string, len, line_buffer);
 
-    g_free(line_buffer);
+    g_string_ascii_up(str);
+    trace_tpm_util_show_buffer(string, len, str->str);
 }
-- 
2.34.1


