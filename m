Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F02FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNRk-00043l-H2; Mon, 27 Apr 2026 11:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHNRd-000416-G0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:00:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHNRX-0000og-Pg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:00:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so124411125e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777302011; x=1777906811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=81+HmGh6yQsX716mvnoroUOihJ8bUeMg8JRK/QkdGn0=;
 b=f3/jkErnc6i8zymkloaFYclwQEXLdEJ9xF4mWZANVR4zCj+iZGKnAQH1kUxNz79BQe
 d3NnjEXH1S2wY3kmUJ+oDcABSK5406SK/G8543Zqwuh+Q4BHlgwdfo2qswrFU0bZTtKe
 QWaFP/eQrJm+U8LpW6QhuY5WuOYfsGc9A77e/6MyGbF1LvWK4yblOMFIMVTM9SxU0V+u
 cJG/fyu6lvFJu7C4kljCooCKaofKBJKIT3AHB6QnnrjfXrmWios/Q6KJPSNlCBSJW/JB
 +HILT85HAIvv4KgI3/pTa8/7Nql5tkxl08mpGG70GA+XSp0zU3t5A1hPMh8T8THhqxgL
 oU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777302011; x=1777906811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81+HmGh6yQsX716mvnoroUOihJ8bUeMg8JRK/QkdGn0=;
 b=G/KwZhnJNvfRSH/PSDq8bU9+Cywgc2FZ/L4hiAxDyye35aTIv0WOeUVEkIi+z2V/72
 YDNhKBegucSQ0SgRkKltxNDt0odsw8awvEJy9oPaunRdjS+LK/S0C0GIZUvIOwp0YcBX
 KRNHEjWcbNoUh9DJ0POh8+bAEhLBOLYjumBmpC6ZoLqIDOI0ESjw2VR2caOehglgKK3q
 3zxAZV62tKwanVUs9LKOCIrPgFLZV+Hdbgq/wxmzbipqNt8EsQh2rOCIscE5CK+TdENZ
 tWBHt5MyXA3TT3C/cbw3Sa/IxzGXVmB8vn6+b73uvmUdYGtTdyIc9LCXGDHn4JIue/tP
 0fyQ==
X-Gm-Message-State: AOJu0YweBQlx6HlpsDj3j59eLh1eyAfSlbu8zkuyOCZt22RXtS4JwRaa
 UmWRNPci2Tqn4GcqoVgGR6UIhn8LnbHh+HpQ3vA3zJniWbu9JEr1g1rQuryU7U2aVhrGtKPAGP8
 6a715
X-Gm-Gg: AeBDietAF4EFqArwPzdgcw/d+jQ4UGzSMWgoodCjb/EpXQ4tcY9fjxeYLMPThPmIKg0
 xJB2Z3uOK/yT2az02N1xO6uGtuYbGcxqGa5qZ4RCJrgxzacikZR7nTU6cJh+2trrDkVbn6jvNMd
 /k6upRYPasgeo5S40bP6h2U4yQePl37vkL1j6arWhEow2wAzqNDqoD3cw7Kk7x5qd/24N8+m/J2
 F6vWH/0WRUWMCMzxp8phb6eeRL4Vx8dfQHP/eu6ipp038nod1ltB1vlBoKJNfaUg1NJv5IpSak7
 ZyolRD+cjIVK07mbufwCSeJ92Cas/b79JdLmckAdqcsAupdrr6Ht8N92xXTHk0Uw4tS2ctu1c8A
 pRUH3H6Nfmx/euWUkuoKUDfSqIhHqDveWdd+j6tm745w5mwBdu4+sTJjyDf8xjfwtVPknDbXD2Z
 P0D3+9Ufk2bhhYKuqZaDS00uUNJp5JtTM//X+iGuUA2JeGKyhDltWb0MlrHvbwMj2jkP6bK3SOd
 HNOjbhV/ygLXs+4nHfjFPIVviRHf2kqfat3Rt+XJQ==
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a52f2a5f0mr417298315e9.18.1777302009543; 
 Mon, 27 Apr 2026 08:00:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm823445235e9.12.2026.04.27.08.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:00:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qtest: Make qtest_get_arch() cleverer
