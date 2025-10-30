Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA04CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJg-0000lo-Ph; Thu, 30 Oct 2025 16:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJL-0000gv-01
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:56 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJ5-0005wI-DF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0FB5380AAC;
 Thu, 30 Oct 2025 23:31:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-MKEVMu0Z; Thu, 30 Oct 2025 23:31:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856285;
 bh=vOw5oa65DZ0Z+eI0DURWrqAVxZOetTHC4LKJBWHMDPQ=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=rvSpYNIzeXup8Llds7Rml/zQMdza20s7zu4qcKpFH4KwRUv+kxoqFZtg0lB6CoKxY
 eV9mbBq4+iNrLWx35SrDVZFvegeymbKDudRF4JeR4piagOreE5Tg5bU5aJSNkPxoA0
 DYbBX2PhGdZsdwFhdoY39t71NZ/Qcchgw9Nl02Kk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 7/8] tests/functional: add skipWithoutSudo() decorator
Date: Thu, 30 Oct 2025 23:31:14 +0300
Message-ID: <20251030203116.870742-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030203116.870742-1-vsementsov@yandex-team.ru>
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

To be used in the next commit: that would be a test for TAP
networking, and it will need to setup TAP device.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 tests/functional/qemu_test/decorators.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index b239295804..125d31dda6 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -6,6 +6,7 @@
 import os
 import platform
 import resource
+import subprocess
 from unittest import skipIf, skipUnless
 
 from .cmd import which
@@ -167,3 +168,18 @@ def skipLockedMemoryTest(locked_memory):
         ulimit_memory == resource.RLIM_INFINITY or ulimit_memory >= locked_memory * 1024,
         f'Test required {locked_memory} kB of available locked memory',
     )
+
+'''
+Decorator to skip execution of a test if passwordless
+sudo command is not available.
+'''
+def skipWithoutSudo():
+    proc = subprocess.run(["sudo", "-n", "/bin/true"],
+                          stdin=subprocess.PIPE,
+                          stdout=subprocess.PIPE,
+                          stderr=subprocess.STDOUT,
+                          universal_newlines=True,
+                          check=False)
+
+    return skipUnless(proc.returncode == 0,
+                      f'requires password-less sudo access: {proc.stdout}')
-- 
2.48.1


