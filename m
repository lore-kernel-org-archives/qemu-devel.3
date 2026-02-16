Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEABE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwcV-0006gk-Iz; Mon, 16 Feb 2026 06:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaa-0005CS-VP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaY-0007OU-98
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTkiQYWm5xuq4+X2pL9s+wlSjm2scNT6GBeBn7FnNBE=;
 b=aKQ9r3t2t9zMY9orV2cUDS6XgIv2FSNRNoBfOMPGT7ZuBELTx77+qSi+WIu6ooQ358HH4I
 C9NgR89P490zCLmIgVP1NYXqow24U04PNfNzbVFLU1vToriAK8IWU1P0ATivN7z1UxracG
 0NgJBOPaus4HlG4z7aoezPI+OaJywdU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-dW163pPLN9qyjDaw4h8kVg-1; Mon,
 16 Feb 2026 06:16:20 -0500
X-MC-Unique: dW163pPLN9qyjDaw4h8kVg-1
X-Mimecast-MFC-AGG-ID: dW163pPLN9qyjDaw4h8kVg_1771240578
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CC8918004BB; Mon, 16 Feb 2026 11:16:18 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B648719560AD; Mon, 16 Feb 2026 11:16:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:03 +0100
Subject: [PATCH 14/85] scripts/modinfo: use argparse
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-14-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uHM8i5gf/zzsBO3Kh9KkNMm19zV45EUZ0obNueX90RM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOH/nUyiGANqnJl0lpVEmXIA13RQcePg0mV
 tRgOYRXje+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5ZuBD/4oN+R8DrwkF5AZJcF8hNM251PNwWLImR++7+b8SzneLnJpCIRzAOa32GfGjJRpz/Hgbs7
 bWLWdTlvjaA/sXAKTkODXEYCh8AdQry56n9TaZQ8JRI6yysHrVju5AlOlLoyeXTzyEfn/29r/aj
 uhOr2vd6tz56r37amNnHnLNJ9S6qvOCpla+fhunhQLp/qe91ouuxM3PRPyoOU9p/cKu2Lg/JV+h
 jOyczxjCYxEkxh3zF7Nb6P5zfKlp3UjyfcE8D2esa7xN1gVAwcKIy6VMFpsHDsKPNRvqz+CUSHi
 A2DCvVhCnhZs8NocXOPATLANNEWLr7m55w30EVvafH5MyblcqgCdUb4Jen5u6aT38TXknmZFn/b
 xqjCgRn37HRJFIf+o8pxhABay0dTDl04+vkbXxPI3ffcI7JP2rU69ayd4NhWtdOIpNOL1f/Firj
 iO3rlL+RNHQmNHulA2+8BJDZ7rrf0Zk8Xe83jJ/7e7FdqtIiib3DQGnQZj8X6bk7CG+z+VCS+v7
 rt6tqT85rZHmjX8LBVxn+JmF0TKdKcmlCz6ZXWFok64/apAY6SOW5LCYdJXhrBCVGoMODuyES88
 IKnNrdLr5r64fcyjPnQIZVGdla5VG2Vb1wW/nD6ikej48nGPC2I0jBQ6af7dK740gd6eMdhcPr5
 6i95ORloydmdbdw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This will allow to tweak argument handling more easily next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


