Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85185C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971Z-0006RL-1O; Tue, 22 Sep 2026 16:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970d-0002hu-Pw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970c-0000IC-DM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4LM5aeuXcVbmLarJCZBwKIzCX8/oTrwbPV9HPdl34I=;
 b=UNaBj1aZhtaCEhL6gQMdXDq+miDYHZF7Q6whMnKfezylsdx58fXePjD0c61wF+uum4xXkR
 LwM5d25gOf3wbMIJmgZPo2Se3V8f6chthDhQaiTb7/ynN8k6Bnadxpc6xMjV1Dn9xRTkhY
 QpzcBRQS03cgG4Nx0h5Ne4UrtuVy3YI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-8dLI9xbVNfuSmBo1dYHF1Q-1; Tue,
 22 Sep 2026 16:22:30 -0400
X-MC-Unique: 8dLI9xbVNfuSmBo1dYHF1Q-1
X-Mimecast-MFC-AGG-ID: 8dLI9xbVNfuSmBo1dYHF1Q_1790108549
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7244D180059C; Tue, 22 Sep 2026 20:22:29 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 809A11956095; Tue, 22 Sep 2026 20:22:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:03 +0400
Subject: [PATCH 56/88] qemu-iotests/119: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-56-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GJxSfMxlvHeuJv+jKQIiEGaB13SWll4bTJtGajT1MwQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyfNiMp2VfkPiZGlcumTQa4UxmcpeLxSQBy
 eKtp2HbMNqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5SBmEACqTMBnWgY6RhHLaM8YXHE/n7NsSQl/LoY/6HYfS2Q68JyR5/f/meY+YxiqXQuUSIgl/he
 7gbCDU2nNExBxhUrhhv/xP4qdyTfSFnEmu99q06aMlrLGAbYtXWfPd7Hx184cq0TlX12pqzUxEA
 bkc42GnAFz728DHzWH1EkMZ7EAadpp4SgqMQe3DXhpf4LmDi30wwO1rYAc+pFGcGGTujlBWgcyq
 2NUvtPc7iNTaaqCH3O+MhJ3rQLCcszbRUX+1XIjn6zdd4iRU+sZInqs6O/WtElGgH61waJlCguX
 LK0cQ70JOOvIaw/OVd+SGvLW5ZK4ZS35xKreZGlUqtiEupkI+IJe7obRNJU+Jb/VBRTg6l8jcuk
 7MOUA/qeQAbYak7Ckeopz7/fatJtIpCzy+cgZ/0cTIldFbiWqwNa/mHvCcnX4euO1bTqRkCZyeV
 5skl/8v5YLhxG51nPSOXwNGJa758Vh5MT6PswtpNtmxOQ4zIqJos1OCBhnkWu91GGI1tL/1VIsF
 UBXCuGPCVvDocMwV1qdTuNMiab1cii3INA4IFrUY8LlgAVjws67U6zpTT4SxDljgdSWBg5GonV0
 lck3R/F7QvZ12XmX27/bja29Ydup0d+FGeiVzTl+0s8qQUZHKOuizOc9ycL0/mXCtiN0XjUP8M2
 z/bTgHZ5jiPZpLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
 tests/qemu-iotests/119     | 5 ++---
 tests/qemu-iotests/119.out | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index ce1b62521f59..6b95f9224b3e 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -41,13 +41,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto nbd
 _supported_os Linux
-_require_hmp
 
 _make_test_img 64M
 # This should not crash
 echo "{'execute': 'qmp_capabilities'}
-      {'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io drv \"read -P 0 0 64k\"'}}
+      {'execute': 'x-qemu-io',
+       'arguments': {'device': 'drv', 'command': 'read -P 0 0 64k'}}
       {'execute': 'quit'}" \
     | $QEMU -nographic -drive id=drv,if=none,file="$TEST_IMG",driver=nbd \
             -qmp stdio -nodefaults \
diff --git a/tests/qemu-iotests/119.out b/tests/qemu-iotests/119.out
index 45f82a4faa93..edd555fdd2d7 100644
--- a/tests/qemu-iotests/119.out
+++ b/tests/qemu-iotests/119.out
@@ -2,9 +2,7 @@ QA output created by 119
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 QMP_VERSION
 {"return": {}}
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {"human-readable-text": "read 65536/65536 bytes at offset 0\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 

-- 
2.56.0.rc0.29.g47ce80527c56


