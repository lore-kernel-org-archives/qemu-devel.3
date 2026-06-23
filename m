Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2616ACDB480
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxtA-00087t-4k; Tue, 23 Jun 2026 05:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxt8-0007u7-8I
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxt6-0003mK-MO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782208668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujsKwFFgURa1HeOejuIFxe0Lo00uy5++usFNyisU6eQ=;
 b=PKdlI/GOO6fQWY/49HiDIVt7B25XDLUJxIVF6P+Ut0KuQZYcQJi8aTGHxuN4Zkgbl2d+1+
 X2AdN18AKKaOyaJdmLKDQiioUkSgwFbDEDO85jVtjG+L3o3WTbcuvFCdJpJG2Jv6Z1ozN/
 n7TmuTK4rupbryk2yggXnMusX87kgtA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-dzpWGB5LOjyzWIwcrd1v1A-1; Tue,
 23 Jun 2026 05:57:43 -0400
X-MC-Unique: dzpWGB5LOjyzWIwcrd1v1A-1
X-Mimecast-MFC-AGG-ID: dzpWGB5LOjyzWIwcrd1v1A_1782208662
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F28C19540F0; Tue, 23 Jun 2026 09:57:42 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.133])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50F6D1686; Tue, 23 Jun 2026 09:57:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 29/35] tests/functional: add a stress test for monitor hot
 unplug
Date: Tue, 23 Jun 2026 10:55:45 +0100
Message-ID: <20260623095551.2106712-30-berrange@redhat.com>
In-Reply-To: <20260623095551.2106712-1-berrange@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When unplugging a monitor there is a careful synchronization dance
between the monitor handling the "object-del" command and the
command processing for the monitor being deleted.

The stress test runs a busy loop of 'query-qmp-schema' on a second
monitor, while the primary monitor requests its deletion.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .../generic/test_monitor_hotplug.py           | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
index 5d8a159eb0..55af8a238f 100755
--- a/tests/functional/generic/test_monitor_hotplug.py
+++ b/tests/functional/generic/test_monitor_hotplug.py
@@ -6,11 +6,16 @@
 #
 # Copyright (c) 2026 Christian Brauner
 
+import asyncio
 import os
+import random
+import threading
+import time
 
 from qemu_test import QemuSystemTest
 
 from qemu.qmp.legacy import QEMUMonitorProtocol
+from qemu.qmp import QMPClient
 
 
 class MonitorHotplug(QemuSystemTest):
@@ -163,6 +168,63 @@ def test_events_after_negotiation(self):
         qmp.close()
         self._remove_monitor()
 
+    def stress_mon(self, sock):
+        async def main():
+            qmp = QMPClient('testvm')
+            await qmp.connect(sock)
+            # Run query-version in a tight loop so that the
+            # monitor thread/dispatcher is very busy at the
+            # time we try to delete the monitor
+            while True:
+                try:
+                    # A command which returns a lot of data to make
+                    # it more likely we're in the I/O reply path
+                    # when deleting the monitor
+                    res = await qmp.execute('query-qmp-schema')
+                    # Some commands which generate async events
+                    # as those can trigger different code paths
+                    res = await qmp.execute('stop')
+                    res = await qmp.execute('cont')
+                except:
+                    # we'll get here if the monitor is terminated
+                    # by QEMU in which case we must disconnect
+                    # out side, but....
+                    try:
+                        await qmp.disconnect()
+                    except (ConnectionResetError, EOFError, BrokenPipeError):
+                        # ... disconnect() will probably see
+                        # errors too, but we must try to call it
+                        # regardless to cleanup asyncio state
+                        # and prevent python warnings at GC time
+                        pass
+                    return
+        asyncio.run(main())
+
+    def test_hotplug_stress(self):
+        """
+        Repeatedly hotplug and unplug a monitor, while another thread
+        concurrently issues commands on that monitor. This stresses
+        the synchronization with the monitor thread during cleanup
+        """
+        self.set_machine('none')
+        self.vm.add_args('-nodefaults')
+        self.vm.launch()
+
+        # Each loop sleeps at most 0.5 seconds, so this should
+        # give an upper bound of approx 5 seconds execution
+        # time which is reasonable to run by default
+        repeat = 10
+        for i in range(repeat):
+            # First cycle
+            sock = self._add_monitor()
+            print ("# stress cycle %02d/%02d" % (i, repeat))
+            stress = threading.Thread(target=self.stress_mon, args=[sock])
+            stress.start()
+            # Sleep upto 1/2 second to vary the races
+            time.sleep(random.random() / 2)
+            self._remove_monitor()
+            stress.join()
+
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.54.0


