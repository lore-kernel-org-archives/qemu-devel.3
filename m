Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59142C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 17:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYUiZ-0008EX-KC; Fri, 09 Feb 2024 12:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rYUiX-0008E9-Vg
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rYUiW-0000Nw-A3
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707499870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dH3fYqVhpUnjVQ1EJpuPIXqHWCIxtv/b1iVeNrQZpM8=;
 b=KF7tDNIkfQlEqHJif5Ap+ww2fe3X6MEu3JAM/syC7SX+kvWJPoJ4UdMiQcOD2tTvF8D+TU
 0h4We4FWSMQRpiEfaYFsresetriv+5gmTNSJaZ5pLQVX1AVca2Z7KXaEr+MtBwCpeA3Tqm
 TtXhmOg8CdVdWi5BGoiIVLOF5D/3Pak=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-qEuKgUksOHGBo0ZKO-qe3Q-1; Fri,
 09 Feb 2024 12:31:07 -0500
X-MC-Unique: qEuKgUksOHGBo0ZKO-qe3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98A6629AC021;
 Fri,  9 Feb 2024 17:31:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0500492BE2;
 Fri,  9 Feb 2024 17:31:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, hreitz@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] iotests: Make 144 deterministic again
Date: Fri,  9 Feb 2024 18:31:03 +0100
Message-ID: <20240209173103.239994-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 tests/qemu-iotests/144     | 12 +++++++++++-
 tests/qemu-iotests/144.out |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

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
2.43.0


