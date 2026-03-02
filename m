Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2A4D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwysq-0001VY-RZ; Mon, 02 Mar 2026 03:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyso-0001VM-Se
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysn-0001Vx-25
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnFW0QusOQ9hOBMv83u5V0q3saz7qewGSXhZFjWhdLY=;
 b=W4qLoKoZJO2rYymDnsuXTSmJaIcjxoisxvT9akE431ZwsY61Fxi4dWL3Ja8jl/NX+xxFVD
 UBOrkApLsIwpSqAgrJeGablTLaLldytZjfUYYJ5oncUB6VIpFC/FJkBfH3DF9KXAIhm4cG
 vYklF8HmpSpbgoEj5oX9bssao8vOzfI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-4Xoz8URYMzi4yEHYM0oRGg-1; Mon, 02 Mar 2026 03:44:03 -0500
X-MC-Unique: 4Xoz8URYMzi4yEHYM0oRGg-1
X-Mimecast-MFC-AGG-ID: 4Xoz8URYMzi4yEHYM0oRGg_1772441042
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837a71903aso25388695e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441041; x=1773045841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnFW0QusOQ9hOBMv83u5V0q3saz7qewGSXhZFjWhdLY=;
 b=m1wZQVjePNFE1BpTa0QgRBn5SMmgQi6VkZYwwiyzGkTz8unvN9ANIgmNW0Nw7hy774
 +//3YCCn7RspljgQLWSb3X8iGAfENXy8pdKzeI0AuUG33GeMf87oWhz8Ji0sGBTfPL3r
 dzxlcfPVZJY4+Q4lEGceyBka7PLDx4jlFVNfg8cSUiQb40ZatHW3M8xV1JHi4vHKLW6X
 SuMcdEEbmTpIUtOicR94DagmljKkFFE5HgN1cpmLe5bTm2KI5Uma5yaF7koLsBQTpUQW
 zl8MYq2vuCAsqiBvVAKQQ2mNxQSqr//S1092Con3euvxi3pZsJSw0+OcP4hroMX6UCNy
 Mk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441041; x=1773045841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GnFW0QusOQ9hOBMv83u5V0q3saz7qewGSXhZFjWhdLY=;
 b=BwZogFguYMXIG4K3OOHhCBaDONK8Rux/bHXHQCQgraOZlmS6jt+AXejWOYvcN2Ec65
 KPeAdO9cIogHq0I97vhiJxEpK0ZJGzo9yFg2vxrycwrTMl8BBqbZIIKt0gMtKJH/Yapw
 2/UdlnwYJbvZvL04w3UL0Xs5b9yir9bNPmehctuj+wgfQ/qfQ3yPoyOuK8EbmItp081j
 XMhlaSiWrKGxLo5RV4y2YJOBKYFBe+QUdyenqUw307JbsJIpnvKBM01DVb1Uvmw1o+xW
 g55cFGKm6gu9LykeQVm5juRz4+5h/YMd3lUDlYhgrLL2E+x4LFGB7llJsFmEh8/vggNl
 YwsA==
X-Gm-Message-State: AOJu0YzOFwcLg5XPZ9jrW4rb0ZT199fTBKJ0jRTrj65fluMGTu5pgEsG
 SmCXYLGFXqs+DvUw3x/U9bZLdOQMLLT01a/E//NKOaFyNIhZzzc48p+hybIF3SuI2GQ+qm2obGw
 aYaOAt+wLtGNxO4ZlBPvx5m5ZoYbdVnhNIjw1lqPvrf2ft7jKV17hrS+KAfZNtmkMw9UfQsjLQE
 2fujDwcMAQtJ5jh6fwekWKH/Tuza4mXMWbl4LM8UKh
X-Gm-Gg: ATEYQzycwTT7okCDjfeNbsPRxUrIWf4t28v0m7d1UouamVcAu7kI0BV8fWlmZWhUZCa
 J1S1JQ2HxpXQfPWQiObbk6vredriaUnC13aDAm8FmOXaoqEd8aeSI7lmflzccNszBftonHEITWq
 U1HpMOCzbqXAEDpVkB2AHAeu48vlD7E0qttJBAe6wKRRLejDhbTTHfqYgRK7kLjAStdrtabsRp7
 80dHFuiEu3RrQIwkv4ZqATdci+7ysSwX7jjSRyqA9WxOuySwwYZ8kxZRpsqA+EuT14sLN79VOMl
 eoaKBKaydkpoAR8jnP7Kno65d2VGHZtRb6X+XSWDkpOzRoQa8DCHP3ztZeynOoTg2lvXlsNHhuS
 Bj5PNdv8SDO+JuQuQcl7RZpTkeQdROyyAaeVbhYBLf96Nb/wghqySbIqOPKs+HQcQ330duydJQX
 T8738tihMtyE2Rvg0et5Qbdo5uXTg=
