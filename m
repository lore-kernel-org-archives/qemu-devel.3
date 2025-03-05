Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFE8C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqh-0008IG-0L; Wed, 05 Mar 2025 10:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqf-0008Hx-LQ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqd-0002IX-PW
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390eb7c1024so4144023f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189190; x=1741793990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yO8rIUYsmfpiPaEUeyghGtqZEEwY/40aLvzN2/tuA48=;
 b=nAj2LVcsLTK+CkUHNkiCy3FBLK7afKdhfynr1QOo+9kcssmLEhWwsLQaBlcAwcoodv
 aucIkh5JBA/pw4Nl36dzf3zu4Tb3l2w5t4PXv0XXHV7IlR0Dm5wIvWAQtJxyyiPfgSe0
 aN7sfhQNuBN/oSSH3qpzGIi4/kUJB8y6hoEhdtp6JnBIiATNW8KeSFypvajf0iNJtkCc
 Xw4iZgtaw2thIrkAzOCZoSSzKDivw+oT11DUh3kihzTgIfuKFxTxSxQ9otKu0l9Ow4Uf
 zsMok/Wc7GxF9NqGJdW+pXNUTCMRKGBqnoQpACw3TGAnaXalDxy8itqQMOmC+cevxprx
 fqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189190; x=1741793990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yO8rIUYsmfpiPaEUeyghGtqZEEwY/40aLvzN2/tuA48=;
 b=HtxJNeDEF6rPt2eceaBUGlSyvIYFm2MPW9IdIp+/3GnC3JTCO/0atsKNE7Wwlm2pMD
 1OWdzD/e6NJQ5fgk3JATQooWlfg8ZCSY2LmF1c/NXFz6ryIsJI0I/EhHlwjVvCfh0qwK
 gk+2q7EH/kwVYgmUio80R7dG/0cWHrmfImuXvX3A278TRqkG8SDEtcZzEHXS+cFLhgCR
 jStB7Ftw+RguTCXjqOFAl0PHtDW0pHOnvP+mEOuE+nJyBDt8g8Pdc9Ijf7d16nQRHzE+
 u1VGNOw29Ats+I8fkuBNQerMfLtQmoTUdHwnsJ5i1aRUrbeSaLS17HNIEiYBBOyIGniC
 O8SA==
X-Gm-Message-State: AOJu0Yy3W3+XHm/IcqaDnKLm306ZwwXtxtmPB6pzYI+mqQwtrMb9Fjrw
 rjB0L82ClnyPbin6Qsxwx1u/gRy0zZKlGrxK5pjJ4VCQUSscKX6INMa+AnfEJkQsLDGW0ylrRly
 rAPY=
X-Gm-Gg: ASbGncsKrBWEHVFEyaVtzMWOt6BKeNn2gzL3pmY+IxJBYLz43cAIxBpvNY3xZb+f4IA
 eusokO0lpKL6iG9PzpESic/OG0Axb72C02fEjnt/XYi/CAWvSr27F570vQnq/48nTYrLSVzrC4f
 iAFeAYUos/BSWSHedmAMoBic+PlsyxMMfCefymqIDgQ3bgyFmaCK3YbtTBpYgUswuaymbNnDett
 WQz2YTHlghqPBve0SgQ/i0VdnwIcfrEwqutwIr/u4u3CJcPfk7nUm16YM9pURpasDPh7eSEkxEv
 2rnMt9GNQ5HwYNgqmP55m6H+rcXV/Ew2u6IuTl03ZETwqMMBTSUFIlBasrBcOxcHDad+/4TdNbM
 jx6kG751N3181iJ6LuQ0=
X-Google-Smtp-Source: AGHT+IG3RVUWfz3pij+8dv7UpzBYF5BrCgJPwOUtxqW3U8p6LEMITUNUqsumhTtxxnlaJrkX4NdytQ==
X-Received: by 2002:a05:6000:186c:b0:390:f609:cbc with SMTP id
 ffacd0b85a97d-3911f7c3d13mr3569537f8f.35.1741189189912; 
 Wed, 05 Mar 2025 07:39:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6d0asm21008964f8f.27.2025.03.05.07.39.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:39:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
