Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9745EC47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaiU-0008C9-PA; Wed, 24 Jan 2024 05:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaiS-0008BT-Kb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaiQ-0008Es-Pm
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706092962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEohwW+frIHgQpcT2dkOzL2eiqZNhael6KKxnjbb308=;
 b=PZ0ncUjBUV158TKxB/c3AycyyCbdbLeDIhQqcj222LCr+brRYZKWw6qxODvMpb7TLV+9sL
 bAs57Q/inVD4xev8mOMH3j+LSNNJKz4ESc0dHjlvDOHx4YqQUXfLf6Xk+KBG7rlMkvpmHi
 Ji1Qg5HPG/3Vo/uuAEMysJFoCTQJGzU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-ei4pEaRZP7irVGfJCjJ3Kg-1; Wed, 24 Jan 2024 05:42:39 -0500
X-MC-Unique: ei4pEaRZP7irVGfJCjJ3Kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D14C80007C;
 Wed, 24 Jan 2024 10:42:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D35A551D5;
 Wed, 24 Jan 2024 10:42:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/7] util/uri: Remove uri_string_unescape()
Date: Wed, 24 Jan 2024 11:42:28 +0100
Message-ID: <20240124104231.603418-5-thuth@redhat.com>
In-Reply-To: <20240124104231.603418-1-thuth@redhat.com>
References: <20240124104231.603418-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

uri_string_unescape() basically does the same as the glib function
g_uri_unescape_segment(). So we can get rid of our implementation
completely by simply using the glib function instead.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240123182247.432642-2-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/uri.h |  1 -
 util/uri.c         | 97 ++++++----------------------------------------
 2 files changed, 11 insertions(+), 87 deletions(-)

diff --git a/include/qemu/uri.h b/include/qemu/uri.h
index 1855b764f2..f0722b75da 100644
--- a/include/qemu/uri.h
+++ b/include/qemu/uri.h
@@ -79,7 +79,6 @@ URI *uri_parse_raw(const char *str, int raw);
 int uri_parse_into(URI *uri, const char *str);
 char *uri_to_string(URI *uri);
 char *uri_string_escape(const char *str, const char *list);
-char *uri_string_unescape(const char *str, int len, char *target);
 void uri_free(URI *uri);
 
 /* Single web service query parameter 'name=value'. */
diff --git a/util/uri.c b/util/uri.c
index dcb3305236..fb7823a43c 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -267,7 +267,7 @@ static int rfc3986_parse_fragment(URI *uri, const char **str)
         if (uri->cleanup & 2) {
             uri->fragment = g_strndup(*str, cur - *str);
         } else {
-            uri->fragment = uri_string_unescape(*str, cur - *str, NULL);
+            uri->fragment = g_uri_unescape_segment(*str, cur, NULL);
         }
     }
     *str = cur;
@@ -368,7 +368,7 @@ static int rfc3986_parse_user_info(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->user = g_strndup(*str, cur - *str);
             } else {
-                uri->user = uri_string_unescape(*str, cur - *str, NULL);
+                uri->user = g_uri_unescape_segment(*str, cur, NULL);
             }
         }
         *str = cur;
@@ -496,7 +496,7 @@ found:
             if (uri->cleanup & 2) {
                 uri->server = g_strndup(host, cur - host);
             } else {
-                uri->server = uri_string_unescape(host, cur - host, NULL);
+                uri->server = g_uri_unescape_segment(host, cur, NULL);
             }
         } else {
             uri->server = NULL;
@@ -614,7 +614,7 @@ static int rfc3986_parse_path_ab_empty(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = g_uri_unescape_segment(*str, cur, NULL);
             }
         } else {
             uri->path = NULL;
@@ -663,7 +663,7 @@ static int rfc3986_parse_path_absolute(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = g_uri_unescape_segment(*str, cur, NULL);
             }
         } else {
             uri->path = NULL;
@@ -709,7 +709,7 @@ static int rfc3986_parse_path_rootless(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = g_uri_unescape_segment(*str, cur, NULL);
             }
         } else {
             uri->path = NULL;
@@ -755,7 +755,7 @@ static int rfc3986_parse_path_no_scheme(URI *uri, const char **str)
             if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
             } else {
-                uri->path = uri_string_unescape(*str, cur - *str, NULL);
+                uri->path = g_uri_unescape_segment(*str, cur, NULL);
             }
         } else {
             uri->path = NULL;
@@ -1561,81 +1561,6 @@ done_cd:
     return 0;
 }
 
