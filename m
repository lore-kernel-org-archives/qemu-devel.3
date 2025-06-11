Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4E5C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL2y-0003LW-Dr; Wed, 11 Jun 2025 08:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2n-0003Jl-Rc
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2j-0004N8-AO
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaH+00akuMW4jm+alwsE/0L8k4sxMJoXLIiJTZJo3hg=;
 b=EE9ysvVB7jo0bW/H/gDp/XZIs7e21Y5R3/V/8bQElr20pAxpqr6j2nW4LLpdza/tYxmGNy
 PzsGHrurwd32sGIY/OeXvzdCQkDIGBkFyYasrsBwB/nZLmwjwou1yulYUa+tKDOYItwIH6
 NkY/6binZYui4FuoVUFlrE7t+aMd3Nw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-zIVgyooFPSKHhaVHKpttWg-1; Wed,
 11 Jun 2025 08:58:57 -0400
X-MC-Unique: zIVgyooFPSKHhaVHKpttWg-1
X-Mimecast-MFC-AGG-ID: zIVgyooFPSKHhaVHKpttWg_1749646736
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C7A019560A1; Wed, 11 Jun 2025 12:58:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 609DA19560AD; Wed, 11 Jun 2025 12:58:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/10] tests/functional: Use the 'none' machine for the VNC test
Date: Wed, 11 Jun 2025 14:58:39 +0200
Message-ID: <20250611125846.125918-4-thuth@redhat.com>
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

The VNC test currently fails if the default machine ("pc" for x86)
has not been compiled into the binary. Since we also can test VNC
when QEMU just shows the default monitor, let's avoid this problem
by simply using the "none" machine (which is always available)
here instead.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250603103449.32499-1-thuth@redhat.com>
---
 tests/functional/test_vnc.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index 5c0ee5f9272..f1dd1597cf1 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -31,6 +31,7 @@ def check_connect(port: int) -> bool:
 class Vnc(QemuSystemTest):
 
     def test_no_vnc_change_password(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
 
@@ -62,6 +63,7 @@ def launch_guarded(self):
                 raise excp
 
     def test_change_password_requires_a_password(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999')
         self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
@@ -74,6 +76,7 @@ def test_change_password_requires_a_password(self):
                          'Could not set password')
 
     def test_change_password(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999,password=on')
         self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
@@ -103,6 +106,7 @@ def do_test_change_listen(self, a, b, c):
         self.assertTrue(check_connect(c))
 
     def test_change_listen(self):
+        self.set_machine('none')
         with Ports() as ports:
             a, b, c = ports.find_free_ports(3)
             self.do_test_change_listen(a, b, c)
-- 
2.49.0


