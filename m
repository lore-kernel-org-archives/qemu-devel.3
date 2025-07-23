Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C09DC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZxo-0004ow-OB; Wed, 23 Jul 2025 09:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZtI-0002tU-RO
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZtF-0002pk-8l
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so75462295e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753278729; x=1753883529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcdlEr/J4j1S/5PvsG83gT109zbXCmA4422HgOxRd8M=;
 b=L0hQfltyUPbaUQUxvVtj7fFJPShEYvoMYx85+5DOoB1CN/GhdQ6tsjCKOYLVxKrVrY
 +vMdVQ4VNX/ViBPlo6yyDqD1WHaUNELDnAy1qjefhPBW7QLk39tdVM8pwC1C4imOySCs
 gQTSnk+DFuwd/QQ5MvMqwkWM3PwflAEqo2SgYRAPZVfzU8MlApMJF3wyU6F0U6VbzZZq
 h0AR4fULBfebO7vTJI+m5J7buVgod6/T69qderlzMwSQXn/EOlzcyZo8TSiFc3LEWPPT
 ioc0pw3vb83ndGoUBdGDtf/aFKNihVF4VP7LgMLi9Ffj7Y1LtjVBRIQQZ0TLgL+Xkb1F
 iaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278729; x=1753883529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcdlEr/J4j1S/5PvsG83gT109zbXCmA4422HgOxRd8M=;
 b=pH79AyH8EM58JuMUgw81Pk8DHY5mt2PGpCKHCIe0SenzCoAQA57Jx3NvMTdc/uS0iR
 rshFKKz7zSwJaKR0T3w7IKXwvYqKv2b3iOkLI96VZkCg8dzuWyHvq/cDl7f861oM3mMO
 OxnBcnZuTN36KQ9EEYNK3+CYfJOlPWtL3MuRPEVTOE78RXEoc6rDI75R0h/USK4FyGbY
 S8eVDPAfzR0dl2nuDPdfSNR7vfKGBRlvHA0+v1HKiCZQaRSghTEdRVCtLqiwTPqPHF32
 DZvg0sRsZ5uncUqOlE4Ed39VsU/uOvZgnnm9vE5SSETDC8LaFg/HnxQEOj4u1eokcAha
 Fy/A==
X-Gm-Message-State: AOJu0YzrfjP0jw7dHmtxXTcEB4NRW+1EqKy/u4rAbUE5GHGdHcjakMGN
 R+CGCz6tjoiOd+P4pUgPt+68M39SAqaPM9BmWBAQNU8sw3Hcqh4nnLMYsRoyjiWI6ogmAcFGwFo
 VcVEl
X-Gm-Gg: ASbGncvr1LwtMa3lBLgq77wBxraPSoHc6s6s2r3353Ue2lTRYqjqbL+RHAjkEnkxHT8
 jN3QzFJ6P/5Ss45br+lrNcwVSJ+W1/lG0x+MiybKkkGGcwncokNH5dXL8FepikFZbQ5izlvZeIi
 UTBqJsRx1Q2rp/SH0E8j+zDB0DcKMP5oTMTQzpCN6bTIQYdYfqKl7zkD3cOCGtwfX0X7e9huhif
 LXcjF5rPkG+VCcXmfUMST3txM9Ozhg0frEtrSVmyAkY2HOW9nK709wu9nHrL4Jrbhr4eyo7SWO4
 lE53IUebTlad8UiFZTY1yO2fJaPErUIFteJpZhu40ovnO/A6QOhjVUiaWvmUs5ZZZ1RGEGeLBP0
 MSagY2QQ+Ac2hAjKeIgLQ63WFn3WYl2CV/yL/2sb8zajwSqcUveI25gkFFKUMrjhSQ2UE0oR2
X-Google-Smtp-Source: AGHT+IGheCM8Hka0VAsDAn6qT6VCvHDh3/IFzV/hzpOM2LiYrILg94ruuTESUGTmXs8udTraYmIemw==
X-Received: by 2002:a05:600c:35ca:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-45868d4f48bmr29607095e9.30.1753278728828; 
 Wed, 23 Jul 2025 06:52:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458648f5ed9sm35552075e9.2.2025.07.23.06.52.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Jul 2025 06:52:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 2/4] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Wed, 23 Jul 2025 15:51:54 +0200
Message-ID: <20250723135156.85426-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723135156.85426-1-philmd@linaro.org>
References: <20250723135156.85426-1-philmd@linaro.org>
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

Implement HVF AccelOpsClass::cpu_target_realize() hook as
empty stubs. Target implementations will come separately.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hvf_int.h  | 2 ++
 accel/hvf/hvf-accel-ops.c | 2 ++
 target/arm/hvf/hvf.c      | 5 +++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 14 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a3b06a3e75b..cbd59525e87 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -111,4 +111,6 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d488d6afbac..6c9369388b8 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -373,6 +373,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_target_realize = hvf_arch_cpu_realize;
+
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bd6b5d11de8..7de770da4f3 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1081,6 +1081,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     cpus_kick_thread(cpu);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 818b50419f4..a24786c8c35 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -367,6 +367,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.49.0


