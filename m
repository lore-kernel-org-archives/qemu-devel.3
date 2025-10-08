Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1A8CCD187
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEx-0002zc-6D; Wed, 08 Oct 2025 18:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDj-0001UX-Rx
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:01:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCf-0007bb-Jj
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:01:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7810289cd4bso283792b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960804; x=1760565604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CvJSXdiWhbprsJzICEFPWeYtoNE9+mbwDhHlNPU7kM=;
 b=aD7bzi01aXBjrXFeLw51y66oPSO2EzoPY7lUmI0QLXFkizvirvMLMxfuHG+8oJuoeT
 LrRWRnDsmigwx4Ikke+gBnlB7bg2v/PBytVTrx+gkn2evJow58AlR4gZIK1zJUTmscFM
 nSxpfS7nNqMwKnY8uABWps2a0JITNyy8DGFsccEiG073Co2HWpIh2pRhcLJs2X7v1gpw
 MBtKPEO6r9wcJUzrPQVibb34I6R79YpI6v/FN000rZ1VcGQQlkEESWFCxv7qXi3xfuon
 bLK6vXCEqRKAGsI259+0L1q/NPVzVDqJ3mdh1PZISgwbwnOFZ+J56Nmfdf6IHzH3O31G
 iFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960804; x=1760565604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CvJSXdiWhbprsJzICEFPWeYtoNE9+mbwDhHlNPU7kM=;
 b=WQu2sCXop1iDFhdVRbwY+9ckKTshT7++dn94ZHpcrtJYUa3QBnzWLHDZkAdI3OXcTl
 T/2CZro9Yk/xiSJKATaHHLzadj5OGttZjKm0+h0DcJ7PS9IC00In2h9jHCEizFImqKmi
 s9egGPa63QBJ4AZ6KWI6BT/oyHGWH4d+NC9UGU+ozkLwXK4F46040ADIR3si+h3CcaEU
 EdYazs2wEPtBK7cEV1qM6E8fzi9aULdNSNazM11m7m1JBHKhQvW15+AaVIZ/s1sDKaTP
 6sVp/BrVFakfjr9IOy1TF3RKHjmN2cbALrEiUNfhgomINo2gOHhQ8HwgdKcQGICa3Vsm
 8O7w==
X-Gm-Message-State: AOJu0YygfRzbDLmtJCC7JmXDVR4AQQ1Pgz/a0SyQ6OYSpOyYsQXDbvv3
 lxiAl0qF1btq2x84nHCpVyI2flUrvpjj2Gx0/XvHwtxKnGgux9c9xcRtbbHNyzibvFC5O3xb1o7
 rSDD4aWc=
X-Gm-Gg: ASbGncsULyKH1Sb4XpHr+evbmojfPWMSqBINE1QVBbRblNSU1DLAhNEAbl3dVFW1mgk
 Je+nt+utaFvBCgFcsLDmHTS7Op4o82kIH6jAPexq5isYLMK9bSHeR/Y4Zqlzp9mi/ck/CYrJsj+
 0DAzkeNKr5Iv91i0ufRAHs5S5anMwu2whLGtxbjeP+LCm3PUrh8YdMzrpD32zNgWdegHeCseVua
 DqrUhTfqnpg6PUX/yQC/OAbT3RpIXOhq+DY/7jgNLNTQLbsFDldthDixKdGwrDHttw7aUPm/fgf
 G3CCrKzuJEcgG4KrneKoINR62FAo2bRVyqg7lZVB7VfnZ/R55+lPWmaq18EJPz/Vp/Ng4Nhy9cN
 vgSa9K7lDck2irttZT2iwpqWIztUzXnlGVLGww1dXScsIdTERUXtkskZStQ4DgIKdYVg=
X-Google-Smtp-Source: AGHT+IELqBILhiNNSAYEg7skJqPvx1cysn7hLWyS6Ddye7mrhPWqikP9shQUPzDMT2jwAoKZdqirqA==
X-Received: by 2002:a05:6a20:6a1d:b0:2ff:1132:8c39 with SMTP id
 adf61e73a8af0-32da80da6c9mr6219620637.4.1759960803547; 
 Wed, 08 Oct 2025 15:00:03 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.15.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 15:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 73/73] tests/tcg/aarch64: Add gcsss
