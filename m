Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86341C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96xv-0004I1-6P; Tue, 22 Sep 2026 16:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xl-0004A9-4F
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xe-00082w-VK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ug/u3sndBRP4pAlXPylAVbR1naChheCB4kkX/CVJlxY=;
 b=PimYBF9B0W74wBBXhd66d/NENlr7ZZnohC4+Y/kTNFlaGnQg0h40zZUJeodG5fXkqK9Vh8
 qxA0P7lbKkEY+SxMBsxuAiVLbngp9mfAfqNJITt6Y5ji7vIjsgNipXP8vULPTySEL75MuP
 voQJzzI1Eh5s7fKvov1qUmdvV361x7I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-VNOzX7VYMgy8GX6ZHneFuA-1; Tue,
 22 Sep 2026 16:19:28 -0400
X-MC-Unique: VNOzX7VYMgy8GX6ZHneFuA-1
X-Mimecast-MFC-AGG-ID: VNOzX7VYMgy8GX6ZHneFuA_1790108367
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E2719774FA; Tue, 22 Sep 2026 20:19:26 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0522C1956095; Tue, 22 Sep 2026 20:19:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:12 +0400
Subject: [PATCH 05/88] qemu-io: drop "qemu-io:" prefix in error-report
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-5-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=161047;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5JBydEEPB+JaG1Yaa4ZzvV9TPnIxR80RFqVmyk0VEhM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuadY9WaQg2A3dgbAr33PxJsbq29PBK5ERW
 5E6pXSYNPqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5VXOD/0bHZeEftO3Ku7CPTZ7SLB9PR5iTx8NUmCSakWKesmkrYpa2OEMjx/lsveW5TYRhjaeBb6
 UqbIpOb8pc22rVyRsTXovIrP+iEFzGTgpwStgAR+95VOSstvBvEJFCPdG2njmXflVk49NeOBClW
 MCQwVtHz+vwaQ8OV5pVTM270ntZzlWsyKyhWO5LpAFNcvmHLVUxIucdhNREma4v5DH73mqflsFz
 OV8orp3J7XFsNx+P798zJXSF96DdQmRGN4NGu/SqkIfS3kkxcgWA1Nb8QUSwrJGLzv2Pse7EIE3
 WcHBVP9WAr/JSH30RsbGIqyXvQ2zedJFWx4MZGOkJqYBtuhlKfqvnwISSroqStGrlFpXqP+/0EO
 kPOYVbGd6mSNkMiCWzGUrqRinxu622iWnK11cE7svgOZRHuyrw3G70Hl+lBA5tWx5Lrfm73CblD
 Gk0/eNlAxDks/OOXmxC59emJPyceDRAdcNmCGvfw4TmevVCqmoydccP95WxXGd+g9z1KYUQWOT9
 77TobDCHTvFzJpvD52nL2PlbLOQh8pFOTTToUlk4GhZmclkYeOz2GBcdrmCBqXZ4dT3e2WDWO98
 CMGcJHp7kbsM2DWnE8RjR5gsVOxKR8Va5EbE9a/gRTcqOgrUoabvs6xFjm2U3tjIz0TWF5T14be
 9LeNa3WvXgD9gDA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

qemu-io is still primarily an interactive program, and constantly
printing the name of the program you're interacting with has little
value.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qemu-io.c                                          |   4 +
 tests/qemu-iotests/004.out                         |  20 +-
 tests/qemu-iotests/021.out                         |  60 ++--
 tests/qemu-iotests/026.out                         | 396 ++++++++++-----------
 tests/qemu-iotests/026.out.nocache                 | 168 ++++-----
 tests/qemu-iotests/059.out                         |   6 +-
 tests/qemu-iotests/060.out                         |  46 +--
 tests/qemu-iotests/061.out                         |   4 +-
 tests/qemu-iotests/069.out                         |   2 +-
 tests/qemu-iotests/070.out                         |   2 +-
 tests/qemu-iotests/071.out                         |   4 +-
 tests/qemu-iotests/072.out                         |   2 +-
 tests/qemu-iotests/075.out                         |  14 +-
 tests/qemu-iotests/076.out                         |   6 +-
 tests/qemu-iotests/078.out                         |  12 +-
 tests/qemu-iotests/080.out                         |  44 +--
 tests/qemu-iotests/081.out                         |   4 +-
 tests/qemu-iotests/083.out                         | 104 +++---
 tests/qemu-iotests/088.out                         |  12 +-
 tests/qemu-iotests/089.out                         |   4 +-
 tests/qemu-iotests/092.out                         |  24 +-
 tests/qemu-iotests/103.out                         |  14 +-
 tests/qemu-iotests/114.out                         |   4 +-
 tests/qemu-iotests/116.out                         |  14 +-
 tests/qemu-iotests/133.out                         |  30 +-
 tests/qemu-iotests/134.out                         |   2 +-
 tests/qemu-iotests/137.out                         |  30 +-
 tests/qemu-iotests/140.out                         |   2 +-
 tests/qemu-iotests/143.out                         |   4 +-
 tests/qemu-iotests/153.out                         |  42 +--
 tests/qemu-iotests/171.out                         |  68 ++--
 tests/qemu-iotests/187.out                         |   6 +-
 tests/qemu-iotests/188.out                         |   2 +-
 tests/qemu-iotests/197.out                         |   2 +-
 tests/qemu-iotests/205                             |   4 +-
 tests/qemu-iotests/214.out                         |   2 +-
 tests/qemu-iotests/215.out                         |   2 +-
 tests/qemu-iotests/220.out                         |   2 +-
 tests/qemu-iotests/226.out                         |  16 +-
 tests/qemu-iotests/244.out                         |  22 +-
 tests/qemu-iotests/271.out                         |  14 +-
 tests/qemu-iotests/289.out                         |   2 +-
 tests/qemu-iotests/293.out                         |  30 +-
 tests/qemu-iotests/294.out                         |   4 +-
 tests/qemu-iotests/305.out                         |   2 +-
 tests/qemu-iotests/307.out                         |   2 +-
 tests/qemu-iotests/tests/file-io-error.out         |   2 +-
 tests/qemu-iotests/tests/image-fleecing.out        |  12 +-
 tests/qemu-iotests/tests/inactive-node-nbd.out     |  10 +-
 tests/qemu-iotests/tests/nbd-reconnect-on-open.out |   4 +-
 tests/qemu-iotests/tests/parallels-bitmap.out      |   4 +-
 tests/qemu-iotests/tests/parallels-checks.out      |   4 +-
 util/error-report.c                                |   2 +-
 53 files changed, 651 insertions(+), 647 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 598d5b1c9ca9..7d6a65a50814 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -628,6 +628,10 @@ int main(int argc, char **argv)
         exit(1);
     }
 
