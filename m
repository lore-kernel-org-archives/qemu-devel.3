Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4972C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgYH-0005qE-D6; Tue, 02 Jul 2024 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYC-0005nZ-Or
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYA-0008Qi-Ca
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719938413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IuvqgqvZpc9QZjDHiqWBEWq/Br6y0CM8OiQCxZHzy68=;
 b=CsMgHMtiz+xaqRwYcgx+KZM1xfKo/oi4dC1YGQy4iLOzEbBqsiBi1qCiJFcpQspjgI+PP6
 jiiMXAvfHUVszsm9XA8YuJxtx5hU2Uxf7I3GXycyMyONMOpG61vT1isCNJaIv3Uujzboun
 BNfbvJQGDKOOSDahVHHiTWFKs6AZIKY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-RGPdsKUIOgy3jPbrAjKKBw-1; Tue,
 02 Jul 2024 12:40:09 -0400
X-MC-Unique: RGPdsKUIOgy3jPbrAjKKBw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC3021944D3D; Tue,  2 Jul 2024 16:40:07 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.206])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 225D71955E95; Tue,  2 Jul 2024 16:40:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, richard.henderson@linaro.org, hreitz@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PULL 3/4] iotests/270: Don't store data-file with json: prefix in
 image
Date: Tue,  2 Jul 2024 18:39:42 +0200
Message-ID: <20240702163943.276618-4-kwolf@redhat.com>
In-Reply-To: <20240702163943.276618-1-kwolf@redhat.com>
References: <20240702163943.276618-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
 tests/qemu-iotests/270 | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/270 b/tests/qemu-iotests/270
index 74352342db..c37b674aa2 100755
--- a/tests/qemu-iotests/270
+++ b/tests/qemu-iotests/270
@@ -60,8 +60,16 @@ _make_test_img -o cluster_size=2M,data_file="$TEST_IMG.orig" \
 # "write" 2G of data without using any space.
 # (qemu-img create does not like it, though, because null-co does not
 # support image creation.)
-$QEMU_IMG amend -o data_file="json:{'driver':'null-co',,'size':'4294967296'}" \
-    "$TEST_IMG"
+test_img_with_null_data="json:{
+    'driver': '$IMGFMT',
+    'file': {
+        'filename': '$TEST_IMG'
+    },
+    'data-file': {
+        'driver': 'null-co',
+        'size':'4294967296'
+    }
+}"
 
 # This gives us a range of:
 #   2^31 - 512 + 768 - 1 = 2^31 + 255 > 2^31
@@ -74,7 +82,7 @@ $QEMU_IMG amend -o data_file="json:{'driver':'null-co',,'size':'4294967296'}" \
 # on L2 boundaries, we need large L2 tables; hence the cluster size of
 # 2 MB.  (Anything from 256 kB should work, though, because then one L2
 # table covers 8 GB.)
-$QEMU_IO -c "write 768 $((2 ** 31 - 512))" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write 768 $((2 ** 31 - 512))" "$test_img_with_null_data" | _filter_qemu_io
 
 _check_test_img
 
-- 
2.45.2


