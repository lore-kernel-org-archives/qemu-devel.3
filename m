Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F2FCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdUN-00082J-7g; Fri, 21 Nov 2025 21:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcDv-0000Gk-7w
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:15:37 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcBu-0005Bk-51
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:15:32 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso412736566b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763773987; x=1764378787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiNGRX34bLVgr8we0q4WpsknHKY0sYA3cJv9gH8gG7k=;
 b=gWj0DasjPf3nYGpSViH7DO5PdYXwj8FJCjBwSqHnUafrv6MABlFlCtqz3UUowBd5QI
 Tn+XIEGvKbTTfdLa4hEZliqAZ56vqEjQsa/HrUC3j6K8tkluSdt6L2XecLfixDRqgPV0
 8YwJolLZsgjNOvuhMDRaRtUmKKmFPomX04UquMJ/662qUA+ZzR6ulX3bV/2blofEA72x
 5et8oYfqbR2FQQsgpQq+24I7jTqr/ASD8994cv9kKIE5cV3ewWfpn/Ne1Ru1nK7cLSbb
 Hrcu4rbx1fXIRyIrb/RuUh6RR8IUOBTpSt0XAFoRDkL10WlE0OnTZS2ULqEOs9gkyuqY
 XmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763773987; x=1764378787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wiNGRX34bLVgr8we0q4WpsknHKY0sYA3cJv9gH8gG7k=;
 b=dyIHNP6zZt00YuPYVni55gQM6r9zRXr5TLZimGVWqGdWIfT4pwaUdCxIUsy8JA9cbH
 b+cPsI9fKu0j7I0fSTN4s7ABISJXxVdBbH/8fJpzzebHbX4lcA7MHsQBG/zKRdA6I4rS
 JXPCuBjKaCXOnrd7eFtV1rKeYf/AMs05LCrf5yvxrb1g+yPqmV3RgaDY04URmMi43A7C
 7TfAD4N5tlpAaweLAOBZlgCV8rA9OmgS7Y26ZL90rPE+jrlq1r/wmgJyMTw22cgo+Osp
 2UVBiRKFz9fTjOHCXVSRNSwCJO1A46askh+msh3WIRABpGGshy5Jm19yj2SqJJOuDTYk
 CkyA==
X-Gm-Message-State: AOJu0YwZb/WsrgDgRLoerecuS+CRPbZJ73rqC5AyPpS/1BHyR4vXrMjq
 UAfuDkKt/0Yf8uc6GU6QVh6Cj/uQ+w+GkcsP0ZlLo75/kU0ir/YRVYg7bWB8AMPNvH5mENIHfBF
 Jn89e2Xek+w==
X-Gm-Gg: ASbGncuEr7bHlGzMwfD+ICVmxekVlIPNtmQ9W7b14UCCrssZ5a3JMCWYmOXZww9M7nH
 e76oidEMdsI1OP12er7D+GHUOMHoqKlvtz5NnKC1/u5W9spfY6hbYMLt3J+2RSWJR2RWIaHSr8W
 UsWSXAuP7B7265ASDqg+r92UFRTfHmbiKJQwPqVerDTuJhg77DAdnBl0uvj7hn5ljKIJ0SZ+NNm
 W6yba9GozkwMvpJopi6fd6FbeP7TnuhsMVgLEeTQXSm2J2xHnat+lAV/eH3pWw5OK4PCQ4ZFW3x
 3L9fcrTJj/1+UmHdqk4MK1E4CFSkn5g+4n+FwN6vMWNPtzQvOwdh9Hse5VPOs+yibwRlWuwEOEd
 wlvLeh49C1IyXoT2ASviAlaqRrYUaaLJh+L4yoyyOhVdaftDD+Ca4PibRlrhlVpjMvdA/GoJz7y
 fh2u2FIruuUd+Du+rbpx3KqHu7yCpvzcWaneSvxFbMoHMHr8OHoJpWJAppDfI0
X-Google-Smtp-Source: AGHT+IGCkg+uWGBlahBmkPgkgQoDmg3pMx2+5N7CNgh0GMGQreSiOwxIaOA51lhQPEmwFRlZ1n3jzA==
X-Received: by 2002:a05:600c:470d:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-477c01f4f4emr29007215e9.31.1763732798704; 
 Fri, 21 Nov 2025 05:46:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4eb2sm44593575e9.12.2025.11.21.05.46.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 14/21] target/s390x: Use little-endian variant
 of cpu_ld/st_data*()
