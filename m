Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5307AC3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpva-00023l-MT; Thu, 11 Jul 2024 05:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpvX-0001pP-4O
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpvU-00007s-Tw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720689440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PJc6MgJNsPdSArmTrtYCHD6iBNMpM2WHe521vKzfns=;
 b=PUh6ReJsPNvEG+wwRFyJZJygMc7UKak5r6zTw9DzmlMmKCc2upyDMCQz0Hwp1CKRxiX6GN
 GNHRxEXqIQhF/y5zoZbrQ6/WKtZEiL7Ilkwz5gWMMzgcfvEb/qhp3+5/leewSi9LzWO2xN
 mEwQ0dufdP8EytikIyN3+xKvxnfHtp8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-WWDkIBDiOveZ3M09IdRpTA-1; Thu,
 11 Jul 2024 05:17:15 -0400
X-MC-Unique: WWDkIBDiOveZ3M09IdRpTA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2828196E099; Thu, 11 Jul 2024 09:17:14 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBA561955F40; Thu, 11 Jul 2024 09:17:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Nir Soffer <nsoffer@redhat.com>
Subject: [PULL 1/2] qemu-iotest/245: Add missing discard=unmap
Date: Thu, 11 Jul 2024 11:17:08 +0200
Message-ID: <20240711091709.584450-2-stefanha@redhat.com>
In-Reply-To: <20240711091709.584450-1-stefanha@redhat.com>
References: <20240711091709.584450-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

From: Nir Soffer <nsoffer@redhat.com>

The test works since we punch holes by default even when opening the
image without discard=on or discard=unmap. Fix the test to enable
discard.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/245 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index a934c9d1e6..f96610f510 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -592,7 +592,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     @iotests.skip_if_unsupported(['compress'])
     def test_insert_compress_filter(self):
         # Add an image to the VM: hd (raw) -> hd0 (qcow2) -> hd0-file (file)
-        opts = {'driver': 'raw', 'node-name': 'hd', 'file': hd_opts(0)}
+        opts = {'driver': 'raw', 'node-name': 'hd', 'file': hd_opts(0), 'discard': 'unmap'}
         self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Add a 'compress' filter
-- 
2.45.2


