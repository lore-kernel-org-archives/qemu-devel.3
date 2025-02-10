Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02E7C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thabj-00064l-Sw; Mon, 10 Feb 2025 15:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabg-000645-Gi
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabe-0003Vw-PZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso13617705e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220133; x=1739824933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcGKYNB2iXQxYTIMbFa2ddZc406Eqn3eyhE9dse+xIY=;
 b=r2zfbUH4R5irxTQ9v2ebS3s50CLUdmSgRHu64ZIyCo8ho9pgVfpRn1amlwSRkXPA5N
 8wnYiZov0iAp7XX/QxkqF4uaNjyQly/B84j5XVxKmtqI1HjlzfA5HVdMUKqK2XENMCSx
 kGpAQ6X3iS3LBc9oramPdd8IDDEC0daWF8hOoD411wVbDqIHGGNoNggE+wtfDD+Ja0aB
 1DWb02tjN3wsoyCHN1XTVvMCMjMhWGSSXYo6GSKNrcbqjyW+6UwnfoN53jFfI6caY2r8
 0/pYpAI5rgUbp5xQg8diWstSeD1gz8xx9Wt9H5jFsXwoVLGBtXYTlGcXWWRpqBhl3pv6
 8itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220133; x=1739824933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcGKYNB2iXQxYTIMbFa2ddZc406Eqn3eyhE9dse+xIY=;
 b=B5J/D0s5jGYduzFooTLob6+QwlhqabHXJSzifz/7qsvObZjMaPRZbTgLiGnCDWFgU0
 /GjNd1rr6LfMwUtfJQD6EBn4TMy0mtzzWmL8xRkrdkAIO2nfNAND3G5KNi5agxsvsFzH
 QmUj9BseJvYdEGhwdaEqTN8NsRCaCoFdc2uvRZfVTnClCqVfdybMHsSvu6rx5hRghsiM
 7ckeaxZOg1VixxSax0XokJXcBR1O1geJyu0BLT2ZV0tslYE/E0ayNstM6BJO9Cb0d+cD
 x6LikGP3WXr4Xom2dY9Fb4LdM134CaBRFrPRieFO8i8vvzrkb67JGHYpuGohHgZS/nVt
 NlOA==
X-Gm-Message-State: AOJu0YynOMtQ1/3lFQbg67MMdfiqDGYTSE5pxuCg3iCNjIwQtowKg96R
 ug8N5/wJBkuQicJWxsaotz+pAlPb1fd82Yq8BOZKVvwBwFoYy4RRrQuFAbUECPTaQPCW2mpnhWE
 lw2I=
X-Gm-Gg: ASbGncvt+q3ZMpASo4EG+EtO/iOyIBkWMs1GTxFZLiRBRX3sJtgktEVlWCiuHOzDDHk
 HhWrX1WOFeJJgzt1hdrFaDJ7fZyhZ1OrPMvk6aQ5BVJhd7Tp3h0jeO9ny/3q1DsdlJd/IRABItn
 VELI9TFsP/42/Xnf0Dqj6WsEs2F2QSYdK0gMW78D3QcqWx461EmN//cpWH94Ja2ur9Ae5TfQcmO
 7csZRuzKcbpTKGGCg0PcM7KvMiXqORLrXU/O+so1PTN9iGfu0pbwo4KzE8u9TVtZbAqvtPEvnrh
 zBfy2TaK3F+rg94PNmTVqlmeC/TECO3HAr9REoZGdBaUCVlNJZVmUwIqQgg309PcdQ==
X-Google-Smtp-Source: AGHT+IFrGqFtsoxvatxUNuh/frVzKMRA9QrAotxE81vuzkvN3DhDKFiaknClKhSpuM3+itVP/m/tOQ==
X-Received: by 2002:a7b:c7d8:0:b0:437:c453:ff19 with SMTP id
 5b1f17b1804b1-4394cf0825fmr6068855e9.14.1739220132560; 
 Mon, 10 Feb 2025 12:42:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1af07sm13299269f8f.15.2025.02.10.12.42.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/32] backends/tpm: Use qemu_hexdump_line() to avoid sprintf()
Date: Mon, 10 Feb 2025 21:41:33 +0100
Message-ID: <20250210204204.54407-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line() both fixes the deprecation warning and
simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
[rth: Keep the linebreaks every 16 bytes]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240412073346.458116-12-richard.henderson@linaro.org>
[PMD: Rebased]
---
 backends/tpm/tpm_util.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 32946251060..0a428eaf756 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "tpm_int.h"
@@ -336,8 +337,8 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string)
 {
-    size_t len, i;
-    char *line_buffer, *p;
+    g_autoptr(GString) str = NULL;
+    size_t len, i, l;
 
     if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER_CONTENT)) {
         return;
@@ -345,19 +346,14 @@ void tpm_util_show_buffer(const unsigned char *buffer,
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
     trace_tpm_util_show_buffer_header(string, len);
 
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
-    trace_tpm_util_show_buffer_content(line_buffer);
 
-    g_free(line_buffer);
+    g_string_ascii_up(str);
+    trace_tpm_util_show_buffer_content(str->str);
 }
-- 
2.47.1


