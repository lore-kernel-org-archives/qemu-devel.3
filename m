Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3620C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972D-0000rM-4q; Tue, 22 Sep 2026 16:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971Y-0006Lw-1a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971W-0000Pk-G9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9NActlqZrsqXIi6E6W/1zrSkYpuOjkw9/ZCmANmogk=;
 b=OUDApCIHBatwl9CUgaHcWzKmsMRWRgOOIjyVo/QcEUkhtLOVsslA12ZtO+YkGjh509qAsq
 FXbKMpbDLnTffut/G657R65aru4zZgcdq0IDaA/s0gzI/mxwG6m7DYyHwHsKOEgcKVEo/Q
 vSNEfqFZHGC8FnssoNknExDfZSyOmmY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-jD-GX_d_MRimFiq_DWNGgA-1; Tue,
 22 Sep 2026 16:23:28 -0400
X-MC-Unique: jD-GX_d_MRimFiq_DWNGgA-1
X-Mimecast-MFC-AGG-ID: jD-GX_d_MRimFiq_DWNGgA_1790108607
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C3D11955F28; Tue, 22 Sep 2026 20:23:27 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AA613000223; Tue, 22 Sep 2026 20:23:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:19 +0400
Subject: [PATCH 72/88] qemu-iotests/145: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-72-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AjZGx6vuolVU8p5Fw4suRr0BtpDzQNyU9vyTBsiRh+g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzOAsXcmj9cUGwpUSOCoVAQkkPwHpdHn6kg
 DqOpol6zC6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5aN1EACdHOXz8oOAPicUqFza7+yoftWISGBmHqvrVwTfb8EWOJSkb3eKKAtlqJXoXRJBfRbUaD0
 oNsZ6hpmONxaro/qk7PzUehElQuUP7la4rwdvaiEBE2z0s4wFOhNbdzAMy7B3vvP/hHi1qNDQ21
 i/D25uQ78s6rjiMDVMfVuiPCThyuUDMUk/eOFaWu/644gL0DQb24v7ZM2AVB5ll5LJQcqoOGpDf
 C6ug20NxAX/tZTCGRnhQtjHQxmKRCdrzYQ68ooPqCuRYQfLFMA+MJi7Rj0acqK78Tq8qMS1MQAv
 MViLPQtnTCsQEJX3FBGAtbkd2z96a7BL7dkjEFgAlSUxamTDs77U7jsvGV/f07PI/uuP2DbqcGK
 0y8tOWi3QcAha5UB9/tE2cTGbRUTCxVhr57lW/Fjgepc8VVsBXcFXr9nUCR96VZuowEX3ERtHzD
 KZRP02IjNXhlefaSdQbQb+Greqpxbx570RsgxF9KIY57qu6vsenb/PYFO1qqrPIwK3XCcBZXU7X
 zL/XQ5WOWgD4pJ4Ab2JrczfESqX84KqZ8HOkupoTUL6ySj3p8xkMuVhs32vgIHiYMik4PfvSVR/
 2qBa5gPUR3eRsDx6fQxN+baeoCReiQy9cZCJx/As8Na2p7sUqc70xG3FTKO9qwyr1rjTKR67932
 GhBDk8QBgajRTkQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/145     | 8 ++++----
 tests/qemu-iotests/145.out | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index f61a50f63951..d763ea14417a 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_require_hmp
 
 _make_test_img 1M
 
@@ -57,9 +56,10 @@ else
     SYSEMU_EXTRA_ARGS=""
 fi
 
-echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
-                  -incoming 'exec:true' -snapshot -serial none -monitor stdio \
-          | _filter_qemu | _filter_hmp
+printf '%s\n' '{"execute":"qmp_capabilities"}' '{"execute":"quit"}' \
+    | $QEMU -nographic $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
+            -incoming 'exec:true' -snapshot -serial none -qmp stdio \
+    | _filter_qmp | _filter_qemu
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/145.out b/tests/qemu-iotests/145.out
index 9a90009e44e3..d7ab88904278 100644
--- a/tests/qemu-iotests/145.out
+++ b/tests/qemu-iotests/145.out
@@ -1,5 +1,7 @@
 QA output created by 145
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


