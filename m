Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA6CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yP9-0000cN-OK; Wed, 01 Oct 2025 11:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yOz-0000bK-Qm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:05:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yOl-0000cc-FJ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:05:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so5553272f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331136; x=1759935936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB6dVSAgijIf0OiELv3g9qeoA98aSmcrlxKCBFTg3Sc=;
 b=dDt+hfIMZ0sc+rZcPGKVt6HVTP4fLcsh8iDSbq/pO/XZFaezzJVGt4OQmADlPHPSFe
 w81litRMLE3YCdigViuIE8XH1T7IPJDVe4KCF8g5Z9/F+AjcL8w4eTr7w6KwNGs4U04g
 besoZBkgqcD09wcsHrjH8fQn7Yv5CWaQJNIncHHixORnkLys61t6nMKcfZ1qxMG/wrjD
 E+X3Mv0tKQk6mYYbp40y+k9oQvChHLp5g53wSCVB51u1FmK9xmlBiS5dluELabEXqGfP
 IA2iGibbTJZcwLGUp1YRtidgFVWMuRPUNfbftWZWmNZFb1bDI00DZAsFqAeyo080JjFs
 RoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331136; x=1759935936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HB6dVSAgijIf0OiELv3g9qeoA98aSmcrlxKCBFTg3Sc=;
 b=TZxSs5Vr2+UXo5vljnvgf3uxffsS5iOga9GhIo1mVFWOxyMV1UWPfYDiMd8+NfziOH
 nXBq7DFCdjX78Uj7yq9IC9fs1N/mzylYx+OKA47lPjgzz7nmulwMwO3kla5yhYDsgIvQ
 FrXKE19L8RWqAHmE5svdHopB5Jc18gOVZOACtaNXgDc76YUVjvzFlKSj0eLklmcgzDrY
 s1pLawpnxuMZ6Bh4de9Vja9hKZNQFK+vPEWe5zGLHVyuN/SkGZj6tjPDKYINwRC0M153
 v8tqDKTlHmUxiUZPmB8PBgXdXHRp5/qUVwo7jf3vRfArAl6x60Bu+KFJApeC2Ri0kurl
 4NEQ==
X-Gm-Message-State: AOJu0YzBy6Q7UdN7ZrgYKt5dRGqJdsCDDseULzC468PZEB6sA0GDP3FJ
 9xnLptTwJCtPyto8/D9b7j5ZDcDqvNbczIZCdaKyi/O3yok2Y43iMPV25AmeSfTOoA3pM4K3IAz
 ai6d8NerAwQ==
X-Gm-Gg: ASbGncvw9ZY1+1qjHi69CiROf/fqamz3qBil82FWkk1YP5zSrmpafePWBHs4bBCo+DK
 B1v2Jc7J0dKK3KkLx0jHD3H/aK0+oxyCXwblXpElSwkZPK1dCNePKsCl+2+HyY7gU0L9hyvyRHi
 iG5FBrOZCqfZlm/9/xabGxYEg/uaTae2/LcW5yNRLlgnPTLyyXqGOMJKh8vNtzuI0y906C74PJ2
 d7WlodpHwXxhOnxJgFmsX84sqnMz9djwiUGLlUMz/NgIag+tfycufYSzVvkRETwbbevFxiofnZN
 5uHGxFc8X+jS1VjIOGwnu9Wu1pO13iO1yPJwEPBiILhlFea5gf3rt1B/qGet7UwbkXgJkY4e7rd
 KjJwLnfVfzCo6nC6oh1R8wLn+BeULUQTNWtCYo6c7sDEOavwRbahgne1Qp7v/p8xTzWVSTrKhVE
 xV0a3RLWFWkoAIXJuSisHX
X-Google-Smtp-Source: AGHT+IHMeKsaMCTPkbyDKm1cHAid6xl1/LyR0T9qwd1oAigNnHGQhd446WAh/h5rHCLDc8v9yEJq4g==
X-Received: by 2002:a05:6000:4007:b0:3ec:d78d:8fcc with SMTP id
 ffacd0b85a97d-425577f01acmr3250637f8f.14.1759331136240; 
 Wed, 01 Oct 2025 08:05:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602df0sm27633907f8f.36.2025.10.01.08.05.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:05:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 01/22] system/qtest: Use &address_space_memory for first vCPU
 address space
Date: Wed,  1 Oct 2025 17:05:06 +0200
Message-ID: <20251001150529.14122-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The QTest framework implementation of the read/write[bwlq]
commands doesn't care about which address space is used.
Historically it accessed the default address space of the
first vCPU (although this is dubious since there is no vCPU
within QTest).

On all targets the first address space is &address_space_memory:

* Only ARM and X86 call cpu_address_space_init() to set an AS,
  and the index #0 is &address_space_memory:

    target/arm/cpu.h:2505:    ARMASIdx_NS = 0,
    target/arm/cpu.c:2162:    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);

    target/i386/cpu.h:2578:    X86ASIdx_MEM = 0,
    target/i386/kvm/kvm-cpu.c:102:    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
    target/i386/tcg/system/tcg-cpu.c:77:    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);

* Other targets don't call cpu_address_space_init() so default
  to &address_space_memory.

Directly use '&address_space_memory' instead of first_cpu->as.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qtest.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index fa42c9f9215..62bb9120dc7 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -16,6 +16,7 @@
 #include "system/qtest.h"
 #include "system/runstate.h"
 #include "chardev/char-fe.h"
+#include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "system/memory.h"
 #include "exec/tswap.h"
@@ -512,22 +513,22 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 1);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 2);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 4);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                 &data, 8);
         }
         qtest_send(chr, "OK\n");
@@ -545,21 +546,21 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                &data, 1);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                &data, 2);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                &data, 4);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                &value, 8);
             tswap64s(&value);
         }
@@ -579,7 +580,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(len);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
 
         enc = qemu_hexdump_line(NULL, data, len, 0, 0);
@@ -600,7 +601,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(ret == 0);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
         b64_data = g_base64_encode(data, len);
         qtest_sendf(chr, "OK %s\n", b64_data);
@@ -634,7 +635,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, data,
                             len);
         g_free(data);
 
@@ -656,7 +657,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                                 data, len);
             g_free(data);
         }
@@ -689,7 +690,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             out_len = MIN(out_len, len);
         }
 
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+        address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, data,
                             len);
 
         qtest_send(chr, "OK\n");
-- 
2.51.0


