Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD7FCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux8Pf-0004XO-Mg; Fri, 12 Sep 2025 14:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8Pc-0004WS-B0
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8Pa-0005HW-Hm
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757701337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+W630tOCA0+rx9/rJ5njZf90sXPW8yYXnWYXhKmUo4=;
 b=WWGhKXv7aOcGUGHqlRxD6n7TSsmTBhyxgFp0DpZw0RlLg2ciSwdkA9yg7L2C3xoKNcIXXW
 /lByYyL3R5fSPbEPQkXzk0BGgQcKliZyYyBmwUInMuTHCABzBulXDWssk1c5OZrPlEE4ra
 Nl1z0W0eg/iqpT2O91Gwwu2JFMtG9Qo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-ZpfGRvMmNYSkz9kFap6OoQ-1; Fri,
 12 Sep 2025 14:22:15 -0400
X-MC-Unique: ZpfGRvMmNYSkz9kFap6OoQ-1
X-Mimecast-MFC-AGG-ID: ZpfGRvMmNYSkz9kFap6OoQ_1757701334
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98A151800451
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 18:22:14 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41D3018003FC; Fri, 12 Sep 2025 18:22:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/6] tests/functional: close GDB socket in reverse debugging
 test
Date: Fri, 12 Sep 2025 19:21:59 +0100
Message-ID: <20250912182200.643909-6-berrange@redhat.com>
In-Reply-To: <20250912182200.643909-1-berrange@redhat.com>
References: <20250912182200.643909-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The GDB socket FD is leaked currently resulting in a warning from
python about the unclosed resource.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/gdb.py     | 4 ++++
 tests/functional/reverse_debugging.py | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_test/gdb.py
index 913e3b65ab..1b463e8a82 100644
--- a/tests/functional/qemu_test/gdb.py
+++ b/tests/functional/qemu_test/gdb.py
@@ -231,3 +231,7 @@ def connect(self):
 
         if self._extended_mode:
             self.set_extended_mode()
+
+    def close(self):
+        self._socket.close()
+        self._socket = None
diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 9c89f5c897..fbb5adbcce 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -186,5 +186,7 @@ def reverse_debugging(self, shift=7, args=None):
         self.check_pc(g, steps[-1])
         logger.info('successfully reached %x' % steps[-1])
 
+        g.close()
+
         logger.info('exiting gdb and qemu')
         vm.shutdown()
-- 
2.50.1


