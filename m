Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD07C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 20:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNI61-0002Ta-Ei; Fri, 28 Jun 2024 16:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sNI60-0002Sw-7e
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 16:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sNI5w-0004Gg-RW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 16:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719606076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IuwFr81seUA4HCmSEHEEcL3uEHCXfggSjJwHqNFXCHM=;
 b=fqoWuVaMhl6qnmfCpLDC/wZuL6lE3ZIf8IhiWxLoLGZJA74B77bjacBf+LyIqINpFGEqEg
 tsZnjopijmjtAiMbAI0wWcAci5KFxUSyvK5fwh/WWpfrnzysUTcmeKZzGuE12kdDhDBWsd
 aDFbNyX2CGsyMIUPB3qYihnEWgpPOtA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-4i8nV4wdMiuKerUgaxTvVw-1; Fri,
 28 Jun 2024 16:21:14 -0400
X-MC-Unique: 4i8nV4wdMiuKerUgaxTvVw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF0A21944D17; Fri, 28 Jun 2024 20:21:12 +0000 (UTC)
Received: from sparse.com (unknown [10.47.238.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE025300021A; Fri, 28 Jun 2024 20:21:08 +0000 (UTC)
From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Nir Soffer <nsoffer@redhat.com>
Subject: [PATCH v3 1/2] qemu-iotest/245: Add missing discard=unmap
Date: Fri, 28 Jun 2024 23:20:57 +0300
Message-ID: <20240628202058.1964986-2-nsoffer@redhat.com>
In-Reply-To: <20240628202058.1964986-1-nsoffer@redhat.com>
References: <20240628202058.1964986-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The test works since we punch holes by default even when opening the
image without discard=on or discard=unmap. Fix the test to enable
discard.
---
 tests/qemu-iotests/245 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index a934c9d1e6..f96610f510 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -590,11 +590,11 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
     # Insert (and remove) a compress filter
     @iotests.skip_if_unsupported(['compress'])
     def test_insert_compress_filter(self):
         # Add an image to the VM: hd (raw) -> hd0 (qcow2) -> hd0-file (file)
-        opts = {'driver': 'raw', 'node-name': 'hd', 'file': hd_opts(0)}
+        opts = {'driver': 'raw', 'node-name': 'hd', 'file': hd_opts(0), 'discard': 'unmap'}
         self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Add a 'compress' filter
         filter_opts = {'driver': 'compress',
                        'node-name': 'compress0',
-- 
2.45.2


