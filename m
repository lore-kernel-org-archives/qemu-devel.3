Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1ECCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gh-00056M-Dv; Fri, 29 May 2026 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GS-0004xZ-EL
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:06 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GO-0005X0-Ly
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:04 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69d7f4cc61aso3251416eaf.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084377; x=1780689177; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VbW6Hbyj3U6aT8UlGYOD2Cj2J91JoG8oSSN/XuQKEIk=;
 b=cDYFgd69CFaxn9F0AnVm67sxkt9ZKY3ofb+/Bi1IuPZZHNgbC/V7Ncp8Y9OeFSDrdw
 CTPtUz6bQ/3aM02IeDplVQ9mDMZzNK1IZMkuOExpdWETFCot/DxN0kVEZLei+ClH12PS
 NAFCghLySURWJEN4kZx5ma+apSaDvXEcZv8ao32KDISKiaXZkaORCkixCralvqhAEcnt
 awN1Y84q0EJy7avVQlh0AkEtYuDhAVT0uvnEhWEFPYop4+xJUN2WPMPrXRwQy2f1Dkr8
 FpTaOi/mgJ2HKQ6WmSCAd9mwoEpxH0xV8WQ4Vq8X1lisiB+6Io+ehXOitCn9x4R6R6cy
 CC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084377; x=1780689177;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VbW6Hbyj3U6aT8UlGYOD2Cj2J91JoG8oSSN/XuQKEIk=;
 b=EwelyDa/7cJfhjDzYwn0xkyAvHpxyptGsgX3tE4AB1MjbRakivck4EIP00NOunAXg4
 zMzVAr8rXuWesX4dSlVxVuFsD24Sye/rhlxLXeYli/k3WDjVZVoxCQ2Rqhf+SnOobdeq
 33eFo6NC48iA4ubMC7X8aJ42V4uYZlpvq44J8GYxxmDRiNnzrCwZQgMqM9T7S9pKOfgv
 98fihDJDwZpqcfE8jQyo+Eb/0ZDPB5O0Aj0PzJPgVUU480rh5xsDboXgcRurpTWSlT8U
 DbEtcJUzhZ0BjpoL/qpbsZNTibWcQHZOKL8HTAfN83bfqX7Ljux5+5BLYUpmoHd0YXAc
 aN0Q==
X-Gm-Message-State: AOJu0YzhK7oIXy2t4xMrdqwyy6o/vftaejLVorRQ38NQGTGwZMjda1xU
 jY9NTjeoCaTD/bM8NOAvA+C3Vav2j5XnnRD8LBwAF222qaq9CTdIVdOT
X-Gm-Gg: Acq92OELDG972xnKZIh+vDibK24BSBPKryODxgedEPg16HRiLm1Yus4L4xj9QlmKvLo
 MERIwCRtyfH8gCEwTWZL60qSycbWl9sXg7pTfdJswvQmS+un2scSpjcGfky8d4dBdJqjviDUwz/
 NxHLo1OpWoxLufLvK9H+a/QEEd+QlpD/VaDPFSdBz4PI6M3C7jwRWBt/AZOq2UI7rDKnPAm2BLq
 H5fjZESlNPgjwOuQUElvTsrRTqgUnAvwEYTx6Rn3Qq/2QvOhXskMv8colRodbYhb2Ty1OmOTcW1
 BBX9sVA/+kuGZVE8EQWVS+cZImtohjMY3JfkpBnw3Z6UriWTO1Pmt61qBifXJQPnPzCMQzMDv+o
 l1Xvw5u8y+fMVmdfEQuMCCvMz4ZbnV6IP8nb8HHdhHVb2XeA/flPh/IUezS5Lzc6UxBPjo2HPo+
 SHmlBMpz1BPwfzfvXwK6OCQAHk5qEA4q7ibdVWQKXjamU=
X-Received: by 2002:a05:6820:c82:b0:694:8fb2:2c35 with SMTP id
 006d021491bc7-69e104765bcmr440621eaf.2.1780084377473; 
 Fri, 29 May 2026 12:52:57 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:52:56 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:41 -0700
