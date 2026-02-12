Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17EAEE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZYZ-0001eO-M1; Thu, 12 Feb 2026 11:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vqZY9-0001Q3-AU
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:28:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vqZY3-0007jc-Nf
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:28:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so266635e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1770913689; x=1771518489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8Mg3xLx5AR9QnULNPfNm28Oi0tteTYNIGto3Ebs6+s=;
 b=F1zvCAAwSSoenJNkzD6tOQzdoK0wSTyEZLJQkqxMolH5ZC6cVvFN53NWVvt79gMaqk
 B/kXfN1/3O/j1WxBK8oey3t2gK3dDjN9wOdgNn0p5tU9PK7NWBcLcriDw9vBAWtfDLAR
 ClO+tR0HFKzwWGUnuFY+gX09KyoB42Pc5IYfXZRwbh+OsAraPALr5WwRZ1wD+19Pxb22
 BueDy5Ke5755Wotwv14n3xTITP5vTauO5wuzdcRnZdhu4zptRKzObwDt/tbZhLP1mxxK
 NXb1NVlz5kI2J/Q65a27tn7eZkN/yjPHFhjZhCy9pkkYoKgW7NcjW4XH6N4vz9xtM7RE
 SKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913689; x=1771518489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R8Mg3xLx5AR9QnULNPfNm28Oi0tteTYNIGto3Ebs6+s=;
 b=STHd+cmjQUbo2zYZlKRyOcku+MUoBpqLoCpSojPOCB0934QrYhEpNaFznLd1wqIfk7
 h5xJ4aFsmrqYMvgeCwWOOfz4J6JvDJZJv1sGtNA4apd+kS07GeuWhRMmMczscSSx+1Q3
 gaJhDRaQTtEIPCR1K6NCf6vtbolQolnDTy9OkJCGsHBIDYuMtFjrDlsyt7bN7EujvTX8
 htvhEvemr7pI/9adw8HHihDISuNR0W/RFjf4uNe2/JJVLbn35Jzu1tlZZv21AEXJdV4X
 0f4lKMbYEfwY99k9DXxgLVIhroL17yzcehHtWvZmNkTnYRNBL9Y3OOEJOoBoPnll+eYj
 CeWQ==
X-Gm-Message-State: AOJu0Yz75YA09QKTjS0dZbQqoA9RQ8uuP7zNRbtUpYor30u/KNe/NNTp
 FX1kvEwimwxWil6YFFmNeAC86/3Fvc+uakpJwC9U+HRl9HFXvcC3SN+Fo/uqw6IHweO0RxRPtTG
 caqd+
X-Gm-Gg: AZuq6aI010WwowMP8sk7gnXZk8tqtm0Wp/qaX5OPvyIwxFPDNjTlcki7+U4opP4Ie4V
 25e9wTHcvsJQ9WHz+pi8Rjuo1kIZDn2mBvauUjZcTulbJ7CbXEYPxjcICswLVzAlLCD7zDuQlmS
 bqDtxj+d9hDCu2wlDa2QyYJiMYl53Ll4X0QEgLfDiFf4dLYcpwvIhHFFkB/PHlAjilT/t08WzUk
 cwr45/oHPLHLijDnBemL+/BqysXfTGWi5HXQgtmwTHxIPDBvnMYtMilyWajOAV6Ckd11Dy1tlb7
 JrwkabiVj1R/GH8xSUnoYLDO/SBGuIvJT6fC2XDES2YlhcdKcBHrv+AG7kFuTML2o45cE/iT57F
 ti09eNp7wLxZ7yapbymA3WCcoIGfeoY6t2gcZA3AC+t1IgXHz41oBWbtAwNumebyNa6YOv4PsDa
 WJWx1DzqFQnqCgMzZ4Fujx7NfSXSWy3oPRZ8qcrjYzdOG/6o6X
X-Received: by 2002:a05:600c:3b85:b0:483:6ff1:18b with SMTP id
 5b1f17b1804b1-4836ff103a7mr4975605e9.0.1770913689197; 
 Thu, 12 Feb 2026 08:28:09 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835b958b6csm140710445e9.1.2026.02.12.08.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 08:28:08 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] block/curl: add support for S3 presigned URLs
Date: Thu, 12 Feb 2026 17:27:25 +0100
Message-ID: <20260212162730.440855-3-adamhet@scaleway.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212162730.440855-1-adamhet@scaleway.com>
References: <20260212162730.440855-1-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x329.google.com
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

