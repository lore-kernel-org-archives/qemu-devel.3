Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B68C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCPg-0001RA-NJ; Tue, 23 Jul 2024 06:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sWCPe-0001Lu-MM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:06:30 -0400
Received: from kuriko.dram.page ([65.108.252.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sWCPX-0007Hw-HB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:06:26 -0400
From: Vivian Wang <uwu@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
 t=1721729179; bh=ArdmnQR1Llme4HvtFTBZiU27PCQzl4QNiM7wMwOD1vo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KJ8AUxKeIiGfLW71lkfqNWw1Q8PGzXyLE/SAvb5FHjYfr7zFAaL380eX91kd6yQfR
 jKRIc276tOCifb/rBijLNAu/T461JHVwzmRef3dyBm+HkeS+oFqVHODtPZzJwogEs9
 V88/RWAJd50cKxLDfcmV7Fpc407MvT0QYmyMMi8k=
To: qemu-devel@nongnu.org
Cc: Vivian Wang <uwu@dram.page>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 1/2] util/getauxval: Ensure setting errno if not found
Date: Tue, 23 Jul 2024 18:05:44 +0800
Message-ID: <20240723100545.405476-2-uwu@dram.page>
In-Reply-To: <20240723100545.405476-1-uwu@dram.page>
References: <20240723100545.405476-1-uwu@dram.page>
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

Assumes that getauxval from sys/auxv.h sets errno correctly.

Signed-off-by: Vivian Wang <uwu@dram.page>
---
 util/getauxval.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/getauxval.c b/util/getauxval.c
index b124107d61..fad16c406e 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -95,6 +95,7 @@ unsigned long qemu_getauxval(unsigned long type)
         }
     }
 
+    errno = ENOENT;
     return 0;
 }
 
@@ -104,7 +105,9 @@ unsigned long qemu_getauxval(unsigned long type)
 unsigned long qemu_getauxval(unsigned long type)
 {
     unsigned long aux = 0;
-    elf_aux_info(type, &aux, sizeof(aux));
+    int ret = elf_aux_info(type, &aux, sizeof(aux));
+    if (ret != 0)
+        errno = ret;
     return aux;
 }
 
@@ -112,6 +115,7 @@ unsigned long qemu_getauxval(unsigned long type)
 
 unsigned long qemu_getauxval(unsigned long type)
 {
+    errno = ENOSYS;
     return 0;
 }
 
-- 
2.45.1


