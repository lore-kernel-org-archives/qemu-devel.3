Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B7C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 07:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqoNU-0006GT-3I; Sat, 08 Mar 2025 02:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqoNS-0006Fa-1m
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqoNQ-0002Kq-F3
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741418018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xacoSg9+cmZydMkbDxHCgdtHUhN+sY4grSF8iJQ4Ugk=;
 b=HpWiZX/Zr1jnLPcGcWqIrOU+Lii5x7iod1NXbqsVFLdLpjzV7FZ6bgaGtdJ4kYa8n6SxLJ
 ys2d8+c7hJzssA+KfZQkQWTP6VILdESsWtwbNhgoSupo2owMGyTL+B2gUxuY8btG8gERfN
 E2UGCL1oAMLs+ZWXRoSPTopjiYQKCwQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-BWG0AV7sMveY-qjRPg-7gw-1; Sat,
 08 Mar 2025 02:13:34 -0500
X-MC-Unique: BWG0AV7sMveY-qjRPg-7gw-1
X-Mimecast-MFC-AGG-ID: BWG0AV7sMveY-qjRPg-7gw_1741418013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8F99180035E; Sat,  8 Mar 2025 07:13:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.48])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A50618009AE; Sat,  8 Mar 2025 07:13:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] tests/functional: Require 'user' netdev for ppc64 e500 test
Date: Sat,  8 Mar 2025 08:13:28 +0100
Message-ID: <20250308071328.193694-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When commit 72cdd672e18c extended the ppc64 e500 test to add network
support, it forgot to require the 'user' netdev backend. Fix that.

Fixes: 72cdd672e18c ("tests/functional: Replace the ppc64 e500 advent calendar test")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_ppc64_e500.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
index 9ce7ae6c4798..f5fcad9f6b66 100755
--- a/tests/functional/test_ppc64_e500.py
+++ b/tests/functional/test_ppc64_e500.py
@@ -20,6 +20,7 @@ class E500Test(LinuxKernelTest):
 
     def test_ppc64_e500_buildroot(self):
         self.set_machine('ppce500')
+        self.require_netdev('user')
         self.cpu = 'e5500'
 
         uimage_path = self.ASSET_BR2_E5500_UIMAGE.fetch()
-- 
2.48.1


