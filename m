Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F0CD0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqhd-0004Bm-U3; Tue, 25 Nov 2025 05:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqhb-000460-L5
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqhX-0001en-P1
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477a219db05so31662815e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068113; x=1764672913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBX0cTyOfypgSePFwe7y0VDhNeDc+UxNVe7O+z7zfxs=;
 b=Dxn8pj6UAaIX+ycTC8EyFnRuTd9V12LwNC7+9os/F6vrUCnoWux0soBewphoD65kcq
 ji6HV/3JwiKJeb16WJxxsSHO4jcWtKuJOQ29j5Z5T/86ymEUpLT5/rngwad61OHQXNNY
 g4wGLdAXjINTYqPq+5UC6ULYxp4+Jwlq56xsFAOUPTSKaLtoNYu9Auo7gQ7R2RV8/2h8
 JiDSpL4aIVAcQsI9IkFxh+na43/giw4Sd2ZSo4A7YH6/wV158+h/LFr9I67L0cDUsj8C
 SIqkzXIEfwsNFEHgmfLAeR7RyoAbO+nEIsdNHtb9fgvAxFxjsU7MYMuGDRvM39RVrvhC
 nBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068113; x=1764672913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBX0cTyOfypgSePFwe7y0VDhNeDc+UxNVe7O+z7zfxs=;
 b=XWErlD2emziDeo2vDvCDxjkgcBCSSOwjmN7aSj1OLKcJYwdrepIXX3PD1hiWCi04V8
 XUpc5UQ4revXtKqdR6wh1HqYocTZX7Mi9WRRYwUfHXJxJ12OwsfNFahPF9vPkDbg4n8f
 jK60QVkvRaVYY1QP7zEbgMNMiO34c+gtbNVdaae7NihimAcoAQhPDzuN5SKu/JqacU/S
 qOfzC4KhTygLk4yOHiYYChpiQKlqN31zc6kj3NJV7iDLAtpe4x5mUBiOyULOeFeCxi3X
 kAbYTz/DjAgtdE6L+NcSpFf7UnsB5RauVglLW2p3MxO2ZbJ4LfLoJq7PYyTLoteQbniS
 qFhg==
X-Gm-Message-State: AOJu0YwD2MKhZ51D0pbXvNsKlINoEKYgxGbkQSHXCTwWTci/YW751Lqm
 BO9ZJ8he9DRNdjnQ0jEZQkblTSnaCXYvDe1oz1wBbQCE1Krd15JxfVG22EEMX6OWO2GltNYW3Cz
 MvujCOOhckA==
X-Gm-Gg: ASbGncuG42Z9QV6ZA7Ldo+Ahl2kKnSOfVe4XOss44cNrKNtuWC+yCL/TxoYLe3Ylw3W
 YUnOxK5jpG4wLa7Z9uM6uHLOWG0pfUE0d0gdj5WpJ0UWSYZKcl9P54XsCokuwM9zfE/WAaNg+TE
 eeNQMykan9HRuZlA9MoMmzBWxsTKYki8sHZMBgFaSlGlh6cImNXxpy1778rX2JrBMIQWc846XJR
 hHdKIdA5wx0PMNb202K3xFFXL7HigW3kKrxuBrb03KBFQTBCHx0zXOdWsMG2U+QiYlVhENboTmk
 F3yNUkYB6dsvD1JYO53V85GQJ+U8tW3QEtIGkrdoMPc0IeCEnmahPrxmJnzCXFFp/+3nxTnbVeN
 t7sGZdacThD/1fFDSpDmdV19700yuOGcTp+fQyQltq59tHfnIuXtPd3ymnH9CvIZvVfRK6ewJW4
 zshnI4WkyOh6xSLFNfM2qKpZRMXCnF65xo/9xqgnEZDGPqhrbi7yjmB7414syy
X-Google-Smtp-Source: AGHT+IF10+EarZb+KODThEaCO/W17Ttqob+eAK+nkvNF/XmYe4Y37Mjtashzw+Ih+rlX0MbTGOS40A==
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-477c112f7b1mr145384405e9.29.1764068113305; 
 Tue, 25 Nov 2025 02:55:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4c13sm243662865e9.13.2025.11.25.02.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 02:55:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-11.0 05/12] target/s390x: Use little-endian variant of
 cpu_ld/st_data*()
Date: Tue, 25 Nov 2025 11:54:26 +0100
Message-ID: <20251125105434.92355-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125105434.92355-1-philmd@linaro.org>
References: <20251125105434.92355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
index 24675fc818d..482c3febf91 100644
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


