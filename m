Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02218CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcux-0001IC-T2; Wed, 06 May 2026 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuY-0000Ne-Qw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuW-0001xh-Nt
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso3309585e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076454; x=1778681254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EBCpT98Uv+V2PVW74Tin5zin5w/ebNQTmy7hJrYTEJU=;
 b=p6olrGVgmY2ybTXOEEYcs+pO8IkXWiq4X5NLUSnxvJprj+4sunAB+uBcNvNvn/gF0K
 3iFd1wLbwgasuE/t0/IM0LFjeKG0s278HoglHnbcm7nyHwkyPNDdtpEpiWzryzYtLXXp
 HVUWOdOUMjESBZwCmnY5u4/9n09cMWGRyOqsqCA4ZTjestebP/bxXCHKau0uK5Djo2Wc
 oNz4wFXA/cgRWOArVm6xltTwN1+2DjRCDXzGniBzCfVIz0NCEU/HXvpbN1YBRQMTzka2
 ErRuURbTyPT1IAOZO7bRek5FfsDe8GnJLOfqSY4K3h5BuQbZoFQU+OcEtJFWH2KMA/a+
 SZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076454; x=1778681254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EBCpT98Uv+V2PVW74Tin5zin5w/ebNQTmy7hJrYTEJU=;
 b=b3UBs/N/yj2VmvZXE3T7UksmQxGstHh1FbXOsSE3fEsY/n3OrM61zVhVvJZZcVw3/L
 qluA4DW4RMEzByQV751qkojRyPjZHc1mOqXmuindamtnaLGvWo3VLSIRZQOT0IWHcPwW
 13It5kPxFWvwFGHkBrQSWyZJ0zLRgxWrhzXtLvlO4fu77Jxmv42QWiyxyZYNEWLx3JtP
 +OUBNEIL8rXTOO1r5Bcg6IB14QTU4Dw1z5mZdZREmqjXNYQuEjJMZd6x6cuu02TJNOrh
 wOdwqlJiMo07B+3K14egongOwMaJKbNRRW3Tp8Ya3PcoGIGonZlsG92Q9Wf1gES2Jv+S
 EfYg==
X-Gm-Message-State: AOJu0YxBl/5HcnCE14ylQzL4qw0iCl2sYBuOkCx10VRe6+X+zOyMZlyl
 Bb0Lso3UjiesHweMrpB1G/zY5/9foXEjtcUoXyG/uB+IboDS3NXMABlhWJQPnUJvzzKiyryteTi
 COulGEt4=
X-Gm-Gg: AeBDieuEVYAm11xad4u72+oXfho9+ODTCE2wUzoGZPGktNRtpV5KmxU0Vu1rRBESCl+
 D+sgx+yZzepYfmK3YJtkUlUfXe0R3/sKmriSBx0NpQ1ShwWA1xSJTxquA22KlcHb8LH2T0f0tc1
 LjTy2KgFsMt7yhTcmL08qGzJuc75J6A2Xun7fHWOF8HddRcdmE2glZnVB5nZeyBvJg3oOTyLkz+
 HSoTYswfMlUM8L7LKVTpEuT2OoUyZOAhh1MmfKh+0FCaB/q06B8eZugS48C8XGLV5KumdMbHLQd
 +EpAFcDVPqdacJ3ozGAWs+79maYUY4YgLt+Gu3Km34S+6BFkDNFZKQgG8f0FWXYAbXmWk7EZvk1
 9/kJ2E4wXiKXYOuZGjX0vCvazPPQnxeh8uryhXFkYtdtvwjV4PJ+iS2fqSkrhhOdfqGt8RKcGiH
 bbesK4TyMsShjdt4TRIYbNQ9byAZixEuUOgPSd5s+CMDAkNhkP0qlZQ8j5eKZ6e0ery34xRQWPh
 RGvAROTHsg=
X-Received: by 2002:a05:600c:1d18:b0:489:149a:f9e7 with SMTP id
 5b1f17b1804b1-48e51f483d8mr60028005e9.27.1778076453815; 
 Wed, 06 May 2026 07:07:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312de08sm18716335e9.17.2026.05.06.07.07.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 092/110] target/s390x: Compile vec_helper.c as common unit
Date: Wed,  6 May 2026 15:55:04 +0200
Message-ID: <20260506135524.20617-93-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In order do build vec_helper.c as a common unit we need to
replace:

  "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"

and update the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-7-philmd@linaro.org>
---
 target/s390x/tcg/vec_helper.c | 34 +++++++++++++++++++++++-----------
 target/s390x/tcg/meson.build  |  2 +-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index 304745c971b..98eecd9fde6 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -16,7 +16,8 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
 
 void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
                          uint32_t desc)
@@ -42,20 +43,26 @@ void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
 
 void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    const uintptr_t ra = GETPC();
+    MemOpIdx oi;
+
     if (likely(bytes >= 16)) {
         uint64_t t0, t1;
 
-        t0 = cpu_ldq_be_data_ra(env, addr, GETPC());
+        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+        t0 = cpu_ldq_mmu(env, addr, oi, ra);
         addr = wrap_address(env, addr + 8);
-        t1 = cpu_ldq_be_data_ra(env, addr, GETPC());
+        t1 = cpu_ldq_mmu(env, addr, oi, ra);
         s390_vec_write_element64(v1, 0, t0);
         s390_vec_write_element64(v1, 1, t1);
     } else {
         S390Vector tmp = {};
-        int i;
 
-        for (i = 0; i < bytes; i++) {
-            uint8_t byte = cpu_ldub_data_ra(env, addr, GETPC());
+        oi = make_memop_idx(MO_8, mmu_idx);
+        for (int i = 0; i < bytes; i++) {
+            uint8_t byte = cpu_ldb_mmu(env, addr, oi, ra);
+
 
             s390_vec_write_element8(&tmp, i, byte);
             addr = wrap_address(env, addr + 1);
@@ -191,20 +198,25 @@ void HELPER(gvec_vperm)(void *v1, const void *v2, const void *v3,
 void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
                   uint64_t bytes)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    const uintptr_t ra = GETPC();
+    MemOpIdx oi;
+
     /* Probe write access before actually modifying memory */
     probe_write_access(env, addr, MIN(bytes, 16), GETPC());
 
     if (likely(bytes >= 16)) {
-        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC());
+        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, ra);
         addr = wrap_address(env, addr + 8);
-        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 1), GETPC());
+        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, ra);
     } else {
-        int i;
+        oi = make_memop_idx(MO_8, mmu_idx);
 
-        for (i = 0; i < bytes; i++) {
+        for (int i = 0; i < bytes; i++) {
             uint8_t byte = s390_vec_read_element8(v1, i);
 
-            cpu_stb_data_ra(env, addr, byte, GETPC());
+            cpu_stb_mmu(env, addr, byte, oi, ra);
             addr = wrap_address(env, addr + 1);
         }
     }
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index d1c60135411..ed6441f6f44 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -3,7 +3,6 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
-  'vec_helper.c',
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
@@ -11,6 +10,7 @@ s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'fpu_helper.c',
   'translate.c',
   'vec_fpu_helper.c',
+  'vec_helper.c',
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-- 
2.53.0


