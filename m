Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CEBC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4k03-0000DO-7C; Tue, 15 Apr 2025 13:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4k01-0000Cd-Gr
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:23:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4jzz-0006vs-NO
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:23:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso42056705e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744737782; x=1745342582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeByU0jwFO7MH0hprr6LSgGx+kuJBq/jNjVmMX1KbGo=;
 b=LQW3pQ8gCiu/uJhNAoYXzSwFLB+9K+k1XV9UrhVjS3DrP0aPzj5wiQEAu+qmHClTlg
 mn5x8bX4Fib+Yj1RhY7636Cb/PdQIyQQHRUSuNFr0CpU6PuljMU/+kZrSuDJLd1SeG4S
 MM2Ab4A1Xm/A6ZIrwMI4BPZGvXVuDbXjiIBUu77ZeR05PTXvRyIwYNoejxxf0QiRZJvl
 sCVHX037ALe+c871YmCx6i2lh99Rfm+XHHWiLOoLPe533ZS05ae88enGmNzdp9kcYy/m
 7NEZHGVaVicP8yvWK91DuleBHlpMh4aFJl3m2BBU3LyjQVXL0+ekfubMlzrnMdgCeGSl
 /CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744737782; x=1745342582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeByU0jwFO7MH0hprr6LSgGx+kuJBq/jNjVmMX1KbGo=;
 b=L1Xc0otffBsM7dNTWse8pFEeYJF2+RO7Va+tsJOrj1bxfwxmHjl4lOodAhPVPlDhsl
 qkecc8dBg18SkupPlnOGcoBurm2o2JQDTINJ5WmKkto+O0wptRhdqM6leTJ8xGeaLwau
 Ivq9bZqVRrcJtkN8W29/X29Zl4U+ox5pE/xUaxaJIAjpyL3Xa1ZkFr78TiF1gybQ44tv
 N2bkiACzjHC3tDM/QPaUPt6L05wgCrBHF7ONI48VlL0ykO4Ge4tC/jAugQQbX29WtzEf
 c8kOXnUAgilel4C1JYsDA1vKo+LjM4SMLXj5fB+XHHRtrUJHPWGSP5AH7d83ZvTRAf7b
 z/rw==
X-Gm-Message-State: AOJu0Yyl4Lcuow3/qrga72BF2Qv4BcQLMKQxwq99uqbPYJWgyb8JjPD/
 l2jkvup6RaAnIghuMGJxWjM3HaTpE+gL2tWn0e9ruPsQeHqKg5lZJ7MO3NxbS0Kx8j+eAbp6v/c
 i
X-Gm-Gg: ASbGncv0uRrfyQIukp2TRfUVKu4JXZbMvp8f4rUdVIW2ZW39NR+wVuaAEcNdMz6PhAY
 +S1Mn2QvRw9XIS3793IbonFbd5JQd2r4PN5macAOGTn7J5hqYFpAWBZg0IcMt6GXBdOjuGy489P
 YYNQaqQa+LUfF6+3PIBndMuGzcf3kzc0ArzYFFsBNmZ1qCwxwlH9r/eiTjCtSTZGcT92H+xmTKG
 HXmVuiGpvvZJV46nu7uK5yXnTlV6/EkUTccsxkZTa44TzExjB2nfIEGj7Egf3ZS1J3LeXm/FAKx
 tj+z/UJVgMrRRmdmH1Hq9I/4QyznNPyIGW9gwsl5v1B8LkqCAUbbDn/smFXogxd7jldvwVn5RzR
 0CbvASwho4w31JS9rI+t9
X-Google-Smtp-Source: AGHT+IGO9OI6cKEACIXOk1Fm1kYRKEzmVHjbsFFdLphNtTssejs5mnc8tSlwyzl3bI42wesr955Egw==
X-Received: by 2002:a05:600c:500e:b0:43d:7588:667b with SMTP id
 5b1f17b1804b1-43f3a93ca20mr185678855e9.10.1744737781985; 
 Tue, 15 Apr 2025 10:23:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a2f71sm214675675e9.15.2025.04.15.10.23.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Apr 2025 10:23:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 3/3] target/arm: Replace target_ulong -> vaddr for
 CPUWatchpoint
Date: Tue, 15 Apr 2025 19:22:46 +0200
Message-ID: <20250415172246.79470-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415172246.79470-1-philmd@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
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

CPUWatchpoint::vaddr/len are of type vaddr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   | 9 +++++----
 target/arm/hyp_gdbstub.c | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 05ceb9bcf5d..a19c805af45 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -26,6 +26,7 @@
 #define TARGET_ARM_INTERNALS_H
 
 #include "exec/hwaddr.h"
+#include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -1946,10 +1947,10 @@ bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
 int insert_hw_breakpoint(uint64_t pc);
 int delete_hw_breakpoint(uint64_t pc);
 
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
index 4e52d37ed80..4d8fd933868 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -125,7 +125,7 @@ int delete_hw_breakpoint(uint64_t pc)
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
@@ -239,7 +239,7 @@ bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
     return false;
 }
 
-CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
+CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr)
 {
     int i;
 
-- 
2.47.1