-static int is_hex(char c)
-{
-    if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
-        ((c >= 'A') && (c <= 'F'))) {
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * uri_string_unescape:
- * @str:  the string to unescape
- * @len:   the length in bytes to unescape (or <= 0 to indicate full string)
- * @target:  optional destination buffer
- *
- * Unescaping routine, but does not check that the string is an URI. The
- * output is a direct unsigned char translation of %XX values (no encoding)
- * Note that the length of the result can only be smaller or same size as
- * the input string.
- *
- * Returns a copy of the string, but unescaped, will return NULL only in case
- * of error
- */
-char *uri_string_unescape(const char *str, int len, char *target)
-{
-    char *ret, *out;
-    const char *in;
-
-    if (str == NULL) {
-        return NULL;
-    }
-    if (len <= 0) {
-        len = strlen(str);
-    }
-    if (len < 0) {
-        return NULL;
-    }
-
-    if (target == NULL) {
-        ret = g_malloc(len + 1);
-    } else {
-        ret = target;
-    }
-    in = str;
-    out = ret;
-    while (len > 0) {
-        if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
-            in++;
-            if ((*in >= '0') && (*in <= '9')) {
-                *out = (*in - '0');
-            } else if ((*in >= 'a') && (*in <= 'f')) {
-                *out = (*in - 'a') + 10;
-            } else if ((*in >= 'A') && (*in <= 'F')) {
-                *out = (*in - 'A') + 10;
-            }
-            in++;
-            if ((*in >= '0') && (*in <= '9')) {
-                *out = *out * 16 + (*in - '0');
-            } else if ((*in >= 'a') && (*in <= 'f')) {
-                *out = *out * 16 + (*in - 'a') + 10;
-            } else if ((*in >= 'A') && (*in <= 'F')) {
-                *out = *out * 16 + (*in - 'A') + 10;
-            }
-            in++;
-            len -= 3;
-            out++;
-        } else {
-            *out++ = *in++;
-            len--;
-        }
-    }
-    *out = 0;
-    return ret;
-}
-
 /**
  * uri_string_escape:
  * @str:  string to escape
@@ -2274,14 +2199,14 @@ struct QueryParams *query_params_parse(const char *query)
          * and consistent with CGI.pm we assume value is "".
          */
         else if (!eq) {
-            name = uri_string_unescape(query, end - query, NULL);
+            name = g_uri_unescape_segment(query, end, NULL);
             value = NULL;
         }
         /* Or if we have "name=" here (works around annoying
          * problem when calling uri_string_unescape with len = 0).
          */
         else if (eq + 1 == end) {
-            name = uri_string_unescape(query, eq - query, NULL);
+            name = g_uri_unescape_segment(query, eq, NULL);
             value = g_new0(char, 1);
         }
         /* If the '=' character is at the beginning then we have
@@ -2293,8 +2218,8 @@ struct QueryParams *query_params_parse(const char *query)
 
         /* Otherwise it's "name=value". */
         else {
-            name = uri_string_unescape(query, eq - query, NULL);
-            value = uri_string_unescape(eq + 1, end - (eq + 1), NULL);
+            name = g_uri_unescape_segment(query, eq, NULL);
+            value = g_uri_unescape_segment(eq + 1, end, NULL);
         }
 
         /* Append to the parameter set. */
-- 
2.43.0


