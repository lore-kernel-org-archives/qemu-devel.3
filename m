Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4062C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOU-0006lK-VG; Tue, 06 May 2025 10:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOS-0006be-QR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOQ-000134-OI
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso36575745e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542132; x=1747146932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCeRqTx0mhaZ0q9s1EL1ORmnDCtjAuDqQ8i9YX1QOyg=;
 b=JSbXXGpKXX7ad0vkDkDhH6ntFZeewhCHgmQGZRDXzPdRLqYpHrEuSO/wt0qTSb4UPI
 SFx0w482S/OS+PQpSK6f7kwc8AHVDxBEL0rmXiAyY6t6ffSxTQk3VDi2AWS0b5ud0mQK
 NyVXwrQl0qC32glI7eZoE3QFxEeZDjzMy7IxBP8S4ddJxIBorhoISFW63jAxYmygVS5n
 gW3momNmcKi/Ncat8NSNiPIq+mquMonfmcbpfNDLklgBmhwhdkiXaayBFzPaDzcLH/+5
 kXEcbwvaGAB0UVG9lUDzocZxJWIhr2spnDfT6/UN4dPkRwadwGvJI3URG1H+xphTmEuP
 nxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542132; x=1747146932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCeRqTx0mhaZ0q9s1EL1ORmnDCtjAuDqQ8i9YX1QOyg=;
 b=mzK7Ig6+aWc5FGG9Jkh7BJa6A+478V2cJHLHJ0JPDuJa3I4d/IJGtxDDu72JCumIaV
 G8LHB8ghqS+BLUA1pf8WGb0M3IQE73hynPz/8MYiS4agrSm1lKIOcNRArfnNjuQNnch5
 nt402iGw0JmvgaWLH/Hx3tNb/WLHZXqYZTPeco9REt6xDQ6lFNnSaXtozx0ltK4DfZHS
 exOhyXbzZjlK1hoMLFy0aFtgrjS1FG9C0d2+Br+aPvz0aoknYNRwvo8T3yQJFHvqIZwu
 UEpix0K2xBFm5PNmSLPjLLGm7Z95qcuKye3Ysm63F3yNhFoFAdMBD6KJ/TG0xVO4NQG6
 k40g==
X-Gm-Message-State: AOJu0Yw8hpG8VnaDTr6pDuaWhFzrNNZMI+4HKgzU7LzEqpbzTCZWKTCx
 ROrMyMEGGlIoXSeqcP6FRYi49FiAcrnBaSo1VYm66IM04oAfneVBd895E40goyzm+emYybPqII/
 V
X-Gm-Gg: ASbGncuRChTgUJ+7T3SertJ5A2CRaODKw6pFSbxLeVtBasFmqsogL5zJMSvQA60PB4l
 Li8pKAbGFbQmNkG2a2KInbKCR6ZlEirOj2AzmvLd1fBZz8BgGt1t3EXrdtjtheI3gXqbsj2lhgF
 H4NlixAtM93c+8OCw0uN6rSxsBTnMgCp8FTw1LwU1rznnjsaI74OXBwoAKdkKRotxH1VtU7IMHc
 OZwySyui6Ji7DYGuTzjnM6Eha7Op6jxW9YYoYnZfZAncm+2+HWSdiNMG2h6pC0pAKJMvtHDYNIK
 CFx0etCE4ggy9r+Y6wbs7TGYGM+PPeKrHcQ2bI9PwhSL4V3ssBJpCrPZavVNNGWTWMSWCz7CZCH
 JmhpAU/ThBzsUyjNq7/44
X-Google-Smtp-Source: AGHT+IGyxPKdPvukJKTXf6ruUaT87ZzEzL6O8dLCqcTvoIwzktd9D4/V25yW65o62J9rxa/+7anu+A==
X-Received: by 2002:a05:600c:1e88:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-441c48bdf64mr94179155e9.13.1746542132340; 
 Tue, 06 May 2025 07:35:32 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7caasm14120803f8f.54.2025.05.06.07.35.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/22] target/migration: Inline VMSTATE_CPU()
Date: Tue,  6 May 2025 16:34:53 +0200
Message-ID: <20250506143512.4315-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

VMSTATE_CPU() is only used in 4 places and doesn't provide
much, directly inline it using VMSTATE_STRUCT().

This removes the last COMPILING_PER_TARGET in "hw/core/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250429085148.11876-1-philmd@linaro.org>
---
 include/hw/core/cpu.h       | 12 ------------
 target/alpha/machine.c      |  2 +-
 target/hppa/machine.c       |  2 +-
 target/microblaze/machine.c |  2 +-
 target/openrisc/machine.c   |  2 +-
 5 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 12b2ff1f7d2..1e87f7d393e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1121,20 +1121,8 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-#ifdef COMPILING_PER_TARGET
-
 extern const VMStateDescription vmstate_cpu_common;
 
-#define VMSTATE_CPU() {                                                     \
-    .name = "parent_obj",                                                   \
-    .size = sizeof(CPUState),                                               \
-    .vmsd = &vmstate_cpu_common,                                            \
-    .flags = VMS_STRUCT,                                                    \
-    .offset = 0,                                                            \
-}
-
-#endif /* COMPILING_PER_TARGET */
-
 #define UNASSIGNED_CPU_INDEX -1
 #define UNASSIGNED_CLUSTER_INDEX -1
 
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index f09834f635d..5f302b166da 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -74,7 +74,7 @@ static const VMStateDescription vmstate_env = {
 };
 
 static const VMStateField vmstate_cpu_fields[] = {
-    VMSTATE_CPU(),
+    VMSTATE_STRUCT(parent_obj, AlphaCPU, 0, vmstate_cpu_common, CPUState),
     VMSTATE_STRUCT(env, AlphaCPU, 1, vmstate_env, CPUAlphaState),
     VMSTATE_END_OF_LIST()
 };
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index bb47a2e689f..13e555151a6 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -216,7 +216,7 @@ static const VMStateDescription vmstate_env = {
 };
 
 static const VMStateField vmstate_cpu_fields[] = {
-    VMSTATE_CPU(),
+    VMSTATE_STRUCT(parent_obj, HPPACPU, 0, vmstate_cpu_common, CPUState),
     VMSTATE_STRUCT(env, HPPACPU, 1, vmstate_env, CPUHPPAState),
     VMSTATE_END_OF_LIST()
 };
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index 51705e4f5c9..a4cf38dc891 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -93,7 +93,7 @@ static const VMStateDescription vmstate_env = {
 };
 
 static const VMStateField vmstate_cpu_fields[] = {
-    VMSTATE_CPU(),
+    VMSTATE_STRUCT(parent_obj, MicroBlazeCPU, 0, vmstate_cpu_common, CPUState),
     VMSTATE_STRUCT(env, MicroBlazeCPU, 1, vmstate_env, CPUMBState),
     VMSTATE_END_OF_LIST()
 };
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 3574e571cb2..081c706d02c 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -136,7 +136,7 @@ const VMStateDescription vmstate_openrisc_cpu = {
     .minimum_version_id = 1,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_CPU(),
+        VMSTATE_STRUCT(parent_obj, OpenRISCCPU, 0, vmstate_cpu_common, CPUState),
         VMSTATE_STRUCT(env, OpenRISCCPU, 1, vmstate_env, CPUOpenRISCState),
         VMSTATE_END_OF_LIST()
     }
-- 
2.47.1


