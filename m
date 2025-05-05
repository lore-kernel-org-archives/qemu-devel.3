Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19412C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC56q-00066a-Oj; Mon, 05 May 2025 19:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56p-00065c-CB
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:27 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56m-0003UJ-3J
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:26 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30572effb26so4748754a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487221; x=1747092021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hghY4IeLObm8ysFk0eCwCGh3lWvsG0krLPTha8KLWmo=;
 b=rcLZZj5QQpQ2WhE+KRMRGRy2BXwycSo8/7oEg0/X2KvDLQLC4H+nOvd7MlkdRXhtVt
 SBF7/FRCUljBbLrnLGcvaHv/kAqzcmu8OKWw1OnroypqMmMGd5hF78NS6cRgeg71AVtM
 cd8tC7A0MWALKCHoHRG9JAXQw4qVkk3hEURBIog5zh5UQDiPxkon1NlD5Ypnt5VsStLy
 El4mmdqc/zuuzL1vzO6Uy1++s3hUwQdWJ61Z9XGI3FHM1P23rEYt9jRmhSoCW482oMz/
 VX7QoGM71DHY5f1SJi46UaBgT8Qcl7mGSZTZsSDWFJXJvGiipp6tj5okWHnJcujcuctG
 s1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487221; x=1747092021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hghY4IeLObm8ysFk0eCwCGh3lWvsG0krLPTha8KLWmo=;
 b=mX+cI2BiYonTHlnN9Q9i8Rkfn0Ii5lmwTmp0wohdGFnj+mP+7A6e5mWfN3VEdBhDAV
 iqoLx7g1PSI5G7ORTh5rWUUo3hpyB8fQNi182xDbVom4hnFzht27JrqYCYbNOuQluSOE
 HcMRfUIHTBFgzDEBhnZDoUYP6BEmRKYDXQLqfnHCkw3Wx3zEb2wCxHvVlamVCTCp50uf
 /ykYyh5dXA36AHq+nq17wHLGTYK4bBmqcu4pAAm5yEpmNRreSq3Xnpn4n9sRxM1iRcCA
 gGgIita9xqE21aaNNUitwF8RVrYvT5WZiBQix5g7H14vazgGAVmvysWv6Y85OzAfIuWM
 M/hQ==
X-Gm-Message-State: AOJu0Yy2l+8oDCvKC0kOg74W1i+hlq+qi3JntmOLvhBQxWtakmQ/Ufwl
 6glqhmw08mPWvyFF7rSfXuUnypBkSfLtZqkzPPMp2UALo1FAEVzKnZCGbmcEEcD+epRALxe47bF
 BcoQ=
X-Gm-Gg: ASbGncu1yNlYhZkh8vgJW4oPsA04St38/eCKB75BMCVv9pWSXJKu/dkjYEu1k4ivhjC
 YJkuPUegcU/poRDLsJhcce7hp/CcbhGpC4F/sRyh8GxuWm0Xg1PSBS5eAQ5JycFYohiu5l9GUc9
 jFo7phtRt1QrBfJNIIU4hg9mzw6ikzs4lXlXzvoIYam96BvWGeKmL4AlkEMq3EKgbCuCtFlT3pU
 cjIMG6sz9KeKSMiu86lo2rLLa5IBZlY3c62JY8cUmQD85l7Vf/M3bHgoO+NgL/1Yj1PRR80DQhR
 t4mOYAchmSD+rO/WCNzFsmtF4Wm6o9myPkClGI4D
X-Google-Smtp-Source: AGHT+IGyW/h0d+P++2N9HLg6A6FxaGbouVs5I8Cg2OUIrJYht0qMsNp9z55lD9B0AK5WzHNucV8FRQ==
X-Received: by 2002:a17:90b:5824:b0:309:eb44:2a58 with SMTP id
 98e67ed59e1d1-30a4e623cb7mr18849133a91.22.1746487221594; 
 Mon, 05 May 2025 16:20:21 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 01/50] target/arm: Replace target_ulong -> vaddr for
 HWBreakpoint
Date: Mon,  5 May 2025 16:19:26 -0700
Message-ID: <20250505232015.130990-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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
index 4d3d84ffebd..79a7449041c 100644
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


