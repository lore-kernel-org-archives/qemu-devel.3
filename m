Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA45CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJRr-0002LC-B9; Tue, 21 Oct 2025 16:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vBJRX-0001hb-KA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vBJRV-0002Wt-15
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761080331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VMRhxdk5GwQ5M0W9N/nhCQ0g5rPgCQWj4kGrqvuGvu0=;
 b=GpYJX2jsChnL2sfnZuObQYsU9bxHzkajKEFM5Gvf2/dvFz46LabNfnrc4JCiW5wMYID6Ns
 +VNBqdPP+p60UD+ZKmhyt8tYRFBb6FJmhOafjTUnj7cu8TMYSIxJL00CKTF19QqpYjrM/a
 Jn887WPSu/JIB3zJBKBjfvN5y+b/g14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-iULxbrMXPG2ud9OEJKLA5w-1; Tue,
 21 Oct 2025 16:58:48 -0400
X-MC-Unique: iULxbrMXPG2ud9OEJKLA5w-1
X-Mimecast-MFC-AGG-ID: iULxbrMXPG2ud9OEJKLA5w_1761080327
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18F6C18001D1; Tue, 21 Oct 2025 20:58:47 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A43F130001BB; Tue, 21 Oct 2025 20:58:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] iotests: Adjust fuse-allow-other expected output
Date: Tue, 21 Oct 2025 15:58:40 -0500
Message-ID: <20251021205843.2585624-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The iotest fuse-allow-other has been broken since commit effd60c8 in
v9.0.0; but as Dan Berrange's efforts to improve CI have proven, we
haven't been reliably running it to notice.  The change in that commit
was good (moving coroutine commands to run in the right context), but
it meant that "execute":"quit" now waits to complete until the
coroutines tearing down fuse have first reported the SHUTDOWN event,
in the opposite order of what happened pre-patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Fixes: effd60c8 ("monitor: only run coroutine commands in qemu_aio_context",
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/tests/fuse-allow-other.out | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/tests/fuse-allow-other.out b/tests/qemu-iotests/tests/fuse-allow-other.out
index 543fa52a063..3219fc35e05 100644
--- a/tests/qemu-iotests/tests/fuse-allow-other.out
+++ b/tests/qemu-iotests/tests/fuse-allow-other.out
@@ -28,9 +28,9 @@ stat: cannot statx 'fuse-export': Permission denied
 cat: fuse-export: Permission denied
 stat: cannot statx 'fuse-export': Permission denied
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{"return": {}}

 --- allow-other=on ---
 {'execute': 'qmp_capabilities'}
@@ -55,9 +55,9 @@ Permissions seen by nobody: 444
 cat: fuse-export: Permission denied
 Permissions seen by nobody: 440
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{"return": {}}

 --- allow-other=auto ---
 {'execute': 'qmp_capabilities'}
@@ -82,7 +82,7 @@ Permissions seen by nobody: 444
 cat: fuse-export: Permission denied
 Permissions seen by nobody: 440
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{"return": {}}
 *** done
-- 
2.51.0


