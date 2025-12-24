Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BE6E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQi3-0000vg-8b; Wed, 24 Dec 2025 10:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhg-0000hk-MN
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:14 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhe-0004fC-Pc
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:08 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64b8e5d1611so7289558a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589785; x=1767194585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZ4NHo11hORfjfHpM+Tb3zuMw053OzsR0ZO7fwiMYhU=;
 b=UaiauIxfc75HdcScVi0CiRICEHNSEmiXWj0dPMCp8bowSg0VhpfsqO9vnneaNLB3jO
 MCK0XOTTVvBVDKRdY7gGzWVHVPp6STpWnwruD4GrMfyI2pmwelTMzcWMo2jpbdYYYdRb
 x7jIdPV3le4xUeGQABjYyC4NkHMZDWdANXi7Abmxp0bSf1gI8NfUEIy8TPk+YRItKaWy
 tYVTREnqwL1XVkWay8lGM96y7FXDlxAzEb3jw6p0fm3o9IYZJSRAcLkgojS8MoM4mtcb
 kK9tFX2FO2L6TuLkO1ZoOBm9vU8AkMY3OniGxIDTxU3GErXkjZhkyu2dEk+V4Q8al6oh
 cdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589785; x=1767194585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yZ4NHo11hORfjfHpM+Tb3zuMw053OzsR0ZO7fwiMYhU=;
 b=OnvqfCxyL9XjmRc9hU5oVDlEV4qW+N5Plj2aIM5g8A7r4zJY07S2ABSZ0ez/NMIH+5
 6+4+t2NRo2GGfiC5nqZ6OdhCoBnpcPuAPiNIf2H+rwHRBP/FbU1OXql/0QZwaqWkRIix
 K306LQUAaT3md7PxzyYfddlq3trfhkAtXQCdSmdHzlq8sgMXJrU0nnxlKmMEcVnXhaoP
 OPKeuXGnp5UWMBCKmWgwZcu8ei36Ycv0eb0a0pQLW0R30YnO4apkboAh+MmGt9PqQ5nc
 gdwA4bTkYct7FCLoMshbCBMAgDzREyWeQ9x8yBRBPzc1ePF5C5V38DIEU9ZQw6CfLxgo
 eXfw==
X-Gm-Message-State: AOJu0YwqbOEbB0bhjY5oyjm4BZhJgkNjK0ICWQjiEJ18FSjeOG9h8Vd+
 20O9Iw26DcAyuYZifSx51grY4nlobZ1aIJg4L4Gi1Dz2knuVa059TLYeQivju7MKKXK2XaqnVkp
 5tOAQUdY=
X-Gm-Gg: AY/fxX4tBlgE9Ryaq6AM7s2sHTtQG7/TMwuELCeEL/ni5esNe5xhI5QVCgU4yLx0k6k
 nKWmSsvOZudljBLePVwZgrp01K7Q9kVR+kqSd94JF/CvCvWzrloRAprN1d6j3HfBvOQIbRoyDR1
 zg8NwvqZ+QULaFHZdco0a0PiLl+1romK4XxJFvbsItJXWiADaq5KKioMbJW3zYE6LWDpl1UGK40
 5I2xx7fGHxSRuJ0OSpxTH33M/8fev74NWRxvIZ3eKzIWc2aAaxBt81DED1MMEOLuUFrVfVMTYJa
 51/Wq2g9lU1+HsWZS3JoeusnoZtt+WdrY6uY3+9HYLBNU6WtxqhYcrdhwZItsp2NoA5t9G1PUpn
 nFh18d6SlVQ474kUGFVSHNShY6Fd7K/Lr7tXCmw1qzlUfZaKdPjDSeeY+RtP7KzdLdUkM2kMVNh
 255aXCK/st/yLm/xk04EWaa2VZzB2jD8D8DcTQO/i5YzwQqYlYyKlBKMnzqdr2
X-Google-Smtp-Source: AGHT+IHt8HPdQPBS6hkqRrwj3NvpubshnbCXw2byM+U5UpUOAMX+KQ75NdG7YVZYVANQ2IgwwdnqTQ==
X-Received: by 2002:a17:907:1c1d:b0:b70:fd2f:6a46 with SMTP id
 a640c23a62f3a-b8036f625fbmr1807246666b.20.1766589784950; 
 Wed, 24 Dec 2025 07:23:04 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f51a74sm1823604366b.63.2025.12.24.07.23.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:23:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 05/25] system/memory: Move *ldst* headers from exec/ to
 system/ namespace
Date: Wed, 24 Dec 2025 16:21:48 +0100
Message-ID: <20251224152210.87880-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Keep all system memory APIs under the system/ namespace.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                       |  1 +
 include/system/memory.h                           |  4 ++--
 include/system/memory_cached.h                    | 10 +++++-----
 include/{exec => system}/memory_ldst.h.inc        |  0
 include/{exec => system}/memory_ldst_cached.h.inc |  0
 include/{exec => system}/memory_ldst_phys.h.inc   |  0
 6 files changed, 8 insertions(+), 7 deletions(-)
 rename include/{exec => system}/memory_ldst.h.inc (100%)
 rename include/{exec => system}/memory_ldst_cached.h.inc (100%)
 rename include/{exec => system}/memory_ldst_phys.h.inc (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c299b84d418..f984891ac2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3255,6 +3255,7 @@ S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/memory.h
+F: include/system/memory_ldst*
 F: include/system/memory_cached.h
 F: include/system/physmem.h
 F: include/system/ram_addr.h
diff --git a/include/system/memory.h b/include/system/memory.h
index 692c2f67dd3..2a966397931 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2848,13 +2848,13 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst.h.inc"
+#include "system/memory_ldst.h.inc"
 
 #ifndef TARGET_NOT_USING_LEGACY_LDST_PHYS_API
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst_phys.h.inc"
+#include "system/memory_ldst_phys.h.inc"
 #endif
 
 void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 1a07774b6ad..587e8a1453a 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -52,7 +52,7 @@ struct MemoryRegionCache {
 #define SUFFIX       _cached_slow
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
-#include "exec/memory_ldst.h.inc"
+#include "system/memory_ldst.h.inc"
 
 /* Inline fast path for direct RAM access.  */
 static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
@@ -78,18 +78,18 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
 }
 
 #define ENDIANNESS
-#include "exec/memory_ldst_cached.h.inc"
+#include "system/memory_ldst_cached.h.inc"
 
 #define ENDIANNESS   _le
-#include "exec/memory_ldst_cached.h.inc"
+#include "system/memory_ldst_cached.h.inc"
 
 #define ENDIANNESS   _be
-#include "exec/memory_ldst_cached.h.inc"
+#include "system/memory_ldst_cached.h.inc"
 
 #define SUFFIX       _cached
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
-#include "exec/memory_ldst_phys.h.inc"
+#include "system/memory_ldst_phys.h.inc"
 
 /**
  * address_space_cache_init: prepare for repeated access to a physical
diff --git a/include/exec/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
similarity index 100%
rename from include/exec/memory_ldst.h.inc
rename to include/system/memory_ldst.h.inc
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/system/memory_ldst_cached.h.inc
similarity index 100%
rename from include/exec/memory_ldst_cached.h.inc
rename to include/system/memory_ldst_cached.h.inc
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
similarity index 100%
rename from include/exec/memory_ldst_phys.h.inc
rename to include/system/memory_ldst_phys.h.inc
-- 
2.52.0


