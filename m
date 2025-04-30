Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E429C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tq-0002FE-5P; Wed, 30 Apr 2025 10:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tk-00028d-Eb
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:56 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8th-0002dw-7E
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:56 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b074d908e56so5553657a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025131; x=1746629931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=ciQuEBJ6+6NTDvjgFSTEZN3Z1ln5rQbVjIYvK4p1XlaovYWnFb8be8gfb5SOEcuzUa
 r5pL1wv+01Xno0uw0dkYT4e8eZ6sN3vtnY/O/J1IUmhEzOwPdWDbVS/aaDEsWzUQKF8J
 ubsFyciTowsok282U9IX4LBedvzGf0dNGrKYgftIDcfr74XrwvUgALxkwu+9TQZopwDb
 lGERrbKNU3zvFE/UYAh8wV+jfP5E9NmbJc3VAiJlb/fxUMm/iYSf8PysCZF9lU+mVnEO
 DrGTI/4kMs8xRO5BMNW0hebr0RuV7OlCUcBkLtBf0BhpQZ4+TOReaj3kN1IIEs8uokLF
 AN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025131; x=1746629931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=n6vj66luwqiAg5xBbQtT3dTAhBsZT3klfSbNWngsxIuf3qNVbokp74ui54vqhGFWBr
 J+sBpp3l6Y3hNeQUhXVl7eyQW+qwWp76w1mrdoGo6Ptr3ZUfX7KicYa8Ve5W4oZ2AHKE
 V41kq+9R3xitSv6gZ6PcL35vP7PU3iYf3Za7DH3m/DQT7OvudN22tjBcU/UuEdVPIR3L
 zrGgaXb4ZqG1BdwSCLZBEHRBCkWSWLonaxeecu8GKbf7sjFj/y0jjAATdA6Lvu8vHgDp
 btV+lGyutrq5Jqu89+HQ4RKC6nh9Rq4V+DmmD3uejylFMBwh14h84r0V5ZhchB96KNLs
 svzA==
X-Gm-Message-State: AOJu0Ywx8Q3dUa7j+d4WXzh/7SWMbbLGtLxdwYY9mVeYbmdXaZbFJgOT
 AeXPg3p4swhZXnyihbFd3OKdnz8qETPMpImlbSCLksFUHFkVhdwtMrZuF5rhFwpOZ5EsJ9U/f9v
 B
X-Gm-Gg: ASbGncvLGaW4rNFhpURKP+TjjJtYX2XrnIpjCDGzmopJQ1wj1ITpCIoWMYhnpielXt/
 84aX9sIspkwxuGnuThJ7oJIOpe3M0uz9ap5yaKtSQs/hiG475FsfkwpPWC75YrqXEZBRDHaMud7
 38JuSHEtjInYSD9geqaGfJgdKAoAsSmtNW0wHT6c9k3Zln44jCvHworPmLWy1ea/qtzcpsSoNwy
 qghkQ5hiF0X3eRh5FeODukDw+YTCDLcIjkFspgoA7nUuPRxrYziOdhSyM7jRaamuhrOVoaCjOKR
 h/R5vQYWZM2RU8fspqZgcBBxrHwSf9wlhJbLhgaL
X-Google-Smtp-Source: AGHT+IFi3zhIVBlI4fvnZXF3ndodFDug/+ZjzkjEgZ4p9GMyQhZU6U0C5qlme+C9qszLASfwf7Vv4g==
X-Received: by 2002:a17:90b:3504:b0:301:cba1:7ada with SMTP id
 98e67ed59e1d1-30a343ce72cmr3932692a91.1.1746025131606; 
 Wed, 30 Apr 2025 07:58:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 01/12] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Date: Wed, 30 Apr 2025 07:58:26 -0700
Message-ID: <20250430145838.1790471-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

CPUARMState::pc is of type uint64_t.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d3d84ffebd..c30689c9fcd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1949,9 +1949,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
+int insert_hw_breakpoint(uint64_t pc);
+int delete_hw_breakpoint(uint64_t pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 0512d67f8cf..4d8fd933868 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(uint64_t addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(uint64_t pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
 {
     int i;
 
-- 
2.47.2


