Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A605F33813
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ppm-0000te-83; Tue, 17 Mar 2026 04:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2Ppk-0000tR-II; Tue, 17 Mar 2026 04:31:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w2Pph-0000Pp-Pj; Tue, 17 Mar 2026 04:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773736271; bh=Y38zX+TH4wKoRrc0z4ZeVSVneQS/3iIy/GomhQJ8Nms=;
 h=From:To:Cc:Subject:Date;
 b=J8TXR9sohbBbPr9gwpN6QG8Yf0jyVoiqGom39/ReLk+apRRpvg5jLLAAqlwu/Pur4
 rHXwK/5kHqDzORsFiVVHmzqeplCz1nRe4YQPj0IwWno6KuwoztyUarsfhk3TFYMc8/
 uPqbIE4Q6UsksYWbVNNVKJ/X6TitSCiIvObZZ/gshRfN03U08VXWuE8HGHJfnr1HKU
 yLg2YsD7p/+yw0v0TcN2vsZXIHJ9O3oNHRPUL0PKop57fbdKeCfsmXNgS54le3J1yX
 Qra78JFfgSL2ThWzwtNciwtVbdYca3yKC1LF6HR/hc/VDSfbMclbNKERBlKtXRv01s
 8B4s3CX+4wUng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DB90A19435E;
 Tue, 17 Mar 2026 11:31:11 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E24C4381049;
 Tue, 17 Mar 2026 11:31:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Christopher Palmer-Richez <crichez@pm.me>
Subject: [PATCH RFC] net/slirp: allow hostfwd socket paths with dashes
Date: Tue, 17 Mar 2026 11:31:08 +0300
Message-ID: <20260317083108.163043-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The format of hostfwd parameter is:
  hostfwd=hostpart-guestaddr:guestport
so a minus sign can not be part of the hostpart.
If hostpart specifies a unix socket path, this becomes problematic.

To solve this, look for the LAST minus/dash char in the string,
not first.

Unfortunately, [-guestaddr] is optional (defaults to 10.0.0.15),
so we still can't parse the thing in an uniform way.

Extend get_str_sep() to accept one more parameter, to indicate if
first or last separator is needed, and modify all callers to ask
for first separator.  Update slirp_hostfwd to search for the last
separator when parsing unix domain socket path.

Inspired-by: Christopher Palmer-Richez <crichez@pm.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/347
---
 net/slirp.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 04925f3318..804d430890 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -49,12 +49,18 @@
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
 
-static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
+typedef enum {
+    SEP_FIRST,
+    SEP_LAST
+} sep_type;
+
+static int get_str_sep(char *buf, int buf_size, const char **pp, int sep,
+                       sep_type which)
 {
     const char *p, *p1;
     int len;
     p = *pp;
-    p1 = strchr(p, sep);
+    p1 = which == SEP_FIRST ? strchr(p, sep) : strrchr(p, sep);
     if (!p1)
         return -1;
     len = p1 - p;
@@ -479,7 +485,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     }
 
     if (vnetwork) {
-        if (get_str_sep(buf, sizeof(buf), &vnetwork, '/') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &vnetwork, '/', SEP_FIRST) < 0) {
             if (!inet_aton(vnetwork, &net)) {
                 error_setg(errp, "Failed to parse netmask");
                 return -1;
@@ -760,7 +766,7 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
     }
 
     p = src_str;
-    if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (!p || get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
 
@@ -772,7 +778,7 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
         goto fail_syntax;
     }
 
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
@@ -827,7 +833,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     socklen_t host_addr_size;
 
     p = redir_str;
-    if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (!p || get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         fail_reason = "No : separators";
         goto fail_syntax;
     }
@@ -848,7 +854,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
     if (is_unix) {
-        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &p, '-', SEP_LAST) < 0) {
             fail_reason = "Missing - separator";
             goto fail_syntax;
         }
@@ -888,7 +894,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         host_addr.in.sin_family = AF_INET;
         host_addr.in.sin_addr.s_addr = INADDR_ANY;
 
-        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
             fail_reason = "Missing : separator";
             goto fail_syntax;
         }
@@ -898,7 +904,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
             goto fail_syntax;
         }
 
-        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &p, '-', SEP_FIRST) < 0) {
             fail_reason = "Bad host port separator";
             goto fail_syntax;
         }
@@ -913,7 +919,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         host_addr_size = sizeof(host_addr.in);
     }
 
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         fail_reason = "Missing guest address";
         goto fail_syntax;
     }
@@ -1125,19 +1131,19 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
     int port;
 
     p = config_str;
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     if (strcmp(buf, "tcp") && buf[0] != '\0') {
         goto fail_syntax;
     }
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     if (buf[0] != '\0' && !inet_aton(buf, &server)) {
         goto fail_syntax;
     }
-    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, '-', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     port = strtol(buf, &end, 10);
-- 
2.47.3


