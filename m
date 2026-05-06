Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8D5FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKclt-0000gw-Fp; Wed, 06 May 2026 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclq-0000Z9-Gj
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:38 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclo-0008S8-F5
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-452169ae568so381224f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075914; x=1778680714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=60coApDZP+p798+jT/PZ7anbii2bv3aln1igBOsFf3w=;
 b=mPLUIFijtf0dByUrf+rTaWyiAyUKmmXGEZkli+/maW56fgfl34LOOYtr3h2sHM6K72
 3TFAVk75myYDAfREUzQWo/VBSBPF9atgAZ5goS+RtcToQWGQErUWhJqBoKFUw3po8G1E
 cZJuWd48PpK5gtDDdg9I5IUy+VZm+TBaBbNlAXmoHhUvSL97nSdLnJenbrxUocfk3gan
 GdTvzVQAa0MWe3vkqhvFVqOjxZy73+M1C7Xgp/i1TAw97xhY6r46gE6B2FIU3B15RAXD
 SefaCbJjDwIlgAxMF8os0Ch2ubJ74QNcjDNVU86ZQTqIwQrIW+TP/N78ADyDKHIddkpC
 Sklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075914; x=1778680714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=60coApDZP+p798+jT/PZ7anbii2bv3aln1igBOsFf3w=;
 b=fKU69jqmDZKD0KbSO8ZABOblI1wEm+nk6ylHfJrRV5IvuHtXM5ON4wOFur2c6on7Xb
 mEULwzTVxfYrTnARBB91ey595Gdbb/H9ALOM9JgG/gLydbm5iBZMymeoSUuHOoUrlj/B
 Uug2B/lh3m2PRXHwhDQ8HlKKp1KS1oklwCID9lv1vwbVCRMnzoKmiCunFBiSC7GOYfw6
 tUfuleFssqK0LrDixpso829/TKnkACx65Ve/upBTZ2xYq8OSp/Frtm20yXhmJdrd2lcd
 Cw4EXTDBDvApZ8T8C6Dinz9Fo1mHXjye8EawHD3Iwv+kzvICA+rAnaUJTmnBoDZ1lSXR
 W8wQ==
X-Gm-Message-State: AOJu0YwIGbj+5f1v7LDdKwrGnjLolXWlUWzREBya2kU51KJ/9FvfOFR4
 nPzyhQWvZnkHn1UUZcnfWdDOadpZbXA7B0NflfUl0YwbzYcObZDguPzck/9L9DYuXbyZBZWQ9xW
 mwDprxxo=
X-Gm-Gg: AeBDiesJLfpM4x8LEY6IHGdUSmamQyvrI3AsAdMfxQEUh+piEVgIgwhXtl4oGlYhHwB
 +0lxB+/OUXMfL8v6aoZrKVZl6WiR72W7acgX+1HtuvzBndvlHVsewr+y2JWoGsf2aFemQ20fHWy
 iqFFGUSb+wC68ga1nsKElPJUQ8SLNfweVuLoW0+0CUTPHA0GtcuOZG0QDhDAlTLlhFa9K+uGbXF
 o9+X4yLmbDAKcm2juonY40iENi1MIdi3BwNHG5yss64b6ycnAQcaFpWbTu3ZYpLNI2EQsg5WWGU
 D3V+ms6UGNjZzhbO4PQIs0OtXiMWbF+CeJW/TzKQJP4YKv3JN/Am/lSQRr7pKwL09cxNTDVkGDo
 O+jeZo99aOzXelNmzwvBsKb7bfa1CyMghu9XNXaJ/vGVMX1PKjGhpXsWfCaJg3MOuEkgjwV5yxZ
 2WkmLix1Nimd/I90/PH5+K9w3TxH4bO3tT+0dSokQQnbhJ3uquh+f7G2Kf3X+JYaLu594SqmEiu
 1cSM8352Vs5L2gl3VsVLA==
X-Received: by 2002:a05:6000:1885:b0:44b:d975:1293 with SMTP id
 ffacd0b85a97d-4515b056ab6mr6830452f8f.1.1778075913851; 
 Wed, 06 May 2026 06:58:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02c5asm12705649f8f.19.2026.05.06.06.58.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 025/110] target/loongarch: Replace legacy ldq_le_phys() ->
 address_space_ldq_le()
Date: Wed,  6 May 2026 15:53:57 +0200
Message-ID: <20260506135524.20617-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Prefer the address_space_ld/st API over the legacy ld/st_phys()
because it allow checking for bus access fault (although the
modified code doesn't check that). There is no logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260319104944.66690-2-philmd@linaro.org>
---
 target/loongarch/cpu_helper.c     | 13 +++++++++----
 target/loongarch/tcg/tlb_helper.c | 10 +++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 60441687667..4b7743c4f28 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/memory.h"
 #include "system/tcg.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-mmu-index.h"
@@ -145,6 +146,7 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
     hwaddr index = 0, phys = 0;
     uint64_t palen_mask = loongarch_palen_mask(env);
@@ -174,7 +176,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = ldq_le_phys(cs->as, phys);
+        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -204,10 +206,13 @@ restart:
         context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
         base += (BIT_ULL(dir_base) & address);
     } else if (cpu_has_ptw(env)) {
+        uint64_t val;
+
         index &= 1;
         context->pte_buddy[index] = base;
-        context->pte_buddy[1 - index] = ldq_le_phys(cs->as,
-                                                    phys + 8 * (1 - 2 * index));
+        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
+                                   attrs, NULL);
+        context->pte_buddy[1 - index] = val;
     }
 
     context->ps = dir_base;
@@ -239,7 +244,7 @@ restart:
         ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
         /* PTE updated by other CPU, reload PTE entry */
         if (ret1 == MEMTX_DECODE_ERROR) {
-            base = ldq_le_phys(cs->as, phys);
+            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
             goto restart;
         }
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c0fd8527fe9..892e0eb4738 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -20,6 +20,7 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
+#include "system/memory.h"
 
 typedef bool (*tlb_match)(bool global, int asid, int tlb_asid);
 
@@ -709,7 +710,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     hwaddr index, phys;
     uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
-
+    uint64_t val;
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -736,7 +737,9 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_le_phys(cs->as, phys) & palen_mask;
+    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
+
+    return val & palen_mask;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -802,7 +805,8 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        pte_raw = ldq_le_phys(cs->as, phys);
+        pte_raw = address_space_ldq_le(cs->as, phys,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
         tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
         ps = ptbase;
     }
-- 
2.53.0


