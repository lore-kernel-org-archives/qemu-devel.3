Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D15CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 09:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up1ti-0000p3-Vp; Thu, 21 Aug 2025 05:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1up1tg-0000ov-Gh
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 05:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1up1tc-0002WH-K9
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 05:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755769664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yJv9AVcPmULD62NGzS++wKzayuNoXdj66VzLzZU9Bqc=;
 b=AZhcIdFqaLqaPnv0IkZ9cCvRqntb8t5dnlihcc84YDTjHWdxlyUOQMPypP/i4MMxwe0dWg
 jtW1oBpwYIbniiRZVPRnNqTZluQUo/q7Zz/KePN9VHi9z5asfQnolQOYsoFJms0Gxu6ZQ3
 Uk4gRO+gg1MBaveu1Trd4CI9fif9KVk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-zVCKZcVzOAS4tEdacKDPiw-1; Thu,
 21 Aug 2025 05:47:40 -0400
X-MC-Unique: zVCKZcVzOAS4tEdacKDPiw-1
X-Mimecast-MFC-AGG-ID: zVCKZcVzOAS4tEdacKDPiw_1755769659
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFFD11800285; Thu, 21 Aug 2025 09:47:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.166])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C554180044F; Thu, 21 Aug 2025 09:47:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Use more fine-grained locking when looking
 for free ports
Date: Thu, 21 Aug 2025 11:47:35 +0200
Message-ID: <20250821094735.804210-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Currently, we have one lock that is held while a test is looking for
free ports. However, we are also using different ranges for looking
for free ports nowadays (PORTS_START is based on the PID of the process),
so instead of using only one lock, we should rather use a lock per
range instead. This should help to allow running more tests in parallel.

While we're at it, also create the lock files without executable bit
(mode is 0o777 by default).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/ports.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
index 631b77abf6b..81174a61532 100644
--- a/tests/functional/qemu_test/ports.py
+++ b/tests/functional/qemu_test/ports.py
@@ -23,8 +23,9 @@ class Ports():
     PORTS_END = PORTS_START + PORTS_RANGE_SIZE
 
     def __enter__(self):
-        lock_file = os.path.join(BUILD_DIR, "tests", "functional", "port_lock")
-        self.lock_fh = os.open(lock_file, os.O_CREAT)
+        lock_file = os.path.join(BUILD_DIR, "tests", "functional",
+                                 f".port_lock.{self.PORTS_START}")
+        self.lock_fh = os.open(lock_file, os.O_CREAT, mode=0o666)
         fcntl.flock(self.lock_fh, fcntl.LOCK_EX)
         return self
 
-- 
2.50.1


