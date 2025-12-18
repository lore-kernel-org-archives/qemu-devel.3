Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA50D711C4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLYO-0001KG-4A; Thu, 18 Dec 2025 16:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLYM-0001Jb-U5
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLYL-0007So-3U
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:28:54 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so7703705e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093331; x=1766698131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvmQqDTuAn2+vm7yu5oXpG7v42LAWlpVJ2+BBQOBjKY=;
 b=QBbOZeLu5SedtKezVCxynAP0n8Fp6lScACY07KouEiI424U84qFpiYPnwjMmW+YGTO
 NSg66EI0zvd8cAD4fEioVN2/Tdq+SeUzPSahihVsMBhgkBSkYLq7pylg7fat+VcwY/9F
 eMY/CZROK7b3lYJnmOcJRqEa7bl00AzyBKmCftDlnMu5pmg9EeZSMToO+F6kHopnberU
 QWc6GJlDLLXk4t5/8Z39rMcKIiObulqeJ0hWGlmL4/xCUifGkn684sxtU7u61z2O8PoB
 GG+BkUYe2guIEG4UVBvMn8Q4tc+2YaD5lYop5GnYj3ZE538Du25Q05oJMsEVM/zJPjRs
 wOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093331; x=1766698131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zvmQqDTuAn2+vm7yu5oXpG7v42LAWlpVJ2+BBQOBjKY=;
 b=A77jH7Nd3pzYLjzomlK+ReRmz8+tipWW/O0jbz2+EEi3CrVzd1OHvoC8DB/ek0ZicR
 OGRHDYCifpxIrxUelxFgPf7XjiFOalU5633liVwXwNjCSSiHuom6dXuGPaboy3uR41+z
 qS8HPVkvCvitzgOT4PJRgOqyb2Gfk7Dc6Ie7AAWaq7ilIxhr3y58qqM+g635q6wpsaif
 nz3vqGPuSmrF9fcfuY2mlnva5OAZovnzLEDjlYZJF84A5XKuzApjThdpy1pdjlMH9IMR
 TbFOayKFx+ra+1N/GEiSGHVMOAgtFclELCv+vqet0bL6zMAD4QGKlKd0ytQKRbU1sxJY
 F0tA==
X-Gm-Message-State: AOJu0YxWJHzonAVMx+BpMLyNn/UlGCiF2EsmlqvK2KTbukyzqpV9kqxB
 xZIsRaE91dLCJzBi9PPWOLMF/wju//tMIpPiPo0QT3vB+yf9L53mM5CyBPgxnRz3XyD7FUyBqgv
 y3M3yEFg=
X-Gm-Gg: AY/fxX6bnJy/oPhYj+w++Kgiy11ntrfdwDPHm4UoP+9RgFcTqSGzBhZHLozU3cla9Gx
 tPkadepzaepNIi8ZHeVy7ZGWcMRn/EuC5L4m01RZfnbRPEoQj8arvSq7PVqjqrV73bMEm6gdOu6
 KxSHVi4508GifSLeDw/G4wRQByBBC6s9EZuSABeWt7eMPaIzdM4fYscgdAfP/1Eo3lozee67+sL
 q4Db+XnjAiFykKQuwCf4kvKliYq9p1HLEfC7hfyKemdEuQuenTSbzq6cbBHv62gQToARVcgAfGe
 RB4jKnyVzSH87TonYXblfBZosLzkA3V9Ph6JCydPMIYOWh8k3eoFz+M90UZG78kadsSv77FfNuo
 oI1IkxZ//9J8UUi4p1Qy4qUN+MheQgZk0PLGpE8dlp0OTgM/QEiovOmh5Fl/SRjfiuYm45tTqeu
 q7yhUQ8RBKJIcjC4vj52aDlUZWeKUO50I/NI4/XMQKpnc767Tl9fGr12UHKSpr
X-Google-Smtp-Source: AGHT+IFTMqJ5n8E+yTdI9QjvfQGN80DnPSmLhCTv7+gaDKHYwnuCV//STQ3yodAihc6k9TwmPL9Atg==
X-Received: by 2002:a05:600c:8710:b0:475:da13:2568 with SMTP id
 5b1f17b1804b1-47d19592102mr5135165e9.25.1766093331125; 
 Thu, 18 Dec 2025 13:28:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm1047786f8f.10.2025.12.18.13.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:28:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 4/4] system/memory: Restrict legacy 'native-endian' APIs
Date: Thu, 18 Dec 2025 22:28:14 +0100
Message-ID: <20251218212814.61445-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218212814.61445-1-philmd@linaro.org>
References: <20251218212814.61445-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h        | 2 ++
 include/exec/translator.h           | 2 +-
 include/qemu/bswap.h                | 5 +++++
 include/system/memory_cached.h      | 2 ++
 system/memory-internal.h            | 2 ++
 include/exec/memory_ldst.h.inc      | 2 ++
 include/exec/memory_ldst_phys.h.inc | 2 ++
 system/memory_ldst.c.inc            | 2 ++
 8 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..91b618c2f41 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,6 +428,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -501,5 +502,6 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 3c326555696..30e6596c5d7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -188,7 +188,7 @@ uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
 uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
                             vaddr pc, MemOp endian);
 
-#ifdef COMPILING_PER_TARGET
+#if defined(TARGET_USE_LEGACY_NATIVE_ENDIAN_API) && defined(COMPILING_PER_TARGET)
 static inline uint16_t
 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 65a1b3634f4..8b0070d26a6 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -412,7 +412,9 @@ static inline void stq_be_p(void *ptr, uint64_t v)
         }                                                               \
     }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 DO_STN_LDN_P(he)
+#endif
 DO_STN_LDN_P(le)
 DO_STN_LDN_P(be)
 
@@ -423,6 +425,7 @@ DO_STN_LDN_P(be)
 #undef le_bswaps
 #undef be_bswaps
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 
 /* Return ld{word}_{le,be}_p following target endianness. */
 #define LOAD_IMPL(word, args...)                    \
@@ -494,4 +497,6 @@ static inline void stn_p(void *ptr, int sz, uint64_t v)
 
 #undef STORE_IMPL
 
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
+
 #endif /* BSWAP_H */
diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 1a07774b6ad..356023f5729 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -77,8 +77,10 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "exec/memory_ldst_cached.h.inc"
+#endif
 
 #define ENDIANNESS   _le
 #include "exec/memory_ldst_cached.h.inc"
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e4..d781d437642 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -41,9 +41,11 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
 {
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
     if (end == DEVICE_NATIVE_ENDIAN) {
         return target_big_endian();
     }
+#endif
     return end == DEVICE_BIG_ENDIAN;
 }
 
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index dd1fb482eac..8ff6e563310 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -25,8 +25,10 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
           hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #include "system/memory_ldst_endian.h.inc"
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index f4c91dc7a91..e0da6d19a5b 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -31,8 +31,10 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS  _le
 #include "system/memory_ldst_phys_endian.h.inc"
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 5a979ea6ac3..2f707e5f5b4 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -181,9 +181,11 @@ void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                              attrs, result);
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #define MO_ENDIAN               MO_LE
-- 
2.52.0


