Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B11C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDj-0003w9-20; Tue, 08 Jul 2025 16:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDnh-0004iu-Gn
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:16:25 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDnd-0007Mk-6k
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:16:21 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-60c79bedc19so7421791a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002175; x=1752606975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdBIXTavtg6pNFCK5VZLNyddFa1VV1Q1VDfkVeBkEjg=;
 b=dzacxMQdeqGnAIOHtZcALSF6bW9SxQmWMdlfxoTFU7PyZbxhI59PVxKGbvzcBVGniw
 hEyhDO8+rQP21v6NMvAePYU2nbkCleUGxghIbhdMzJ8xApqhjEs6zyXRUh333H/dOatN
 OKFQhSaerBXC04z2I7+kbqrdMa3kojCCS7IAvLJoWx2fLkd/shgBy1WG4v2uUtUsfUvQ
 mYfTNOfNKzSCsN68sG+RZMI93lwDL/wz9dP/KEfotV1BhRjdSRpMOycMn2pUuA57x8fX
 F8z1l0WsoWSWYWJ07IOnwvPfs0LVeUHszVg0cjdVY200Vt3Q+zPYLfId/+YaKeBJ3U5j
 idRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002175; x=1752606975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdBIXTavtg6pNFCK5VZLNyddFa1VV1Q1VDfkVeBkEjg=;
 b=ivqHesuX8M9vg+LTxZsIjpKPG7wOLsxiXqmj1b0kMy2vO3wC/Vlgalp68PjEQ/mIH/
 XpH99c33N+xju+0S+LT809TBZMrlolPvxSbh+pEsOHtXbUNt5uak+UR3bbj0sHvkhMX0
 vtMnmrZHxfpaD7AGuCIQB6YI9w3QHw4fjvxnvHUf5Y7bzVuCIho0f5aGKuMi7UuEOep5
 WzDORejfPS0oXaVyeaaXD3f85fJYVHq/z+AnERyI7rVF9n4chwaEomQdWbCrAMQqk34y
 2I3T1RkMepWopBQlQQdDQkJpW6aCGshU0aW2aKKkCMu8wTa+4OGGYe4mtlccwJU7h2sY
 Vlvw==
X-Gm-Message-State: AOJu0YyFtkuhYfSbSBZvNtjbr6UEDXtYRcrMm/3kBCtXBHRrWxX+HYU/
 BuSjGJI7bvwgJpifv1xaAOs8KjmEOwcOtsZ5cxnC9VRC+ZdmQaPq1HBaf0Bca40VtqarK6YcpVg
 slMzG
X-Gm-Gg: ASbGncv/BXlefMrhYmqgZSzq8rg8PtR4ARuUThG++/ZSW89ycof8bRPAOFNRT+MBIol
 Bjus6QpYOBTanRlv3RvmemCRCtRPOVrYkIeCVFsmdn84yVlyBDdCV7NHN1AtEfU2sHyF3YEi6Ex
 MrAtlW0lEiO5X4I8Q5DUKtiYNDYuamghsvcJvudDnOzHssHg8mldbk9slsILPUDKqh09HCY73nL
 3JZMIlBv2clzJqerjQgFGPSkHdsc+hDDaVMAIqDy8S9vIAMRTPPtHU01MWGSbDdscrVXgInpmkY
 6aU6W9Q9x6ZTQRUMDqL86Hl5iXhYHXJx5nTH1vsPUG+eLPbF0U1t9ZuLpVeMzna5kh+zVldxdaN
 9C5mEaeeU0eecCWLtkv88KM/KjVxsMu5xpmNCBxGPYyWnMDc=
X-Google-Smtp-Source: AGHT+IFV+g34WvWk4fFmJMfbidxBMeG+bOyMg6P21RXF1+TrS4p4+WPGBBxZ3CcOWTROJtkYGu1rsw==
X-Received: by 2002:a05:600c:8b6b:b0:454:ac20:d157 with SMTP id
 5b1f17b1804b1-454b311616fmr201532255e9.30.1751995429336; 
 Tue, 08 Jul 2025 10:23:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd49379fsm27387165e9.25.2025.07.08.10.23.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 10:23:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Helge Deller <deller@gmx.de>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Xu <peterx@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH-for-10.1 v7 7/8] qemu: Declare all load/store helper in
 'qemu/bswap.h'