Date: Wed,  8 Oct 2025 14:56:13 -0700
Message-ID: <20251008215613.300150-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Validate stack switching and recursion depth.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gcs.h           |  9 ++++
 tests/tcg/aarch64/gcsss.c         | 74 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcsss.c

diff --git a/tests/tcg/aarch64/gcs.h b/tests/tcg/aarch64/gcs.h
index 99cb4d4e38..e821963cb8 100644
--- a/tests/tcg/aarch64/gcs.h
+++ b/tests/tcg/aarch64/gcs.h
@@ -69,3 +69,12 @@
 
 #define gcspr() \
     ({ uint64_t *r; asm volatile("mrs %0, s3_3_c2_c5_1" : "=r"(r)); r; })
+
+#define gcsss1(val) \
+    do {                                                                     \
+        asm volatile("sys #3, c7, c7, #2, %0" : : "r"(val) : "memory");      \
+    } while (0)
+
+#define gcsss2() \
+    ({ uint64_t *r;                                                          \
+       asm volatile("sysl %0, #3, c7, c7, #3" : "=r"(r) : : "memory"); r; })
diff --git a/tests/tcg/aarch64/gcsss.c b/tests/tcg/aarch64/gcsss.c
new file mode 100644
index 0000000000..9550c68e7e
--- /dev/null
+++ b/tests/tcg/aarch64/gcsss.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+#define IN_PROGRESS(X)  ((uint64_t)(X) | 5)
+#define CAP(X)          (((uint64_t)(X) & ~0xfff) + 1)
+
+static uint64_t * __attribute__((noinline)) recurse(size_t index)
+{
+    if (index == 0) {
+        return gcspr();
+    }
+    return recurse(index - 1);
+}
+
+int main()
+{
+    void *tmp;
+    uint64_t *alt_stack, *alt_cap;
+    uint64_t *orig_pr, *orig_cap;
+    uint64_t *bottom;
+    size_t pagesize = getpagesize();
+    size_t words;
+
+    enable_gcs(0);
+    orig_pr = gcspr();
+
+    /* Allocate a guard page before and after. */
+    tmp = mmap(0, 3 * pagesize, PROT_NONE, MAP_ANON | MAP_PRIVATE, -1, 0);
+    assert(tmp != MAP_FAILED);
+
+    /* map_shadow_stack won't replace existing mappings */
+    munmap(tmp + pagesize, pagesize);
+
+    /* Allocate a new stack between the guards. */
+    alt_stack = (uint64_t *)
+        syscall(__NR_map_shadow_stack, tmp + pagesize, pagesize,
+                SHADOW_STACK_SET_TOKEN);
+    assert(alt_stack == tmp + pagesize);
+
+    words = pagesize / 8;
+    alt_cap = alt_stack + words - 1;
+
+    /* SHADOW_STACK_SET_TOKEN set the cap. */
+    assert(*alt_cap == CAP(alt_cap));
+
+    /* Swap to the alt stack, one step at a time. */
+    gcsss1(alt_cap);
+
+    assert(gcspr() == alt_cap);
+    assert(*alt_cap == IN_PROGRESS(orig_pr));
+
+    orig_cap = gcsss2();
+
+    assert(orig_cap == orig_pr - 1);
+    assert(*orig_cap == CAP(orig_cap));
+    assert(gcspr() == alt_stack + words);
+
+    /* We should be able to use the whole stack. */
+    bottom = recurse(words - 1);
+    assert(bottom == alt_stack);
+
+    /* We should be back where we started. */
+    assert(gcspr() == alt_stack + words);
+
+    /* Swap back to the original stack. */
+    gcsss1(orig_cap);
+    tmp = gcsss2();
+
+    assert(gcspr() == orig_pr);
+    assert(tmp == alt_cap);
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index fddb7bc9cd..55ce34e45e 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr gcspushm
+GCS_TESTS += gcsstr gcspushm gcsss
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


