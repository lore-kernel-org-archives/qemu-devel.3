Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85740C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ofm-00023J-KU; Wed, 16 Sep 2026 08:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ofj-00022Y-8w
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:23:31 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ofh-0000ir-B4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:23:31 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso2255317a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789561408; x=1790166208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zl1CpNNBC64yTHdfO2MGGcHf7v3o1QsLvR0TSZIg1a8=;
 b=ZMQ2AJQaPNXXvsBkA8RKJBJ4Sb+Mu1+Ejetfyh3XyWVC0tqJxRd6Qqw8s+w9MOb037
 QtuQMGotvONv+uzIwpr1Z8m4F+bs1bWht7JaGlcPL63Hu5QH8vGGa7u8JRuT14GUjjUb
 Mo4y+EMWsP58wC67vN6ndEUVIVFH0KPxPys9ggSCR9ChxKEDQCQbB+W0GIkLUKkTEaaM
 TOTbEZKPBNQhLE0+w2df+gQNRFYootc6SdQPkwmc3hThweAKUiTydTJU2TdvzIQ+uhLR
 jy2Oy+2sW9mCrW5THkWTESxeEnOre0Lt/NWZjYbgmA1Y6yuORi5BkF1kmwaeV0pcggQK
 i9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789561408; x=1790166208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zl1CpNNBC64yTHdfO2MGGcHf7v3o1QsLvR0TSZIg1a8=;
 b=27vCdLuTvStOjNs1dRS580BG4otYErOVywN4uMXZfZf8rc9H//R8lNebdNFZq+GJap
 VT4ZLyFvS4QcYwm9Z9IzXEGYXNaYDD69+LpaYfAIKRQEZduM77JNeLewmZhDcYtdCRCb
 vlyz31KePLxrEfr5Giv0zr1hBjyAU24QZX6GXNdgJIq19bqEiQ8p2qw1raM7WEW461M8
 TUkUQskFb+d/BBr1EcMjvRrLYSN54//uatf4R/V2ouS4uL77bEErLvlyI+bka8/DSxF7
 NlOz5kaPn22iQm0wK5H6O18RdGNfY1fRPQIqTMhJH5jaMzFw81Tws6unfFemA46zXhz5
 cqHA==
X-Gm-Message-State: AFuF++l5pDHkFH4BiLQmwupaGJueaGwmOq2O9loqW/U1OrtIbncR3o6M
 4K3RwmB8jaz4J/GAsbypyF0SGaBK75hq5ll1ERr5L9fy+vS7G05i+rpViYO67cuoRuLrpclHwiO
 duCMuHz0=
X-Gm-Gg: AYBFou15rFI0amf/rV4IEU3hRaUvdMC7f4SYOCJ+0t+kBCy0OmCjy0ii59R3gRHHX72
 2RnA8sViPE4UHUk75driX263cuxdj5OP1RmprUt9zgawiCsguE/4vBcm3JFo/s/6tf+EiVGUIIA
 V0/JaZr+ZeNZ2QDxx7LbSmlKmt1RFJ6CiUqQVjDY/4DBZqnlmjQnnMcY/y7SlGU7BB7k2p86yjr
 MRdCZssLbXLt1nmTRw0sEqm0MXwY/SVTDNpOOIPnPw3Zga/VXDB7PkUwdFnsewrWYUq+2DUyvS1
 qBUvbH7/scvzg/ndCDQikn+FiSbVCmdA4RYM3yM7DAE1S4jiGqMmSNeMjRmUD0Ag3zmY8ZzK0yN
 t+OMgzdoo7jUpgHV+v3ux0PmaQrspe47dH9tEByg75s152vAXlNSTu8Y8epImM7JbC4OvtzSd0c
 4mln/bMLh0UbwU6AhuoW4njGBAcsB3J00OA+y3VTS4Ketwz4/Pp8XqdmG7nqcwTJx7FM/jqCFYc
 njuikc=
X-Received: by 2002:a17:90b:2f08:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39dfdfd409amr9252070a91.5.1789561407590; 
 Wed, 16 Sep 2026 05:23:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b0520asm8254656eec.27.2026.09.16.05.23.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:23:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/tcg/s390x: Add regression test for #4449
Date: Wed, 16 Sep 2026 02:23:22 -1000
Message-ID: <20260916122322.3224918-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916122322.3224918-1-richard.henderson@linaro.org>
References: <20260916122322.3224918-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/s390x/issue4449.c | 26 ++++++++++++++++++++++++++
 tests/tcg/s390x/meson.build |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 tests/tcg/s390x/issue4449.c

diff --git a/tests/tcg/s390x/issue4449.c b/tests/tcg/s390x/issue4449.c
new file mode 100644
index 00000000000..b2f74f9362c
--- /dev/null
+++ b/tests/tcg/s390x/issue4449.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+
+#define CASE(name, old, cst, sh)                                        \
+do {                                                                    \
+  unsigned long t1, got;                                                \
+  __asm__("lhi  %0," #cst "\n\t"   /* low 32 known, high not */         \
+          "lghi %1," #old "\n\t"   /* whole register constant */        \
+          "sllk %1,%0," #sh "\n\t" /* 32-bit write = deposit */         \
+          "brc 15,1f\n\t"          /* ends the translation block */     \
+          "nop\n"                                                       \
+          "1:"                                                          \
+          : "=r"(t1), "=r"(got) : : );                                  \
+  unsigned long want = (unsigned)(cst) << (sh);                         \
+  assert(got == want);                                                  \
+} while (0)
+
+int main()
+{
+  CASE(a, 256, 128, 1);
+  CASE(b, 128, 128, 0);
+  CASE(c, 512, 128, 2);
+  CASE(d,   2,   1, 1);
+  return 0;
+}
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index dc6271c7c73..73e1dd4aa03 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -73,6 +73,7 @@ tests += {
   'stckf.c': {},
   'ts.c': {},
   'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+  'issue4449.c': {},
 }
 
 foreach src: tests_s390x_pgm
-- 
2.53.0


