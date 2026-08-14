Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77C2C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuorG-0002bp-26; Fri, 14 Aug 2026 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuorA-0002aD-4O
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuor8-0001jF-1I
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786702181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eajPihqaIKakud96xK9ImxfArzHQS6U2yhtiTwTnHe8=;
 b=iCH4G1C33Dp0hueYixMaGsN/U49wVFZssw29hQxlOA4NS6oc9WjTQ64DzIfNmRcCuFxVX0
 GLFmULuhvqPXQ/151YWNmucCjE5oF3WERv7HTkVzNx36yXH8HP0WxPUc5M2cjrpUkaKTT7
 0DGU9RUqTlj6qO6WrpZWjR0PcL/ZDCc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-4aMjAmREMfmIiybqECAhfg-1; Fri,
 14 Aug 2026 06:09:26 -0400
X-MC-Unique: 4aMjAmREMfmIiybqECAhfg-1
X-Mimecast-MFC-AGG-ID: 4aMjAmREMfmIiybqECAhfg_1786702165
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E33B1956096; Fri, 14 Aug 2026 10:09:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5CB4423; Fri, 14 Aug 2026 10:09:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 2/6] tests/functional/qemu_test: drop *args argument from
 .get_vm()
Date: Fri, 14 Aug 2026 12:09:13 +0200
Message-ID: <20260814100917.163448-3-thuth@redhat.com>
In-Reply-To: <20260814100917.163448-1-thuth@redhat.com>
References: <20260814100917.163448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

It's redundant. Only one caller use it, and it may be simply
substituted by .add_args().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260729093146.1893719-3-vsementsov@yandex-team.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/migration.py          | 3 ++-
 tests/functional/qemu_test/testcase.py | 9 +++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 4344e03be41..8d2428efc24 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -63,7 +63,8 @@ def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
         self.assert_dest_vm(dst_vm)
 
     def migrate(self, dst_uri, src_uri=None):
-        dst_vm = self.get_vm('-incoming', 'defer', name="dst-qemu")
+        dst_vm = self.get_vm("dst-qemu")
+        dst_vm.add_args('-incoming', 'defer')
         self.configure_machine(dst_vm)
         dst_vm.launch()
 
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index e4179d165c0..12ef84281c4 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -381,7 +381,7 @@ def require_device(self, devicename):
         if helptxt.find(devicename) < 0:
             self.skipTest('no support for device ' + devicename)
 
-    def _new_vm(self, name, *args):
+    def _new_vm(self, name):
         vm = QEMUMachine(self.qemu_bin,
                          name=name,
                          base_temp_dir=self.workdir,
@@ -394,20 +394,17 @@ def _new_vm(self, name, *args):
             vm.add_args("-chardev",
                         f"socket,id=backdoor,path={sockpath},server=on,wait=off",
                         "-mon", "chardev=backdoor,mode=control")
-
-        if args:
-            vm.add_args(*args)
         return vm
 
     @property
     def vm(self):
         return self.get_vm(name='default')
 
-    def get_vm(self, *args, name=None):
+    def get_vm(self, name=None):
         if not name:
             name = str(uuid.uuid4())
         if self._vms.get(name) is None:
-            self._vms[name] = self._new_vm(name, *args)
+            self._vms[name] = self._new_vm(name)
             if self.cpu is not None:
                 self._vms[name].add_args('-cpu', self.cpu)
             if self.machine is not None:
-- 
2.55.0


