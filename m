Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2039E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHya-0001tr-Iv; Tue, 03 Feb 2026 10:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyS-0001Jg-FN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:54 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyP-00021f-3f
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43601e96f72so1768366f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131147; x=1770735947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jm6avVJZdcczFIoFxsC4aKZsgBH8BQs4lBtZL6M+lOM=;
 b=MhQR4QTwImV9u8IT9zp6Baml3a+65fiWFkXpGwF1dpFsB79DHZVRQDdJ2CxVezU56g
 cpdHlsHql4j0PiZiIRHcKuW5pH+YOxg8zUVm+qRspTaxjXE0TlJUOLZJpV3YCV+vDjgC
 ceyxdxRZKHlp++ECQb33gY7x9wEnAfQbF14UHgYs6kghbmCoAq+i5M8/trBBGCUegNPi
 m69kRDL6tJpLZ+neqF5jgRazAjSCWd9VaJ+7vm44iL/rbP54W0CcOI6T086bpr6hMviT
 S3BHEYO6WWRr//q0LZ8ljc/+JNbD3FbQ7MhsXl491aA7f2OO+xYd/k5qEdYHiSF7K1V5
 khUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131147; x=1770735947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jm6avVJZdcczFIoFxsC4aKZsgBH8BQs4lBtZL6M+lOM=;
 b=Ojri3l4UVzQESq31wQEllHvwZ4iQoNZHcp4b5N5Ju6LI6ibQvGUhvA4uBrrzXQT0uZ
 k/urR3YIO6/zViEQPPmiNXSMhlVBNJOONhK/EKji2m89KzaeQBR5tAcRJkkp4dDVNRkP
 LYFYT5pzcc8qYezhEdnFn7uM0WJZy6Obj2nsv9ubz6kU4l5YScWBC0or5FHqKzg3orvH
 BgguEDwmXf0eLa8Q2DyYbHGL9Iy3R39CXWijPpOK/8fGtPY+SY6xX7bevatYLLT4WIaf
 tQ/ljSYONGqthxbDF7sAzDS42pW61gR/AWesGLFejoUtKhrtV8qk3GvEaldokZ7TZe8V
 p3+g==
X-Gm-Message-State: AOJu0YwzW0x1iCoTfk0WJ913g2ee26eu2KZHLTv9K1SKVnCo8xrHRxRV
 56vMGVvx0UNDcpGR7gGLWSjypOn2Fs5jgNBkfTAFj6G9UHACb4Wi40R7H4zO7f5ipiB3/yp4z8I
 310FVCOg=
X-Gm-Gg: AZuq6aJttw2E8qQZlqhlkWVRdHODEpEo+mhUOZeBsnPwOR1oijAULzaUAzswpyJ1GEb
 3SAosF+EuAopG/uGXC/v/FFEm1h+Rev6D/x9Pg7Dk+6xb9j4sl9mrs9ZXaevAl9z+YkMQZPb1sr
 BIYb/Wq2qJJwzqLzpnvaf96Eo3IPqtc8gq6Sh8MQGepIgc/de61beILYh46U6GZKh40S8hB5xbT
 gB+p41tcUfGRHYY6JmPBdO10r5E9XVArv+vLGWj5cjtkR7FSoIbJlO7ZS0vJQu7RkS+dTSBV3yh
 e5VmuniOau7QugV8WfoqIscOzvMU4PgV6KU3OaxJo07q3KmVhQItePYPEOidBKgp6ufwoHh58X5
 yeAlBV508IsKBJoQ1hdecybtP1LB9cVuRx3sYjRoNZcVt/lcW5CVPUZCEeMc9G08ugbfcwhKuYt
 SNxWDtF/hiZib9Ag1whuRvp4CrMY4/d0uBdBx3//xQjlHDyKzcOI/QQzjKkBVE
X-Received: by 2002:a05:6000:26c3:b0:435:b7b9:afe5 with SMTP id
 ffacd0b85a97d-435f3a66f53mr21021559f8f.1.1770131146957; 
 Tue, 03 Feb 2026 07:05:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436142de842sm4194533f8f.30.2026.02.03.07.05.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/30] target/ppc: Introduce ppc_env_is_little_endian() helper
