Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3D7E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIUg-0003rQ-AZ; Thu, 02 Jan 2025 05:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUf-0003r9-EJ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUd-0005qF-VB
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735813915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gP3n+xmGEu7VSzd7bF6ZEXq02fd+LK2FuyJYFdeOJd0=;
 b=cg9KcpjNzMgtI9flqxU1L2HGUWHbhl88cDzUFmMwu1Hx1BbnMZ4S9EELzLvUld0sJH47hp
 0aToYvnrxQYYrC6yhPdIzFlt680ex4D5h+jX86lmzvCSl9YorTBjbdjFYvsVNr05fkxuX6
 CsGVN4QW4QljwlMKzNUQHDiJxLEtlKw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-CgwbuEo3PUuwnOgGEWkJcw-1; Thu,
 02 Jan 2025 05:31:52 -0500
X-MC-Unique: CgwbuEo3PUuwnOgGEWkJcw-1
X-Mimecast-MFC-AGG-ID: CgwbuEo3PUuwnOgGEWkJcw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B32E19560BA
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2025 10:31:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1DD81956052; Thu,  2 Jan 2025 10:31:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 03/10] tests/functional/test_vnc: Do not use a hard-coded VNC
 port
Date: Thu,  2 Jan 2025 11:31:31 +0100
Message-ID: <20250102103138.354618-4-thuth@redhat.com>
In-Reply-To: <20250102103138.354618-1-thuth@redhat.com>
References: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Two tests here are using the hard-coded VNC port :0 ... if there
is already a QEMU or other program running that is using this
port, the tests will be failing. Fortunately, QEMU can also
auto-detect a free port with the "to=..." parameter, so let's
use that for the tests to avoid the problem.

Message-ID: <20241218131439.255841-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_vnc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index b769d3b268..e6328567c7 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -72,7 +72,7 @@ def test_no_vnc_change_password(self):
                          'Could not set password')
 
     def test_change_password_requires_a_password(self):
-        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0')
+        self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999')
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         set_password_response = self.vm.qmp('change-vnc-password',
@@ -84,7 +84,7 @@ def test_change_password_requires_a_password(self):
                          'Could not set password')
 
     def test_change_password(self):
-        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password=on')
+        self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999,password=on')
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         self.vm.cmd('change-vnc-password',
-- 
2.47.1


