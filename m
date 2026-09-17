Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A12C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo8-0003F5-Tm; Thu, 17 Sep 2026 17:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo4-0002mW-SD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:13 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo3-0007mw-9E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:12 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc0so639233a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681090; x=1790285890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Oqd+89YbJDB2DyKGjGr0gV1UqVGACVX/6aSSSxFh6c=;
 b=dYyLOpAvB1PJFYbo2308b+l8r82c3E+mpJQ72M0rRAjIOmUYxPYQXS5R86jfRg7pc7
 5k5EKo+ZrOgF9FhuGTTjJtwccQQ6NiVGwpFlMlwMohOMSZJtbSSwo028Ls/CIU4b1VmJ
 +j1eRT1bDz4RGPZOu1h7vENOqGtRgss6tOJ/Y793nOYI5fnyEXynGEo8Io43jGn5YqEs
 9C/fMI/HKmu8IN/EatRFyj5LwRvlGVASp/N5qO8vCfOeaSp1aeY5vVW7VG3/3G2aFVLV
 hUeBDwacn9GdIzg1fKA3jHT0tqxjygnwyHS7pNdnzGx4dpAX3NuIkWMxC4h7PH/DZXr7
 SZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681090; x=1790285890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Oqd+89YbJDB2DyKGjGr0gV1UqVGACVX/6aSSSxFh6c=;
 b=HeUmPfIyjFBNQOjAjqooIYFz209MetYEGyC9G8Pftu7L1zpQABlfTPODfD+YfakyMS
 bKkm+x2cCA6xxFU9vooIEJMbxz0D2Umlv2OJy0SUQjw6uBvjAmm0rFMZMc7BVxRcreV1
 aQMxWFpsG5sE4mSpm9nur/NLq10uNNlHqeVfDBluIqg2B8YRdow5zz2oTX8oecBTjuYZ
 pA5FX25O1NkyMKOTuiwrfj8cvtPHuGXPJegbYDM3HGdLr2mnLKplDSoWP7rjT58/2xe0
 NVOLpe7e2Hlb/OdJNwef0BQm/Z7TWrSenEchMetLSaj752+zNlXdFOhr9P11N/2oM/YV
 ed3w==
X-Gm-Message-State: AFuF++lDUacu7AkgDS/VvQBCgbA6ndzHTVkRDk7A/tTs0EgfxgIIxokE
 wLDldxw97zj54t9Oqo/JiAWuumkMYxTAL3odSijTznzTkBEPYbrNwD9UYqWNxADAmPSU4CXOuzU
 XEgFiLIU=
X-Gm-Gg: AYBFou3HayOreGjclKRcNGmZhK/THFl4jbfUb3KSX1UvuEKzoP6XccwiT8HzTcost+3
 Jy2GcjLgvfFym8e50NUcMGYkkHx3A/DCldHdRXTxVR8XrG+tmsEI9+0so2xkIxge0HOndohf5M3
 3/ugS1yvJ8K12K+zJDAl4hZU6stpOJsAj464RrqNxJVcWW3vo3ufZfXFIa9oLZ1nz/ULnvl+ivt
 7BB6y8/v+D3cW+Nfr6gELx1nUHuPBscRRXg2tFCQcwASVT2COLlsB2AMqyL+bTyz6C55OeTRiPB
 lgCaXqRHf8eIuQY/HPmAcpBw6r7RQPhdJmjsk1pD6eUhHqTmGKuhBrbXfOHg4y9VZtJK3rGdFHD
 zfNV9C1N3tOLo73Q7RT+Kj3ABGIsXx0Uy/o6fBJqsxPAGYa5YSlcSrnLkOvltEr22qmNXW/O9oU
 f3LD/6jSp4sWRr2kDR7wsT3E2YejuTeyYmNyDyPaBDXAJvomqzxGaw7Usptc/opNd294GbGqqt4
 MBWJpMJibiZYfefRPo=
X-Received: by 2002:a05:6a21:7105:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3dd8c3d20d1mr543705637.7.1789681089936; 
 Thu, 17 Sep 2026 14:38:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 15/15] tests/tcg/s390x: Test LOAD and STORE REVERSED
Date: Thu, 17 Sep 2026 11:37:49 -1000
Message-ID: <20260917213749.36756-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260803123928.1875606-1-iii@linux.ibm.com>
---
 tests/tcg/s390x/load-store-reversed.c | 46 +++++++++++++++++++++++++++
 tests/tcg/s390x/meson.build           |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 tests/tcg/s390x/load-store-reversed.c

diff --git a/tests/tcg/s390x/load-store-reversed.c b/tests/tcg/s390x/load-store-reversed.c
new file mode 100644
index 00000000000..bcc6b98dd3b
--- /dev/null
+++ b/tests/tcg/s390x/load-store-reversed.c
@@ -0,0 +1,46 @@
+/*
+ * Test the LOAD REVERSED and STORE REVERSED instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    long i = 0x123456789abcdefULL, o;
+
+    o = i;
+    asm("lrvr %0,%1" : "+r" (o) : "r" (i));
+    assert(o == 0x1234567efcdab89ULL);
+
+    o = i;
+    asm("lrvgr %0,%1" : "+r" (o) : "r" (i));
+    assert(o == 0xefcdab8967452301ULL);
+
+    o = i;
+    asm("lrvh %0,%1" : "=r" (o) : "T" (i));
+    assert(o == 0x123456789ab2301ULL);
+
+    o = i;
+    asm("lrv %0,%1" : "=r" (o) : "T" (i));
+    assert(o == 0x123456767452301ULL);
+
+    o = i;
+    asm("lrvg %0,%1" : "=r" (o) : "T" (i));
+    assert(o == 0xefcdab8967452301ULL);
+
+    o = i;
+    asm("strvh %1,%0" : "=T" (o) : "r" (i));
+    assert(o == 0xefcd456789abcdefULL);
+
+    o = i;
+    asm("strv %1,%0" : "=T" (o) : "r" (i));
+    assert(o == 0xefcdab8989abcdefULL);
+
+    o = i;
+    asm("strvg %1,%0" : "=T" (o) : "r" (i));
+    assert(o == 0xefcdab8967452301ULL);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index dc6271c7c73..c9af66aa1b0 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -73,6 +73,7 @@ tests += {
   'stckf.c': {},
   'ts.c': {},
   'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+  'load-store-reversed.c': {},
 }
 
 foreach src: tests_s390x_pgm
-- 
2.53.0