+    /* Compute the prompt before clearing prgname */
+    get_prompt();
+    g_set_prgname("");
+
     qemu_init_main_loop(&error_fatal);
 
     if (!trace_init_backends()) {
diff --git a/tests/qemu-iotests/004.out b/tests/qemu-iotests/004.out
index 37da6024809f..fb8593289f51 100644
--- a/tests/qemu-iotests/004.out
+++ b/tests/qemu-iotests/004.out
@@ -6,36 +6,36 @@ wrote 1048576/1048576 bytes at offset 133169152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write into image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write at image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write past image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 pwrite past image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 writev past image boundary
-qemu-io: writev failed: Input/output error
+writev failed: Input/output error
 
 read before image boundary
 read 1048576/1048576 bytes at offset 133169152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read into image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read at image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read past image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 pread past image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 readv past image boundary
-qemu-io: readv failed: Input/output error
+readv failed: Input/output error
 *** done
diff --git a/tests/qemu-iotests/021.out b/tests/qemu-iotests/021.out
index dfdfeb503780..8533f8e58ae6 100644
--- a/tests/qemu-iotests/021.out
+++ b/tests/qemu-iotests/021.out
@@ -2,92 +2,92 @@ QA output created by 021
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
 == testing writev -P -1 ==
-qemu-io: -1 is not a valid pattern byte
+-1 is not a valid pattern byte
 
 == testing read -P -1 ==
-qemu-io: -1 is not a valid pattern byte
+-1 is not a valid pattern byte
 
 == testing write -P -1 ==
-qemu-io: -1 is not a valid pattern byte
+-1 is not a valid pattern byte
 
 == testing readv -P -1 ==
-qemu-io: -1 is not a valid pattern byte
+-1 is not a valid pattern byte
 
 == testing aio_read -P -1 ==
-qemu-io: -1 is not a valid pattern byte
+-1 is not a valid pattern byte
 
 == testing aio_write -P -1 ==
-qemu-io: -1 is not a valid pattern byte
+-1 is not a valid pattern byte
 
 == testing writev -P 300 ==
-qemu-io: 300 is not a valid pattern byte
+300 is not a valid pattern byte
 
 == testing read -P 300 ==
-qemu-io: 300 is not a valid pattern byte
+300 is not a valid pattern byte
 
 == testing write -P 300 ==
-qemu-io: 300 is not a valid pattern byte
+300 is not a valid pattern byte
 
 == testing readv -P 300 ==
-qemu-io: 300 is not a valid pattern byte
+300 is not a valid pattern byte
 
 == testing aio_read -P 300 ==
-qemu-io: 300 is not a valid pattern byte
+300 is not a valid pattern byte
 
 == testing aio_write -P 300 ==
-qemu-io: 300 is not a valid pattern byte
+300 is not a valid pattern byte
 
 == testing writev -P 12m ==
-qemu-io: 12m is not a valid pattern byte
+12m is not a valid pattern byte
 
 == testing read -P 12m ==
-qemu-io: 12m is not a valid pattern byte
+12m is not a valid pattern byte
 
 == testing write -P 12m ==
-qemu-io: 12m is not a valid pattern byte
+12m is not a valid pattern byte
 
 == testing readv -P 12m ==
-qemu-io: 12m is not a valid pattern byte
+12m is not a valid pattern byte
 
 == testing aio_read -P 12m ==
-qemu-io: 12m is not a valid pattern byte
+12m is not a valid pattern byte
 
 == testing aio_write -P 12m ==
-qemu-io: 12m is not a valid pattern byte
+12m is not a valid pattern byte
 
 == testing writev -P 4k ==
-qemu-io: 4k is not a valid pattern byte
+4k is not a valid pattern byte
 
 == testing read -P 4k ==
-qemu-io: 4k is not a valid pattern byte
+4k is not a valid pattern byte
 
 == testing write -P 4k ==
-qemu-io: 4k is not a valid pattern byte
+4k is not a valid pattern byte
 
 == testing readv -P 4k ==
-qemu-io: 4k is not a valid pattern byte
+4k is not a valid pattern byte
 
 == testing aio_read -P 4k ==
-qemu-io: 4k is not a valid pattern byte
+4k is not a valid pattern byte
 
 == testing aio_write -P 4k ==
-qemu-io: 4k is not a valid pattern byte
+4k is not a valid pattern byte
 
 == testing writev -P route66 ==
-qemu-io: route66 is not a valid pattern byte
+route66 is not a valid pattern byte
 
 == testing read -P route66 ==
-qemu-io: route66 is not a valid pattern byte
+route66 is not a valid pattern byte
 
 == testing write -P route66 ==
-qemu-io: route66 is not a valid pattern byte
+route66 is not a valid pattern byte
 
 == testing readv -P route66 ==
-qemu-io: route66 is not a valid pattern byte
+route66 is not a valid pattern byte
 
 == testing aio_read -P route66 ==
-qemu-io: route66 is not a valid pattern byte
+route66 is not a valid pattern byte
 
 == testing aio_write -P route66 ==
-qemu-io: route66 is not a valid pattern byte
+route66 is not a valid pattern byte
 *** done
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index b998a9ac83da..050bbfa18863 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -4,442 +4,442 @@ Errors while writing 128 kB
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: on; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: Input/output error
-qemu-io: read failed: Input/output error
+write failed: Input/output error
+read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: on; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: Input/output error
-qemu-io: read failed: Input/output error
+write failed: Input/output error
+read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: off; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: Input/output error
-qemu-io: read failed: Input/output error
+write failed: Input/output error
+read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 5; imm: off; once: off; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: Input/output error
-qemu-io: read failed: Input/output error
+write failed: Input/output error
+read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: on; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: No space left on device
-qemu-io: read failed: No space left on device
+write failed: No space left on device
+read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: on; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: No space left on device
-qemu-io: read failed: No space left on device
+write failed: No space left on device
+read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: off; write
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: No space left on device
-qemu-io: read failed: No space left on device
+write failed: No space left on device
+read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_load; errno: 28; imm: off; once: off; write -b
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: No space left on device
-qemu-io: read failed: No space left on device
+write failed: No space left on device
+read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: on; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: on; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: off; write
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 5; imm: off; once: off; write -b
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: cluster_alloc; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 
 === Refcount table growth tests ===
@@ -447,122 +447,122 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write -b
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 
 === L1 growth tests ===
@@ -570,76 +570,76 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 5; imm: off; once: on
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 5; imm: off; once: off
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 28; imm: off; once: on
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_alloc_table; errno: 28; imm: off; once: off
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: on
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: on
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: on
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
-qemu-io: write failed: Input/output error
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+write failed: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
-qemu-io: write failed: No space left on device
+write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
-qemu-io: write failed: No space left on device
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+write failed: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 No errors were found on the image.
 
 === Avoid cluster leaks after temporary failure ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
@@ -651,6 +651,6 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 9359d26d7e20..b46d00b35c85 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -14,15 +14,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -38,15 +38,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -128,16 +128,16 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_update; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
@@ -156,16 +156,16 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_update; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
@@ -182,15 +182,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -206,15 +206,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -230,15 +230,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 5; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -254,15 +254,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: write_aio; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -278,15 +278,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 5; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -302,15 +302,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -326,15 +326,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -350,15 +350,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -374,15 +374,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -398,15 +398,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -465,15 +465,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -489,15 +489,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -513,15 +513,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -537,15 +537,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -561,15 +561,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write 
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 
@@ -603,8 +603,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -615,8 +615,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -627,8 +627,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
@@ -639,8 +639,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Failed to flush the L2 table cache: No space left on device
+Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 275ee7c7781a..be757ea2f211 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2,15 +2,15 @@ QA output created by 059
 
 === Testing invalid granularity ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.vmdk: Invalid granularity, image may be corrupt
+can't open device TEST_DIR/t.vmdk: Invalid granularity, image may be corrupt
 
 === Testing too big L2 table size ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.vmdk: L2 table size too big
+can't open device TEST_DIR/t.vmdk: L2 table size too big
 
 === Testing too big L1 table size ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.vmdk: L1 size too big
+can't open device TEST_DIR/t.vmdk: L1 size too big
 
 === Testing monolithicFlat creation and opening ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2147483648
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 27275fd6b70e..8870a478231c 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -9,7 +9,7 @@ ERROR cluster 3 refcount=1 reference=3
 Data may be corrupted, or further writes to the image may corrupt it.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with active L1 table); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 incompatible_features     [1]
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -22,8 +22,8 @@ Format specific information:
     refcount bits: 16
     corrupt: true
     extended l2: false
-qemu-io: can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot be opened read/write
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot be opened read/write
+no file open, try 'help open'
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -37,7 +37,7 @@ ERROR cluster 2 refcount=1 reference=2
 Data may be corrupted, or further writes to the image may corrupt it.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with refcount block); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 incompatible_features     [1]
 ERROR refcount block 0 refcount=2
 ERROR cluster 2 refcount=1 reference=2
@@ -73,7 +73,7 @@ Data may be corrupted, or further writes to the image may corrupt it.
 This means waste of disk space, but no harm to data.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with inactive L2 table); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 incompatible_features     [1]
 ERROR cluster 4 refcount=1 reference=2
 Leaked cluster 9 refcount=1 reference=0
