Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A34D7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9Ls-0002A5-Op; Thu, 21 Nov 2024 10:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Lq-0001z2-4T
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Lo-00014p-7d
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyFkxmEDProtwTBUvdEdXCOHx7kjYPBJU+JzezPkC9M=;
 b=Q20Ffo9bhzIjSUU/TI04gGq/g22LF50bnTlNFPrCNq4EkfpIk7Hqn8vg6L6FGEru2cCMTV
 vQzWJTvaxh8u1GLHQSf5GYHPEtnga/SpkjKuB1pR7D82ivgO30UciAt/DeFq5nqF/uRr9A
 ElwYf8RaihqdUt3NhRnckx1GhP9tja4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-Jkmg4TtxPEOiAuzL-TH5tQ-1; Thu,
 21 Nov 2024 10:44:08 -0500
X-MC-Unique: Jkmg4TtxPEOiAuzL-TH5tQ-1
X-Mimecast-MFC-AGG-ID: Jkmg4TtxPEOiAuzL-TH5tQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 354211956064; Thu, 21 Nov 2024 15:44:07 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48ABD1956086; Thu, 21 Nov 2024 15:44:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 16/18] tests/functional: remove time.sleep usage from
 tuxrun tests
Date: Thu, 21 Nov 2024 15:42:16 +0000
Message-ID: <20241121154218.1423005-17-berrange@redhat.com>
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com>
References: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The tuxrun tests send a series of strings to the guest to login
and then run commands. Since we have been unable to match on
console output that isn't followed by a newline, the test used
many time.sleep() statements to pretend to synchronize with
the guest.

This has proved to be unreliable for the aarch64be instance of
the tuxrun tests, with the test often hanging. The hang is a
very subtle timing problem, and it is suspected that some
(otherwise apparently harmless) I/O error messages could be
resulting in full FIFO buffers, stalling interaction with
the guest.

With the newly rewritten console interaction able to match
strings that don't have a following newline, the tux run
tests can now match directly on the login prompt, and/or
shell PS1 prompt.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2689
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/tuxruntest.py | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index ed2b238c92..ab3b27da43 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -124,16 +124,12 @@ def run_tuxtest_tests(self, haltmsg):
         then do a few things on the console. Trigger a shutdown and
         wait to exit cleanly.
         """
-        self.wait_for_console_pattern("Welcome to TuxTest")
-        time.sleep(0.2)
-        exec_command(self, 'root')
-        time.sleep(0.2)
-        exec_command(self, 'cat /proc/interrupts')
-        time.sleep(0.1)
-        exec_command(self, 'cat /proc/self/maps')
-        time.sleep(0.1)
-        exec_command(self, 'uname -a')
-        time.sleep(0.1)
+        ps1='root@tuxtest:~#'
+        self.wait_for_console_pattern('tuxtest login:')
+        exec_command_and_wait_for_pattern(self, 'root', ps1)
+        exec_command_and_wait_for_pattern(self, 'cat /proc/interrupts', ps1)
+        exec_command_and_wait_for_pattern(self, 'cat /proc/self/maps', ps1)
+        exec_command_and_wait_for_pattern(self, 'uname -a', ps1)
         exec_command_and_wait_for_pattern(self, 'halt', haltmsg)
 
         # Wait for VM to shut down gracefully if it can
-- 
2.46.0


