Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FF3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 13:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVWVk-0000yI-By; Sun, 21 Jul 2024 09:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sVSZP-0002Ij-Jg
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 05:09:31 -0400
Received: from kuriko.dram.page ([65.108.252.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sVSZM-0002Q7-Ex
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 05:09:31 -0400
From: Vivian Wang <uwu@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
 t=1721552964; bh=NeRawDYGirUd6fjzt3B5LrPbIDPJUX8InLiktOIoU7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GQpy6TW4BW/jpK02FOhBT6Hh1LeAot1xNhHK1Uia1OnTSdcGK5qg9FHux6zeFGX+e
 nY9UpOHFzPZtcndQVKhdFzrpgH8fs2p1ewab8pMl0bZYb6q9wwiJxndrFqBSIEu5LK
 NI7op7FENsgrtNfexpqKWPY0DceJKiiquLuV55/U=
To: qemu-devel@nongnu.org
Cc: Vivian Wang <uwu@dram.page>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
Date: Sun, 21 Jul 2024 17:08:16 +0800
Message-ID: <20240721090817.120888-2-uwu@dram.page>
In-Reply-To: <20240721090817.120888-1-uwu@dram.page>
References: <20240721090817.120888-1-uwu@dram.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.108.252.55; envelope-from=uwu@dram.page;
 helo=kuriko.dram.page
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Jul 2024 09:21:56 -0400
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

Sometimes zero is a valid value for getauxval (e.g. AT_EXECFD). Make
sure that we can distinguish between a valid zero value and a not found
entry by setting errno.

Ignore getauxval from sys/auxv.h on glibc < 2.19 because it does not set
errno.

Signed-off-by: Vivian Wang <uwu@dram.page>
---
 util/getauxval.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/util/getauxval.c b/util/getauxval.c
index b124107d61..f1008bdc59 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -24,7 +24,13 @@
 
 #include "qemu/osdep.h"
 
-#ifdef CONFIG_GETAUXVAL
+/* If glibc < 2.19, getauxval can't be used because it does not set errno if
+   entry is not found. */
+#if defined(CONFIG_GETAUXVAL) && \
+    (!defined(__GLIBC__) \
+        || __GLIBC__ > 2 \
+        || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19))
+
 /* Don't inline this in qemu/osdep.h, because pulling in <sys/auxv.h> for
    the system declaration of getauxval pulls in the system <elf.h>, which
    conflicts with qemu's version.  */
@@ -95,6 +101,7 @@ unsigned long qemu_getauxval(unsigned long type)
         }
     }
 
+    errno = ENOENT;
     return 0;
 }
 
@@ -104,7 +111,9 @@ unsigned long qemu_getauxval(unsigned long type)
 unsigned long qemu_getauxval(unsigned long type)
 {
     unsigned long aux = 0;
-    elf_aux_info(type, &aux, sizeof(aux));
+    int ret = elf_aux_info(type, &aux, sizeof(aux));
+    if (ret != 0)
+        errno = ret;
     return aux;
 }
 
@@ -112,6 +121,7 @@ unsigned long qemu_getauxval(unsigned long type)
 
 unsigned long qemu_getauxval(unsigned long type)
 {
+    errno = ENOSYS;
     return 0;
 }
 
-- 
2.45.1


