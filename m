Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4CACC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4T-0002GP-0C; Thu, 15 Oct 2026 06:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4R-0002EY-Cc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4P-0007oZ-OV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1af482519so22860955e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061540; x=1792666340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7hkoqg80LJ/iEfLHckgEh1MhXrvZWlafn/x+FJeWzgQ=;
 b=EHo6ynZ0Zs7G1Ng1bU/az97k21C70gttDxmtLojszgemAO9eZQsXf8q3dcBhOlu8ba
 bDWKdZVy1Z3PMmKAM/9rpuhgpNDZFfNHU41QeyyBdMNqsE0Hb2nKKWMLsT6EbH3eiagc
 FXpkXPwIbmjw8H/7eqs9f1imuCh8R1MNrlGB6LQllRL0HhE0h7UnjFUOo1CMinWnHDSi
 2zhdJxicCcf3DiYSVmElWDeqxQ1FBwF8NEtfjHukojGdK4A3hmnZTkHCRCAJYuoW2wnN
 YYWNogAHQum4t5C9ug+8AZpg9JnqBIakwi1yvppxCfAWHsuFPX6cvA7VON/xzw3t+Rfu
 JMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061540; x=1792666340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7hkoqg80LJ/iEfLHckgEh1MhXrvZWlafn/x+FJeWzgQ=;
 b=Tu3WJe00istBsHtv+nFs9B87AbL78WFyR+6jU7yfU9pTUdUSGcxpi3NyIVVXBrz6fz
 Ha+R2zjNTybMZvR7J2wKPtdxVgF+W391xBnnVPETf1rc90Y7Fgs4gYKNykTEPwkIihSm
 sYLMd1KbKr4oxwbc2wxeKt1FqPEjqwsiqLH6CIDvgS9PVM2IFoV9OUFlji6LM4r+XWBU
 zyHtBNQ1BreAPq0ZW+8nVQ8a69lhaLJDnS1rZTdIHsgNLMSe7iitJnKTMsZfjYbT4TYP
 htFLGG9ySiEwWgS7+8vHlJ1PWu9dgQOnThWyNe/1GmziZAOwKtZn9UPqbPm9EJSdii3a
 P8TQ==
X-Gm-Message-State: AFq9FYK3CkucYlO8MYhAqMJGWfGHkZGevta/iZNV/CjoDIXcqQTpreCa
 h4r6Dcwm1X07vbWjInD/MknallB9VxVFDLBmHVbwQOGebWwZX0SZxeveaZEq9MrIOBpxxuHuWSN
 ips79jV4=
X-Gm-Gg: AYBFou1zIOYmh+bBoU11brHOdyRwyz0tHG1NWfstydqtmjZ6KrOVLt7xIh9wlqjyCjO
 uFgLMACEkTt17Gb82Dv6R2UzxiA701YK1O5ibQ74rJ0FRCi8w+eystn5ZLWtSMPG9ccGRs1JyXO
 hedwF82/WqlGNO6Nw+qCZjND1NjSar5/bFxGOY2qtwiCnXPePryhRgvxm8+QKBzSdhf0U43SGoS
 DuSiPjSpR5OsUoTURd1C6q6dE6F0PLRIfAuiRCckvCO0gQCcFpNr39q1HPyKaKJmZYKcEQ41m3h
 5idC/gGMtSNruzBLhSOBTuNU3fQl12IQNrmqhvJ0h9CX4/lI309BPwpDMeLqjks9kzW1iW4c3gf
 7vc6Xj5VR1sH4DRRfu2YU+TGwQdGAbDMPWYWErjDbDrgyq6Nct4LoVLKygvzI4fwuKYqH5BmOIE
 rBy5yg7OJjH6c8ytFofu/m0LUKVjUaVBHy5k+XbhyQQijKZU6li3sE5ltBPwVFyTetVGpw3TRBC
 JT3EPkdZydO90RIRYZ49v4xA5n0+K/B5W134a4AQLiurL4eJx+CUjn6VyMMLhdVjGVkCn7JdtDR
 EmvzjsglyprDgGU=
X-Received: by 2002:a05:600c:810a:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a18e3ef100mr357492545e9.0.1792061540223; 
 Thu, 15 Oct 2026 03:52:20 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dominic P <gcc@gcc.dp11.uk>
Subject: [PULL 02/16] tests/tcg: Add tests for sign extension after rotate
Date: Thu, 15 Oct 2026 12:51:54 +0200
Message-ID: <20261015105212.356392-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dominic P <gcc@gcc.dp11.uk>

Cover the rotr_i32 (ARM ror) and rotl_i32 (i386 roll) forms fixed by
the previous patch.  Both tests fail without it.

Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930185124.3036980-3-gcc@gcc.dp11.uk>
---
 tests/tcg/arm/test-arm-opt-ror.c   | 21 +++++++++++++++++++++
 tests/tcg/i386/test-i386-opt-rol.c | 21 +++++++++++++++++++++
 tests/tcg/arm/meson.build          |  1 +
 tests/tcg/i386/meson.build         |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tests/tcg/arm/test-arm-opt-ror.c
 create mode 100644 tests/tcg/i386/test-i386-opt-rol.c

diff --git a/tests/tcg/arm/test-arm-opt-ror.c b/tests/tcg/arm/test-arm-opt-ror.c
new file mode 100644
index 00000000000..2579168a131
--- /dev/null
+++ b/tests/tcg/arm/test-arm-opt-ror.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetitions after rotate. */
+
+#include <assert.h>
+
+int main(void)
+{
+    /* Load from memory so that TCG does not see a constant. */
+    volatile int v = 3;
+    int x = v, gt;
+
+    asm("sxtb %1, %1\n\t"
+        "ror %1, %1, #1\n\t"
+        "sxtb %1, %1\n\t"
+        "cmp %1, #0\n\t"
+        "movle %0, #0\n\t"
+        "movgt %0, #1"
+        : "=r"(gt), "+r"(x) : : "cc");
+    assert(gt);
+    return 0;
+}
diff --git a/tests/tcg/i386/test-i386-opt-rol.c b/tests/tcg/i386/test-i386-opt-rol.c
new file mode 100644
index 00000000000..e0393147e17
--- /dev/null
+++ b/tests/tcg/i386/test-i386-opt-rol.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetitions after rotate. */
+
+#include <assert.h>
+
+int main(void)
+{
+    /* Load from memory so that TCG does not see a constant. */
+    volatile int v = 3;
+    int x = v;
+    char test;
+
+    asm("movsbl %b1, %1\n\t"
+        "roll $31, %1\n\t"
+        "movsbl %b1, %1\n\t"
+        "testl %1, %1\n\t"
+        "setg %0"
+        : "=q"(test), "+q"(x));
+    assert(test);
+    return 0;
+}
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 8f70411dfd6..fd82b5c7a63 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -39,6 +39,7 @@ tests += {
   },
   'pcalign-a32.c': {'cflags': ['-marm']},
   'issue4448.c': {},
+  'test-arm-opt-ror.c': {'cflags': ['-marm']},
 }
 
 # Vector SHA1
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 38723d7f8df..84bd68067a5 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -28,6 +28,7 @@ tests += {
   'test-i386-fxtract.c': {},
   'test-i386-fyl2x.c': {},
   'test-i386-fyl2xp1.c': {},
+  'test-i386-opt-rol.c': {},
   'test-i386-opt-shr.c': {},
   'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
   'test-i386-pseudo-denormal.c': {},
-- 
2.53.0


