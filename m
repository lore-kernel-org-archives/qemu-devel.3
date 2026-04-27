Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACFDFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHPPF-0007qG-V8; Mon, 27 Apr 2026 13:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wHPPA-0007j4-KK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wHPP8-0006Ud-8g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777309553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xt1Ev/wLan3HxX+yy3/W3SrxiXPBZBxO+DaqEQ//04c=;
 b=FRO0mJvj0nXivpU+I9K5yx16vr/Wk6M7gYG79LbBwzK/vNTJmu/+ch7UM4N+lvKHw79nvD
 mUFp5UR2wlmQvggDsnwF3os5cFXCKUm8T2XPnSVK9swGAY9NLtv3gNX61kdHr2Ekg1DSaI
 BBPBO6wx6oXu9MSSL0GiX0/UsJ+lDrY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-IC3RRJevMQyC33fVLEPCjw-1; Mon,
 27 Apr 2026 13:05:50 -0400
X-MC-Unique: IC3RRJevMQyC33fVLEPCjw-1
X-Mimecast-MFC-AGG-ID: IC3RRJevMQyC33fVLEPCjw_1777309549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C1C919560B4; Mon, 27 Apr 2026 17:05:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FE121800446; Mon, 27 Apr 2026 17:05:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 4/4] iotests/046: Test that discard/write_zeroes wait for
 dependencies
Date: Mon, 27 Apr 2026 19:05:20 +0200
Message-ID: <20260427170520.101242-5-kwolf@redhat.com>
In-Reply-To: <20260427170520.101242-1-kwolf@redhat.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a regression test for the bug fixed in the previous commit where
discard and write_zeroes operations wouldn't consider their dependencies
in s->cluster_allocs. Without the fix, this results in a corrupted
image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/046     | 46 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/046.out | 36 +++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 4c9ed4d26e1..e03dd401479 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -184,6 +184,48 @@ aio_write -P 160 0x104000 0x18000
 resume A
 aio_flush
 EOF
+
+# Create a pre-allocated zero cluster, then start a write on it and discard it
+# before the L2 update is made
+cat  <<EOF
+write -P 181 0x120000 0x10000
+write -z 0x120000 0x10000
+
+break write_aio A
+aio_write -P 180 0x120000 0x10000
+wait_break A
+aio_discard 0x120000 0x10000
+resume A
+aio_flush
+EOF
+
+# Create a pre-allocated zero cluster, then start a write on it and a
+# concurrent zero write with MAY_UNMAP before the L2 update is made
+cat  <<EOF
+write -P 181 0x130000 0x10000
+write -z 0x130000 0x10000
+
+break write_aio A
+aio_write -P 180 0x130000 0x10000
+wait_break A
+aio_write -z -u 0x130000 0x10000
+resume A
+aio_flush
+EOF
+
+# Create a pre-allocated zero cluster, then start a write on it and a
+# concurrent zero write without MAY_UNMAP before the L2 update is made
+cat  <<EOF
+write -P 181 0x140000 0x10000
+write -z 0x140000 0x10000
+
+break write_aio A
+aio_write -P 180 0x140000 0x10000
+wait_break A
+aio_write -z 0x140000 0x10000
+resume A
+aio_flush
+EOF
 }
 
 overlay_io | $QEMU_IO blkdebug::"$TEST_IMG" | _filter_qemu_io |\
@@ -264,6 +306,10 @@ verify_io()
     # Undefined content for 0x10c000 0x8000
     echo read -P 160 0x114000 0x8000
     echo read -P 17  0x11c000 0x4000
+
+    echo read -P 0   0x120000 0x10000
+    echo read -P 0   0x130000 0x10000
+    echo read -P 0   0x140000 0x10000
 }
 
 verify_io | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index b1a03f40414..6341df335c9 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -139,6 +139,36 @@ wrote XXX/XXX bytes at offset XXX
 XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+blkdebug: Suspended request 'A'
+blkdebug: Resuming request 'A'
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discarded  XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+blkdebug: Suspended request 'A'
+blkdebug: Resuming request 'A'
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+blkdebug: Suspended request 'A'
+blkdebug: Resuming request 'A'
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == Verify image content ==
 read 65536/65536 bytes at offset 0
@@ -239,5 +269,11 @@ read 32768/32768 bytes at offset 1130496
 32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 16384/16384 bytes at offset 1163264
 16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 1179648
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 1245184
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 1310720
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 *** done
-- 
2.53.0


