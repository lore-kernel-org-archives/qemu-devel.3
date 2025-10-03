Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E5CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jQL-0005Cu-Aw; Fri, 03 Oct 2025 13:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jM1-00082n-EZ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:14:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKH-0007vW-Mk
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so3464113b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511527; x=1760116327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55ummCXHlN27uJsHHRoko5hx4ehNW7kEFeS5FsKkEGI=;
 b=qRSl0ojzrXVM9ayk6GjAMin0VUpK+sehDe0vasa7NWWYS6qJbMd/rC1subKzdpn1CT
 G96zFiVYi+DrBy/m0QEfmHcAoXOA/Sm+/7qxGRSvMsgOD5tWCPNcBiUZErHB9zU0wvRe
 IRiPBAzqPVCxsps9muOlHcbOCsVTz0hMAYyyYJG9oCq36yXiNyIve8jU7+ahaImXZiQL
 uvP1oAvk5ODzTM7R12QLSMtL3pGxcV1916tt47QRG5T/9Az4P+g1MPHEqECQpFi475T+
 yWYArlV3MwBK05jQv0J0uNejVDhV8ycqUivYU3dwDmunpVguWT4Mm2j5ezPOHTZxPe4f
 uAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511527; x=1760116327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55ummCXHlN27uJsHHRoko5hx4ehNW7kEFeS5FsKkEGI=;
 b=OYZP2hCmkUuDlChOSALEiB17BXFi64/o7PkjEBzT0lkSej4hfyRIjh3iOaBGyO9Hzi
 4boO6P+pExexlZrPDmuJ4608L4LHx+RMv3JzpMwLRF4d4QUMIEJeikvn1QDvl/Ic+gP0
 zDTJfwkPBGEWG0xLKnoHjI8jFgZxkeo3XUHu6BRxUX2mIHuoukdAu3LbpT4Mye5L0JFA
 rIKcej3Zn2Npfpr5miF3Npcad9ydp/CvHrQZ+E7VDtRIAqJwvpTo0QlCt1FhU51AeA99
 xxERgx5gD2R8Kks+zqMw5sRVRrzwvoQmP+VweSFOv0KXS92/EYP2J3nkmy+eJtcSeoNy
 h27Q==
X-Gm-Message-State: AOJu0Yx/lewIK+eyPvYLQbyyq/kaIMLK8SU4lfvIC5v3MyRFCdFY6Bz3
 EQ25QzAr4RoMbByJWXXNa7WM4+eiDBL8k5mw907yf6sV3byctvl49URkGWj8WUxjV++CfCIiKOD
 VL6vgcx4=
X-Gm-Gg: ASbGncugEhbCGjyRKQn2eZ2q/xjIKQYkwSzEBsfYYuJQe2HYwTg5aJO+5UOEuQf/F6W
 jNmvj240Y7LTnr2WDIS+ZgskPWlUx4oCZIQrup1WYgXlCM1VK6XroYG9zqVz8/fg9AkM5rC5pNf
 521o/rk94kN6eKgxpvXHJD0pUG5mMWJge0CWYJ6qxdqdKjYfTm07ubnq8PSyPq4inuBbajYPEgW
 QBLfX7Z8x7ixSRteVhwlHo5mLY3faRh2ITdHueYJnHMHLktc8spx7mgAayqied0AnGMBmMHnKU5
 EkrMPd55dAhxKSUlZIc8jme5harZSfaN9MvYOHTiFRdLiiZv962RQjNfDhECZn3hEnh3hgOmjaR
 DJVbRuG0gAiX91mfNoUXk+bZRA/W42D5z1C2xGR6cswRdb4YS2y2LGDicm6izbZ/xRyY=
X-Google-Smtp-Source: AGHT+IGPod/MpW9mmeo2F5VGkOI38Fxme2OtNw6VnfN8Tkeq0LwZ3O51w4WkvcX7HnXUUoNqjLl4VA==
X-Received: by 2002:a05:6a00:1acd:b0:78a:f70d:b80c with SMTP id
 d2e1a72fcca58-78c98cdea76mr4583111b3a.22.1759511527082; 
 Fri, 03 Oct 2025 10:12:07 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:12:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 72/73] tests/tcg/aarch64: Add gcspushm
Date: Fri,  3 Oct 2025 10:07:59 -0700
Message-ID: <20251003170800.997167-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Validate successful and trapped executions of GCSPUSHM, GCSPOPM.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gcspushm.c      | 71 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcspushm.c

diff --git a/tests/tcg/aarch64/gcspushm.c b/tests/tcg/aarch64/gcspushm.c
new file mode 100644
index 0000000000..c330417a2f
--- /dev/null
+++ b/tests/tcg/aarch64/gcspushm.c
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+
+#define GCSPUSHM  "sys #3, c7, c7, #0, %[push]"
+#define GCSPOPM   "sysl %[pop], #3, c7, c7, #1"
+
+static void test_sigsegv(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigsegv;
+
+    __asm__("adr %0, inst_sigsegv" : "=r"(inst_sigsegv));
+    assert(uc->uc_mcontext.pc == inst_sigsegv);
+    assert(info->si_code == SEGV_CPERR);
+    /* TODO: Dig for ESR and verify syndrome. */
+    uc->uc_mcontext.pc += 4;
+}
+
+static void test_sigill(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigill;
+
+    __asm__("adr %0, inst_sigill" : "=r"(inst_sigill));
+    assert(uc->uc_mcontext.pc == inst_sigill);
+    assert(info->si_code == ILL_ILLOPC);
+    uc->uc_mcontext.pc += 4;
+}
+
+int main()
+{
+    struct sigaction sa = { .sa_flags = SA_SIGINFO };
+    uint64_t old, new;
+
+    sa.sa_sigaction = test_sigsegv;
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    sa.sa_sigaction = test_sigill;
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    /* Pushm is disabled -- SIGILL via EC_SYSTEMREGISTERTRAP */
+    asm volatile("inst_sigill:\t" GCSPUSHM
+                 : : [push] "r" (1));
+
+    enable_gcs(PR_SHADOW_STACK_PUSH);
+
+    /* Valid value -- low 2 bits clear */
+    old = 0xdeadbeeffeedcaec;
+    asm volatile(GCSPUSHM "\n\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (old)
+                 : "memory");
+    assert(old == new);
+
+    /* Invalid value -- SIGSEGV via EC_GCS */
+    asm volatile(GCSPUSHM "\n"
+                 "inst_sigsegv:\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (1)
+                 : "memory");
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 5e1b3a3385..fddb7bc9cd 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr
+GCS_TESTS += gcsstr gcspushm
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


