Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F0DC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVi-0001sQ-Qf; Thu, 03 Apr 2025 20:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVK-0001ZI-PH
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVI-0003D7-TI
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:50 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so802387f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724907; x=1744329707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvplpfWyToxlMcaiW33GsKxUhgmpqpXgGdwTbAzyNHc=;
 b=CYu/BATgayAuDYYofooAUO/EDTXW70J8TG0onXheXvTsPv5lX8/mAnmXcoBeh1Whby
 cA+xLDrJI0O/HwAYAgdNwEiNobq7ihPkKJnDQnmD9W65xVPRwyVIE6vpZkn3W0ZvvlRL
 Ly+3sn2drS22gqlkb21Fk2Uv7bA0KXouy8smb3J/8JKyFCznv5D/EnIAmSdVYf86B72h
 du8r0KLNU/VtCWUkiX7Yj10mKpOvAF6Ju4amkH892JEk8kou0s7Sqj9iNVdkKiyiUAIR
 BeIDaCJUh23epr5FO0XKU8Xd2ozRkqZN+acWzABoFUnXaa1KNDVwtYdBz8wZckQ1ovs6
 cARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724907; x=1744329707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvplpfWyToxlMcaiW33GsKxUhgmpqpXgGdwTbAzyNHc=;
 b=WpTtX5vhcSt9MADYiH4nOrc7P/ES+oN/TWQtN6UcsMvBl1LlgpdmQYre9MqtLuPuPH
 /drtrMX6xHB0laM2J3ZbQtqG02EJ0VLr7S4nTfbrbrDkx8kIbJAm+IqqqiVxf9blFij/
 m0Pp5Sv1o9FH6PWCZKxKNEl6zY20go8MHbxhrve48fwvq8XmJFOMHeG3/pw8t0mUSlAh
 Nur81AQSrsWqE64eEYAB5yQKmCbKIkjm4sH5Ng0RlPwCFEXpFMUJQBeSUraPdG0JQaZB
 aw/URhqWz9FvvJ+vxi4ZDj5vq/BElpIF1s8g47XcRvNn8qPgLynUhB1jVwYQN2IrF/Xy
 b+Mg==
X-Gm-Message-State: AOJu0Yw32Oc5z8T1mjfAurpqarWwIvyqco24R9aU1IbT/rxP2AIWe6jd
 fMRJa1QK2JRE/8zFTYJTsavwAbcxnuEKieFS+cIAXgSFGGTE7PIQwO1n0bfwxZVCmoLE/fR+map
 M
X-Gm-Gg: ASbGncvcjQzt0dBQHFxEJcCIOgesQyLpHhtZOqBI1h58IyhdYvEct65rrwwmHt5wBx+
 /agi6AC0yfHAOs6r4BfvLjLapWHrB4/+JFCusrmxE2hLVXInBZGENkyR81CBSEdrR2kHm+rv/y5
 zIpHeZTuSJbgDNrfI0hGY+5bkq8zPtZZDnCDhNzjCu67U/XXfv3t79+CzIaZO1bySL20pGttt+5
 VFRDjLh3VAT1JwsLEtX2n78seg5vzB+ZrySaR/Jk2oMcorYSQHsLVelsKoWKKZybf8BaKyCyS3l
 FAdkXAHZHTKhjB6MbJUad5uvlJr9WBt0K3JoTeh5/m93y1/33uPkd6IASq24vrKO3H/LUVbrlvb
 DFRy+Z68yzwdNO+KVvgjBpCse+UBrEA==
X-Google-Smtp-Source: AGHT+IHxrTYTWXVGBPfsHgtuKoCUsimt7uVv3YSmHOTE/x0r5cix+QUcvXoaVXQSGR4TWzyzMq1gOg==
X-Received: by 2002:a5d:5f94:0:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-39d0de61c04mr466263f8f.46.1743724907054; 
 Thu, 03 Apr 2025 17:01:47 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020da22sm3029543f8f.68.2025.04.03.17.01.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 31/39] target/arm: Replace target_ulong ->
 uint64_t for HWBreakpoint
Date: Fri,  4 Apr 2025 01:58:13 +0200
Message-ID: <20250403235821.9909-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

CPUARMState::pc is of type uint64_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d6ac00be0f2..ce60aee41d8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1944,9 +1944,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
+int insert_hw_breakpoint(uint64_t pc);
+int delete_hw_breakpoint(uint64_t pc);
 
 bool check_watchpoint_in_range(int i, target_ulong addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 1e861263b3d..4e52d37ed80 100644
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
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
 {
     int i;
 
-- 
2.47.1


