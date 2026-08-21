Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D197C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0g-0007Cd-5o; Fri, 21 Aug 2026 07:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0c-0006oK-SZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0a-0007K2-UE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso9475535e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310119; x=1787914919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vgZGi3ojMLAhiJTCT4hqPiUIwr2tFKlpfDU4bFHaPo4=;
 b=hZ/otcIRzIwWWy3axoToUBRxIohC+bsI9CjDAfOIphCnAUeZM0eqBbUabh+TJWDEfz
 AlNNR8lq1I1Qu8UaH0y/+JOmQ1hyoh91bcQpWXjyiioQWdrHge+6uTzWW2C37dWSjYNP
 oLsB7l94hs1wKuKEMQKo1fXEjL1SeE/IPk2iVXy49vEzIvtXmDO0ZT4/tfurG/gjxhM6
 T04eJW5iptlNxhSFL01H88SLI6+nEO1CA0N7ng/9ZunFMJuKjKpu2ZFoAKiOiEz7BqoF
 EPnj/4OHuXjYE+KBVYemMeLHkNHec8NGJl/rGVvGTabMFC8LqenBTYBA0HpqZrJeppXD
 PYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310119; x=1787914919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vgZGi3ojMLAhiJTCT4hqPiUIwr2tFKlpfDU4bFHaPo4=;
 b=a9VgsoM3PHzJB+51IClEW5xefC62QL9K/ivvIpcyq7oYGajxKvRgp+rGdhlMCbLgBF
 ILjHdG0CB4VQfe0gm94Id6ymPv0NPVvYqRqbPczeVxagZSasOK7Y0wDeX6KpoYaV+vPf
 ho45iyCCz/UnoEqEsdF3SdRGFuITMoFfCLy973fqxhoEj/N6z0LJ7WaYzqXCyZevIpRi
 c7dS/hdmjRf/O+gyLee8sK+2qflvRCeg3Z+lYIjdPk0ih+vQzahTLIJAs2X5bFSEQU1j
 SyFfENOEPFHjwfZNHgUrLwGY0REUppDZ+HCFbTH8dSfjnIEiBlccnAgTI2E2m5VmxXiO
 S7cw==
X-Gm-Message-State: AOJu0Yx+BiMrxJ1Hi3yj89DynTvK2nC7zxw7q2wcB2zw5ZrRA4qCPey0
 NHyJRp/zTaZ/i7t5q5UUlPM/t+U/vwvbBxzo7/CIwebctc/sSUOlLP3SQ+t9XTEkOt9t0GPenkr
 rmW4D
X-Gm-Gg: AR+sD13x4rCfGNh02eW+3WYlP3AdhZyjSv1B0IeUn63KX4hE64xYQJ2DWso+/cj8UMu
 2D0baVInLWAhHMP79AklUnJfmXtpxzuHbxvVY3+jEfcbgv3w2PZkYcNyIwxCnOTRGRzM8yzFaaV
 B7Y9o8Ty5dV1ApjJwABcTZycUMsCZn0Na2V9Rc5Q4+CN/mZOegLUvtaWF8R1CWz4qe2Yy5dQ5dB
 OTVD0AR/KPxvET3hPizJv0Jez8fyS78urO6U9XCQIuGlgtxjJxFQFSCFnaBGR84EslQxSdvIb2n
 Nztmry9hBpco3Ys+gnJy6EHiRf4/P33T2ofvpWLc4bLhL3U5fKGDM44NfLtRocpE0YKPg3jBdsp
 YbpOyFKFTu407Nd4pEhCuHHZvO67tthJOF+5nZAMtN8eG6Q8vQJfhB0hsaIQF4mLACLOOV4KYuk
 UaCN6RrAXGll9oXH6XQvHp7VZWVve6rRYOEAf96JKkf3T2/qMTQcLF500wwTDufyrz+12XQTNXM
 McFw3ITbwpEf09khnu9JY/d4QxZsJVgdZFHNKbUL8eutKdWwEKmybFtNpekPIbsoHi6jnmF3rnJ
 pAmO
X-Received: by 2002:a05:600c:46d1:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-499b8469f20mr65569665e9.15.1787310119138; 
 Fri, 21 Aug 2026 04:01:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/43] tests/tcg/aarch64: Add regression test for
 whilewr/whilerw
Date: Fri, 21 Aug 2026 12:00:32 +0100
Message-ID: <20260821110101.3971391-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260811191540.79882-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  5 +++--
 tests/tcg/aarch64/sve-while-ptr.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-while-ptr.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 32f26892737..6cc81bf854f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -203,8 +203,9 @@ endif
 endif
 
 ifneq ($(CROSS_CC_HAS_SVE2),)
-AARCH64_TESTS += test-826
-test-826: CFLAGS += $(CROSS_CC_HAS_SVE2)
+SVE2_TESTS = test-826 sve-while-ptr
+$(SVE2_TESTS): CFLAGS += $(CROSS_CC_HAS_SVE2)
+AARCH64_TESTS += $(SVE2_TESTS)
 endif
 
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/sve-while-ptr.c b/tests/tcg/aarch64/sve-while-ptr.c
new file mode 100644
index 00000000000..7db3b9cc035
--- /dev/null
+++ b/tests/tcg/aarch64/sve-while-ptr.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* WHILEWR / WHILERW regression test */
+
+#include <sys/prctl.h>
+#include <assert.h>
+
+int main(int argc, char **argv)
+{
+    unsigned short p;
+    int set_vl_ret;
+
+    set_vl_ret = prctl(PR_SVE_SET_VL, 16, 0, 0, 0, 0);
+    assert(set_vl_ret == 16);
+
+    p = 0xdead;
+    asm("whilewr p0.s, %0, %1\n\t"
+        "str p0, [%2]"
+        : : "r"(8), "r"(11), "r"(&p) : "memory", "p0");
+    assert(p == 0x1111);
+
+    p = 0xdead;
+    asm("whilerw p0.s, %0, %1\n\t"
+        "str p0, [%2]"
+        : : "r"(8), "r"(11), "r"(&p) : "memory", "p0");
+    assert(p == 0x1111);
+
+    return 0;
+}
-- 
2.43.0


