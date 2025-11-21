Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC90CFC51D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcz7-00044K-MT; Fri, 21 Nov 2025 21:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMc9Y-0006Lb-C4; Fri, 21 Nov 2025 20:11:04 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMc9M-0004Uw-V8; Fri, 21 Nov 2025 20:11:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 289B116CA51;
 Fri, 21 Nov 2025 21:44:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D601B321C8D;
 Fri, 21 Nov 2025 21:44:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bastian Blank <bblank@thinkmo.de>,
 Bastian Blank <waldi@debian.org>, Peter Maydell <peter.maydell@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 22/81] linux-user: Use correct type for FIBMAP and
 FIGETBSZ emulation
Date: Fri, 21 Nov 2025 21:43:21 +0300
Message-ID: <20251121184424.1137669-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Bastian Blank <bblank@thinkmo.de>

Both the FIBMAP and FIGETBSZ ioctl get "int *" (pointer to 32bit
integer) as argument, not "long *" as specified in qemu.  Using the
correct type makes the emulation work in cross endian context.

Both ioctl does not seem to be documented. However the kernel
implementation has always used "int *".

Signed-off-by: Bastian Blank <waldi@debian.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3185
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviwed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 7c7089321670fb51022a1c4493cbcc69aa288a0f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3b41128fd7..2f62fd2cb9 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -130,7 +130,7 @@
      IOCTL(FDTWADDLE, 0, TYPE_NULL)
      IOCTL(FDEJECT, 0, TYPE_NULL)
 
-     IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
+     IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_INT))
 #ifdef FICLONE
      IOCTL(FICLONE, IOC_W, TYPE_INT)
      IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
@@ -145,7 +145,7 @@
      IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range)))
 #endif
 
-     IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
+     IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_INT))
 #ifdef CONFIG_FIEMAP
      IOCTL_SPECIAL(FS_IOC_FIEMAP, IOC_W | IOC_R, do_ioctl_fs_ioc_fiemap,
                    MK_PTR(MK_STRUCT(STRUCT_fiemap)))
-- 
2.47.3


