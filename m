Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F288D73EB1
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0Tb-0007EI-Lu; Fri, 30 Jan 2026 21:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0TR-0006wA-7B
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:12:34 -0500
Received: from mail-10626.protonmail.ch ([79.135.106.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0TM-00027v-L7
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769825545; x=1770084745;
 bh=v+3r1FrmqevCgJnc8NlPIs5RUlRvtA5aa2esuxBc84k=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dy4kV1C+XgPsHdXIGAJ4PKvOO7tcj3w3gG/Hkatw/srimbQLOtQLu6yFW4rA1YA7j
 qZQt31SAuiXKFkxi4T0xbLMQBsjEwLGH0AdiO4EFYHvfQI+PBJchf5HybocSW7sQgK
 1mfBYOMHHw7HQikU0zLYoa7YEYZTwsVbDStw7RBba2iqXI/FrRZDF6+U2UHXDoQUF9
 OS6l9DC0gG0FG7wl7Ggk5kxqgjGmYFROIZarcavIgV+O92LVUrHw64eSx/4IdNR4kt
 1KVi1yD4uxjn3x/cW8LwC9rtetKpqkGNoq3shX94gHSGolMfuM/SIdJlepYph4Lfri
 i0gg9/d1rwpSg==
Date: Sat, 31 Jan 2026 02:12:20 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v4 4/5 qemu] block/file-posix: Clean up sys/ioctl import
Message-ID: <20260131021116.1717230-5-damien@zamaudio.com>
In-Reply-To: <20260131021116.1717230-1-damien@zamaudio.com>
References: <20260131021116.1717230-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: bb61cb6876f646ce576f0f6c948f549ae6c24f5e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.26; envelope-from=damien@zamaudio.com;
 helo=mail-10626.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since all platforms except sun include this header,
clean up the ifdefs.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 block/file-posix.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 6265d2e248..8a3ba5eecb 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -43,9 +43,11 @@
 #include "scsi/constants.h"
 #include "scsi/utils.h"
=20
-#if defined(__APPLE__) && (__MACH__)
+#ifndef __sun__
 #include <sys/ioctl.h>
-#if defined(HAVE_HOST_BLOCK_DEVICE)
+#endif
+
+#if defined(__APPLE__) && (__MACH__) && defined(HAVE_HOST_BLOCK_DEVICE)
 #include <paths.h>
 #include <sys/param.h>
 #include <sys/mount.h>
@@ -57,7 +59,6 @@
 //#include <IOKit/storage/IOCDTypes.h>
 #include <IOKit/storage/IODVDMedia.h>
 #include <CoreFoundation/CoreFoundation.h>
-#endif /* defined(HAVE_HOST_BLOCK_DEVICE) */
 #endif
=20
 #ifdef __sun__
@@ -65,7 +66,6 @@
 #include <sys/dkio.h>
 #endif
 #ifdef __linux__
-#include <sys/ioctl.h>
 #include <sys/param.h>
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -95,27 +95,20 @@
 #endif
=20
 #ifdef __OpenBSD__
-#include <sys/ioctl.h>
 #include <sys/disklabel.h>
 #include <sys/dkio.h>
 #endif
=20
 #ifdef __NetBSD__
-#include <sys/ioctl.h>
 #include <sys/disklabel.h>
 #include <sys/dkio.h>
 #include <sys/disk.h>
 #endif
=20
 #ifdef __DragonFly__
-#include <sys/ioctl.h>
 #include <sys/diskslice.h>
 #endif
=20
-#ifdef EMSCRIPTEN
-#include <sys/ioctl.h>
-#endif
-
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
 #ifdef O_SYNC
--=20
2.51.0



