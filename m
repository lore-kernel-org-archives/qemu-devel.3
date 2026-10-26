Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kFMor6gZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLDK-0001UK-05; Mon, 26 Oct 2026 09:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLCY-0007rw-GL; Mon, 26 Oct 2026 09:57:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLCV-0000JX-CV; Mon, 26 Oct 2026 09:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022943; bh=ZHf1AyGrZUyT6m1rch+yS5qkcyGQD5G5YAQuxjwG0fU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kFMor6gZF6fmmUSPC9qNqB8U9xZdYQU5U6WSADk2zF58vc6HEJgPxW3AqUbCjCPvz
 U0gKLTKoHMSnk4SuNM8/Grs5MyVYcncg4HYH0r621Kd8goQqpCZcH6SrSZmxyYZvie
 2DNTMJjxYklBABrrcd2ZfHh56VhocrUZNsTaBx5O/4AlRKNPi5UggwwrViskIsaw0l
 y0xd8xlnazR5G+ryUCDd4e1p40GYos35rDaMg6I7Cbnm3M0f5+1yvle2xLvtv2eg7P
 2XIA+81udXnxIF13SzRN7sulBn9YXKx0CE/54SDBtCe+xNiM39pOvbF6VJAxyM3wF7
 g3M8MzAdv1jzw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E42B81E1299;
 Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E20A544B8EA;
 Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D8DF0934B9; Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 76/98] iotests: add test cases for failing flush
 after qemu-img convert
Date: Mon, 26 Oct 2026 16:55:03 +0300
Message-ID: <20261026135529.1019772-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fiona Ebner <f.ebner@proxmox.com>

In preparation to add more checks in the following commits and show
how the behavior changes.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260930132140.2342574-2-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 90b5f6ca171dcc7673c95e31f2a270b64608bb70)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index be0f6b79e5d..488649f1bd0 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -334,6 +334,39 @@ echo
 $QEMU_IMG convert -O $IMGFMT -o preallocation=metadata -n \
 	  "$TEST_IMG" "$TEST_IMG".orig && echo "unexpected success"
 
+echo
+echo "=== failing flush after convert with default ('unsafe') cache mode ==="
+echo
+
+TEST_IMG="$TEST_IMG".orig _make_test_img 1M
+TEST_IMG="$TEST_IMG" _make_test_img 1M
+
+$QEMU_IO -c "write -P 42 0 1M" "$TEST_IMG".orig | _filter_qemu_io
+
+target_fails_flush="json:{
+    'driver': '$IMGFMT',
+    'file': {
+        'driver': 'blkdebug',
+        'inject-error': [{
+            'event': 'flush_to_disk'
+        }],
+        'image': {
+            'driver': 'file',
+            'filename': '$TEST_IMG'
+        }
+    }
+}"
+
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush"
+echo "qemu-img convert exited with status $?"
+
+echo
+echo "=== failing flush after convert with 'writeback' cache mode ==="
+echo
+
+$QEMU_IMG convert -t writeback -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush"
+echo "qemu-img convert exited with status $?"
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 6a1aa3fe2b9..f3e28f33bc2 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -256,4 +256,18 @@ Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
 === -n incompatible with -o ===
 
 qemu-img: -o has no effect when skipping image creation
+
+=== failing flush after convert with default ('unsafe') cache mode ===
+
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img convert exited with status 0
+
+=== failing flush after convert with 'writeback' cache mode ===
+
+qemu-img: Failed to flush the L2 table cache: Input/output error
+qemu-img: Failed to flush the refcount block cache: Input/output error
+qemu-img convert exited with status 0
 *** done
-- 
2.47.3


