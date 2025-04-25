Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADA1C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1U-0004A8-RL; Fri, 25 Apr 2025 11:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0x-0001nG-4B
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0v-0003zp-8s
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso17107585e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595051; x=1746199851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Mae8D06ltiqtMkNSlccU/d3B53+20vWvaXUnEGJrLs=;
 b=tHpT9TPHr//OSWzWUm1sNJ5gsGZpccEnX/4Fmtv48YJeBI8nJljxOOT+j6+V1WynFB
 g4cdm+5cpus+lzpz6dDZ6D51p0sqbGOj4ip5PdnILW+qr1wTT0n6m5QBq36bbIwhuQJ/
 NPUVlbVGv+7BY2YYFPCUzfGbVI66w1plYJNe1DoxKfGQXnt06qZ0g+qReaKKzjkwOlEr
 h0+BazdPsWLxQozhquudUIO+CV6ymyU6+70VKgeKDV1K6dnN3tRLT5reSxOHpAyJWyBA
 DobcAgv0LN0oyaxtC9dfmAPR7AyYyyRqBjSkKpXuGasWgbOOmChX5N+h6cWDlaQVcYvw
 peKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595051; x=1746199851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Mae8D06ltiqtMkNSlccU/d3B53+20vWvaXUnEGJrLs=;
 b=dCaDTyRhLUq0VL9XECrjzz8Z0sfKdkwdYcT2naoGWQX2r4a81gItbvBQCsSYcNH3ZA
 r87Fm1aGF8ES1BTNrT6yAKV8mX6tvhPn5b/NQbFxwAMwq8vF7lxy8Rkwei2GNVFEXbLC
 FGkEfqKWUuTUdkBtyL5AqOXngm8Thx8nEugCO5wbAYSgn2nE5Kqq116F+yaXWE3O4K20
 wXjFsSV61PXa4KqCl3OjuVX06HBS7nlCEQQMh1qD1XEcoWEx0WT0TUuXAYPdpV7wg1ZN
 7gozaLNcJYt1b+Pb0MPi8rid4l+fonAQ4GihBQ1CmBI/vSgRIy4OYzOpyJ/yRAcsCTz3
 dTEg==
X-Gm-Message-State: AOJu0YxQrWpXsdmsDcSgGFWXrBk+hYdFrcaQcrFJrmiv2mdxSnIIvOgV
 9905F1jkeRYebV+Pks20mG3FOPnCJYoVwplopzQ7VxEDzazd6v0mlARLACC/0e3sXbtkBZrZS1A
 n
X-Gm-Gg: ASbGncvQy9xpmfWKF3au9rIanGiRJd/vB2zwTr574HRkOs4hUYnz0w/GJ+qjJMRGMCe
 PCSAl5HcpGt2vMe+CWZgit7F2xFFG14oMvEMWCptBNJKWeMZd/6uQZ0YTMNOoo1nMBSgBnJmyp8
 p9LzyZ4uluZVslSV1IyeMau4rA2rb0QN5bJ+rCgf4LXnjbvTlB3XH2unXGdGmC/a2gb70vQo8KI
 lso/hkyKplZY/JSm26sNUP5oTA7fjv8tcwrgCSO3OlGWm5PeAtgr25vaFFqKJm0Eap9u6/jAbRi
 B01wRNOrEfoM1KVkfc2PxvRwAQDITujafjVdmBBAz9Dpa7X704sTnn/oCnOnruEB7jcNdQR3dFB
 dpWZz/ciLIkUdcyw=
X-Google-Smtp-Source: AGHT+IF3tdTjwU1wYqrKeUI5QB+jDaDcgfLzSHYBdpNrBaByU1/jVvWkFJoth3q+adOzS0gDOphKCg==
X-Received: by 2002:a05:600c:c17:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-440a65d8d46mr29707605e9.14.1745595049801; 
 Fri, 25 Apr 2025 08:30:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cab5sm2717318f8f.10.2025.04.25.08.30.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/58] target/arm: Replace target_ulong -> vaddr for
 CPUWatchpoint
Date: Fri, 25 Apr 2025 17:28:09 +0200
Message-ID: <20250425152843.69638-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

CPUWatchpoint::vaddr/len are of type vaddr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250415172246.79470-4-philmd@linaro.org>
---
 target/arm/internals.h   | 9 +++++----
 target/arm/hyp_gdbstub.c | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0818de530b2..4d3d84ffebd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -26,6 +26,7 @@
 #define TARGET_ARM_INTERNALS_H
 
 #include "exec/hwaddr.h"
+#include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -1952,10 +1953,10 @@ bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
 int insert_hw_breakpoint(target_ulong pc);
 int delete_hw_breakpoint(target_ulong pc);
 
-bool check_watchpoint_in_range(int i, target_ulong addr);
-CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr);
-int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type);
-int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type);
+bool check_watchpoint_in_range(int i, vaddr addr);
+CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
+int insert_hw_watchpoint(vaddr addr, vaddr len, int type);
+int delete_hw_watchpoint(vaddr addr, vaddr len, int type);
 
 /* Return the current value of the system counter in ticks */
 uint64_t gt_get_countervalue(CPUARMState *env);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 1e861263b3d..0512d67f8cf 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -125,7 +125,7 @@ int delete_hw_breakpoint(target_ulong pc)
  * need to ensure you mask the address as required and set BAS=0xff
  */
 
-int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type)
+int insert_hw_watchpoint(vaddr addr, vaddr len, int type)
 {
     HWWatchpoint wp = {
         .wcr = R_DBGWCR_E_MASK, /* E=1, enable */
@@ -182,7 +182,7 @@ int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type)
     return 0;
 }
 
-bool check_watchpoint_in_range(int i, target_ulong addr)
+bool check_watchpoint_in_range(int i, vaddr addr)
 {
     HWWatchpoint *wp = get_hw_wp(i);
     uint64_t addr_top, addr_bottom = wp->wvr;
@@ -214,7 +214,7 @@ bool check_watchpoint_in_range(int i, target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type)
+int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
 {
     int i;
     for (i = 0; i < cur_hw_wps; i++) {
@@ -239,7 +239,7 @@ bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
     return false;
 }
 
-CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
+CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr)
 {
     int i;
 
-- 
2.47.1


