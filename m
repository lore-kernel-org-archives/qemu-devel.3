Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF514CE9D48
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJt-0003yJ-9y; Wed, 07 Jan 2026 07:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJm-0003uf-7K
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJg-0002BO-V5
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/GviJvjpGqwcOf9CVERLbyCmZZuE0qefwJTWvgJ3E0=;
 b=gphdYk/Kyicw9b6eMlGgzM3H3pgaA2h4ujPto2xGPEYNtkZ4eFXi7g5puA6+x1eFxhF67X
 VBLiVG0LovEN11BMpffAheVCZ9zWYFZwjaeNlmXy1QDUtck2AXefxN3shYktuXc3wn+ekM
 rONleLodooemzYdxqnoB3SJWhqtK/pc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-5_pavtXWN7WfU7XjPDzqPg-1; Wed,
 07 Jan 2026 07:07:00 -0500
X-MC-Unique: 5_pavtXWN7WfU7XjPDzqPg-1
X-Mimecast-MFC-AGG-ID: 5_pavtXWN7WfU7XjPDzqPg_1767787619
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 562B21800359; Wed,  7 Jan 2026 12:06:59 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3FBA1956048; Wed,  7 Jan 2026 12:06:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 11/14] target/s390x: Use big-endian variant of cpu_ld/st_data*()
Date: Wed,  7 Jan 2026 13:06:35 +0100
Message-ID: <20260107120638.56735-12-thuth@redhat.com>
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
References: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We only build the S390x target using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the
big endian declarations. Use the explicit big-endian variants.

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162036.90404-7-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/mem_helper.c | 48 +++++++++++++++++------------------
 target/s390x/tcg/vec_helper.c |  8 +++---
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index b7b6f581901..2972b7ddb97 100644
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
@@ -1023,7 +1023,7 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        env->aregs[i] = cpu_ldl_data_ra(env, a2, ra);
+        env->aregs[i] = cpu_ldl_be_data_ra(env, a2, ra);
         a2 += 4;
 
         if (i == r3) {
@@ -1043,7 +1043,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stl_data_ra(env, a2, env->aregs[i], ra);
+        cpu_stl_be_data_ra(env, a2, env->aregs[i], ra);
         a2 += 4;
 
         if (i == r3) {
@@ -1364,7 +1364,7 @@ Int128 HELPER(cksm)(CPUS390XState *env, uint64_t r1,
 
     /* Process full words as available.  */
     for (len = 0; len + 4 <= max_len; len += 4, src += 4) {
-        cksm += (uint32_t)cpu_ldl_data_ra(env, src, ra);
+        cksm += (uint32_t)cpu_ldl_be_data_ra(env, src, ra);
     }
 
     switch (max_len - len) {
@@ -1373,11 +1373,11 @@ Int128 HELPER(cksm)(CPUS390XState *env, uint64_t r1,
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
@@ -1956,7 +1956,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        uint64_t val = cpu_ldq_data_ra(env, src, ra);
+        uint64_t val = cpu_ldq_be_data_ra(env, src, ra);
         if (env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
         }
@@ -1993,7 +1993,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        uint32_t val = cpu_ldl_data_ra(env, src, ra);
+        uint32_t val = cpu_ldl_be_data_ra(env, src, ra);
         uint64_t val64 = deposit64(env->cregs[i], 0, 32, val);
         if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
             PERchanged = true;
@@ -2029,7 +2029,7 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stq_data_ra(env, dest, env->cregs[i], ra);
+        cpu_stq_be_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint64_t);
 
         if (i == r3) {
@@ -2049,7 +2049,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 
     for (i = r1;; i = (i + 1) % 16) {
-        cpu_stl_data_ra(env, dest, env->cregs[i], ra);
+        cpu_stl_be_data_ra(env, dest, env->cregs[i], ra);
         dest += sizeof(uint32_t);
 
         if (i == r3) {
@@ -2066,7 +2066,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     real_addr = wrap_address(env, real_addr) & TARGET_PAGE_MASK;
 
     for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
-        cpu_stq_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
+        cpu_stq_be_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
     }
 
     return 0;
@@ -2325,11 +2325,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
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
@@ -2356,9 +2356,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     pte_addr += VADDR_PAGE_TX(vaddr) * 8;
 
     /* Mark the page table entry as invalid */
-    pte = cpu_ldq_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
+    pte = cpu_ldq_be_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
     pte |= PAGE_ENTRY_I;
-    cpu_stq_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
+    cpu_stq_be_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
@@ -2700,7 +2700,7 @@ static int decode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
     if (ilen < 2) {
         return 0;
     }
-    s0 = cpu_lduw_data_ra(env, addr, ra);
+    s0 = cpu_lduw_be_data_ra(env, addr, ra);
     if ((s0 & 0xfc00) != 0xd800) {
         /* one word character */
         l = 2;
@@ -2711,7 +2711,7 @@ static int decode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
         if (ilen < 4) {
             return 0;
         }
-        s1 = cpu_lduw_data_ra(env, addr + 2, ra);
+        s1 = cpu_lduw_be_data_ra(env, addr + 2, ra);
         c = extract32(s0, 6, 4) + 1;
         c = (c << 6) | (s0 & 0x3f);
         c = (c << 10) | (s1 & 0x3ff);
@@ -2735,7 +2735,7 @@ static int decode_utf32(CPUS390XState *env, uint64_t addr, uint64_t ilen,
     if (ilen < 4) {
         return 0;
     }
-    c = cpu_ldl_data_ra(env, addr, ra);
+    c = cpu_ldl_be_data_ra(env, addr, ra);
     if ((c >= 0xd800 && c <= 0xdbff) || c > 0x10ffff) {
         /* invalid unicode character */
         return 2;
@@ -2797,7 +2797,7 @@ static int encode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
         if (ilen < 2) {
             return 1;
         }
-        cpu_stw_data_ra(env, addr, c, ra);
+        cpu_stw_be_data_ra(env, addr, c, ra);
         *olen = 2;
     } else {
         /* two word character */
@@ -2807,8 +2807,8 @@ static int encode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
         d1 = 0xdc00 | extract32(c, 0, 10);
         d0 = 0xd800 | extract32(c, 10, 6);
         d0 = deposit32(d0, 6, 4, extract32(c, 16, 5) - 1);
-        cpu_stw_data_ra(env, addr + 0, d0, ra);
-        cpu_stw_data_ra(env, addr + 2, d1, ra);
+        cpu_stw_be_data_ra(env, addr + 0, d0, ra);
+        cpu_stw_be_data_ra(env, addr + 2, d1, ra);
         *olen = 4;
     }
 
@@ -2821,7 +2821,7 @@ static int encode_utf32(CPUS390XState *env, uint64_t addr, uint64_t ilen,
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
2.52.0


