Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA0C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsN9-00033n-6A; Wed, 04 Jun 2025 13:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsML-0002S4-9S
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsMJ-0000at-Ny
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o61jD5a5IrYorC0wTg9QfLo6B72B4bfNqjyS26JA7ns=;
 b=T6Odq8+WExlvgtnQt4RBhs+LNYq3kBurud1jo5X5Xpm5kJllX7v3p/YLEqeYKOyr5TCumB
 HELzTyYbJAsAopj9bWyzoLtuGJT04pJcrCWAH2CmNBfY99s0wAIVfC3gW+Hhfm/ZMPAsrD
 FmFnmtNbZQJXjAptGuDCaApEEF3z+WM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-yaxqlYXhMvuQhHUhNSEWFw-1; Wed,
 04 Jun 2025 13:57:01 -0400
X-MC-Unique: yaxqlYXhMvuQhHUhNSEWFw-1
X-Mimecast-MFC-AGG-ID: yaxqlYXhMvuQhHUhNSEWFw_1749059821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00E119560BB; Wed,  4 Jun 2025 17:57:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C2E318003FD; Wed,  4 Jun 2025 17:56:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 23/24] iotests: fix 240
Date: Wed,  4 Jun 2025 19:56:12 +0200
Message-ID: <20250604175613.344113-24-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
removed the limitation that virtio-scsi devices must successfully set
the AioContext on their BlockBackends. This was made possible thanks to
the QEMU multi-queue block layer.

This change broke qemu-iotests 240, which checks that adding a
virtio-scsi device with a drive that is already in another AioContext
will fail.

Update the test to take the relaxed behavior into account. I considered
removing this test case entirely, but the code coverage still seems
valuable.

Fixes: 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250529203147.180338-1-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/240     | 2 --
 tests/qemu-iotests/240.out | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 9b281e1dc0..f8af9ff648 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -81,8 +81,6 @@ class TestCase(iotests.QMPTestCase):
 
         self.vm.qmp_log('device_del', id='scsi-hd0')
         self.vm.event_wait('DEVICE_DELETED')
-        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
-
         self.vm.qmp_log('device_del', id='scsi-hd1')
         self.vm.event_wait('DEVICE_DELETED')
         self.vm.qmp_log('blockdev-del', node_name='hd0')
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index 89ed25e506..10dcc42e06 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -46,10 +46,8 @@
 {"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
 {"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
-{"error": {"class": "GenericError", "desc": "Cannot change iothread of active block backend"}}
-{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
 {"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
 {"return": {}}
-- 
2.49.0


