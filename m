Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9E7C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 19:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZyAF-0001m5-Nb; Fri, 02 Aug 2024 15:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZyAC-0001gx-1i
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 15:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZyA9-0006Pb-QV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 15:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722627725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJRVoV8joIzvzwEK+I1wnNb8PlLcPaFvR6Lcnvr3iW4=;
 b=GU1RIZJ29UbxKGDrPoN2Qyq6MdoDstzWjMHH1ejqcZPa1XwRT4u5RCD5mfhLPxZBMgNMGZ
 ECPTiKCwUyJOaE9Z7GsG4/V/foxnmikM2zmUGz//ekJjTa33/ppWW2IFcJSpXUn7NCAiaP
 utzJ9yWJKxef+F3Epm2iqvt8N0aA6z4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-DbdUnAQPNwKAjbtpg_k7Pw-1; Fri,
 02 Aug 2024 15:42:04 -0400
X-MC-Unique: DbdUnAQPNwKAjbtpg_k7Pw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F297C195608B; Fri,  2 Aug 2024 19:42:02 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56BE11955D44; Fri,  2 Aug 2024 19:42:00 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/2] util: Refactor json-writer's string sanitizer to be public
Date: Fri,  2 Aug 2024 14:26:05 -0500
Message-ID: <20240802194156.2131519-5-eblake@redhat.com>
In-Reply-To: <20240802194156.2131519-4-eblake@redhat.com>
References: <20240802194156.2131519-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

My next patch needs to convert text from an untrusted input into an
output representation that is suitable for display on a terminal is
useful to more than just the json-writer; the text should normally be
UTF-8, but blindly allowing all Unicode code points (including ASCII
ESC) through to a terminal risks remote-code-execution attacks on some
terminals.  Extract the existing body of json-writer's quoted_strinto
a new helper routine mod_utf8_sanitize, and generalize it to also work
on data that is length-limited rather than NUL-terminated.  [I was
actually surprised that glib does not have such a sanitizer already -
Google turns up lots of examples of rolling your own string
sanitizer.]

If desired in the future, we may want to tweak whether the output is
guaranteed to be ASCII (using lots of \u escape sequences, including
surrogate pairs for code points outside the BMP) or if we are okay
passing printable Unicode through (we still need to escape control
characters).  But for now, I went for minimal code churn, including
the fact that the resulting function allows a non-UTF-8 2-byte synonym
for U+0000.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/unicode.h |  3 ++
 qobject/json-writer.c  | 47 +----------------------
 util/unicode.c         | 84 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 46 deletions(-)

diff --git a/include/qemu/unicode.h b/include/qemu/unicode.h
index 7fa10b8e604..e1013b29f72 100644
--- a/include/qemu/unicode.h
+++ b/include/qemu/unicode.h
@@ -4,4 +4,7 @@
 int mod_utf8_codepoint(const char *s, size_t n, char **end);
 ssize_t mod_utf8_encode(char buf[], size_t bufsz, int codepoint);

+void mod_utf8_sanitize(GString *buf, const char *str);
+void mod_utf8_sanitize_len(GString *buf, const char *str, ssize_t len);
+
 #endif
diff --git a/qobject/json-writer.c b/qobject/json-writer.c
index 309a31d57a9..5c14574efee 100644
--- a/qobject/json-writer.c
+++ b/qobject/json-writer.c
@@ -104,53 +104,8 @@ static void pretty_newline_or_space(JSONWriter *writer)

 static void quoted_str(JSONWriter *writer, const char *str)
 {
-    const char *ptr;
-    char *end;
-    int cp;
-
     g_string_append_c(writer->contents, '"');
-
-    for (ptr = str; *ptr; ptr = end) {
-        cp = mod_utf8_codepoint(ptr, 6, &end);
-        switch (cp) {
-        case '\"':
-            g_string_append(writer->contents, "\\\"");
-            break;
-        case '\\':
-            g_string_append(writer->contents, "\\\\");
-            break;
-        case '\b':
-            g_string_append(writer->contents, "\\b");
-            break;
-        case '\f':
-            g_string_append(writer->contents, "\\f");
-            break;
-        case '\n':
-            g_string_append(writer->contents, "\\n");
-            break;
-        case '\r':
-            g_string_append(writer->contents, "\\r");
-            break;
-        case '\t':
-            g_string_append(writer->contents, "\\t");
-            break;
-        default:
-            if (cp < 0) {
-                cp = 0xFFFD; /* replacement character */
-            }
-            if (cp > 0xFFFF) {
-                /* beyond BMP; need a surrogate pair */
-                g_string_append_printf(writer->contents, "\\u%04X\\u%04X",
-                                       0xD800 + ((cp - 0x10000) >> 10),
-                                       0xDC00 + ((cp - 0x10000) & 0x3FF));
-            } else if (cp < 0x20 || cp >= 0x7F) {
-                g_string_append_printf(writer->contents, "\\u%04X", cp);
-            } else {
-                g_string_append_c(writer->contents, cp);
-            }
-        }
-    };
-
+    mod_utf8_sanitize(writer->contents, str);
     g_string_append_c(writer->contents, '"');
 }

