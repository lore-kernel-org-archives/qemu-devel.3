Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A53C31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgYE-0005nm-BF; Tue, 02 Jul 2024 12:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYA-0005nB-L2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgY6-0008PJ-0T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719938408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxGSJWJdT1tuYYeevSiIyl83n8PhmxBCYbBIreUSDxg=;
 b=eclsm5JJJVSRWTJQTLWdFhWDPRgffhRyn4Bwd1myifTcP0p7sbeasspRJoEls2QBhydlDK
 gpGFEjQqYzOXmaHKrQLYYtLNjQIdoy1fsf1JcRr96palWJ/bdIiHdKH/5kJINoZ0sKmbnK
 NQ52AcT0rrTZvkIfJkISiLAjh8jz7E8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-R-mH694RNCukfjG7t9lWOA-1; Tue,
 02 Jul 2024 12:40:07 -0400
X-MC-Unique: R-mH694RNCukfjG7t9lWOA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01D501955E7D; Tue,  2 Jul 2024 16:40:05 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.206])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C6EA19560AD; Tue,  2 Jul 2024 16:40:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, richard.henderson@linaro.org, hreitz@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PULL 2/4] iotests/244: Don't store data-file with protocol in image
Date: Tue,  2 Jul 2024 18:39:41 +0200
Message-ID: <20240702163943.276618-3-kwolf@redhat.com>
In-Reply-To: <20240702163943.276618-1-kwolf@redhat.com>
References: <20240702163943.276618-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We want to disable filename parsing for data files because it's too easy
to abuse in malicious image files. Make the test ready for the change by
passing the data file explicitly in command line options.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/244 | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 3e61fa25bb..bb9cc6512f 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -215,9 +215,22 @@ $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
 $QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
 
 # blkdebug doesn't support copy offloading, so this tests the error path
-$QEMU_IMG amend -f $IMGFMT -o "data_file=blkdebug::$TEST_IMG.data" "$TEST_IMG"
-$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
-$QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
+test_img_with_blkdebug="json:{
+    'driver': 'qcow2',
+    'file': {
+        'driver': 'file',
+        'filename': '$TEST_IMG'
+    },
+    'data-file': {
+        'driver': 'blkdebug',
+        'image': {
+            'driver': 'file',
+            'filename': '$TEST_IMG.data'
+        }
+    }
+}"
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$test_img_with_blkdebug"
+$QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$test_img_with_blkdebug"
 
 echo
 echo "=== Flushing should flush the data file ==="
-- 
2.45.2


