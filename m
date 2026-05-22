Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03025CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOdU-0001lU-RX; Fri, 22 May 2026 08:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdT-0001lB-CN
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:51 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdR-0000cq-HB
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:50 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3F0A480739;
 Fri, 22 May 2026 15:05:48 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:55c::1:1d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Z5T7aO0g14Y0-kuzdgFnT; Fri, 22 May 2026 15:05:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779451547;
 bh=eUlFYRpVeapYCcmEi/9tpmjPFPyxSUveD1Zne0K2r8Y=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=Zy5NouIO/vDLnxoY227p6nDsm3NE28anGjTvWUmAFAWFTOIIrcLx+vEySarWj2QKI
 82NIJOWIBYMrvkASI1x51L2NoCQfdqMNSg4p5CZStguTTeDi/sZjhOu+wYTkS4lvLw
 pGXSZSd8O4le9nUxXi+HxG0jY1pUCnNSly8VlW38=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, Thomas Huth <thuth@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v16 7/8] tests/functional: add skipWithoutSudo() decorator
Date: Fri, 22 May 2026 15:05:32 +0300
Message-ID: <20260522120534.77653-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522120534.77653-1-vsementsov@yandex-team.ru>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

To be used in the next commit: that would be a test for TAP
networking, and it will need to setup TAP device.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 tests/functional/qemu_test/decorators.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index fcf236ecfdf..aa135acc785 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -6,6 +6,7 @@
 import os
 import platform
 import resource
+import subprocess
 from unittest import skipIf, skipUnless
 
 from .cmd import which
@@ -177,3 +178,18 @@ def skipLockedMemoryTest(locked_memory):
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
2.52.0


