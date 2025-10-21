Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F5ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCs7-0000Fq-2j; Tue, 21 Oct 2025 09:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs2-0000Di-47
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs0-0007ws-43
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2L/Jxby2ZpFPnIqwqvxM/ykVi8YDoUxBU6sV7v8gSk=;
 b=JAGVZGUMhihbklCwED+NiFaZmt5sbjKCGO284UFttUOtXs+W2iLd+662JjQCRu8CaMOFXm
 XMA16QjgkLllxEjFeqPjviFIK4ejlm6eBiDw5wvFnvrzcMWe1TT1OxogwvQMJ1Z4dKKi/s
 Nlir1JfMgLPkGp7g+vIsIyaRpITj3ug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-IOqRt3DgOBWgR0o-I84kng-1; Tue,
 21 Oct 2025 09:57:43 -0400
X-MC-Unique: IOqRt3DgOBWgR0o-I84kng-1
X-Mimecast-MFC-AGG-ID: IOqRt3DgOBWgR0o-I84kng_1761055061
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98DEC18002DD; Tue, 21 Oct 2025 13:57:41 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CD0D19560A2; Tue, 21 Oct 2025 13:57:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PULL 2/6] tests/functional: add tests for SCLP event CPI
Date: Tue, 21 Oct 2025 15:57:31 +0200
Message-ID: <20251021135735.96145-3-thuth@redhat.com>
In-Reply-To: <20251021135735.96145-1-thuth@redhat.com>
References: <20251021135735.96145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>

Add tests for SCLP event type Control-Program Identification.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by Thomas Huth <thuth@redhat.com>
Message-ID: <20251016121708.334133-2-shalini@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/s390x/test_ccw_virtio.py | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
index 453711aa0f5..04553378567 100755
--- a/tests/functional/s390x/test_ccw_virtio.py
+++ b/tests/functional/s390x/test_ccw_virtio.py
@@ -15,6 +15,7 @@
 import tempfile
 
 from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
 
@@ -270,5 +271,30 @@ def test_s390x_fedora(self):
                         'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
                         ' sleep 1 ; done', 'Start virtcrypto_remove.')
 
+        # Test SCLP event Control-Program Identification (CPI)
+        cpi = '/sys/firmware/cpi/'
+        sclpcpi = '/machine/sclp/s390-sclp-event-facility/sclpcpi'
+        self.log.info("Test SCLP event CPI")
+        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
+        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
+        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
+        exec_command(self, 'echo 0x001a000000060b00 > ' + cpi + 'system_level')
+        exec_command_and_wait_for_pattern(self,
+                                          'echo 1 > ' + cpi + 'set', ':/#')
+        try:
+            event = self.vm.event_wait('SCLP_CPI_INFO_AVAILABLE')
+        except TimeoutError:
+            self.fail('Timed out waiting for the SCLP_CPI_INFO_AVAILABLE event')
+        ts = self.vm.cmd('qom-get', path=sclpcpi, property='timestamp')
+        self.assertNotEqual(ts, 0)
+        name = self.vm.cmd('qom-get', path=sclpcpi, property='system_name')
+        self.assertEqual(name.strip(), 'TESTVM')
+        typ = self.vm.cmd('qom-get', path=sclpcpi, property='system_type')
+        self.assertEqual(typ.strip(), 'LINUX')
+        sysplex = self.vm.cmd('qom-get', path=sclpcpi, property='sysplex_name')
+        self.assertEqual(sysplex.strip(), 'TESTPLEX')
+        level = self.vm.cmd('qom-get', path=sclpcpi, property='system_level')
+        self.assertEqual(level, 0x001a000000060b00)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.0


