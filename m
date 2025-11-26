Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D04D11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM2d-00036N-Bb; Wed, 26 Nov 2025 15:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2b-00032T-0M
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2X-0002Q0-Rd
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:04 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso1058985e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188580; x=1764793380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WS7GKcpVsm6chESD7cJOz+J25JMyZfvS0l7pjZVz5Jw=;
 b=gfWFNVTDMTPtfJKjBhIyO3E76L4Sag7KK9ygOYr0I/v5lNIz1+XhKaLdbhZBfRldYM
 H1s0sOD0NvILe6OLd8+ekjKOI8QIYXbcHjM+OXFQ8f7Hx71bzO9VGmpEjfyAzi9ZII9N
 q534oWZD+KYbn6B8z7RZ+XtQtMv2Ls8FEWn8IhTkx69L7op3FrWI262WNuW6T0bpbAi4
 zBNY6yrLma4yukfiFOK7mabDSQLLue3fMhf+M19RBNNNzos/3Ak//yHCJrRJc9lXqEMf
 RU02d/Z3ta/+jmfRdYBJtiHil8hNIQ8Q7iVqFh4dIvdF/4CmdjjOyit3btvyf2gaRgIF
 Ydyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188580; x=1764793380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WS7GKcpVsm6chESD7cJOz+J25JMyZfvS0l7pjZVz5Jw=;
 b=Cs9oZzSrfKi8VJ3AUmZlmp7jC5m5oizKPXTtC++YeVdJX+Kyr+ARgbHoU/2EQXGYDY
 JgIDXaKUqBVMkYpHxVIodaLd6tmhMTktY7viXmWZ/yA7vRDyOH8pgM7RghpaYTJ7y2FW
 EAZn6d33dQto9AHjCxkZJHCa8i3uBtqNf32WJxviREiGQxVuwY2V84bs2ASQP9NKuobz
 gcGF8hxvTPxAcyIcqqMTj4DHn1eiHArx/XhMeKA1gWxIcMNUhzb6Y2U+HPjKOD1H9IJw
 Z7wpeF+edAkaJy+CQ0ynpklNqUYBsI4xBAJjby8Dzrxp7KZo7xLQ1lhbhlX9WYak6YFx
 JUjQ==
X-Gm-Message-State: AOJu0YwhDyLgG+hOWLzbKy2D34mdEYonjLV4wGKBZUt10xbkgDMqxixh
 sjB14G47jAt0Mq1r6rJSzZgc4Q8vZe5+8IqDDqBC+GfnkSmYVsrHC5KeYS5Tee/efPMMyVB7m7U
 MkUFMdf+2aC71
X-Gm-Gg: ASbGncsbdZIsV/8UPbHIjG6fNGQD0QP0F2coQlen8BlBXaBAwwAY7eyi8+fXCl/41QR
 kezO5haKnabxFIjLVYl+RiKc9BAFOjEPOmkas5svYN86ZidOWNXcyAMfVue4X2+6H4WRc9wiQds
 1a0bThMrTEaDep8gp0rmdsNZ6bgkhH7sjBHX31aKNajGgXHvCCAz1+dXe1ceI+fOvg8rVDmyct3
 zQ2wD7hNVoTfuJLMnYuytY56b+IYucp+AWaIzMz2UeODijhdcDRjFFdfeZ+DWE2PJ6V8YrW8Yaf
 uzwG1wWD2ua5kInVEuyxpuJOwghD5cXpH/devu5QBmVBsIQUvcrjdFLrKprddgGB72OoszAbQpQ
 R2pyYwyykRUMyj9IH24tEALZse3TlW/1RC/vPE5N5JbN9VRdnv9Ahmp1STD4JFu06NGpYSma/Xy
 JJOgyQrSWJThZ+/Ucz1shxVOdj21vuk/cIeCFe8+Pr6sRYIlLcfnvNopm7uYhB
X-Google-Smtp-Source: AGHT+IH2JJSaP/fggN4tgfIi3FH8bMK6jCYSBBgIjfhCJvYRm5HMx88CWzkZ11caRFE6NYbL0pA1Ug==
X-Received: by 2002:a05:600c:3553:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-477c0174840mr194724595e9.6.1764188580038; 
 Wed, 26 Nov 2025 12:23:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040c70c5sm52411705e9.4.2025.11.26.12.22.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:22:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH-for-11.0 v3 08/22] target/s390x: Use big-endian variant of
 cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 21:21:44 +0100
Message-ID: <20251126202200.23100-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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


