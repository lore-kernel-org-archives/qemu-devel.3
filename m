Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9865BC98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971N-0005Bd-H2; Tue, 22 Sep 2026 16:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970h-0002rp-MT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970g-0000Ib-4f
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJDmsFu8kUStZLf37ukvoULZtZY1UoVdrTEAldri5oE=;
 b=TWzrOgKOZMilqUAi92iUFrcMQ9FfvjtRV+vHUGczcH5BDmpfllQ+863/Sso8XuqkzpoOBf
 nSJMSVp5Uwyltxh4VQeirlLFyn1za6n/zN0QORF18uLhDFRo0FVLws2qUT52joZO9Zvrst
 7+Z28VsmoizaoSjEdKGCkGMVjtNgd/k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-meR3CylKNGefHC9zkzFsZw-1; Tue,
 22 Sep 2026 16:22:33 -0400
X-MC-Unique: meR3CylKNGefHC9zkzFsZw-1
X-Mimecast-MFC-AGG-ID: meR3CylKNGefHC9zkzFsZw_1790108553
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CA3618005A2; Tue, 22 Sep 2026 20:22:33 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D34F418; Tue, 22 Sep 2026 20:22:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:04 +0400
Subject: [PATCH 57/88] qemu-iotests/060: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-57-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tGyM0cVGMQ+xwJ+2qai4Ws7GSoRgwxRYOOvuYnCNttk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKywp7CjizqGgxtYwzJsu4rUZUR+yaoG2Giu
 0B3eELfKVaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5Va4D/0SSqTghf2V/zhQh8mvAlA9/KNYkaM4GoswU0y2BUjb/UAfti+I0a++IDIkbuVBR+H0+ot
 ljhx7j5fJUbeykqlvmCttfUq1aU8Fnr+XAzeOLJNvyk/goBY76xbcP1T+QZtjwICWcz5jL34oci
 qaoPD9Edw7AObBDfp/or644d6FZEqkqBpl9zDgH6p/xhDpNuodwvyBElGaU8Tf8PZf16L2Ss6kU
 bCBkVUHwn5TEGIYvJP080SDDxR3qf5IQOvF4o3VJ6vj0713aAAwRBR+1MPxk1W8igdFlnFbQJwO
 KWEsXyc2wRjzU2LWTXNhzWAB4Qxa7ytZE2xsXYSzXE98aNLE/c1bbhdb6M+HrJjfZXTf0IJvcDN
 mJqkw8oVi2FdicHxad723DYULdTVcgSi3VzqpEqP/dvr040azTqdR1OeeePx6YyhxYgYJ0UJTzS
 hWJ4P1fkz/Dgs8LSvgFBwPre55Wz5paUZLvQzNHGPWmoKjKRRVxFFm4Nxgx+1+9Z5Ar3mKdtGwM
 m7ujMRJmRtX2/FcTifIEkpJSS/pO/Ug8PKQr4m3LOEMv6jgLtxi/V58IRCwxfh0FChUsI7XNjoN
 trLQeuUY5nP5kmCPHWQ7/c5yKFdbeUCfZXVuKJdjXDZqAZr4H+YT6esg8LKYVduRwP/jA3i9w+t
 +MNckLTrxV7by2g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/qemu-iotests/060     | 9 ++++-----
 tests/qemu-iotests/060.out | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 8d06f84df16b..c2c1cd815f0f 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -56,7 +56,6 @@ _unsupported_imgopts 'compat=0.10' data_file \
 
 # The repair process will create a large file - so check for availability first
 _require_large_file 64G
-_require_hmp
 
 rt_offset=65536  # 0x10000 (XXX: just an assumption)
 rb_offset=131072 # 0x20000 (XXX: just an assumption)
@@ -450,8 +449,8 @@ echo
 _make_test_img 64M
 poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 echo "{'execute': 'qmp_capabilities'}
-      {'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io drive \"write 0 512\"'}}
+      {'execute': 'x-qemu-io',
+       'arguments': {'device': 'drive', 'command': 'write 0 512'}}
       {'execute': 'quit'}" \
     | $QEMU -qmp stdio -nographic -nodefaults \
             -drive if=none,node-name=drive,file="$TEST_IMG",driver=qcow2 \
@@ -469,8 +468,8 @@ poke_file "$TEST_IMG" "$l1_offset" "\x00\x00\x00\x00\x2a\x2a\x2a\x2a"
 # Inactive images are effectively read-only images, so this should be a
 # non-fatal corruption (which does not modify the image)
 echo "{'execute': 'qmp_capabilities'}
-      {'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io drive \"read 0 512\"'}}
+      {'execute': 'x-qemu-io',
+       'arguments': {'device': 'drive', 'command': 'read 0 512'}}
       {'execute': 'quit'}" \
     | $QEMU -qmp stdio -nographic -nodefaults \
             -blockdev "{'node-name': 'drive',
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 8870a478231c..833f29c9b031 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -419,7 +419,7 @@ qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps
 QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "none0", "msg": "Preventing invalid write on metadata (overlaps with refcount table)", "offset": 65536, "node-name": "drive", "fatal": true, "size": 65536}}
-{"return": "Error: write failed: Input/output error\r\n"}
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 

-- 
2.56.0.rc0.29.g47ce80527c56


