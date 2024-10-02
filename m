Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC991CF31AC
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 09:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svvON-00062C-0F; Wed, 02 Oct 2024 05:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1svvOK-00061w-5F
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 05:11:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1svvOI-0000uH-0m
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 05:11:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 208D5946A8;
 Wed,  2 Oct 2024 12:10:43 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5ACF414ABE1;
 Wed,  2 Oct 2024 12:11:21 +0300 (MSK)
Received: (nullmailer pid 995481 invoked by uid 1000);
 Wed, 02 Oct 2024 09:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] linux-user/elfload.c: keep GNU0_MAGIC in host byte order
Date: Wed,  2 Oct 2024 12:11:19 +0300
Message-Id: <20241002091119.995467-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Other places of this file operate in host byte order.  Only
this constant is defined as little-endian.  This does not
work, for example, on s390x host when running an arm64 binary:

 qemu-arm64: /usr/bin/busybox: Invalid note in PT_GNU_PROPERTY

This change is tested on all combinations of host/guest for
which debian provides release architectures, namely:

  amd64 arm64 armel armhf i386 mips64el ppc64el riscv64 s390x

Fixes: v5.1.0-2580-g83f990eb5adb "linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes"
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0678c9d506..1c54c556fc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3028,7 +3028,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
 
 enum {
     /* The string "GNU\0" as a magic number. */
-    GNU0_MAGIC = const_le32('G' | 'N' << 8 | 'U' << 16),
+    GNU0_MAGIC = 'G' | 'N' << 8 | 'U' << 16,
     NOTE_DATA_SZ = 1 * KiB,
     NOTE_NAME_SZ = 4,
     ELF_GNU_PROPERTY_ALIGN = ELF_CLASS == ELFCLASS32 ? 4 : 8,
-- 
2.39.5


