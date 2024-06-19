Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BA5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pm-0002PG-7t; Wed, 19 Jun 2024 17:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pg-0002Ks-OI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pe-0000fw-0B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f700e4cb92so1732485ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830812; x=1719435612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pj+qvvjA1OpTR0kovCqFcBz5fTkZz/8axEDe30k10Pc=;
 b=UL6OGZ2fMqJJC7Grh+yk0myXfh+KVjBk/piJQeJQNW+wubD7fmBFzx3/KYz9QP/tX7
 CooiZy2oaCGZ3ty/gwE6OHJeIy3IApnKj9x2N9Gsl++QEV2y0tHW/J6fpJhTuwF2DaC9
 ms4XTwkm0PGWdaHY1E7hCj+jd3E6QrJbHsJWomCsaDpWnm2X84kdR0BvVY8MdHii3n9u
 IoD9MdhUFbxkaxMFM87ahJoh2fTzko+YDgAczK8hPOvfdPv1qq/ddRb1HhA0OSEmhH8b
 15bcRJsM4tBTv7TDT4wFpMwITpMOMXKdqNcgAkCMFmtz3D8A02z3WlBXtcyZD3ai+pA1
 1gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830812; x=1719435612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pj+qvvjA1OpTR0kovCqFcBz5fTkZz/8axEDe30k10Pc=;
 b=NbNSnX0tIrJq1eAGUMDAItSZi6h21o2QOx1PyMmfz1FgWGxcsyuRTcSuyrESIY5OZt
 VLoRu5ZKILpBnOdnyxvU1cDRlBR+9UE+wgNbVhBaWCGp2h2zlWyY7DPfdYoX6IgqBnRH
 JZDJ3JxrYBr0LF+6SbRYqWZUi87AnNXffDRtS9d2o0OBlFvdfzzhMVKLclgJ8RM3LXCk
 +7ICIG9jEwfIxgkx1nqUvBAAUSznWwzNuPYwiJhFcU2WnreIum+OYUB5QWPnleYZynl4
 gGFt1p9+sFVcTrYaQY5vLryikmvNdcENEXf1K8cvqh96IXvZYxJeqJbCfqXL7UcN4yM/
 K6FQ==
X-Gm-Message-State: AOJu0YxUIVYrnWrHLQubdaa8MdGdjEhUyb44lVuNb/v+zYhXpGThV2k+
 qDnuJIdmVPqzpFHZHtvir+ylgIoioaU+p17ya7Hj0fHj6bzXS00sWBg5eb2+22bwWJv3qJtXUSr
 4
X-Google-Smtp-Source: AGHT+IFgcah2rCN3TLtimsT5/zjt8zLBgGjoG3XkfSt0PFyZ3ND/Mf5wVQwQXLkKFMxqMfXelM+HMA==
X-Received: by 2002:a17:903:1cf:b0:1f6:92f1:b01c with SMTP id
 d9443c01a7336-1f9aa481248mr43110975ad.69.1718830812268; 
 Wed, 19 Jun 2024 14:00:12 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 20/24] util/bufferiszero: Add loongarch64 vector acceleration
Date: Wed, 19 Jun 2024 13:59:48 -0700
Message-Id: <20240619205952.235946-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use inline assembly because no release compiler allows
per-function selection of the ISA.

Tested-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .../loongarch64/host/bufferiszero.c.inc       | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 host/include/loongarch64/host/bufferiszero.c.inc

diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
new file mode 100644
index 0000000000..69891eac80
--- /dev/null
+++ b/host/include/loongarch64/host/bufferiszero.c.inc
@@ -0,0 +1,143 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * buffer_is_zero acceleration, loongarch64 version.
+ */
+
+/*
+ * Builtins for LSX and LASX are introduced by gcc 14 and llvm 18,
+ * but as yet neither has support for attribute target, so neither
+ * is able to enable the optimization without globally enabling
+ * vector support.  Since we want runtime detection, use assembly.
+ */
+
+static bool buffer_is_zero_lsx(const void *buf, size_t len)
+{
+    const void *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
+    const void *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16) - (7 * 16);
+    const void *l = buf + len;
+    bool ret;
+
+    asm("vld $vr0,%2,0\n\t"             /* first: buf + 0 */
+        "vld $vr1,%4,-16\n\t"           /* last: buf + len - 16 */
+        "vld $vr2,%3,0\n\t"             /* e[0] */
+        "vld $vr3,%3,16\n\t"            /* e[1] */
+        "vld $vr4,%3,32\n\t"            /* e[2] */
+        "vld $vr5,%3,48\n\t"            /* e[3] */
+        "vld $vr6,%3,64\n\t"            /* e[4] */
+        "vld $vr7,%3,80\n\t"            /* e[5] */
+        "vld $vr8,%3,96\n\t"            /* e[6] */
+        "vor.v $vr0,$vr0,$vr1\n\t"
+        "vor.v $vr2,$vr2,$vr3\n\t"
+        "vor.v $vr4,$vr4,$vr5\n\t"
+        "vor.v $vr6,$vr6,$vr7\n\t"
+        "vor.v $vr0,$vr0,$vr2\n\t"
+        "vor.v $vr4,$vr4,$vr6\n\t"
+        "vor.v $vr0,$vr0,$vr4\n\t"
+        "vor.v $vr0,$vr0,$vr8\n\t"
+        "or %0,$r0,$r0\n"               /* prepare return false */
+    "1:\n\t"
+        "vsetnez.v $fcc0,$vr0\n\t"
+        "bcnez $fcc0,2f\n\t"
+        "vld $vr0,%1,0\n\t"             /* p[0] */
+        "vld $vr1,%1,16\n\t"            /* p[1] */
+        "vld $vr2,%1,32\n\t"            /* p[2] */
+        "vld $vr3,%1,48\n\t"            /* p[3] */
+        "vld $vr4,%1,64\n\t"            /* p[4] */
+        "vld $vr5,%1,80\n\t"            /* p[5] */
+        "vld $vr6,%1,96\n\t"            /* p[6] */
+        "vld $vr7,%1,112\n\t"           /* p[7] */
+        "addi.d %1,%1,128\n\t"
+        "vor.v $vr0,$vr0,$vr1\n\t"
+        "vor.v $vr2,$vr2,$vr3\n\t"
+        "vor.v $vr4,$vr4,$vr5\n\t"
+        "vor.v $vr6,$vr6,$vr7\n\t"
+        "vor.v $vr0,$vr0,$vr2\n\t"
+        "vor.v $vr4,$vr4,$vr6\n\t"
+        "vor.v $vr0,$vr0,$vr4\n\t"
+        "bltu %1,%3,1b\n\t"
+        "vsetnez.v $fcc0,$vr0\n\t"
+        "bcnez $fcc0,2f\n\t"
+        "ori %0,$r0,1\n"
+    "2:"
+        : "=&r"(ret), "+r"(p)
+        : "r"(buf), "r"(e), "r"(l)
+        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
+
+    return ret;
+}
+
+static bool buffer_is_zero_lasx(const void *buf, size_t len)
+{
+    const void *p = QEMU_ALIGN_PTR_DOWN(buf + 32, 32);
+    const void *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 32) - (7 * 32);
+    const void *l = buf + len;
+    bool ret;
+
+    asm("xvld $xr0,%2,0\n\t"             /* first: buf + 0 */
+        "xvld $xr1,%4,-32\n\t"           /* last: buf + len - 32 */
+        "xvld $xr2,%3,0\n\t"             /* e[0] */
+        "xvld $xr3,%3,32\n\t"            /* e[1] */
+        "xvld $xr4,%3,64\n\t"            /* e[2] */
+        "xvld $xr5,%3,96\n\t"            /* e[3] */
+        "xvld $xr6,%3,128\n\t"           /* e[4] */
+        "xvld $xr7,%3,160\n\t"           /* e[5] */
+        "xvld $xr8,%3,192\n\t"           /* e[6] */
+        "xvor.v $xr0,$xr0,$xr1\n\t"
+        "xvor.v $xr2,$xr2,$xr3\n\t"
+        "xvor.v $xr4,$xr4,$xr5\n\t"
+        "xvor.v $xr6,$xr6,$xr7\n\t"
+        "xvor.v $xr0,$xr0,$xr2\n\t"
+        "xvor.v $xr4,$xr4,$xr6\n\t"
+        "xvor.v $xr0,$xr0,$xr4\n\t"
+        "xvor.v $xr0,$xr0,$xr8\n\t"
+        "or %0,$r0,$r0\n\t"              /* prepare return false */
+        "bgeu %1,%3,2f\n"
+    "1:\n\t"
+        "xvsetnez.v $fcc0,$xr0\n\t"
+        "bcnez $fcc0,3f\n\t"
+        "xvld $xr0,%1,0\n\t"             /* p[0] */
+        "xvld $xr1,%1,32\n\t"            /* p[1] */
+        "xvld $xr2,%1,64\n\t"            /* p[2] */
+        "xvld $xr3,%1,96\n\t"            /* p[3] */
+        "xvld $xr4,%1,128\n\t"           /* p[4] */
+        "xvld $xr5,%1,160\n\t"           /* p[5] */
+        "xvld $xr6,%1,192\n\t"           /* p[6] */
+        "xvld $xr7,%1,224\n\t"           /* p[7] */
+        "addi.d %1,%1,256\n\t"
+        "xvor.v $xr0,$xr0,$xr1\n\t"
+        "xvor.v $xr2,$xr2,$xr3\n\t"
+        "xvor.v $xr4,$xr4,$xr5\n\t"
+        "xvor.v $xr6,$xr6,$xr7\n\t"
+        "xvor.v $xr0,$xr0,$xr2\n\t"
+        "xvor.v $xr4,$xr4,$xr6\n\t"
+        "xvor.v $xr0,$xr0,$xr4\n\t"
+        "bltu %1,%3,1b\n"
+    "2:\n\t"
+        "xvsetnez.v $fcc0,$xr0\n\t"
+        "bcnez $fcc0,3f\n\t"
+        "ori %0,$r0,1\n"
+    "3:"
+        : "=&r"(ret), "+r"(p)
+        : "r"(buf), "r"(e), "r"(l)
+        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
+
+    return ret;
+}
+
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_is_zero_lsx,
+    buffer_is_zero_lasx,
+};
+
+static unsigned best_accel(void)
+{
+    unsigned info = cpuinfo_init();
+    if (info & CPUINFO_LASX) {
+        return 2;
+    }
+    if (info & CPUINFO_LSX) {
+        return 1;
+    }
+    return 0;
+}
-- 
2.34.1


