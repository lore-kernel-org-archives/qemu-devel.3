Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC258C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBAP-00064R-IU; Wed, 29 Jul 2026 16:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBAN-00063M-Kj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:46:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBAL-0001w7-7m
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:46:15 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38101f85591so87547a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785357972; x=1785962772; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DpJFAUutrc41ySPpycA2ebbRrQVPAyR6l11ZXPhVRqo=;
 b=sqJCmWwrmdRFZL2sBDxfblXbcuCeulmQuqrKS+nsaLrH1lHErDSvBU4pCRdL/RIk69
 dIhql75w9KyJ5dmpYKRO47Li1vPGmP8tl92Y9h0C3RBDXiGqEHjjULSdSAUFwuXmgGb3
 0HyodhPtsjSVJj4ZMTfDhWoRFQ5lS+Yga8CN2EoInpkuqiLtuzv+CQi8Q2m0KVTcpg2k
 vncOLHtVC/h+9qDsKNazB78FV7uTyqGCFyP8xu7pOgkOH5CYghLvMmt4BW4unbyJI+km
 IYwrOFyceB8f0NmkR7+1pi3Iwl+Rg9BIXiAk/K+a3NnrGUAa8SKVjZwdGvAntTb1/aAL
 DaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785357972; x=1785962772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DpJFAUutrc41ySPpycA2ebbRrQVPAyR6l11ZXPhVRqo=;
 b=XmbIIFrIEmAdQ8CVnAOAzkgfwMmceUynXiI9VKicBmCQQUD2dKS4NEk+TYR22Mx5th
 Gv+e4VwohBeBVQm1xao8F/C1NdM4gYjUx/xPb90rZ/Zicez2C1gXT7akf14/t0PrUWWg
 7zmJ0W4UakwZWttICpv5w6MfnmJy7cPZfCKEuTN5FjQD10dVOtWvX8YTq7p6fV1kjssH
 dlwg9Rmw608UP8Yp5uac5hjxkjZAIigztXA95yY9IS+85bkt8PBLcoTAEAS3XKrwpZYu
 7Ft/sLqz4ubMwwo8U9iaGmFf1vBRNy4CXBYANCGyWRGR3u8LNKk9lu/2g3Juz4wAZ25a
 bzDw==
X-Gm-Message-State: AOJu0YzRG/+fKOMneLeT65cAmiYS537I2apKDje9iy7USpBAoh23yu8M
 otKCiiGGCxNUOTRxYnZEjt1cY+z6ViYAo8tc8VK8lnA4LQzkF1Y8BkBU
X-Gm-Gg: AR+sD10kAR3hmefCrFCJqg2wdSMiAl0uBJIAY/5W5L6h2ltY3hcZelCQshNaykIwkcx
 TY8wi3mvh4cVbJFX4EC42cEc15r14Dc3Fv4o/zHgR100vzK0a84ijm/gExPD5abXj/FGyxLyUAj
 inXEoh1Itzptfc16Ke6pROncvbsNQEBenXyjbigIyPEbBf7VevKaPmqiMZgSc6y6dg2FdVVDkfg
 Me+UwYNwFLlAO4dLdzLylTBdriHsNKOxTup7ArpWdf7wmXOJv0CzgriwnA13W6/72bjRreIruRs
 EwH+SWMOCzOmGK3LSJxCt7s1E0+3VLygDga9nTOiQyFDfsr/LyXqiLLUkndU0Y4QdsK5aYLEJYk
 5+pRNrXp6ISDfuIFqAoeq8q2b64Bm7sIlk862bjrtpdHp0qz2RoQjCOKNva/u6rV4uxTxMsQ7G9
 BSwzYqOyB/BKcck7QOBURt+dP7LnerDSw2LrQ9+ZS6p1kK4vHEkkhgziXk+QY1xs59Erc35XA=
