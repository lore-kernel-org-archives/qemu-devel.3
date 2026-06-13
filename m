Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893A1CD98D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUfz-0002Xe-HQ; Sat, 13 Jun 2026 16:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfu-000208-V4; Sat, 13 Jun 2026 16:09:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfr-00031m-07; Sat, 13 Jun 2026 16:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381070; bh=NeizuiU9CNw1ZzTV6M1T2A/yYQYGEMCvWTUWZVtOwzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vSFGFoVgTSTrjY3K9nrE6jGcgHCWjEpY4W7Q3EGU3Wrcda8u66TfSktnONsdnnikZ
 Lnrw3YgoZZXkGOpna9kfr+U2yhzAgozpPQZaPMBzzC7b3A7Aff/6OPWsAJsFzPc5jU
 knCVH6szoG01X7DXbzQ9NZQcNjY3wBShajjhm4pczkZ2mFw/tGXnIPwxSQOORrP4mW
 S5cPg+K9RR3/qBLenRJis6Q0fkGYP0knmY2uM8Um0Ixw3XsFpwjODA5hbxE0+5+Ta4
 hVfmk/0pCoIeYDx4596ZEEpmS0jGNFX0sVzQ2zblHRUffWcAGme5Upsma2hqMzbV/h
 7rcR8HUjDbrUw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E2B411B6EA7;
 Sat, 13 Jun 2026 23:04:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4BD6A3CE901;
 Sat, 13 Jun 2026 23:04:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 55/61] iotests/046: Test that discard/write_zeroes
 wait for dependencies
Date: Sat, 13 Jun 2026 23:03:38 +0300
Message-ID: <20260613200411.1808021-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

This is a regression test for the bug fixed in the previous commit where
discard and write_zeroes operations wouldn't consider their dependencies
in s->cluster_allocs. Without the fix, this results in a corrupted
image.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260427170520.101242-5-kwolf@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Tested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 389f5bcc744d3ddc127d550a57261aed9bbba1f3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 4c9ed4d26e..e03dd40147 100755
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
index b1a03f4041..6341df335c 100644
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
2.47.3


