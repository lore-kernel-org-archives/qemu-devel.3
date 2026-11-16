Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26989606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=qiuB4SKO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Fr-0008P7-2e; Mon, 16 Nov 2026 15:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3FZ-00082O-FY; Mon, 16 Nov 2026 15:24:28 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3FS-0004KI-Ko; Mon, 16 Nov 2026 15:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860377; bh=re2/BbEcvJIcZdp0j5Ix2HFLmsPC4ndGgCsC4W6V7dc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qiuB4SKOFar6ClHQT+nsdV2Dr5VNiYaW6WtHket/vQ1BnBooEIQzuLVifcF9LHIr+
 qRULkelmPkU+ebiT7sVQPbDDcJmdXVT0VVJtcSXtHEy4+CMZp+NsF2ES8mabb7925q
 O5jrQhCzgohPA4VuCw/GRheYvrCJUYF6YJfpfCvcAcx016xLY3m3VjKez4I2n8nkJT
 fcVesfoV3ZwQd5C6sNCcqRb225H1W5rSXviQrZ41yOScsy3pY92Ti6uvK1Xv2vl6GK
 4R6jwnDpmQHqm9hXh/Ltnc5I38+PuDLPrpoguc/PPDcyPOARwIjFTjPNXoZpSAfNzO
 eve2I1W2A573Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC3D01E716D;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A9CF245FBA2;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 91183B8E34; Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 51/59] iotests/290: add 'discard' and 'write -z -u'
 case with a snapshot
Date: Mon, 16 Nov 2026 23:18:55 +0300
Message-ID: <20261116201922.534306-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Before the previous commit, issuing 'discard' and 'write -z -u'
operations with discard-no-unref=on option enabled led to data
corruption.  Add a test to cover this case.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20261105161515.794213-4-andrey.drobyshev@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 8f23f50082b2b8e283a7e76ee1fb5dbde880991c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 6689b903dc7..7e5316fe031 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -130,6 +130,22 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
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
2.47.3