S3 presigned URLs are signed for a specific HTTP method (typically GET
for our use cases). The curl block driver currently issues a HEAD
request to discover the backend features and the file size, which fails
with 403.

Add a 'force-range' option that skips the HEAD request and instead
issues a minimal GET request (querying 1 byte from the server) to
extract the file size from the 'Content-Range' response header. To
achieve this the 'curl_header_cb' is redesigned to generically parse
HTTP headers.

$ $QEMU -drive driver=http,\
             'url=https://s3.example.com/some.img?X-Amz-Security-Token=XXX',
             force-range=true

Enabling the 'force-range' option without the backend supporting it is
undefined behavior and untested but the libcurl should ignore the body
and stop reading after the HTTP headers then we would fail with the
expected `Server does not support 'range' (byte ranges).` error.

Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
---
 block/curl.c                          | 104 ++++++++++++++++++--------
 block/trace-events                    |   1 +
 docs/system/device-url-syntax.rst.inc |   6 ++
 qapi/block-core.json                  |  14 +++-
 4 files changed, 90 insertions(+), 35 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 6dccf002564e..66aecfb20ec6 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -62,10 +62,12 @@
 #define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
+#define CURL_BLOCK_OPT_FORCE_RANGE "force-range"
 
 #define CURL_BLOCK_OPT_READAHEAD_DEFAULT (256 * 1024)
 #define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
 #define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
+#define CURL_BLOCK_OPT_FORCE_RANGE_DEFAULT false
 
 struct BDRVCURLState;
 struct CURLState;
@@ -206,27 +208,33 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     BDRVCURLState *s = opaque;
     size_t realsize = size * nmemb;
-    const char *p = ptr;
-    const char *end = p + realsize;
-    const char *t = "accept-ranges : bytes "; /* A lowercase template */
+    g_autofree char *header = g_strstrip(g_strndup(ptr, realsize));
+    char *val = strchr(header, ':');
 
-    /* check if header matches the "t" template */
-    for (;;) {
-        if (*t == ' ') { /* space in t matches any amount of isspace in p */
-            if (p < end && g_ascii_isspace(*p)) {
-                ++p;
-            } else {
-                ++t;
-            }
-        } else if (*t && p < end && *t == g_ascii_tolower(*p)) {
-            ++p, ++t;
-        } else {
-            break;
-        }
+    if (!val) {
+        return realsize;
     }
 
-    if (!*t && p == end) { /* if we managed to reach ends of both strings */
-        s->accept_range = true;
+    *val++ = '\0';
+    g_strchomp(header);
+    while (g_ascii_isspace(*val)) {
+        ++val;
+    }
+
+    trace_curl_header_cb(header, val);
+
+    if (!g_ascii_strcasecmp(header, "accept-ranges")) {
+        if (!g_ascii_strcasecmp(val, "bytes")) {
+            s->accept_range = true;
+        }
+    } else if (!g_ascii_strcasecmp(header, "Content-Range")) {
+        /* Content-Range fmt is `bytes begin-end/full_size` */
+        val = strchr(val, '/');
+        if (val) {
+            if (qemu_strtou64(val + 1, NULL, 10, &s->len) < 0) {
+                s->len = UINT64_MAX;
+            }
+        }
     }
 
     return realsize;
@@ -668,6 +676,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "ID of secret used as password for HTTP proxy auth",
         },
+        {
+            .name = CURL_BLOCK_OPT_FORCE_RANGE,
+            .type = QEMU_OPT_BOOL,
+            .help = "Assume HTTP range requests are supported",
+        },
         { /* end of list */ }
     },
 };
@@ -690,6 +703,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
 #endif
     const char *secretid;
     const char *protocol_delimiter;
+    bool force_range;
     int ret;
 
     bdrv_graph_rdlock_main_loop();
@@ -807,35 +821,56 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->accept_range = false;
+    s->len = UINT64_MAX;
+    force_range = qemu_opt_get_bool(opts, CURL_BLOCK_OPT_FORCE_RANGE,
+                                    CURL_BLOCK_OPT_FORCE_RANGE_DEFAULT);
+    /*
+     * When minimal CURL will be bumped to `7.83`, the header callback + manual
+     * parsing can be replaced by `curl_easy_header` calls
+     */
     if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1L) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION, curl_header_cb) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERDATA, s)) {
-        pstrcpy(state->errmsg, CURL_ERROR_SIZE,
-                "curl library initialization failed.");
-        goto out;
+        goto out_init;
+    }
+    if (force_range) {
+        if (curl_easy_setopt(state->curl, CURLOPT_CUSTOMREQUEST, "GET") ||
+            curl_easy_setopt(state->curl, CURLOPT_RANGE, "0-0")) {
+            goto out_init;
+        }
     }
