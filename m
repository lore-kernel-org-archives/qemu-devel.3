Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10554C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yT-0005Wb-LR; Tue, 22 Sep 2026 16:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96y6-0004ZJ-GN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96y4-000869-Qh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPlnf4vOwH0lk+JYzT5+ypAwsqr9czf9Ndd8LFkbA5Q=;
 b=f7swB/GGafMXYGupg2UHcYB40Xe3FGaAfVKU2Eynqy9jYwBhkd1RZ5cRzVqw1yvj/sO1/d
 xbJr7UYhvUyMGeeq0wPYrTUvFld4Mb7EHTdH9kBo3qq5c5orSdxgqBSaAddKRUaO8ygA30
 fi5Msj9g7LHAhrODSCS2F32vW2n+5ZM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-KTQ7ewwRMqyrZIbgp7Wigg-1; Tue,
 22 Sep 2026 16:19:53 -0400
X-MC-Unique: KTQ7ewwRMqyrZIbgp7Wigg-1
X-Mimecast-MFC-AGG-ID: KTQ7ewwRMqyrZIbgp7Wigg_1790108392
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786911955DC7; Tue, 22 Sep 2026 20:19:52 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B13F418; Tue, 22 Sep 2026 20:19:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:19 +0400
Subject: [PATCH 12/88] qemu-iotests/216: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-12-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dBGKEZNeNd47WGb/fgyqvzVShRX06zcUsc4yIRp7Sq8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuti3y/wHJoSwoBfs+/wCjgRQ7V2e2r5LMk
 0QKH1sybUaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5cBoD/sGM/HmcTPPS42YaaCIsiYN5IG38icrhIINSkSIyuw82A4Non3O7pCYyyBdmvCJTf76a5X
 CO/CE5hKqGR0QHc4fuKJneismSKkbzGWbZZGJSU2CAl7xRC83N2l6+uIpbcFtZ1+RMWf1Ik8Iv8
 1dox9xrPQlRTlWz0wP7Ynin15iKdhZOR611vLlF0LSrS6AF5ttz56Hatbf2JLilad9UXBlCuF4u
 7lIamjsROwkmyYFCX5Z2BgX14fKxE+blbSOMYjIK3c3sn7exJT6l5afM8zQH1QuNpLPliF0vArz
 dq4+x2BXEKRU84uJwHvKgCdruyZHkQasSnvEMmJrfKQ5HnqwdhRzrtKccLOjX1RTsGh9/NgzCQu
 V3m/FdzxZFTACTMXTfGNd08RXirqdDZ6f4dO6HqSzdpGDHTR/80FmoDxPXorSnMUsjo+vyz50JO
 S/x9YYJxKMIvOOsA77tKrmjCMoenCoj1TIaBBITQ5jc/Y7tgZKlcrq3+GI18Glk5MdKkNS19RkV
 OlzenQR8FRt9h4Y55FXdnYizwZFD838m/5KQIfaNj2XIuqf6XSYmAKXxvyBSAQyz3UMODFhHJy4
 Tu+JzCFYV+NDvdJv0YqCnk/NUPI158/aJ1yQbR8kKWs01gnAUexUHOy1yex6JTxYAkJNBUwupfD
 6J/HDimEig3PLzg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Log command, although this is not strictly needed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/216     | 6 ++----
 tests/qemu-iotests/216.out | 3 ++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 4eabada9b35d..2d32b0f126ce 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -25,8 +25,7 @@ from iotests import log, qemu_img, qemu_io
 
 # Need backing file support
 iotests.script_initialize(supported_fmts=['qcow2', 'qcow', 'qed', 'vmdk'],
-                          supported_platforms=['linux'],
-                          require_hmp=True)
+                          supported_platforms=['linux'])
 
 log('')
 log('=== Copy-on-read across nodes ===')
@@ -102,8 +101,7 @@ with iotests.FilePath('base.img') as base_img_path, \
                     }))
 
     # Trigger COR
-    log(vm.qmp('human-monitor-command',
-               command_line='qemu-io node0 "read 0 64M"'))
+    vm.qmp_qemu_io('node0', 'read 0 64M', use_log=True)
 
     vm.shutdown()
 
diff --git a/tests/qemu-iotests/216.out b/tests/qemu-iotests/216.out
index a70aa5cdaeb9..c2d8101e8858 100644
--- a/tests/qemu-iotests/216.out
+++ b/tests/qemu-iotests/216.out
@@ -8,7 +8,8 @@ Done
 --- Doing COR ---
 
 {"return": {}}
-{"return": ""}
+{"execute": "x-qemu-io", "arguments": {"command": "read 0 64M", "device": "node0"}}
+{"return": {"human-readable-text": "read 67108864/67108864 bytes at offset 0\n64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 
 --- Checking COR result ---
 

-- 
2.56.0.rc0.29.g47ce80527c56


