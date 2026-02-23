Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFEDE98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSXe-0004e3-0h; Mon, 23 Feb 2026 04:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXQ-0004Q1-Oh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSXP-0006rP-8M
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fyZcdE9s/wqXZGBK+GCcVOqAQZtud4UZZpyJvMPL/w=;
 b=ZAuYxBN3v3r9ocwP/gXt5SgajObBaqatahbdxxhDbLRPRBfIt/YfSh2zayzV40wlhTQojA
 +t5B00isq8nHjQBx7gO+tEoVLl7J9/w1xpkrjBZwVd/tfZV2Q88/0opzd1mJkH4lSvJ58r
 nCBfcUieqQsyYyqzzRLqJ9pnRRYj/4g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-AZ5AdIHvPlW-rVFmCi02dA-1; Mon,
 23 Feb 2026 04:47:32 -0500
X-MC-Unique: AZ5AdIHvPlW-rVFmCi02dA-1
X-Mimecast-MFC-AGG-ID: AZ5AdIHvPlW-rVFmCi02dA_1771840052
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 048851956095; Mon, 23 Feb 2026 09:47:32 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 601911800674; Mon, 23 Feb 2026 09:47:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL v2 14/85] scripts/modinfo: use argparse
Date: Mon, 23 Feb 2026 10:45:32 +0100
Message-ID: <20260223094649.2005118-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This will allow to tweak argument handling more easily next.

Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/modinfo-generate.py | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index 8011c842caf..777d419aa33 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python3
 
+import argparse
 import os
 import sys
 from typing import Optional
@@ -79,24 +80,28 @@ def print_post() -> None:
     print("    /* end of list */")
     print("}};")
 
-def main(args: list[str]) -> None:
-    if len(args) < 3 or args[0] != '--devices':
-        print('Expected: modinfo-generate.py --devices '
-              'config-device.mak [modinfo files]', file=sys.stderr)
-        exit(1)
+def main() -> None:
+    parser = argparse.ArgumentParser(
+        description='Generate C code for QEMU module info'
+    )
+    parser.add_argument('--devices', required=True,
+                        help='path to config-device.mak')
+    parser.add_argument('modinfo', nargs='+',
+                        help='modinfo files to process')
+    args = parser.parse_args()
 
     # get all devices enabled in kconfig, from *-config-device.mak
     enabled = set()
-    with open(args[1]) as file:
+    with open(args.devices) as file:
         for line in file.readlines():
             config = line.split('=')
             if config[1].rstrip() == 'y':
-                enabled.add(config[0][7:]) # remove CONFIG_
+                enabled.add(config[0][7:])  # remove CONFIG_
 
     deps = set()
     modules = set()
     print_pre()
-    for modinfo in args[2:]:
+    for modinfo in args.modinfo:
         with open(modinfo) as f:
             lines = f.readlines()
         print(f"    /* {modinfo} */")
@@ -116,4 +121,4 @@ def main(args: list[str]) -> None:
         exit(1)
 
 if __name__ == "__main__":
-    main(sys.argv[1:])
+    main()
-- 
2.53.0


