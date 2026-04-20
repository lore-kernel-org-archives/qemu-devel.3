Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50651F588EF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErMF-0005eS-A0; Mon, 20 Apr 2026 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wErMC-0005dR-Mt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:20:20 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wErMB-0003Hi-0U
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:20:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A03BA8062E;
 Mon, 20 Apr 2026 19:20:17 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 0KUTY10KuKo0-BZXgEaqI; Mon, 20 Apr 2026 19:20:17 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776702017;
 bh=86MQ9xSBn/yGccDFGDq/KIMg3bCdLAUA35MDduZTO6Y=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=cnjAbRrx2w9Yz/MOtanhTuqd/tVX5pm7K8xEV56CW6hS6YQ9EwA1k5A8Y8tnqI1iL
 mczUEo2oxWVY/5s0F2TlLRLtSbR1DQCmpfIRmwE9/+omedCnJxrcmiFygi0Pl6NtDx
 +YKrHLRNrSg8FJCum2VoQGVkAMGRnKmvM/DZBUg8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
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
Subject: [PATCH v14 7/8] tests/functional: add skipWithoutSudo() decorator
Date: Mon, 20 Apr 2026 19:19:57 +0300
Message-ID: <20260420161958.584407-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420161958.584407-1-vsementsov@yandex-team.ru>
References: <20260420161958.584407-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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


