Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A667DC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublZJ-0005eR-BZ; Tue, 15 Jul 2025 15:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxa-0004PF-RK
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxX-0001Ty-HK
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtUCpwx+B+m845VIJ5WbVmDfe+AsAs8PMzBj9Z+WtJg=;
 b=WKVs7iQMXhRJtf1DVcn8DbdWV7T1ICTXzHO9g+RkPdsYl3imTD+fMUMTq5Egd9mRW6j8tl
 q2mxd6G5suZsWsqN6G7zPxPyYS9lcxbwmuCOEqjgmRnsYGqfks1ZfVaFgYwchAn9r/t0zU
 gtcnCs/Djzcmtptdhh1x8gd4+/barSU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-jwR3GiocOkGGxMcqJjP0FA-1; Tue,
 15 Jul 2025 15:04:56 -0400
X-MC-Unique: jwR3GiocOkGGxMcqJjP0FA-1
X-Mimecast-MFC-AGG-ID: jwR3GiocOkGGxMcqJjP0FA_1752606295
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75C4A19560B3; Tue, 15 Jul 2025 19:04:55 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9D4F197702B; Tue, 15 Jul 2025 19:04:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 37/57] qemu-img: check: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:10 +0200
Message-ID: <20250715190330.378764-38-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add missing long options and --help output,
reorder options for consistency.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-8-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 60 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b60b4d38df..d310f0de0d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -805,31 +805,57 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
             {"format", required_argument, 0, 'f'},
+            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 'T'},
             {"repair", required_argument, 0, 'r'},
+            {"force-share", no_argument, 0, 'U'},
             {"output", required_argument, 0, OPTION_OUTPUT},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
-            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:r:T:qU",
+        c = getopt_long(argc, argv, "hf:T:r:Uq",
                         long_options, &option_index);
         if (c == -1) {
             break;
         }
         switch(c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
         case 'h':
-            help();
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-T CACHE_MODE] [-r leaks|all]\n"
+"        [-U] [--output human|json] [-q] [--object OBJDEF] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specifies the format of the image explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -T, --cache CACHE_MODE\n" /* why not -t ? */
+"     cache mode (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -r, --repair leaks|all\n"
+"     repair errors of the given category in the image (image will be\n"
+"     opened in read-write mode, incompatible with -U|--force-share)\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  --output human|json\n"
+"     output format (default: human)\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or an option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case 'T':
+            cache = optarg;
+            break;
         case 'r':
             flags |= BDRV_O_RDWR;
 
@@ -842,24 +868,20 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
                            "(expecting 'leaks' or 'all'): %s", optarg);
             }
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OUTPUT:
             output_format = parse_output_format(argv[0], optarg);
             break;
-        case 'T':
-            cache = optarg;
-            break;
         case 'q':
             quiet = true;
             break;
-        case 'U':
-            force_share = true;
-            break;
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
     if (optind != argc - 1) {
-- 
2.50.1