Date: Tue,  8 Jul 2025 19:19:47 +0200
Message-ID: <20250708171949.62500-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708171949.62500-1-philmd@linaro.org>
References: <20250708171949.62500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

Restrict "exec/tswap.h" to the tswap*() methods,
move the load/store helpers with the other ones
declared in "qemu/bswap.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tswap.h                 | 70 --------------------------
 include/qemu/bswap.h                 | 73 ++++++++++++++++++++++++++++
 include/system/memory.h              |  1 -
 include/user/abitypes.h              |  1 -
 target/ppc/mmu-hash64.h              |  2 -
 hw/acpi/bios-linker-loader.c         |  2 -
 hw/arm/allwinner-r40.c               |  1 -
 hw/arm/boot.c                        |  2 +
 hw/arm/npcm7xx.c                     |  2 +-
 hw/block/hd-geometry.c               |  1 -
 hw/char/riscv_htif.c                 |  1 -
 hw/cxl/cxl-events.c                  |  2 -
 hw/display/artist.c                  |  1 +
 hw/display/ati.c                     |  1 +
 hw/net/can/ctucan_core.c             |  1 -
 hw/net/lan9118.c                     |  1 +
 hw/net/rtl8139.c                     |  1 +
 hw/net/vmxnet3.c                     |  1 -
 hw/pci-host/gt64120.c                |  1 +
 hw/pci-host/pnv_phb3.c               |  1 +
 hw/pci-host/pnv_phb4.c               |  1 +
 hw/pci-host/ppce500.c                |  1 -
 hw/pci-host/sh_pci.c                 |  1 -
 hw/s390x/s390-pci-inst.c             |  1 +
 hw/sensor/lsm303dlhc_mag.c           |  1 -
 hw/smbios/smbios.c                   |  1 +
 hw/vfio/migration-multifd.c          |  1 -
 hw/virtio/virtio-pci.c               |  1 +
 hw/vmapple/virtio-blk.c              |  1 -
 target/arm/cpu.c                     |  1 -
 target/i386/tcg/system/excp_helper.c |  1 -
 target/i386/xsave_helper.c           |  1 -
 target/riscv/vector_helper.c         |  1 -
 tests/tcg/plugins/mem.c              |  1 +
 34 files changed, 87 insertions(+), 93 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 55ffa633598..72219e2c431 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -69,74 +69,4 @@ static inline void tswap64s(uint64_t *s)
     }
 }
 
-/* Return ld{word}_{le,be}_p following target endianness. */
-#define LOAD_IMPL(word, args...)                    \
-do {                                                \
-    if (target_big_endian()) {                      \
-        return glue(glue(ld, word), _be_p)(args);   \
-    } else {                                        \
-        return glue(glue(ld, word), _le_p)(args);   \
-    }                                               \
-} while (0)
-
-static inline int lduw_p(const void *ptr)
-{
-    LOAD_IMPL(uw, ptr);
-}
-
-static inline int ldsw_p(const void *ptr)
-{
-    LOAD_IMPL(sw, ptr);
-}
-
-static inline int ldl_p(const void *ptr)
-{
-    LOAD_IMPL(l, ptr);
-}
-
-static inline uint64_t ldq_p(const void *ptr)
-{
-    LOAD_IMPL(q, ptr);
-}
-
-static inline uint64_t ldn_p(const void *ptr, int sz)
-{
-    LOAD_IMPL(n, ptr, sz);
-}
-
-#undef LOAD_IMPL
-
-/* Call st{word}_{le,be}_p following target endianness. */
-#define STORE_IMPL(word, args...)           \
-do {                                        \
-    if (target_big_endian()) {              \
-        glue(glue(st, word), _be_p)(args);  \
-    } else {                                \
-        glue(glue(st, word), _le_p)(args);  \
-    }                                       \
-} while (0)
-
-
-static inline void stw_p(void *ptr, uint16_t v)
-{
-    STORE_IMPL(w, ptr, v);
-}
-
-static inline void stl_p(void *ptr, uint32_t v)
-{
-    STORE_IMPL(l, ptr, v);
-}
-
-static inline void stq_p(void *ptr, uint64_t v)
-{
-    STORE_IMPL(q, ptr, v);
-}
-
-static inline void stn_p(void *ptr, int sz, uint64_t v)
-{
-    STORE_IMPL(n, ptr, sz, v);
-}
-
-#undef STORE_IMPL
-
 #endif  /* TSWAP_H */
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 9a117645360..39ba64046a6 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -1,6 +1,8 @@
 #ifndef BSWAP_H
 #define BSWAP_H
 
