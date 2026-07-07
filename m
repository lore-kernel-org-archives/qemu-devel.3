Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0F7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz9H-0003hg-R1; Tue, 07 Jul 2026 02:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz9B-0003eq-IF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:11 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz99-0001HA-Op
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:09 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id D2307240101
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 08:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783405144;
 bh=sqJjUQr1d6MtGh6P89u1z/j9xMEOCvznwFnXrNcsL+k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=UuUOO7HCe2otFHPKhEJ402fznlqGU5K0jGlSfztuwkviruaKp0BdP3yvXAsvVycce
 EeKcla5DBgmnMFZ5+Y8c97kzaCvrd8PUK5Mipr6q+nVQJqhHjTbaDDdeBNWe5/weeK
 nnooqiV4KfIBldASTwEiFDYSZACXGjQD5hcPsBhX+4N3ffDED8spAyJRIZjzsEhz2S
 hHHbO7+iSFyuq3GJltYrkNI5sABNpRaPENhBY5GRdD4zMLzuNR1hYD2+SWacK2Xx5J
 3BY2X9a9NYOqs3spucI1GzOeDBV0uoqde+B5YfI+NZ1vi1JDnNa6yMPqF4LOoMmumU
 75mwivrl7Xyxw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gvWJm320vz9rxG;
 Tue,  7 Jul 2026 08:19:04 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PULL 3/3] tests/functional: use QMP to query available machines
Date: Tue, 07 Jul 2026 06:19:04 +0000
Message-ID: <20260707061851.8298-4-th.huth@posteo.eu>
In-Reply-To: <20260707061851.8298-1-th.huth@posteo.eu>
References: <20260707061851.8298-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ganesh Harshan <ganeshredcobra@gmail.com>

Replace parsing of "qemu -M help" in set_machine() with
QMP "query-machines".

The previous approach relied on parsing human-readable CLI
output and substring matching, which is fragile and prone to
incorrect matches. It is also sensitive to output format changes.

Use QMP instead to retrieve structured machine information,
ensuring accurate matching and better maintainability.

Cache the result at the class level to avoid repeated QEMU
startup overhead.

Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260625165310.54113-1-ganeshredcobra@gmail.com>
[thuth: Drop problematic self.vm.set_machine() statement]
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 tests/functional/qemu_test/testcase.py | 31 +++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index eaec1bea13..4912a47a46 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -314,13 +314,32 @@ def setUp(self):
         console_log.addHandler(self._console_log_fh)
 
     def set_machine(self, machinename):
-        # TODO: We should use QMP to get the list of available machines
-        if not self._machinehelp:
-            self._machinehelp = run(
-                [self.qemu_bin, '-M', 'help'],
-                capture_output=True, check=True, encoding='utf8').stdout
-        if self._machinehelp.find(machinename) < 0:
+        cls = type(self)
+
+        if not hasattr(cls, "_machines"):
+            tmp_vm = QEMUMachine(self.qemu_bin)
+            tmp_vm.set_machine('none')
+
+            try:
+                tmp_vm.launch()
+                resp = tmp_vm.qmp('query-machines')
+
+                machines = resp.get('return', [])
+                cls._machines = [
+                    m.get('name') for m in machines if 'name' in m
+                ]
+
+            finally:
+                try:
+                    tmp_vm.shutdown()
+                except Exception:
+                    pass
+
+        self._machines = cls._machines
+
+        if machinename not in self._machines:
             self.skipTest('no support for machine ' + machinename)
+
         self.machine = machinename
 
     def require_accelerator(self, accelerator):
-- 
2.54.0


