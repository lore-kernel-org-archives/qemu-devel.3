Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9C5C98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970H-0000yv-9G; Tue, 22 Sep 2026 16:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zG-0007yy-JM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zE-0008Vi-Q6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seWtzgqeJn1gI0P0xYdXoTyLGs8by+U3ufozSMltnto=;
 b=NOMYb95Av027pJTmhhOrXn4Xqo0oyy+C9+fzvF5z0xIBslts0CR+2R0hIlnqdtKH+SDzmO
 1OH+9OHCFAH8vSZZZwqCnr8lR9TwUPxFQyi29jV254qMRVxYF64rfa1z4xOt6I1Ffksu/3
 k4OBI8cFzMqrs1Ea/KTXElGhQ+Y/ILk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-cAMpvAlVPLeTou0UyJZNzw-1; Tue,
 22 Sep 2026 16:21:04 -0400
X-MC-Unique: cAMpvAlVPLeTou0UyJZNzw-1
X-Mimecast-MFC-AGG-ID: cAMpvAlVPLeTou0UyJZNzw_1790108463
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFB8C1944B2E; Tue, 22 Sep 2026 20:21:03 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E71A6180056E; Tue, 22 Sep 2026 20:21:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:39 +0400
Subject: [PATCH 32/88] qemu-iotests/236: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-32-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kLIKc+93mA9l8lzVIzG4tw8CQ4RlO24YAy6CK6vsuRs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwWFkWgE+g4GCAlu/BhaCCZL4c67rfTFeMz
 j1HE4HufKmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5asvD/wMjMG61NIfs9UoU8Vy+plXxlaDDHAWXFA1T6arDjY+0qvCiLcfKswJ6xOWUElHN8uUeLl
 tCgjt7L+7j6OYa3kw/aWdKPiNKWJiCylQXRYAOWqbm+rCLe6gQp+GgyPC3/rCdI+VZOKyxU+raA
 dFeOUycy9olOZ2xW7xYHr21lc05NDU2c+UPM3mX0RPyOSyhFJWQBLlJygCfXXU8M2++m/yP8XES
 m0IilOIyFZ53Om7HSu1UuqyTHucHbgq/wEWSf4UrmZfITHmyuQPxmdCyw5ddi+TgAhClj0/5ymq
 MyjZYyjIQDQUhISQCsIm4QD4fkJfUnyhcNcxz5T35K+rWbZCzVNXNpc/NfjaFLNZ1X79AVo9k70
 nSiFFNPGsKcNkaGjY1PGWTgddNQumFvj8DPU+ybClBU/jRjDMMlwhnhYpLWsYq/XOSrTe0B3wbk
 w3uxnx7Qh80C2IZ5dUKnC/D42ylDFlUwal98cHhoQj9ZzeFY4LT6q24HDLwXPMDFD7h2zf56bn+
 19iB4At1rG2YS/6dWoWz2daLv1xKk14SjVxONIr7V8S3I1mtJp1H/zUKSq2NEX9AKffLGov2kdc
 LsvkNyShEIRwDbIE/YPM9iwCc0MEDqrexUWY60u05IU1eD2qae2s8JFdIzrzWlCoyn8D1Bef6I3
 1pPcX5nU+Oar5sg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

No need to log empty results, qmp_qemu_io() already checks for success.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/236     | 7 +++----
 tests/qemu-iotests/236.out | 8 --------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 3cf0de4043f6..0d2c1780df71 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -23,8 +23,7 @@
 import iotests
 from iotests import log
 
-iotests.script_initialize(supported_fmts=['generic'],
-                          require_hmp=True)
+iotests.script_initialize(supported_fmts=['generic'])
 size = 64 * 1024 * 1024
 granularity = 64 * 1024
 
@@ -62,7 +61,7 @@ with iotests.FilePath('img') as img_path, \
     for p in patterns:
         cmd = "write -P%s %s %s" % p
         log(cmd)
-        log(vm.hmp_qemu_io("drive0", cmd))
+        vm.qmp_qemu_io("drive0", cmd)
 
     log(query_bitmaps(vm), indent=2)
 
@@ -100,7 +99,7 @@ with iotests.FilePath('img') as img_path, \
     for p in overwrite:
         cmd = "write -P%s %s %s" % p
         log(cmd)
-        log(vm.hmp_qemu_io("drive0", cmd))
+        vm.qmp_qemu_io("drive0", cmd)
 
     log('\n--- Disabling A & C ---\n')
     vm.qmp_log("transaction", indent=2, actions=[
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
index 7448ceea027e..aedac37931d7 100644
--- a/tests/qemu-iotests/236.out
+++ b/tests/qemu-iotests/236.out
@@ -11,13 +11,9 @@
 --- Emulating writes ---
 
 write -P0x5d 0 64k
-{"return": ""}
 write -P0xd5 1M 64k
-{"return": ""}
 write -P0xdc 32M 64k
-{"return": ""}
 write -P0xcd 0x3ff0000 64k
-{"return": ""}
 {
   "bitmaps": {
     "drive0": [
@@ -150,13 +146,9 @@ write -P0xcd 0x3ff0000 64k
 --- Emulating further writes ---
 
 write -P0xab 0 64k
-{"return": ""}
 write -P0xad 0x00f8000 64k
-{"return": ""}
 write -P0x1d 0x2008000 64k
-{"return": ""}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
 
 --- Disabling A & C ---
 

-- 
2.56.0.rc0.29.g47ce80527c56


