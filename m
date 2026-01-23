Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0446CD72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBwq-00037Z-8x; Fri, 23 Jan 2026 02:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBwo-000379-5D
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBwm-00029U-Ks
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjihiQhqWRy36zZV9uuA5B5Wf/vGCBkOyW5DDeKcshw=;
 b=gwOBTg08KT/JCDEje83kKLUVLeHzQsxSvq1IPnraEI2b6qdao1CUzIRik90JazkIquzUaU
 3zIak54f4w8fqNZZRiPPTIjelfiYW6+/zk6XZsangrDLhWiNYHb8d6WMKIN208OqaW5KYG
 S/M0V++h2NgD2Dnxpz97BWL0vSu+EXc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-DGWLjRh_Mtm1uziJ_wgUxw-1; Fri,
 23 Jan 2026 02:51:10 -0500
X-MC-Unique: DGWLjRh_Mtm1uziJ_wgUxw-1
X-Mimecast-MFC-AGG-ID: DGWLjRh_Mtm1uziJ_wgUxw_1769154669
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41D7B18003FC; Fri, 23 Jan 2026 07:51:09 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C56EC1956095; Fri, 23 Jan 2026 07:51:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 13/37] scripts/modinfo: use argparse
Date: Fri, 23 Jan 2026 11:49:16 +0400
Message-ID: <20260123074945.2563196-14-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.52.0