Date: Mon, 27 Apr 2026 16:00:07 +0100
Message-ID: <20260427150007.1185559-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The qtest_get_arch() function tries to determine the architecture
under test by extracting it from the binary name as provided in
QTEST_QEMU_BINARY.  The current logic finds the last '-' in the
string and assumes everything beyond it is the architecture name.
Although we also look for the substring "-system-", the only effect
this check has is that we will exit with an error if it is not
present.

Because the logic at the moment is very simplistic, although
it is possible to provide more complex commands than a bare
QEMU binary path, such as:
  QTEST_QEMU_BINARY='rr record ./qemu-system-x86_64'
it is not possible to provide extra arguments to QEMU, such as:
  QTEST_QEMU_BINARY='./qemu-system-x86_64 -d trace:foo'

Because the "-system-" check and the "find the architecture" check
are not the same, the latter example will pass the "we found
-system-" check and not notice that the "architecture name" it has
found starts further on in the string; so rather than printing an
error it will return "d trace:foo" to the test.

Improve the "find the architecture name" logic to look for the
rightmost occurrence of the substring "-system-" in
QTEST_QEMU_BINARY, and take the architecture name as starting there
and continuing until the first whitespace character or the end of the
string.

Because we now need to potentially modify the environment variable
string to terminate the architecture name if it is not the last part
of the string, we make a copy of it which we cache in a static
variable.  This lets us avoid having to modify all the callers to get
them to take ownership of the returned string.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I wanted to be able to pass trace arguments to a QEMU to help
debug a failing test; in the past I've done this by writing
a little wrapper shell script with the right shaped name, but
we can do better than that.

 tests/qtest/libqtest.c | 43 +++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 051faf31e1..116a8a3258 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1015,22 +1015,39 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
 
 const char *qtest_get_arch(void)
 {
-    const char *qemu = qtest_qemu_binary(NULL);
-    const char *end = strrchr(qemu, '-');
+    /*
+     * We find and cache the architecture name once, because we need to
+     * allocate memory to hold it. This memory will stay around for
+     * the lifetime of this test process.
+     */
+    static const char *arch;
 
-    if (!end) {
-        fprintf(stderr, "Can't determine architecture from binary name.\n");
-        exit(1);
+    if (!arch) {
+        /*
+         * Find the rightmost occurrence of "-system-"; the architecture
+         * name runs from there to the next whitespace.
+         */
+        const char *qemu = qtest_qemu_binary(NULL);
+        const char *sysstr = g_strrstr(qemu, "-system-");
+
+        if (sysstr) {
+            g_auto(GStrv) tokens = g_strsplit_set(sysstr + strlen("-system-"),
+                                                  " \t", 2);
+            if (tokens && tokens[0]) {
+                arch = g_steal_pointer(&tokens[0]);
+            }
+        }
+
+        if (!arch) {
+            fprintf(stderr, "Can't determine architecture from binary name.\n"
+                    "QTEST_QEMU_BINARY must include *-system-<arch> where "
+                    "'arch' is the target architecture "
+                    "(x86_64, aarch64, etc).\n");
+            exit(1);
+        }
     }
 
-    if (!strstr(qemu, "-system-")) {
-        fprintf(stderr, "QTEST_QEMU_BINARY must end with *-system-<arch> "
-                "where 'arch' is the target\narchitecture (x86_64, aarch64, "
-                "etc).\n");
-        exit(1);
-    }
-
-    return end + 1;
+    return arch;
 }
 
 static bool qtest_qom_has_concrete_type(const char *parent_typename,
-- 
2.43.0


