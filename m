Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB3DD116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjJ1-0004LU-W7; Wed, 03 Dec 2025 04:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjJ1-0004GA-09; Wed, 03 Dec 2025 04:37:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjIz-0007BH-Cx; Wed, 03 Dec 2025 04:37:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA4741708BF;
 Wed, 03 Dec 2025 12:35:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9619F32B5B6;
 Wed, 03 Dec 2025 12:36:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 96/96] kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl()
 return value
Date: Wed,  3 Dec 2025 12:35:29 +0300
Message-ID: <20251203093612.2370716-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

These functions wrap ioctl().  When ioctl() fails, it sets @errno.
The wrappers then return that @errno negated.

Except they call accel_ioctl_end() between calling ioctl() and reading
@errno.  accel_ioctl_end() can clobber @errno, e.g. when a futex()
system call fails.  Seems unlikely, but it's a bug all the same.

Fix by retrieving @errno before calling accel_ioctl_end().

Fixes: a27dd2de68f3 (KVM: keep track of running ioctls)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251128152050.3417834-1-armbru@redhat.com>
(cherry picked from commit 88be119fb19b8ee04d681ad9048cde9f6a37c631)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f8..8c360d8399 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3381,10 +3381,10 @@ int kvm_vm_ioctl(KVMState *s, unsigned long type, ...)
     trace_kvm_vm_ioctl(type, arg);
     accel_ioctl_begin();
     ret = ioctl(s->vmfd, type, arg);
-    accel_ioctl_end();
     if (ret == -1) {
         ret = -errno;
     }
+    accel_ioctl_end();
     return ret;
 }
 
@@ -3421,10 +3421,10 @@ int kvm_device_ioctl(int fd, unsigned long type, ...)
     trace_kvm_device_ioctl(fd, type, arg);
     accel_ioctl_begin();
     ret = ioctl(fd, type, arg);
-    accel_ioctl_end();
     if (ret == -1) {
         ret = -errno;
     }
+    accel_ioctl_end();
     return ret;
 }
 
-- 
2.47.3


