Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976BDCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd8M-000612-J3; Fri, 21 Nov 2025 21:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcuq-0000NK-Em; Fri, 21 Nov 2025 20:59:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMctJ-00080x-A6; Fri, 21 Nov 2025 20:59:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0845416CA69;
 Fri, 21 Nov 2025 21:44:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B8988321CA5;
 Fri, 21 Nov 2025 21:44:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 46/81] tests/qemu-iotest: fix iotest 024 with qed
 images
Date: Fri, 21 Nov 2025 21:43:45 +0300
Message-ID: <20251121184424.1137669-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alberto Garcia <berto@igalia.com>

Use 'qemu-io -c map' instead of 'qemu-img map' to get an output that
works with both image types.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 909852ba6b4a ("qemu-img rebase: don't exceed IO_BUF_SIZE in one operation")
Fixes: 585d5c1db8bd ("qemu-img rebase: don't exceed IO_BUF_SIZE in one operation") in 10.0.x
Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-ID: <20251112170959.700840-1-berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 4c91719a6a78a1c24d8bb854f7594e767962d0d9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 021169b4a1..10be2bd845 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -359,7 +359,7 @@ $QEMU_IO "$OVERLAY" -c "read -P 0x00  0 1M" | _filter_qemu_io
 $QEMU_IO "$OVERLAY" -c "read -P 0xff 1M 2M" | _filter_qemu_io
 $QEMU_IO "$OVERLAY" -c "read -P 0x00 3M 1M" | _filter_qemu_io
 
-$QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
+$QEMU_IO -c map "$OVERLAY" | _filter_qemu_io
 
 echo
 
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 1b7522ba71..da8fedc08b 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -266,7 +266,6 @@ read 2097152/2097152 bytes at offset 1048576
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1048576/1048576 bytes at offset 3145728
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0               0x400000        TEST_DIR/subdir/t.IMGFMT
+4 MiB (0x400000) bytes     allocated at offset 0 bytes (0x0)
 
 *** done
-- 
2.47.3