diff --git a/util/unicode.c b/util/unicode.c
index 8580bc598b3..a419ed4de35 100644
--- a/util/unicode.c
+++ b/util/unicode.c
@@ -154,3 +154,87 @@ ssize_t mod_utf8_encode(char buf[], size_t bufsz, int codepoint)
     buf[4] = 0;
     return 4;
 }
+
+/**
+ * mod_utf8_sanitize:
+ * @buf: Destination buffer
+ * @str: Modified UTF-8 string to sanitize
+ *
+ * Append the contents of the NUL-terminated Modified UTF-8 string
+ * @str into @buf, with escape sequences used for non-printable ASCII
+ * and for quote characters.  The result is therefore safe for output
+ * to a terminal.
+ *
+ * Modified UTF-8 is exactly like UTF-8, except U+0000 is encoded as
+ * "\xC0\x80".
+ */
+void mod_utf8_sanitize(GString *buf, const char *str)
+{
+    mod_utf8_sanitize_len(buf, str, -1);
+}
+
+/**
+ * mod_utf8_sanitize:
+ * @buf: Destination buffer
+ * @str: Modified UTF-8 string to sanitize
+ * @len: Length of @str, or negative to stop at NUL terminator
+ *
+ * Append the contents of @len bytes of the Modified UTF-8 string
+ * @str into @buf, with escape sequences used for non-printable ASCII
+ * and for quote characters.  The result is therefore safe for output
+ * to a terminal.
+ *
+ * Modified UTF-8 is exactly like UTF-8, except U+0000 is encoded as
+ * "\xC0\x80".
+ */
+void mod_utf8_sanitize_len(GString *buf, const char *str, ssize_t len)
+{
+    const char *ptr;
+    char *end;
+    int cp;
+
+    if (len < 0) {
+        len = strlen(str);
+    }
+
+    for (ptr = str; *ptr; ptr = end) {
+        cp = mod_utf8_codepoint(ptr, MIN(6, str + len - ptr), &end);
+        switch (cp) {
+        case '\"':
+            g_string_append(buf, "\\\"");
+            break;
+        case '\\':
+            g_string_append(buf, "\\\\");
+            break;
+        case '\b':
+            g_string_append(buf, "\\b");
+            break;
+        case '\f':
+            g_string_append(buf, "\\f");
+            break;
+        case '\n':
+            g_string_append(buf, "\\n");
+            break;
+        case '\r':
+            g_string_append(buf, "\\r");
+            break;
+        case '\t':
+            g_string_append(buf, "\\t");
+            break;
+        default:
+            if (cp < 0) {
+                cp = 0xFFFD; /* replacement character */
+            }
+            if (cp > 0xFFFF) {
+                /* beyond BMP; need a surrogate pair */
+                g_string_append_printf(buf, "\\u%04X\\u%04X",
+                                       0xD800 + ((cp - 0x10000) >> 10),
+                                       0xDC00 + ((cp - 0x10000) & 0x3FF));
+            } else if (cp < 0x20 || cp >= 0x7F) {
+                g_string_append_printf(buf, "\\u%04X", cp);
+            } else {
+                g_string_append_c(buf, cp);
+            }
+        }
+    }
+}
-- 
2.45.2


