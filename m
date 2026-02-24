Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5601F3C9A0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuj8-0003kN-6j; Tue, 24 Feb 2026 10:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj6-0003jc-UI
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj3-00087C-Kq
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:32 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4398913af88so575412f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1771948408; x=1772553208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kj8T6mb1572v2v1TIxJJ9XBRNaQfvElom9Lfk0/2aVA=;
 b=YZbfYuf5HanryEjdzGXFOD1QMv4OPdphQeAJRlbwRzOonEgJQ1iodFz6awcUC/xknZ
 8OVmHHeuEUp0/yNA8sNkuvY5twfQxSm264oIpFT1Ky8L6V4tHp6q+qkumrjYJkw4729I
 A5oyCL0B1+Ouqk6X+zMnNlxzHoMFzxZTxk2e4l/gobAlwNiuNnw8TSlaCP8bSeBTLnUu
 pSucQ4KLzLrteS/E/h1+UK4dh6QCroA14c2TviBQLwUlYAeCp1Qgmb/Qg1wZ3p+91IJe
 ZbRM4I2Yu2iW7dj2XfF2m68cRIsFwYoD5K3Ph271YM1+bxuVxaEbkFXDy6P1BxYScddj
 Qliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948408; x=1772553208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kj8T6mb1572v2v1TIxJJ9XBRNaQfvElom9Lfk0/2aVA=;
 b=Vl+LD9bGrpoQC4bnH12jEJgko9MOi5GdLJivMzvBM1LWFa7IDHmv8+iDPlAMTW6mYQ
 gjGhCLD8cOzusd3jKxmhWczD3XaoRYC11PaDeQsk0pRGLuYOJG3A7MpNGMs9Q7oOD1y6
 CxHvE4ispoObYBPPrRmCeUVCS1Qb4O7DCsZLAX93C79EQPSpYh2saQhJhBfgtzzF0Eih
 cix/mSIh6NBIgebOZKgW1fLA4+05Vppr2fszBKyn3MHO0AEVnn6Gq/zZN1JircBDaFHv
 w0B0KtmG1514xhwFbQXd21r2hxD6MEqcG5esmj7Ys3MXqMooygXhG7zvu+GQJMCkSYmx
 xC9w==
X-Gm-Message-State: AOJu0Yx41/LzcLJOyXzLlOwtbBf0w0Mne5afjWEQnRUM9ufPnPOlBe4C
 EaikHB4fRWOINWHLsWCMigEqwfWukySza541AWIrolS9AilpE1gBkPixQxhQlokDGolbaVAqHuH
 H+Ya9
X-Gm-Gg: ATEYQzz4zUiQNzbsHXcoPgkhONy0TEGaDFxhMANFg+RMIohYlwrsjuP/6Sa6uTr99Yr
 kt3vD2jG11nQ93IPA/+AfDrbYayj4kz7KsExbi5K4p/Or9FmD0DrImDjZyrMmoYmZxmAfbGUMaM
 1Jp+2DOCoLfDA5mcbqrbU1g6kluDxFmUV7oYbR5dENJq/ctQbdYF+XQRh/J5JRoDZTv6lBPWnGw
 Kb4OSeO4KlSYPx/3ivfN2jGXZamm8drrFj4phU5q31MfjeYLVXOAdIxRso3uDGEW/T1zprLpHPW
 wLhUzK6f/Qnd1pLJqb4VGBgBAxOTDXsco8JDgCwf0ZNbfq++0/ARZul5TNocmc8tVs9Cjlcaikd
 pbNCxZoxHxlCdZ9yLrkVFVZNoEHSCS/kvUr1b9rV+N7L9GmVcS4Lk7nobwTZpG9SKdZqffEcb8y
 Fz+nqqkugP/Yg0t6e9FZa/2NY=
X-Received: by 2002:adf:e346:0:b0:437:6efe:94c5 with SMTP id
 ffacd0b85a97d-4396f1564b2mr17444321f8f.2.1771948407951; 
 Tue, 24 Feb 2026 07:53:27 -0800 (PST)
Received: from localhost ([2a01:e0a:e9e:c3d0:7a5b:f76a:6cf6:aac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54c5csm27753096f8f.38.2026.02.24.07.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:53:27 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 3/3] block/curl: add support for S3 presigned URLs
Date: Tue, 24 Feb 2026 16:51:31 +0100
Message-ID: <20260224155314.1658988-4-adamhet@scaleway.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224155314.1658988-1-adamhet@scaleway.com>
References: <20260224155314.1658988-1-adamhet@scaleway.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=adamhet@scaleway.com; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
---
 block/curl.c                          | 104 ++++++++++++++++++--------
 block/trace-events                    |   1 +
 docs/system/device-url-syntax.rst.inc |   6 ++
 qapi/block-core.json                  |   9 ++-
 4 files changed, 86 insertions(+), 34 deletions(-)

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
index aae65d138c00..445e2a0a4157 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -179,6 +179,12 @@ These are specified using a special URL syntax.
       get the size of the image to be downloaded. If not set, the
       default timeout of 5 seconds is used.
 
+   ``force-range``
+      Assume the HTTP backend supports range requests and avoid doing
+      an HTTP HEAD request to discover the feature. Typically S3
+      presigned URLs will only support one method and refuse other
+      request types.
+
    Note that when passing options to qemu explicitly, ``driver`` is the
    value of <protocol>.
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a7871705fa69..50e7078cbec0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4582,12 +4582,19 @@
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie
 #     data in a secure way.  See @cookie for the format.  (since 2.10)
 #
+# @force-range: Don't issue a HEAD HTTP request to discover if the
+#     http server supports range requests and rely only on GET
+#     requests.  This is especially useful for S3 presigned URLs where
+#     HEAD requests are unauthorized.  Defaults to false.
+#     (default: false; since 11.0)
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
-- 
2.53.0


