Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6A9C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 17:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlAFK-0003l7-Io; Thu, 20 Feb 2025 12:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@gentoo.org>) id 1tlAFJ-0003kp-Hf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:21:57 -0500
Received: from mail.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]
 helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <sam@gentoo.org>) id 1tlAFH-0001lA-OI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 12:21:57 -0500
Received: from mop.. (unknown [82.8.138.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sam@gentoo.org)
 by smtp.gentoo.org (Postfix) with ESMTPSA id B676234300B;
 Thu, 20 Feb 2025 17:21:43 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: qemu-devel@nongnu.org
Cc: Sam James <sam@gentoo.org>
Subject: [PATCH] optionrom: pass -Wl,--no-error-rwx-segments
Date: Thu, 20 Feb 2025 17:21:30 +0000
Message-ID: <8fbd4539809b41b4c5db0005d2bbde74765c4370.1740072090.git.sam@gentoo.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4;
 envelope-from=sam@gentoo.org; helo=smtp.gentoo.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If GNU Binutils is configured with --enable-error-rwx-segments=yes, one
gets the following for optionrom:
```
.../bin/ld: error: pvh.img has a LOAD segment with RWX permissions
.../bin/ld: final link faile
```

Pass -Wl,--no-error-rwx-segments to suppress that.

Signed-off-by: Sam James <sam@gentoo.org>
---
 pc-bios/optionrom/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index 30d07026c7..4d3ce75af3 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -37,6 +37,7 @@ config-cc.mak: Makefile
 -include config-cc.mak
 
 override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
+override LDFLAGS += -Wl,--no-error-rwx-segments
 
 pvh.img: pvh.o pvh_main.o
 

base-commit: 40efe733e10cc00e4fb4f9f5790a28e744e63c62
-- 
2.48.1


