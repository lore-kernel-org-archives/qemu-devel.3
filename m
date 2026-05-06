Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3EBCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuz-0001aV-QO; Wed, 06 May 2026 10:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuu-00017A-RE
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcur-0001zN-5j
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so63801635e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076471; x=1778681271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NjD38AF72kHQcdJLp03kxhc3tCZ7YiQ75NzgoKjvE9A=;
 b=lxXYNLnegtkZ6QxWuXFFyiTKzzzUyzxIlkZbnz8qL7NoO7Hz8haDEKUujS7ukGDEHN
 az/N9iPHHIUarAORoR4riHZB7PJDJAZh5itKcPv45WMzicQyMYe51N/5/ALerqX6RDYQ
 jz+h3QsgUD4U1nkMy7OyLUJgQdM5df8PoAwnCRUjhZ1IV8GNkDqhWWi3m/KmDEM9orPk
 qPyQoywos1wsjhqW1ZC3a48V1fHdbwcBdyRMTM4Ra4l+VnKAlq3VLNayTORKfeyrfbPL
 x+dlxvsOhNzQDPuOKnUHGye/+NH6plBIHQfnl1Pss/O5qtZ/4WOWi5aMZFFzfuAkfHPP
 IpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076471; x=1778681271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NjD38AF72kHQcdJLp03kxhc3tCZ7YiQ75NzgoKjvE9A=;
 b=mPCR4WPRZHwTwIbh/tV02lmWu20p/GmaShqu1+mxwHooFKc5HCA+WmU+Q98+ywcois
 Qg0hjz6llLyrHqn+tedL3BIOEZkr49DNwQGXWC6WhPe+SVbF4Fz/MeXAGQSW8oV7ood4
 mLAtG72R1zwtdKZI9ZXGLOY9YDI7HuoN6djBxkv21kdQHO344u+wJIzQsJ4tIqPyOLs6
 edYhDj1qEJ7+p+erkrdMED7QsPw124Kw9roJDt2t4KUZc2MJPHSk1eH9XECugf4j8Egs
 PTRXev10Z4YyY9q/VxAEFlW84P7rLFdWEFjspfKfIrpwjSfVl4usUB2JQ9I+FqJAfY+h
 U0iw==
X-Gm-Message-State: AOJu0YzKTmDIWs9EyGGKF3UGuuv5HaMx5dC8N2+m4hS6WzQ5uTMpdPxA
 25xvFpYRzXHFe38zo9BkQARyhaBmv1Wb/NmwkdscWn1eFBe3BB0RQH/2Sy3bltVJFAsHPn4dpBz
 2ZVkt72o=
X-Gm-Gg: AeBDiev7IdBYl9cS41PfdhdlGSaAVo0qEwxRva+ffaXnaNVf5NX73fIH9sx1ledJeTu
 7BNEsVkPsnTKEcrq6IB0Qg4fEiVWwk5B0kt9/7uScBguVe8A3bm7GfbNmAJ3j0uBQDncQqiciuo
 lqNMU3bdlA/9tcmbYL76ZB4GIVO8XZc8P588klP7RWNE+6HlwqR8TxPjIM8Y4GhWR6RYXhtCCOy
 2HsccT4UbxFQRWd1zJyHzrfT/aPCE0aRc/muD73bdiVg6ic6rLPawG+XUrUdF71Ip6zo+NWcgJ+
 VldkR9VeT6faPq2LWOP838CMo8eM9NYzLTdC4Cl68x+MV30FtmJrPLi5yAl1qaiBWcA+3U3vHV7
 F1HACKmQkdHOGwcD8oEh8g+CEYlK2wAGWR9Z6hvr+qslBkMP/wWWWWlnsX4of87fCWm+hPbcL1C
 Q5+mNvQJTb66BxeTK5V4ZbM5yIXxcjd260STQnjrUfLJkNlTklH+M/6I5JJ5HoO38ZTa+w1Aikc
 NMpUivjabw=
X-Received: by 2002:a05:600c:4e43:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48e51f4c1e5mr72058645e9.21.1778076470551; 
 Wed, 06 May 2026 07:07:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53141f41sm17510765e9.26.2026.05.06.07.07.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 094/110] target/s390x: Compile crypto_helper.c as common unit