Subject: [PATCH v7 01/15] target/arm: implement MTE_PERM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-1-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=4761;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=hMnVVCR5aDsXksNo9hA/xVe759MtMSZHmHwiTMnpTcw=;
 b=eryx34ZM8YCj6tPqJP5zRYRnuFQcK7VT5G4vzXX3GjiKJhXUtShKnz/cWCZH2vPSEDLH9zdje
 +IeHg37QIl7BBCaY9GckuTIoHDCCa8/i7qmJVkRlJhD/2FIaWZ6hzQ2
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduces a new stage 2 memory attribute, NoTagAccess, that raises a
stage 2 data abort on a tag check, tag read, or tag write.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h   |  5 +++++
 target/arm/ptw.c            | 25 ++++++++++++++++++++++---
 target/arm/tcg/mte_helper.c | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f9c979d20b..9451df3813 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1181,6 +1181,11 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
+static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0a5201763a..6cb0fe5645 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3415,7 +3415,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
                                         ARMCacheAttrs s1, ARMCacheAttrs s2)
 {
     ARMCacheAttrs ret;
-    bool tagged = false;
+    bool tagged = false, notagaccess = false;
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
@@ -3425,6 +3425,18 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
         s1.attrs = 0xff;
     }
 
+    if (hcr & HCR_FWB) {
+        if (s2.attrs >= 0xe) {
+            notagaccess = true;
+            s2.attrs = 0x7;
+        }
+    } else {
+        if (s2.attrs == 0x4) {
+            notagaccess = true;
+            s2.attrs = 0xf;
+        }
+    }
+
     /* Combine shareability attributes (table D4-43) */
     if (s1.shareability == 2 || s2.shareability == 2) {
         /* if either are outer-shareable, the result is outer-shareable */
@@ -3456,9 +3468,16 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
         ret.shareability = 2;
     }
 
-    /* TODO: CombineS1S2Desc does not consider transient, only WB, RWA. */
+    /*
+     * The attr encoding 0xe0 corresponds to Tagged NoTagAccess and is only
+     * valid with FEAT_MTE_PERM (otherwise RESERVED, constrained
+     * unpredictable)). The presence of this feature is checked in
+     * allocation_tag_mem_probe, where Tagged NoTagAccess has its effect. See
+     * J1.3.5.2 EncodePARAttrs.
+     * TODO: CombineS1S2Desc does not consider transient, only WB, RWA.
+     */
     if (tagged && ret.attrs == 0xff) {
-        ret.attrs = 0xf0;
+        ret.attrs = notagaccess ? 0xe0 : 0xf0;
     }
 
     return ret;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a9fb979f63..bf35dc10ce 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -58,6 +58,27 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
+#ifndef CONFIG_USER_ONLY
+/*
+ * Constructs S2 Permission Fault as described in ARM ARM "Stage 2 Memory
+ * Tagging Attributes".
+ */
+static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
+                                uintptr_t ra, bool is_write)
+{
+    uint64_t syn;
+
+    env->exception.vaddress = dirty_ptr;
+
+    syn = syn_data_abort_no_iss(0, 0, 0, 0, 0, is_write, 0);
+
+    syn |= BIT_ULL(41); /* TagAccess is bit 41 */
+
+    raise_exception_ra(env, EXCP_DATA_ABORT, syn, 2, ra);
+    g_assert_not_reached();
+}
+#endif
+
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   uint64_t ptr, MMUAccessType ptr_access,
                                   int ptr_size, MMUAccessType tag_access,
@@ -117,8 +138,21 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     }
     assert(!(flags & TLB_INVALID_MASK));
 
-    /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->extra.arm.pte_attrs != 0xf0) {
+    switch (full->extra.arm.pte_attrs) {
+    case 0xf0: /* Tagged */
+        break;
+
+    case 0xe0: /* NoTagAccess */
+        if (cpu_isar_feature(aa64_mteperm, env_archcpu(env))) {
+            if (probe) {
+                return NULL;
+            }
+            assert(ra);
+            mte_perm_check_fail(env, ptr, ra, tag_access == MMU_DATA_STORE);
+        }
+        /* fall through */
+
+    default: /* Not Tagged */
         return NULL;
     }
 

-- 
2.54.0