@@ -108,8 +108,8 @@ wrote 65536/65536 bytes at offset 0
 wrote 65536/65536 bytes at offset 536870912
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with active L2 table); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
-qemu-io: aio_write failed: No medium found
+write failed: Input/output error
+aio_write failed: No medium found
 blkdebug: Suspended request '0'
 blkdebug: Resuming request '0'
 
@@ -119,7 +119,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with qcow2_header); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 === Testing unaligned L1 entry ===
 
@@ -127,7 +127,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: L2 table offset 0x42a00 unaligned (L1 index: 0); further corruption events will be suppressed
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -140,7 +140,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Testing unaligned pre-allocated zero cluster ===
 
@@ -154,7 +154,7 @@ qemu-img: Failed to turn zero into data clusters: Input/output error
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Refblock offset 0x22a00 unaligned (reftable index: 0); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 === Testing non-fatal corruption on freeing ===
 
@@ -171,8 +171,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Image is corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further non-fatal corruption events will be suppressed
-qemu-io: read failed: Input/output error
-qemu-io: read failed: Input/output error
+read failed: Input/output error
+read failed: Input/output error
 
 === Testing non-fatal and then fatal corruption report ===
 
@@ -181,7 +181,7 @@ wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Image is corrupt: Cannot free unaligned cluster 0x52a00; further non-fatal corruption events will be suppressed
 qcow2: Marking image as corrupt: Cluster allocation offset 0x62a00 unaligned (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -189,7 +189,7 @@ discard 65536/65536 bytes at offset 0
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with refcount table); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
@@ -209,7 +209,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of refcount block at offset 0; further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
@@ -229,7 +229,7 @@ No errors were found on the image.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 2 refcount=0 reference=1
@@ -251,7 +251,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 65536
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of compressed cluster at offset 0; further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
 ERROR cluster 2 refcount=0 reference=1
@@ -270,7 +270,7 @@ No errors were found on the image.
 === Testing zero refcount table size ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Image does not contain a reference count table
+can't open device TEST_DIR/t.IMGFMT: Image does not contain a reference count table
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 3 refcount=0 reference=1
 Rebuilding refcount structure
@@ -286,7 +286,7 @@ No errors were found on the image.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 === Testing dirty corrupt image ===
 
@@ -299,7 +299,7 @@ Can't get refcount for cluster 2: Input/output error
 Can't get refcount for cluster 3: Input/output error
 Rebuilding refcount structure
 Repairing cluster 1 refcount=1 reference=0
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not repair dirty image: Input/output error
+can't open device TEST_DIR/t.IMGFMT: Could not repair dirty image: Input/output error
 --- Repairing ---
 Leaked cluster 1 refcount=1 reference=0
 Repairing cluster 1 refcount=1 reference=0
@@ -319,7 +319,7 @@ wrote 65536/65536 bytes at offset 0
 discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preallocated zero cluster offset 0x2a00 unaligned (guest offset: 0); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 --- Repairing ---
 Repairing offset=2a00: Preallocated cluster is not properly aligned; L2 entry corrupted.
 The following inconsistencies were found and repaired:
@@ -337,7 +337,7 @@ wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Refblock offset 0x2a00 unaligned (reftable index: 0); further corruption events will be suppressed
 qcow2_free_clusters failed: Input/output error
-qemu-io: discard failed: No medium found
+discard failed: No medium found
 --- Repairing ---
 ERROR refcount block 0 is not cluster aligned; refcount table entry corrupted
 qcow2: Marking image as corrupt: Refblock offset 0x2a00 unaligned (reftable index: 0); further corruption events will be suppressed
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 951c6bf3e62c..7e34a6fd9c28 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -545,7 +545,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: data-file can only be set for images that use an external data file
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open 'foo': No such file or directory
+can't open device TEST_DIR/t.IMGFMT: Could not open 'foo': No such file or directory
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
@@ -562,7 +562,7 @@ Format specific information:
     corrupt: false
     extended l2: false
 
-qemu-io: can't open device TEST_DIR/t.IMGFMT: 'data-file' is required for this image
+can't open device TEST_DIR/t.IMGFMT: 'data-file' is required for this image
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
diff --git a/tests/qemu-iotests/069.out b/tests/qemu-iotests/069.out
index 126b4d2d519b..0409b4700e0f 100644
--- a/tests/qemu-iotests/069.out
+++ b/tests/qemu-iotests/069.out
@@ -4,5 +4,5 @@ QA output created by 069
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=131072
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
+can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
 *** done
diff --git a/tests/qemu-iotests/070.out b/tests/qemu-iotests/070.out
index 2fbfd7eaf334..287f16de2a6f 100644
--- a/tests/qemu-iotests/070.out
+++ b/tests/qemu-iotests/070.out
@@ -1,7 +1,7 @@
 QA output created by 070
 
 === Verify open image read-only fails, due to dirty log ===
-qemu-io: can't open device TEST_DIR/iotest-dirtylog-10G-4M.vhdx: VHDX image file 'TEST_DIR/iotest-dirtylog-10G-4M.vhdx' opened read-only, but contains a log that needs to be replayed
+can't open device TEST_DIR/iotest-dirtylog-10G-4M.vhdx: VHDX image file 'TEST_DIR/iotest-dirtylog-10G-4M.vhdx' opened read-only, but contains a log that needs to be replayed
 To replay the log, run:
 qemu-img check -r all 'TEST_DIR/iotest-dirtylog-10G-4M.vhdx'
 === Verify open image replays log  ===
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index f2d015d8ccae..15353aba08b9 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -30,11 +30,11 @@ blkverify: read offset=0 bytes=512 contents mismatch at offset 0
 
 === Testing blkdebug through filename ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Testing blkdebug through file blockref ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Testing blkdebug on existing block device ===
 
diff --git a/tests/qemu-iotests/072.out b/tests/qemu-iotests/072.out
index d7ce24da1f7a..fe949d47817a 100644
--- a/tests/qemu-iotests/072.out
+++ b/tests/qemu-iotests/072.out
@@ -15,7 +15,7 @@ read 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 1024
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: Pattern verification failed at offset 0, 512 bytes
+Pattern verification failed at offset 0, 512 bytes
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/075.out b/tests/qemu-iotests/075.out
index 4f3871d33717..b234b758e026 100644
--- a/tests/qemu-iotests/075.out
+++ b/tests/qemu-iotests/075.out
@@ -9,23 +9,23 @@ read 512/512 bytes at offset 1048064
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == block_size must be a multiple of 512 ==
-qemu-io: can't open device TEST_DIR/simple-pattern.cloop: block_size 513 must be a multiple of 512
+can't open device TEST_DIR/simple-pattern.cloop: block_size 513 must be a multiple of 512
 
 == block_size cannot be zero ==
-qemu-io: can't open device TEST_DIR/simple-pattern.cloop: block_size cannot be zero
+can't open device TEST_DIR/simple-pattern.cloop: block_size cannot be zero
 
 == huge block_size ===
-qemu-io: can't open device TEST_DIR/simple-pattern.cloop: block_size 4294966784 must be 64 MB or less
+can't open device TEST_DIR/simple-pattern.cloop: block_size 4294966784 must be 64 MB or less
 
 == offsets_size overflow ===
-qemu-io: can't open device TEST_DIR/simple-pattern.cloop: n_blocks 4294967295 must be 536870911 or less
+can't open device TEST_DIR/simple-pattern.cloop: n_blocks 4294967295 must be 536870911 or less
 
 == refuse images that require too many offsets ===
-qemu-io: can't open device TEST_DIR/simple-pattern.cloop: image requires too many offsets, try increasing block size
+can't open device TEST_DIR/simple-pattern.cloop: image requires too many offsets, try increasing block size
 
 == refuse images with non-monotonically increasing offsets ==
