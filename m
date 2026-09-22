Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC41C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971L-00052f-QN; Tue, 22 Sep 2026 16:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970F-0000u2-Ba
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970D-0000Eq-S8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1v1iyeoNL86Z2eZXyPgjMLqKh/q+InPVG4GkqRw5nfY=;
 b=Z1z+jd3jyuhJybR7gqDqCSSagPF8bMvyrk3KNiv26xvgm8KtZKCSXsFKSH1p4e1j+58B8w
 cYG9MVzduIga6UYlSvp6EAxgM0prmcBDcGpocatEqYuLFOgJSiVXWyCla7jghA9W2eC6+R
 KsXB+cqIZ3C7AY2ueVWDESeSHRfxFI0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-_lXkap0RNGKJtn4lP8yxPw-1; Tue,
 22 Sep 2026 16:22:06 -0400
X-MC-Unique: _lXkap0RNGKJtn4lP8yxPw-1
X-Mimecast-MFC-AGG-ID: _lXkap0RNGKJtn4lP8yxPw_1790108525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 169EF1956064; Tue, 22 Sep 2026 20:22:05 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40B411800446; Tue, 22 Sep 2026 20:22:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:56 +0400
Subject: [PATCH 49/88] qemu-iotests/028: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-49-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hIWR+ick5mR5I1w2Xcka5W5ImcOurs2E5rx0Nz2RL/Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKx4qKsCQQTAbq4ogD53cf9+Fmk14FFnkys3
 xcsDGzul76JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5V7+EACHKwIU2b7TBkTvxdAUegllEriRSZMaPPff7JMqCb3bPly8ZAEM8nauKKr0dGXLiUhOCVB
 fgO8sh0r/N+FXfpcA9vUZVUrOchFhX1SB3Eq43IsjW6yFt+4j532ywrBYW2sNfCHgvTOAwwNMbq
 9rJliE9tFG3umieOacIXsdFr/I8vrC9qqw//COB2/+CirHSne2LIc9KpquuW84Wp5lhslOquAYz
 0RYU3CKPY7394YTO2RhdnhYJxbutkkECJnEOqpw1zc3lIpTWAkyS8umQPMsXtQzdW6wNN8XTAqu
 MdgE2qchfw4paqDcEXGtn2h+w7274Cf9LhMBlglAtQT0xzMeMP+bwRryUYPCBAtp7oIU+NJszhg
 APVAwIzJI8oBeGDBaRw0QqwL0OhxuwvAfHGxW4ALd4uxJgH4znElYcmRnuV9C15WfW2dALAxLAx
 y5F28lRvhibJBWq3C0QvCzXqrHEuNsOzmY4975u9aGlivlf02DmQa1Dov0f2c799qYe4cmH/Th2
 4TDxbS3SHmfA2BoSMhrJA6pmU+tC5drzgtj+34q351PCdOIlObQVeyoxqzvc5PzAamy9wPy61Ud
 B+JNRosYj94Uer9AnCPNW00cbHGpliBibuTOjYmxV2zeYPwY41t+4s4kJEYBVhf5UlEHQhUh7tg
 EgfkNCtcVWneTWw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Replace HMP drive_backup, info block-jobs, and quit with their QMP
equivalents (drive-backup, query-block-jobs, quit). Capture
BLOCK_JOB_COMPLETED and JOB_STATUS_CHANGE events during polling
to keep the output clean.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/028     | 27 ++++++++++++++++++++-------
 tests/qemu-iotests/028.out | 17 +++++++++++++----
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 28f01439c525..e570c3d303d5 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -49,7 +49,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file fuse
 _supported_os Linux
-_require_hmp
 
 # Choose a size that is not necessarily a cluster size multiple for image
 # formats that use clusters.  This will ensure that the base image doesn't end
@@ -109,7 +108,6 @@ echo
 echo block-backup
 echo
 
-qemu_comm_method="monitor"
 _launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=${AIOMODE},id=disk
 h=$QEMU_HANDLE
 if [ "${VALGRIND_QEMU}" == "y" ]; then
@@ -119,12 +117,27 @@ else
 fi
 
 TEST_IMG="$TEST_IMG.copy" _make_test_img $image_size
-_send_qemu_cmd $h "drive_backup -n disk ${TEST_IMG}.copy" "(qemu)" \
-    | _filter_imgfmt
 
-silent=y qemu_cmd_repeat=20 _send_qemu_cmd $h "info block-jobs" "No active jobs"
-_send_qemu_cmd $h "info block-jobs" "No active jobs"
-_send_qemu_cmd $h 'quit' ""
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
+
+capture_events="BLOCK_JOB_COMPLETED JOB_STATUS_CHANGE" \
+_send_qemu_cmd $h \
+    "{ 'execute': 'drive-backup',
+       'arguments': { 'device': 'disk',
+                      'target': '${TEST_IMG}.copy',
+                      'sync': 'full',
+                      'mode': 'existing' } }" \
+    "return"
+
+capture_events="BLOCK_JOB_COMPLETED JOB_STATUS_CHANGE" \
+silent=y qemu_cmd_repeat=20 _send_qemu_cmd $h \
+    '{"execute":"query-block-jobs"}' '"return": \[\]'
+
+capture_events="BLOCK_JOB_COMPLETED JOB_STATUS_CHANGE" \
+_send_qemu_cmd $h '{"execute":"query-block-jobs"}' '"return": \[\]'
+
+_send_qemu_cmd $h '{"execute":"quit"}' 'return'
+wait=1 _cleanup_qemu
 
 # Base image sectors
 TEST_IMG="${TEST_IMG}.copy" io readv $(( offset )) 512 1024 32
diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index e58048821686..0c63b15360f3 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -469,10 +469,19 @@ No errors were found on the image.
 block-backup
 
 Formatting 'TEST_DIR/t.IMGFMT.copy', fmt=IMGFMT size=4294968832
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) drive_backup -n disk TEST_DIR/t.IMGFMT.copy
-(qemu) info block-jobs
-No active jobs
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'drive-backup',
+       'arguments': { 'device': 'disk',
+                      'target': 'TEST_DIR/t.IMGFMT.copy',
+                      'sync': 'full',
+                      'mode': 'existing' } }
+{"return": {}}
+{"execute":"query-block-jobs"}
+{"return": []}
+{"execute":"quit"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 === IO: pattern 195
 read 512/512 bytes at offset 3221194240
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-- 
2.56.0.rc0.29.g47ce80527c56


