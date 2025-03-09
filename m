Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621B7C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqg-0007Pv-A0; Sun, 09 Mar 2025 13:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqH-0006wq-UJ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:39 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqG-0004vp-EG
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1810419f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542813; x=1742147613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CR9qHcPdMx1za2MutCx4NKVWEwgwRQ/k65jZmcbEmWI=;
 b=eV8Ae0rlDpAun0EPpM/DJ6KtikB2IfP08Uvf12VmXFmjQuxX+l6+gKScXecqtWK5Cr
 aV7WyYYJAKIyzu/qeeKg1n1rbUWhB5NldD29014J0XEtZQxeVHW+blbZku40RmP/A6Ud
 yPQ2dBSk8Ufl2L6bM4tIq3IHlHLCkxqiTxpOzUq5LFpXPa1EFieJy623lR+Trb7/Uzsq
 Z3jbyk5t/a2Wx1KpyDxQPT+MN3kSTIS30LkiSMTwMAj5UsJ/iZJKuNpf2tR0qTFUS0Uh
 Fx5lzuotGHKcFBncywR4LRcyb0FaMDs9VbxcBw+PGXIvLKp2MefBJ/LMWepe1cyGPF84
 aa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542813; x=1742147613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CR9qHcPdMx1za2MutCx4NKVWEwgwRQ/k65jZmcbEmWI=;
 b=ewqsJPofsZS96dPNY77J4u0cnquEjygXV/qZE5iXChMlhSNc+FxjNz0qst78d94Urg
 tYbPLQs1cxslEfOZ87rRb+nhsecJif1sr3e+yGDbgGQ00XWRBqvomU211/Tkjic7LH1h
 vPj5FM9OFwelRmo1bzPKQdvtOp+DBwmwnrcwe45JIxt8AsXKKrbKoMp5GvBdLKW0sMC+
 7RTFbSgMmvvqjd+ZUloxUQ+rw3UMRlOy7xkp7LZzuFtYGKuoyYBAkEjSydL3BqCbJhCw
 ErUiQJo+5iBelrEoDJX6eLQosqNDMJ2zNYnkE2dtSAsyBAXEypJScTkRzF1vWXDh9JT5
 4f7g==
X-Gm-Message-State: AOJu0Yy0UtzpVIC7TLSdvxb/F0JFkPap90zUIwPGtZ8AwW4fO4blVKld
 YZKp2UxIeEbFZ5aPgjAJ6WiGHatwhAYcrP6JnBqBUgEeOQjwf7CwZfaCmMwcIOplClXiAR7WhW1
 r+Kw=
X-Gm-Gg: ASbGncvh7iXDGo8L9gY+JXGaULsVZvXpVIMRIm9CM7ZSstuhp/X8QHNWbLNLJsil1XV
 WBxHoCSPUr8AwG+IfiwmNTJeNx8ivM3wC71CQWW3vNJXV3UtWP0d2Fcvm93qIlSLCHirSIX2KJT
 30wrZKZ2scLXpxT7yagktPltvAMfwiUbamL/paOYgQql6CIAresYGChAgbA8kE+3W9KxytZUtJ4
 gldme+Rg0iwO9eaGbDm+QkzFxBO11h5d2w3aK3xN5hZOCQ1VmaqVSN7KBaQsPjoHLimNHVVkc/Y
 lOBD+oZ1E3kimNkpEDDDW4O81e26p3XCrXGVk3vsVXN6o4jHYjROu6z/cLonKH8+wDsKBmQ/oqJ
 p+fr2z0M2DSrhn8Tjfqk=
X-Google-Smtp-Source: AGHT+IH2f+EX/rt4pFnmHBWq6sWTKZFfrwVOJ/0JNg6e3IbZpBAm/xM7owoDljZEb3LnPSvIaKy8tQ==
X-Received: by 2002:a5d:5987:0:b0:391:2bab:d2fd with SMTP id
 ffacd0b85a97d-39132da96c9mr6963404f8f.37.1741542812830; 
 Sun, 09 Mar 2025 10:53:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceaac390bsm53503015e9.35.2025.03.09.10.53.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/38] target/arm: Move has_work() from CPUClass to SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:47 +0100
Message-ID: <20250309175207.43828-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-6-philmd@linaro.org>
---
 target/arm/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d7e61d08bbb..01786ac7879 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -123,6 +123,7 @@ void arm_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 /*
  * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
  * IRQ without Superpriority. Moreover, if the GIC is configured so that
@@ -141,6 +142,7 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
          | CPU_INTERRUPT_EXITTB);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -2655,6 +2657,7 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
+    .has_work = arm_cpu_has_work,
     .get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
@@ -2705,7 +2708,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->has_work = arm_cpu_has_work;
     cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
-- 
2.47.1


