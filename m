Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC83FEFB49
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxFY-00079C-RZ; Fri, 27 Feb 2026 07:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxFB-0006tv-Al
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxF4-0001f2-OD
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so13307075e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 04:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1772196409; x=1772801209; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=utum6+s33iaXOZ1VCoUahsk6lJbB3MentN70PBUsR4c=;
 b=LPoOGpq9GuZnDe/PsOBwSgdeOXVgq4vYY2xcovo0IVK/ToyyLGi+b60+KpPLuzWj8R
 jmVzlWXb4ot6v54oaeS3Z3OSBlCSM/ua+fCbKAljgw92gHztFyi51TocQmlNK17OJ56y
 lPk+1o69BcqBAvpVDojLtXz4B3fSkP45rMvdllps7D9ErtDW33Bpljz06VWVmEGRXlBf
 Ye4WtCkJwIqj9xXg/cKe5hivYbQ3cxGyZ+8qmOqQCQN4tQ4xPSTPCAOjAFMiOJivZLgU
 ab1aYYzJ+6JgU1B84pI1JK6KUUwoaWZ7vMkwV0W8fCBapgZ+YV/cUMpFANuX6+8zaTUU
 WHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772196409; x=1772801209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=utum6+s33iaXOZ1VCoUahsk6lJbB3MentN70PBUsR4c=;
 b=PdBKRODrz6Um9GvntXqkC5vDcl/GejHkwxnhJJCrgtiyLYvZdOTc0Z6y8+7ZSs0wuc
 CD24vMyTj9PrbLbdLqbA6YVn6cVXgzTDoDXnib1XZvn3oTLRtsgmm4TpEvX+L8rVqX4V
 3MbtEQUjmZFRqjAxz2kbYaEqPYt4yC1FqJfBTeSRAQj1GPw8hWP2Fb13ESESlltq/ujH
 ZlsnnrkHbNd3OyU+QdEK0FP0t2M0WoEIqkUTXJJ4r6E+AkiLFE+DlM08JLBiOndP6VwS
 NX/nvG7yOQxROht3ArZPZIfKyYlhkYrKZ82YBv7ztr/5kYqhHNIDd3EQRdynMOa2MSZY
 byIg==
X-Gm-Message-State: AOJu0YzlsDm08J9MjcprPwqZoAa9cIThTsSnUxtPctKq1j7U1hOqum/V
 GKh0POkB762i6BTHBPFNFuJm0+Ywn5TxNgFXlQBHxs075rIdOkbNC22Jj8HSdLjWhfM=
X-Gm-Gg: ATEYQzyeswweVdQJGZca9aEfycjBu0fcVcXuRsbXi/4KAbirSOFe7Dt5g/zlC/qNKMG
 3ZaC4ba3JjUK1xDOFzNphmww3Oa13hRLpkDMA4UaPESjpl8dHnymrQumhTI1q0JaqDs5s5PovJp
 0VDIE+8xshBhalJBowEcQbqPRo+DlKfxkj1bn+3KvvYAhN/g43u/VPuZdiy9l/6n/lD9jhlyChk
 seVfBK+i/EUi7Ezywx7qArJeg93iMWo5T74HKdCKs0zn4awobsFTuM6o62ZgDOWan8OPaybB7hf
 kWb5LIjQNObohp34YannOJ7dbIMDb7B3mYobyl2BZQgqC+dYTohXfgapPQhB/Y62OB88RnYBV4Y
 Sndueq655OgsD/eoNydz0AD6/uaf7APaBJHmtK3bdgEc7yqYkIfqgItZGSnJPkPmE3LDmEM0v+k
 OPpYXEN8lpNjGhWVz8JIo3lpq2yuHXOzjD/8/5RZdDGD85lwvo
X-Received: by 2002:a05:600c:a16:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-483c9c02ef1mr36960715e9.18.1772196408647; 
 Fri, 27 Feb 2026 04:46:48 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm346099895e9.0.2026.02.27.04.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 04:46:48 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
Date: Fri, 27 Feb 2026 13:45:53 +0100
Subject: [PATCH v3 3/3] block/curl: add support for S3 presigned URLs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-fix-curl-v3-v3-3-eb8a4d88feef@scaleway.com>
References: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
In-Reply-To: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Antoine Damhet <adamhet@scaleway.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9839; i=adamhet@scaleway.com; 
 h=from:subject:message-id;
 bh=z8OIN6LEUGyjWk5XyYZrkXCTubPYiO201/qNmV0EHv4=; 
 b=owEBbQGS/pANAwAKAdwJoy885Y8+AcsmYgBpoZIxqcwIqjRH62r70KCwS2sTiY/L0jVx/vOG3
 b5q2HqGODaJATMEAAEKAB0WIQQCubVZtDHYaY6x8XzcCaMvPOWPPgUCaaGSMQAKCRDcCaMvPOWP
 PiS7CACrQly84n0XgJlkzdlRqTW5Vz+M2/0vtTD915xqVJHGSCnI+jOUNG72SncftpOjO2EGMvv
 /V+KKhZ6Ph36TPp9XqwR2gxjYkX6SfwmTeuet0HE8HoQY9PBJy50dZbLA8NDJ914lmNh2Zwisos
 U3XYyGD7bI15gKgagbt9GasEFEaqFxJ+uXoOjRl/Cpj551aNsZADlkg75KYlKFfk8ipGVRs1mqt
 sM/bdVIWch1OVE3Cn+3XrXW4inYkZVqAHRtLAyr+6v43XIurEJ8K+ffcXUb3LzJAyREU1Im8fYg
 q9aoHOVo1YNbblIO/htaNNrWE+eH/6CvXSBeYugcb6p7TCGp
X-Developer-Key: i=adamhet@scaleway.com; a=openpgp;
 fpr=4C3AEF45D70C65052D3F37E02A5F5236CFB70DEC
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
---
 block/curl.c                          | 104 +++++++++++++++++++++++-----------
 block/trace-events                    |   1 +
 docs/system/device-url-syntax.rst.inc |   6 ++
 qapi/block-core.json                  |   8 ++-
 4 files changed, 85 insertions(+), 34 deletions(-)

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
index aae65d138c00..996ce5418ffb 100644
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
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a7871705fa69..18ba3b732ff4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4582,12 +4582,18 @@
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

-- 
2.53.0


