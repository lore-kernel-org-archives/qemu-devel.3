Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5AFC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd1B-0002Xk-B0; Tue, 04 Mar 2025 19:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0o-0002Q8-GF
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:28 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0m-0007YB-LV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:26 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso3747175f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741136002; x=1741740802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6A3P5mAjc99C3XOMrVg6RA3bQK/YWQGC1ZLsd/UtMk=;
 b=qsrNGILjoGFXNGR7uMjKc8RMCBX5SXbc8YZDIVxR1wucxksnAF2Y1tQUc7SnXX5UU4
 GxV4pWDjPNPhRCWhHYYqHFfzaUgo0NTjwDitrUdkLvV7GNYwgMDiftwlzNMqZZic03dl
 XhFECDHmWqCthMygakDqVD4Mr4VBiHYIrKi13zuuTfDuYUWMfN2cojcp7ozQE20mGN7s
 W5YuahhGRDD1YLvcGEof+duMA9aR8lLAGXpBEvKVSoa3eYGAdV3PuNVLO5UkfLVmQHRO
 QN5kMUIz4v97hIJog6hKtNpB8h8Re9dNsskpFUl52ClZehWTZMkbTcVN5Z6/Sc2ki0FA
 8k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741136002; x=1741740802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6A3P5mAjc99C3XOMrVg6RA3bQK/YWQGC1ZLsd/UtMk=;
 b=ug68RWa5pcR3nfDSQ9jCLkslxhb3lF+uXJzwLihtEhQwTGexhGGxOKY3DaaaHSiA9N
 bpod9zJJjfJh6fAYmavj1NzNEIymyCPX76+Vd4ZfyqLkXyx1Z3FZkIYAzrRwQrTHcqXQ
 TAD+zw2FmoX6ZLcuOq4uzXtTW6KymkyaEY6jKqvABEHeyEKL2o5wMe1sXmwS5pnvveAG
 KcXoF5DOhCcFddwF+FYqEaIu3UAGqXDLj12ou0BgEuYVZIbAa/SH7WFG5NNrzuTcMgwJ
 M8wdLyfAb1S9YchqW8LYKs7DQrG2pdhvMaoBCgyJn22F5VAVeKwsNLQhZxcKn+ub9Krd
 rFgw==
X-Gm-Message-State: AOJu0YxgZIimYuLBLOK0xjBms8qsd5+o/CClxuz8eLLZ3364mGMqQ0sq
 MYxSa1iec92GTmcp+ja+uv7VVuD9JPw8fM/agaM4Sm2hYnXnuhF1ExuyuaG/WI/sLDaA/nR/h16
 FE+I=
X-Gm-Gg: ASbGncv9ATtGBalF88/1ega1KUCpMnaAvWPiR6v1zp+nzxNS0xlwIflSggTJE8o6sM1
 KYGfR+ceUHYrE5Z53qcCrbeH5HDnvfT216L4Rx/2NsJ8IxG6ROMgyN4180pXtvZqFAohH+CJQcm
 eD74DxPUdg+j79DcYDZqkLsjyF1eZfUzTUjUrF8VQYKkVxPi0u9GotLXCzALqg0B5/4rFCO0A5p
 RSIBSc6GpW9GKvZ9V07huzho76Yo/te/R3K48VTttJHiqV7lKpsuZVDjxRznMqRsh9r1OuS/fxC
 QrjBIdUEeMRkgAlP2thMfOPlAAL9AlbO44W1pYST9eEwiW/9WPEnRAdu9idqG+qe01a1zfYTKnT
 wbh/LgXg097eTvmQAmKQ=
X-Google-Smtp-Source: AGHT+IE08w5IQES/o1owcvHY4sjqN42KGZBHEOYyiWwIUOgo0oVKzhkwwMtW2brFSdhD2bQ9aO5FNQ==
X-Received: by 2002:a5d:6c65:0:b0:391:d52:d042 with SMTP id
 ffacd0b85a97d-3911f76ee72mr620459f8f.32.1741136002313; 
 Tue, 04 Mar 2025 16:53:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844c0dsm18818713f8f.80.2025.03.04.16.53.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:53:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 10/11] qemu: Introduce qemu_arch_name() helper
