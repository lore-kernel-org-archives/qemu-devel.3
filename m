Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8FDCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQje-0002lm-13; Mon, 12 Jan 2026 17:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjc-0002gR-Db
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQja-0002bh-LW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47ed9b04365so372655e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258201; x=1768863001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cos4UCipc+8S3courFEq2OGz4cGQRTYcXYO+7KekyB0=;
 b=XYafBB02E++nMvzb8J0PtAKZnosIMuPFl7dwsL1VlrNenEekjw+WssOa9KJP67N8os
 ZhrPGekVbXw4+hSFX9gg/1gQ28eRvJ2AS98RLgO06q44I6vYgPnHwF1+ZvgySV3ZHCdY
 bUwu/Ea0VzxCW2O2qIlAYJBXN2RLv2hTSAj3Zf1Fm7xGpCuBCVAq5aTrvYF/uNt6s4et
 J4jDoaNY2wks1E29s/N7Ldg+EgFhrGjljJnXHvN/Qmcz9uOM7t9xV4Lt/YJLdurZOpDx
 6nxYyptDewYf/XFeyj/B2Xh45c9D7ICsVfPNm41FqeKY/dWGpCrRAWtvdedVT1A3wqh6
 lUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258201; x=1768863001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cos4UCipc+8S3courFEq2OGz4cGQRTYcXYO+7KekyB0=;
 b=VuWi4uQiym2+bo5vtT81VC07w5eH616WH4NFpTqMAKV/fpnvX0Wlldx+ya2QXi5lKn
 8Y2OZKbE22LP8sfpRPmYyBsilZ3r/UnuB5gkCqlhiIfa2StZKGVgB6bg4z4DtJ45zhxp
 I9Dw3A5qbsr5bTPSM7v1xQk2xWn5WXlbdMTAV4nyJ853/ogfIGw1ltQXiU/9IQdUnO9x
 JUFN3Z9YqlYetdzasRCda0DKvx4QYIQAN5Nazl2YJBz6yAMh/yadlfwYVN2oqn+6Syt6
 PnAPdl/y8moCG6cjPCjTSkeIzuZQW4XF45/9sVU3Db2li08xqYgwL/+Ic1acCxiIvQgU
 +06Q==
X-Gm-Message-State: AOJu0YzrIK9cZZzcv9pq9Hyg5zfZhTARR0l87jGIMssoXbzDL6wXgwcv
 xpUdNjywdkGEKCOtBenpq59neYibu3PTuZ3KddKpx7HPKMoaB3tng1WwS3bAjTZysv34FpVRT54
 hJTlZJyU=
X-Gm-Gg: AY/fxX5nbff27glCUSfhMggdk+zDFH0GG+2PVaKdlLC1ga7GoPhehXYfrAADL25MngX
 WKqDUpImYsJ481aXvXeQswkE/t3xFN4nbt7SUFR57jC+vbATUHZJUfE+BsRSY2HP+ORhilQoBDA
 ZJJhXujdKkCAc9KmpanG6FLrBrQElg/9tFcCMtdfk1O8Il47rjMa/F+4ffoiCfC3pcYrMwmm8KO
 mzWkcA1HiT1WcHqwV7q3iy5/My20EATyI3W8KSwNiJlYGqVjqAKEMuqB2DYO0Rx7iljrpqmhxji
 is4/tNGFZJN+jBmwSxWIX/Cd8OXvGQRgwmA7y67mhIfWyp36DoC2XJlLZ0Xje8JVjOkD+pdcPUf
 QL54G3VkJJuUlFlRcSW2vC2FfNvTM2lrC5OAtBvPu+FdpavypkXx2Mn53bamiZnb5WMwLGMPbtY
 5mOAqOrnKYrkVtDTGvn1DjIT3dgqEHLSdyBP0qcWvwje8XTIIXcKEUbM+f6EVs
X-Google-Smtp-Source: AGHT+IFPCyvGbv1vQte0+TrzHHilHux6qeVXAIbwZp5ZYtmmR8kFy2ZF6E/SQ2zDW6HeGurmNRSNmg==
X-Received: by 2002:a05:600c:19c9:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47d84b18215mr251622595e9.16.1768258200602; 
 Mon, 12 Jan 2026 14:50:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41eb3bsm388849625e9.7.2026.01.12.14.49.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/61] system/ioport: Declare x86-specific I/O port in
 little-endian order
Date: Mon, 12 Jan 2026 23:48:04 +0100
Message-ID: <20260112224857.42068-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

X86 in/out port (related to ISA bus) uses little endianness:
- enforce little endianness in x86 cpu_in/out() accessors,
- serialize QTest in/out port accesses as little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-22-philmd@linaro.org>
---
 system/ioport.c               | 10 +++++-----
 tests/qtest/endianness-test.c | 10 ++++++----
 tests/qtest/libqtest.c        | 13 +++++++++----
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 801e2490c36..4b94f2f8111 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -56,7 +56,7 @@ static void unassigned_io_write(void *opaque, hwaddr addr, uint64_t val,
 const MemoryRegionOps unassigned_io_ops = {
     .read = unassigned_io_read,
     .write = unassigned_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 void cpu_outb(uint32_t addr, uint8_t val)
@@ -71,7 +71,7 @@ void cpu_outw(uint32_t addr, uint16_t val)
     uint8_t buf[2];
 
     trace_cpu_out(addr, 'w', val);
-    stw_p(buf, val);
+    stw_le_p(buf, val);
     address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
                         buf, 2);
 }
