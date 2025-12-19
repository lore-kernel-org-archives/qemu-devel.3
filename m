Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C1FD7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdDg-0006iD-PQ; Fri, 19 Dec 2025 11:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDf-0006Z1-BX
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDd-00060J-B7
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so12926025e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161239; x=1766766039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NIAoPJvrGX1p+tc7Ww/oBPK652DA3zeYsmkIjYDpeM=;
 b=BicJdVUVTGJjLa0jb+d86SFC54gEkQfd2YtzLz/TB+dXQFM61tY0nfEL/IlgU2cZJR
 2J2rE6xKmozD3U8SAMCfmBm+YCF1kqPLzNFF/y2IRi0KkofvG6JuPjdVI+wpbv7asvd3
 +UPqCSjdZ8cKN9brsa511j8OG/tC/D63RoekoVocIZBISgVeaoXeqbLwCndMAcep2m8a
 4hB0o7UXpDnaaMYsXGwQwrGVIN+MhP7y2+4sVilm8EZPRSd+BlvZymW9FPsJVNnq+Yti
 /SaK/aFuxqzyXHXzSgRSXSedQEjJeMCxxFbmeT92fYZRHIBN2+Qi5UFao4s4yxXeufIg
 6xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161239; x=1766766039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0NIAoPJvrGX1p+tc7Ww/oBPK652DA3zeYsmkIjYDpeM=;
 b=Hpf0bT3JJ0p17I/HFAUm4dgQRYrB93vgEvrlc03/zY+qZf006Mc1UjrlGxt/tT4fav
 FZdh4UvWg/r0dzbzLzCEiA3zG/qnd3SZdD6tbVu8q001LdCgj06bzZsPvw9fh4ZMKDtN
 GZlhoGHlhR4uHCCe4TOOjdj7RqByTc1PJqM+UkZqkobgY3tSunEVWvLptXmE1VEC5tLP
 tf2YERihUDiKef6533/RlSmqLOkN3SBkLbg6nMf4fQJIKt1pCgzjM8apFSwa4LyoSsRF
 UjC7gj+Yklnh0tdFowTZLvsjeygTPN+glKbgnvYVYcBiIv8KmU0nhtH6yuTgmUOAJk9w
 rbwA==
X-Gm-Message-State: AOJu0YyZOhnlnfBYg4tgkvkh01A06Ap0YOlAXWEQLpxpNP1kweiUglBT
 buCI4kjATfKEIo6euTrwuj6SsSzGHp53MRv/zPGpv5y4PyPI9bkZPS1HCwf6nmHrK4xRWCzUbBS
 RvweRyP4=
X-Gm-Gg: AY/fxX7azMZ33nB1CYCklX4EPeWQP6ZOvcMNA0g314RAInDNEJ/OJnbZ7kWTgaSxdg+
 E2R/Qk1zoLecU0IYxG2gc/BkeVQmwg1RVvIMrrNruEWLiRjEjQKkzP+f3vIQtHXJhozmcamx9mW
 A5hTh3H8pERua4SpZcac6+v2WunGRAyseRNkeorDOTfjK7EdNeIT9iiQs/Pb8i4sP+FA8INKakQ
 FNWYOrN/ZNl/fnG7YfmZw4C2PCEYl7rt93BrSt7C/WxUZFtvRmRskqhORub46WWAgzGC4kMB2zt
 buRt948cbszbb7TSb2lVZ2LZTy9dZRgcTnIBA0sj2PENAocWw+Y4VBCGzLl2x8rilCrhcUAgtIO
 xuHIqDsPVGYsYMBooAtgne8xA1NEKFiEtGJdUuvUs+Nr5XTzM0S/vhfOIZ5PAEhMPksID1UqRx1
 xtLaWNnaFIFxNlwjCDYR9MAb+KZSxBGx1g0zUvEj3gZ/v1DmdOK72oiWtNebfp
X-Google-Smtp-Source: AGHT+IFlUymaAKn0CkmKPYvUeb95/nx5pNl0MqB/urDVVfkMZLustvzWWwDnHzMDQPca0xyl8VscUA==
X-Received: by 2002:a7b:ca4a:0:b0:477:75b4:d2d1 with SMTP id
 5b1f17b1804b1-47be29f3835mr50926095e9.15.1766161239336; 
 Fri, 19 Dec 2025 08:20:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm102418435e9.8.2025.12.19.08.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/24] system/memory: Move *ldst* headers from exec/ to
 system/ namespace
Date: Fri, 19 Dec 2025 17:19:33 +0100
Message-ID: <20251219161953.72724-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
index 90f375df5df..8043d295334 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2848,12 +2848,12 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst.h.inc"
+#include "system/memory_ldst.h.inc"
 
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst_phys.h.inc"
+#include "system/memory_ldst_phys.h.inc"
 
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


