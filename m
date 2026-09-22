Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E919C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9710-0002vc-Ko; Tue, 22 Sep 2026 16:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970K-0001IA-MQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970J-0000FZ-4Q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUuXliWp734quSaNvNUDA6qjChfAYzCXNyUYL5PAT1I=;
 b=MBKcGBFNmMlj8z8QmwNER6tINb0K1yrsQFhP8bZbVbz52z8q0Rne4CX2sQT6LquxogvxlE
 L3JwKX8084leJrCtoExFrCsNYn8i4zQfQwaMBf4LRXAarcmgsZUZUu4C7eUaB+1q8bc5cZ
 8KAPy+MI6vb78XKrTaRfqQQXSVDuPSQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-QVCG-KgNMQ6ap6iM2lw-Ww-1; Tue,
 22 Sep 2026 16:22:13 -0400
X-MC-Unique: QVCG-KgNMQ6ap6iM2lw-Ww-1
X-Mimecast-MFC-AGG-ID: QVCG-KgNMQ6ap6iM2lw-Ww_1790108532
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B6501935335; Tue, 22 Sep 2026 20:22:12 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BAB41956086; Tue, 22 Sep 2026 20:22:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:58 +0400
Subject: [PATCH 51/88] qemu-iotests/300: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-51-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0eoIxhURmoezbw0lX1uJddsbqu8+ijpOzKc1ZxiN8BQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxqGijIf8j1dEEGrZdHXeSaUoDJOMmiRR0F
 dwm4wcOCJKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5eNBD/91c/hEgzLHhPVxY2QYE32WzcZPhQGTJS6uKpk3+QKXFoYVaoYB8MLKp1swgAEyqCkHMsq
 BEdVfhHHwR0ZQkCTbnC6YcowPMYPBdrXraGrPGbzxqchf4dwwq9j8FcJkD+dOEM9Ob4tUrEgKgQ
 x4clvrXJfuBFWn5GYKLE35hDnsse6BwwOQIzCQd+1I8vio0mGEk2AGaBk7vQG1toIfR2C3TdD+i
 6e8XBMqOhkEddN7Qb3nMaycD4JUSyeiBFODsdang0IkiuW6AE6xA1jUspt4OMRj/xQDTZWV1+8j
 Cr8Rwr/WdeSycjAWwt/i5+7cbTfS319UCcyGFjricPbm+vdfcEpy33jh7M+5hsAk0PT9pHXm7W7
 Dn39y/J1uf2Ndr30kICTtclNQTNIeUaN53jtO+QqLKAKcC8CuON33QypOqAuPbDjgRkB56ACKr8
 Ewft/O/ggr1p/yLffxYD4rcxdkmuulMWrcbi9BVSNHFN77lYea3nZCUgBvkLeOFzl59+/h+Ut7G
 xoakWXD/nWzh9do9+PKlcJxDss0tJ2D3IyCh/0R2sma60jKLuypxut/1W9Y5pna2GJgS0QuTeSF
 NDoIzZ7O80MNSOIm/w9tVFecTKkqkGU2Fn1xfSUPywTZQNLBnzD/6xQRgUFdX6AO2ooIlTSAWo8
 f1N+ydJbZEde4bw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Migrate away from HMP "info migrate_parameters", and use QMP
query-migrate-parameters instead. We no longer check HMP formatting
output though, but this is not meant to be a testable interface.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/300 | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index bcc6fa972581..c6a7519b67ce 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -21,7 +21,6 @@
 
 import os
 import random
-import re
 from typing import Dict, List, Optional
 
 import iotests
@@ -136,8 +135,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         Invoke migrate-set-parameters on @vm to set the given @mapping.
         Check for success if @error is None, or verify the error message
         if it is not.
-        On success, verify that "info migrate_parameters" on HMP returns
-        our mapping.  (Just to check its formatting code.)
+        On success, verify that query-migrate-parameters returns
+        our mapping.
         """
         result = vm.qmp('migrate-set-parameters',
                         block_bitmap_mapping=mapping)
@@ -145,30 +144,12 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         if error is None:
             self.assert_qmp(result, 'return', {})
 
-            result = vm.qmp('human-monitor-command',
-                            command_line='info migrate_parameters')
-
-            m = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
-                          result['return'], flags=re.MULTILINE)
-            hmp_mapping = m.group(0).replace('\r', '') if m else None
-
-            self.assertEqual(hmp_mapping, self.to_hmp_mapping(mapping))
+            result = vm.qmp('query-migrate-parameters')
+            qmp_mapping = result['return'].get('block-bitmap-mapping')
+            self.assertEqual(qmp_mapping, mapping)
         else:
             self.assert_qmp(result, 'error/desc', error)
 
-    @staticmethod
-    def to_hmp_mapping(mapping: BlockBitmapMapping) -> str:
-        result = 'block-bitmap-mapping:\n'
-
-        for node in mapping:
-            result += f"  '{node['node-name']}' -> '{node['alias']}'\n"
-
-            assert isinstance(node['bitmaps'], list)
-            for bitmap in node['bitmaps']:
-                result += f"    '{bitmap['name']}' -> '{bitmap['alias']}'\n"
-
-        return result
-
 
 class TestAliasMigration(TestDirtyBitmapMigration):
     src_node_name = 'node0'
@@ -683,5 +664,4 @@ class TestAliasTransformMigration(TestDirtyBitmapMigration):
         self.verify_dest_error(None)
 
 if __name__ == '__main__':
-    iotests.main(supported_protocols=['file'],
-                 require_hmp=True)
+    iotests.main(supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


