Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECF9CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 12:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNs6j-000642-Nw; Fri, 15 May 2026 08:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6g-00062b-Q0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6f-0000V9-2e
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso12687985e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778849851; x=1779454651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9LWXq81PmoJ4M5/Kig4f6Q90NNHPt9NWDEzmnCq//U=;
 b=tw4N09Jf25eURFmyJxHa16XHes1RUCP9z3OiYNuuCmwk2lKGwo2JTa2b20W0051e4A
 v7fLXURMl1cH0q7VgcLweVn2JX2HG8Q0i2Y9Cr/OHnKlIZgLMEV78ItsE8A2I4PO/IoZ
 PCiHParZEopsO+mCW0WxkSKYZzHXlLAnFj0zuCAbZa7MdH+qxVbU+kOVD/3oOhJ/bpqe
 XHYml4xIaHe0QstCUqE19foe6UILOa6sTaVl17NO67GcHi35F5M/Bt0GLESeAcVUiLEz
 NcGGYkSum0EKdsz0Igpw5OEHF+lRTy0oiVR4Ry/L34oJGPp2COZnOLUA31j4FQPMGZ2m
 twMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849851; x=1779454651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X9LWXq81PmoJ4M5/Kig4f6Q90NNHPt9NWDEzmnCq//U=;
 b=CitakSVMMWSs2OpwIqGKtX+McX/66KbLwr7HjrIiks8YKUPmm+ybXXYWak5bhWLXtV
 5FzUtjuUX48qE4sdNV9Sw+Br3flgrRh9VpaPxBeJa+6uQPGixr2vTzCpO+RIi5CQRj3K
 VvrwHxOCyON2eWwMy2t+qJHhI1TSTsFqXED8W5ktviGkNKbtWZ3V6Mwsq9u4Q/O6EY5m
 hcFbyJVyeKajepsL4zmrmE05QBwvbCOIFCmlD8TZzYOGPA+Tct1vtjBOVOZNfKlxvE5k
 02Q92InQgbNc2Q5r3nK3rvXV/1Dtp56lhPgWYsFi9Vsw2EqK/+MEkcEBKb2iN0lCBf5P
 xneA==
X-Gm-Message-State: AOJu0YwQ5TFvPxWkEf0ebR+1eEmi9N0HN17VuV83fBlVeM/JKpsh5YN0
 Ug7OpE3AkkuMvKhqDSJH1RGqyvQg2oDunZ873axDFLvh4yu24eOVYC6nP2p9WeK9jZiV2NJhP8U
 PfgRx
X-Gm-Gg: Acq92OEln9fVlk3VMw/leA0jr9DUF3bOF1v3v+TKQCXaMi9MSVH4toTdD2JtPtVJXIW
 Dld3bS7ozCmTwrR6rXlPhPVByWMZjPtTmJHDsXQGdd3xyLYblI6dzRy5EtAbfi/p47i22QnOTPq
 eJfRuK4dARKEcFqa9/WXMQGltCsI3FuAVTVHBk4A0TCtpbWUvVxVeDMEDTXnq0zspdKd2v0WIye
 71huR6J78QxZ2qaL8pD9u2GVd6gHmA4w1PZBO/m/+qJipOLxLUof8I3281jMEM1C6O4dE3yhtBE
 pNoQd7wdg0TgPnuqBApuHaDxozodcuoCGektrQqyj+n9kXy2XqaHsqBdZF7VysNMYIvMUHbAM63
 7Fb6v/IbIdWZcrGuDkr9+N+Mz81De1dXiYQ87VuVn4ibkLmfz0qTt+QFE22BDW25zTBYC5q67nW
 b3pppkRfDuTzG7Njqpo13B4gGEWKYOpelCo2DQOzmkVQRbcJN5t/95y1dNkL7/07hjdvcQKP5GP
 /12oir7txPxui1dh3H4tr2X6BgIqKcuImn5gC4+ZQONyO9KWb/j
X-Received: by 2002:a05:600c:b95:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-48fe60ea2dfmr55508855e9.11.1778849851236; 
 Fri, 15 May 2026 05:57:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm57526515e9.2.2026.05.15.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:57:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 1/3] target/microblaze: Convert to translate_for_debug
Date: Fri, 15 May 2026 13:57:25 +0100
Message-ID: <20260515125727.349675-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515125727.349675-1-peter.maydell@linaro.org>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
x86 and microblaze.  Convert microblaze to the newer
translate_for_debug method, as a step towards being able to remove
get_phys_addr_attrs_debug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/cpu.c    |  2 +-
 target/microblaze/cpu.h    |  4 ++--
 target/microblaze/helper.c | 25 ++++++++++++++-----------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index c6a456dd5e..a97c92a7b6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -428,7 +428,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
     .has_work = mb_cpu_has_work,
-    .get_phys_addr_attrs_debug = mb_cpu_get_phys_addr_attrs_debug,
+    .translate_for_debug = mb_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 068da60529..b9602f72b9 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -369,8 +369,8 @@ struct MicroBlazeCPUClass {
 #ifndef CONFIG_USER_ONLY
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
-hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                        MemTxAttrs *attrs);
+bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result);
 #endif /* !CONFIG_USER_ONLY */
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                            MMUAccessType access_type,
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f81c4f625b..9c49c510dd 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -280,30 +280,33 @@ void mb_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
-                                        MemTxAttrs *attrs)
+bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
 
-    /* Caller doesn't initialize */
-    *attrs = (MemTxAttrs) {};
-    attrs->secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD);
+    result->attrs = (MemTxAttrs) {
+        .secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD),
+        .debug = 1,
+    };
+
+    result->lg_page_size = TARGET_PAGE_SIZE;
 
     if (mmu_idx != MMU_NOMMU_IDX) {
         hit = mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
-            paddr = lu.paddr + addr - lu.vaddr;
-        } else
-            paddr = 0; /* ???.  */
+            result->physaddr = lu.paddr + addr - lu.vaddr;
+        } else {
+            result->physaddr = 0; /* ???.  */
+        }
     } else {
-        paddr = addr;
+        result->physaddr = addr;
     }
 
-    return paddr;
+    return true;
 }
 
 bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.43.0


