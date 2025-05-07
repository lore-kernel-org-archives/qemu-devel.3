Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF267C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPb-000866-Er; Wed, 07 May 2025 19:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPZ-00082D-7G
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPV-0002Q2-Oy
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227d6b530d8so4592515ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661364; x=1747266164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wT6DnXqbX5AENDmRydoGeLBXcyCT3Vy8ui4SCalzaQ=;
 b=bjre1c7xOmlPpkgUZXk9pzbWghf6iuWCiCw5GqI3AsUaKgK5QUWg4HTsijEGTklMhu
 xGXY7KFAhKdBCNdFgtvaR9Ux9WTIXmVMt5duKN67z/jSEoY8Cac8KxMiv2beQdTUlx+8
 WRVlx13tLThwENLbWMXs+4ePuSdTq/dTCSThmdXgoHlurtM46ZX6/8ERD2NjP68Ztdhn
 yK44fOT3yhWl5emrTHuZFEvjuD6Y3G/7h47f9RubHTr6Jnd/RKUp9mUtrVNwQHP0jVu3
 Toj88elw8rKfo/xdiEuXFWSW9DRV4SmAfDJPWQTTeH3+j/SdtHRpSvzMqGM5ENWsbvUf
 dl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661364; x=1747266164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wT6DnXqbX5AENDmRydoGeLBXcyCT3Vy8ui4SCalzaQ=;
 b=Tvvra/GXE9Z/lyVZYrGA5g2C2cO5figBIpYpmcZYWTJKp5bNknOx/BFpxVcqINvBmL
 WPD90Hk6OqhOYha/AGt7l+pK+YU8nltNcSvRM6vR3JoUQSVm5A1dIQaYg7844NeX6oEK
 P3WiH8fIX+kF3iqzmbWTZW03Wn1fYhDR/GL77LnDnx+61I07RIVOf+rQ8B7wJNnOJO+k
 Y/avyVrlQGDZQPZT4N1sVyXbqyLZsDkUHRkVcySePkqeC75gnax+Q5Aa5tiHmdTLYonK
 F2qx8787TPaLodBGZsgtoQkEhpyRUm1+TxboCRy/fFeNNGrBvfDWAt98MSOt8ao1dDyv
 PVMA==
X-Gm-Message-State: AOJu0YyzoOiIF5t4PIWqYUTvn2F3CltHM8bgw6IH0wgJgBMoykEKr9xa
 PpnxWaHThSrmwhtUDndrTZN9gxvOFvxuJaEgG0OWDBL9F7czlefSjz1HqdUF33//t7qO4gJRvLA
 B0mLHdw==
X-Gm-Gg: ASbGncsboN5nyFvBzLS4eE2erQYCUNQnvGelqoNcGPTV9SYhGItAjW85LsCXppZhYy/
 Uvejjiy7TFgScRGMksehiB9ikWNPd6T6tvwh2xcdjjZxFTZcTkm0+VYSodph72NpX0LyKiPFxtS
 ou8Kkt8eMCujn1++p6zMvCmKaUNWB0ZqhXC3o95oehGv5+wz8yfdNh8gicK2kZZpenc7y4rJOS0
 MzwhjKzoDbHHP5V2U4QRxZIj+QfmHbZVjeGDGnWU0EXPt7I8WbqpLP7tK1VOlM4B2MObTNJv6lP
 QMJnaEb+MCKyD0T39lzfnV84EIhiqtTG/92U05Yg
X-Google-Smtp-Source: AGHT+IH9jmSZoEfyBfxc66HFb7NLtse6xLVjOyrIpvtO2+/5/1e3pQZm95IdBBwOL7DhDe1MFZOmAA==
X-Received: by 2002:a17:902:f606:b0:224:1af1:87f4 with SMTP id
 d9443c01a7336-22e5ea91381mr89954445ad.22.1746661364459; 
 Wed, 07 May 2025 16:42:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 01/49] target/arm: Replace target_ulong -> vaddr for
 HWBreakpoint
Date: Wed,  7 May 2025 16:41:52 -0700
Message-ID: <20250507234241.957746-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 660d3a88e07..5b421bc4ecd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1949,9 +1949,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, vaddr pc);
+int insert_hw_breakpoint(vaddr pc);
+int delete_hw_breakpoint(vaddr pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 0512d67f8cf..bb5969720ce 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(vaddr addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(vaddr pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, vaddr pc)
 {
     int i;
 
-- 
2.47.2


