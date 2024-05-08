Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F2FC25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNb-0002jz-My; Wed, 08 May 2024 13:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNX-0002Nm-Qc
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:56 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNV-0008NS-A3
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:55 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51f60817e34so5567041e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190411; x=1715795211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ksHT3bB/Mu2+/CUZFpNJqWT39TDBSsmRF88s5MP6rA=;
 b=O4Z48j9AVvCjFHDzDesqLZHTJsINN2l31GJkU9xbkek91JkL3+P7Tqc5oZnSurOgv0
 I7ti91Ge+zxbr31k65ZGuIYEQoNGd6CwWd9l3S/PWo57i8f1VASDQkLUbEfSe9Ngnk6d
 XMPMb7s9K9NgPgebnGd+u4w6yANQaj3bOzvNHEfp5CbnAmnc7IhqyI5LYIvNGfu9Y+ZK
 N2RvNObdTcQy2ayr8M/wYwN3yFVql/XxNzXjH+PUdB7NAvi18dIbtJYCnZo1ffEgRONH
 19wDz7cAqa1joKYHwxOBTOQmRiocGWS3NqH5oI9teetHgZrJ7SUKzji7PUaOBkcNAEbO
 058g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190411; x=1715795211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ksHT3bB/Mu2+/CUZFpNJqWT39TDBSsmRF88s5MP6rA=;
 b=i3Hu1tBO1+O3UoCAWziqvia+gG3bUoFI7GXQD2+tzai+eLBIGDUXp5zlPr+rKmWHBU
 3GD8R37pzVC6BcKDoDDgiay+Bijw6Z80AEr0fv3wg1i6vFkiAO5tEVsCTeFlvEKGChgu
 rPepF70xy9dLKthaHOdlvJJwsmvLp40tUPl20jhyBjGlVQRfRzyd/ri0Cue4wUNea9Iu
 2YTEQqYVzwSbt/0cvAxjeHiWcBOOUNdNyyxRcG4VQZ7igMy9ewpU517GCeRy8wwCGNpg
 nay6Y+Acni5RzkgrUwi4cEwyCB2sRVy+GSbND9UBFteYpxZ3Fl2wepaW2qPE5vHVp5SH
 IXVQ==
X-Gm-Message-State: AOJu0YwFPY7kEpYtBCefKbrKPJlFKMj80pigBEyPLR6BgUG2hUky8nQs
 WT6n0C9MJ7pnIWmrLJ5rhP3TFK9WV2Z9AKxoE5cNx04Na6aWHlOvLpuEurLt1NFnVCn2MVlO5Pu
 +
X-Google-Smtp-Source: AGHT+IF3DwLW/VGQCis1GT3b/8D7+Buh8NcG6JCXcSNfw3SrPAl9nHmQuI3jejdB5UUXRn9DxRVV3Q==
X-Received: by 2002:a05:6512:3b92:b0:51e:f68b:d266 with SMTP id
 2adb3069b0e04-5217cc42a62mr2596591e87.50.1715190410789; 
 Wed, 08 May 2024 10:46:50 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 q8-20020a170906a08800b00a59ce3ec763sm3925589ejy.154.2024.05.08.10.46.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/26] hw/loongarch: move memory map to boot.c
Date: Wed,  8 May 2024 19:45:02 +0200
Message-ID: <20240508174510.60470-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Ensure that it can be used even if virt.c is not included in the build, as
is the case for --without-default-devices.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240507145135.270803-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loongarch/boot.h | 10 ++++++++++
 include/hw/loongarch/virt.h | 10 ----------
 hw/loongarch/boot.c         |  3 +++
 hw/loongarch/virt.c         |  3 ---
 .gitlab-ci.d/buildtest.yml  |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 4ebcc89dcf..b3b870df1f 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -104,6 +104,16 @@ struct loongarch_boot_info {
     uint64_t a0, a1, a2;
 };
 
+extern struct memmap_entry *memmap_table;
+extern unsigned memmap_entries;
+
+struct memmap_entry {
+    uint64_t address;
+    uint64_t length;
+    uint32_t type;
+    uint32_t reserved;
+};
+
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
 
 #endif /* HW_LOONGARCH_BOOT_H */
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 4e14bf6060..fdbd2b146f 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -37,16 +37,6 @@
 
 #define FDT_BASE                0x100000
 
-extern struct memmap_entry *memmap_table;
-extern unsigned memmap_entries;
-
-struct memmap_entry {
-    uint64_t address;
-    uint64_t length;
-    uint32_t type;
-    uint32_t reserved;
-};
-
 struct LoongArchMachineState {
     /*< private >*/
     MachineState parent_obj;
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 7d1630b2e7..03f6301a77 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -15,6 +15,9 @@
 #include "sysemu/reset.h"
 #include "sysemu/qtest.h"
 
+struct memmap_entry *memmap_table;
+unsigned memmap_entries;
+
 ram_addr_t initrd_offset;
 uint64_t initrd_size;
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c0999878df..504e1fb349 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -516,9 +516,6 @@ static void virt_powerdown_req(Notifier *notifier, void *opaque)
     acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
 }
 
-struct memmap_entry *memmap_table;
-unsigned memmap_entries;
-
 static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
 {
     /* Ensure there are no duplicate entries. */
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e9402a68a7..bab6194564 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -650,7 +650,7 @@ build-tci:
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
 #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
-# does not build without boards: i386, loongarch64, s390x, sh4, sh4eb, x86_64
+# does not build without boards: i386, s390x, sh4, sh4eb, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
-- 
2.41.0