Date: Wed,  5 Mar 2025 16:39:14 +0100
Message-ID: <20250305153929.43687-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Introduce an API to get information specific to a binary
from the binary name (argv[0]).

Initialize it from qemu_init() on system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                       |   2 +-
 include/qemu/legacy_binary_info.h |  14 +++
 legacy_binary_info.c              | 160 ++++++++++++++++++++++++++++++
 system/vl.c                       |   2 +
 4 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/legacy_binary_info.h
 create mode 100644 legacy_binary_info.c

diff --git a/meson.build b/meson.build
index eaae1da2e92..e4ede6ba06f 100644
--- a/meson.build
+++ b/meson.build
@@ -3767,7 +3767,7 @@ if have_block
   endif
 endif
 
-common_ss.add(files('cpu-common.c'))
+common_ss.add(files('cpu-common.c', 'legacy_binary_info.c'))
 specific_ss.add(files('cpu-target.c', 'arch_info-target.c'))
 
 subdir('system')
diff --git a/include/qemu/legacy_binary_info.h b/include/qemu/legacy_binary_info.h
new file mode 100644
index 00000000000..ae67399ebf2
--- /dev/null
+++ b/include/qemu/legacy_binary_info.h
@@ -0,0 +1,14 @@
+/*
+ * QEMU legacy binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_LEGACY_BINARY_INFO_H
+#define QEMU_LEGACY_BINARY_INFO_H
+
+void legacy_binary_info_init(const char *argv0);
+
+#endif
diff --git a/legacy_binary_info.c b/legacy_binary_info.c
new file mode 100644
index 00000000000..0c50fc9248a
--- /dev/null
+++ b/legacy_binary_info.c
@@ -0,0 +1,160 @@
+/*
+ * QEMU legacy binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/arch_info.h"
+#include "qemu/legacy_binary_info.h"
+
+typedef struct LegacyBinaryInfo {
+    const char *binary_name;
+    QemuArchBit arch_bit;
+} LegacyBinaryInfo;
+
+/* List alphabetically sorted by binary_name */
+static const LegacyBinaryInfo legacy_binary_infos[] = {
+    {
+        .binary_name = "qemu-system-aarch64",
+        .arch_bit = QEMU_ARCH_BIT_ARM,
+    },
+    {
+        .binary_name = "qemu-system-alpha",
+        .arch_bit = QEMU_ARCH_BIT_ALPHA,
+    },
+    {
+        .binary_name = "qemu-system-arm",
+        .arch_bit = QEMU_ARCH_BIT_ARM,
+    },
+    {
+        .binary_name = "qemu-system-avr",
+        .arch_bit = QEMU_ARCH_BIT_AVR,
+    },
+    {
+        .binary_name = "qemu-system-hppa",
+        .arch_bit = QEMU_ARCH_BIT_HPPA,
+    },
+    {
+        .binary_name = "qemu-system-i386",
+        .arch_bit = QEMU_ARCH_BIT_I386,
+    },
+    {
+        .binary_name = "qemu-system-loongarch64",
+        .arch_bit = QEMU_ARCH_BIT_LOONGARCH,
+    },
+    {
+        .binary_name = "qemu-system-m68k",
+        .arch_bit = QEMU_ARCH_BIT_M68K,
+    },
+    {
+        .binary_name = "qemu-system-microblaze",
+        .arch_bit = QEMU_ARCH_BIT_MICROBLAZE,
+    },
+    {
+        .binary_name = "qemu-system-microblazeel",
+        .arch_bit = QEMU_ARCH_BIT_MICROBLAZE,
+    },
+    {
+        .binary_name = "qemu-system-mips",
+        .arch_bit = QEMU_ARCH_BIT_MIPS,
+    },
+    {
+        .binary_name = "qemu-system-mips64",
+        .arch_bit = QEMU_ARCH_BIT_MIPS,
+    },
+    {
+        .binary_name = "qemu-system-mips64el",
+        .arch_bit = QEMU_ARCH_BIT_MIPS,
+    },
+    {
+        .binary_name = "qemu-system-mipsel",
+        .arch_bit = QEMU_ARCH_BIT_MIPS,
+    },
+    {
+        .binary_name = "qemu-system-or1k",
+        .arch_bit = QEMU_ARCH_BIT_OPENRISC,
+    },
+    {
+        .binary_name = "qemu-system-ppc",
+        .arch_bit = QEMU_ARCH_BIT_PPC,
+    },
+    {
+        .binary_name = "qemu-system-ppc64",
+        .arch_bit = QEMU_ARCH_BIT_PPC,
+    },
+    {
+        .binary_name = "qemu-system-riscv32",
+        .arch_bit = QEMU_ARCH_BIT_RISCV,
+    },
+    {
+        .binary_name = "qemu-system-riscv64",
+        .arch_bit = QEMU_ARCH_BIT_RISCV,
+    },
+    {
+        .binary_name = "qemu-system-rx",
+        .arch_bit = QEMU_ARCH_BIT_RX,
+    },
+    {
+        .binary_name = "qemu-system-s390x",
+        .arch_bit = QEMU_ARCH_BIT_S390X,
+    },
+    {
+        .binary_name = "qemu-system-sh4",
+        .arch_bit = QEMU_ARCH_BIT_SH4,
+    },
+    {
+        .binary_name = "qemu-system-sh4eb",
+        .arch_bit = QEMU_ARCH_BIT_SH4,
+    },
+    {
+        .binary_name = "qemu-system-sparc",
+        .arch_bit = QEMU_ARCH_BIT_SPARC,
+    },
+    {
+        .binary_name = "qemu-system-sparc64",
+        .arch_bit = QEMU_ARCH_BIT_SPARC,
+    },
+    {
+        .binary_name = "qemu-system-tricore",
+        .arch_bit = QEMU_ARCH_BIT_TRICORE,
+    },
+    {
+        .binary_name = "qemu-system-x86_64",
+        .arch_bit = QEMU_ARCH_BIT_I386,
+    },
+    {
+        .binary_name = "qemu-system-xtensa",
+        .arch_bit = QEMU_ARCH_BIT_XTENSA,
+    },
+    {
+        .binary_name = "qemu-system-xtensaeb",
+        .arch_bit = QEMU_ARCH_BIT_XTENSA,
+    },
+};
+
+static int current_index = -1;
+
+void legacy_binary_info_init(const char *argv0)
+{
+    g_auto(GStrv) tokens = g_strsplit(argv0, G_DIR_SEPARATOR_S, -1);
+    unsigned count = 0;
+    const char *binary_name;
+
+    while (tokens[count]) {
+        count++;
+    }
+    assert(count > 0);
+    binary_name = tokens[count - 1];
+
+    for (size_t i = 0; i < ARRAY_SIZE(legacy_binary_infos); i++) {
+        if (!strcmp(legacy_binary_infos[i].binary_name, binary_name)) {
+            current_index = i;
+            return;
+        }
+    }
+    fprintf(stderr, "Missing legacy info for '%s' binary.\n", binary_name);
+    abort();
+}
diff --git a/system/vl.c b/system/vl.c
index a41ba4a2d5f..74a062c7fff 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,6 +28,7 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "qemu/arch_info.h"
+#include "qemu/legacy_binary_info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -2883,6 +2884,7 @@ void qemu_init(int argc, char **argv)
 
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
+    legacy_binary_info_init(argv[0]);
 
     os_setup_limits();
 
-- 
2.47.1


