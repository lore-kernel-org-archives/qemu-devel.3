Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E3FD4F05
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvZ-0003tO-9c; Tue, 10 Mar 2026 12:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvW-0003h4-Kx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvT-00010E-Rq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NYvw0OxBs5HdokP5YldS9J+T2s8QfdGmfB9yCRG9hQ=;
 b=ahiULIqrdyrPRwfx+vXYZV8GtaeGtggzzJRdWkSg6mKnK5jmvtFqUjyUBoSQQ4KQ5BvI+8
 gcwwPB2lAVwNh9OHG/vLlaDtrRWee7QQOnGzTsE4o6QrKNdQxKeDdnSziedD3CsB/XD0j7
 3VEVNdLSYXhwff/pFggayDOExRLOVm4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-Ime2abjDPvCAHVFPOXL4UA-1; Tue,
 10 Mar 2026 12:27:17 -0400
X-MC-Unique: Ime2abjDPvCAHVFPOXL4UA-1
X-Mimecast-MFC-AGG-ID: Ime2abjDPvCAHVFPOXL4UA_1773160036
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A6CF19560B3; Tue, 10 Mar 2026 16:27:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10E9819560A6; Tue, 10 Mar 2026 16:27:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 28/28] block/curl: add support for S3 presigned URLs
Date: Tue, 10 Mar 2026 17:26:22 +0100
Message-ID: <20260310162622.333137-29-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Antoine Damhet <adamhet@scaleway.com>

S3 presigned URLs are signed for a specific HTTP method (typically GET
for our use cases). The curl block driver currently issues a HEAD
request to discover the web server features and the file size, which
fails with 'HTTP 403' (forbidden).

Add a 'force-range' option that skips the HEAD request and instead
issues a minimal GET request (querying 1 byte from the server) to
extract the file size from the 'Content-Range' response header. To
achieve this the 'curl_header_cb' is redesigned to generically parse
HTTP headers.

$ $QEMU -drive driver=https,\
             'url=https://s3.example.com/some.img?X-Amz-Security-Token=XXX',
             force-range=true

Enabling the 'force-range' option without the web server specified with
@url supporting it might cause the server to respond successfully with
'HTTP 200' and attempt to send the whole file body. With the
'CURLOPT_NOBODY' option set the libcurl will skip reading after the
headers and close the connection. QEMU still gracefully detects the
missing feature. This might waste a small number of TCP packets but is
otherwise transparent to the user.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
Message-ID: <20260227-fix-curl-v3-v3-3-eb8a4d88feef@scaleway.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json                  |   8 +-
 docs/system/device-url-syntax.rst.inc |   6 ++
 block/curl.c                          | 104 ++++++++++++++++++--------
 block/trace-events                    |   1 +
 4 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8ba1fdc49d6..f8d446b3d6e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4587,12 +4587,18 @@
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie
 #     data in a secure way.  See @cookie for the format.  (since 2.10)
 #
+# @force-range: Don't issue a HEAD HTTP request to discover if the
+#     http server supports range requests and rely only on GET
+#     requests.  This is especially useful for S3 presigned URLs where
+#     HEAD requests are unauthorized.  (default: false; since 11.0)
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
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index aae65d138c0..996ce5418ff 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -179,6 +179,12 @@ These are specified using a special URL syntax.
       get the size of the image to be downloaded. If not set, the
       default timeout of 5 seconds is used.
 
+   ``force-range``
+      Don't issue a HEAD HTTP request to discover if the http server
+      server supports range requests and rely only on GET requests. This
+      is especially useful for S3 presigned URLs where HEAD requests
+      are unauthorized. It defaults to 'false'.
+
    Note that when passing options to qemu explicitly, ``driver`` is the
    value of <protocol>.
 
diff --git a/block/curl.c b/block/curl.c
index 6dccf002564..66aecfb20ec 100644
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
index c9b4736ff88..d170fc96f15 100644
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
-- 
2.53.0


