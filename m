Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE45AD2D105
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffAL-0003ql-MV; Tue, 13 Jan 2026 09:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vffAK-0003pp-J9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:14:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vffAJ-0003jX-45
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768313672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9HajdmobONRARRFgwe7OqKPM/j4e/rKBGfUCIx3mNbc=;
 b=GCjprV6+SzY2YxAwdEO++tk+cdjY+ncJPPq0gt95JPEi4R2+1p/HERXlAbFrTFecT3EKTP
 6ajsSbBxjE6wGHftx36pAIqs9wRGYIk2YA96EDH0s9MpReyS9/9aZlFQO11UYFRBv5z0Gs
 5kAPOLsl5eHPvJaLZQXXLueT6wLbhgo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-7PDv_F6gMtiUoqA0NMKq6Q-1; Tue,
 13 Jan 2026 09:14:31 -0500
X-MC-Unique: 7PDv_F6gMtiUoqA0NMKq6Q-1
X-Mimecast-MFC-AGG-ID: 7PDv_F6gMtiUoqA0NMKq6Q_1768313670
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 065A31956061; Tue, 13 Jan 2026 14:14:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F02E19560BA; Tue, 13 Jan 2026 14:14:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/qemu-iotests: Use "gsed" for expressions that require
 GNU sed
Date: Tue, 13 Jan 2026 15:14:15 +0100
Message-ID: <20260113141415.97281-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

A bunch of tests are currently failing e.g. on FreeBSD like this:

 082   fail       [13:38:58] [13:38:59]   0.5s                 output
  mismatch (see .../build/tests/qemu-iotests/scratch/qcow2-file-082/082.out.bad)
 --- .../src/tests/qemu-iotests/082.out
 +++ .../build/tests/qemu-iotests/scratch/qcow2-file-082/082.out.bad
 @@ -17,7 +17,7 @@
  cluster_size: 4096
  Format specific information:
      compat: 1.1
 -    compression type: COMPRESSION_TYPE
 +    compression type: zlib
      lazy refcounts: true
      refcount bits: 16
      corrupt: false

This happens because the sed statements require GNU sed. Let's use
gsed in these spots to get it fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/286       | 2 +-
 tests/qemu-iotests/common.rc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/286 b/tests/qemu-iotests/286
index 38216c2a0e2..cc6aacf0228 100755
--- a/tests/qemu-iotests/286
+++ b/tests/qemu-iotests/286
@@ -62,7 +62,7 @@ wait=yes _cleanup_qemu
 
 echo 'Output structure:'
 $QEMU_IMG snapshot -l "$TEST_IMG" | tail -n 1 | tr -s ' ' \
-    | sed -e 's/\S\+/./g' \
+    | gsed -e 's/\S\+/./g' \
     | sed -e 's/\./(snapshot ID)/' \
           -e 's/\./(snapshot name)/' \
           -e 's/\./(VM state size value)/' \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index c0f8f0f8dfa..731e4b2b998 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -719,7 +719,7 @@ _img_info()
     regex_json_spec_start='^ *"format-specific": \{'
     regex_json_child_start='^ *"children": \['
     $QEMU_IMG info $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" 2>&1 | \
-        sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
+        gsed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
             -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
             -e "s#$SOCK_DIR/fuse-#TEST_DIR/#g" \
-- 
2.52.0


