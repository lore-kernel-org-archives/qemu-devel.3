Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59CAD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdD6-0005ul-Mq; Fri, 19 Dec 2025 11:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdD5-0005uX-5x
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdD3-0005v1-ED
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso13852075e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161203; x=1766766003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1b6x18riFiHnFkkcqn+CtPN4j8BBN9191Tesnu/1k0=;
 b=f3N0CabHvpoiw0njnD9n/uLXbhMdrO1hgm3rRVSby9Oe6SrAVifjQUjbhdMQeKxFgS
 jLs87ZxmpWH+KjO/kmdGKTI9AesbxQfvJFBhdbc3FVGL8qbrqLdldGdoL3NptSQH8ckX
 VHTAP3gRPsyymSRVZcMAImHUWkov0YeF6Y4ThTgcCdQO2EmUwAhpNQ41HoQMZjxAmLJn
 rhUgYLyLwCwoco013gg/977CM6CCyQHNlCXyw8WaZJGQDcW0tBahJE/1bIzuSmq1UqiT
 VEoGHXB5BFDrbaBZLN1M/uM6s+/FNus2xskgikS8BFzgVUZ3DEzjYeo9wNfnZzZQGUz6
 BjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161203; x=1766766003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B1b6x18riFiHnFkkcqn+CtPN4j8BBN9191Tesnu/1k0=;
 b=ZoQJ1ExWblpBSy/KejJ60wFLbp2a6ecgQ7vj/9shw4qjc5akbEnWlBWI+yQt2kl4NS
 XUvHSmKh86sl1oDJ4p2NorLHskX+Zottm9ulrWYmIp6XbqZIx2w0aUH4H0s3VipWIEAt
 Pv9W5x+TpLz/3MVp4r2DgzN45bnB8aOwWAAXJSAClm71wdOjReJvwpOY+7LBKM5mgvEL
 c5geMyqbytdXTof4GpJix7cntPMnjXGBKxwkKCFC57gH7tyPAuYuLOEteVkMF0dwCggT
 pmVFNjn6TneuBvIRSsGAw6jhkC6gWO0SrTJWXzc0ttshkRF+cGs5Q6UfBt616Hjcccam
 yB6w==
X-Gm-Message-State: AOJu0YxpQyM4EDISOCYeyRG2pqVFlp1IHmjX3qi/ygVsyMxE7GTrjyde
 q7zZWGP7Wc006FCRS5qSY/g3gYWSwmKGZ2PRlwewuc7w9U/1YOnYEbZycyYblt6Z1uE3r7aKpyu
 CxxCB/to=
X-Gm-Gg: AY/fxX72YCUDMxu4XVsCrvyYT8E/+/FzM/ocdluJQAEjruh+bqJJ7uYk2kcvt/QTzPo
 gZhf1hLDN9m7xo5rjHWI/W+zCiBa2vIYuLjm6HVPDz2tVsIuOnLzzb7QHbPGp/Eg3X3N5L2MSKM
 xLj9V8RozS41UyBvsy3La0iwhGgfiJQgSVfvpsSgOQJpLPN27W032qojLcXsMZBSMLf1OPmKFkb
 eGAu6gy8rv5MFb0z3FV+CcBe0RvcFBj+Y8rdzo9/3PLBw0osfueQzcf1meJ8AR+Alr1m9UDsgOj
 KvpweuHhwqWCVpg6ztW6Us8pugYm6Yeqe+W735nCkpFH0RHrTkbPkqII3ME/JLN7wpqIH/gBVzF
 hYpXiWpjGzgps3COAqH1H185njmzmK7nyFuPUAEF2G+sMLMkGABWLKLXRhN0oOgVjZrnivGwiAI
 m/GxOFVZvxPxTl8GwNVIf1ria0TaTVXSalOws6oM6rtRMNyioigVjP7K3C6WDh
X-Google-Smtp-Source: AGHT+IHiV9J9OBvlD0VK7/nkj3/FIHnq9Fv/Yio9jlsaZFwAZWOV9tqpf+UehcDxROdnJCwCT4NgzQ==
X-Received: by 2002:a05:600c:1caa:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-47d19545aaemr31183775e9.13.1766161203486; 
 Fri, 19 Dec 2025 08:20:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3af6dbdsm38161245e9.19.2025.12.19.08.20.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/24] system/memory: Remove address_space_stl_notdirty and
 stl_phys_notdirty
Date: Fri, 19 Dec 2025 17:19:28 +0100
Message-ID: <20251219161953.72724-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

stl_phys_notdirty() was added in commit 8df1cd076cc ("physical memory
access functions") as a (premature?) optimisation for the CODE path.
Meanwhile 20 years passed, we might never have understood / used it
properly; the code evolved and now the recommended way to access the
CODE path is via the cpu_ld/st_mmu*() API.

Remove both address_space_stl_notdirty() and stl_phys_notdirty()
leftovers.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory.h        |  6 ------
 include/exec/memory_ldst.h.inc |  2 --
 system/memory_ldst.c.inc       | 39 ----------------------------------
 3 files changed, 47 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0d..e69171de05a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2850,12 +2850,6 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "exec/memory_ldst.h.inc"
 
-static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl_notdirty(as, addr, val,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 7270235c600..173164fee3a 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -25,8 +25,6 @@ uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stl, SUFFIX)(ARG1_DECL,
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 333da209d1a..b45bfecd137 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -261,45 +261,6 @@ uint16_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
                                        DEVICE_BIG_ENDIAN);
 }
 
-/* warning: addr must be aligned. The ram page is not masked as dirty
-   and the code inside is not invalidated. It is useful if the dirty
-   bits are used to track modified PTEs */
-void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 4;
-    hwaddr addr1;
-    MemTxResult r;
-    uint8_t dirty_log_mask;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
-    } else {
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        stl_p(ptr, val);
-
-        dirty_log_mask = memory_region_get_dirty_log_mask(mr);
-        dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
-        physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
-                                            4, dirty_log_mask);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
-}
-
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
-- 
2.52.0


