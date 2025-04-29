Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62048C3ABAA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d5E-00080g-9F; Tue, 29 Apr 2025 01:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4w-0007X8-OR
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4t-0005yL-8U
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22da3b26532so48156015ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902817; x=1746507617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd9JoYIvLQe/drBoM2Bi9/5cgLzZGHsmbjtG6PaToKY=;
 b=ts3Mg5xy10CFwIodrwP2DTDjbMQqc2sM8FrsDg3IRbHw3kPxp6qhUOd9vBjiyHScRb
 Roji1b/mvbCtLt+F2qbDXNczZw6Oi4ATtEv0bfQU9yaNSXX/OPNQLrUwB24MR3ii9WS4
 40/p8LhSUe8hc5mtwh2JJpnuFkzMqSZ47s6exq3XAlr/ovEl/gtCS/BOihJ618x+pmev
 SB2EFxiOIe8a4fLGT/JR4QGIl6EzayCtiiO/H6ZfVQKYSOCiKkYagoy/4SdcDtPS+Enb
 p3PTaM6hdU0M+76U2idpAOLJ1UyR9lqC4vHUm6rNmgJXsSo2ExBqvC/rnWU/gpKfhTuz
 d3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902817; x=1746507617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qd9JoYIvLQe/drBoM2Bi9/5cgLzZGHsmbjtG6PaToKY=;
 b=bPQx2joYnmooUPi1nfoSE9fBU6YaD3A8tLMX+zn/MEUS1/Sw2yilbId1T0QxVC7t1l
 r1kIHE46LPuZbBsFZCewroPGhi1rPvCNizgfD5fEW5ZByspB2IrnVJbRGfQzsAJTq5RT
 rtad7XIPQmBvbl83O2x1823DNVUqMVgiyyxuOU0k8X6ZYHnUcvmW/xB7fCZVWLXXtADK
 zhzPZ1E5pRKI4PxXy0uBXTNCoVb91n9GQTDBAbTMzCnbARiHVpJRQeJz8jxFbzpyBq/F
 ewP9vqNO9IFODd+qM4fVJ1OdO22rzUPUkHQ2HCVM97GCGCIRKeYnSQpMygdy190V/FAT
 Il6w==
X-Gm-Message-State: AOJu0YzR7x5ovc2J9qOcRA5Hrpa7K/3KPu0LlNJ1c1s4NYMnkt+royBI
 qqQfpFLAM74sbQt4Qx0F2nJS/KrHEAZeVx5TiBk9a7qXbs963oVWUAAZZ/EDPgHGT8ljEh/xplm
 C
X-Gm-Gg: ASbGncvEql4cgED7Mqs9++ejsW/muWQw7NtOoUz+zn2Gk9b/MeDHqk3DtisN7Q6RBvH
 KHKr1YailT8tYqH+vEwyCUkzLBUdGHg16yo6mPvWxfnywYjcbG8rvor4CQM7Jy9Y3K3s0wv2tOA
 SnPyQrC93C9nBeSN4nlUY+umdRbKLKOobn0s5Fi2iKMDLcMMW92ZVDH9dYanYpj6aKcRoHjLjKv
 47MbZxO1jgG/3ZP2j/uTdYn3IH+RCsQ0U9L84nPm62GfvzzF4iWoI/ebNp7tN54wuPnhGydUJ4p
 svX9R+YsMQ0HTBARV0qNso0om21v87FFuUg0Q/qn
X-Google-Smtp-Source: AGHT+IEym+4DaHg2WVCA9P5QZCnFC4FKkvs0up3xAn46PptfaIMRSezZKhGFkfqVu0U7+N2+PKpNSQ==
X-Received: by 2002:a17:903:28d:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22de70276d4mr26404235ad.21.1745902817405; 
 Mon, 28 Apr 2025 22:00:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 01/13] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Date: Mon, 28 Apr 2025 21:59:58 -0700
Message-ID: <20250429050010.971128-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