-qemu-io: can't open device TEST_DIR/simple-pattern.cloop: offsets not monotonically increasing at index 1, image file is corrupt
+can't open device TEST_DIR/simple-pattern.cloop: offsets not monotonically increasing at index 1, image file is corrupt
 
 == refuse images with invalid compressed block size ==
-qemu-io: can't open device TEST_DIR/simple-pattern.cloop: invalid compressed block size at index 1, image file is corrupt
+can't open device TEST_DIR/simple-pattern.cloop: invalid compressed block size at index 1, image file is corrupt
 *** done
diff --git a/tests/qemu-iotests/076.out b/tests/qemu-iotests/076.out
index 2de8a710a55d..9c66c5fb46b7 100644
--- a/tests/qemu-iotests/076.out
+++ b/tests/qemu-iotests/076.out
@@ -5,13 +5,13 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == Negative catalog size ==
-qemu-io: can't open device TEST_DIR/parallels-v1: Catalog too large
+can't open device TEST_DIR/parallels-v1: Catalog too large
 
 == Overflow in catalog allocation ==
-qemu-io: can't open device TEST_DIR/parallels-v1: Catalog too large
+can't open device TEST_DIR/parallels-v1: Catalog too large
 
 == Zero sectors per track ==
-qemu-io: can't open device TEST_DIR/parallels-v1: Invalid image: Zero sectors per track
+can't open device TEST_DIR/parallels-v1: Invalid image: Zero sectors per track
 
 == Read from a valid v2 image ==
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/078.out b/tests/qemu-iotests/078.out
index 4a82e1779fe3..c3d6aa4fe465 100644
--- a/tests/qemu-iotests/078.out
+++ b/tests/qemu-iotests/078.out
@@ -5,18 +5,18 @@ read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == Negative catalog size ==
-qemu-io: can't open device TEST_DIR/empty.bochs: Catalog size is too large
+can't open device TEST_DIR/empty.bochs: Catalog size is too large
 
 == Overflow for catalog size * sizeof(uint32_t) ==
-qemu-io: can't open device TEST_DIR/empty.bochs: Catalog size is too large
+can't open device TEST_DIR/empty.bochs: Catalog size is too large
 
 == Too small catalog bitmap for image size ==
-qemu-io: can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
-qemu-io: can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
+can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
+can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
 
 == Negative extent size ==
-qemu-io: can't open device TEST_DIR/empty.bochs: Extent size 2147483648 is too large
+can't open device TEST_DIR/empty.bochs: Extent size 2147483648 is too large
 
 == Zero extent size ==
-qemu-io: can't open device TEST_DIR/empty.bochs: Extent size must be at least 512
+can't open device TEST_DIR/empty.bochs: Extent size must be at least 512
 *** done
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index b20c21faf6a9..bf0ede4e206f 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -2,34 +2,34 @@ QA output created by 080
 
 == Huge header size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
-qemu-io: can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
+can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
+can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
 
 == Huge unknown header extension ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Invalid backing file offset
-qemu-io: can't open device TEST_DIR/t.qcow2: Header extension too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Header extension too large
+can't open device TEST_DIR/t.qcow2: Invalid backing file offset
+can't open device TEST_DIR/t.qcow2: Header extension too large
+can't open device TEST_DIR/t.qcow2: Header extension too large
 
 == Huge refcount table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table too large
+can't open device TEST_DIR/t.qcow2: Reference count table too large
+can't open device TEST_DIR/t.qcow2: Reference count table too large
 
 == Misaligned refcount table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table offset invalid
+can't open device TEST_DIR/t.qcow2: Reference count table offset invalid
 
 == Huge refcount offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table offset invalid
+can't open device TEST_DIR/t.qcow2: Reference count table offset invalid
 
 == Invalid snapshot table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
+can't open device TEST_DIR/t.qcow2: Snapshot table too large
+can't open device TEST_DIR/t.qcow2: Snapshot table too large
+can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
+can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
 
 == Hitting snapshot table size limit ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -39,10 +39,10 @@ read 512/512 bytes at offset 0
 
 == Invalid L1 table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table offset invalid
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table offset invalid
+can't open device TEST_DIR/t.qcow2: Active L1 table too large
+can't open device TEST_DIR/t.qcow2: Active L1 table too large
+can't open device TEST_DIR/t.qcow2: Active L1 table offset invalid
+can't open device TEST_DIR/t.qcow2: Active L1 table offset invalid
 
 == Invalid L1 table (with internal snapshot in the image) ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -50,7 +50,7 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': L1 table is too small
 
 == Invalid backing file size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Backing file name too long
+can't open device TEST_DIR/t.qcow2: Backing file name too long
 
 == Invalid L2 entry (huge physical offset) ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -66,8 +66,8 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Failed to turn zero into data clusters: Invalid argument
-qemu-io: write failed: Invalid argument
-qemu-io: Failed to flush the refcount block cache: Invalid argument
+write failed: Invalid argument
+Failed to flush the refcount block cache: Invalid argument
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: Invalid argument
 qemu-img: Could not delete snapshot 'test': Snapshot L1 table offset invalid
@@ -89,8 +89,8 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Failed to turn zero into data clusters: File too large
-qemu-io: write failed: File too large
-qemu-io: Failed to flush the refcount block cache: File too large
+write failed: File too large
+Failed to flush the refcount block cache: File too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: File too large
 qemu-img: Could not delete snapshot 'test': Snapshot L1 table too large
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index bc902bd81832..084b6fbff66a 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -81,7 +81,7 @@ wrote 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == checking that quorum is broken ==
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 == checking the blkverify mode with broken content ==
 quorum: offset=0 bytes=10485760 contents mismatch at offset 0
@@ -97,7 +97,7 @@ read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == checking the blkverify mode with invalid settings ==
-qemu-io: can't open: blkverify=on can only be set if there are exactly two files and vote-threshold is 2
+can't open: blkverify=on can only be set if there are exactly two files and vote-threshold is 2
 
 == dynamically adding a child to a quorum ==
 Testing:
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index a1c446d5365e..70696dae1180 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -1,83 +1,83 @@
 QA output created by 083
 === Check disconnect before neg1 ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect after neg1 ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect 8 neg1 ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect 16 neg1 ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect before export ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect after export ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect 4 export ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect 12 export ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect 16 export ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect before neg2 ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect after neg2 ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect 8 neg2 ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect 10 neg2 ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect before request ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect after request ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect before reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect after reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect before data ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect after data ===
 
@@ -86,107 +86,107 @@ read 512/512 bytes at offset 0
 
 === Check disconnect before neg-classic ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect 8 neg-classic ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect 16 neg-classic ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect 24 neg-classic ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect 28 neg-classic ===
 
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect after neg-classic ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect before neg1 ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect after neg1 ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 8 neg1 ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 16 neg1 ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect before export ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect after export ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 4 export ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 12 export ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 16 export ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect before neg2 ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect after neg2 ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect 8 neg2 ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 10 neg2 ===
 
-qemu-io: can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///foo?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect before request ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect after request ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect before reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect after reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect before data ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Check disconnect after data ===
 
@@ -195,26 +195,26 @@ read 512/512 bytes at offset 0
 
 === Check disconnect before neg-classic ===
 
-qemu-io: can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 8 neg-classic ===
 
-qemu-io: can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 16 neg-classic ===
 
-qemu-io: can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 24 neg-classic ===
 
-qemu-io: can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect 28 neg-classic ===
 
-qemu-io: can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
+can't open device nbd+unix:///?socket=SOCK_DIR/nbd.sock
 
 === Check disconnect after neg-classic ===
 
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 *** done
diff --git a/tests/qemu-iotests/088.out b/tests/qemu-iotests/088.out
index 814be7181dc5..1f6bcf0abc97 100644
--- a/tests/qemu-iotests/088.out
+++ b/tests/qemu-iotests/088.out
@@ -2,10 +2,10 @@ QA output created by 088
 
 == Invalid block size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.vpc: Invalid block size 0