X-Received: by 2002:a05:600c:444d:b0:483:885:f0b0 with SMTP id
 5b1f17b1804b1-483c9c243fbmr210797095e9.35.1772441041039; 
 Mon, 02 Mar 2026 00:44:01 -0800 (PST)
X-Received: by 2002:a05:600c:444d:b0:483:885:f0b0 with SMTP id
 5b1f17b1804b1-483c9c243fbmr210796625e9.35.1772441040539; 
 Mon, 02 Mar 2026 00:44:00 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439bb686a32sm1968294f8f.13.2026.03.02.00.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:43:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 006/102] target/i386: emulate, hvf: move x86_mmu to common code
Date: Mon,  2 Mar 2026 09:42:01 +0100
Message-ID: <20260302084338.473368-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260223233950.96076-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/{hvf => emulate}/x86_mmu.h |  0
 target/i386/{hvf => emulate}/x86_mmu.c | 14 +++++++++-----
 target/i386/hvf/hvf.c                  | 10 +++++++++-
 target/i386/hvf/x86.c                  |  2 +-
 target/i386/hvf/x86_task.c             |  2 +-
 target/i386/emulate/meson.build        |  1 +
 target/i386/hvf/meson.build            |  1 -
 7 files changed, 21 insertions(+), 9 deletions(-)
 rename target/i386/{hvf => emulate}/x86_mmu.h (100%)
 rename target/i386/{hvf => emulate}/x86_mmu.c (95%)

diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/emulate/x86_mmu.h
similarity index 100%
rename from target/i386/hvf/x86_mmu.h
rename to target/i386/emulate/x86_mmu.h
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/emulate/x86_mmu.c
similarity index 95%
rename from target/i386/hvf/x86_mmu.c
rename to target/i386/emulate/x86_mmu.c
index fe44d2edf4a..b82a55a3da7 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -19,10 +19,10 @@
 #include "qemu/osdep.h"
 #include "panic.h"
 #include "cpu.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "emulate/x86.h"
-#include "x86_mmu.h"
-#include "vmcs.h"
-#include "vmx.h"
+#include "emulate/x86_mmu.h"
 
 #define pte_present(pte) (pte & PT_PRESENT)
 #define pte_write_access(pte) (pte & PT_WRITE)
@@ -99,6 +99,8 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
                           int level, int *largeness, bool pae)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     uint64_t pte = pt->pte[level];
 
     if (pt->write_access) {
@@ -127,7 +129,7 @@ static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
         pt->err_code |= MMU_PAGE_PT;
     }
 
-    uint32_t cr0 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    uint32_t cr0 = env->cr[0];
     /* check protection */
     if (cr0 & CR0_WP_MASK) {
         if (pt->write_access && !pte_write_access(pte)) {
@@ -179,9 +181,11 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
 static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
                      struct gpt_translation *pt, bool pae)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     int top_level, level;
     int largeness = 0;
-    target_ulong cr3 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+    target_ulong cr3 = env->cr[3];
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
     
     memset(pt, 0, sizeof(*pt));
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ce54020f003..0b3674ad33d 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -62,7 +62,7 @@
 #include "emulate/x86.h"
 #include "x86_descr.h"
 #include "emulate/x86_flags.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "x86_task.h"
@@ -254,11 +254,19 @@ static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descript
 
 static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_read_mem(cpu, data, gva, bytes);
 }
 
 static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_write_mem(cpu, gva, data, bytes);
 }
 
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 5c75ec9a007..2fa210ff601 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -23,7 +23,7 @@
 #include "emulate/x86_emu.h"
 #include "vmcs.h"
 #include "vmx.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "x86_descr.h"
 
 /* static uint32_t x86_segment_access_rights(struct x86_segment_descriptor *var)
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index bdf8b51ae67..b1e541a6420 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -16,7 +16,7 @@
 #include "vmx.h"
 #include "emulate/x86.h"
 #include "x86_descr.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "x86_task.h"
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index b6dafb6a5be..dd047c424a1 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -2,6 +2,7 @@ emulator_files = files(
   'x86_decode.c',
   'x86_emu.c',
   'x86_flags.c',
+  'x86_mmu.c'
 )
 
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
index 519d190f0e6..22bf886978f 100644
--- a/target/i386/hvf/meson.build
+++ b/target/i386/hvf/meson.build
@@ -3,7 +3,6 @@ i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'x86.c',
   'x86_cpuid.c',
   'x86_descr.c',
-  'x86_mmu.c',
   'x86_task.c',
   'x86hvf.c',
   'hvf-cpu.c',
-- 
2.53.0