Date: Fri, 21 Nov 2025 14:44:56 +0100
Message-ID: <20251121134503.30914-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

We only build the S390x target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=s390x; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 48 +++++++++++++++++------------------
 target/s390x/tcg/vec_helper.c |  8 +++---
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 84d901c2008..cb990c0c983 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -101,7 +101,7 @@ static inline uint64_t cpu_ldusize_data_ra(CPUS390XState *env, uint64_t addr,
     case 1:
         return cpu_ldub_data_ra(env, addr, ra);
     case 2:
-        return cpu_lduw_data_ra(env, addr, ra);
+        return cpu_lduw_be_data_ra(env, addr, ra);
     default:
         abort();
     }
@@ -117,7 +117,7 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
         cpu_stb_data_ra(env, addr, value, ra);
         break;
     case 2:
-        cpu_stw_data_ra(env, addr, value, ra);
+        cpu_stw_be_data_ra(env, addr, value, ra);
         break;
     default:
         abort();
@@ -865,7 +865,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, uint32_t r2)
             env->cc_op = 2;
             return;
         }
-        v = cpu_lduw_data_ra(env, str + len, ra);
+        v = cpu_lduw_be_data_ra(env, str + len, ra);
         if (v == c) {
             /* Character found.  Set R1 to the location; R2 is unmodified.  */
             env->cc_op = 1;
@@ -1022,7 +1022,7 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        env->aregs[i] = cpu_ldl_data_ra(env, a2, ra);
+        env->aregs[i] = cpu_ldl_be_data_ra(env, a2, ra);
         a2 += 4;
 
         if (i == r3) {
@@ -1042,7 +1042,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stl_data_ra(env, a2, env->aregs[i], ra);
+        cpu_stl_be_data_ra(env, a2, env->aregs[i], ra);
         a2 += 4;
 
         if (i == r3) {
@@ -1363,7 +1363,7 @@ Int128 HELPER(cksm)(CPUS390XState *env, uint64_t r1,
 
     /* Process full words as available.  */
     for (len = 0; len + 4 <= max_len; len += 4, src += 4) {
-        cksm += (uint32_t)cpu_ldl_data_ra(env, src, ra);
+        cksm += (uint32_t)cpu_ldl_be_data_ra(env, src, ra);
     }
 
     switch (max_len - len) {
@@ -1372,11 +1372,11 @@ Int128 HELPER(cksm)(CPUS390XState *env, uint64_t r1,
         len += 1;
         break;
     case 2:
-        cksm += cpu_lduw_data_ra(env, src, ra) << 16;
+        cksm += cpu_lduw_be_data_ra(env, src, ra) << 16;
         len += 2;
         break;
     case 3:
-        cksm += cpu_lduw_data_ra(env, src, ra) << 16;
+        cksm += cpu_lduw_be_data_ra(env, src, ra) << 16;
         cksm += cpu_ldub_data_ra(env, src + 2, ra) << 8;
         len += 3;
         break;
@@ -1955,7 +1955,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        uint64_t val = cpu_ldq_data_ra(env, src, ra);
+        uint64_t val = cpu_ldq_be_data_ra(env, src, ra);
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
@@ -1992,7 +1992,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        uint32_t val = cpu_ldl_data_ra(env, src, ra);
+        uint32_t val = cpu_ldl_be_data_ra(env, src, ra);
         uint64_t val64 = deposit64(env->cregs[i], 0, 32, val);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
@@ -2028,7 +2028,7 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stq_data_ra(env, dest, env->cregs[i], ra);
+        cpu_stq_be_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint64_t);
 
         if (i == r3) {
@@ -2048,7 +2048,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stl_data_ra(env, dest, env->cregs[i], ra);
+        cpu_stl_be_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint32_t);
 
         if (i == r3) {
@@ -2065,7 +2065,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     real_addr = wrap_address(env, real_addr) & TARGET_PAGE_MASK;
 
     for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
-        cpu_stq_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
+        cpu_stq_be_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
     }
 
     return 0;
@@ -2324,11 +2324,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
         for (i = 0; i < entries; i++) {
             /* addresses are not wrapped in 24/31bit mode but table index is */
             raddr = table + ((index + i) & 0x7ff) * sizeof(entry);
-            entry = cpu_ldq_mmuidx_ra(env, raddr, MMU_REAL_IDX, ra);
+            entry = cpu_ldq_be_mmuidx_ra(env, raddr, MMU_REAL_IDX, ra);
             if (!(entry & REGION_ENTRY_I)) {
                 /* we are allowed to not store if already invalid */
                 entry |= REGION_ENTRY_I;
-                cpu_stq_mmuidx_ra(env, raddr, entry, MMU_REAL_IDX, ra);
+                cpu_stq_be_mmuidx_ra(env, raddr, entry, MMU_REAL_IDX, ra);
             }
         }
     }
@@ -2355,9 +2355,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     pte_addr += VADDR_PAGE_TX(vaddr) * 8;
 
     /* Mark the page table entry as invalid */
-    pte = cpu_ldq_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
+    pte = cpu_ldq_be_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
     pte |= PAGE_ENTRY_I;
-    cpu_stq_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
+    cpu_stq_be_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
@@ -2695,7 +2695,7 @@ static int decode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
     if (ilen < 2) {
         return 0;
     }
-    s0 = cpu_lduw_data_ra(env, addr, ra);
+    s0 = cpu_lduw_be_data_ra(env, addr, ra);
     if ((s0 & 0xfc00) != 0xd800) {
         /* one word character */
         l = 2;
@@ -2706,7 +2706,7 @@ static int decode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
         if (ilen < 4) {
             return 0;
         }
-        s1 = cpu_lduw_data_ra(env, addr + 2, ra);
+        s1 = cpu_lduw_be_data_ra(env, addr + 2, ra);
         c = extract32(s0, 6, 4) + 1;
         c = (c << 6) | (s0 & 0x3f);
         c = (c << 10) | (s1 & 0x3ff);
@@ -2730,7 +2730,7 @@ static int decode_utf32(CPUS390XState *env, uint64_t addr, uint64_t ilen,
     if (ilen < 4) {
         return 0;
     }
-    c = cpu_ldl_data_ra(env, addr, ra);
+    c = cpu_ldl_be_data_ra(env, addr, ra);
     if ((c >= 0xd800 && c <= 0xdbff) || c > 0x10ffff) {
         /* invalid unicode character */
         return 2;
@@ -2792,7 +2792,7 @@ static int encode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
         if (ilen < 2) {
             return 1;
         }
-        cpu_stw_data_ra(env, addr, c, ra);
+        cpu_stw_be_data_ra(env, addr, c, ra);
         *olen = 2;
     } else {
         /* two word character */
@@ -2802,8 +2802,8 @@ static int encode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
         d1 = 0xdc00 | extract32(c, 0, 10);
         d0 = 0xd800 | extract32(c, 10, 6);
         d0 = deposit32(d0, 6, 4, extract32(c, 16, 5) - 1);
-        cpu_stw_data_ra(env, addr + 0, d0, ra);
-        cpu_stw_data_ra(env, addr + 2, d1, ra);
+        cpu_stw_be_data_ra(env, addr + 0, d0, ra);
+        cpu_stw_be_data_ra(env, addr + 2, d1, ra);
         *olen = 4;
     }
 
@@ -2816,7 +2816,7 @@ static int encode_utf32(CPUS390XState *env, uint64_t addr, uint64_t ilen,
     if (ilen < 4) {
         return 1;
     }
-    cpu_stl_data_ra(env, addr, c, ra);
+    cpu_stl_be_data_ra(env, addr, c, ra);
     *olen = 4;
     return -1;
 }
diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index 46ec4a947dd..304745c971b 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -45,9 +45,9 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
     if (likely(bytes >= 16)) {
         uint64_t t0, t1;
 
-        t0 = cpu_ldq_data_ra(env, addr, GETPC());
+        t0 = cpu_ldq_be_data_ra(env, addr, GETPC());
         addr = wrap_address(env, addr + 8);
-        t1 = cpu_ldq_data_ra(env, addr, GETPC());
+        t1 = cpu_ldq_be_data_ra(env, addr, GETPC());
         s390_vec_write_element64(v1, 0, t0);
         s390_vec_write_element64(v1, 1, t1);
     } else {
@@ -195,9 +195,9 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
     probe_write_access(env, addr, MIN(bytes, 16), GETPC());
 
     if (likely(bytes >= 16)) {
-        cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC());
+        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC());
         addr = wrap_address(env, addr + 8);
-        cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 1), GETPC());
+        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 1), GETPC());
     } else {
         int i;
 
-- 
2.51.0


