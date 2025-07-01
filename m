Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E320C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYIH-0004Zg-FW; Tue, 01 Jul 2025 06:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYI6-0004UR-CA; Tue, 01 Jul 2025 06:32:42 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYI3-0002Eo-HX; Tue, 01 Jul 2025 06:32:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so3889710b3a.2; 
 Tue, 01 Jul 2025 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751365954; x=1751970754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5xqQGmlWDxi1LmZ2ClirqJ/75e4RmGThjr5rHPhrog=;
 b=GT4FFM6+X9ygT5xq8Qd5gOKrQY/vVzgmLUV4hjo/6JR+XzAMCw8F3H+EX1z4E14xw8
 u36B+N3+xB7XBBN7i5NaPNZ73UlNfvnoutBfD8poMcwGaaz5WYz+iAJoCSnyCFOXe+8x
 2BXUgEeVDRGsNcM1UPwSv0AGDQrfhvQ9oZjc+1H8VFB6pQk9lYibo25piAiY2+/T508M
 YHt2A5gOVm5f+WaC4LegbcthRxMsAcZDs+KG07/UymUPAQCzjMNIkxiq8dWkvfhdD7iZ
 LiQJQCQhCoOtVlbmJdeD5H5m9wp6balF4pjx26WIHXQdSdQ+v+PE8C8qsdwnnktIyJ4j
 zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365954; x=1751970754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5xqQGmlWDxi1LmZ2ClirqJ/75e4RmGThjr5rHPhrog=;
 b=Ydu+1cvYwdrsyuBP98ROtLJxw3FSfEgpbf2hqSqCBqNGsVxwCOkwoilfl3/1RXOD7u
 P9mLZa61LwQzolbDH9nM4neXXuBcbqngssMhYnNw2lyeB5cEvkp0HYmoeUz60wUa3K9N
 KOsrBW5/XoxLrOXHFlDeE19g4n5K9qSFtWs0JFRcQkb9jkHH66l+qHDO8d6L9HlZtUoz
 rOY9vm8myWIj/LXjU7xOWDGIDUMUmEhtfGXX0dasFTA5OQd6mh0rlVwlMxT1hB4TnUIr
 BTfKziLKzibmVoSGioADn//YNKq99qF3Oer79vTbry/NZu7TVSl8GmcBUpZwLQ2TwPFy
 aInA==
X-Gm-Message-State: AOJu0Yybsd3zzpL+fwQYM3+miegtsWV/LNGyleSP8JmnIsXKaZnk+svW
 oJ+NPAmGYZwPOr+MHEf/g64k4H9Q3EvUtlG3BE+vhbsp7oygwcR2/gZqbJaTiWMTjfk=
X-Gm-Gg: ASbGnctLVT9cIILAghUXxP3EjmxMWPOx0YHwaCei++hzpYJN8LAK2iMI9CJODrjAEZH
 7TOY9SyEEb6Al2Dh0wYxaiXS1xC7rNXdmwNP7IUBUjuzDHAxCyjpV4jEs7lUqPMR3rAbu5jYfhk
 1uOvR8ze6AtBcKFkKG/IOyzSpYX//kDg96dBWRtW1JiJmxxyMBPi+gib/D9MFvj4DpICTtHfQia
 9+KYaxNe1dX0p+8VGOtcOoUd8fplV6IKfXPYbv/XYRJI8HdJdE+4rUOwReKP6bbuttcCDuA2jcr
 Tn+nmlAJN/z0XVh0anbzKjki9oMx3BGEy+eywJorJh6rQAvVOzPvfO7K7KiplK3lURHZKMXmIdw
 zHT9V9VKt7GPu9MNjxKsIsIrCs+7Kedpthpc29P7E5dI=
X-Google-Smtp-Source: AGHT+IG6uvXGmSbxW5lroVeFT11dBMl3BemDxljnjeavGNgNvSorTBzUTWNzfn4rg7C0szEO0UXzFg==
X-Received: by 2002:a05:6a20:2d0b:b0:215:dee4:4808 with SMTP id
 adf61e73a8af0-220a1292cb0mr29649925637.18.1751365954395; 
 Tue, 01 Jul 2025 03:32:34 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b34e31db02esm10172589a12.63.2025.07.01.03.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:32:33 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 01/12] target/arm: Fix VLSTM/VLLDM helper load/store
 alignment checks
Date: Tue,  1 Jul 2025 20:01:48 +0930
Message-ID: <20250701103159.62661-2-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations in the VLLDM
instruction, and in the store operations in the VLSTM instruction.

Manual alignment checks in the both helpers are retained because they
enforce an 8-byte alignment requirement (instead of the 4-byte alignment for
ordinary long loads/stores). References to cpu_*_data_* are still replaced
with cpu_*_mmu(), so that the individual word accesses themselves also
perform the standard alignment checks, in keeping with the ARM pseudocode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/m_helper.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 6614719832..251e12edf9 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -1048,6 +1048,9 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
 
@@ -1073,7 +1076,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
      * Note that we do not use v7m_stack_write() here, because the
      * accesses should not set the FSR bits for stacking errors if they
      * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
-     * or AccType_LAZYFP). Faults in cpu_stl_data_ra() will throw exceptions
+     * or AccType_LAZYFP). Faults in cpu_stl_mmu() will throw exceptions
      * and longjmp out.
      */
     if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
@@ -1089,12 +1092,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
             if (i >= 16) {
                 faddr += 8; /* skip the slot for the FPSCR */
             }
-            cpu_stl_data_ra(env, faddr, slo, ra);
-            cpu_stl_data_ra(env, faddr + 4, shi, ra);
+            cpu_stl_mmu(env, faddr, slo, oi, ra);
+            cpu_stl_mmu(env, faddr + 4, shi, oi, ra);
         }
-        cpu_stl_data_ra(env, fptr + 0x40, vfp_get_fpscr(env), ra);
+        cpu_stl_mmu(env, fptr + 0x40, vfp_get_fpscr(env), oi, ra);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            cpu_stl_data_ra(env, fptr + 0x44, env->v7m.vpr, ra);
+            cpu_stl_mmu(env, fptr + 0x44, env->v7m.vpr, oi, ra);
         }
 
         /*
@@ -1121,6 +1124,9 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
 {
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
     assert(env->v7m.secure);
@@ -1155,16 +1161,16 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
                 faddr += 8; /* skip the slot for the FPSCR and VPR */
             }
 
-            slo = cpu_ldl_data_ra(env, faddr, ra);
-            shi = cpu_ldl_data_ra(env, faddr + 4, ra);
+            slo = cpu_ldl_mmu(env, faddr, oi, ra);
+            shi = cpu_ldl_mmu(env, faddr + 4, oi, ra);
 
             dn = (uint64_t) shi << 32 | slo;
             *aa32_vfp_dreg(env, i / 2) = dn;
         }
-        fpscr = cpu_ldl_data_ra(env, fptr + 0x40, ra);
+        fpscr = cpu_ldl_mmu(env, fptr + 0x40, oi, ra);
         vfp_set_fpscr(env, fpscr);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            env->v7m.vpr = cpu_ldl_data_ra(env, fptr + 0x44, ra);
+            env->v7m.vpr = cpu_ldl_mmu(env, fptr + 0x44, oi, ra);
         }
     }
 
-- 
2.48.1