-qemu-io: can't open device TEST_DIR/t.vpc: Invalid block size 0
-qemu-io: can't open device TEST_DIR/t.vpc: Invalid block size 128
-qemu-io: can't open device TEST_DIR/t.vpc: Invalid block size 128
-qemu-io: can't open device TEST_DIR/t.vpc: Invalid block size 305419896
-qemu-io: can't open device TEST_DIR/t.vpc: Invalid block size 305419896
+can't open device TEST_DIR/t.vpc: Invalid block size 0
+can't open device TEST_DIR/t.vpc: Invalid block size 0
+can't open device TEST_DIR/t.vpc: Invalid block size 128
+can't open device TEST_DIR/t.vpc: Invalid block size 128
+can't open device TEST_DIR/t.vpc: Invalid block size 305419896
+can't open device TEST_DIR/t.vpc: Invalid block size 305419896
 *** done
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index a29e19b12d7e..c53fc4823a16 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -16,7 +16,7 @@ read 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 1024
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: Pattern verification failed at offset 0, 512 bytes
+Pattern verification failed at offset 0, 512 bytes
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -33,7 +33,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 229376
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 === Testing qemu-img info output ===
 
diff --git a/tests/qemu-iotests/092.out b/tests/qemu-iotests/092.out
index 3e799148735f..6eda321fc6bc 100644
--- a/tests/qemu-iotests/092.out
+++ b/tests/qemu-iotests/092.out
@@ -2,25 +2,25 @@ QA output created by 092
 
 == Invalid cluster size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-qemu-io: can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
 
 == Invalid L2 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-qemu-io: can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
+can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
 
 == Invalid size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow: Image too large
-qemu-io: can't open device TEST_DIR/t.qcow: Image too large
+can't open device TEST_DIR/t.qcow: Image too large
+can't open device TEST_DIR/t.qcow: Image too large
 
 == Invalid backing file length ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow: Backing file name too long
-qemu-io: can't open device TEST_DIR/t.qcow: Backing file name too long
+can't open device TEST_DIR/t.qcow: Backing file name too long
+can't open device TEST_DIR/t.qcow: Backing file name too long
 *** done
diff --git a/tests/qemu-iotests/103.out b/tests/qemu-iotests/103.out
index 16704cf499a0..bd9eec325028 100644
--- a/tests/qemu-iotests/103.out
+++ b/tests/qemu-iotests/103.out
@@ -5,13 +5,13 @@ wrote 65536/65536 bytes at offset 0
 
 === Testing invalid option combinations ===
 
-qemu-io: can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
-qemu-io: can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed cache-size
-qemu-io: can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not exceed cache-size
-qemu-io: can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
-qemu-io: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
-qemu-io: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
-qemu-io: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
+can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed cache-size
+can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not exceed cache-size
+can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
+can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 
 === Testing valid option combinations ===
 
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index 80220e440eca..c629db04e02f 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -10,8 +10,8 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: foo
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open backing file: Unknown driver 'foo'
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: Could not open backing file: Unknown driver 'foo'
+no file open, try 'help open'
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Could not change the backing file to 'TEST_DIR/t.qcow2.base': backing format must be specified
diff --git a/tests/qemu-iotests/116.out b/tests/qemu-iotests/116.out
index 5f6c6fffcaf2..6d9f5488063d 100644
--- a/tests/qemu-iotests/116.out
+++ b/tests/qemu-iotests/116.out
@@ -2,29 +2,29 @@ QA output created by 116
 
 == truncated header cluster ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-qemu-io: can't open device TEST_DIR/t.qed: QED table offset is invalid
+can't open device TEST_DIR/t.qed: QED table offset is invalid
 
 == invalid header magic ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-qemu-io: can't open device TEST_DIR/t.qed: Image not in QED format
+can't open device TEST_DIR/t.qed: Image not in QED format
 
 == invalid cluster size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-qemu-io: can't open device TEST_DIR/t.qed: QED cluster size is invalid
+can't open device TEST_DIR/t.qed: QED cluster size is invalid
 
 == invalid table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-qemu-io: can't open device TEST_DIR/t.qed: QED table size is invalid
+can't open device TEST_DIR/t.qed: QED table size is invalid
 
 == invalid header size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-qemu-io: can't open device TEST_DIR/t.qed: QED table offset is invalid
+can't open device TEST_DIR/t.qed: QED table offset is invalid
 
 == invalid L1 table offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-qemu-io: can't open device TEST_DIR/t.qed: QED table offset is invalid
+can't open device TEST_DIR/t.qed: QED table offset is invalid
 
 == invalid image size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-qemu-io: can't open device TEST_DIR/t.qed: QED image size is invalid
+can't open device TEST_DIR/t.qed: QED image size is invalid
 *** done
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index d70c2e8041ce..8934c32dadd0 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -4,18 +4,18 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t
 
 === Check that node-name can't be changed ===
 
-qemu-io: Cannot change the option 'node-name'
-qemu-io: Cannot change the option 'node-name'
-qemu-io: Cannot change the option 'node-name'
+Cannot change the option 'node-name'
+Cannot change the option 'node-name'
+Cannot change the option 'node-name'
 
 === Check that unchanged node-name is okay ===
 
 
 === Check that driver can't be changed ===
 
-qemu-io: Cannot change the option 'driver'
-qemu-io: Cannot change the option 'driver'
-qemu-io: Cannot change the option 'driver'
+Cannot change the option 'driver'
+Cannot change the option 'driver'
+Cannot change the option 'driver'
 
 === Check that unchanged driver is okay ===
 
@@ -27,16 +27,16 @@ format name: null-co
 
 === Check that mixing -c/-r/-w and their corresponding options is forbidden ===
 
-qemu-io: Cannot set both -r/-w and 'read-only'
-qemu-io: Cannot set both -r/-w and 'read-only'
-qemu-io: Cannot set both -c and the cache options
-qemu-io: Cannot set both -c and the cache options
-qemu-io: Cannot set both -c and the cache options
+Cannot set both -r/-w and 'read-only'
+Cannot set both -r/-w and 'read-only'
+Cannot set both -c and the cache options
+Cannot set both -c and the cache options
+Cannot set both -c and the cache options
 
 === Check that invalid options are handled correctly ===
 
-qemu-io: Parameter 'read-only' expects 'on' or 'off'
-qemu-io: Parameter 'cache.no-flush' expects 'on' or 'off'
-qemu-io: Parameter 'cache.direct' expects 'on' or 'off'
-qemu-io: Parameter 'auto-read-only' expects 'on' or 'off'
+Parameter 'read-only' expects 'on' or 'off'
+Parameter 'cache.no-flush' expects 'on' or 'off'
+Parameter 'cache.direct' expects 'on' or 'off'
+Parameter 'auto-read-only' expects 'on' or 'off'
 *** done
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index ce2a0df166ee..4abc5b5f7da6 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -24,7 +24,7 @@ read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify pattern failure with wrong password ==
-qemu-io: Pattern verification failed at offset 0, 134217728 bytes
+Pattern verification failed at offset 0, 134217728 bytes
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 1947c1a1bd7c..b22d4aeb747f 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -15,30 +15,30 @@ read 33554432/33554432 bytes at offset 0
 
 === Try setting some invalid values ===
 
-qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
-qemu-io: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
-qemu-io: l2-cache-size may not exceed cache-size
-qemu-io: refcount-cache-size may not exceed cache-size
-qemu-io: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
-qemu-io: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
-qemu-io: Refcount cache size too big
-qemu-io: Conflicting values for qcow2 options 'overlap-check' ('constant') and 'overlap-check.template' ('all')
-qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
-qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
-qemu-io: Cache clean interval too big
+Parameter 'lazy-refcounts' expects 'on' or 'off'
+cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
+l2-cache-size may not exceed cache-size
+refcount-cache-size may not exceed cache-size
+L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+Refcount cache size too big
+Conflicting values for qcow2 options 'overlap-check' ('constant') and 'overlap-check.template' ('all')
+Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
+Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
+Cache clean interval too big
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=36028797018963968
-qemu-io: L2 cache size too big
+L2 cache size too big
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 === Test transaction semantics ===
 
-qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
+Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 OK: Dirty bit not set
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
+Parameter 'lazy-refcounts' expects 'on' or 'off'
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 *** done
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 32866440aed3..c2a75fd5f7e8 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -16,7 +16,7 @@ read 65536/65536 bytes at offset 0
 { 'execute': 'eject',
        'arguments': { 'device': 'drv' }}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "drv"}}
-qemu-io: can't open device nbd+unix:///drv?socket=SOCK_DIR/nbd: Requested export not available
+can't open device nbd+unix:///drv?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'drv' not present
 { 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index d6afa32abc54..5e685a06415b 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -5,9 +5,9 @@ QA output created by 143
        'arguments': { 'addr': { 'type': 'unix',
                                 'data': { 'path': 'SOCK_DIR/nbd' }}}}
 {"return": {}}
-qemu-io: can't open device nbd+unix:///no_such_export?socket=SOCK_DIR/nbd: Requested export not available
+can't open device nbd+unix:///no_such_export?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'no_such_export' not present
-qemu-io: can't open device nbd+unix:///aa--aa1?socket=SOCK_DIR/nbd: Requested export not available
+can't open device nbd+unix:///aa--aa1?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'aa--aa...' not present
 { 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index e235d9e59e35..1607a79b36b7 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -23,22 +23,22 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 == Running utility commands  ==
 
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
-qemu-io: no file open, try 'help open'
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get shared "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
-qemu-io: no file open, try 'help open'
+no file open, try 'help open'
 
 _qemu_img_wrapper info TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
@@ -101,13 +101,13 @@ backing file format: IMGFMT
 == Running utility commands -U ==
 
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
 
 _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
@@ -168,15 +168,15 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 == Running utility commands  ==
 
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
-qemu-io: no file open, try 'help open'
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
 
@@ -225,13 +225,13 @@ backing file format: IMGFMT
 == Running utility commands -U ==
 
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
 
 _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
@@ -330,13 +330,13 @@ backing file format: IMGFMT
 == Running utility commands -U ==
 
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
 
 _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
 
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: force-share=on can only be used with read-only images
+no file open, try 'help open'
 
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
 
@@ -430,7 +430,7 @@ Adding drive
 {"return": "OKrn"}
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Creating overlay with qemu-img when the guest is running should be allowed
 
@@ -455,7 +455,7 @@ _qemu_img_wrapper info TEST_DIR/t.qcow2
 {"return": ""}
 
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Closing the other
 { 'execute': 'human-monitor-command',
@@ -478,5 +478,5 @@ qemu-img: --force-share/-U conflicts with image options
 No conflict:
 
 Conflict:
-qemu-io: -U conflicts with image options
+-U conflicts with image options
 *** done
diff --git a/tests/qemu-iotests/171.out b/tests/qemu-iotests/171.out
index 67ef9b884152..ec3363b4f440 100644
--- a/tests/qemu-iotests/171.out
+++ b/tests/qemu-iotests/171.out
@@ -21,32 +21,32 @@ wrote 1/1 bytes at offset 3583
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write across image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write at image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write after image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 writev before/after image boundary
-qemu-io: writev failed: Input/output error
+writev failed: Input/output error
 
 read before image boundary
 read 1/1 bytes at offset 3583
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read across image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read at image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read after image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 readv before/after image boundary
-qemu-io: readv failed: Input/output error
+readv failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -60,7 +60,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write zeroes across image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write zeroes at image boundary and check
 wrote 2/2 bytes at offset 3582
@@ -68,7 +68,7 @@ wrote 2/2 bytes at offset 3582
 00000ffe:  00 00  ..
 read 2/2 bytes at offset 4094
 2 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -82,7 +82,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 discard across image boundary
-qemu-io: discard failed: Input/output error
+discard failed: Input/output error
 
 discard at image boundary and check
 discard 2/2 bytes at offset 3582
@@ -90,7 +90,7 @@ discard 2/2 bytes at offset 3582
 00000ffe:  00 00  ..
 read 2/2 bytes at offset 4094
 2 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 == test 'offset' and 'size' options ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4096
@@ -113,32 +113,32 @@ wrote 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write across image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write at image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write after image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 writev before/after image boundary
-qemu-io: writev failed: Input/output error
+writev failed: Input/output error
 
 read before image boundary
 read 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read across image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read at image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read after image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 readv before/after image boundary
-qemu-io: readv failed: Input/output error
+readv failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -152,7 +152,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write zeroes across image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write zeroes at image boundary and check
 wrote 2/2 bytes at offset 2046
@@ -176,7 +176,7 @@ read 4/4 bytes at offset 510
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 discard across image boundary
-qemu-io: discard failed: Input/output error
+discard failed: Input/output error
 
 discard at image boundary and check
 discard 2/2 bytes at offset 2046
@@ -209,32 +209,32 @@ wrote 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write across image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write at image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write after image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 writev before/after image boundary
-qemu-io: writev failed: Input/output error
+writev failed: Input/output error
 
 read before image boundary
 read 1/1 bytes at offset 2047
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 read across image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read at image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 read after image boundary
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 readv before/after image boundary
-qemu-io: readv failed: Input/output error
+readv failed: Input/output error
 
 fill image with pattern
 wrote 4096/4096 bytes at offset 0
@@ -248,7 +248,7 @@ read 4/4 bytes at offset 8
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 write zeroes across image boundary
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 write zeroes at image boundary and check
 wrote 2/2 bytes at offset 2046
@@ -272,7 +272,7 @@ read 4/4 bytes at offset 8
 4 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 discard across image boundary
-qemu-io: discard failed: Input/output error
+discard failed: Input/output error
 
 discard at image boundary and check
 discard 2/2 bytes at offset 2046
@@ -290,12 +290,12 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1/1 bytes at offset 511
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1/1 bytes at offset 1023
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 checking boundaries
 000001fe:  00 00 0a 0a  ....
 read 4/4 bytes at offset 510
diff --git a/tests/qemu-iotests/187.out b/tests/qemu-iotests/187.out
index 86203d8abcb0..30b987f71f8d 100644
--- a/tests/qemu-iotests/187.out
+++ b/tests/qemu-iotests/187.out
@@ -3,16 +3,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 Start from read-only
 
-qemu-io: Block node is read-only
+Block node is read-only
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: Block node is read-only
+Block node is read-only
 
 Start from read-write
 
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: Block node is read-only
+Block node is read-only
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index 5426861b180c..0f05a6901419 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -14,7 +14,7 @@ read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify open failure with wrong password ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 
 == verify that has_zero_init returns false when preallocating ==
 Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=16777216
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index 86c57b51d303..ebb20da95f6e 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -16,7 +16,7 @@ read 2147483136/2147483136 bytes at offset 1024
 2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1024/1024 bytes at offset 3221226496
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.wrap.qcow2: Can't use copy-on-read on read-only device
+can't open device TEST_DIR/t.wrap.qcow2: Can't use copy-on-read on read-only device
 2 GiB (0x80010000) bytes     allocated at offset 0 bytes (0x0)
 1023.938 MiB (0x3fff0000) bytes not allocated at offset 2 GiB (0x80010000)
 64 KiB (0x10000) bytes     allocated at offset 3 GiB (0xc0000000)
diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 3ed3ed233ac9..947de270c8e7 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -75,11 +75,11 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 
     def assertReadFailed(self, qemu_io_output):
         self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
-                         'qemu-io: read failed: Input/output error')
+                         'read failed: Input/output error')
 
     def assertConnectFailed(self, qemu_io_output):
         self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
