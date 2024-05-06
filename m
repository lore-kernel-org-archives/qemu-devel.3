Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F736C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wnY-0002wy-2z; Mon, 06 May 2024 07:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmg-00020j-GH
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:31 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wme-00020u-WD
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EefT7v8rE+Ga47+Z+jrlLQY0Rn8dnOkk3WD8JQbXUh8=; b=Bym6Utbz9yzPXMJYkK/+VPcqYp
 CefB2UmBuSYuuTdrAsCN40cRj1QcD9ZtJ8EQ1qUmC8YiLz3kQunxcISWFYbMoFQqku9n6F6dT5HIS
 GmKFiLFlsC93n3Pw4F+fzkKct16jW7aYQg5Y1UcMBPo3NK/s1jpQbN3gJgdk0wtKdM3zlUT2bAh2W
 OW8J0GF+ZUf3qFG+UUkz1VgBt75POMUNZX1fjeeR/MXqe3SDBhRkmzg9bdSs8iu+nTB9/zcsO+tqT
 Lrv3Y4lQjdqACS4veEuoEQOJ/2FDojPrsHEOnTrkO83SOx4vC7zCxYjLaEryNK12y96Yb+8hMHGuD
 KGFdB45Oiq46B/yvxYpm4yA/qYmZV2myqmvCXkNtphxuA6oHuJj7o2lL5SJrmVA21LnqlDBVcY2U6
 iPfD5U7GwyPcz0OizTfEqXgJ7OLK+PShx8Xak6pUUHuCJtUT4rd4qS04rKhdj1Br7ciQaKwswVg1v
 ghc/svQg8EWBMxzs4Loy6hvcvtKpofbh12FenhonsqERaTzaUIyIA4qmqh3ixztYHx/eZk5arM4SF
 ifngjUIDcVJF7c4MBrXy/N6tcSQYcihPdh/w0U9yxpkBN5t0Uud0OAwbOoxUxu9YvR5VgB4n+0cxF
 I/Qer9+HDRDVjVRRF36oFAVtACOi8Yqmul1MPIAXU=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wlW-0005pA-LF; Mon, 06 May 2024 12:44:22 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:45 +0100
Message-Id: <20240506114451.331311-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 06/12] linux-user/sparc: Add more hwcap bits for sparc64
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

From: Richard Henderson <richard.henderson@linaro.org>

Supply HWCAP_SPARC_V8PLUS, HWCAP_SPARC_MUL32, HWCAP_SPARC_DIV32,
HWCAP_SPARC_POPC, HWCAP_SPARC_FSMULD, HWCAP_SPARC_VIS, HWCAP_SPARC_VIS2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240502165528.244004-2-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 linux-user/elfload.c | 48 +++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f9461d2844..14f08b64a1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -968,24 +968,44 @@ const char *elf_hwcap2_str(uint32_t bit)
 #endif /* TARGET_ARM */
 
 #ifdef TARGET_SPARC
-#ifdef TARGET_SPARC64
 
-#define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
-                    | HWCAP_SPARC_MULDIV | HWCAP_SPARC_V9)
-#ifndef TARGET_ABI32
-#define elf_check_arch(x) ( (x) == EM_SPARCV9 || (x) == EM_SPARC32PLUS )
+#ifndef TARGET_SPARC64
+# define ELF_CLASS  ELFCLASS32
+# define ELF_ARCH   EM_SPARC
+#elif defined(TARGET_ABI32)
+# define ELF_CLASS  ELFCLASS32
+# define elf_check_arch(x) ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
-#define elf_check_arch(x) ( (x) == EM_SPARC32PLUS || (x) == EM_SPARC )
+# define ELF_CLASS  ELFCLASS64
+# define ELF_ARCH   EM_SPARCV9
 #endif
 
-#define ELF_CLASS   ELFCLASS64
-#define ELF_ARCH    EM_SPARCV9
-#else
-#define ELF_HWCAP  (HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | HWCAP_SPARC_SWAP \
-                    | HWCAP_SPARC_MULDIV)
-#define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_SPARC
-#endif /* TARGET_SPARC64 */
+#include "elf.h"
+
+#define ELF_HWCAP get_elf_hwcap()
+
+static uint32_t get_elf_hwcap(void)
+{
+    /* There are not many sparc32 hwcap bits -- we have all of them. */
+    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
+                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
+
+#ifdef TARGET_SPARC64
+    CPUSPARCState *env = cpu_env(thread_cpu);
+    uint32_t features = env->def.features;
+
+    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
+    /* 32x32 multiply and divide are efficient. */
+    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
+    /* We don't have an internal feature bit for this. */
+    r |= HWCAP_SPARC_POPC;
+    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
+    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
+    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+#endif
+
+    return r;
+}
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
-- 
2.39.2


