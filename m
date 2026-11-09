Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C4606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kp5nvmKO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSVw-0002PB-50; Mon, 09 Nov 2026 11:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVb-0002Dq-OA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVN-00010Q-Ou
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqLmiGSiWYD+7uxKzTGCa/OMsyBLp4FvJsubmAVJPQY=;
 b=Kp5nvmKONYj3XxYTDkwmo4ZQvezd/xkxXt8JH7n6DFSlknvtjk6GbJZ6jxgwPljoeMuDpF
 qGZEPcw9D2oMz9r65Q/KQCz/uuyv64IuEiPFVROxEjIe+lREw7POSXnkfsQwaYngBcXa6b
 ika1HbBoeQMzOa7iCt4/wGwEXhlMeis=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-8hOl03bYNbKp9Bu17HBKAQ-1; Mon,
 09 Nov 2026 11:45:57 -0500
X-MC-Unique: 8hOl03bYNbKp9Bu17HBKAQ-1
X-Mimecast-MFC-AGG-ID: 8hOl03bYNbKp9Bu17HBKAQ_1794242756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 167781801218; Mon,  9 Nov 2026 16:45:56 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9E0830000E5; Mon,  9 Nov 2026 16:45:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/11] iotests/290: add 'discard' and 'write -z -u' case with a
 snapshot
Date: Mon,  9 Nov 2026 17:45:32 +0100
Message-ID: <20261109164533.293487-11-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Before the previous commit, issuing 'discard' and 'write -z -u'
operations with discard-no-unref=on option enabled led to data
corruption.  Add a test to cover this case.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20261105161515.794213-4-andrey.drobyshev@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/290     | 16 ++++++++++++++++
 tests/qemu-iotests/290.out |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index cf4ff6c2bac..b9a71b0cee4 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -128,6 +128,22 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 echo "# Output of qemu-img map for the image with kept reference"
 $QEMU_IMG map --output=json "$NOUNREF_IMG" | _filter_qemu_img_map
 
+echo
+echo "### Discard with 'discard-no-unref' on a cluster shared with a snapshot"
+echo
+
+_make_test_img 128k
+$QEMU_IO -c 'write -q -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -c snap "$TEST_IMG"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c 'discard -q 0 64k' -c 'write -q -z -u 64k 64k' --image-opts \
+         "driver=$IMGFMT,file.filename=$TEST_IMG,discard-no-unref=on" \
+         | _filter_qemu_io
+$QEMU_IO -c 'read -q -P 0 0 128k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -a snap "$TEST_IMG"
+$QEMU_IO -c 'read -q -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index d8f8d5ff493..264fbcb28ca 100644
--- a/tests/qemu-iotests/290.out
+++ b/tests/qemu-iotests/290.out
@@ -86,4 +86,9 @@ Images are identical.
 # Output of qemu-img map for the image with kept reference
 [{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
 { "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
+
+### Discard with 'discard-no-unref' on a cluster shared with a snapshot
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+No errors were found on the image.
 *** done
-- 
2.56.0


