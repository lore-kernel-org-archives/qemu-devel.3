Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C274C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjRr-0007Fg-D3; Tue, 30 Jul 2024 05:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sYjRk-0006pu-A1; Tue, 30 Jul 2024 05:47:13 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sYjRh-0001i3-PV; Tue, 30 Jul 2024 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=z/pSz8JWP1f258KcjOwczIObAKqmmWgwMknXpyWI3oM=; b=SZ831bQurWvc
 GruiMd/R02hnOCfakeuV3EI9kqPDcBSp41CgbnYc2Fmy9I5olOIkRIn3aA0g3eGYpltUKvZLV7TTh
 Xcf2yoVOHjE+EEhkNARSyYQj5fy/6f/PUHOgvilQPLCJPDebQt3C/QTjlo4rrTq67RW9gdmTJ8qaD
 0yAfmTFqRvsJgLZh/SoqtZDRJ44QYLQvJa3VMtuyQLEoA1qbt8afgS71bp6DwyP9OepvgVX0/21KR
 kUJ3kU7as2etnmmFWH8wXdQ1NWKFAVn0QJQZKnRZW+XQSw3ayuEYBRWXUY1LXQe0Cd1k6SBEcLxyi
 zX19t3Vs64MRvgEM7swNpA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sYjQN-00Eeh3-1L;
 Tue, 30 Jul 2024 11:46:51 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, thuth@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH] iotests/024: exclude 'backing file format' field from the
 output
Date: Tue, 30 Jul 2024 12:47:01 +0300
Message-Id: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Apparently 'qemu-img info' doesn't report the backing file format field
for qed (as it does for qcow2):

$ qemu-img create -f qed base.qed 1M && qemu-img create -f qed -b base.qed -F qed top.qed 1M
$ qemu-img create -f qcow2 base.qcow2 1M && qemu-img create -f qcow2 -b base.qcow2 -F qcow2 top.qcow2 1M
$ qemu-img info top.qed | grep 'backing file format'
$ qemu-img info top.qcow2 | grep 'backing file format'
backing file format: qcow2

This leads to the 024 test failure with -qed.  Let's just filter the
field out and exclude it from the output.

This is a fixup for the commit f93e65ee51 ("iotests/{024, 271}: add
testcases for qemu-img rebase").

Found-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/024     | 2 +-
 tests/qemu-iotests/024.out | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 285f17e79f..b29c76e161 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -283,7 +283,7 @@ TEST_IMG=$BASE_OLD _make_test_img -b "$BASE_NEW" -F $IMGFMT \
 CLUSTER_SIZE=$(( CLUSTER_SIZE * 2 )) TEST_IMG=$OVERLAY \
     _make_test_img -b "$BASE_OLD" -F $IMGFMT $(( CLUSTER_SIZE * 6 ))
 
-TEST_IMG=$OVERLAY _img_info
+TEST_IMG=$OVERLAY _img_info | grep -v '^backing file format:'
 
 echo
 echo "Fill backing files with data"
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index e1e8eea863..3d1e31927a 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -214,7 +214,6 @@ file format: IMGFMT
 virtual size: 384 KiB (393216 bytes)
 cluster_size: 131072
 backing file: TEST_DIR/subdir/t.IMGFMT.base_old
-backing file format: IMGFMT
 
 Fill backing files with data
 
-- 
2.39.3


