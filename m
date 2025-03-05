Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5464FC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqn-0008JP-4K; Wed, 05 Mar 2025 10:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqql-0008Iy-2h
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqj-0002J4-3b
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:58 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso4215623f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189195; x=1741793995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xkVi+fM9u6NjYnvimRvSzA5d9mqak031ohahGjE3Qo=;
 b=TxXzzWx8WOIOlW2iEpgxcouBu0Xx8uHS5KKZbY5o6SME5u3OjNvUL8eA1POAn4ifJ6
 4qQVpbNqdI6hgyXCILIGbq9ZuI4SR+eDHphPFNoTt2pFyAicX8DUKd/CP15aoJQXQRL0
 2plfWgb1RmTSX61qbIJHMzbQGFdJSJjL+CA7jXYcdLNPALFHK/EwXQZirr3NcKUekk4q
 KAyTe+34XqtTSHBXQrLHr+PZpWq8WNgl5KD/taRLi/ub4Wj1eOVOjC+KS8djET1iiFB6
 aUbKQZ874IoDkQnZEFRpPoGC8ot3caRhmDDOnfZQCDF306qb+YR19TIsb/Lv9somfK5u
 QzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189195; x=1741793995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xkVi+fM9u6NjYnvimRvSzA5d9mqak031ohahGjE3Qo=;
 b=nJkzNloKRF866aZNwl6bGDUDc3MgnZF6rOSojPyOOUMepKplgfuupcid1mbhVLuwN3
 iiu2iw8jgeuFxOJ5uKzpBJYcQ0HlYJYweRaIsBB061/aevrMm0/k0/QDbgfEfz4Z/vTr
 FOGp1zAgSLZ+DOCZBqQKvdg3YIe/mfZPoKRYJeqI1ACF/6rD8PdeWWeVQT+/TRdp+vom
 9OyKfB3UFwfgVGLoZWpUfWRLKjQ8uTHsoTEZfOgAmxXlBMpwES2R7+tKMOIXt9DwNefl
 kVVRMfxycJzfXf/vZCAV6+cKhPAKbLoLkaa5ZGoyiZlTouQXlFaDVMCQA6Yycj/ZyCPl
 fe0w==
X-Gm-Message-State: AOJu0YzsK4U6uFc7uOZWL7+XtpkGBfpBmmoD8G51DA/D8DCMgIXOp8g9
 7nHOD9OlX4Sgx9UY0oQWcH3LmJlDN2IPnFrQ3c1inL7C7TYeNo6W60orFgAdQmKnmTO+1p5MLc+
 1nBk=
X-Gm-Gg: ASbGncsLFgMg7natPsRx6dlGRPU4/YqlhHiX8mFM3JuvB9o2WgAAAon4bmx+il4oX+r
 +UAqxtK3fvk+qJzT++SWvFl5X+wWYAhPj2ishhlhzoey+5+liPYmTQKW2grpTeUJZVOMGy5N8co
 wRYAUjmVgiqLqfiMWpO1ihu0ejKYA5eX5/6B0Cajd7HuJ/G6xe5gqbUFNUaroCreWRWlYkBbJRY
 yZz9XOrxxdd4D3JaWemibsWKMyOMqYH4TOJoRRJ+9Z4BvxBRCr0pi+P4QAjZ7hRJn237XOrDHTu
 03n2JOsMZO8kKKVYztF9E8JRzR+hr3/QlvVnB541PJQCKcyeuKCP+2upvQcr72qzHkZcgRBB5x6
 cYhXJpvsybGbRjmEWmto=
X-Google-Smtp-Source: AGHT+IH2SNSYu1go+vMvptDDaHOCOikxea34irNUz8kMS5JlxACZU665AtGU83pq/RQohXFrBz531Q==
X-Received: by 2002:a05:6000:1aca:b0:390:d954:5e7c with SMTP id
 ffacd0b85a97d-3911f7c3d08mr3752352f8f.38.1741189194743; 
 Wed, 05 Mar 2025 07:39:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7b6asm21845512f8f.51.2025.03.05.07.39.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:39:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 05/18] qemu: Introduce legacy_binary_is_64bit() helper
Date: Wed,  5 Mar 2025 16:39:15 +0100
Message-ID: <20250305153929.43687-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Introduce legacy_binary_is_64bit() to check at runtime if
a binary is compiled with TARGET_LONG_BITS == 64.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/legacy_binary_info.h |  3 +++
 legacy_binary_info.c              | 37 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/qemu/legacy_binary_info.h b/include/qemu/legacy_binary_info.h
