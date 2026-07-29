Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3963C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0dp-00058J-9O; Wed, 29 Jul 2026 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dn-00057D-Jb
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:55 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dl-0007kx-06
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id B5A26C0A4A;
 Wed, 29 Jul 2026 12:31:51 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id kVacraKWFGk0-Pn7GdoXq; Wed, 29 Jul 2026 12:31:51 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785317511;
 bh=Heugvd44UzeLE9Y7zi6x0k/Glc660bM46rnMu4b77TM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=SGXYJEvCNAnuMcKt3cjMntW90BbdPsDfN86r0r8LtvAdTtQqPOJ66VFNy1O+COnH+
 JDVBwGkjxdOtVkVJtIWacqdgZC0xz7G0tFzlGDSbOmZ/pWp8CdZmKarHIoy6NeSOMw
 2Shy2O1mahzLuz4zyBI49NOp7sSdWmV2cNwvyIQk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 4/5] tests/testcase.py: passthrough monitor_address
Date: Wed, 29 Jul 2026 12:31:44 +0300
Message-ID: <20260729093146.1893719-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We'll need it soon to implement test for cpr-exec mode of
tap-fd-migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/qemu_test/testcase.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 12ef84281c4..69d3d06cc0e 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -381,11 +381,12 @@ def require_device(self, devicename):
         if helptxt.find(devicename) < 0:
             self.skipTest('no support for device ' + devicename)
 
-    def _new_vm(self, name):
+    def _new_vm(self, name, monitor_address):
         vm = QEMUMachine(self.qemu_bin,
                          name=name,
                          base_temp_dir=self.workdir,
-                         log_dir=self.log_file())
+                         log_dir=self.log_file(),
+                         monitor_address=monitor_address)
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
 
@@ -400,11 +401,11 @@ def _new_vm(self, name):
     def vm(self):
         return self.get_vm(name='default')
 
-    def get_vm(self, name=None):
+    def get_vm(self, name=None, monitor_address=None):
         if not name:
             name = str(uuid.uuid4())
         if self._vms.get(name) is None:
-            self._vms[name] = self._new_vm(name)
+            self._vms[name] = self._new_vm(name, monitor_address)
             if self.cpu is not None:
                 self._vms[name].add_args('-cpu', self.cpu)
             if self.machine is not None:
-- 
2.43.0


