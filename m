Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118F5C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb1-0008Q8-IK; Sun, 18 Jan 2026 14:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZe-0006Vk-OR
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZa-0006mW-Gt
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:33 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so13845925e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764988; x=1769369788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4SqeZxl5HqhEizpE5MaSMKz3/wkRaflVH0M8Y28zmg=;
 b=SrciQ54MG8qeDHrrFLwDPHy4bgqT970Bo4zeHHix4GyqK9MQwmA+4wZ91q2YE/BajU
 SI7BrKYlCctY7qSR93aeQbs0TAil+EGnDyyuB6jcNVC7KiT37XUFL1Hw2kPhKClIilye
 uQbm9G8dM37BOdRLH6HkzD4acYO3yZMdYiH5MkpZrWKIRpSSAS5nVzoZRuirZoveMfFO
 /a3BxPTzpY84aiXukCW50tXt5RTodmS1KFKWIwXbdlEtMF9w6ewtn/vAvzBN9jdDNYrK
 i67ox02J8rbRAz9iTbkfPfLJlDh0/WihKAHWXMPEQQfKk94zSARR7kLvvpRgl97+/IC9
 Q3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764988; x=1769369788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y4SqeZxl5HqhEizpE5MaSMKz3/wkRaflVH0M8Y28zmg=;
 b=D53S9vKhef9004MgQDOiLfAqCXbmkB0ZmH7BX8MrhtW9ervR5SxbPRIcPvfz6isvB5
 larsDbT7r4MiISR8mU4K/UsTbdTb6F2YZrozcCNC/zF+T8flsgAcedRG7CdCkkEWVr7d
 PwKZ/LnqZ/7S887ViL3CgatEo3NAhyXjwWkfwAQXtN4CE687Fl19gF5eddkPB5txFQdM
 8sASHlRM9k4bA+twQOiZbRvw/x/OaHpyoHQ46nqPCMjptKEw4prWJAZ+TbG8nIkhu2P/
 MwoxRSMAqztXi/1foFekrcMNXMwdZn5Zstj7KE/eov2M6ShugAGDh+y4rO2In6wm/fVr
 Qn4Q==
X-Gm-Message-State: AOJu0YxUMs6vKdXcdnoV9b0dfUDZA2rqv+5szkAuonSSSOLkcaDuFNsn
 +M9G38zm7BJlJ2e1M6novEKnRXA5LYw6u1onoHHdldlFpzPdzFZgkShqmnu7b6Ud0GstniCcH8f
 G3xvIKGs=
X-Gm-Gg: AY/fxX40SilcTczdDOeTaJUIcdHaIBZ6ziuRdcjaMr7Cqk+sD9p5nmZU+wly4Az8QU9
 geQadxxSQ0TKyYE5az8EpMhZdtwmDZ8GAE/SLTQSG7Y/F0wis+4V1pmWFuUgBa+vGK5SxQYLFja
 mclbhcZ92Db/f7TjjOepp1yQLURcVyEQtYvy0OnNI0kTM9K1RGANgcBM6f0xPGtZRB5jE/TcIh6
 OCSRuNgvDN0kXdvKDwlSHdi+oIH3NbzmOMh6/BL1ectTQ7jj2eb3v8CliD4f6Xrk76+2CHgEPLd
 fsHTlCHYPgTuqjaYBnY0VJGwXUOgq0uyka1uCpulh21jdSOeBFtQU9l/7omt+y/W1PoU3dafL9X
 zZtAi82hOSMZ4a59hkuKXn0tj5W8vtWeH9070wJ9+STQ/HJdLklweamCHtbvRF3ksP+pVZV0O6d
 q+fFrcIS0CvwdhElw1280u05U64TWknhQDkwHvzET6AmoNqQGbAD17+/12kz9Y
X-Received: by 2002:a05:600c:37cc:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-4801eac97b9mr109494195e9.15.1768764987621; 
 Sun, 18 Jan 2026 11:36:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c197sm156490585e9.1.2026.01.18.11.36.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:36:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 11/18] system/memory: Directly call
 address_space_ldst[M]_internal() helper
Date: Sun, 18 Jan 2026 20:35:01 +0100
Message-ID: <20260118193509.42923-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Inline internal address_space_ld/st[L,D,Q] helpers,
directly calling address_space_ldst[M]_internal().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory_ldst.c.inc        | 47 ---------------------------------
 system/memory_ldst_endian.c.inc | 12 ++++-----
 2 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index d51c5feddf7..ebb441f1a66 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -57,22 +57,6 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     return val;
 }
 
-/* warning: addr must be aligned */
-static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_32, addr,
-                                                    attrs, result);
-}
-
-/* warning: addr must be aligned */
-static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_64, addr,
-                                                    attrs, result);
-}
-
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -80,14 +64,6 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
                                                     attrs, result);
 }
 
-/* warning: addr must be aligned */
-static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_16, addr,
-                                                    attrs, result);
-}
-
 /* warning: addr must be aligned */
 static inline
 void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
@@ -122,14 +98,6 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     RCU_READ_UNLOCK();
 }
 
-/* warning: addr must be aligned */
-static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_32, addr, val,
-                                             attrs, result);
-}
-
 void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                      MemTxAttrs attrs, MemTxResult *result)
 {
@@ -137,21 +105,6 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
-/* warning: addr must be aligned */
-static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_16, addr, val,
-                                             attrs, result);
-}
-
-static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
-    MemOp mop, hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_64, addr, val,
-                                             attrs, result);
-}
-
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 9cf36017135..fb933de11f8 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -22,42 +22,42 @@
 uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_16,
                                         addr, attrs, result);
 }
 
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_32,
                                         addr, attrs, result);
 }
 
 uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result)
 {
-    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, MO_ENDIAN,
+    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | MO_64,
                                         addr, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_16,
                                  addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_32,
                                  addr, val, attrs, result);
 }
 
 void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
-    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, MO_ENDIAN,
+    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | MO_64,
                                  addr, val, attrs, result);
 }
 
-- 
2.52.0