index ae67399ebf2..2d42e852b7a 100644
--- a/include/qemu/legacy_binary_info.h
+++ b/include/qemu/legacy_binary_info.h
@@ -11,4 +11,7 @@
 
 void legacy_binary_info_init(const char *argv0);
 
+/* Return runtime equivalent of TARGET_LONG_BITS == 64 check */
+bool legacy_binary_is_64bit(void);
+
 #endif
diff --git a/legacy_binary_info.c b/legacy_binary_info.c
index 0c50fc9248a..be50d3f50ea 100644
--- a/legacy_binary_info.c
+++ b/legacy_binary_info.c
@@ -13,6 +13,7 @@
 typedef struct LegacyBinaryInfo {
     const char *binary_name;
     QemuArchBit arch_bit;
+    unsigned long_bits;
 } LegacyBinaryInfo;
 
 /* List alphabetically sorted by binary_name */
@@ -20,118 +21,147 @@ static const LegacyBinaryInfo legacy_binary_infos[] = {
     {
         .binary_name = "qemu-system-aarch64",
         .arch_bit = QEMU_ARCH_BIT_ARM,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-alpha",
         .arch_bit = QEMU_ARCH_BIT_ALPHA,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-arm",
         .arch_bit = QEMU_ARCH_BIT_ARM,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-avr",
         .arch_bit = QEMU_ARCH_BIT_AVR,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-hppa",
         .arch_bit = QEMU_ARCH_BIT_HPPA,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-i386",
         .arch_bit = QEMU_ARCH_BIT_I386,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-loongarch64",
         .arch_bit = QEMU_ARCH_BIT_LOONGARCH,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-m68k",
         .arch_bit = QEMU_ARCH_BIT_M68K,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-microblaze",
         .arch_bit = QEMU_ARCH_BIT_MICROBLAZE,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-microblazeel",
         .arch_bit = QEMU_ARCH_BIT_MICROBLAZE,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mips",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mips64",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mips64el",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-mipsel",
         .arch_bit = QEMU_ARCH_BIT_MIPS,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-or1k",
         .arch_bit = QEMU_ARCH_BIT_OPENRISC,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-ppc",
         .arch_bit = QEMU_ARCH_BIT_PPC,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-ppc64",
         .arch_bit = QEMU_ARCH_BIT_PPC,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-riscv32",
         .arch_bit = QEMU_ARCH_BIT_RISCV,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-riscv64",
         .arch_bit = QEMU_ARCH_BIT_RISCV,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-rx",
         .arch_bit = QEMU_ARCH_BIT_RX,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-s390x",
         .arch_bit = QEMU_ARCH_BIT_S390X,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-sh4",
         .arch_bit = QEMU_ARCH_BIT_SH4,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-sh4eb",
         .arch_bit = QEMU_ARCH_BIT_SH4,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-sparc",
         .arch_bit = QEMU_ARCH_BIT_SPARC,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-sparc64",
         .arch_bit = QEMU_ARCH_BIT_SPARC,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-tricore",
         .arch_bit = QEMU_ARCH_BIT_TRICORE,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-x86_64",
         .arch_bit = QEMU_ARCH_BIT_I386,
+        .long_bits = 64,
     },
     {
         .binary_name = "qemu-system-xtensa",
         .arch_bit = QEMU_ARCH_BIT_XTENSA,
+        .long_bits = 32,
     },
     {
         .binary_name = "qemu-system-xtensaeb",
         .arch_bit = QEMU_ARCH_BIT_XTENSA,
+        .long_bits = 32,
     },
 };
 
@@ -151,6 +181,7 @@ void legacy_binary_info_init(const char *argv0)
 
     for (size_t i = 0; i < ARRAY_SIZE(legacy_binary_infos); i++) {
         if (!strcmp(legacy_binary_infos[i].binary_name, binary_name)) {
+            assert(legacy_binary_infos[i].long_bits);
             current_index = i;
             return;
         }
@@ -158,3 +189,9 @@ void legacy_binary_info_init(const char *argv0)
     fprintf(stderr, "Missing legacy info for '%s' binary.\n", binary_name);
     abort();
 }
+
+bool legacy_binary_is_64bit(void)
+{
+    assert(current_index != -1);
+    return legacy_binary_infos[current_index].long_bits == 64;
+}
-- 
2.47.1