+
     if (curl_easy_perform(state->curl))
         goto out;
-    /* CURL 7.55.0 deprecates CURLINFO_CONTENT_LENGTH_DOWNLOAD in favour of
-     * the *_T version which returns a more sensible type for content length.
-     */
+
+    if (!force_range) {
+        /*
+         * CURL 7.55.0 deprecates CURLINFO_CONTENT_LENGTH_DOWNLOAD in favour of
+         * the *_T version which returns a more sensible type for content
+         * length.
+         */
 #if LIBCURL_VERSION_NUM >= 0x073700
-    if (curl_easy_getinfo(state->curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD_T, &cl)) {
-        goto out;
-    }
+        if (curl_easy_getinfo(state->curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD_T,
+                              &cl)) {
+            goto out;
+        }
 #else
-    if (curl_easy_getinfo(state->curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD, &cl)) {
-        goto out;
-    }
+        if (curl_easy_getinfo(state->curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD,
+                              &cl)) {
+            goto out;
+        }
 #endif
-    if (cl < 0) {
+        if (cl >= 0) {
+            s->len = cl;
+        }
+    }
+
+    if (s->len == UINT64_MAX) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
                 "Server didn't report file size.");
         goto out;
     }
 
-    s->len = cl;
-
     if ((!strncasecmp(s->url, "http://", strlen("http://"))
         || !strncasecmp(s->url, "https://", strlen("https://")))
         && !s->accept_range) {
@@ -856,6 +891,9 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_opts_del(opts);
     return 0;
 
+out_init:
+    pstrcpy(state->errmsg, CURL_ERROR_SIZE,
+            "curl library initialization failed.");
 out:
     error_setg(errp, "CURL: Error opening file: %s", state->errmsg);
     curl_easy_cleanup(state->curl);
diff --git a/block/trace-events b/block/trace-events
index c9b4736ff884..d170fc96f15f 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -191,6 +191,7 @@ ssh_server_status(int status) "server status=%d"
 curl_timer_cb(long timeout_ms) "timer callback timeout_ms %ld"
 curl_sock_cb(int action, int fd) "sock action %d on fd %d"
 curl_read_cb(size_t realsize) "just reading %zu bytes"
+curl_header_cb(const char *key, const char *val) "looking at %s: %s"
 curl_open(const char *file) "opening %s"
 curl_open_size(uint64_t size) "size = %" PRIu64
 curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "reading %" PRIu64 " at %" PRIu64 " (%s)"
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index aae65d138c00..e77032e9e4b6 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -179,6 +179,12 @@ These are specified using a special URL syntax.
       get the size of the image to be downloaded. If not set, the
       default timeout of 5 seconds is used.
 
+   ``force-range``
+      Assume the HTTP backend supports range requests and avoid doing
+      a HTTP HEAD request to discover the feature. Typically S3
+      presigned URLs will only support one method and refuse other
+      requests types.
+
    Note that when passing options to qemu explicitly, ``driver`` is the
    value of <protocol>.
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b82af7425614..ff018c2d6bfb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4582,12 +4582,17 @@
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie
 #     data in a secure way.  See @cookie for the format.  (since 2.10)
 #
+# @force-range: Don't issue a HEAD HTTP request to discover if the
+#     backend supports range requests and rely only on GET requests.
+#     This is especially useful for S3 presigned URLs.  (since 11.0)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttp',
   'base': 'BlockdevOptionsCurlBase',
   'data': { '*cookie': 'str',
-            '*cookie-secret': 'str'} }
+            '*cookie-secret': 'str',
+            '*force-range': 'bool'} }
 
 ##
 # @BlockdevOptionsCurlHttps:
@@ -4605,13 +4610,18 @@
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie
 #     data in a secure way.  See @cookie for the format.  (since 2.10)
 #
+# @force-range: Don't issue a HEAD HTTP request to discover if the
+#     backend supports range requests and rely only on GET requests.
+#     This is especially useful for S3 presigned URLs.  (since 11.0)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttps',
   'base': 'BlockdevOptionsCurlBase',
   'data': { '*cookie': 'str',
             '*sslverify': 'bool',
-            '*cookie-secret': 'str'} }
+            '*cookie-secret': 'str',
+            '*force-range': 'bool'} }
 
 ##
 # @BlockdevOptionsCurlFtp:
-- 
2.53.0