+#include "qemu/target-info.h"
+
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
 #undef  bswap32
@@ -432,4 +434,75 @@ DO_STN_LDN_P(be)
 #undef le_bswaps
 #undef be_bswaps
 
+
+/* Return ld{word}_{le,be}_p following target endianness. */
+#define LOAD_IMPL(word, args...)                    \
+do {                                                \
+    if (target_big_endian()) {                      \
+        return glue(glue(ld, word), _be_p)(args);   \
+    } else {                                        \
+        return glue(glue(ld, word), _le_p)(args);   \
+    }                                               \
+} while (0)
+
+static inline int lduw_p(const void *ptr)
+{
+    LOAD_IMPL(uw, ptr);
+}
+
+static inline int ldsw_p(const void *ptr)
+{
+    LOAD_IMPL(sw, ptr);
+}
+
+static inline int ldl_p(const void *ptr)
+{
+    LOAD_IMPL(l, ptr);
+}
+
+static inline uint64_t ldq_p(const void *ptr)
+{
+    LOAD_IMPL(q, ptr);
+}
+
+static inline uint64_t ldn_p(const void *ptr, int sz)
+{
+    LOAD_IMPL(n, ptr, sz);
+}
+
+#undef LOAD_IMPL
+
+/* Call st{word}_{le,be}_p following target endianness. */
+#define STORE_IMPL(word, args...)           \
+do {                                        \
+    if (target_big_endian()) {              \
+        glue(glue(st, word), _be_p)(args);  \
+    } else {                                \
+        glue(glue(st, word), _le_p)(args);  \
+    }                                       \
+} while (0)
+
+
+static inline void stw_p(void *ptr, uint16_t v)
+{
+    STORE_IMPL(w, ptr, v);
+}
+
+static inline void stl_p(void *ptr, uint32_t v)
+{
+    STORE_IMPL(l, ptr, v);
+}
+
+static inline void stq_p(void *ptr, uint64_t v)
+{
+    STORE_IMPL(q, ptr, v);
+}
+
+static inline void stn_p(void *ptr, int sz, uint64_t v)
+{
+    STORE_IMPL(n, ptr, sz, v);
+}
+
+#undef STORE_IMPL
+
 #endif /* BSWAP_H */
diff --git a/include/system/memory.h b/include/system/memory.h
index 46248d4a52c..3ba34d49ba3 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -19,7 +19,6 @@
 #include "exec/memattrs.h"
 #include "exec/memop.h"
 #include "exec/ramlist.h"
-#include "exec/tswap.h"
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
diff --git a/include/user/abitypes.h b/include/user/abitypes.h
index 7528124b62f..be7a8765238 100644
--- a/include/user/abitypes.h
+++ b/include/user/abitypes.h
@@ -6,7 +6,6 @@
 #endif
 
 #include "exec/cpu-defs.h"
-#include "exec/tswap.h"
 #include "user/tswap-target.h"
 
 #ifdef TARGET_ABI32
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index b8fb12a9705..ae8d4b37aed 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -1,8 +1,6 @@
 #ifndef MMU_HASH64_H
 #define MMU_HASH64_H
 
-#include "exec/tswap.h"
-
 #ifndef CONFIG_USER_ONLY
 
 #ifdef TARGET_PPC64
diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index 108061828b1..c9ffe449aac 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -22,8 +22,6 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 
-#include "qemu/bswap.h"
-
 /*
  * Linker/loader is a paravirtualized interface that passes commands to guest.
  * The commands can be used to request guest to
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 0bf700865c2..c8eda39957c 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/boards.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index becd827af13..d391cd01bb1 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -15,6 +15,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
 #include "cpu.h"
+#include "exec/tswap.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
@@ -29,6 +30,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "qemu/bswap.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 2f30c49df55..ecfae328a96 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -24,7 +24,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "qemu/bswap.h"
+#include "exec/tswap.h"
 #include "qemu/units.h"
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index f3939e73f42..db221901cf4 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -33,7 +33,6 @@
 #include "qemu/osdep.h"
 #include "system/block-backend.h"
 #include "qapi/qapi-types-block.h"
-#include "qemu/bswap.h"
 #include "hw/block/block.h"
 #include "trace.h"
 
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index c884be5d757..a78ea9b01c0 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -29,7 +29,6 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
-#include "exec/tswap.h"
 #include "system/dma.h"
 #include "system/runstate.h"
 #include "trace.h"
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e4675..f90470930d6 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -8,8 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-
-#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/display/artist.c b/hw/display/artist.c
index 3fafc8a222b..3c884c92437 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -12,6 +12,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/loader.h"
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 7de27732cdc..f7c0006a879 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -22,6 +22,7 @@
 #include "vga-access.h"
 #include "hw/qdev-properties.h"
 #include "vga_regs.h"
+#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index 17131a4e18f..6bd99c477b2 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -28,7 +28,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 6dda1e5c940..3017e129710 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -21,6 +21,7 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include <zlib.h> /* for crc32 */
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 654a087d80a..324fb932aac 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -57,6 +57,7 @@
 #include "system/dma.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "qemu/bswap.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "system/system.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 7c0ca56b7c0..af73aa8ef28 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -22,7 +22,6 @@
 #include "net/tap.h"
 #include "net/checksum.h"
 #include "system/system.h"
-#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/pci/msix.h"
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index b12a25696c4..b1d96f62fe9 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
+#include "qemu/bswap.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index a4335f44f22..5d8383fac30 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -8,6 +8,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "hw/pci-host/pnv_phb3_regs.h"
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 77ea35299d3..18992054e83 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -8,6 +8,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 52269b05bb1..975d191ccb8 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -20,7 +20,6 @@
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
-#include "qemu/bswap.h"
 #include "hw/pci-host/ppce500.h"
 #include "qom/object.h"
 
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index de8f6a84aab..62fb945075f 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -28,7 +28,6 @@
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
-#include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b5dddb22b84..a3bb5aa2216 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -16,6 +16,7 @@
 #include "exec/target_page.h"
 #include "system/memory.h"
 #include "qemu/error-report.h"
+#include "qemu/bswap.h"
 #include "system/hw_accel.h"
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index f9e501da840..cd5773ae64e 100644
--- a/hw/sensor/lsm303dlhc_mag.c
+++ b/hw/sensor/lsm303dlhc_mag.c
@@ -28,7 +28,6 @@
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "qemu/bswap.h"
 
 enum LSM303DLHCMagReg {
     LSM303DLHC_MAG_REG_CRA          = 0x00,
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index ad4cd6721e6..1ac063cfb4b 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 850a3194887..69e57833dbd 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -13,7 +13,6 @@
 #include "hw/vfio/vfio-device.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
-#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fba2372c93b..767216d7959 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bswap.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 532b5649ab7..9de9aaae0bf 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -19,7 +19,6 @@
 #include "hw/vmapple/vmapple.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-pci.h"
-#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ebac86f70d3..baaa13aed6d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,7 +23,6 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
-#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index c1626215877..50040f6fcaf 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -25,7 +25,6 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
-#include "exec/tswap.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 24ab7be8e9a..996e9f3bfef 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -5,7 +5,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/tswap.h"
 
 void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b41c29da0be..7c67d67a13f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -27,7 +27,6 @@
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "exec/target_page.h"
-#include "exec/tswap.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index ca4e8883dd2..9649bce99ca 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -20,6 +20,7 @@
  * few things provided by compiler.h.
  */
 #include <compiler.h>
+#include <stdbool.h>
 #include <bswap.h>
 #include <qemu-plugin.h>
 
-- 
2.49.0


