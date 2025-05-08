Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53095C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 18:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD5gg-00075U-WE; Thu, 08 May 2025 14:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uD5ga-000751-Q3
 for qemu-devel@nongnu.org; Thu, 08 May 2025 14:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uD5gY-0004Fv-MS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 14:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746727768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=07HnvPojVF8hLGZzQUwp17gwdN6/3egZGr9Fl+4PU/0=;
 b=ijQtsUEnmVEs/0rAnhRFq0RrD49lHD6O8ORXQ13hZRThkXcqv4DCIYwtCJiSLJkb3HYp1v
 S+TYkRSLRvEbJDPaFIgGlqmqHu/gLjEN9fLS67Xx3RPeK4pQKSopz7SE//P6hGvOhU/Hx+
 dNG+GmwuZEXyQKqcHh7jSy2rDyReUt0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-8O6JguBzNWOiBEbq62C-Kw-1; Thu,
 08 May 2025 14:09:24 -0400
X-MC-Unique: 8O6JguBzNWOiBEbq62C-Kw-1
X-Mimecast-MFC-AGG-ID: 8O6JguBzNWOiBEbq62C-Kw_1746727763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C9E91800374; Thu,  8 May 2025 18:09:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.200])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5014419560AD; Thu,  8 May 2025 18:09:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Use -no-shutdown in the hppa_seabios test
Date: Thu,  8 May 2025 20:09:18 +0200
Message-ID: <20250508180918.228757-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

qemu-system-hppa shuts down automatically when the BIOS is
unable to boot from any device. So this test currently fails
occasionally when QEMU already quit, but the test still
expected it to be around (e.g. to shut it down cleanly).
Adding a "-no-shutdown" seems to make it reliable.
While we're at it, also remove the stray "self.machine" in
there that does not have any purpose.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_hppa_seabios.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/test_hppa_seabios.py
index a44d1a3eebe..661b2464e13 100755
--- a/tests/functional/test_hppa_seabios.py
+++ b/tests/functional/test_hppa_seabios.py
@@ -17,9 +17,9 @@ class HppaSeabios(QemuSystemTest):
     def boot_seabios(self):
         mach = self.machine
         bits = self.MACH_BITS[mach]
+        self.vm.add_args('-no-shutdown')
         self.vm.set_console()
         self.vm.launch()
-        self.machine
         wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Firmware')
         wait_for_console_pattern(self, f'Emulated machine:     HP {mach} ({bits}-bit')
 
-- 
2.49.0


