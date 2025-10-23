Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABFFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vByfY-0004pv-La; Thu, 23 Oct 2025 13:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vByfV-0004li-VF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:00:05 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1vByfS-0005i0-Vt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:00:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 84CAF80867;
 Thu, 23 Oct 2025 20:00:00 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:ef9:2188:6644:f7b6])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8xbwbU0ImGk0-sICMexIH; Thu, 23 Oct 2025 20:00:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761238800;
 bh=l3Q5Jn0/ip5OA9uVWgOE4Exn6LjYQnH+//1CKa2kqlE=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=kbAD80WNEv9eKOjxB9s3Te/XkWq06H/4wEXIAwBlHvtPPbjg2+8DJ63kKCZpX2y5P
 9R+N5Oumaefh2Q5jgz4n7hb7u5IAfmJw5mJGYfMXE17IpWlbZ+YDr8rl0tRasrpFbF
 2ilMjiLtYeiIp33aRAT0JX4Ua11kSM1smATCVPKI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: crosa@redhat.com, jsnow@redhat.com, davydov-max@yandex-team.ru,
 philmd@linaro.org, vsementsov@yandex-team.ru
Subject: [PATCH 1/2] scripts/compare-mt: add confidential computing getter
Date: Thu, 23 Oct 2025 19:58:45 +0300
Message-Id: <20251023165846.326295-2-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023165846.326295-1-davydov-max@yandex-team.ru>
References: <20251023165846.326295-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

"sev-guest" option was added to the 9.0 machines. So, the script has to
be able to get default values of properties of this type.
Unfortunatelly, some default values are set during instance
initialization but not during class initialization. Thus, they can't be
easily accessed.

Based on the above, "qom-list-properties" command was choosen for getting
default values, but now it always returns nothing usefull. Maybe, in the
future we will have a more appropriate command for "sev-guest".

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 scripts/compare-machine-types.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/compare-machine-types.py b/scripts/compare-machine-types.py
index 2af3995eb8..dba9e03548 100755
--- a/scripts/compare-machine-types.py
+++ b/scripts/compare-machine-types.py
@@ -154,6 +154,26 @@ def get_prop(self, driver: str, prop_name: str) -> str:
         return 'Unknown property'
 
 
+# A stub to print default values of all types whose parent is
+# 'confidential-guest-support'. Some properties have default values
+# but can't be accessed without an instance initialization (e.g.
+# "policy" of "sev-snp-guest").
+class QEMUConfidentialGuestSupport(QEMUObject):
+    def __init__(self, vm: QEMUMachine) -> None:
+        super().__init__(vm, 'confidential-guest-support')
+        self.cached: Dict[str, List[Dict[str, Any]]] = {}
+
+    def get_prop(self, driver: str, prop_name: str) -> str:
+        if driver not in self.cached:
+            self.cached[driver] = self.vm.cmd('qom-list-properties',
+                                              typename=driver)
+        for prop in self.cached[driver]:
+            if prop['name'] == prop_name:
+                return str(prop.get('default-value', 'No default value'))
+
+        return 'Unknown property'
+
+
 def new_driver(vm: QEMUMachine, name: str, is_abstr: bool) -> Driver:
     if name == 'object':
         return QEMUObject(vm, 'object')
@@ -163,6 +183,8 @@ def new_driver(vm: QEMUMachine, name: str, is_abstr: bool) -> Driver:
         return QEMUx86CPU(vm)
     elif name == 'memory-backend':
         return QEMUMemoryBackend(vm)
+    elif name == 'confidential-guest-support':
+        return QEMUConfidentialGuestSupport(vm)
     else:
         return Driver(vm, name, is_abstr)
 # End of methods definition
-- 
2.34.1