@@ -81,7 +81,7 @@ void cpu_outl(uint32_t addr, uint32_t val)
     uint8_t buf[4];
 
     trace_cpu_out(addr, 'l', val);
-    stl_p(buf, val);
+    stl_le_p(buf, val);
     address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
                         buf, 4);
 }
@@ -102,7 +102,7 @@ uint16_t cpu_inw(uint32_t addr)
     uint16_t val;
 
     address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 2);
-    val = lduw_p(buf);
+    val = lduw_le_p(buf);
     trace_cpu_in(addr, 'w', val);
     return val;
 }
@@ -113,7 +113,7 @@ uint32_t cpu_inl(uint32_t addr)
     uint32_t val;
 
     address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 4);
-    val = ldl_p(buf);
+    val = ldl_le_p(buf);
     trace_cpu_in(addr, 'l', val);
     return val;
 }
diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.c
index 222d116fae2..2b2f92099d0 100644
--- a/tests/qtest/endianness-test.c
+++ b/tests/qtest/endianness-test.c
@@ -65,8 +65,9 @@ static uint16_t isa_inw(QTestState *qts, const TestCase *test, uint16_t addr)
         value = qtest_inw(qts, addr);
     } else {
         value = qtest_readw(qts, test->isa_base + addr);
+        value = test->bswap ? bswap16(value) : value;
     }
-    return test->bswap ? bswap16(value) : value;
+    return value;
 }
 
 static uint32_t isa_inl(QTestState *qts, const TestCase *test, uint16_t addr)
@@ -76,8 +77,9 @@ static uint32_t isa_inl(QTestState *qts, const TestCase *test, uint16_t addr)
         value = qtest_inl(qts, addr);
     } else {
         value = qtest_readl(qts, test->isa_base + addr);
+        value = test->bswap ? bswap32(value) : value;
     }
-    return test->bswap ? bswap32(value) : value;
+    return value;
 }
 
 static void isa_outb(QTestState *qts, const TestCase *test, uint16_t addr,
@@ -93,10 +95,10 @@ static void isa_outb(QTestState *qts, const TestCase *test, uint16_t addr,
 static void isa_outw(QTestState *qts, const TestCase *test, uint16_t addr,
                      uint16_t value)
 {
-    value = test->bswap ? bswap16(value) : value;
     if (test->isa_base == -1) {
         qtest_outw(qts, addr, value);
     } else {
+        value = test->bswap ? bswap16(value) : value;
         qtest_writew(qts, test->isa_base + addr, value);
     }
 }
@@ -104,10 +106,10 @@ static void isa_outw(QTestState *qts, const TestCase *test, uint16_t addr,
 static void isa_outl(QTestState *qts, const TestCase *test, uint16_t addr,
                      uint32_t value)
 {
-    value = test->bswap ? bswap32(value) : value;
     if (test->isa_base == -1) {
         qtest_outl(qts, addr, value);
     } else {
+        value = test->bswap ? bswap32(value) : value;
         qtest_writel(qts, test->isa_base + addr, value);
     }
 }
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 622464e3656..132aa511375 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -31,6 +31,7 @@
 #include "libqtest.h"
 #include "libqmp.h"
 #include "qemu/accel.h"
+#include "qemu/bswap.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/exit-with-parent.h"
@@ -1190,12 +1191,12 @@ void qtest_outb(QTestState *s, uint16_t addr, uint8_t value)
 
 void qtest_outw(QTestState *s, uint16_t addr, uint16_t value)
 {
-    qtest_out(s, "outw", addr, value);
+    qtest_out(s, "outw", addr, qtest_big_endian(s) ? bswap16(value) : value);
 }
 
 void qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
 {
-    qtest_out(s, "outl", addr, value);
+    qtest_out(s, "outl", addr, qtest_big_endian(s) ? bswap32(value) : value);
 }
 
 static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
@@ -1220,12 +1221,16 @@ uint8_t qtest_inb(QTestState *s, uint16_t addr)
 
 uint16_t qtest_inw(QTestState *s, uint16_t addr)
 {
-    return qtest_in(s, "inw", addr);
+    uint16_t v = qtest_in(s, "inw", addr);
+
+    return qtest_big_endian(s) ? bswap16(v) : v;
 }
 
 uint32_t qtest_inl(QTestState *s, uint16_t addr)
 {
-    return qtest_in(s, "inl", addr);
+    uint32_t v = qtest_in(s, "inl", addr);
+
+    return qtest_big_endian(s) ? bswap32(v) : v;
 }
 
 static void qtest_write(QTestState *s, const char *cmd, uint64_t addr,
-- 
2.52.0


