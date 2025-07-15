Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C935C83F34
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublaC-00008d-8j; Tue, 15 Jul 2025 15:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky4-0004cQ-R6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky1-0001js-MW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoF5O3CxgYBmoMtLJ+YW7avYeQobfPJoF/M2V373gxU=;
 b=Pn/bK5+rs43+kGLvGudBcpwdbxUMppWtMNoHyuGtQ12kVR544E0BzlREJuysQLzzGvGTCO
 wJuXyb2zbE/AkyHUhFjSPuspxYmM+lB6DnEBhY6MIfSwCruLgcCaWAE68hkv4qjNmOiwiJ
 i5fDwIcl6UD0D4ni12ltSXQXV/Bw9DE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-du1X5F9ZN4adgu98xciA5Q-1; Tue,
 15 Jul 2025 15:05:21 -0400
X-MC-Unique: du1X5F9ZN4adgu98xciA5Q-1
X-Mimecast-MFC-AGG-ID: du1X5F9ZN4adgu98xciA5Q_1752606321
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 008EE19560B8; Tue, 15 Jul 2025 19:05:21 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 721F0197702B; Tue, 15 Jul 2025 19:05:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 49/57] qemu-img: resize: do not always eat last argument
Date: Tue, 15 Jul 2025 21:03:22 +0200
Message-ID: <20250715190330.378764-50-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

'qemu-img resize --help' does not work, since it wants more
arguments.  Also -size is only recognized as a very last
argument, but it is common for tools to handle other options
after positional arguments too.

Tell getopt_long() to return non-options together with options,
and process filename and size in the loop, and check if there's
an argument right after filename which looks like -N (number),
and treat it as size (decrement).  This way we can handle --help,
and we can also have options after filename and size, and `--'
will be handled fine too.

The only case which is not handled right is when there's an option
between filename and size, and size is given as decrement, - in
this case -size will be treated as option, not as size.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-20-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a02d271af1..36ef998a34 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4302,7 +4302,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret, relative;
-    const char *filename, *fmt, *size;
+    const char *filename = NULL, *fmt = NULL, *size = NULL;
     int64_t n, total_size, current_size;
     bool quiet = false;
     BlockBackend *blk = NULL;
@@ -4325,17 +4325,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
     bool image_opts = false;
     bool shrink = false;
 
-    /* Remove size from argv manually so that negative numbers are not treated
-     * as options by getopt. */
-    if (argc < 3) {
-        error_exit(argv[0], "Not enough arguments");
-        return 1;
-    }
-
-    size = argv[--argc];
-
     /* Parse getopt arguments */
-    fmt = NULL;
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
@@ -4345,7 +4335,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
             {"shrink", no_argument, 0, OPTION_SHRINK},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:hq",
+        c = getopt_long(argc, argv, "-:f:hq",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -4383,12 +4373,35 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_SHRINK:
             shrink = true;
             break;
+        case 1: /* a non-optional argument */
+            if (!filename) {
+                filename = optarg;
+                /* see if we have -size (number) next to filename */
+                if (optind < argc) {
+                    size = argv[optind];
+                    if (size[0] == '-' && size[1] >= '0' && size[1] <= '9') {
+                        ++optind;
+                    } else {
+                        size = NULL;
+                    }
+                }
+            } else if (!size) {
+                size = optarg;
+            } else {
+                error_exit(argv[0], "Extra argument(s) in command line");
+            }
+            break;
         }
     }
-    if (optind != argc - 1) {
+    if (!filename && optind < argc) {
+        filename = argv[optind++];
+    }
+    if (!size && optind < argc) {
+        size = argv[optind++];
+    }
+    if (!filename || !size || optind < argc) {
         error_exit(argv[0], "Expecting image file name and size");
     }
-    filename = argv[optind++];
 
     /* Choose grow, shrink, or absolute resize mode */
     switch (size[0]) {
-- 
2.50.1