Date: Wed,  6 May 2026 15:55:06 +0200
Message-ID: <20260506135524.20617-95-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

In order do build crypto_helper.c as a common unit we need to
replace:

  "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"

and update the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-9-philmd@linaro.org>
---
 target/s390x/tcg/crypto_helper.c | 39 +++++++++++++++++---------------
 target/s390x/tcg/meson.build     |  2 +-
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 074d745eb3f..ae392bce0e7 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -17,7 +17,7 @@
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 
 static uint64_t R(uint64_t x, int c)
@@ -123,44 +123,44 @@ static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
 static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
                             uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
-    for (i = 0; i < 8; i++, addr += 8) {
+    for (int i = 0; i < 8; i++, addr += 8) {
         addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
+        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
     }
 }
 
 static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
                              uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
-    for (i = 0; i < 8; i++, addr += 8) {
+    for (int i = 0; i < 8; i++, addr += 8) {
         addr = wrap_address(env, addr);
-        cpu_stq_be_data_ra(env, addr, a[i], ra);
+        cpu_stq_mmu(env, addr, a[i], oi, ra);
     }
 }
 
 static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
                               uint64_t addr, uint64_t a[16], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
-    for (i = 0; i < 16; i++, addr += 8) {
+    for (int i = 0; i < 16; i++, addr += 8) {
         addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
+        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
     }
 }
 
 static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
                                  uint64_t addr, uint8_t a[16], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
-    for (i = 0; i < 16; i++, addr += 1) {
+    for (int i = 0; i < 16; i++, addr += 1) {
         addr = wrap_address(env, addr);
-        a[i] = cpu_ldub_data_ra(env, addr, ra);
+        a[i] = cpu_ldb_mmu(env, addr, oi, ra);
     }
 }
 
@@ -200,13 +200,14 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* KLMD: Process partial/empty block last. */
     if (type == S390_FEAT_TYPE_KLMD && len < 128) {
+        const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
         uint8_t x[128];
 
         /* Read the remainder of the message byte-per-byte. */
         for (i = 0; i < len; i++) {
             uint64_t addr = wrap_address(env, *message_reg + processed + i);
 
-            x[i] = cpu_ldub_data_ra(env, addr, ra);
+            x[i] = cpu_ldb_mmu(env, addr, oi, ra);
         }
         /* Pad the remainder with zero and set the top bit. */
         memset(x + len, 0, 128 - len);
@@ -248,6 +249,7 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                             uint64_t *buf_reg, uint64_t *len_reg)
 {
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t tmp[256];
     uint64_t len = *len_reg;
     int buf_reg_len = 64;
@@ -262,7 +264,7 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
         qemu_guest_getrandom_nofail(tmp, block);
         for (size_t i = 0; i < block; ++i) {
-            cpu_stb_data_ra(env, wrap_address(env, *buf_reg), tmp[i], ra);
+            cpu_stb_mmu(env, wrap_address(env, *buf_reg), tmp[i], oi, ra);
             *buf_reg = deposit64(*buf_reg, 0, buf_reg_len, *buf_reg + 1);
             --*len_reg;
         }
@@ -279,7 +281,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     const uint8_t fc = env->regs[0] & 0x7fULL;
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
-    int i;
+    MemOpIdx oi;
 
     switch (type) {
     case S390_FEAT_TYPE_KMAC:
@@ -300,9 +302,10 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
 
     switch (fc) {
     case 0: /* query subfunction */
-        for (i = 0; i < 16; i++) {
+        oi = make_memop_idx(MO_8, mmu_idx);
+        for (int i = 0; i < 16; i++) {
             param_addr = wrap_address(env, env->regs[1] + i);
-            cpu_stb_data_ra(env, param_addr, subfunc[i], ra);
+            cpu_stb_mmu(env, param_addr, subfunc[i], oi, ra);
         }
         break;
     case 3: /* CPACF_*_SHA_512 */
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index ed6441f6f44..36cb0e079ed 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -1,11 +1,11 @@
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'crypto_helper.c',
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'crypto_helper.c',
   'excp_helper.c',
   'fpu_helper.c',
   'translate.c',
-- 
2.53.0