X-Received: by 2002:a17:90b:1d44:b0:38d:eaed:4adb with SMTP id
 98e67ed59e1d1-38f83701272mr3929374a91.20.1785357971729; 
 Wed, 29 Jul 2026 13:46:11 -0700 (PDT)
Received: from devone.local ([2600:8801:100:1910:66a:cb3f:f6a7:d5f0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b88e12sm13032389eec.11.2026.07.29.13.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:46:11 -0700 (PDT)
From: Randy Schifflin <randy.schifflin@gmail.com>
Date: Wed, 29 Jul 2026 13:45:05 -0700
Subject: [PATCH v2 1/2] target/sh4: add tests for sh4 fipr and ftrv
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-fixup-sh4-tcg-fpu-instructions-b4-v2-1-2c1c0fe04672@gmail.com>
References: <20260729-fixup-sh4-tcg-fpu-instructions-b4-v2-0-2c1c0fe04672@gmail.com>
In-Reply-To: <20260729-fixup-sh4-tcg-fpu-instructions-b4-v2-0-2c1c0fe04672@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-trivial@nongnu.org, 
 Randy Schifflin <randy.schifflin@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1785357969; l=6194;
 i=randy.schifflin@gmail.com; s=id_rsa; h=from:subject:message-id;
 bh=5cBg+ZXpLi5ufRgZCbIjDZhGUAy04i15L8un0h7Z518=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBALXHj1ozDvr3TmWcPoueK1kIy
 Q3yQ7HL5bbiu8J+P0QBzcchmw5nwN0avQmreXhYuMhz40g0dhCJPnJqNHg1FBflQPz2cgY7Utm3
 9lQrK/CQqWsjRwXMinMR7LrmtMFp9+up7MzdXoxmTLgPsKJ/dQmx0rUHx++mUSl8zl7lHO50YVD
 hsw1RHrkrXlxnUjRi+jtjgErRHvoRwSZpKc44yR62wV8chkTMnHtrn8hgL0Hh+jhHteNn4JTQB/
 wme8MghhliXR5oh9xirpeLlS9S4TBY3Vdk6ccgvncSS4uF/y2ZAAV5sNiLZ97OFkBhIQ0bXhVx9
 w1LPMkho650Iu9da5/0koNheHS2KAVC2FdPTyaxvqeFAsAB8fCprfh4lpShdcVpyChdd2KXFS53
 s9MAUQmZjG0pQvS/dqGCCDWqo7cY3J3VTMXwVtdzYkgZt5eMajL7z8VljXQ08ZgAStdizC/rHNg
 wy+fIL+6kgxvL/NhJwoiAWhC4D+xQY7SXjJGTvwAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgLOJWZnfFuDKAkVWuk9Sy/WDZZo1ryfHSR/RACHO0HfZsgbjA
 mWxCBwprqDNChh7+K+KWnJ21svCtmzwU+UhMvkyMtM8LD9KthUtPItMWI3r/bJo1v6Py/LJ9Wjb
 gOZgz6Dx8EVhQT9l7prKjCRwjCrpnn0kw470tNLs6ELS6SpW7NrIGDjTyIR7+Xsil+Zmj2DTNtA
 mu/sioXYJ/GyCB8pNdmtmblgS+pl0bXRXCqJLzkW/e1xIGGdo/fnQkqnIQ2OppUMPJn7aeovjEf
 ye753y6l5sJW32Nzpgf+LiPlQ3rSDFab+/3e2mACqNI4flrBeJb0G0aw2noas0a5OW9iLbyR+sy
 HdY91rPrmg1oJb1CTBLXLye/5SNvKorssEc2w+7u3soVAi9ZRmrF9TBqYtpoEYCoB+Jjq2rBCcH
 liSk1/TQM1n6kA0bYz1jXcG6LCe93V4jRauhPsUmOdj27FhT0cJecw7aZQpZS6nMjzpMpgshEpt
 OO92ZA+TKb47Z4A==
X-Developer-Key: i=randy.schifflin@gmail.com; a=openssh;
 fpr=SHA256:7gww1tlDoVPb7symWGdTNhRWcHyTORA23OcjS8eyd8Y
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=randy.schifflin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add tests for the TCG generation of the sh4-specific `fipr`
and `ftrv` instructions.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>
---
 tests/tcg/sh4/Makefile.target |   7 +++
 tests/tcg/sh4/test-fpu-fipr.c |  72 ++++++++++++++++++++++++++++
 tests/tcg/sh4/test-fpu-ftrv.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index b7a8737be0..0975fac72d 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -16,3 +16,10 @@ TESTS += test-addv
 
 test-subv: CFLAGS += -O -g
 TESTS += test-subv
+
+test-fpu-fipr: CFLAGS += -O -g
+TESTS += test-fpu-fipr
+
+test-fpu-ftrv: CFLAGS += -O -g
+TESTS += test-fpu-ftrv
+
diff --git a/tests/tcg/sh4/test-fpu-fipr.c b/tests/tcg/sh4/test-fpu-fipr.c
new file mode 100644
index 0000000000..1bf1a1b4ec
--- /dev/null
+++ b/tests/tcg/sh4/test-fpu-fipr.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdlib.h>
+static const unsigned long FPSCR_PR_BIT = 1UL << 19;
+
+static void single_precision_mode(void)
+{
+    unsigned long fpscr;
+    /* Read FPSCR register */
+    asm volatile("sts fpscr, %0" : "=r" (fpscr));
+    /* Set precision mode to single-precision */
+    fpscr &= ~FPSCR_PR_BIT;
+    /* Write FPSCR register */
+    asm volatile("lds %0, fpscr" : : "r" (fpscr));
+}
+
+static float fipr(const float v1[4], const float v2[4])
+{
+    float fout = 0.0;
+    /*
+     * Perform inner product of fv4 and fv8
+     * Result is stored in the last float register of the last vector argument
+     */
+    asm volatile(
+        "fmov %1,fr4\n"
+        "fmov %2,fr5\n"
+        "fmov %3,fr6\n"
+        "fmov %4,fr7\n"
+        "fmov %5,fr8\n"
+        "fmov %6,fr9\n"
+        "fmov %7,fr10\n"
+        "fmov %8,fr11\n"
+        "fipr fv4,fv8\n" /* (fr4,fr5,fr6,fr7) dot (fr8,fr9,fr10,fr11) */
+        "fmov fr11,%0\n" /* Result in fr11 */
+        : "=f" (fout)
+        : "f" (v1[0]), "f" (v1[1]), "f" (v1[2]), "f" (v1[3]),
+          "f" (v2[0]), "f" (v2[1]), "f" (v2[2]), "f" (v2[3]));
+    return fout;
+}
+
+int main(void)
+{
+    /*
+     * The SH4 manual specifies `fipr` is only available when
+     * FPSCR register precision-mode (PR) bit is 0
+     */
+    single_precision_mode();
+
+    float v1[4] = {1.0, 0.0, 0.0, 0.0};
+    float mag_sq = 0.0;
+    float dot = 0.0;
+
+    mag_sq = fipr(v1, v1);
+    if (mag_sq != 1.0) {
+        abort();
+    }
+
+    v1[0] = 2.0;
+    mag_sq = fipr(v1, v1);
+    if (mag_sq != 4.0) {
+        abort();
+    }
+
+    float v2[4] = {1.0, 0.0, 0.0, 0.0};
+    dot = fipr(v1, v2);
+    if (dot != 2.0) {
+        abort();
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/sh4/test-fpu-ftrv.c b/tests/tcg/sh4/test-fpu-ftrv.c
new file mode 100644
index 0000000000..041e03120e
--- /dev/null
+++ b/tests/tcg/sh4/test-fpu-ftrv.c
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdlib.h>
+static const unsigned long FPSCR_PR_BIT = 1UL << 19;
+
+static void single_precision_mode(void)
+{
+    unsigned long fpscr;
+    /* Read FPSCR register */
+    asm volatile("sts fpscr, %0" : "=r" (fpscr));
+    /* Set precision mode to single-precision */
+    fpscr &= ~FPSCR_PR_BIT;
+    /* Write FPSCR register */
+    asm volatile("lds %0, fpscr" : : "r" (fpscr));
+}
+
+/* Set XMTRX registers to a doubling scale matrix */
+static void xmtrx_scale_2(void)
+{
+    asm volatile(
+        "fldi0 fr0\n" /* Pair dr0 (fr0, fr1) = zero,zero */
+        "fldi0 fr1\n"
+        "fldi1 fr2\n"
+        "fadd fr2,fr2\n" /* Pair dr2 (fr2,fr3) = two,zero */
+        "fldi0 fr3\n"
+        "fldi0 fr4\n"
+        "fmov fr2,fr5\n" /* Pair dr4 (fr4, fr5) = zero,two */
+
+        /* Enable pair-write */
+        "fschg\n"
+        /* matrix[0][0] = 2.0 */
+        /* matrix[0][1] = 0.0 */
+        "fmov dr2,xd0\n"
+        /* matrix[0][2] = 0.0 */
+        /* matrix[0][3] = 0.0 */
+        "fmov dr0,xd2\n"
+        /* matrix[1][0] = 0.0 */
+        /* matrix[1][1] = 2.0 */
+        "fmov dr4,xd4\n"
+        /* matrix[1][2] = 0.0 */
+        /* matrix[1][3] = 0.0 */
+        "fmov dr0,xd6\n"
+        /* matrix[2][0] = 0.0 */
+        /* matrix[2][1] = 0.0 */
+        "fmov dr0,xd8\n"
+        /* matrix[2][2] = 2.0 */
+        /* matrix[2][3] = 0.0 */
+        "fmov dr2,xd10\n"
+        /* matrix[3][0] = 0.0 */
+        /* matrix[3][1] = 0.0 */
+        "fmov dr0,xd12\n"
+        /* matrix[3][2] = 0.0 */
+        /* matrix[3][3] = 2.0 */
+        "fmov dr4,xd14\n"
+        /* Disable pair-write */
+        "fschg"
+        :
+        :
+        : "fr0", "fr1", "fr2", "fr3", "fr4", "fr5");
+}
+
+/* Transform vector vin by xmtrx; store result in vector vout */
+static void ftrv(const float vin[4], float vout[4])
+{
+    asm volatile("fmov %4,fr0\n"
+                 "fmov %5,fr1\n"
+                 "fmov %6,fr2\n"
+                 "fmov %7,fr3\n"
+                 "ftrv xmtrx,fv0\n"
+                 "fmov fr0,%0\n"
+                 "fmov fr1,%1\n"
+                 "fmov fr2,%2\n"
+                 "fmov fr3,%3"
+                 : "=f" (vout[0]), "=f" (vout[1]),
+                   "=f" (vout[2]), "=f" (vout[3])
+                 : "f" (vin[0]), "f" (vin[1]),
+                   "f" (vin[2]), "f" (vin[3])
+                 : "fr0", "fr1", "fr2", "fr3");
+}
+
+int main(void)
+{
+    /*
+     * The SH4 manual specifies `ftrv` is only available when
+     * FPSCR register precision-mode (PR) bit is 0
+     */
+    single_precision_mode();
+    xmtrx_scale_2();
+    float vin[4] = {1.0, 2.0, 3.0, 4.0};
+    float vout[4] = { 0.0, 0.0, 0.0, 0.0};
+
+    ftrv(vin, vout);
+    if (vout[0] != 2.0) {
+        abort();
+    }
+    if (vout[1] != 4.0) {
+        abort();
+    }
+    if (vout[2] != 6.0) {
+        abort();
+    }
+    if (vout[3] != 8.0) {
+        abort();
+    }
+
+    return 0;
+}

-- 
2.43.0