Date: Wed,  5 Mar 2025 01:52:24 +0100
Message-ID: <20250305005225.95051-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Introduce a generic helper to get the target name of a QemuArchBit.
(This will be used for single / heterogeneous binaries).
Use it in target_name(), removing the last use of the TARGET_NAME
definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/arch_info.h |  2 ++
 arch_info-target.c       | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/qemu/arch_info.h b/include/qemu/arch_info.h
index 613dc2037db..7e3192f590f 100644
--- a/include/qemu/arch_info.h
+++ b/include/qemu/arch_info.h
@@ -46,6 +46,8 @@ typedef enum QemuArchBit {
 #define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
 #define QEMU_ARCH_ALL           -1
 
+const char *qemu_arch_name(QemuArchBit qemu_arch_bit);
+
 const char *target_name(void);
 
 bool qemu_arch_available(unsigned qemu_arch_mask);
diff --git a/arch_info-target.c b/arch_info-target.c
index 61007415b30..9b19fe8d56d 100644
--- a/arch_info-target.c
+++ b/arch_info-target.c
@@ -24,9 +24,41 @@
 #include "qemu/osdep.h"
 #include "qemu/arch_info.h"
 
+const char *qemu_arch_name(QemuArchBit qemu_arch_bit)
+{
+    static const char *legacy_target_names[] = {
+        [QEMU_ARCH_ALPHA] = "alpha",
+        [QEMU_ARCH_BIT_ARM] = TARGET_LONG_BITS == 32 ? "arm" : "aarch64",
+        [QEMU_ARCH_BIT_AVR] = "avr",
+        [QEMU_ARCH_BIT_HEXAGON] = "hexagon",
+        [QEMU_ARCH_BIT_HPPA] = "hppa",
+        [QEMU_ARCH_BIT_I386] = TARGET_LONG_BITS == 32 ? "i386" : "x86_64",
+        [QEMU_ARCH_BIT_LOONGARCH] = "loongarch64",
+        [QEMU_ARCH_BIT_M68K] = "m68k",
+        [QEMU_ARCH_BIT_MICROBLAZE] = TARGET_BIG_ENDIAN ? "microblaze"
+                                                       : "microblazeel",
+        [QEMU_ARCH_BIT_MIPS] = TARGET_BIG_ENDIAN
+                             ? (TARGET_LONG_BITS == 32 ? "mips" : "mips64")
+                             : (TARGET_LONG_BITS == 32 ? "mipsel" : "mips64el"),
+        [QEMU_ARCH_BIT_OPENRISC] = "or1k",
+        [QEMU_ARCH_BIT_PPC] = TARGET_LONG_BITS == 32 ? "ppc" : "ppc64",
+        [QEMU_ARCH_BIT_RISCV] = TARGET_LONG_BITS == 32 ? "riscv32" : "riscv64",
+        [QEMU_ARCH_BIT_RX] = "rx",
+        [QEMU_ARCH_BIT_S390X] = "s390x",
+        [QEMU_ARCH_BIT_SH4] = TARGET_BIG_ENDIAN ? "sh4eb" : "sh4",
+        [QEMU_ARCH_BIT_SPARC] = TARGET_LONG_BITS == 32 ? "sparc" : "sparc64",
+        [QEMU_ARCH_BIT_TRICORE] = "tricore",
+        [QEMU_ARCH_BIT_XTENSA] = TARGET_BIG_ENDIAN ? "xtensaeb" : "xtensa",
+    };
+
+    assert(qemu_arch_bit < ARRAY_SIZE(legacy_target_names));
+    assert(legacy_target_names[qemu_arch_bit]);
+    return legacy_target_names[qemu_arch_bit];
+}
+
 const char *target_name(void)
 {
-    return TARGET_NAME;
+    return qemu_arch_name(QEMU_ARCH_BIT);
 }
 
 bool qemu_arch_available(unsigned qemu_arch_mask)
-- 
2.47.1