Date: Tue,  3 Feb 2026 16:04:15 +0100
Message-ID: <20260203150436.71907-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Centralize endianness check on MSR via a common helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-10-philmd@linaro.org>
---
 target/ppc/internal.h   | 5 +++++
 target/ppc/cpu_init.c   | 9 +++------
 target/ppc/gdbstub.c    | 2 +-
 target/ppc/mem_helper.c | 8 ++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index c3d3590cc89..e6e60de95a4 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -24,6 +24,11 @@
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
 
+static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
+{
+    return FIELD_EX64(env->msr, MSR, LE);
+}
+
 /**
  * ppc_data_endian_env:
  * @env: the cpu context
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0808284b722..c5cec7c2ed9 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7364,7 +7364,7 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
 {
     cpu_synchronize_state(cs);
 
-    return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
+    return !ppc_env_is_little_endian(cpu_env(cs));
 }
 
 static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
@@ -7456,11 +7456,8 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     CPUPPCState *env = cpu_env(cs);
 
-    if ((env->msr >> MSR_LE) & 1) {
-        info->endian = BFD_ENDIAN_LITTLE;
-    } else {
-        info->endian = BFD_ENDIAN_BIG;
-    }
+    info->endian = ppc_env_is_little_endian(env) ? BFD_ENDIAN_LITTLE
+                                                 : BFD_ENDIAN_BIG;
     info->mach = env->bfd_mach;
     if (!env->bfd_mach) {
 #ifdef TARGET_PPC64
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3b28d4e21c7..b19c0f1ea9c 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -84,7 +84,7 @@ static int ppc_gdb_register_len(int n)
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
 #ifndef CONFIG_USER_ONLY
-    if (!FIELD_EX64(env->msr, MSR, LE)) {
+    if (!ppc_env_is_little_endian(env)) {
         /* do nothing */
     } else if (len == 4) {
         bswap32s((uint32_t *)mem_buf);
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index ca84131d1a9..119dc1df233 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -420,7 +420,7 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         int adjust = HI_IDX * (n_elems - 1);                    \
         int sh = sizeof(r->element[0]) >> 1;                    \
         int index = (addr & 0xf) >> sh;                         \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);          \
+        bool byteswap = ppc_env_is_little_endian(env);          \
                                                                 \
         if (byteswap) {                                         \
             index = n_elems - index - 1;                        \
@@ -446,7 +446,7 @@ LVE(LVEWX, cpu_ldl_be_data_ra, bswap32, u32)
         int adjust = HI_IDX * (n_elems - 1);                            \
         int sh = sizeof(r->element[0]) >> 1;                            \
         int index = (addr & 0xf) >> sh;                                 \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);                  \
+        bool byteswap = ppc_env_is_little_endian(env);                  \
                                                                         \
         if (byteswap) {                                                 \
             index = n_elems - index - 1;                                \
@@ -479,7 +479,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,                 \
     t.s128 = int128_zero();                                             \
     if (nb) {                                                           \
         nb = (nb >= 16) ? 16 : nb;                                      \
-        if (FIELD_EX64(env->msr, MSR, LE) && !lj) {                     \
+        if (ppc_env_is_little_endian(env) && !lj) {                     \
             for (i = 16; i > 16 - nb; i--) {                            \
                 t.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());   \
                 addr = addr_add(env, addr, 1);                          \
@@ -510,7 +510,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,           \
     }                                                             \
                                                                   \
     nb = (nb >= 16) ? 16 : nb;                                    \
-    if (FIELD_EX64(env->msr, MSR, LE) && !lj) {                   \
+    if (ppc_env_is_little_endian(env) && !lj) {                   \
         for (i = 16; i > 16 - nb; i--) {                          \
             cpu_stb_data_ra(env, addr, xt->VsrB(i - 1), GETPC()); \
             addr = addr_add(env, addr, 1);                        \
-- 
2.52.0


