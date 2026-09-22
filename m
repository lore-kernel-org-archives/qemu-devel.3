Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9DCC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971M-00059B-TK; Tue, 22 Sep 2026 16:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970z-0002xa-VH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970y-0000KV-Jv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ud4bWHBKs7U+iMRE57KMfTHPBw9J9aCTHLnWyZ1ljzQ=;
 b=WO5ySh0OawqFmk4JVandBPENq0q23tK9oFm68feQUFCQ53gYk/IYFEz8PpijtPz6w8Z+OD
 IBlxqd6lq0b+0mbqU0GxRYY8A3Ta0LQ0c1POCDAwkQEe8sF/72tM+5Bdjl/2AMlPwF+B+2
 JYtAG2HgVNBwFIIbAuhJhubQseL5i1c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-hBnLBHOfNNKeIG1egS-U8g-1; Tue,
 22 Sep 2026 16:22:52 -0400
X-MC-Unique: hBnLBHOfNNKeIG1egS-U8g-1
X-Mimecast-MFC-AGG-ID: hBnLBHOfNNKeIG1egS-U8g_1790108571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1AC519560AE; Tue, 22 Sep 2026 20:22:51 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E19471800446; Tue, 22 Sep 2026 20:22:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:09 +0400
Subject: [PATCH 62/88] qemu-iotests/120: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-62-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JnT2p54tqoC4BrydBFoE4z6q9Ie79AGI9/p9IyjCXec=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKymnwtMrKIS+troVRcR2rysVjhZ1YdGP6Vr
 c4ZmXxllKGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5QPdD/9P9zST5ab7OA3jDFo4oKp/WuDlpIc9C+faCz7KK+MlUkZm87D6lkjD5mjvQS4xYw3+o0h
 Vsa9c2DrlV4Msp4lqiyhCcSf71K8In3A/bXx2dcEJmOJDyURe8VklUlB6FaYWVXpaWSCbcLVF/+
 mmwK+asF11WGdPmyASx0QE1P4SQd5yX9cUYJYzeQYFe3FsOKGjDFjdQAmtnjShRJ3Zb3vaqXMSN
 GPYxwBIXUFPzvCA2DWN/TzQSSCYauIATN4bwqMWDnjfLvO93/wNNeg1+6l5TgTC4l57dK285iQm
 Fm4xwM3eNbAWiajj1W26r+0c37+BHkts/rOMevGmqbgga5+LUdOggKam3dFlv2C3cXLhTzpfqa7
 W8MEA/OD++shUJum2zdgGTaHzJLNHmSPdVSEQtH4nsTMH8ZTq8pC7gtqwcfRB6qYPWCb86ECIUS
 JtdaVzwwRFRKEAOzrt2Mthgq6B7dnoXUq4hvJZggfmYoruiIbUNKfuXVX8oYAjGVNQ7WN2CBvwN
 eLb8saRnPb1tpp5YUkS2XhIvo6LFKwnAFfS1t3yCrGLwXc8mHHFV7llmoFg60Wb+amIjUqA5RKx
 8yqH6WZqOf0kCDGLxUA0/gqp3uBfX7O4N7pCpfiweBPGedpL1V0VAxfbZUeLEgfz1jb4DF2+WQK
 cXLm5x6GkNQ1HMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/120     | 5 ++---
 tests/qemu-iotests/120.out | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index e4ed87e1a705..fb9ac5a165ef 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -42,13 +42,12 @@ _supported_fmt generic
 _supported_proto file fuse
 _unsupported_fmt luks
 _require_drivers raw
-_require_hmp
 
 _make_test_img 64M
 
 echo "{'execute': 'qmp_capabilities'}
-      {'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io drv \"write -P 42 0 64k\"'}}
+      {'execute': 'x-qemu-io',
+       'arguments': {'device': 'drv', 'command': 'write -P 42 0 64k'}}
       {'execute': 'quit'}" \
     | $QEMU -qmp stdio -nographic -nodefaults \
             -drive id=drv,if=none,file="$TEST_IMG",driver=raw,file.driver=$IMGFMT \
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index 35d84a5bc5a8..c32ae81feb05 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -2,9 +2,7 @@ QA output created by 120
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 QMP_VERSION
 {"return": {}}
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {"human-readable-text": "wrote 65536/65536 bytes at offset 0\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 read 65536/65536 bytes at offset 0

-- 
2.56.0.rc0.29.g47ce80527c56


