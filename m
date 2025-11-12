Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CC6CD3428
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 17:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJENz-0000kt-PL; Wed, 12 Nov 2025 12:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1vJEMg-0006id-ST; Wed, 12 Nov 2025 12:10:39 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1vJEMQ-0005C8-13; Wed, 12 Nov 2025 12:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5IdLrr6gwvITdekkQlm5kKyIg7/OH1LZk4HmFzEcghU=; b=VhidzxHrisueQRpXYfg3MziXWG
 epAW2MZARds3k0p9BuC0i3dACk8tbzNKxLP5o9IwNYQQHSFJ4lf9vWpsMbG2Ku0dWs+QrYO3S/f3F
 21v+goOBFjAPKjw9r0CLILcz3XV+bEXQftNfjQoRVYPx5OWZb+1Rz641q+Pj4Z2aukf+YYN1vrez7
 UqRcHEmbu0z2bsv8+1JufeTJ2Eica1EplfmnFcppHpXsjJNQzLjNl2ZLGmlJcxvTzx6yh7Q0dmSKW
 6rsi+VyyhNv10pw7k7MG10HR8QWDDzp0NUA3iQ7ZcHOfYjMA171z6OqMSJhi2om9maXxNEO30Ikhw
 IMAzZV9Q==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vJEMA-005e36-Tu; Wed, 12 Nov 2025 18:10:06 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1vJEMA-00000002wKD-3Mto;
 Wed, 12 Nov 2025 18:10:06 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PATCH] tests/qemu-iotest: fix iotest 024 with qed images
Date: Wed, 12 Nov 2025 18:09:57 +0100
Message-ID: <20251112170959.700840-1-berto@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use 'qemu-io -c map' instead of 'qemu-img map' to get an output that
works with both image types.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 909852ba6b4a ("qemu-img rebase: don't exceed IO_BUF_SIZE in one operation")
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/024     | 2 +-
 tests/qemu-iotests/024.out | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

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


