Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A7E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNttd-0002H6-1e; Wed, 18 Dec 2024 08:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNttQ-0002Eh-Nz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNttJ-0005Gz-0b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734527698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLxBCKjMzrxnWG0lb9dtJu6GgW4J2VLx4EjRb0x+M+Y=;
 b=gEwVkaswIG9bgua2dyfruq6xLQl9x4GLjMGLQNbuev9O4rZ7ULWZHqX0Q73j/ATuio397M
 91y0eNYBiMrylRcYpWkDZVp3f0HWGzXuqAeKrn6sGLBfogjq/4AZNun6Ot7ebBNb2VD87t
 xutKDcjdXms/A9ZVQ+hwvIahgmmBkfY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-F2dgJdDYPn-gIOKyeNfbkg-1; Wed,
 18 Dec 2024 08:14:55 -0500
X-MC-Unique: F2dgJdDYPn-gIOKyeNfbkg-1
X-Mimecast-MFC-AGG-ID: F2dgJdDYPn-gIOKyeNfbkg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 860C51955E9A; Wed, 18 Dec 2024 13:14:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B4BF30044C1; Wed, 18 Dec 2024 13:14:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 2/5] tests/functional/test_vnc: Remove the test_no_vnc test
Date: Wed, 18 Dec 2024 14:14:36 +0100
Message-ID: <20241218131439.255841-3-thuth@redhat.com>
In-Reply-To: <20241218131439.255841-1-thuth@redhat.com>
References: <20241218131439.255841-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

This test matches exactly the first three lines of the following
test_no_vnc_change_password test, so there is exactly zero additional
test coverage in here.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_vnc.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index b769d3b268..42ffcec217 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -54,11 +54,6 @@ def find_free_ports(count: int) -> List[int]:
 
 class Vnc(QemuSystemTest):
 
-    def test_no_vnc(self):
-        self.vm.add_args('-nodefaults', '-S')
-        self.vm.launch()
-        self.assertFalse(self.vm.qmp('query-vnc')['return']['enabled'])
-
     def test_no_vnc_change_password(self):
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
-- 
2.47.1