-                         "qemu-io: can't open device " + nbd_uri +
+                         "can't open device " + nbd_uri +
                          ": Requested export not available\n"
                          "server reported: export 'exp' not present")
 
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
index 26056938ee9e..9fc67287f8e1 100644
--- a/tests/qemu-iotests/214.out
+++ b/tests/qemu-iotests/214.out
@@ -7,7 +7,7 @@ wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 No errors were found on the image.
 read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/215.out b/tests/qemu-iotests/215.out
index 5a2fe40d0314..70b0f5fb1956 100644
--- a/tests/qemu-iotests/215.out
+++ b/tests/qemu-iotests/215.out
@@ -16,7 +16,7 @@ read 2147483136/2147483136 bytes at offset 1024
 2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1024/1024 bytes at offset 3221226496
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.wrap.qcow2: Block node is read-only
+can't open device TEST_DIR/t.wrap.qcow2: Block node is read-only
 2 GiB (0x80010000) bytes     allocated at offset 0 bytes (0x0)
 1023.938 MiB (0x3fff0000) bytes not allocated at offset 2 GiB (0x80010000)
 64 KiB (0x10000) bytes     allocated at offset 3 GiB (0xc0000000)
diff --git a/tests/qemu-iotests/220.out b/tests/qemu-iotests/220.out
index 6f200ec89479..33b994b8a14b 100644
--- a/tests/qemu-iotests/220.out
+++ b/tests/qemu-iotests/220.out
@@ -38,7 +38,7 @@ wrote 2097152/2097152 bytes at offset 37748736
 No errors were found on the image.
 image size 39845888
 == Trying to write compressed cluster ==
-qemu-io: write failed: File too large
+write failed: File too large
 image size 562949957615616
 == Writing normal cluster ==
 wrote 2097152/2097152 bytes at offset 0
diff --git a/tests/qemu-iotests/226.out b/tests/qemu-iotests/226.out
index 55504d29c4b3..14d1be50f748 100644
--- a/tests/qemu-iotests/226.out
+++ b/tests/qemu-iotests/226.out
@@ -3,24 +3,24 @@ QA output created by 226
 === Testing with driver:file ===
 
 == Testing RO ==
-qemu-io: can't open: 'file' driver requires 'TEST_DIR/t.IMGFMT' to be a regular file
-qemu-io: can't open: 'file' driver requires '/dev/null' to be a regular file
+can't open: 'file' driver requires 'TEST_DIR/t.IMGFMT' to be a regular file
+can't open: 'file' driver requires '/dev/null' to be a regular file
 == Testing RW ==
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
-qemu-io: can't open: 'file' driver requires '/dev/null' to be a regular file
+can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+can't open: 'file' driver requires '/dev/null' to be a regular file
 
 === Testing with driver:host_device ===
 
 == Testing RO ==
-qemu-io: can't open: 'host_device' driver requires 'TEST_DIR/t.IMGFMT' to be either a character or block device
+can't open: 'host_device' driver requires 'TEST_DIR/t.IMGFMT' to be either a character or block device
 == Testing RW ==
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
 
 === Testing with driver:host_cdrom ===
 
 == Testing RO ==
-qemu-io: can't open: 'host_cdrom' driver requires 'TEST_DIR/t.IMGFMT' to be either a character or block device
+can't open: 'host_cdrom' driver requires 'TEST_DIR/t.IMGFMT' to be either a character or block device
 == Testing RW ==
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
 
 *** done
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index c5e62146c930..6b7fbb3a4168 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -9,23 +9,23 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
+no file open, try 'help open'
 
 Data file required, but without data file name in the image:
-qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' is required for this image
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: 'data-file' is required for this image
+no file open, try 'help open'
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
+no file open, try 'help open'
 
 Setting data-file for an image with internal data:
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' can only be set for images with an external data file
-qemu-io: no file open, try 'help open'
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
-qemu-io: no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: 'data-file' can only be set for images with an external data file
+no file open, try 'help open'
+can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
+no file open, try 'help open'
 
 === Conflicting features ===
 
@@ -37,7 +37,7 @@ qemu-img: error while writing at byte 0: Operation not supported
 
 Convert uncompressed, then write compressed data manually:
 Images are identical.
-qemu-io: write failed: Operation not supported
+write failed: Operation not supported
 No errors were found on the image.
 
 Take an internal snapshot:
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
index da92d4b5b1ab..0b24d501595b 100644
--- a/tests/qemu-iotests/271.out
+++ b/tests/qemu-iotests/271.out
@@ -456,7 +456,7 @@ L2 entry #0: 0x8000000000050001 0000000000000001
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x8000000000060000 00000001ffffffff
 qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 ### Corrupted L2 entries - read test (unallocated) ###
 
@@ -471,14 +471,14 @@ L2 entry #0: 0x0000000000000001 0000000000000000
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #0: 0x0000000000000000 0000000000000001
 qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 # Both 'subcluster is zero' and 'subcluster is allocated' bits set
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x0000000000000000 0000000100000001
 qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 ### Compressed cluster with subcluster bitmap != 0 - read test ###
 
@@ -501,7 +501,7 @@ L2 entry #0: 0x8000000000050001 0000000000000001
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x8000000000060000 00000001ffffffff
 qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 ### Corrupted L2 entries - write test (unallocated) ###
 
@@ -516,14 +516,14 @@ L2 entry #0: 0x8000000000060000 0000000000000001
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #0: 0x0000000000000000 0000000000000001
 qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 # Both 'subcluster is zero' and 'subcluster is allocated' bits set
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x0000000000000000 0000000100000001
 qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 ### Compressed cluster with subcluster bitmap != 0 - write test ###
 
@@ -555,7 +555,7 @@ Double checking the fixed image now...
 1 errors were found on the image.
 Data may be corrupted, or further writes to the image may corrupt it.
 qcow2: Marking image as corrupt: Cluster allocation offset 0x50200 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 # Corrupted L2 entry, no allocated subclusters #
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
 Repairing offset=50200: Preallocated cluster is not properly aligned; L2 entry corrupted.
diff --git a/tests/qemu-iotests/289.out b/tests/qemu-iotests/289.out
index 58e4f4942f0c..e54e2629d4dc 100644
--- a/tests/qemu-iotests/289.out
+++ b/tests/qemu-iotests/289.out
@@ -3,6 +3,6 @@ QA output created by 289
 === Avoid freeing external data clusters on failure ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536 data_file=TEST_DIR/t.IMGFMT.data_file
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/293.out b/tests/qemu-iotests/293.out
index 72607831260c..5e5b0d8d54b8 100644
--- a/tests/qemu-iotests/293.out
+++ b/tests/qemu-iotests/293.out
@@ -23,10 +23,10 @@ read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == erase slot 0 and try it ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 
 == erase slot 2 and try it ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 
 == filling  4 slots with secret 2 ==
 
@@ -54,9 +54,9 @@ read 4096/4096 bytes at offset 0
 qemu-img: All the active keyslots match the (old) password that was given and erasing them will erase all the data in the image irreversibly - refusing operation
 
 == only secret3 should work now  ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
@@ -66,9 +66,9 @@ read 4096/4096 bytes at offset 0
 == only secret0 should work now  ==
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 
 == replace secret0 with secret1 (should fail)  ==
 qemu-img: Refusing to overwrite active keyslot 0 - please erase it first
@@ -76,11 +76,11 @@ qemu-img: Refusing to overwrite active keyslot 0 - please erase it first
 == replace secret0 with secret1 with force (should work)  ==
 
 == only secret1 should work now  ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 
 == erase last secret (should fail)  ==
 qemu-img: Attempt to erase the only active keyslot 0 which will erase all the data in the image irreversibly - refusing operation
@@ -92,8 +92,8 @@ qemu-img: No keyslots match given (old) password for erase operation
 == erase last secret with force by slot (should work)  ==
 
 == we have no secrets now, data is lost forever ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 *** done
