Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE87E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQkc-0000pZ-Us; Wed, 24 Dec 2025 10:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQka-0000XC-77
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:26:08 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQkY-0005G5-9d
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:26:07 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8018eba13cso843699066b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589964; x=1767194764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dy6/NslyxJqRDTVGf5fd5Uvb/GCGYxxTwE0EkQ6kp1o=;
 b=G8bFoBvwiWhK/fD112TOmPnpXMLr/mn5g2LtNSnzvE2E6kghcXQq15uSQdhHVnE3/e
 jAbWkV083WpghONTsj7qUchfU9aMScnHUOOH8CB5FFib2X2HguchkZdNCjbGFvFjP/ua
 D4lB82K8hAo7bUhs7gCmvS6CkZ6Tbpy/eDdLzcoCpkwo9LMVKWumw8ak89M1IjdcOzYa
 qIMo/WS33UdSCLSImTtiUJWxYaYJ+aa2LRID/Al4CUm0mwxdEsjN9+HSuKrbhGVg0auX
 sAe/EQTQ7/GUU1/gUZhrXPGfOv0Q/uv7peUduP/9bopjWKfZbNjg50G/uwb7FYWehqf2
 gQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589964; x=1767194764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dy6/NslyxJqRDTVGf5fd5Uvb/GCGYxxTwE0EkQ6kp1o=;
 b=YZd34eT70rsU6o64R2r+CGZ2vJEs1uJwjnMed0BX8vRmQ+odV12ZsWxQLJEYtn9NAa
 jvf3jLCPLEdg2OIW3eO2h4OOmfJNbsX0jULpsSgJSy++g8Y8DDgSl8CodNLInwxrAZJP
 Q2i6d6mtf+cKCtubsstimWnol09qUhBaq9o4CWEN6pt6dl+vTLmtrSdwXVfC+5Uzy55E
 +zkg1n0nCSNkgRfCgO9uF1JLyeoqiwIxf5qe1LxtEaTm81mGIVdoqv4jewDuXeLmOgOf
 CTXx6NlQUJpqxZPaZuNcUACCtit/QJbugmpswqlQRKCbxT2Ab6ixoHGN6+TxU3UU9Pvk
 djYg==
X-Gm-Message-State: AOJu0YyJjQ+kAmGcQ2cb8lM8m9dfPQ1IDHkqOr6PunjXr4uAMrpzArn1
 9Rh2AueMufOVoEaGtfi/wBwyC2zQg3FslIY891rPvmbDH6FJEq8fIJFdtBAE2LbKPnAN/qmaSEq
 vuYl4xr0=
X-Gm-Gg: AY/fxX4D3t7aY2BYmWn71NDdWxlF0lUMJ3HdDCe92atSM9IIQh5Amx4yzHXPGGJDUtp
 lpHRwTx8EZe8WBaBoC5jxoFVdrIxuiWPWDKttXQYBMURMy1BkuFS/eJfy/5FeOf1YpLTqPnYfaU
 TSlx03mtV4FDzt2c8K8ydbvWLNgXV3LFfD6WITTm+AyAwqXjbVYk5k/e54qOOVbNfjfEP4TKbos
 QBjA18+lP08cwDUeT0FJZYv4tDmh6ET5Y6qy1zw4b1YhaenWkGBRnYlJIIzwYE6kk/kolSRIQgv
 hV0O3cwwKQ8/O3ZtUbFhA8dssu1F9/lbkwVhRcSqjA4mufrM3/R2NRS9C2A/ZfM5AIT4+u45zZ0
 d1JVvrwlGVQ0iUvRwsqM/HXH3aMmltl+x3fSoHaF16hFFjpn0QUBhLIIQc7U3qFylYC92iY3GCp
 +2e4qLSwG9FTSJtqjWkf8G/IcGDoHyIB1tvwrqkF+4NQePPe0/L6JM87w=
X-Google-Smtp-Source: AGHT+IHxwwBYhJsuxjucfTRtDi1OzVw9yyqXlo5ViKDFqq6PVVZTXEn+aTNJeYFIZANbWyz1N2RmeA==
X-Received: by 2002:a17:907:3fa2:b0:b72:5fac:d05a with SMTP id
 a640c23a62f3a-b80371790a3mr1888464166b.37.1766589964200; 
 Wed, 24 Dec 2025 07:26:04 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5c4dfsm1788823966b.14.2025.12.24.07.26.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:26:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 24/25] system/ioport: Declare x86-specific I/O port in
 little-endian order
Date: Wed, 24 Dec 2025 16:22:07 +0100
Message-ID: <20251224152210.87880-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

X86 in/out port (related to ISA bus) uses little endianness:
- enforce little endianness in x86 cpu_in/out() accessors,
- serialize QTest in/out port accesses as little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/ioport.c               | 10 +++++-----
 tests/qtest/endianness-test.c | 10 ++++++----
 tests/qtest/libqtest.c        | 13 +++++++++----
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 4f96e9119fc..35ad256c940 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -55,7 +55,7 @@ static void unassigned_io_write(void *opaque, hwaddr addr, uint64_t val,
 const MemoryRegionOps unassigned_io_ops = {
     .read = unassigned_io_read,
     .write = unassigned_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 void cpu_outb(uint32_t addr, uint8_t val)
@@ -70,7 +70,7 @@ void cpu_outw(uint32_t addr, uint16_t val)
     uint8_t buf[2];
 
     trace_cpu_out(addr, 'w', val);
-    stw_p(buf, val);
+    stw_le_p(buf, val);
     address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
                         buf, 2);
 }
@@ -80,7 +80,7 @@ void cpu_outl(uint32_t addr, uint32_t val)
     uint8_t buf[4];
 
     trace_cpu_out(addr, 'l', val);
-    stl_p(buf, val);
+    stl_le_p(buf, val);
     address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
                         buf, 4);
 }
@@ -101,7 +101,7 @@ uint16_t cpu_inw(uint32_t addr)
     uint16_t val;
 
     address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 2);
-    val = lduw_p(buf);
+    val = lduw_le_p(buf);
     trace_cpu_in(addr, 'w', val);
     return val;
 }
@@ -112,7 +112,7 @@ uint32_t cpu_inl(uint32_t addr)
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


