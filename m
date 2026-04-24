Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CB8FE5204
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGE0V-0005sl-07; Fri, 24 Apr 2026 06:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGE0S-0005rQ-1w
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:43:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGE0P-0003ua-NI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:43:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0046078so69591945e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777027408; x=1777632208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E2wkN1bufIhL14IHSKnpj7rUkgY1Gqo3hqaNAVYj5As=;
 b=yF6/NFxrTrDyN2H1xKSPRMffX36PQQDCDbXeTaoJOLk3omw0vFBSmCrORIfZH5JH1r
 KlJe9cTuD95+JTvepd0rVGTzFQB83C+mDH+m4uYQOTBrJfDXY3bScHJ0tz/ABxnaI9UB
 isSSXL3Nvous7Omu+VJL1gJuYDzj0RQudCEdFgqOyE+Ey4XyNZKAXn92o6sAcNIcCthw
 LlGrZxLVJy5m+CauODGzt931OhrTE65CtbQzUJaQuO1q2STOeATRYfYgQ77cErUjxzh4
 6g4vz/6ZGXzdqGg8whJ22OFgR7SYakzcOwtbeOMdVLOUbhuHb02RubjlQZJnusgg0zU3
 aQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777027408; x=1777632208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2wkN1bufIhL14IHSKnpj7rUkgY1Gqo3hqaNAVYj5As=;
 b=B9RlXmsjWBjIYcvYdpchUPMjGdwqMcmcWsCnRQNTz5H5PNdspmnZXL2H/8OhewDo5E
 6wamCyniZjY/Gphs2MFG6xWI3OarG+XUfggZ1vk7vvPZsd6Wb0U7o9CSK1sZMa/k13nr
 WlgWiDQhSC3NgiggXLCpKSwavOqwKUDflvVUj0wJWzz8aXCevNUvS49sQJ265D/34/MO
 lWuTpQTNszEq0nYx5gkJnRHh3mw/u3PXHUq+Iqh9mT4zDBX9csCXXU0qaNTOU9J6z+vX
 blZ1km7YknZ/jq0UssZy0T8f17Liw7lO+AnuTzzQnm9RuPM8ham+7dwe5hhqL0qm1P7x
 EVTg==
X-Gm-Message-State: AOJu0Ywsr40SEZEqtd6uCKkVttJDaGpLi6DOTFcjUIVhsVCsWiFTirGk
 +dVDO42aF9VJ1ecEUeSlMRns3Yt1f7MNuxNUlkGeCWRzs4U+fq1DwZTz7hkSa4L5fEh6dCM5Eet
 BNqLmtR4=
X-Gm-Gg: AeBDieuxwa9uY0SeCzIsWnQ/N8C64MClHc+N2vcgnqPD1iguUAN7XW8x6Ru+Z2PuYoY
 foMImPNNd9mgIFrwrPloM5xex8OpVdtrGggRLqeAx/kv0woOcNIgGtxQy1PJRVnJAzopm36aKH1
 Wtj6boOXjRELG1tGdYbhsNDNLEQNus8wspcIvYLi3soFnVL6X53dLP2A3+FdQkZYIsks0C5jQC+
 KrfEhkNMXNPEp/eoliZw31BpL+kk+ua9mVk5rBS9dMRg8D+/zRT2XE9ukZxlQPWeEnxruhGaYBF
 2A60DX9pZG3bhslnnWa8cXzvC2wF69rQTrNbJvnK/wKXBObpu8iLbTotbA2fQ79DLjDDcZotEXx
 SdjgtIQfzIay+9aOsLKObhs0lOcKwPTaGKbgF0l3VXSFrjouSMohLaBg1dZw6E4FSgdxR1FoyOb
 UiN3XpBE4pWspk3YdFO9y//KnXwCzZMV6TcED4O0VbBKEWDgVSF04AJpm7W+TgkcsD4s4aAeI4+
 iPJrZiiZhQ=
X-Received: by 2002:a05:600c:4e8f:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-4891fa59adfmr296331575e9.9.1777027407697; 
 Fri, 24 Apr 2026 03:43:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a66533ff4sm10927015e9.6.2026.04.24.03.43.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 03:43:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3] target/s390x: Leverage 128-bit vector type in V{L,
 ST}L opcodes
Date: Fri, 24 Apr 2026 12:43:25 +0200
Message-ID: <20260424104325.81484-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The access is unaligned (MO_UNALN), we can easily replace the 2
consecutive 64-bit calls by a single 128-bit one.
Considering atomicity of the new 128-bit access, the both opcodes
VLL (Vector Load with Length) and VSTL (Vector STore with Length)
access byte granularity, so use MO_ATOM_NONE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20260423135035.50126-1-philmd@linaro.org>

v3:
- do not increase addr (Ilya)
- MO_ATOM_NONE (Richard)
---
 target/s390x/tcg/vec.h        | 12 ++++++++++++
 target/s390x/tcg/vec_helper.c | 17 ++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/s390x/tcg/vec.h b/target/s390x/tcg/vec.h
index 8d095efcfc6..34413f7e029 100644
--- a/target/s390x/tcg/vec.h
+++ b/target/s390x/tcg/vec.h
@@ -13,8 +13,10 @@
 #define S390X_VEC_H
 
 #include "tcg/tcg.h"
+#include "qemu/int128.h"
 
 typedef union S390Vector {
+    Int128 quadword;
     uint64_t doubleword[2];
     uint32_t word[4];
     uint16_t halfword[8];
@@ -72,6 +74,11 @@ static inline uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr)
     return v->doubleword[enr];
 }
 
+static inline Int128 s390_vec_read_element128(const S390Vector *v)
+{
+    return v->quadword;
+}
+
 static inline uint64_t s390_vec_read_element(const S390Vector *v, uint8_t enr,
                                              uint8_t es)
 {
@@ -117,6 +124,11 @@ static inline void s390_vec_write_element64(S390Vector *v, uint8_t enr,
     v->doubleword[enr] = data;
 }
 
+static inline void s390_vec_write_element128(S390Vector *v, Int128 data)
+{
+    v->quadword = data;
+}
+
 static inline void s390_vec_write_element(S390Vector *v, uint8_t enr,
                                           uint8_t es, uint64_t data)
 {
diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index 98eecd9fde6..a86819f61b6 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -48,14 +48,11 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
     MemOpIdx oi;
 
     if (likely(bytes >= 16)) {
-        uint64_t t0, t1;
+        Int128 t;
 
-        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-        t0 = cpu_ldq_mmu(env, addr, oi, ra);
-        addr = wrap_address(env, addr + 8);
-        t1 = cpu_ldq_mmu(env, addr, oi, ra);
-        s390_vec_write_element64(v1, 0, t0);
-        s390_vec_write_element64(v1, 1, t1);
+        oi = make_memop_idx(MO_128 | MO_UNALN | MO_ATOM_NONE | MO_BE, mmu_idx);
+        t = cpu_ld16_mmu(env, addr, oi, ra);
+        s390_vec_write_element128(v1, t);
     } else {
         S390Vector tmp = {};
 
@@ -206,10 +203,8 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
     probe_write_access(env, addr, MIN(bytes, 16), GETPC());
 
     if (likely(bytes >= 16)) {
-        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, ra);
-        addr = wrap_address(env, addr + 8);
-        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, ra);
+        oi = make_memop_idx(MO_128 | MO_UNALN | MO_ATOM_NONE | MO_BE, mmu_idx);
+        cpu_st16_mmu(env, addr, s390_vec_read_element128(v1), oi, ra);
     } else {
         oi = make_memop_idx(MO_8, mmu_idx);
 
-- 
2.53.0


