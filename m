Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33492C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971Y-0006Oh-PF; Tue, 22 Sep 2026 16:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9715-0003CM-I9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9713-0000L6-PY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdxscaKfy4+hi+OgbSe7s21g3XydX6kOH6WFjN0huhA=;
 b=OkGsQiNX1CxPFcQAIXKBloI6oAKjlX5G6n5oS8zEqGBJHTevUOOqu2fbMOjyY7O+PX8gPT
 lCUfhaK3BqUNxp9XgY6C5hgd5g3DYNd5pAAij2mbrpfskPbti9gH5uAkQH649vzUlrckma
 0VCIgyn+4JK046DcKU4UKjl8KqUzGNo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-e5T04Tl9MJeG4pSZJtbxtw-1; Tue,
 22 Sep 2026 16:22:59 -0400
X-MC-Unique: e5T04Tl9MJeG4pSZJtbxtw-1
X-Mimecast-MFC-AGG-ID: e5T04Tl9MJeG4pSZJtbxtw_1790108578
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B72A1955D76; Tue, 22 Sep 2026 20:22:58 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC79041D; Tue, 22 Sep 2026 20:22:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:11 +0400
Subject: [PATCH 64/88] qemu-iotests/249: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-64-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3849;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VLRlMvZ61jdJQkdiAmEeYyQuL77+W9Xqq2buftMSbXE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyv+sAhanKEe01XJ28sZU6gi/xRgJGAvy3g
 G6L7CtzCXqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5UynEACnbJr4qic6wuKWEH6jt3a9N/Bcliug5FFjRzLdSAUmCqtM8E6XmiHnGljWEEwDRPTtgk9
 K6CdY2LeFu9FikbBLz4htPfYQbv0m5268QSDKPllz/gH/TTR+Q5JwVADjJagGJoazISNdcoFuRR
 +6LP6lXEmowThZUzV4bJTMm20xG/sv0Pk/sk8PM2cpTbtv3vxw5f9zn0NjmMg+Wg5ImAnjHLb3i
 U8rntBX+B6kiBHQhpoIH70A9Abz6WvBR1TnRtt0eo1lvxsY5op0Q8631D2WVqjjp4EINjTmp6Rb
 u6vtSll9RY00ZqOxFqQt2NqNutsg6InK035reAwmicPnD7KzsVKgI7WVBU2vsHL7aDDJ3VJfXMI
 SXZKn/T5JwL77Pw6D7ELog5fmHURFSvuHcRMBj1ay6x7TvSVGSSVXFCLvgqW5q8422qSarbDzZd
 75WcXRQyWGXcoB3LWZSi8KLK1vAJx4HLL8KW2NbxEmceoAW67fcM8AwW9usvu36u5XE2VD/nWUV
 U20q2tDGWyEqNuQGvPYxWpKBQPEAzD8f7hZgaWmNYWzIG9w4LQshdTZLsEsYwfdbmnLeDlr6k5G
 z8o6gPeQlWeMahBOcjCnukLJcKIxtCFfLPcqXfof3gD5G2d9snyfNX2+ip1xzHdbrGEYDPh6Dlb
 Zr2f5onUHjmcIvg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/249     | 19 +++++++++----------
 tests/qemu-iotests/249.out | 18 +++++++++---------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 1254bf942913..fb3a4c480a78 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -45,7 +45,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file fuse
 _supported_os Linux
-_require_hmp
 
 IMG_SIZE=1M
 
@@ -68,9 +67,9 @@ echo
 echo '=== Send a write command to a drive opened in read-only mode (1)'
 echo
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
-    'return'
+    "{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
+    'error'
 
 echo
 echo '=== Run block-commit on base using an invalid filter node name'
@@ -85,9 +84,9 @@ echo
 echo '=== Send a write command to a drive opened in read-only mode (2)'
 echo
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
-    'return'
+    "{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
+    'error'
 
 echo
 echo '=== Run block-commit on base using the default filter node name'
@@ -105,9 +104,9 @@ echo
 echo '=== Send a write command to a drive opened in read-only mode (3)'
 echo
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
-    'return'
+    "{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
+    'error'
 
 _cleanup_qemu
 
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index 3d37709a9ef8..79f69cd26513 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -7,9 +7,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 === Send a write command to a drive opened in read-only mode (1)
 
-{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Error: Block node is read-onlyrn"}
+{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}
+{"error": {"class": "GenericError", "desc": "Block node is read-only"}}
 
 === Run block-commit on base using an invalid filter node name
 
@@ -22,9 +22,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 === Send a write command to a drive opened in read-only mode (2)
 
-{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Error: Block node is read-onlyrn"}
+{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}
+{"error": {"class": "GenericError", "desc": "Block node is read-only"}}
 
 === Run block-commit on base using the default filter node name
 
@@ -41,7 +41,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 === Send a write command to a drive opened in read-only mode (3)
 
-{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Error: Block node is read-onlyrn"}
+{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}
+{"error": {"class": "GenericError", "desc": "Block node is read-only"}}
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