diff --git a/tests/qemu-iotests/294.out b/tests/qemu-iotests/294.out
index 994ae873081c..6aeabb43f604 100644
--- a/tests/qemu-iotests/294.out
+++ b/tests/qemu-iotests/294.out
@@ -15,14 +15,14 @@ read 4096/4096 bytes at offset 0
 == erase slot 0 ==
 
 == test that key 0 doesn't open the image ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 
 == 'restore' the image header ==
 1+0 records in
 1+0 records out
 
 == test that key 0 still doesn't open the image (key material is erased) ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+can't open: Invalid password, cannot unlock any keyslot
 
 == test that key 1 still works ==
 read 4096/4096 bytes at offset 0
diff --git a/tests/qemu-iotests/305.out b/tests/qemu-iotests/305.out
index af09d6a3ff48..538019e72601 100644
--- a/tests/qemu-iotests/305.out
+++ b/tests/qemu-iotests/305.out
@@ -12,5 +12,5 @@ discard 1024/1024 bytes at offset 125952
 ### Corrupt the offset of the second refcount block
 ### Try to allocate the discarded clusters again
 qcow2: Marking image as corrupt: Refblock offset 0x20600 unaligned (reftable index: 0x1); further corruption events will be suppressed
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 *** done
diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
index 608b407a6fc5..a9b37d3ac119 100644
--- a/tests/qemu-iotests/307.out
+++ b/tests/qemu-iotests/307.out
@@ -127,7 +127,7 @@ exports available: 1
 {"error": {"class": "GenericError", "desc": "export 'export1' still in use"}}
 {"execute": "block-export-del", "arguments": {"id": "export1", "mode": "hard"}}
 {"return": {}}
-qemu-io: read failed: Input/output error
+read failed: Input/output error
 
 {"execute": "query-block-exports", "arguments": {}}
 {"return": []}
diff --git a/tests/qemu-iotests/tests/file-io-error.out b/tests/qemu-iotests/tests/file-io-error.out
index bf8c0018ba5a..0f46455a94a7 100644
--- a/tests/qemu-iotests/tests/file-io-error.out
+++ b/tests/qemu-iotests/tests/file-io-error.out
@@ -21,7 +21,7 @@ QA output created by file-io-error
       }}
 {"return": {}}
 
-qemu-io: write failed: Input/output error
+write failed: Input/output error
 
 {'execute': 'block-export-del',
       'arguments': {'id': 'exp0'}}
diff --git a/tests/qemu-iotests/tests/image-fleecing.out b/tests/qemu-iotests/tests/image-fleecing.out
index dc788f1e20a4..acfc89ff0e99 100644
--- a/tests/qemu-iotests/tests/image-fleecing.out
+++ b/tests/qemu-iotests/tests/image-fleecing.out
@@ -238,13 +238,13 @@ read -P0xd5 1M 64k
 read -P0xdc 32M 64k
 read -P0xcd 0x3ff0000 64k
 read -P0 0x00f8000 32k
-qemu-io: read failed: Invalid argument
+read failed: Invalid argument
 
 read -P0 0x2010000 32k
-qemu-io: read failed: Invalid argument
+read failed: Invalid argument
 
 read -P0 0x3fe0000 64k
-qemu-io: read failed: Invalid argument
+read failed: Invalid argument
 
 
 --- Testing COW ---
@@ -265,13 +265,13 @@ read -P0xd5 1M 64k
 read -P0xdc 32M 64k
 read -P0xcd 0x3ff0000 64k
 read -P0 0x00f8000 32k
-qemu-io: read failed: Invalid argument
+read failed: Invalid argument
 
 read -P0 0x2010000 32k
-qemu-io: read failed: Invalid argument
+read failed: Invalid argument
 
 read -P0 0x3fe0000 64k
-qemu-io: read failed: Invalid argument
+read failed: Invalid argument
 
 
 --- Cleanup ---
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
index 96af7608ded2..cdb5bfbaac5b 100644
--- a/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -215,16 +215,16 @@ target-fmt active: True
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-qemu-io: write failed: Operation not permitted
+write failed: Operation not permitted
 
-qemu-io: write failed: Operation not permitted
+write failed: Operation not permitted
 
-qemu-io: write failed: Operation not permitted
+write failed: Operation not permitted
 
-qemu-io: discard failed: Operation not permitted
+discard failed: Operation not permitted
 
 
-qemu-io: Failed to get allocation status: Operation not permitted
+Failed to get allocation status: Operation not permitted
 
 
 === Inactivating a read-only node ===
diff --git a/tests/qemu-iotests/tests/nbd-reconnect-on-open.out b/tests/qemu-iotests/tests/nbd-reconnect-on-open.out
index b3dd90f2a3cd..69544c38a560 100644
--- a/tests/qemu-iotests/tests/nbd-reconnect-on-open.out
+++ b/tests/qemu-iotests/tests/nbd-reconnect-on-open.out
@@ -2,10 +2,10 @@ read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 Check fail to connect with 0 seconds of timeout
-qemu-io: can't open: Failed to connect to 'SOCK_DIR/PID-nbd-sock': No such file or directory
+can't open: Failed to connect to 'SOCK_DIR/PID-nbd-sock': No such file or directory
 
 qemu_io finished in 0..0.2 seconds, OK
 Check fail to connect with 1 seconds of timeout
-qemu-io: can't open: Failed to connect to 'SOCK_DIR/PID-nbd-sock': No such file or directory
+can't open: Failed to connect to 'SOCK_DIR/PID-nbd-sock': No such file or directory
 
 qemu_io finished in 1..1.2 seconds, OK
diff --git a/tests/qemu-iotests/tests/parallels-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
index df6f6761062e..580296d179ba 100644
--- a/tests/qemu-iotests/tests/parallels-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-bitmap.out
@@ -82,10 +82,10 @@ qemu-img: Operation add on bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69 failed: B
     in use after deactivation: False
     in use after activation:   True
 --- a bitmap which can not be written is reported, not lost in silence
-    qemu-io: Lost persistent bitmaps during inactivation of node 'NODE_NAME': Can't save dirty bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69: IO error: Input/output error
+    Lost persistent bitmaps during inactivation of node 'NODE_NAME': Can't save dirty bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69: IO error: Input/output error
     in use after the failure:  True
 --- but the guest data went through, and the image says it is in use
-qemu-io: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong parallels Format Extension magic: 0x1111111111111111, expected: 0xab234cef23dcea87
+warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong parallels Format Extension magic: 0x1111111111111111, expected: 0xab234cef23dcea87
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index f6806f82fa76..bc77ce1f5347 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -146,7 +146,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == open must fail cleanly instead of aborting ==
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Invalid image: Catalog size too small for advertised disk size
 == write into the uncovered range must fail cleanly too ==
-qemu-io: can't open device TEST_DIR/t.parallels: Invalid image: Catalog size too small for advertised disk size
+can't open device TEST_DIR/t.parallels: Invalid image: Catalog size too small for advertised disk size
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST BAT ENTRY POINTING OUTSIDE IMAGE ==
 == corrupt image: point first cluster far outside the file ==
@@ -307,7 +307,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == a guest write may reuse the extension cluster, so clobber it ==
 == pretend the image was not closed correctly ==
 == the image opens, the extension is dropped ==
-qemu-io: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong parallels Format Extension magic: 0xaaaaaaaaaaaaaaaa, expected: 0xab234cef23dcea87
+warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong parallels Format Extension magic: 0xaaaaaaaaaaaaaaaa, expected: 0xab234cef23dcea87
 Repairing image was not closed correctly
 Repairing space leaked at the end of the image 1048576
 wrote 65536/65536 bytes at offset 0
diff --git a/util/error-report.c b/util/error-report.c
index 8932beebfb9f..451ee2af4599 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -185,7 +185,7 @@ static void print_loc(MonitorHMP *hmp)
     int i;
     const char *const *argp;
 
-    if (!hmp && g_get_prgname()) {
+    if (!hmp && g_get_prgname() && *g_get_prgname()) {
         fprintf(stderr, "%s:", g_get_prgname());
         sep = " ";
     }

-- 
2.56.0.rc0.29.g47ce80527c56


