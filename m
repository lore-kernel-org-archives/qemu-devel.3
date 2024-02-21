Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FFC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoJI-0000mG-D6; Wed, 21 Feb 2024 10:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchua-0001iS-8j; Wed, 21 Feb 2024 03:25:04 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchuY-0002rG-AH; Wed, 21 Feb 2024 03:25:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 219694F3ED;
 Wed, 21 Feb 2024 11:21:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E0694860CC;
 Wed, 21 Feb 2024 11:21:01 +0300 (MSK)
Received: (nullmailer pid 2142131 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 47/60] iotests: Make 144 deterministic again
Date: Wed, 21 Feb 2024 11:20:35 +0300
Message-Id: <20240221082058.2141850-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

Since commit effd60c8 changed how QMP commands are processed, the order
of the block-commit return value and job events in iotests 144 wasn't
fixed and more and caused the test to fail intermittently.

Change the test to cache events first and then print them in a
predefined order.

Waiting three times for JOB_STATUS_CHANGE is a bit uglier than just
waiting for the JOB_STATUS_CHANGE that has "status": "ready", but the
tooling we have doesn't seem to allow the latter easily.

Fixes: effd60c878176bcaf97fa7ce2b12d04bb8ead6f7
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2126
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20240209173103.239994-1-kwolf@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit cc29c12ec629ba68a4a6cb7d165c94cc8502815a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index bdcc498fa2..d284a0e442 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -83,12 +83,22 @@ echo
 echo === Performing block-commit on active layer ===
 echo
 
+capture_events="BLOCK_JOB_READY JOB_STATUS_CHANGE"
+
 # Block commit on active layer, push the new overlay into base
 _send_qemu_cmd $h "{ 'execute': 'block-commit',
                                 'arguments': {
                                                  'device': 'virtio0'
                                               }
-                    }" "READY"
+                    }" "return"
+
+_wait_event $h "JOB_STATUS_CHANGE"
+_wait_event $h "JOB_STATUS_CHANGE"
+_wait_event $h "JOB_STATUS_CHANGE"
+
+_wait_event $h "BLOCK_JOB_READY"
+
+capture_events=
 
 _send_qemu_cmd $h "{ 'execute': 'block-job-complete',
                                 'arguments': {
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index b3b4812015..2245ddfa10 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -25,9 +25,9 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off co
                                                  'device': 'virtio0'
                                               }
                     }
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "virtio0"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "virtio0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 { 'execute': 'block-job-complete',
-- 
2.39.2


