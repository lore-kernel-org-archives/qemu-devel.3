Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2023CCA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnvS-0002hH-Ig; Thu, 08 Oct 2026 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvO-0002fB-Qc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvM-0002Ot-7b
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4pnkdq8uFn8PDlHCFA+JC4qDnFiswXUp1gwT6kKPzs=;
 b=Q+PWWuthui/Srrqipnbn3IaRSuHyNuGgsKCthw1hjOZ265v8Q81OIJb+vI1jS8lU6uwlEg
 7iDtPxhK6Dyy6WMgDGVgV+CZgq26uDhOQLHe4cJWwuco1VqQhgLDgFrjRVPvOw2+/J96Bm
 SrN5BVO0jhsVBIwj3FS2CQ31O1XD/Ag=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-swzz7rytPo-n8s4RFhV01g-1; Thu,
 08 Oct 2026 09:12:35 -0400
X-MC-Unique: swzz7rytPo-n8s4RFhV01g-1
X-Mimecast-MFC-AGG-ID: swzz7rytPo-n8s4RFhV01g_1791465153
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BA40195F154; Thu,  8 Oct 2026 13:12:33 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAFAF30001BB; Thu,  8 Oct 2026 13:12:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 03/15] iotests: add test cases for failing flush after qemu-img
 convert
Date: Thu,  8 Oct 2026 08:11:42 -0500
Message-ID: <20261008131216.2437896-20-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Fiona Ebner <f.ebner@proxmox.com>

In preparation to add more checks in the following commits and show
how the behavior changes.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260930132140.2342574-2-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/122     | 33 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 14 ++++++++++++++
 2 files changed, 47 insertions(+)

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
2.56.0


